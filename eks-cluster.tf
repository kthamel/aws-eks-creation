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
  role_arn = aws_iam_role.kthamel-eks-cluster-iam-role.arn

  vpc_config {
    subnet_ids = [
      "subnet-0ebbeb2b84570d2bb",
      "subnet-0a0d8037b2051a470",
      "subnet-025d011a84e801ae7",
      "subnet-0dedaaf475b652bdc"
    ]
  }
  depends_on = [aws_iam_role_policy_attachment.kthamel-eks-cluster-iam-role-policy]
}
