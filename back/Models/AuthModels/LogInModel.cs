using System.ComponentModel.DataAnnotations;

namespace ATDapi.Models;
public class LogInModel
{
    [Required(ErrorMessage = "El nombre de usuario es requerido.")]
    public string Username { get; set; } = string.Empty;

    [Required(ErrorMessage = "La contraseña es requerida.")]
    [DataType(DataType.Password)]
    public string Password { get; set; } = string.Empty;
    public string? rol { get; set; }
    public string CheckUser()
    {
        return string.Format("EXEC dbo.validate_user @user = '{0}', @password = '{1}'", Username, Password);
    }
}