resource "aws_instance" "this" {
  ami                    = "ami-09c813fb71547fc4f" #This is our devops-practice AMI ID
  vpc_security_group_ids = [aws_security_group.allow_tlse.id]
  instance_type          = "t3.micro"
  tags = {
    Name    = "terraform-demo"
    Purpose = "terraform-practice"
  }
  provisioner "local-exec" {
    command = "echo ${self.private_ip} > inventory"
    
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = self.public_ip
  }

  provisioner  "remote-exec" {
    inline = [
      "sudo dnf install nginx -y",
       "sudo systemctl start nginx",
    ]
  }

  provisioner  "remote-exec" {
    when = destroy
    inline = [
      "sudo dnf install nginx -y",
       "sudo systemctl stop nginx",
    ]
  }

}

resource "aws_security_group" "allow_tlse" {
  name        = "allow_tlse"
  description = "Allow TLSE inbound traffic and all outbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tlse"
  }
}
