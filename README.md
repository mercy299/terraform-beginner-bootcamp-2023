# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The format

**MAJOR.MINOR.PATCH**, eg `1.0.1`


– **MAJOR** version when you make incompatible API changes

– **MINOR**version when you add functionality in a backward compatible manner

– **PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Install The Terraform CLI

The terraform installation instruction have changed due to the gpg keyring changes. So we referred to the lateest Install CLI instructions via the terraform documentation and changed the scripting to install.

[Install the Terraform CLI] (https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations For Linux Distribution

This project is built agains Ubuntu. Please check your distribution and change according to your distribution needs

[How to check OS Version in Linux] (https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

### Refractoring Into Bash Scripts

While fixing the terrafor gpg deprecation issues, we noticed the installation steps were a considerable amount of mono code. So we decided to create a bash script to install the Terraform CLI. 

This bash script is located here [./bin/install_terraform_cli.sh](./bin/install_terraform_cli.sh)

- This will keep the GitPod task files([gitpod.yml] (.gitpod.yml)) tidy and 
- This will allow us an easier  time to debug and execute manually Terraform CLI Install
- This will allow better portability for other projects that need to Install Terraform CLI
https://linuxhandbook.com/shebang/


#### Shebang Considerations

A Shebang tells the bash script what INterpreter will Interprete the script.

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

If we are using a script in 'gitpod.yml' in we need to point the script to a program to interprete it. 

eg `source ./bin/install_terraform_cli`


#### Linux Permission Considerations

In order to make our bash scripts executable, we need to change linux permissions for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively, 

```sh
chmod 744 ./bin/install_terraform_cli
```
We need to make these permissions as follows

https://www.redhat.com/sysadmin/linux-file-permissions-explained


### GitHub Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we start an existing workspace. 

https://en.wikipedia.org/wiki/chmod

https://www.gitpod.io/docs/configure/workspaces/tasks