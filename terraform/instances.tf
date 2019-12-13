resource "aws_instance" "web-1" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "ap-southeast-1a"
    instance_type = "m1.small"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.web.id}"]
    subnet_id = "${aws_subnet.ap-southeast-1a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false
    
    tags {
        Name = "ansible-master-Web Server 1"
    }
}

resource "aws_instance" "db-1" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "ap-southeast-1a"
    instance_type = "m1.small"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.db.id}"]
    subnet_id = "${aws_subnet.ap-southeast-1a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "ansible-master-DB Server 1"
    }
}

data "template_file" "init" {
  template = "${file("init/install-ansible.sh")}"

  vars = {
    web01_address = "${aws_instance.web-1.private_ip}"
    db01_address = "${aws_instance.db-1.private_ip}"
  }
}
resource "aws_instance" "nat" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "ap-southeast-1a"
    instance_type = "m1.small"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.nat.id}"]
    subnet_id = "${aws_subnet.ap-southeast-1a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false

    provisioner "file" {
    source      = "keys/fix-key.pem"
    destination = "/home/ec2-user/.ssh/fix-key.pem"
        connection {
        type     = "ssh"
        user     = "ec2-user"
        private_key = "${file("keys/fix-key.pem")}"
        }
    }
    user_data   = "${data.template_file.init.rendered}"

    tags {
        Name = "ansible-master-VPC NAT"
    }
}