
# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our Root Module Structure is as follows:

```
- PROJECT ROOT
  |- main.tf             # everything else
  |- variables.tf        # stores the structure of input variables
  |- providers.tf        # defined required providers and their configuration
  |- terraform.tfvars    # the data of variables we want to load into our Terraform project
  |- output.tf           # stores our output
  |- README.md           # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

## Terraform Cloud Variables 

In terraform we can set two kind of variables:
- Environment Variables - those that you would set in your bash terminal eg AWS
- Terraform Variables - those that you would set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibly in the UI

### Loading  Terraform Input Variables

[Terraform Input Variables
](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an intput variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag

- TODO: research this flag

### terraform.tfvars

This is the default file to load in terraform variables in blunk

### auto.tfvars

- TODO: research this flag. document it for terraform cloud

### order of terraform variables

- TODO: research this flag. document which terraform variables take prescedence

## Dealing with configuration Drift

## What hapens if we lose our state files?

If you lose your statefiles, you most likely have to tear down your cloud infrastructure manually.

You can use terraform iport but it won't work for all cloud resouces. You need to check the terraform providers documentation for which resources support import.

### Fix missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket_name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

[AWS S3 Bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and deletes or modifies cloud resources manually through clickOps.
If we run terraform plan, It will attempt to put our infrastructure back into the expected state fixing our configuration drift. 