variable "instances" {
    default = ["mysql", "backend", "frontend"]
  
}

variable "zone_id" {
    default = "Z08625042U0IMS33AVUS6"
  
}

variable "domain_name" {
    default = "algot.online"
  
}

variable "common_tags" {
    type = map
    default = {
        project = "expense"
        Environment = "dev"
    }
  
}