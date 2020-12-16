resource "intersight_ntp_policy" "example_ntp_policy_1" {
  name    = "example_ntp_policy_1"
  enabled = true
  ntp_servers = [
    "ntp.esl.cisco.com",
    "time-a-g.nist.gov",
    "time-b-g.nist.gov"
  ]
  organization {
    object_type = "organization.Organization"
    moid = "5ddf03ee6972652d32b94ecd"
  }
}

resource "intersight_ntp_policy" "example_ntp_policy_2" {
  name    = "example_ntp_policy_2"
  enabled = true
  ntp_servers = [
    "ntp.esl.cisco.com",
    "time-a-g.nist.gov",
    "time-b-g.nist.gov"
  ]
  organization {
    object_type = "organization.Organization"
    moid = "5ddf03ee6972652d32b94ecd"
  }
}

resource "intersight_snmp_policy" "example_snmp_policy_1" {
  name                    = "example_snmp_policy_1"
  description             = "testing smtp policy"
  enabled                 = true
  snmp_port               = 1983
  access_community_string = "dummy123"
  community_access        = "Disabled"
  trap_community          = "TrapCommunity"
  sys_contact             = "sttrayno"
  sys_location            = "TME-lAB"
  engine_id               = "vvb"
  snmp_users {
    name             = "exampleuser"
    privacy_type     = "AES"
    auth_password    = "C!5co123"
    privacy_password = "C!5co123"
    security_level   = "AuthPriv"
    auth_type        = "SHA"
  }
  snmp_traps {
    destination = "10.10.10.1"
    enabled     = false
    port        = 660
    type        = "Trap"
    user        = "exampleuser"
    nr_version     = "V3"
  }
  organization {
    object_type = "organization.Organization"
    moid = "5ddf03ee6972652d32b94ecd"
  }
}

resource "intersight_syslog_policy" "example_syslog_policy_1" {
  name        = "example_syslog_policy_1"
  description = "demo syslog policy"
  local_clients {
    min_severity = "emergency"
    object_type  = "syslog.LocalFileLoggingClient"
  }
  remote_clients {
    enabled      = true
    hostname     = "10.10.10.10"
    port         = 514
    protocol     = "tcp"
    min_severity = "emergency"
    object_type  = "syslog.RemoteLoggingClient"
  }
  remote_clients {
    enabled      = true
    hostname     = "2001:0db8:0a0b:12f0:0000:0000:0000:0004"
    port         = 64000
    protocol     = "udp"
    min_severity = "emergency"
    object_type  = "syslog.RemoteLoggingClient"
 }
  organization {
    object_type = "organization.Organization"
    moid = "5ddf03ee6972652d32b94ecd"
  }
}

resource "intersight_adapter_config_policy" "adapter_config_policy_1" {
  name        = "adapter_config_policy_1"
  description = "test policy"
  organization {
    object_type = "organization.Organization"
    moid = "5ddf03ee6972652d32b94ecd"
  }
  settings {
    object_type="adapter.AdapterConfig"
    slot_id = "1"
    eth_settings {
      lldp_enabled = true
      object_type="adapter.EthSettings"
    }
    fc_settings {
      object_type="adapter.FcSettings"
      fip_enabled = true
    }
  }
  settings {
    object_type="adapter.AdapterConfig"
    slot_id = "MLOM"
    eth_settings {
      object_type="adapter.EthSettings"
      lldp_enabled = true
    }
    fc_settings {
      object_type="adapter.FcSettings"
      fip_enabled = true
    }
}
}
