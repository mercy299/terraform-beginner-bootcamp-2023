terraform {
    required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  # backend "remote" {
  #   hostname = "app.terraform.io"
  #   organization = "Altschool"

  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }
  # cloud {
  #   organization = "Altschool"
  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }

}
provider "terratowns" {
  endpoint = var.terratowns_endpoint
  # endpoint = "https://terratowns.cloud/api"
  # user_uuid="ad4757c3-a0a6-4459-bd4e-2983f2538e8c" 
  user_uuid = var.teacherseat_user_uuid
  token=var.terratowns_access_token
}

module "terrahouse_aws" {
  source = "./Modules/terrahouse_aws"
  user_uuid= var.teacherseat_user_uuid
  # bucket_name = var.bucket_name
  error_html_filepath = var.error_html_filepath
  index_html_filepath = var.index_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

# module "terrahouse_aws" {
#   source = "./Modules/terrahouse_aws"
#   user_uuid = var.user_uuid
#   bucket_name = var.bucket_name
#   index_html_filepath = var.index_html_filepath
#   error_html_filepath = var.error_html_filepath
#   content_version = var.content_version
# }

# resource "terratowns_home" "home" {
#   name = "How to play Arcanum in 2023!"
#   description = <<DESCRIPTION
# Arcanum is a game from 2001 that shipped with alot of bugs.
# Modders have removed all the originals making this game really fun
# to play (despite that old look graphics). This is my guide that will
# show you how to play arcanum without spoiling the plot.
# DESCRIPTION
#   domain_name = module.terrahouse_aws.cloudfront_url
#   # domain_name = "3fdq3gz.cloudfront.net"
#   town = "missingo"
#   content_version = 1
# }

resource "terratowns_home" "home" {
  name = "Slyvan Esso"
  description = <<DESCRIPTION
Sylvan Esso is an American electronic pop duo from Durham, North Carolina which was formed in 2013.
The band consists of singer Amelia Meath (born July 2, 1988) and producer Nick Sanborn (born March 8, 1983). 
They made their debut with the single "Hey Mami" and 
released their eponymous debut album on Partisan Records on May 12, 2014. 
It reached No. 39 on the Billboard 200. 
They released their second album, What Now, with Loma Vista Recordings on April 28, 2017, 
which was nominated for a Grammy Award for Best Dance/Electronic Album.[2]
On August 12, 2022, Sylvan Esso released their fourth studio album, 
No Rules Sandy, to positive reviews on their Psychic Hotline label.[3]
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  # domain_name = "3fdq3gz.cloudfront.net"
  town = "missingo"
  content_version = 1
}