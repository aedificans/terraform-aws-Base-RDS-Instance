resource "aws_security_group" "this" {
  name        = local.naming.resource
  description = "Security Group for ${local.naming.display} DB"
  vpc_id      = var.networking.vpc_id

  tags = merge(
    local.tags,
    tomap({ "Name" = "${local.naming.display} RDS Security Group" })
  )
}

#=======#
# Rules #
#=======#

resource "aws_security_group_rule" "ingress_security_group_ids" {
  for_each = var.networking.ingress_security_group_ids

  security_group_id        = aws_security_group.this.id
  description              = each.value.description
  type                     = "ingress"
  from_port                = coalesce(each.value.port, var.networking.port)
  to_port                  = coalesce(each.value.port, var.networking.port)
  protocol                 = each.value.protocol
  source_security_group_id = each.value.security_group_id
}
resource "aws_security_group_rule" "ingress_cidr_blocks" {
  for_each = var.networking.ingress_cidr_blocks

  security_group_id = aws_security_group.this.id
  description       = each.value.description
  type              = "ingress"
  from_port         = coalesce(each.value.port, var.networking.port)
  to_port           = coalesce(each.value.port, var.networking.port)
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
}
resource "aws_security_group_rule" "egress" {
  for_each = var.networking.egress_cidr_blocks

  security_group_id = aws_security_group.this.id
  description       = each.value.description
  type              = "egress"
  from_port         = coalesce(each.value.port, var.networking.port)
  to_port           = coalesce(each.value.port, var.networking.port)
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
}
