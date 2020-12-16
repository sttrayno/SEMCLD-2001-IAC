
# Variables
locals {
  vmm_vcenter        = "uni/vmmp-VMware/dom-My-vCenter"
  phys_db            = "uni/phys-phys"
}


# Prod App Profile Definition
resource "aci_application_profile" "production_phoenix_app" {
  tenant_dn  = aci_tenant.production_tenant.id
  name       = "phoenix_app_prod"
  name_alias = "phoenix_ap_prod"
  prio       = "level1"
  
}

# Dev App Profile Definition
resource "aci_application_profile" "development_phoenix_app" {
  tenant_dn  = aci_tenant.production_tenant.id
  name       = "phoenix_app_dev"
  name_alias = "phoenix_ap_dev"
  prio       = "level2"
}

# Prod environment EPG Definitions
resource "aci_application_epg" "prod_web" {
  application_profile_dn  = aci_application_profile.development_phoenix_app.id
  name                    = "web"
  name_alias              = "Nginx"
  relation_fv_rs_bd       = aci_bridge_domain.production_bd.id
}

resource "aci_application_epg" "prod_app" {
  application_profile_dn  = aci_application_profile.development_phoenix_app.id
  name                    = "app"
  name_alias              = "NodeJS"
  relation_fv_rs_bd       = aci_bridge_domain.production_bd.id
}

resource "aci_application_epg" "prod_db_cache" {
  application_profile_dn  = aci_application_profile.development_phoenix_app.id
  name                    = "db_cache"
  name_alias              = "DB_Cache"
  relation_fv_rs_bd       = aci_bridge_domain.production_bd.id
}
resource "aci_application_epg" "prod_db" {
  application_profile_dn  = aci_application_profile.development_phoenix_app.id
  name                    = "db"
  name_alias              = "MariaDB"
  relation_fv_rs_bd       = aci_bridge_domain.production_bd.id
}
resource "aci_application_epg" "prod_log" {
  application_profile_dn  = aci_application_profile.development_phoenix_app.id
  name                    = "log"
  name_alias              = "Logstash"
  relation_fv_rs_bd       = aci_bridge_domain.production_bd.id
}
resource "aci_application_epg" "prod_auth" {
  application_profile_dn  = aci_application_profile.development_phoenix_app.id
  name                    = "auth"
  name_alias              = "Auth"
  relation_fv_rs_bd       = aci_bridge_domain.production_bd.id
}


# Dev environemnt EPG Definitions
resource "aci_application_epg" "dev_web" {
  application_profile_dn  = aci_application_profile.production_phoenix_app.id
  name                    = "web"
  name_alias              = "Nginx"
  relation_fv_rs_bd       = aci_bridge_domain.development_bd.id
}

resource "aci_application_epg" "dev_app" {
  application_profile_dn  = aci_application_profile.production_phoenix_app.id
  name                    = "app"
  name_alias              = "NodeJS"
  relation_fv_rs_bd       = aci_bridge_domain.development_bd.id
}

resource "aci_application_epg" "dev_db_cache" {
  application_profile_dn  = aci_application_profile.production_phoenix_app.id
  name                    = "db_cache"
  name_alias              = "DB_Cache"
  relation_fv_rs_bd       = aci_bridge_domain.development_bd.id
}
resource "aci_application_epg" "dev_db" {
  application_profile_dn  = aci_application_profile.production_phoenix_app.id
  name                    = "db"
  name_alias              = "MariaDB"
  relation_fv_rs_bd       = aci_bridge_domain.development_bd.id
}
resource "aci_application_epg" "dev_log" {
  application_profile_dn  = aci_application_profile.production_phoenix_app.id
  name                    = "log"
  name_alias              = "Logstash"
  relation_fv_rs_bd       = aci_bridge_domain.development_bd.id
}
resource "aci_application_epg" "dev_auth" {
  application_profile_dn  = aci_application_profile.production_phoenix_app.id
  name                    = "auth"
  name_alias              = "Auth"
  relation_fv_rs_bd       = aci_bridge_domain.development_bd.id
}


# Contract Filters
## HTTPS Traffic
resource "aci_filter" "https_traffic" {
  tenant_dn = aci_tenant.production_tenant.id
  name      = "https_traffic"
}

resource "aci_filter_entry" "https" {
  filter_dn   = aci_filter.https_traffic.id
  name        = "https"
  ether_t     = "ip"
  prot        = "tcp"
  # Note using `443` here works, but is represented as `https` in the model
  # Using `https` prevents TF trying to set it to `443` every run
  d_from_port = "https"
  d_to_port   = "https"
}
## DB Traffic
resource "aci_filter" "db_traffic" {
  tenant_dn = aci_tenant.production_tenant.id
  name      = "db_traffic"
}

resource "aci_filter_entry" "mariadb" {
  filter_dn   = aci_filter.db_traffic.id
  name        = "mariadb"
  ether_t     = "ip"
  prot        = "tcp"
  d_from_port = "3306"
  d_to_port   = "3306"
}


# Contract Definitions
resource "aci_contract" "web_to_app" {
  tenant_dn = aci_tenant.production_tenant.id
  name      = "web_to_app"
  scope     = "global"
}

resource "aci_contract" "app_to_db" {
  tenant_dn = aci_tenant.production_tenant.id
  name      = "app_to_db"
  scope     = "global"
}

resource "aci_contract" "app_to_auth" {
  tenant_dn = aci_tenant.production_tenant.id
  name      = "app_to_auth"
  scope     = "global"
}

resource "aci_contract" "cache_to_db" {
  tenant_dn = aci_tenant.production_tenant.id
  name      = "cache_to_db"
  scope     = "global"
}

resource "aci_contract" "any_to_log" {
  tenant_dn = aci_tenant.production_tenant.id
  name      = "any_to_log"
  scope     = "global"
}




# Subject Definitions
resource "aci_contract_subject" "only_web_secure_traffic" {
  contract_dn                  = aci_contract.web_to_app.id
  name                         = "only_web_secure_traffic"
}

resource "aci_contract_subject" "only_db_traffic" {
  contract_dn                  = aci_contract.app_to_db.id
  name                         = "only_db_traffic"
}

resource "aci_contract_subject" "only_auth_traffic" {
  contract_dn                  = aci_contract.app_to_auth.id
  name                         = "only_auth_traffic"
}

resource "aci_contract_subject" "only_log_traffic" {
  contract_dn                  = aci_contract.any_to_log.id
  name                         = "only_log_traffic"
}

resource "aci_contract_subject" "only_db_cache_traffic" {
  contract_dn                  = aci_contract.cache_to_db.id
  name                         = "only_db_cache_traffic"
}
