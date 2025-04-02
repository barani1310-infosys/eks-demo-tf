resource "aws_eks_cluster" "Example" {
  name     = "eks_cluster"
  role_arn = aws_iam_role.example.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.my_pubsubnet.id,
      aws_subnet.my_prisubnet.id,
    ]
  }
}

# IAM role for eks

resource "aws_iam_role" "example" {
  name = "eks-cluster-example"

  tags = {
    tag-key = "eks-cluster-demo"
  }

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "eks.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

# resource "aws_iam_role" "example" {
#   name = "eks-cluster-example"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Effect = "Allow",
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.example.name
}

resource "aws_eks_node_group" "nodes" {
  cluster_name    = aws_eks_cluster.Example.name
  node_group_name = "EKS-nodes"
  node_role_arn   = aws_iam_role.example.arn
  subnet_ids     = [aws_subnet.my_pubsubnet.id, aws_subnet.my_pubsubnet_1.id]
  #instance_types  = var.instance_type

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
}

resource "aws_launch_template" "my_launch_template" {
  name_prefix = var.name_prefix
  image_id    = var.image_id # Specify your desired AMI ID
  instance_type = var.instance_type # Specify your desired instance type
  key_name    = var.key_name   # Specify your SSH keypair
}

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  #   depends_on = [
  #     aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
  #     aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
  #     aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  #   ]
