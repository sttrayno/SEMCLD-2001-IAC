terraform {
  required_providers {
   intersight = {
      source = "ciscodevnet/intersight"
    }
  }
  required_version = ">= 0.13"
}

provider "intersight" {
  apikey    = "5ae6fc29766763397136ac70/5ae6fbfe766763397136ab51/5fbd15527564612d30c2c414"
  secretkeyfile = "secretKeyFile.txt"
  endpoint = "https://intersight.com"
}

