### To manage AWS Elastic Container Service (ECS) using Terraform, you need to define resources 
### such as the ECS cluster, task definitions, services, and optionally, networking configurations. 
### Below is a simplified example of Terraform scripts for managing AWS ECS. 
### This example includes the creation of an ECS cluster, a task definition, and a service.

### Example for creating ECS Cluster

resource "aws_ecs_cluster" "my_cluster" {
  name = "my-ecs-cluster-yv"

  setting {
    name  = "containerInsights"
    value = "enabled"
  
    }
}



