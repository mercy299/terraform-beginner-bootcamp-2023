## TerraHomoe aws

```tf
module "home_afang" {
  source = "./Modules/terrahome_aws"
  user_uuid= var.teacherseat_user_uuid
  public_path = var.afang_public_path
  content_version = var.content_version
}
```

The public directory expects the following: 
- index.html
- error.html
- assets

All top level files will be copied, but not any subdirectories.