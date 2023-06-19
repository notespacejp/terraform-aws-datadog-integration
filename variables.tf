variable "role_name" {
    type = string
    description = "aws role name"
    default = "DatadogAWSIntegrationRole"
}

variable "policy_name" {
    type = string
    description = "aws policy name"
    default = "DatadogAWSIntegrationPolicy"
}

variable "dd_account_ids" {
    type = list(string)
    description = "Datadog aws account ids (Default: AP1 AWS account ids)"
    default = [
        "464622532012",
        "417141415827",
    ]
}