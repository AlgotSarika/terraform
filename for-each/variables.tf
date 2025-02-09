variable "instances" {
    type = map  
    default = {
        mysql = "t3.small"
        backend = "t3.micro"
        frontend = "t3.micro"
    }
  
}

variable "domain_name" {
    default = "algot.online"
  
}

variable "zone_id" {
    default = "Z08625042U0IMS33AVUS6"
  
}