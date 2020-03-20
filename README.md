# POC-Project

Assignment-Syncron

This is a submission as part of the interview assignment for Syncron. Here, there is an AWS API gateway available that taken inputs from users for *InstanceType* and fetches AWS RDS instance details *Endpoint and Instance type*.

Behind the scenes, there are 2 Lambda functions that perform the heavy lifting.

1. lambda-1 *-->* fetches AWS RDS details and updates in dynamoDB table scheduled to run every 5 minutes
2. lambda-2 --> Works as the API gateway backend to fetch details from dynamoDB backend based on the input provided by the user


```
Structure of the terrafrom files
```
```
api.tf
dynamoDB.tf
Jenkinsfile
lambda-api
    lambda_handler.py
    lambda_handler.zip
lambda_handler.py
lambda_handler.zip
lambda.tf
plan.txt
provider.tf
rds.tf
terraform.tfstate
terraform.tfstate.backup
variable.tf
```

## Contributing
Pull requests are welcome. 
