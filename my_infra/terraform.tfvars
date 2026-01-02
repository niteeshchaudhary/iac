# Number of EC2 instances
instance_count = 5

# Subnet where EC2 instances will be launched
subnet_id = "subnet-0a1b2c3d4e5f6a7b6"

# Docker images to run (one per instance or reused as per your logic)
docker_images = [
  "nginx:latest",
  "redis:7",
  "postgres:15",
  "python:3.11-slim",
  "node:20-alpine"
]

# Environment variables per instance (must match instance_count)
docker_envs = [
  {
    ENV        = "dev"
    APP_PORT  = "8000"
  },
  {
    ENV        = "dev"
    REDIS_URL = "redis://localhost:6379"
  },
  {
    ENV        = "dev"
    POSTGRES_DB = "appdb"
    POSTGRES_USER = "appuser"
  },
  {
    ENV       = "dev"
    WORKERS   = "4"
  },
  {
    ENV       = "dev"
    NODE_ENV = "development"
  }
]

# Port mappings per container
docker_ports = [
  "80:80",
  "6379:6379",
  "5432:5432",
  "8000:8000",
  "3000:3000"
]
