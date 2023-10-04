locals {
  config = {
    name                  = aws_eks_cluster.control_plane.name
    endpoint              = aws_eks_cluster.control_plane.endpoint
    ca_data               = aws_eks_cluster.control_plane.certificate_authority[0].data
    vpc_id                = var.vpc_config.vpc_id
    private_subnet_ids    = var.vpc_config.private_subnet_ids
    node_security_group   = aws_eks_cluster.control_plane.vpc_config.0.cluster_security_group_id
    node_instance_profile = var.iam_config.node_role
    tags                  = var.tags
    aws_ebs_csi_driver    = var.aws_ebs_csi_driver
  }
}

output "config" {
  value = local.config
}

output "oidc_config" {
  value = {
    url       = aws_iam_openid_connect_provider.cluster_oidc.url
    arn       = aws_iam_openid_connect_provider.cluster_oidc.arn
    condition = "${replace(aws_iam_openid_connect_provider.cluster_oidc.url, "https://", "")}:sub"
  }
}
output "iamconfig" {
  value = {
    service_role = aws_iam_role.eks_service_role.name
    node_role    = aws_iam_role.eks_node.name
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node,
    aws_iam_role_policy_attachment.eks_cni,
    aws_iam_role_policy_attachment.ecr,
    aws_iam_role_policy_attachment.eks_service_policy,
    aws_iam_role_policy_attachment.eks_cluster_policy,
  ]
}