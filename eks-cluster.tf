resource "aws_iam_role" "kthamel-eks-cluster-iam-role" {
  name               = "kthamel-eks-cluster-iam-role"
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "sts:AssumeRole"
            ],
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "eks.amazonaws.com",
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
} 
  POLICY

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "kthamel-eks-cluster-iam-role-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.kthamel-eks-cluster-iam-role.name
}

resource "aws_eks_cluster" "kthamel-eks-cluster" {
  name     = "kthamel-eks-cluster"
  platform_version = "1.31"
  role_arn = aws_iam_role.kthamel-eks-cluster-iam-role.arn

  vpc_config {
    subnet_ids = [
      "subnet-018bc20e7d040c324",
      "subnet-01a00135b18b64a72"
    ]
  }
  depends_on = [aws_iam_role_policy_attachment.kthamel-eks-cluster-iam-role-policy]
}
