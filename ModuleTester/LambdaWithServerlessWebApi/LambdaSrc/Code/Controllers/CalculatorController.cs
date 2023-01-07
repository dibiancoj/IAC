using Microsoft.AspNetCore.Mvc;

namespace MyServerlessProject.Controllers;

[ApiController]
[Route("[controller]")]
public class CalculatorController : ControllerBase
{
    [HttpGet]
    public string Get() => $"HttpGet --> Processed On {DateTime.Now}";

    [HttpPost]
    public string Post() => $"HttpPost --> Processed On {DateTime.Now}";
}
