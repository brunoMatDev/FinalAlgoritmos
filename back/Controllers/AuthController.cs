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
[Route("/Auth/")]
public class AuthController : ControllerBase
{
    private IConfiguration _configuration;
    private Repository repository = new Repository();

    public AuthController(IConfiguration configuration)
    {
        this._configuration = configuration;
    }

    [HttpPost("Login")]
    public async Task<BaseResponse> Login([FromBody] LoginModel model)
    {
        try
        {
            string query = model.CheckUser();
            LoginModel result = await repository.GetByQuery<LoginModel>(query);
            if (result != null)
                {
                    var userRol = result.rol;
                    var token = GenerateAccessToken(model.Username,userRol);
                    return new DataResponse<string>(true, 200, "Lista de usuarios", new JwtSecurityTokenHandler().WriteToken(token));
                }
                else
                {
                    return new BaseResponse(false, 204, "No hay usuarios cargados!");
                }
        }
        catch (Exception ex)
        {
            return new BaseResponse(false, 500, ex.Message);
        }
    }

    [HttpGet("listar")]
    [Authorize]
    public async Task<BaseResponse> listar()
    {
        try
        {
            var rol = HttpContext.User.Claims.ElementAtOrDefault(1).Value;

            if (rol != "administrator")
            {
                return new BaseResponse(false, 401, "No tienes permisos para acceder");
            }
            else
            {
                string query = "SELECT u.username AS Username, u.password AS Password, r.roles AS rol FROM users AS u INNER JOIN roles AS r ON u.rol = r.id ORDER BY u.username ASC;";
                var result = await repository.GetListBy<LoginModel>(query);

                if (result != null)
                {
                    return new DataResponse<List<LoginModel>>(true, 200, "Lista de usuarios", result);
                }
                else
                {
                    return new BaseResponse(false, 204, "No hay usuarios cargados!");
                }

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