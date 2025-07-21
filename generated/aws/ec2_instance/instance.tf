resource "aws_instance" "tfer--i-002D-0a5fa6b2b4a389198_myvm" {
  ami                         = "ami-042b4708b1d05f512"
  associate_public_ip_address = "false"
  availability_zone           = "eu-north-1b"

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  cpu_core_count = "1"

  cpu_options {
    core_count       = "1"
    threads_per_core = "2"
  }

  cpu_threads_per_core = "2"

  credit_specification {
    cpu_credits = "unlimited"
  }

  disable_api_stop        = "false"
  disable_api_termination = "false"
  ebs_optimized           = "true"

  enclave_options {
    enabled = "false"
  }

  get_password_data                    = "false"
  hibernation                          = "false"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.micro"
  ipv6_address_count                   = "0"
  key_name                             = "common_key"

  maintenance_options {
    auto_recovery = "default"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = "2"
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }

  monitoring                 = "false"
  placement_partition_number = "0"

  private_dns_name_options {
    enable_resource_name_dns_a_record    = "true"
    enable_resource_name_dns_aaaa_record = "false"
    hostname_type                        = "ip-name"
  }

  private_ip = "172.31.34.98"

  root_block_device {
    delete_on_termination = "true"
    encrypted             = "false"
    iops                  = "3000"
    throughput            = "125"
    volume_size           = "30"
    volume_type           = "gp3"
  }

  security_groups   = ["launch-wizard-1"]
  source_dest_check = "true"
  subnet_id         = "subnet-009d9776e2f248f93"

  tags = {
    Name = "myvm"
  }

  tags_all = {
    Name = "myvm"
  }

  tenancy                = "default"
  vpc_security_group_ids = ["sg-056a6b58a47bf2d9f"]
}
