terraform {
  required_providers {
    intersight = {
      source = "ciscodevnet/intersight"
    }
    aci = {
      source = "ciscodevnet/aci"
    }
  }
  required_version = ">= 0.13"
}

# Configure provider with your Cisco ACI credentials
provider "aci" {
  # Cisco ACI user name
  username = "admin"
  # Cisco ACI password
  password = "C1sco12345"
  # Cisco ACI URL
  url      = "https://10.10.20.14"
  insecure = true
}

