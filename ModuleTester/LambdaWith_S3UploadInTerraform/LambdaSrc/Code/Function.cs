using Amazon.Lambda.ApplicationLoadBalancerEvents;
using Amazon.Lambda.Core;
using Amazon.Lambda.RuntimeSupport;
using Amazon.Lambda.Serialization.SystemTextJson;

namespace Src;

public class Function
{
    /// <summary>
    /// The main entry point for the custom runtime.
    /// </summary>
    /// <param name="args"></param>
    private static async Task Main(string[] args)
    {
        Func<ApplicationLoadBalancerRequest, ILambdaContext, ApplicationLoadBalancerResponse> handler = FunctionHandler;
        await LambdaBootstrapBuilder.Create(handler, new DefaultLambdaJsonSerializer())
            .Build()
            .RunAsync();
    }

    public static ApplicationLoadBalancerResponse FunctionHandler(ApplicationLoadBalancerRequest request, ILambdaContext context)
    {
        //System.Text.Json.JsonSerializer.Deserialize<SomeClass>(request.Body);

        return new ApplicationLoadBalancerResponse
        {
            StatusCode = 200,
            StatusDescription = "200 OK",
            IsBase64Encoded = false,
            Headers = new Dictionary<string, string>
            {
                { "Content-Type", "application/json" }
            },
            Body = System.Text.Json.JsonSerializer.Serialize(new { Message = "Lambda With Alb Called From S3." })
        };
    }
}
