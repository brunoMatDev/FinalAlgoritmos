namespace ATDapi.Models;
public class UserLogedModel
{
    public int Id { get; set; }
    public required string Username { get; set; }
    public required string Name { get; set; }
    public required string Last_name { get; set; }
    public required string Rol { get; set; }

    public static string ListUsers(){
      return "EXEC dbo.list_users";
    }
}