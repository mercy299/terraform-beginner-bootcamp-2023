
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