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
  region     = us-east-1

}


resource "aws_elasticache_cluster" "example" {
  cluster_id           = "my-redis-cluster-yv"
  engine               = "redis"
  engine_version       = "5.0.6"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis5.0"
  port                 = 6379
  subnet_group_name    = aws_db_subnet_group.example.name
  security_group_ids   = [aws_security_group.example.id]
  tags = {
    Name = "MyRedisCluster"
  }
}
