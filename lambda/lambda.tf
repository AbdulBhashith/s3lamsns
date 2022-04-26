resource "aws_iam_role" "iam_for_lambda" {
  name = var.lambda_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

#Policies
resource "aws_iam_role_policy" "role_policy" {
  name = var.lambda_iam_policy_name
  role = aws_iam_role.lambda_iam.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*",
        "ses:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

#Finallly Lambda function
resource "aws_lambda_function" "test_lambda1" {
  filename      = "./location"
  function_name = var.function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.test"
  source_code_hash = filebase64sha256("./location")
  runtime = var.runtime

  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_lambda_function" "test_lambda2" {
  filename      = "./location"
  function_name = var.function2_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.test"
  source_code_hash = filebase64sha256("./location")
  runtime = var.runtime2

  environment {
    variables = {
      foo = "bar"
    }
  }
}
