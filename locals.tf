locals {

  vpc_id = data.aws_ssm_parameter.vpc_id.value


  # split functionality -> divides a single string into a list of substrings based on a specified separator, below one best example, converting that single string into 2 sub strings, taking the first one 😁
  #minimum , there should be 2 subnet ids, that is below.
  private_subnet_id        = split(",", data.aws_ssm_parameter.private_subnet_ids.value)[0] # converted to list strings, and 0th index is 1 st one we need that, using it-> private subnet [zone.]
  private_subnet_ids       = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  
  #ami id and sg_id of components
  ami_id                   = data.aws_ami.joindevops.id #here i am getting ami_id through data sources-> data.tf[refer it]
  #component sg id ex - catalogue, user etc like that.
  sg_id          = data.aws_ssm_parameter.sg_id.value

  #arn
  backend_alb_listener_arn = data.aws_ssm_parameter.backend_alb_listener_arn.value
  frontend_alb_listener_arn = data.aws_ssm_parameter.frontend_alb_listener_arn.value
  

  #alb_listner_arn 
  alb_listener_arn = "${var.component}" == "frontend" ? local.frontend_alb_listener_arn : local.backend_alb_listener_arn

  #target port, already we know, from front end it should connect through 80, and for backend, microservices, port is 8080
  tg_port = "${var.component}" == "frontend" ? 80 : 8080
  # health check path, for front end / and for backened /health
  health_check_path = "${var.component}" == "frontend" ? "/" : "/health"

  #rule header
  rule_header_url = "${var.component}" == "frontend" ? "${var.environment}.${var.zone_name}" : "${var.component}.backend-${var.environment}.${var.zone_name}"


  #common tags
  common_tags = {
    Project     = var.project
    Environment = var.environment
    Terraform   = "true"
  }

}

