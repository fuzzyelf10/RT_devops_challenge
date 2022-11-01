# RT_devops_challenge

To build this project, Pls have docker and terraform installed. use AMD64 cpu type.

Run the following commands afrer exporting your AWS credentials

`terraform init`

`terraform plan`

`terraform apply`

Access load balancer URL from the output `alb_url` and then access the URL on port 5000

<ALB_URL>:5000/status