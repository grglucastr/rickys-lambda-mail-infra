variable "region" {
  default     = "us-east-1"
}

variable "lambda_function_name" {
  default     = "rickys-lambda-mail"
}

variable "iam_role_name" {
  default     = "iam_for_lambda_rickys_mail"
}

variable "iam_policy_name" {
  default     =  "lambda_log_policy"
}

variable "iam_policy_description" {
  default     = "IAM policy for logging from a lambda"
}

variable "lambda_output_file" {
  default     = "lambda_function_payload.zip"
}

variable "nodejs_runtime" {
  default = "nodejs18.x"
}

variable "cors_allow_origins" {
  type = list(string)
  default = [ "*" ] 
}

variable "cors_allow_methods" {
  type = list(string)
  default = [ "POST" ] 
}
