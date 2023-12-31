

# Terraform Beginner Bootcamp 2023 - Week 0

## Table of Contents

- [Semantic Versioning ](#semantic-versioning)
- [Install The Terraform CLI](#install-the-terraform-cli)
   * [Considerations For Linux Distribution](#considerations-for-linux-distribution)
   * [Refactoring Into Bash Scripts](#refactoring-into-bash-scripts)
      + [Shebang Considerations](#shebang-considerations)
      + [Execution Considerations](#execution-considerations)
      + [Linux Permission Considerations](#linux-permission-considerations)
- [GitPod Lifecycle (Before, Init, Command)](#gitpod-lifecycle-before-init-command)
- [Working Env Vars](#working-env-vars)
      + [env command](#env-command)
      + [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
      + [Printing Vars](#printing-vars)
      + [Scoping of Env Vars](#scoping-of-env-vars)
      + [Persisting Env vars in Gitpod](#persisting-env-vars-in-gitpod)
   * [AWS CLI INSTALLATION](#aws-cli-installation)
- [Terraform Basics ](#terraform-basics)
   * [Terraform Registry](#terraform-registry)
   * [Terraform Console](#terraform-console)
       + [Terraform Init](#terraform-init)
       + [Terraform Plan](#terraform-plan)
       + [Terraform Apply](#terraform-apply)
       + [Terraform Destroy ](#terraform-destroy)
       + [Terraform Lock Files](#terraform-lock-files)
       + [Terraform state files](#terraform-state-files)
       + [Terraform Directory](#terraform-directory)
       + [Terraform Providers](#terraform-providers)
- [Issues with Terraform cloud login and Gitpod workspaces](#issues-with-terraform-cloud-login-and-gitpod-workspaces)

<!-- TOC end -->

## Semantic Versioning 

This project is going to utilize semantic versioning for its tagging.
[semver. org](https://semver.org/)

The format

**MAJOR.MINOR.PATCH**, eg `1.0.1`


– **MAJOR** version when you make incompatible API changes

– **MINOR**version when you add functionality in a backward-compatible manner

– **PATCH** version when you make backwards compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Install The Terraform CLI

The terraform installation instructions have changed due to the gpg keyring changes. So we referred to the latest Install CLI instructions via the terraform documentation and changed the scripting to install.

[Install the Terraform CLI] (https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations For Linux Distribution

This project is built against Ubuntu. Please check your distribution and change it according to your distribution needs

[How to check OS Version in Linux] (https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

### Refactoring Into Bash Scripts

While fixing the terraform gpg deprecation issues, we noticed the installation steps were a considerable amount of mono code. So we decided to create a bash script to install the Terraform CLI. 

This bash script is located here [./bin/install_terraform_cli.sh](./bin/install_terraform_cli.sh)

- This will keep the GitPod task files([gitpod.yml] (.gitpod.yml)) tidy and 
- This will allow us an easier  time to debug and execute manually Terraform CLI Install
- This will allow better portability for other projects that need to Install Terraform CLI
https://linuxhandbook.com/shebang/


#### Shebang Considerations

A Shebang tells the bash script what INterpreter will Interpret the script.

Chat GPT recommended this code for bash
```sh
#!/usr/bin/env bash
```
- For Portability for different OS distributions.
- Will search the user's PATH for the bash executable 


https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations

When executing the bash script, we can use the '/' shorthand  notation

eg `./bin/install_terraform_cli`

If we are using a script in 'gitpod.yml' we need to point the script to a program to interpret it. 

eg `source ./bin/install_terraform_cli`


#### Linux Permission Considerations

In order to make our bash scripts executable, we need to change linux permissions for the fix to be executable in the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively, 

```sh
chmod 744 ./bin/install_terraform_cli
```
We need to make these permissions as follows

https://www.redhat.com/sysadmin/linux-file-permissions-explained


## GitPod Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we start an existing workspace. 

https://en.wikipedia.org/wiki/chmod

https://www.gitpod.io/docs/configure/workspaces/tasks


## Working Env Vars

#### env command

We can list all the Environment variables using the `env` command

We can filter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal, we can set using `export HELLO= 'WORLD'`

In the terminal, we unset using `unset HELLO`

We can set an env var temporarily when just running a command 


```sh
HELLO='World' ./bin/print_message
```

Within a bash script, we can set an env without writing export eg.

```sh
#!/usr/bin/env bash
HELLO='World'

echo $HELLO
```

#### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open up new bash terminals in vscode, it will not be aware of ENV vars you have set in another window.

If you want env vars to persist across all future bash terminals that are open, you need to set env vars in your bash profile. eg `.bash_profile`

#### Persisting Env vars in Gitpod

We can process env vars in Gitpod by storing them in Gitpod Secrets Storage

```
gp env HELLO='World'
```

All future workspaces launched will set the env for all bash terminals open in those workspaces.

You can also set env vars in the 'gitpod.yml' but this can only contain non-sensitive env vars.

### AWS CLI INSTALLATION

Aws Cli is installed for this project via the bash script []`./bin/install_aws_cli`] (./bin/install_aws_cli)

[Getting Started](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)


[AWS CLI ENV VARS](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

[AWS configure CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS Credentials are configured correctly by running the following AWS CLI command

```sh
aws sts get-caller-identity
```
If it is successful, you should see a json payload return that looks like this 

```json
{
    "UserId": "AIDAS3KLTZM2BEOEXAMPE",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```
We would need to generate AWS CLI Credits from IAM User in order to the user AWS CLI.

## Terraform Basics 

### Terraform Registry

Terraform sources provide their providers and modules from the terraform repository which is located at [registory.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that allows you to create resources in Terraform. They are responsible for understanding API interactions and exposing resources.
- **Modules**  Modules are self-contained packages of Terraform configurations that are managed as a group.

### Terraform Console

We can see a list of all the terraform commands by simply typing `terraform`.

### Terraform Init

`terraform init`
At the start of a terraform project, we will run `terraform init`. to download the binaries that we'd use in the terraform project.
[](https://registry.terraform.io/providers/hashicorp/random/)

### Terraform Plan

`terraform plan`
This will generate a changeset about the state of our infrastructure and what will be changed. 
We can output this changeset ie. "plan" to be passed to an apply, but you can just ignore outputting. 

### Terraform Apply

`terraform apply`
This will run a plan and pass the changeset to be executed by Terraform. This should prompt `yes or no`. If we want to automatically approve the auto approve flag eg. `terraform apply --auto-approve`

### Terraform Destroy 

This will destroy resources.
You can also use the `--auto-approve` flag to skip the approve part.
eg. `terraform destroy --auto-approve`

### Terraform Lock Files

`terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with the project. 
The terraform lock file **should** be committed to your Github.

### Terraform state files

`terraform.tfstate` contains information about the current state of your infrastructure. 

This file **should not** be committed to your GitHub. This file can contain sensitive data. If you lose this file, you lose knowing the state of your infrastructure. 

`terraform.tfstate.backup` is the previous state of the files

### Terraform Directory

`.terraform` directory contains binaries of different terraform providers.

### Terraform Providers

You should not have more than one Terraform Provider Block. You can have more than one `required provider` block in the terraform provider block though.

- You need to follow the guidelines for the S3 bucket naming conditions so you don't end up with a number of errors.

## Issues with Terraform cloud login and Gitpod workspaces

When attempting to run `terraform login`, it will ask you to generate a token. You need to look out and carefully input the value. Or you can manually create and generate a token and store it in a manually created file.

```
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Place your token in the file and save

```json
{
   "credentials": {
    "app.terrafoform.io" : { 
        token: "YOUR-TERRAFORM-TOKEN"
    }
   }
}
```
We have automated this workaround with the following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)
