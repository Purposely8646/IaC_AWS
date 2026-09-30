# Importation des ressources du VPC

#Vpc
import {
  to = aws_vpc.name
  id = "${var.aws_vpc}"
}

# sous réseaux privés et publiques des 2 AZ
import {
  to = aws_subnet.public_az1
  id = "${var.public_subnet1}"
}

import {
  to = aws_subnet.public_az2
  id = "${var.public_subnet2}"
}

import {
  to = aws_subnet.private_az1
  id = "${var.private_subnet1}"
}

import {
  to = aws_subnet.private_az2
  id = "${var.private_subnet2}"
}

# Tables de routage
import {
  to = aws_route_table.route1
  id = "${var.routetable1}"
}

import {
  to = aws_route_table.route2
  id = "${var.routetable2}"
}

import {
  to = aws_route_table.route3
  id = "${var.routetable3}"
}

import {
  to = aws_route_table.route4
  id = "${var.routetable4}"
}

import {
  to = aws_route_table.route5
  id = "${var.routetable5}"
}

# table de routage d'association
import {
  to = aws_route_table_association.asso1
  id = "${var.asso_public1}"
}

import {
  to = aws_route_table_association.asso2
  id = "${var.asso_public2}"
}

import {
  to = aws_route_table_association.asso3
  id = "${var.asso_private1}"
}

import {
  to = aws_route_table_association.asso4
  id = "${var.asso_private2}"
}

import {
  to = aws_route_table_association.asso5
  id = "${var.asso_nat}"
}

# Importer les passerelles
import {
  to = aws_internet_gateway.igw
  id = "${var.Internet}"
}

import {
  to = aws_nat_gateway.ngw
  id = "${var.nat-gtw}"
}

# importer les ID de l'ALB

import {
  to = aws_lb.alb-arn
  id = "${var.ALB_ARN}"
}

import {
  to = aws_lb_listener.listen
  id = "${var.ALB_Listeners}"
}

import {
  to = aws_lb_target_group.target
  id = "${var.ALB_TargetGroup}"
}

# Importer les instances

import {
  to = aws_instance.bastion
  id = "${var.Bastion_ID}"
}

import {
  to = aws_instance.nginx
  id = "${var.Web_ID}"
}

# Importer les SecurityGroup

import {
  to = aws_security_group.sg_nat
  id = "${var.sg-nat}"
}

import {
  to = aws_security_group.sg_web
  id = "${var.sg-web}"
}

import {
  to = aws_security_group.sg_alb
  id = "${var.SG-ALB}"
}

import {
  to = aws_security_group.sg_bastion
  id = "${var.SG-Bastion}"
}

# Importer les Elastic IP

import {
  to = aws_eip.elastic_nat1
  id = "${var.elastic-nat1}"
}

import {
  to = aws_eip.elastic_nat2
  id = "${var.elastic-nat2}"
}

import {
  to = aws_eip.elastic_bastion
  id = "${var.elastic-bastion}"
}

import {
  to = aws_eip.elastic_alb
  id = "${var.elastic-ALB}"
}

# Importer les clés

# Target Group Attachment : TargetGroup ARN, ID de la ressource ciblé & port ciblé
import {
  to = aws_lb_target_group_attachment.target
  identity = {
    target_group_arn = "${var.ALB_TargetGroup}"
    target_id = "${var.Web_ID}"
    port = 80
  }
}