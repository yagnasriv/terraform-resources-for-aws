### Amazon API Gateway.
___________________________________________________________________________________________________

- Amazon API Gateway provides front end services to AWS Lambda , EC2 instances and other services in AWS.
- API gateway helps developers to create and manage APIs to back-end systems running on Amazon EC2, AWS Lambda, or any publicly addressable web service. 
- With Amazon API Gateway, you can generate custom client SDKs for your APIs, to connect your back-end systems to mobile, web, and server applications or services.

<Note: In simple terms, the relationship between AWS Lambda and AWS API Gateway is like a backend service (Lambda) and a frontend interface (API Gateway) for your applications.>

___________________________________________________________________________________________________

### Simple Use Case:

- You create a Lambda function to perform a specific task 
    - Ex: process an image, fetch data from a database.
- API Gateway allows you to create an HTTP endpoint (API) that clients can call to trigger the Lambda function.
- Clients with (web or mobile apps) send requests to the API Gateway, and it, in turn, invokes the corresponding Lambda function.
- The Lambda function processes the request, performs its task, and returns a response through API Gateway.
- In essence, AWS Lambda functions are the backend logic that performs tasks, while AWS API Gateway acts as the entry point or interface through which external clients interact with your Lambda functions. The combination of Lambda and API Gateway allows you to build scalable and serverless architectures for your applications.