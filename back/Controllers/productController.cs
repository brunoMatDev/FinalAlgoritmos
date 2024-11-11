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
[Route("products")]
public class productController : ControllerBase
{
    private Repository repository = new Repository();

    [HttpGet("ListaProductos")]
    public async Task<BaseResponse> ListaProductos()
    {
        try
        {
            string query = "SELECT id, nombre, precio, image from productos;";
            List<productModel> result = await repository.GetListBy<productModel>(query);
            if (result != null)
                {
                    return new DataResponse<List<productModel>>(true, 200, "Lista de productos", result);
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
    
    [HttpPost("SelectById")]
    public async Task<BaseResponse> SelectByID(int ID){
        try{
            string query = $"SELECT id,nombre, precio from productos where id = '{ID}'";
            var result = await repository.GetOneByQuery<productModel>(query);
            if (result != null)
                {
                    return new DataResponse<productModel>(true, 200, "Producto encontrado", result);
                }
                else
                {
                    return new BaseResponse(false, 204, "No hay usuarios cargados!");
                }

        }catch(Exception ex){
            return new BaseResponse(false, 500, ex.Message);

        }
    }



    
}