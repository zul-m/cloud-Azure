using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace AzureFunc
{
    public static class Function1
    {
        [FunctionName("Function1")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)] HttpRequest req,
            ILogger log)
        {
            TransactionData _TransactionData = new TransactionData();

            string id = req.Query["id"];
            string name = req.Query["name"];
            string trid = req.Query["trid"];
            string reid = req.Query["reid"];

            if (!string.IsNullOrEmpty(id))
            {
                _TransactionData.id = Int32.Parse(id);
                _TransactionData.name = name;
                _TransactionData.trid = trid;
                _TransactionData.reid = reid;
            }

            log.LogInformation("C# HTTP trigger function processed a request.", JsonConvert.SerializeObject(_TransactionData));

            string responseMessage = string.IsNullOrEmpty(name)
                ? "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."
                : $"Hello, {id} {name} {trid} {reid}. This HTTP triggered function executed successfully.";

            return new OkObjectResult(responseMessage);
        }
    }
}
