resource "aws_vpc_peering_connection" "peer" {
  vpc_id      = var.vpc_id_1
  peer_vpc_id = var.vpc_id_2
  auto_accept = true

  tags = {
    Name = "${var.resourceName}-peering"
  }
}

resource "aws_route" "route_1_to_2" {
  route_table_id            = var.aws_route_table_1
  destination_cidr_block    = var.vpc_cidr_block_2
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route" "route_2_to_1" {
  route_table_id            = var.aws_route_table_2
  destination_cidr_block    = var.vpc_cidr_block_1
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}