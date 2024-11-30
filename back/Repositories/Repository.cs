using Dapper;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Data.Odbc;

namespace ATDapi.Repositories;

public class Repository
{
  private string dbConnectionString = "SERVER=localhost\\AGUSSSTIN;DATABASE=carrito_de_bruno;UID=agustin;PWD=1234;TrustServerCertificate=True";
  public async Task<int> DeleteAsync(string query)
  {
    using (SqlConnection connection = new SqlConnection(dbConnectionString))
    {
      return await connection.ExecuteAsync(query);
    }
  }
  public async Task<T> GetOneByQuery<T>(string query)
  {
    using SqlConnection connection = new SqlConnection(dbConnectionString);
    return await connection.QueryFirstOrDefaultAsync<T>(query);
  }
  public async Task<List<T>> GetListByProcedure<T>(string query, DynamicParameters parameters)
  {
    using SqlConnection connection = new(dbConnectionString);
    IEnumerable<T> rows = await connection.QueryAsync<T>(query, parameters, commandType: CommandType.StoredProcedure);
    return rows.AsList();
  }
  public async Task<int> InsertByProcedure(string query, DynamicParameters parameters)
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


