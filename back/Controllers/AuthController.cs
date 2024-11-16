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
using System.Net;

[ApiController]
[Route("Auth")]
public class AuthController : ControllerBase
{
  private IConfiguration _configuration;
  RequestLogger _requestLogger;
  private Repository repository = new();

  public AuthController(IConfiguration configuration, RequestLogger requestLogger)
  {
    _configuration = configuration;
    _requestLogger = requestLogger;

  }

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
        string userRol = result.Rol;
        JwtSecurityToken claims = GenerateAccessToken(model.Username, userRol);
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

  [HttpGet("listar")]
  [Authorize]
  public async Task<BaseResponse> Listar()
  {
    try
    {
      string rol = HttpContext.User.Claims.ElementAtOrDefault(1).Value;

      if (rol != "administrator")
      {
        return new BaseResponse(false, 401, "No tienes permisos para acceder");
      }
      else
      {
        string query = UserLogedModel.ListUsers();
        List<UserLogedModel> result = await repository.GetListBy<UserLogedModel>(query);

        // if (result != null)
        // {
        //   return new DataResponse<List<LoginModel>>(true, 200, "Lista de usuarios", result);
        // }
        // else
        // {
          return new BaseResponse(false, 204, "No hay usuarios cargados!");
        // }

      }


    }
    catch (Exception ex)
    {
      return new BaseResponse(false, 500, $"error:{ex}");
    }

  }

  private JwtSecurityToken GenerateAccessToken(string userName, string rol)
  {
    var claims = new List<Claim>
        {
            new Claim("username", userName),
            new Claim("rol", rol)
        };

    var token = new JwtSecurityToken(
        issuer: _configuration["JwtSettings:Issuer"],
        audience: _configuration["JwtSettings:Audience"],
        claims: claims,
        expires: DateTime.UtcNow.AddMinutes(30), // Token expiration time
        signingCredentials: new SigningCredentials(new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JwtSettings:SecretKey"])), SecurityAlgorithms.HmacSha256)
    );

    return token;
  }
}