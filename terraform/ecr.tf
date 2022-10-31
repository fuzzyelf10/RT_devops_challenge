resource "aws_ecr_repository" "python_app" {
  name                 = "python-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  provisioner "local-exec" {
    working_dir = "../"
    command = <<-EOT
      docker build -t python-app .
      aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com
      docker tag python-app:latest $ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/python-app:latest  
      docker push $ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/python-app:latest    
    EOT

    environment = {
      ACCOUNT_ID = data.aws_caller_identity.current.account_id
    }
  }
}

