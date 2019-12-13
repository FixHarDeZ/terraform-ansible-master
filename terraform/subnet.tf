resource "aws_subnet" "ap-southeast-1a-public" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "ap-southeast-1a"

    tags {
        Name = "ansible-master-Public Subnet"
    }
}

resource "aws_subnet" "ap-southeast-1a-private" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "ap-southeast-1a"

    tags {
        Name = "ansible-master-Private Subnet"
    }
}