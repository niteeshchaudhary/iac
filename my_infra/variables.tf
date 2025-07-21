variable "instance_count" {
  description = "Number of EC2 instances to create."
  type        = number
  default     = 5
}

variable "subnet_id" {
  description = "The subnet ID to launch the instances in."
  type        = string
}

variable "docker_images" {
  description = "List of Docker images to run on each instance."
  type        = list(string)
}

variable "docker_envs" {
  description = "List of maps of environment variables for each instance."
  type        = list(map(string))
}

variable "docker_ports" {
  description = "List of port mappings for each container, e.g. ['9000:8000', ...]"
  type        = list(string)
} 