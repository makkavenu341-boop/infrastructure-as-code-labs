output "vpc1" {
    value = aws_vpc.vpc1
  
}
output "rt1" {
    value = aws_route_table.rt1[*].id
  
}