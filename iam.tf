data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "lambda_log_data_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name                = var.iam_role_name
  assume_role_policy  = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "lambda_log_policy" {
  name                = var.iam_policy_name
  path                = "/"
  description         = var.iam_policy_description
  policy              = data.aws_iam_policy_document.lambda_log_data_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_log_policy.arn
}