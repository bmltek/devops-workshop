
resource "tls_private_key" "my_key" {
algorithm = "RSA"
rsa_bits = 2048
}
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.my_key.public_key_openssh
tags ={
  Name = "MyKeyPair"
  Owner = "Bolanle"
}
}

resource "null_resource" "download_key" {
  triggers = {
    private_key = tls_private_key.my_key.private_key_pem
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "${tls_private_key.my_key.private_key_pem}" > deployer-key.pem
      chmod 400 deployer-key.pem
    EOT
  }
}


resource "aws_instance" "dpp-server" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t2.micro"
    #key_name = aws_key_pair.deployer.key_name
    key_name = "my-key"
    vpc_security_group_ids = [aws_security_group.dpp-sg.id]
    subnet_id = aws_subnet.dpp-public-subnet-01.id 
  for_each = toset(["jenkins-master", "build-slave", "ansible"])
   tags = {
     Name = "${each.key}"
   }
    root_block_device {
    volume_size           = 30
    volume_type           = "gp2"
    delete_on_termination = true
  
}
}
resource "aws_security_group" "dpp-sg" {
  name        = "dpp-sg"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.dpp-vpc.id

   ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
      ingress {
    description      = "jenkins access to public"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "dpp-sg"

  }
}

