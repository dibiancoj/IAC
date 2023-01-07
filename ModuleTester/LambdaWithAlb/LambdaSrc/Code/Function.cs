using Amazon.Lambda.ApplicationLoadBalancerEvents;
using Amazon.Lambda.Core;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace Src;

public class Function
{
    public ApplicationLoadBalancerResponse FunctionHandler(ApplicationLoadBalancerRequest request, ILambdaContext context)
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
            Body = System.Text.Json.JsonSerializer.Serialize(new { Message = "Lambda With Alb Called" })
        };
    }
}
