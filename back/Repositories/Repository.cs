using Dapper;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Data.Odbc;

namespace ATDapi.Repositories;

public class Repository
{
  private string dbConnectionString = "SERVER=server-terciario.hilet.com,11333;DATABASE=carrito_de_bruno;UID=sa;PWD=1234!\"qwerQW;TrustServerCertificate=True";
  public async Task<int> DeleteAsync(string query)
  {
    using (SqlConnection connection = new SqlConnection(dbConnectionString))
    {
      return await connection.ExecuteAsync(query);
    }
  }

  //Query que trae una sola fila de la tabla
  public async Task<T> GetOneByQuery<T>(string query)
  {
    using (SqlConnection connection = new SqlConnection(dbConnectionString))
    {
      return await connection.QueryFirstOrDefaultAsync<T>(query);
    }
  }

  //Query que trae varias filas desde la base de datos
  public async Task<List<T>> GetListBy<T>(string query)
  {
    using (SqlConnection connection = new SqlConnection(dbConnectionString))
    {
      IEnumerable<T> rows = await connection.QueryAsync<T>(query);
      return rows.AsList();
    }
  }

  //Query que inserta en la tabla
  public async Task<dynamic> InsertByQuery(string query, DynamicParameters parameters)
  {
    using (SqlConnection connection = new SqlConnection(dbConnectionString))
    {
      try
      {
        return await connection.ExecuteAsync(query, parameters, commandType: CommandType.StoredProcedure);

      }
      catch (Exception ex)
      {
        throw ex;
      }
    }
  }
  public async Task<dynamic> InsertProcedure(string query, DynamicParameters parameters)
  {
    using SqlConnection connection = new(dbConnectionString);
    try
    {
      return await connection.ExecuteAsync(query, parameters, commandType: CommandType.StoredProcedure);

    }
    catch (Exception ex)
    {
      throw ex;
    }
  }
}


