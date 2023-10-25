## Setting up a Redis Cluster for scalability and high availability
## Amazon ElastiCache for Redis cluster mode setup, configuration, security, and provisioning

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}


provider "aws" {
  region     = "us-east-1"
}


resource "aws_elasticache_cluster" "example" {
  cluster_id           = "my-redis-cluster-yv"
  engine               = "redis"
  engine_version       = "5.0.6"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis5.0"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.example.name
  security_group_ids   = "sg-03b3f6c4ade634dd5"
  tags = {
    Name = "MyRedisCluster-YV"
  }
}

resource "aws_elasticache_subnet_group" "example" {
  name       = "my-cache-subnet-yv"
  subnet_ids = [subnet-0faeccfe09c516254,
                subnet-0a135ebade0072a07]
}