resource "aws_instance" "instance" {
  ami           = "ami-085925f297f89fce1"
  instance_type = "t2.micro"
  key_name = "terra_key1"
  subnet_id = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.public-sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "Terraform_instance"
  }
}
resource "aws_instance" "init_p" {
   ami  = "ami-085925f297f89fce1"
   instance_type = "t2.micro"
   key_name = "terra_key1"
   subnet_id = aws_subnet.private-subnet.id
   vpc_security_group_ids = [aws_security_group.sg_private.id]
   tags ={
    Name = "private_init"
  }
}
resource "null_resource" "ModifyApplyAnsiblePlayBook" {
  provisioner "local-exec" {
    command = " ansible-playbook -i ',${aws_instance.instance.public_ip}' --private-key ../../key play.yml"
  }
}

