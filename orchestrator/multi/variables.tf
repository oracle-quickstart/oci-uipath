#Variables declared in this file must be declared in the marketplace.yaml

############################
#  Hidden Variable Group   #
############################
#TODO remove default value
# variable "tenancy" {
#   default = "ocid1.tenancy.oc1..aaaaaaaa4qmyu4ddxfuvdeqpe5rm6vwgye4iolxvmzyqicmzfc5zmvpcua3q"
# }

variable "mp_listing_id" {
  default = "ocid1.appcataloglisting.oc1..aaaaaaaafd5ljqfswelpeqxdv5gwtwl3uyllgxnm2b4hi6ovwfpgmj77t77a"
}

variable "mp_listing_resource_id" {
  default     = "ocid1.image.oc1..aaaaaaaa3en4cf5bmb3yaxk45xd4f7lvsuhje3ggrl63y7k655czwjsiy4nq"
  description = "Marketplace - Image OCID"
}

variable "mp_listing_resource_version" {
  default = "1.0"
}

variable "use_marketplace_image" {
  default = true
}

############################
#  Marketplace Image      #
############################


# variable "mp_listing_resource_id" {
#   default = "ocid1.image.oc1.iad.aaaaaaaamvqqg42veexxstidctjf4gw76dlbqxpnew5jwbm4lz4jghvtn47a"
#   description = "Marketplace - Image OCID"
# }

############################
#  Basics Configuration   #
############################

variable "vm_display_name" {
  description = "Instance Name"
  default     = "Orchestrator"
}

#TODO remove default value
variable "instance_username" {
  default     = "opc"
  description = "Default username for OCI is opc"
}

#TODO remove default value
variable "instance_password" {
  default     = "1qazXSW@3edc"
  description = "Password for local username"
}

variable "region" {
  default = "us-ashburn-1"
  type = string
}

#TODO remove default value and local value from main.tf
variable "compartment_ocid" {
  default     = "ocid1.tenancy.oc1..aaaaaaaa4qmyu4ddxfuvdeqpe5rm6vwgye4iolxvmzyqicmzfc5zmvpcua3q"
  description = "Compartment where infrastructure resources will be created"
}


############################
#  Orchestrator Info   #
############################
#TODO remove default value
variable "orchestratorVersion" {
  default = "19.10.19"
}
#TODO remove default value
variable "orchestratorAdminPassword" {
  default = "3edcVFR$5tgb"
}
#TODO remove default value
variable "passphrase" {
  default = "1qazXCVB"
}

# db variables passed to/used by orchestrator in SQL section

variable "redisServerHost" {
  description = "RedisConnectionString"
  default     = "dev-env-adi.redis.cache.windows.net:6380,password=xZ3l0vn9F01xwIYeHZzUGlnTFNuIpDJUQZOfbEVBH+0=,ssl=True,abortConnect=False"
}


############################
#  Virtual Machine Settings   #
############################

variable "vm_compute_shape" {
  default     = "VM.Standard.E2.2"
  description = "Compute Shape"
}

variable "availability_domain_name" {
  default     = "MCLg:US-ASHBURN-AD-1"
  description = "Availability Domain"
}

variable "network_strategy" {
  default = "Create New VCN and Subnet"
}

variable "vcn_id" {
  default = ""
}

variable "vcn_display_name" {
  default     = "uipath"
  description = "VCN Name"
}

variable "vcn_dns_label" {
  default = "uipath"
}

variable "subnet_dns_label" {
  default = "subnet"
}

variable "vcn_cidr_block" {
  description = "VCN CIDR"
  default     = "10.0.0.0/16"
}

variable "subnet_id" {
  default = ""
}

variable "subnet_display_name" {
  description = "Subnet Name"
  default     = "subnet"
}

variable "subnet_cidr_block" {
  description = "Subnet CIDR"
  default     = "10.0.0.0/16"
}
variable "nsg_display_name" {
  default = ""
}

variable "nsg_whitelist_ip" {
  default = ""
}

############################
#  SQL settings   #
############################
variable "databaseType" {
  # Understood values: "New SQL Server Evaluation", "Existing SQL Server", "New Paid SQL Server Standard"
  # WARNING: paid option incurs a license charge beyond IaaS cost. See: https://console.us-ashburn-1.oraclecloud.com/marketplace/application/60874068/overview
  default = "New SQL Server Evaluation"
}
variable "databaseServerName" {
  # placeholder value required for ORM, change based on databaseType
  default = "sqlserver.domain.com"
}

variable "databaseName" {
  # placeholder value required for ORM, change based on databaseType
  default = "uipath"
}

variable "databaseUserName" {
  # placeholder value required for ORM, change based on databaseType
  default = "SA"
}
#TODO remove default value
variable "databaseUserPassword" {
  default = "6yhnMJU&8ik,"
}
#TODO remove default value
variable "ssh_public_key" {
  # Used only for SQL Server evaluation running on OL instance
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAntqRU/L3YGeoTlBlqFoiFVa66NgXcNcBbAoCkHvdZ47dfn589DEhmZO3yhcZb+b1AD4jdF7Pr+LctS56eqXt7A4CthosHRmTxLxbL9kNKvB8ObR7EgnOwX8yrtFQvoyL4Efn174HOESboaEqJl9X2k4JQe+8v8/7DUz5kv+hRdzexA6P81/k+s4LX9Vn+lWpm4Z/e3+sjtNasYhL4rgMAOr8ZfmcQJBEzfkQs4vjOerE5KeP/Zbn68P6nsPy6+AjL9JdN/ukR/e3bIHZeY8GiUlngptmv5R49h6t0OD9qBolWeDQQnX6ZL33eUFw5ew8fM8UZAbr4iHALSlNTwAh3Q== rsa-key-20200306"
}

variable "load_balancer_display_name" {
  default = "lborch"
}

variable "certificate_name" {
  default = "lbcert"
}

variable "cert_private_key" {
  description = "Certificate private key"
  default     = "-----BEGIN PRIVATE KEY-----\n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\nwn/UfNDMhVcC+CpP9NcZ1QTVtdvhjr9p\n-----END PRIVATE KEY-----"
}

variable "cert_public_key" {
  description = "Certificate public key"
  default     = "-----BEGIN CERTIFICATE-----\nMIIFDTCCAvWgAwIBAgIQHYn7YKkK55tEEn5Y9mWiFTANBgkqhkiG9w0BAQsFADAf\nMR0wGwYDVQQDDBRVaVBhdGhTZWxmU2lnbmVkUm9vdDAeFw0yMDA3MjkxMTAwMTJa\nFw00MDA3MjkxMTEwMDhaMB8xHTAbBgNVBAMMFFVpUGF0aFNlbGZTaWduZWRSb290\nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAtho5FbLTQDFtkSlkCIGc\nOJRWUD1xhS0E3j0Jdkx8RV9fEs0qXh7a3UzM/i4uMY9HNJXOzS1wncc8qyCNp+DR\nmn4qOXGds42lLqH0Mv30IBkteUWADReRM+lZB6Jyp8m77ZMRakHJtCbLlLeJXm3s\nS9i2QFGvkHreSIrlfC/Xh9Y67LsSia8lQCgYdOY4G5UTMxrNNpbY5CMKsgXbjh4j\ndEobcCcXNHKvXjexx2sYA1jtVxfPG+VkGoWaLd4wMu9heuUeAOl7JNBCy9I2ZedJ\nbArdyN+CcTUo82FfUUhVoLfI9iC892yhpDDL72wEpA8pa+Qm/tZCkVU4VNOWRLah\n9vJd5VS5QP40lLsyTdvVQjDD+Pk20Hoa57i1yvehwbDkXQ4e14Zg1TLxaTRTfKQQ\nYFW6tCbuzTsJb38VfWYc+Ie8oz6Cgf08D0c/tP/n8CgpffeEkxsg8+VFE1o9rImd\nJ3KmmvKm51BLZcj9860cTxQgXQrcBtLE+SUz15OcoLBguurwPtdhyO/LqJUjwgnk\nMF4B+vvBUDVjKbawbuRfkW9vcQjsDFjP35SpUPnpVW4J0X1YRQQFBislpOaA1k2u\nnu/MbV4JWNYzawYMbFKBwl7mej8D/42xn7ASIUfTGxS1am3ZrDesNhYy4gfvXzof\nMbrktrwklQpGUN7Or7ytTo0CAwEAAaNFMEMwDgYDVR0PAQH/BAQDAgIEMBIGA1Ud\nEwEB/wQIMAYBAf8CAQMwHQYDVR0OBBYEFO/qEsxoKUcF5sVwagbnZfuNr07vMA0G\nCSqGSIb3DQEBCwUAA4ICAQA4m5sQJDY9IYDjgi/j/vjRBw3Ui8ofQy9i3JnojMTb\nDoew9sl06RgYnLl34/g0JXiNA+haPQKWMW6/SEpWSQ+tAlyXDiwKlffXJ389iT0m\nWkK3vNvuOHgGXL9wRhvxgNmiw0i1huTpwjz717AH+L+sxpT6wPJeA6u9g+T2AJ8+\nO0g55xjjcz/p5kE5FoWynKLObL5hZ3zsFDRH6rqdjI65aq6Gt1kFhNfC2JNZ4z0c\nDLKrUr/+axvTf6cqXHvyURM5Z7XUfl0wxsIr9S0CRrGHrCsCbwXMsYUa7dcY6f8w\nLBMAuNw0EjPOhxwcwBgCwATyuVMifYyq0IWV0TS6znABm340S4NDZJqUWFlWDmps\nhSmS1P6stkZZ1gnqLm4v9wuAdWo6a3sBWba9SfIjoFnA9rrE4xTsbrDvV/hilaK7\niiuFlvp1gUefgfF3n5pkOx8bEaBk96dg9ijMn+k4Ec7i+U73rD49iAuGznLooW5G\n2trj2BeVFWo2biQg/DZGq7E7uDNCA9ouQr5CMBJnx77A5HvUQYy/Uw+KiEZn10mr\nHcHSxe+87DpW7H6mUTbYQd+rfXy8adgpXqXhldxkBp8fWLvVV+hwl5mrphbbA3BT\nd7GyUU+iyveqj71l3VCovkT9c8FVZvZqhz48eeo5kjk2XBuSh15nwaOjybs/5yoh\nCQ==\n-----END CERTIFICATE-----"
}

variable "ca_certificate" {
  default = "-----BEGIN CERTIFICATE-----\nMIIFDTCCAvWgAwIBAgIQHYn7YKkK55tEEn5Y9mWiFTANBgkqhkiG9w0BAQsFADAf\nMR0wGwYDVQQDDBRVaVBhdGhTZWxmU2lnbmVkUm9vdDAeFw0yMDA3MjkxMTAwMTJa\nFw00MDA3MjkxMTEwMDhaMB8xHTAbBgNVBAMMFFVpUGF0aFNlbGZTaWduZWRSb290\nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAtho5FbLTQDFtkSlkCIGc\nOJRWUD1xhS0E3j0Jdkx8RV9fEs0qXh7a3UzM/i4uMY9HNJXOzS1wncc8qyCNp+DR\nmn4qOXGds42lLqH0Mv30IBkteUWADReRM+lZB6Jyp8m77ZMRakHJtCbLlLeJXm3s\nS9i2QFGvkHreSIrlfC/Xh9Y67LsSia8lQCgYdOY4G5UTMxrNNpbY5CMKsgXbjh4j\ndEobcCcXNHKvXjexx2sYA1jtVxfPG+VkGoWaLd4wMu9heuUeAOl7JNBCy9I2ZedJ\nbArdyN+CcTUo82FfUUhVoLfI9iC892yhpDDL72wEpA8pa+Qm/tZCkVU4VNOWRLah\n9vJd5VS5QP40lLsyTdvVQjDD+Pk20Hoa57i1yvehwbDkXQ4e14Zg1TLxaTRTfKQQ\nYFW6tCbuzTsJb38VfWYc+Ie8oz6Cgf08D0c/tP/n8CgpffeEkxsg8+VFE1o9rImd\nJ3KmmvKm51BLZcj9860cTxQgXQrcBtLE+SUz15OcoLBguurwPtdhyO/LqJUjwgnk\nMF4B+vvBUDVjKbawbuRfkW9vcQjsDFjP35SpUPnpVW4J0X1YRQQFBislpOaA1k2u\nnu/MbV4JWNYzawYMbFKBwl7mej8D/42xn7ASIUfTGxS1am3ZrDesNhYy4gfvXzof\nMbrktrwklQpGUN7Or7ytTo0CAwEAAaNFMEMwDgYDVR0PAQH/BAQDAgIEMBIGA1Ud\nEwEB/wQIMAYBAf8CAQMwHQYDVR0OBBYEFO/qEsxoKUcF5sVwagbnZfuNr07vMA0G\nCSqGSIb3DQEBCwUAA4ICAQA4m5sQJDY9IYDjgi/j/vjRBw3Ui8ofQy9i3JnojMTb\nDoew9sl06RgYnLl34/g0JXiNA+haPQKWMW6/SEpWSQ+tAlyXDiwKlffXJ389iT0m\nWkK3vNvuOHgGXL9wRhvxgNmiw0i1huTpwjz717AH+L+sxpT6wPJeA6u9g+T2AJ8+\nO0g55xjjcz/p5kE5FoWynKLObL5hZ3zsFDRH6rqdjI65aq6Gt1kFhNfC2JNZ4z0c\nDLKrUr/+axvTf6cqXHvyURM5Z7XUfl0wxsIr9S0CRrGHrCsCbwXMsYUa7dcY6f8w\nLBMAuNw0EjPOhxwcwBgCwATyuVMifYyq0IWV0TS6znABm340S4NDZJqUWFlWDmps\nhSmS1P6stkZZ1gnqLm4v9wuAdWo6a3sBWba9SfIjoFnA9rrE4xTsbrDvV/hilaK7\niiuFlvp1gUefgfF3n5pkOx8bEaBk96dg9ijMn+k4Ec7i+U73rD49iAuGznLooW5G\n2trj2BeVFWo2biQg/DZGq7E7uDNCA9ouQr5CMBJnx77A5HvUQYy/Uw+KiEZn10mr\nHcHSxe+87DpW7H6mUTbYQd+rfXy8adgpXqXhldxkBp8fWLvVV+hwl5mrphbbA3BT\nd7GyUU+iyveqj71l3VCovkT9c8FVZvZqhz48eeo5kjk2XBuSh15nwaOjybs/5yoh\nCQ==\n-----END CERTIFICATE-----"
}

#######File storage module variables############
variable "file_system_display_name" {
  default     = "orchestrator_nuget"
}

variable "mount_target_display_name" {
  default     = "nuget_mount_target"
}

variable "export_path" {
  default     = "/nugetpackages"
}

variable "export_source" {
  default     = "10.0.0.0/16"
}

variable "export_access" {
  default     = "READ_WRITE"
}

variable "export_identity_squash" {
  default     = "NONE"
}

variable "privileged_source_port" {
  default     = "false"
}

#TODO when adding this variable in marketplace.yaml, need to validate base64String; add pattern=^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$
variable "key_file" {
  
  description = "PEM private key"
  default     = "LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQ0KTUlJRW9nSUJBQUtDQVFFQW0zN0R1Kzg0N0JlOTdQU0xvb1VoNENGTkFaTVo5MUJ6N1J3d09yWEhDNjlDSGtFSG84aEFoZUZETktIRg0KWFFqdkhDcGJUUmZFb0ttY01CRGc0eGtnN0NBdVVQTDlkVTduOWxXMENtdjhKUHlaWEJ4OUkwc0hlekpuc0xFNFlmaE5Ua3ZVbDV5bA0KNzA0d3BpMkM3dVFGQkw2SkJZaE4zMHJFT2gwSHZHUi9rZkttT2NDMEJROWFVcmg5VjhTcGt6SjNyaWFPNW9ORFJqcExya1I2cDFtZQ0KRWM0K2gyemFMNlJ3ckN3TEVHc1YwOHdpSnVuaWtpQ0ZqeXdVdW0vcXk2YzE3NEgwUUQ5VXh4bTFaUGxyd01Hb3NxTTNpeEFzZk9BeQ0Ka20rSDB5U0lIZ1BrYzd3YXhnRkRZdWh6QllXcTQ5Z3h5djk2SEZGa1Azd3Jnbm9JWU82c013SURBUUFCQW9JQkFHT2t0eStlbS82SA0KTkZrOVdLSGI2SnBsSEtET3NFd1F6VWo3MEZnL0ZuK0JYc0JlY2RQZHhxTkVlRG1wRlAyS2RSZTZlT21OT3A2dU1mMkhRMldrTzdtMA0KNFpsVUxXSFlIOE4ycGpvcmV0Z0UydzN3MzZ3WEw0TWVDTjVzb3JIOVdTUzhhVTZDdnI3OGZ5WnVjY0krY296WXdKdS8vZzhDTFg4RQ0KRFdvSGlNeHdEa1B4Ny91MVdZNUZMY3B2bjk1QlpkWmNINmtZWld1N1RsU2FLM0E2cVljajRNY2JlcU1aODNLWFZmc1o0azY1WnFYMw0KTHBWemNYeENhaGdMcFhSVlNFRzVoODlscVR1NWROZUZKc1BDTEtaekppbHJyaDdDbVo4TkNra0R4OVJsVkpUZkdNOVNuZFhVN3lxNQ0KeUZIcHQ2aXkyUmd6T2kwVDlQWVprU1hOVGVrQ2dZRUEzWDhLTUd3ZDBUVkpXYm5hWVBPOHJmWFgwVXd1K0wwSmcrSW9FV0RVNERodg0KUk5PNjlLTWZMWElUVmNaQ2xrU0Y3YklFeXk2RUMvbyt2SUpXMTFmY3Q4ZmRrQTVSMlBYRThCamd6RGJKVmFETTJzQUthVFdVVEhweQ0KMktkeTdFTVErOXBrT0lqTi90a3VqQTJiaWF5U2RpdzVzSVlJczJoWHBKckhlclNzbWgwQ2dZRUFzN2V4d1BiNUsvL3g1QldBNzdmZA0KbGFQV3F2M040TjlxWHp1UlBBeWFXSjBGZDQ4MFkyaXBoMHpVY0hGR1k1T3FOdC9Xb3BxMXVUMmRBZkFycTd3TGE1bCtDazExZmhucQ0KQ2NCMmJ4S2lxTlQ5MXlYbDFKTkpidzg4V0czTkM5L1h1L1dLMVZUN3BNeFNwRHFkSGVJb2hOa1pXU1BPSkIwamRESjFLeURERG84Qw0KZ1lBOHhpVEhrSUxGNm5jTDFZRGo1VHk2QnFDRzN2NXNaWUg4MjhyZXFkRC9ETDBMQjRWZXBudGhmdEZyVVpEbnBqbVJOSzA0Q3JWVQ0KaS84MnZoU1IxWnZNR1Z6anIrb3BPNVlqd3MrN2VMVFpkOXQ5a2YvSlNsZzhlOFNUU2E2d3dONGlISlF2SnVwT3FNeXF4UGtPVjNtQQ0KVHpZdEJ6blA4Q3RNRU9QMitTZjZ5UUtCZ0R3TW92NUJCNXptRm1NSnRGMWs2RXM1eFY2NUUzT1I4eThDN2xKTU83NWtLUkY3N2h0Ug0KTzJRVURkL01XYUtvRW5YbmNRWS8vM3gzMCtCejZZT21mNEppZFRUb0VOd2p1SW10bjJVWnF2UVN4d1oraVQ3d1A5YzJGZ25PRm5kag0KUWVoeDhRTzdNNklyQzJvSWs3c0tlRk43WHZiaitkc2pTVmRvRExKdWJmNk5Bb0dBQXlsbGZ6cjBHNXNpMldQS1g3bzNuRUtZWXdjVg0KRVA2Y1I1blFlL044dWM0RkN2QmRocFRhQ3BzK3h5cFlhYzZuVHBvdHloN1ViZ0kzK3ZwSGo2a2hzeFlYdjVUTm9taGtyRk12c3o1SQ0KNEthTGtjZHBmbDcwTHBLZVIyV1ZpMWVtdmRQbFNzZDZkRjZENkx1a21qdDAxRkpOYVJIOWRDL0RRRmtoVUo4SHJTcz0NCi0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0t"
}
