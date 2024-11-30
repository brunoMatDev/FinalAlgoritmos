using ATDapi.Repositories;
using Dapper;

namespace ATDapi.Services;

public class RequestLogger(Repository repository)
{
  public async Task SaveLog(HttpContext context, int statusCode, string message, int? id = null)
  {
    string ip = context.Request.Headers["X-Forwarded-For"].ToString();
    if (string.IsNullOrEmpty(ip))
    {
      ip = context.Connection.RemoteIpAddress.ToString();
    }
    else
    {
      string[] ips = ip.Split(',');
      ip = ips[0].Trim();
    }
    string endpoint = context.Request.Path.Value;
    DateTime date = DateTime.Now;
    string userAgent = context.Request.Headers["User-Agent"].ToString();
    DynamicParameters parameters = new();
    parameters.Add("@ip", ip);
    parameters.Add("@endpoint", endpoint);
    parameters.Add("@date_and_time", date);
    parameters.Add("@user_agent", userAgent);
    parameters.Add("@id_user", id ?? null);
    parameters.Add("@status_code", statusCode);
    parameters.Add("@message", message);
    dynamic result = await repository.InsertByProcedure("save_request_logs", parameters);
    if (result > 0)
    {
      ConsoleLogger(null);
    }
    else
    {
      ConsoleLogger("ALERTA: No se pudo almacenar el registro de la peticion");
    }
  }
  public void ConsoleLogger(string? message = null)
  {
    
  }
}
