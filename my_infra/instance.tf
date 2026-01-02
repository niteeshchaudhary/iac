resource "aws_instance" "this" {
  count                       = var.instance_count
  ami                         = "ami-12345678"
  associate_public_ip_address = true
  availability_zone           = "eu-north-1b"

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  cpu_options {
    core_count       = 1
    threads_per_core = 2
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  disable_api_stop        = false
  disable_api_termination = false
  ebs_optimized           = true

  enclave_options {
    enabled = false
  }

  get_password_data                    = false
  hibernation                          = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.micro"
  ipv6_address_count                   = 0
  key_name                             = "common_key"

  maintenance_options {
    auto_recovery = "default"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }

  monitoring                 = false
  placement_partition_number = 0

  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }

  # Removed private_ip for auto-assignment

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    iops                  = 3000
    throughput            = 125
    volume_size           = 30
    volume_type           = "gp3"
  }

  security_groups   = ["sg-056a6b58a47bf2d9f"]
  source_dest_check = true
  subnet_id         = var.subnet_id

  tags = {
    Name = "myvm-${count.index + 1}"
  }

  tags_all = {
    Name = "myvm-${count.index + 1}"
  }

  tenancy                = "default"
  vpc_security_group_ids = ["sg-056a6b58a47bf2d9f"]

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"
    apt-get update -y
    apt-get install -y docker-ce
    systemctl enable docker
    systemctl start docker

    IMAGE="${var.docker_images[count.index]}"

    # Prepare env vars
    ENV_VARS=""
%{ for key, value in var.docker_envs[count.index] ~}
    ENV_VARS="$ENV_VARS -e ${key}='${value}'"
%{ endfor ~}

    PORT_MAPPING=""
    %{ if var.docker_ports[count.index] != "" } 
    PORT_MAPPING="-p ${var.docker_ports[count.index]}"
    %{ endif }

    docker pull $IMAGE
    eval "docker run -d --name app_container $PORT_MAPPING $ENV_VARS $IMAGE"
  EOF
}
