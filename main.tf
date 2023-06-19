terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.0"
        }
        datadog = {
            source = "DataDog/datadog"
            version = "~> 3.0"
        }
    }
}

data "aws_caller_identity" "this" {}

resource "datadog_integration_aws" "this" {
    account_id = data.aws_caller_identity.this.account_id
    role_name = var.role_name
}

data "aws_iam_policy_document" "assume_role" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type = "AWS"
            identifiers = [for s in var.dd_account_ids : format("arn:aws:iam::%s:root", s)]
        }

        condition {
            test = "StringEquals"
            variable = "sts:ExternalId"

            values = [
                datadog_integration_aws.this.external_id
            ]
        }
    }
}

data "aws_iam_policy_document" "permissions" {
    statement {
        actions = [
            "apigateway:GET",
            "autoscaling:Describe*",
            "backup:List*",
            "budgets:ViewBudget",
            "cloudfront:GetDistributionConfig",
            "cloudfront:ListDistributions",
            "cloudtrail:DescribeTrails",
            "cloudtrail:GetTrailStatus",
            "cloudtrail:LookupEvents",
            "cloudwatch:Describe*",
            "cloudwatch:Get*",
            "cloudwatch:List*",
            "codedeploy:List*",
            "codedeploy:BatchGet*",
            "directconnect:Describe*",
            "dynamodb:List*",
            "dynamodb:Describe*",
            "ec2:Describe*",
            "ecs:Describe*",
            "ecs:List*",
            "elasticache:Describe*",
            "elasticache:List*",
            "elasticfilesystem:DescribeFileSystems",
            "elasticfilesystem:DescribeTags",
            "elasticfilesystem:DescribeAccessPoints",
            "elasticloadbalancing:Describe*",
            "elasticmapreduce:List*",
            "elasticmapreduce:Describe*",
            "es:ListTags",
            "es:ListDomainNames",
            "es:DescribeElasticsearchDomains",
            "events:CreateEventBus",
            "fsx:DescribeFileSystems",
            "fsx:ListTagsForResource",
            "health:DescribeEvents",
            "health:DescribeEventDetails",
            "health:DescribeAffectedEntities",
            "kinesis:List*",
            "kinesis:Describe*",
            "lambda:GetPolicy",
            "lambda:List*",
            "logs:DeleteSubscriptionFilter",
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams",
            "logs:DescribeSubscriptionFilters",
            "logs:FilterLogEvents",
            "logs:PutSubscriptionFilter",
            "logs:TestMetricFilter",
            "organizations:Describe*",
            "organizations:List*",
            "rds:Describe*",
            "rds:List*",
            "redshift:DescribeClusters",
            "redshift:DescribeLoggingStatus",
            "route53:List*",
            "s3:GetBucketLogging",
            "s3:GetBucketLocation",
            "s3:GetBucketNotification",
            "s3:GetBucketTagging",
            "s3:ListAllMyBuckets",
            "s3:PutBucketNotification",
            "ses:Get*",
            "sns:List*",
            "sns:Publish",
            "sqs:ListQueues",
            "states:ListStateMachines",
            "states:DescribeStateMachine",
            "support:DescribeTrustedAdvisor*",
            "support:RefreshTrustedAdvisorCheck",
            "tag:GetResources",
            "tag:GetTagKeys",
            "tag:GetTagValues",
            "xray:BatchGetTraces",
            "xray:GetTraceSummaries"
        ]
        resources = ["*"]
    }
}


resource "aws_iam_policy" "this" {
    name = var.policy_name
    policy = data.aws_iam_policy_document.permissions.json
}

resource "aws_iam_role" "this" {
    name = var.role_name
    description = "Role for Datadog AWS Integration"
    assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "this" {
    role = aws_iam_role.this.name
    policy_arn = aws_iam_policy.this.arn
}
