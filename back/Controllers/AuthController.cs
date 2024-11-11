using Microsoft.AspNetCore.Mvc;
using ATDapi.Responses;
using ATDapi.Models;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using ATDapi.Repositories;
using Microsoft.AspNetCore.Authorization;

[ApiController]
[Route("Auth")]
public class AuthController : ControllerBase
{
  private IConfiguration _configuration;
  private Repository repository = new Repository();

  public AuthController(IConfiguration configuration)
  {
    this._configuration = configuration;
  }

  [HttpPost("Login")]
  public async Task<IActionResult> Login(LogInModel model)
  {
    try
    {
      string query = model.CheckUser();
      UserLogedModel? result = await repository.GetOneByQuery<UserLogedModel>(query);
      if (result != null)
      {
        string userRol = result.Rol;
        JwtSecurityToken claims = GenerateAccessToken(model.Username, userRol);
        string token = new JwtSecurityTokenHandler().WriteToken(claims);
        return Ok(new{ error = false, token});
      }
      else
      {
        return Unauthorized(new {error = true, message = "El usuario y contraseña son incorrectos"} );
      }
    }
    catch (Exception ex)
    {
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