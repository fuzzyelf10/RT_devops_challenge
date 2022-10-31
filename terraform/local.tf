locals {
  data_userdata = <<EOF
#!/bin/bash
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt install unzip awscli docker-ce -y
sudo usermod -aG docker ubuntu
aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com
sudo docker run -it -p 5000:5000 -d --name my-running-app ${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com/python-app:latest
EOF
}
