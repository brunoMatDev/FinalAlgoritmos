using Microsoft.AspNetCore.Mvc;
using ATDapi.Responses;
using ATDapi.AuthModels.Models;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using ATDapi.Repositories;
using Microsoft.AspNetCore.Authorization;
using ATDapi.Services;
using Dapper;

namespace ATDapi.Controllers;

[ApiController]
[Route("Auth")]
public class AuthController(IConfiguration configuration, RequestLogger requestLogger) : ControllerBase
{
  private readonly IConfiguration _configuration = configuration;
  RequestLogger _requestLogger = requestLogger;
  private readonly Repository repository = new();

  [HttpPost("Login")]
  public async Task<IActionResult> Login(LogInModel model)
  {
    string message;
    try
    {
      string query = model.CheckUser();
      UserLogedModel? result = await repository.GetOneByQuery<UserLogedModel>(query);
      if (result != null)
      {
        JwtSecurityToken claims = GenerateAccessToken(result.Id, result.Username, result.Rol);
        string token = new JwtSecurityTokenHandler().WriteToken(claims);
        message = string.Format("El usuario: {0}, id: {1}, inicio sesion exitosamente", result.Username, result.Id);
        await _requestLogger.SaveLog(HttpContext, 200, message);
        return Ok(new{ error = false, token});
      }
      else
      {
        message = string.Format("Se intento iniciar sesion con el username: {0}", model.Username);
        await _requestLogger.SaveLog(HttpContext, 401, message);
        return Unauthorized(new {error = true, message = "El usuario y contraseña son incorrectos"} );
      }
    }
    catch (Exception ex)
    {
      await _requestLogger.SaveLog(HttpContext, 500, ex.Message);
      return StatusCode(500, new {error = true, message = "Ha ocurrido un error al momento de realizar la peticion, por favor contacte con el administrador"} );
    }
  }

  [HttpPost("register")]
  public async Task<IActionResult> Register(RegisterModel model)
  {
    string message;
    try
    {
      DynamicParameters parameters = new();
      parameters.Add("@username", model.Username);
      parameters.Add("@password", model.Password);
      parameters.Add("@name", model.Name);
      parameters.Add("@last_name", model.LastName);
      int rowsAffected = await repository.InsertByProcedure("register_new_user", parameters);
      if (rowsAffected > 0)
      {
        message = string.Format("Se registro el usuario: {0} exitosamente", model.Username);
        await _requestLogger.SaveLog(HttpContext, 200, message);
        return Ok(new{ error = false, message });
      }
      else
      {
        message = string.Format("No se pudo registrar el usuario: {0}, podria ya estar en uso", model.Username);
        await _requestLogger.SaveLog(HttpContext, 401, message);
        return Unauthorized(new {error = true, message } );
      }
    }
    catch (Exception ex)
    {
      await _requestLogger.SaveLog(HttpContext, 500, ex.Message);
      return StatusCode(500, new {error = true, message = "Ha ocurrido un error al intentar registrarse, por favor contacte con el administrador"} );
    }
  }

  private JwtSecurityToken GenerateAccessToken(int id, string userName, string rol)
  {
    var claims = new List<Claim>
        {
            new("id", id.ToString()),
            new("username", userName),
            new("rol", rol)
        };

    var token = new JwtSecurityToken(
        issuer: _configuration["JwtSettings:Issuer"],
        audience: _configuration["JwtSettings:Audience"],
        claims: claims,
        expires: DateTime.UtcNow.AddMinutes(30),
        signingCredentials: new SigningCredentials(new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JwtSettings:SecretKey"])), SecurityAlgorithms.HmacSha256)
    );

    return token;
  }
}