resource "aws_instance" "vrising-instance" {
    ami = "ami-0310483fb2b488153"
    instance_type = "t3.medium"
    root_block_device {
        delete_on_termination = true
        volume_size = 16
    }
    security_groups = [resource.aws_security_group.vrising-sg.name]
    key_name = "vrising-pk"
    user_data_base64 = base64encode(data.template_file.input.rendered)
    tags = {
            Name = "vrising-instance"
        }
}

resource "aws_security_group" "vrising-sg" {
    name = "vrising-sg"
    ingress {
        description = "vrising-port-allow-9876"
        from_port = 9876
        to_port = 9876
        protocol = "udp"
        cidr_blocks = var.home_cdir_block
    }
    ingress {
        description = "vrising-port-allow-9877"
        from_port = 9877
        to_port = 9877
        protocol = "udp"
        cidr_blocks = var.home_cdir_block
    }
    ingress {
        description = "ssh-allow"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = var.home_cdir_block
    }

    egress {
        description = "outbound-rule"
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "instance-ip" {
    value = resource.aws_instance.vrising-instance.public_ip
}