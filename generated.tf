# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.
resource "aws_vpc" "name" {
  assign_generated_ipv6_cidr_block     = true
  tags                                 = {
    "Name" = "Developpement-vpc"
        }
  tags_all                             = {
    "Name" = "Developpement-vpc" 
        }
}
# __generated__ by Terraform from "sg-0a16ebdd5b719dc9c"
resource "aws_security_group" "sg_alb" {
  description = "Equilibreur"
  egress = [{
    cidr_blocks      = []
    description      = ""
    from_port        = 443
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = aws_security_group.sg_alb.id
    self             = false
    to_port          = 443
    }, {
    cidr_blocks      = []
    description      = ""
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = aws_security_group.sg_alb.id
    self             = false
    to_port          = 80
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 443
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 443
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
  }]
  name                   = "ALB"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = aws_vpc.name.id
}

# __generated__ by Terraform
resource "aws_lb_target_group_attachment" "target" {
  availability_zone = null
  port              = 80
  #quic_server_id    = null
  #region            = "eu-west-3"
  target_group_arn  = aws_lb_target_group.target.arn
  target_id         = aws_instance.nginx.id
}

# __generated__ by Terraform
resource "aws_route_table" "route3" {
  propagating_vgws = []
  route = [{
    carrier_gateway_id         = null
    cidr_block                 = "0.0.0.0/0"
    core_network_arn           = null
    destination_prefix_list_id = null
    egress_only_gateway_id     = null
    gateway_id                 = null
    ipv6_cidr_block            = null
    local_gateway_id           = null
    nat_gateway_id             = aws_nat_gateway.ngw.id
    network_interface_id       = null
    odb_network_arn            = null
    transit_gateway_id         = null
    vpc_endpoint_id            = null
    vpc_peering_connection_id  = null
  }]
  tags     = {
    "Name" = "Developpement-rtb-private2-eu-west-3b"
  }
  tags_all = {
    "Name" = "Developpement-rtb-private2-eu-west-3b"
  }
  vpc_id   = aws_vpc.name.id
}

# __generated__ by Terraform
resource "aws_route_table" "route1" {
  propagating_vgws = []
  # region           = "eu-west-3"
  route = [{
    carrier_gateway_id         = null
    cidr_block                 = "0.0.0.0/0"
    core_network_arn           = null
    destination_prefix_list_id = null
    egress_only_gateway_id     = null
    gateway_id                 = aws_internet_gateway.igw.id
    ipv6_cidr_block            = null
    local_gateway_id           = null
    nat_gateway_id             = null
    network_interface_id       = null
    odb_network_arn            = null
    transit_gateway_id         = null
    vpc_endpoint_id            = null
    vpc_peering_connection_id  = null
  }, {
    carrier_gateway_id         = null
    cidr_block                 = null
    core_network_arn           = null
    destination_prefix_list_id = null
    egress_only_gateway_id     = null
    gateway_id                 = aws_internet_gateway.igw.id
    ipv6_cidr_block            = "::/0"
    local_gateway_id           = null
    nat_gateway_id             = null
    network_interface_id       = null
    odb_network_arn            = null
    transit_gateway_id         = null
    vpc_endpoint_id            = null
    vpc_peering_connection_id  = null
  }]
  tags = {
    Name = "Developpement-rtb-public"
  }
  tags_all = {
    Name = "Developpement-rtb-public"
  }
  vpc_id = aws_vpc.name.id
}

resource "aws_route_table" "route2" {
  propagating_vgws = []
  # region           = "eu-west-3"
  route = [{
    carrier_gateway_id         = null
    cidr_block                 = "0.0.0.0/0"
    core_network_arn           = null
    destination_prefix_list_id = null
    egress_only_gateway_id     = null
    gateway_id                 = null
    ipv6_cidr_block            = null
    local_gateway_id           = null
    nat_gateway_id             = aws_nat_gateway.ngw.id
    network_interface_id       = null
    odb_network_arn            = null
    transit_gateway_id         = null
    vpc_endpoint_id            = null
    vpc_peering_connection_id  = null
  }]
  tags = {
    Name = "Developpement-rtb-private1-eu-west-3a"
  }
  tags_all = {
    Name = "Developpement-rtb-private1-eu-west-3a"
  }
  vpc_id = aws_vpc.name.id
}

# __generated__ by Terraform
resource "aws_subnet" "private_az1" {
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "eu-west-3a"
  cidr_block                                     = "192.168.20.128/28"
  customer_owned_ipv4_pool                       = null
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  #ipv4_ipam_pool_id                              = null
  #ipv4_netmask_length                            = null
  ipv6_cidr_block                                = "2a05:d012:a88:df02::/64"
  #ipv6_ipam_pool_id                              = null
  ipv6_native                                    = false
  #ipv6_netmask_length                            = null
  map_public_ip_on_launch                        = false
  outpost_arn                                    = null
  private_dns_hostname_type_on_launch            = "ip-name"
  #region                                         = "eu-west-3"
  tags = {
    Name = "Developpement-subnet-private1-eu-west-3a"
  }
  tags_all = {
    Name = "Developpement-subnet-private1-eu-west-3a"
  }
  vpc_id = aws_vpc.name.id
}

# __generated__ by Terraform from "sg-05a65c447217cfd37"
resource "aws_security_group" "sg_bastion" {
  description = "Autorise le SSH"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = -1
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "icmp"
    security_groups  = []
    self             = false
    to_port          = -1
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 443
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 443
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
    }, {
    cidr_blocks      = [aws_subnet.private_az1.cidr_block]
    description      = ""
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 22
  }]
  ingress = [{
    cidr_blocks      = ["${var.IP_admin}"]
    description      = ""
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 22
  }]
  name                   = "SG-Bastion"
  #region                 = "eu-west-3"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = aws_vpc.name.id
}

# __generated__ by Terraform
resource "aws_subnet" "private_az2" {
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "eu-west-3b"
  cidr_block                                     = "192.168.20.144/28"
  customer_owned_ipv4_pool                       = null
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  #ipv4_ipam_pool_id                              = null
  #ipv4_netmask_length                            = null
  ipv6_cidr_block                                = "2a05:d012:a88:df03::/64"
  #ipv6_ipam_pool_id                              = null
  ipv6_native                                    = false
  #ipv6_netmask_length                            = null
  map_public_ip_on_launch                        = false
  outpost_arn                                    = null
  private_dns_hostname_type_on_launch            = "ip-name"
  #region                                         = "eu-west-3"
  tags = {
    Name = "Developpement-subnet-private2-eu-west-3b"
  }
  tags_all = {
    Name = "Developpement-subnet-private2-eu-west-3b"
  }
  vpc_id = aws_vpc.name.id
}

# __generated__ by Terraform
resource "aws_subnet" "public_az2" {
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "eu-west-3b"
  cidr_block                                     = "192.168.20.16/28"
  customer_owned_ipv4_pool                       = null
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  #ipv4_ipam_pool_id                              = null
  #ipv4_netmask_length                            = null
  ipv6_cidr_block                                = "2a05:d012:a88:df01::/64"
  #ipv6_ipam_pool_id                              = null
  ipv6_native                                    = false
  #ipv6_netmask_length                            = null
  map_public_ip_on_launch                        = false
  outpost_arn                                    = null
  private_dns_hostname_type_on_launch            = "ip-name"
  #region                                         = "eu-west-3"
  tags = {
    Name = "Developpement-subnet-public2-eu-west-3b"
  }
  tags_all = {
    Name = "Developpement-subnet-public2-eu-west-3b"
  }
  vpc_id = aws_vpc.name.id
}

# __generated__ by Terraform from "eipalloc-037c0e8dc321ed489"
resource "aws_eip" "elastic_bastion" {
  address                   = null
  associate_with_private_ip = null
  customer_owned_ipv4_pool  = null
  domain                    = "vpc"
  instance                  = aws_instance.bastion.id
  network_border_group      = "eu-west-3"
  network_interface         = aws_instance.bastion.primary_network_interface_id
  public_ipv4_pool          = "amazon"
  #region                    = "eu-west-3"
  tags                      = {}
  tags_all                  = {}
}

resource "aws_eip" "elastic_alb" {
  domain = "vpc"
}
# __generated__ by Terraform from aws_internet_gateway.igw.id
resource "aws_internet_gateway" "igw" {
  #region = "eu-west-3"
  tags = {
    Name = "Developpement-igw"
  }
  tags_all = {
    Name = "Developpement-igw"
  }
  vpc_id = aws_vpc.name.id
}

resource "aws_nat_gateway" "ngw" {
  availability_mode                  = "regional"
  connectivity_type                  = "public"
  vpc_id                             = aws_vpc.name.id
  subnet_id                          = null
  tags = {
    Name = "gtw-dev"
  }
}

# __generated__ by Terraform from "rtb-0ca4679dabb0aadbf"
resource "aws_route_table" "route5" {
  propagating_vgws = []
  route            = []
  tags             = {}
  tags_all         = {}
  vpc_id           = aws_vpc.name.id
}

# __generated__ by Terraform from "eipalloc-0c66fef6234e140da"
resource "aws_eip" "elastic_nat2" {
  address                   = null
  associate_with_private_ip = null
  customer_owned_ipv4_pool  = null
  domain                    = "vpc"
  network_border_group      = "eu-west-3"
  public_ipv4_pool          = "amazon"
  #region                    = "eu-west-3"
  tags                      = {}
  tags_all                  = {}
}

# __generated__ by Terraform from "eipalloc-0dabaed0cdbf1463c"
resource "aws_eip" "elastic_nat1" {
  address                   = null
  associate_with_private_ip = null
  customer_owned_ipv4_pool  = null
  domain                    = "vpc"
  network_border_group      = "eu-west-3"
  public_ipv4_pool          = "amazon"
  #region                    = "eu-west-3"
  tags                      = {}
  tags_all                  = {}
}

# __generated__ by Terraform
resource "aws_lb" "alb-arn" {
  client_keep_alive                           = 3600
  customer_owned_ipv4_pool                    = null
  desync_mitigation_mode                      = "defensive"
  dns_record_client_routing_policy            = null
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  #enable_prefix_for_ipv6_source_nat           = "off"
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  enable_zonal_shift                          = false
  idle_timeout                                = 60
  internal                                    = false
  ip_address_type                             = "ipv4"
  load_balancer_type                          = "application"
  name                                        = "ALB"
  preserve_host_header                        = false
  #region                                      = "eu-west-3"
  security_groups                             = [aws_security_group.sg_alb.id]
  tags                                        = {}
  tags_all                                    = {}
  xff_header_processing_mode                  = "append"
  access_logs {
    bucket  = ""
    enabled = false
    prefix  = null
  }
  connection_logs {
    bucket  = ""
    enabled = false
    prefix  = null
  }
  health_check_logs {
    bucket  = ""
    enabled = false
    prefix  = null
  }
  subnet_mapping {
    allocation_id        = null
    ipv6_address         = null
    private_ipv4_address = null
    subnet_id            = aws_subnet.public_az1.id
  }
  subnet_mapping {
    allocation_id        = null
    ipv6_address         = null
    private_ipv4_address = null
    subnet_id            = aws_subnet.public_az2.id
  }
}

# __generated__ by Terraform
resource "aws_route_table" "route4" {
  propagating_vgws = []
  region           = "eu-west-3"
  route = [{
    carrier_gateway_id         = null
    cidr_block                 = "0.0.0.0/0"
    core_network_arn           = null
    destination_prefix_list_id = null
    egress_only_gateway_id     = null
    gateway_id                 = aws_internet_gateway.igw.id
    ipv6_cidr_block            = null
    local_gateway_id           = null
    nat_gateway_id             = null
    network_interface_id       = null
    odb_network_arn            = null
    transit_gateway_id         = null
    vpc_endpoint_id            = null
    vpc_peering_connection_id  = null
  }]

  vpc_id = aws_vpc.name.id
}


resource "aws_security_group" "sg_web" {
  description = "Autorisations du serveur web"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = -1
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "icmp"
    security_groups  = []
    self             = false
    to_port          = -1
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 443
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 443
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
  }]
  ingress = [{
    cidr_blocks      = []
    description      = ""
    from_port        = -1
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "icmp"
    security_groups  = [aws_security_group.sg_nat.id]
    self             = false
    to_port          = -1
    }, {
    cidr_blocks      = []
    description      = ""
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = [aws_security_group.sg_bastion.id]
    self             = false
    to_port          = 22
    }, {
    cidr_blocks      = []
    description      = ""
    from_port        = 443
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = [aws_security_group.sg_alb.id]
    self             = false
    to_port          = 443
    }, {
    cidr_blocks      = []
    description      = ""
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = [aws_security_group.sg_alb.id]
    self             = false
    to_port          = 80
  }]
  name                   = "SG-web"
  region                 = "eu-west-3"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = aws_vpc.name.id
}

# __generated__ by Terraform from "arn:aws:elasticloadbalancing:eu-west-3:233231935533:listener/app/ALB/4c1cbebdff5cb4a0/cf673a7ca9e0691f"
resource "aws_lb_listener" "listen" {
  alpn_policy                          = null
  certificate_arn                      = null
  load_balancer_arn                    = aws_lb.alb-arn.arn
  port                                 = 80
  protocol                             = "HTTP"
  # region                               = "eu-west-3"
  routing_http_response_server_enabled = true
  tags                                 = {}
  tags_all                             = {}
  default_action {
    order            = 1
    target_group_arn = aws_lb_target_group.target.arn
    type             = "forward"
    forward {
      stickiness {
        duration = 3600
        enabled  = false
      }
      target_group {
        arn    = aws_lb_target_group.target.arn
        weight = 1
      }
    }
  }
}

# __generated__ by Terraform
resource "aws_subnet" "public_az1" {
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "eu-west-3a"
  cidr_block                                     = "192.168.20.0/28"
  customer_owned_ipv4_pool                       = null
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv4_ipam_pool_id                              = null
  ipv4_netmask_length                            = null
  ipv6_cidr_block                                = "2a05:d012:a88:df00::/64"
  ipv6_ipam_pool_id                              = null
  ipv6_native                                    = false
  ipv6_netmask_length                            = null
  map_public_ip_on_launch                        = false
  outpost_arn                                    = null
  private_dns_hostname_type_on_launch            = "ip-name"
  region                                         = "eu-west-3"
  tags = {
    Name = "Developpement-subnet-public1-eu-west-3a"
  }
  tags_all = {
    Name = "Developpement-subnet-public1-eu-west-3a"
  }
  vpc_id = aws_vpc.name.id
}

# __generated__ by Terraform from "sg-0058dc61b057c95b2"
resource "aws_security_group" "sg_nat" {
  description = "Autorisation du flux de la NAT Instance"
  egress = [{
    cidr_blocks      = [aws_subnet.private_az1.cidr_block]
    description      = ""
    from_port        = -1
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "icmp"
    security_groups  = []
    self             = false
    to_port          = -1
  }]
  ingress = [{
    cidr_blocks      = [aws_subnet.private_az1.cidr_block]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  name                   = "SG-NAT"
  region                 = "eu-west-3"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = aws_vpc.name.id
}

# __generated__ by Terraform
resource "aws_lb_target_group" "target" {
  deregistration_delay               = "300"
  ip_address_type                    = "ipv4"
  lambda_multi_value_headers_enabled = false
  load_balancing_algorithm_type      = "round_robin"
  load_balancing_anomaly_mitigation  = "off"
  load_balancing_cross_zone_enabled  = "use_load_balancer_configuration"
  name                               = "TG-WEB-PRIVATE"
  port                               = 80
  protocol                           = "HTTP"
  protocol_version                   = "HTTP1"
  proxy_protocol_v2                  = false
  region                             = "eu-west-3"
  slow_start                         = 0
  tags                               = {}
  tags_all                           = {}
  target_type                        = "instance"
  vpc_id                             = aws_vpc.name.id
  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
  stickiness {
    cookie_duration = 86400
    cookie_name     = null
    enabled         = false
    type            = "lb_cookie"
  }

  target_group_health {
    dns_failover {
      minimum_healthy_targets_count      = "1"
      minimum_healthy_targets_percentage = "off"
    }
    unhealthy_state_routing {
      minimum_healthy_targets_count      = 1
      minimum_healthy_targets_percentage = "off"
    }
  }
  /*target_health_state {
    enable_unhealthy_connection_termination = true
    unhealthy_draining_interval             = 100
  }*/
}


resource "aws_route_table_association" "asso1" {
  gateway_id = null
  region = "eu-west-3"
  route_table_id = aws_route_table.route1.id
  subnet_id = aws_subnet.public_az1.id
}

resource "aws_route_table_association" "asso2" {
  gateway_id = null
  region = "eu-west-3"
  route_table_id = aws_route_table.route1.id
  subnet_id = aws_subnet.public_az2.id
}

# __generated__ by Terraform from "subnet-044540ec65a3a2ccf/rtb-08c52a7c4ebe371a4"
resource "aws_route_table_association" "asso3" {
  gateway_id     = null
  region         = "eu-west-3"
  route_table_id = aws_route_table.route2.id
  subnet_id      = aws_subnet.private_az1.id
}

resource "aws_route_table_association" "asso4" {
  gateway_id = null
  region = "eu-west-3"
  route_table_id = aws_route_table.route3
  subnet_id = aws_subnet.private_az2
}

resource "aws_route_table_association" "asso5" {
  gateway_id = aws_nat_gateway.ngw.id
  region = "eu-west-3"
  route_table_id = aws_route_table.route4.id
}

resource "aws_main_route_table_association" "asso6" {
  vpc_id = aws_vpc.name.id
  region = "eu-west-3"
  route_table_id = aws_route_table.route5
}

# __generated__ by Terraform
resource "aws_instance" "nginx" {
  ami                                  = "ami-0e1c4170d9c01184b"
  availability_zone                    = "eu-west-3a"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = true
  force_destroy                        = false
  get_password_data                    = false
  hibernation                          = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.micro"
  key_name                             = "srv-web"
  monitoring                           = false
  placement_partition_number           = 0
  region                               = "eu-west-3"
  tags = {
    Name = "Serveur-Web"
  }
  tags_all = {
    Name = "Serveur-Web"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_replace_on_change = null
  volume_tags                 = null
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
  enclave_options {
    enabled = false
  }
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
  primary_network_interface {
    network_interface_id = "eni-090c59447859ec920"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = false
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 3000
    tags                  = {}
    tags_all              = {}
    throughput            = 125
    volume_size           = 10
    volume_type           = "gp3"
  }
}

# __generated__ by Terraform
# On supprimme les paramètres réseaux de la VM (IP publique & privée statique) pour que ce soit à l'interface de la VM de la faire
resource "aws_instance" "bastion" {
  ami                                  = "ami-00034b0b6e2e5a27e"
  availability_zone                    = "eu-west-3a"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = true
  force_destroy                        = false
  get_password_data                    = false
  hibernation                          = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.micro"
  key_name                             = "Iencli"
  monitoring                           = false
  placement_partition_number           = 0
  region                               = "eu-west-3"
  tags = {
    Name = "NAT-Instance"
  }
  tags_all = {
    Name = "NAT-Instance"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_replace_on_change = false
  volume_tags                 = null
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
  enclave_options {
    enabled = false
  }
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
  primary_network_interface {
    network_interface_id = "eni-0ce354fd051e86e81"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = false
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 3000
    tags                  = {}
    tags_all              = {}
    throughput            = 125
    volume_size           = 12
    volume_type           = "gp3"
  }
}
