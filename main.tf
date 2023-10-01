terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "starter_code"
  output_path = var.lambda_output_file
}

resource "aws_lambda_function" "lambda_nodejs" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = var.lambda_output_file
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = var.nodejs_runtime

  environment {
    variables = {
      ENVIRONMENT = "production"
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_cloudwatch_log_group.lambda_log_group,
  ]
}

resource "aws_lambda_function_url" "lambda_url" {
  function_name      = aws_lambda_function.lambda_nodejs.function_name
  authorization_type = "NONE"
  cors {
    allow_origins     = var.cors_allow_origins
    allow_methods     = var.cors_allow_methods
  }
}