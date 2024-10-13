terraform {
  backend "s3" {

    bucket = "tf-storage-starting-stopping-ec2-instances"

    key = ""

    region = "us-east-1"
  }
}