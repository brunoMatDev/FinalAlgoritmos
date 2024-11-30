using Microsoft.AspNetCore.Mvc;
using ATDapi.Models;
using ATDapi.Repositories;
using Dapper;
using ATDapi.Services;
using Microsoft.AspNetCore.Authorization;

namespace ATDapi.Controllers;

[ApiController]
[Route("products")]
public class ProductController(RequestLogger requestLogger) : ControllerBase
{
  RequestLogger _requestLogger = requestLogger;
  private Repository repository = new();

  [HttpGet("ListProducts")]
  public async Task<IActionResult> ListProducts(int page)
  {
    try
    {
      DynamicParameters parameters = new();
      parameters.Add("@page", page);

      List<productModel> result = await repository.GetListByProcedure<productModel>("get_products", parameters);
      if (result != null)
      {
        return Ok(new { error = false, result });
      }
      else
      {
        return StatusCode(204, new { error = false });
      }
    }
    catch (Exception ex)
    {
      await _requestLogger.SaveLog(HttpContext, 500, ex.Message);
      return StatusCode(500, new { error = true, message = "Ha ocurrido un error al momento de realizar la peticion, por favor contacte con el administrador" });
    }
  }

  [HttpGet("searchbyname")]
  public async Task<IActionResult> SearchByName(int page, string search)
  {
    try
    {
      DynamicParameters parameters = new();
      parameters.Add("@page", page);
      parameters.Add("@product_name", search);
      List<productModel> result = await repository.GetListByProcedure<productModel>("search_product_by_name", parameters);
      if (result != null)
      {
        return Ok(new { error = false, result });
      }
      else
      {
        return StatusCode(204, new { error = false });
      }
    }
    catch (Exception ex)
    {
      await _requestLogger.SaveLog(HttpContext, 500, ex.Message);
      return StatusCode(500, new { error = true, message = "Ha ocurrido un error al momento de realizar la peticion, por favor contacte con el administrador" });
    }
  }

  [Authorize]
  [HttpGet("recovercart")]
  public async Task<IActionResult> RecoverCart()
  {
    string id_user = HttpContext.User.Claims.FirstOrDefault(item => item.Type == "id").Value;
    try
    {
      DynamicParameters parameters = new();
      parameters.Add("@id_user", id_user);
      List<ProductInCart> result = await repository.GetListByProcedure<ProductInCart>("recover_cart", parameters);
      if (result != null)
      {
        return Ok(new { error = false, message = "Se recupero el carrito correctamente", cartItems = result });
      }
      else
      {
        return StatusCode(204, new { error = true, message = "No se encontro el carrito" });
      }
    }
    catch (Exception ex)
    {
      return StatusCode(500, new { error = true, message = "No se pudo procesar la peticion en este momento" });
    }
  }

  [Authorize]
  [HttpPost("removefromcart")]
  public async Task<IActionResult> RemoveFromCart(ModifyItemAmountModel item)
  {
    string idUser = HttpContext.User.Claims.FirstOrDefault(item => item.Type == "id").Value;
    try
    {
      DynamicParameters parameters = new();
      parameters.Add("@id_user", idUser);
      parameters.Add("@id_item", item.IdItem);
      List<ProductInCart> result = await repository.GetListByProcedure<ProductInCart>("remove_from_cart", parameters);
      if (result != null)
      {
        return Ok(new { error = false, message = "El articulo se modifico correctamente", cartItems = result });
      }
      else
      {
        return StatusCode(204, new { error = true, message = "No se encontro el articulo" });
      }
    }
    catch (Exception ex)
    {
      return StatusCode(500, new { error = true, message = "No se pudo procesar la peticion en este momento" });
    }
  }

  [Authorize]
  [HttpPost("addtocart")]
  public async Task<IActionResult> AddToCart(ModifyItemAmountModel item)
  {
    string idUser = HttpContext.User.Claims.FirstOrDefault(item => item.Type == "id").Value;
    try
    {
      DynamicParameters parameters = new();
      parameters.Add("@id_user", idUser);
      parameters.Add("@id_item", item.IdItem);
      List<ProductInCart> result = await repository.GetListByProcedure<ProductInCart>("add_to_cart", parameters);
      if (result != null)
      {
        return Ok(new { error = false, message = "articulo añadido al carrito correctamente", cartItems = result });
      }
      else
      {
        return StatusCode(204, new { error = true, message = "No se encontro el articulo" });
      }
    }
    catch (Exception ex)
    {
      return StatusCode(500, new { error = true, message = "No se pudo procesar la peticion en este momento" });
    }
  }

  [Authorize]
  [HttpDelete("deleteitem")]
  public async Task<IActionResult> DeleteItem(int idItem)
  {
    string id_user = HttpContext.User.Claims.FirstOrDefault(item => item.Type == "id").Value;
    try
    {
      DynamicParameters parameters = new();
      parameters.Add("@id_user", id_user);
      parameters.Add("@id_item", idItem);
      List<ProductInCart> result = await repository.GetListByProcedure<ProductInCart>("delete_item", parameters);
      if (result != null)
      {
        return Ok(new { error = false, message = "Se recupero el carrito correctamente", cartItems = result });
      }
      else
      {
        return StatusCode(204, new { error = true, message = "No se encontro el carrito" });
      }
    }
    catch (Exception ex)
    {
      return StatusCode(500, new { error = true, message = "No se pudo procesar la peticion en este momento" });
    }
  }

}