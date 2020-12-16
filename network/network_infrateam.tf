
# Tenant Definition
resource "aci_tenant" "production_tenant" {
  # Note the names cannot be modified in ACI, use the name_alias instead
  # The name becomes the distinguished named with the model, this is the reference name
  # The model can be deployed A/B if the name, aka the model, must change
  name        = "production_tenant"
  name_alias  = "production_tenant"
  description = "This tenant is created by terraform ACI provider"
}

resource "aci_vrf" "prod_vrf" {
  tenant_dn              = aci_tenant.production_tenant.id
  name                   = "prod_vrf"
}


resource "aci_bridge_domain" "production_bd" {
  tenant_dn   = aci_tenant.production_tenant.id
  name        = "production_bd"
  description = "This bridge domain is created by terraform ACI provider"
}

resource "aci_subnet" "prodsubnet" {
  parent_dn                           = aci_bridge_domain.production_bd.id
  ip                                  = "10.0.0.1/16"
  scope                               = ["private"]
  description                         = "This subject is created by terraform"
  ctrl                                = ["nd"]
  preferred                           = "no"
  virtual                             = "yes"
}


# Tenant Definition
resource "aci_tenant" "development_tenant" {
  # Note the names cannot be modified in ACI, use the name_alias instead
  # The name becomes the distinguished named with the model, this is the reference name
  # The model can be deployed A/B if the name, aka the model, must change
  name        = "development_tenant"
  name_alias  = "development_tenant"
  description = "This tenant is created by terraform ACI provider"
}

resource "aci_vrf" "dev_vrf" {
  tenant_dn              = aci_tenant.development_tenant.id
  name                   = "dev_vrf"
}


resource "aci_bridge_domain" "development_bd" {
  tenant_dn   = aci_tenant.development_tenant.id
  name        = "dev_bd"
  description = "This bridge domain is created by terraform ACI provider"
}

resource "aci_subnet" "devsubnet" {
  parent_dn                           = aci_bridge_domain.development_bd.id
  ip                                  = "10.0.0.1/16"
  scope                               = ["private"]
  description                         = "This subject is created by terraform"
  ctrl                                = ["nd"]
  preferred                           = "no"
  virtual                             = "yes"
}