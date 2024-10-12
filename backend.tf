terraform {
  backend "s3" {
    bucket = "kthamel-terrafeorm-states"
    key    = "eks-tfstate"
    region = "us-east-1"
  }
}
