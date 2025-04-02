terraform {
  backend "s3" {
    bucket = "aprbucketeks"
    key = "demo/terraform.tfstate"
    region = "ap-south-1"
    
  }
}