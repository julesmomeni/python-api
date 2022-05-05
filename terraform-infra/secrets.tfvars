# copy this file to secrets.tfvars and add your own secrets
# never commit the actual secrets.tfvars file
aws-access-key = "myAWSAccessKey"
aws-secret-key = "myAWSSecret"
application-secrets = {
  "SOLARIS_WEBHOOK_SECRET"   = "my-solaris-webhook-secret"
  "DYNAMO_DB_KEY"            = "my-dynamo-db-key"
  "DYNAMO_DB_SECRET"         = "my-dynamo-db-secret"
  "API_KEY_X" = "my-api-key"
}

