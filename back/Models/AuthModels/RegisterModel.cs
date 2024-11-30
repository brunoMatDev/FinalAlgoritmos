using System.ComponentModel.DataAnnotations;

namespace ATDapi.AuthModels.Models;
public class RegisterModel
{
    public required string Username { get; set; }

    [DataType(DataType.Password)]
    public required string Password { get; set; }
    public required string Name { get; set; }
    public required string LastName { get; set; }

}