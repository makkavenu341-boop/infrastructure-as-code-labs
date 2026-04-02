variable "infra" {
    type = object({
      vpc_name = string
      vpc_cidr = string 
      sub_info = object({
        sub_cidr =list(string)
        sub_az = list(string)
        sub_name = list(string) 
      })
    })
    default = {
      vpc_name = "my-vpc1"
      vpc_cidr = "10.0.0.0/16"
      sub_info = {
        sub_cidr = ["10.0.0.0/24","10.0.1.0/24","10.0.2.0/24"]
        sub_az = ["ap-south-2a","ap-south-2b","ap-south-2c"]
        sub_name = ["v1s1","v1s2","v1s3"]
      }
    }
  
}