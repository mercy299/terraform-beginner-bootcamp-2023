# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing Tags

[How to delete alaocal and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Locally delete a tag
```sh
git tag -d <tag_name>
```
Remotely delete a tag
```sh
git push --delete origin tagname
```

Checkout the commit that you want to retag. Grab the sha from your Github history

```
git checkout <SHA>
git tag M.M.A
git push --tags
git checkout main
```

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

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only --auto-aprove
```

## Terraform Modules 

### Terraform Modules Structure

It is recomended to place modules in a `modules directory` when locally developing modules. But you can name it whatever you like

### Passing Input Variables

We can pass input variables to our modules.
The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./Modules/terrahouse_aws"
  user_uuid= var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source, we can import the module from various places, eg: 
- Locally
- GitHub
- Terraform Registory

```tf
module "terrahouse_aws" {
  source = "./Modules/terrahouse_aws"
}
```

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when usng ChatGPT to write Terraform

LLMs such as ChatGPT may not be trained on the latest documentation or information about terraform. 
It might likely produce older examples that could be deprecated. Often affecting providers

## Working with Files in Terraform

### Fileexists Function

This is a built in terrafofrm function to check the existance of a file.

```tf
  condition = fileexists(var.error_html_filepath)
```

https://developer.hashicorp.com/terraform/language/functions/fileexists

### Filemd5

https://developer.hashicorp.com/terraform/language/functions/filemd5

### Path Variable

In Terraform, there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressinon/references#filesystem-and-workspace-info)

```tf
resource "aws_s3_object" "index_html" {
    bucket = aws_s3_bucket.website_bucket.bucket
    key = "index.html"
    source = "${path.root}/public/index.html"
}
```

## Terraform Locals

Locals allow us to define local variables. 
It can be very useful when we need to transform data into another formatand have it referenced as a variable.
```tf
locals {
  s3_origin_id = "Mys3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)
## Terraform Data Sources

This allows us to source data from cloud resources.

This is useful when we want to reference cloud resources without importing them. 

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-source)

## Working with Json

We use the jsonencode to create the json policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```
[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the Lifecycle of Resources

[Meta Arguments lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

### Terraform Data 

Plain data values such as local values and input variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behaviour of planning an action each time input changes to indirectly use a plain value to trigger replacement.
[](https://developer.hashicorp.com/terraform/language/resources/terraform-data)