### AWS LAMBDA Fucntions..
___________________________________________________________________________________________________

- On Day to day basics a Devops Engineer uses AWS Lambda service for multiple uses cases
- use lambda for projects like cost optimization
- you can trigger lambda functions using s3 buckets, cloud watch
- Event driven actions 
- Lambda functions has wide range of use cases.

___________________________________________________________________________________________________

### Fundamentals of serverless architecture , serverless application management. 

- Difference btw EC2 and Lamnbda functions
- When to use Ec2, when to use Lambda functions and which service is cost efficient

___________________________________________________________________________________________________

### AWS Lambda Functions
- What problem is it solving on AWS ? 
    - compute and serverless issue is solved by Lambda functions
    - Lambda belongs to the same family as EC2 belongs to 
    - Ec2 also solves the compute problems.
    - EC2 is nothing but a virtual server.
    - When people move from virutal machines to AWS - there is a service called EC2 instance for compute issues and by providing few parameters a virutal device / server is created for workaround. 
    - Lambda functions can also give you compute, ex: python based application, you can run this application on this lambda function and this lambda function follow the serverless architecture
    - If you are spinning up a lambda function, what would happen is you will not provide any parameters you provided for creating a EC2 instance, AWS will itself take care of these parameters for creating a Lambda function.
    - you want to run a nodejs, python application etc.., aws will automatically create a compute for you depending on the requirements and once you are entire application is triggered, aws will create the compute for you and aws will tear down the compute .
    - But when you create a EC2 instance, after the application is triggered you will have to manually tear down the instance. 
    - AWS Lambda functions are ephemeral. 
    - In the serverless architecture you are not responsible for the server at all.
    - Depends on the requirements, AWS will automatically creates the compute size and once the task is done, AWS will scale down the compute for you.
    - You can make use of Lambda functions for cost optimization. 


- S3 bucket solves problems in aws ? 
    - is storage 

___________________________________________________________________________________________________


### Example: Food DElivery Platform (Mobile or desktop application)
    - When a user creates a requests on a food delivery application he selects the food , goes to check out , performs the payment and once the transaction is completed the user moves out of the application.
    - Once the payment is done the user will not be able to access the payment page.
    - A Lambda Function /Infrastructure is being created by the AWS for checkout form and payment gateway task, so once the customer is done with the payment, he exists the page and AWS will tear down the infrastructure it created for the application.
    - Only when the user requests the application for performing a certain task then only AWS will create certain infrastructure and once that particular task is done, the infrastructure will be tear down by AWs.
    - If you use serverless architecture this is the advantage.
    - for EC2 instance you will have to delete the infrastructure after the usage is done.


___________________________________________________________________________________________________

- IP address (public ip adddress) - EC2 instance
    - control auto scaling 
    - public ip address
- Lambda it doesnt have ip address 


___________________________________________________________________________________________________


### Who will decide if we have to go with Serverless architecture or with server ? 
- A Devops engineer, will not decide 
- This will be taken care by Development team or Architecture team.
- Ex: Food delivery platform can run on both server and serverless approach.


___________________________________________________________________________________________________


### When it comes to Cost Optimization why are you choosing Lambda functions instead of EC2 instances ? 
- As a Devops Engineer, it is your job to check the active/ stale resources for cost optimization purpose.
- Say a EBS is created 30 days back and it is not being used by anyone you need to either delete the unused service or send a notification to check if it is being used by anyone.
- This task can be performed by using AWS Lambda functions by writing a code, you can govern the cost by using Lambda function.
- For checking the unused AWS Services / resources by the end users or the cost of the services being used in AWS, you can create a cron job in CloudWatch with a time like around 10am everyday to check the services using AWS Lambda function.
- In general serverless, AWS Lambda function is event driven, it has to be triggered by a service like cloudwatch to check the cost or unused services and once it checks, it automatically tears down the function.

___________________________________________________________________________________________________

### Some of the best use cases of serverless architecture / Lambda
    - Cost Optimization
    - Security / Compliance of Organization
    - Scope is Endless

___________________________________________________________________________________________________
