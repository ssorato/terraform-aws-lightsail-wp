# Create a Wordpress site in AWS LightSail

Create a Wordpress site running in AWS LightSail. The access is limited from current external ip.

# Tip

Save the terraform state in a s3 bucket by creating a `backend.tf`

```tf
terraform {
  backend "s3" {
    bucket = "the-bucket-name"
    key    = "terraform-s3-static-website"
    region = "us-east-1"
  }
}
```