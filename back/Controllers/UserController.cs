using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("/User/")]
class UserController : ControllerBase {
    public async Task<IActionResult> Index() {
        
        return Ok("hola");
    }
}