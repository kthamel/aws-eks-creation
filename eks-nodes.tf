resource "aws_iam_role" "kthamel-eks-nodes-iam-role" {
  name = "kthamel-eks-nodes-iam-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "eks.amazonaws.com",
            "ec2.amazonaws.com"
          ]
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "kthamel-eks-node-iam-role-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.kthamel-eks-nodes-iam-role.name
}

resource "aws_iam_role_policy_attachment" "kthamel-eks-ecr-iam-role-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.kthamel-eks-nodes-iam-role.name
}

resource "aws_iam_role_policy_attachment" "kthamel-eks-cni-iam-role-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.kthamel-eks-nodes-iam-role.name
}

resource "aws_eks_node_group" "master-nodes" {
  cluster_name    = aws_eks_cluster.kthamel-eks-cluster.name
  node_group_name = "controler-nodes"
  node_role_arn   = aws_iam_role.kthamel-eks-nodes-iam-role.arn

  subnet_ids = [
      "subnet-018bc20e7d040c324",
      "subnet-01a00135b18b64a72"
    ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.medium"]
  scaling_config {
    desired_size = 2
    min_size     = 0
    max_size     = 3
  }
  update_config {
    max_unavailable = 1
  }
  labels = {
    node_type = "controlplane"
  }

  tags = local.common_tags
}

resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.kthamel-eks-cluster.name
  node_group_name = "worker-nodes"
  node_role_arn   = aws_iam_role.kthamel-eks-nodes-iam-role.arn

  subnet_ids = [
      "subnet-018bc20e7d040c324",
      "subnet-01a00135b18b64a72"
    ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.medium"]
  scaling_config {
    desired_size = 2
    min_size     = 0
    max_size     = 3
  }
  update_config {
    max_unavailable = 1
  }
  labels = {
    node_type = "workers"
  }

  tags = local.common_tags
}
