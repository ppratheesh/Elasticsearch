module "NetworkModule" {
    source = "./module/Network"
}

resource "aws_instance"  "dev_instance" {

    ami = var.AMIS[var.REGION]
    instance_type = "t2.micro"
    key_name = aws_key_pair.dev_key.key_name
    subnet_id  = module.NetworkModule.public_subnet_id
    vpc_security_group_ids = ["${aws_security_group.sg_dev.id}"]
        tags = {
        Name = "web_dev"
        "Environment" = "DEV"
    }
    provisioner "remote-exec" {
    inline = [
              "sudo apt-get update",
              "sudo apt-get install -y  python3"
             ]

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = var.USER_NAME
      private_key = file(var.PRIVATE_KEY)
    }
  } 

    provisioner "local-exec" {
    command = <<EOF
         echo "es-host ansible_host=${self.public_ip} ansible_user=${var.USER_NAME} ansible_ssh_private_key_file=${var.PRIVATE_KEY}">ansible_script/host.yml;
         ansible-playbook  ansible_script/main.yml -i ansible_script/host.yml
         EOF
  }
}


resource "aws_security_group" "sg_dev" {
    
    name = "sg_dev"
    vpc_id = module.NetworkModule.vpc_id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 9200
        to_port = 9200
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
