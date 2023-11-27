output "region" {
   value = var.region    
}


output "project-name" {
    value = var.aws-project  
}

output "vpc_id" {
   value = aws_vpc.prd-aws-1.id    
}

output "public-subnet-az1" {
   value = aws_subnet.aws-prd-public-subnet-1.id 
}    

output "pvt-app-subnet-az1" {
   value =  aws_subnet.aws-pvt-app-subnet-1.id 
   }    

output "pvt-data-subnet-1" {
   value = aws_subnet.private_data_subnet_az1
}    



