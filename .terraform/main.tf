provider "aws" {
  region = "us-east-1" # Change to your preferred region
}

resource "aws_ecr_repository" "quotes_repo" {
  name = "quotes-repo"
}

resource "aws_ecs_cluster" "quotes_cluster" {
  name = "quotes-cluster"
}

resource "aws_ecs_task_definition" "quotes_task" {
  family                   = "quotes-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = jsonencode([
    {
      name  = "quotes-container"
      image = "${aws_ecr_repository.quotes_repo.repository_url}:latest"
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    },
  ])
}

resource "aws_ecs_service" "quotes_service" {
  name            = "quotes-service"
  cluster         = aws_ecs_cluster.quotes_cluster.id
  task_definition = aws_ecs_task_definition.quotes_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1
  network_configuration {
    subnets = ["subnet-xxxxxxxxxxxxxxxxx", "subnet-yyyyyyyyyyyyyyyyy"] # Specify your subnet IDs
    security_groups = ["sg-xxxxxxxxxxxxxxxxx"] # Specify your security group IDs
  }
}

output "service_url" {
  value = aws_ecs_service.quotes_service.endpoint
}
