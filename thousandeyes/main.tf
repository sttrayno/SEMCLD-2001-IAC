provider_installation {
  filesystem_mirror {
    path = "/usr/local/bin"
  }
}


terraform {
  required_providers {
    thousandeyes = {
      source  = "william20111/thousandeyes"
    }
  }
  required_version = ">= 0.13"


}

provider "thousandeyes" {
  token = "xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx"
}
