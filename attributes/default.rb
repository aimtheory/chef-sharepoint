# SQL
default[:sharepoint][:sql][:hostname] = "vagrant-2008R2"
default[:sharepoint][:sql][:port] = "1433"
default[:sharepoint][:sql][:user] = "sa"

default[:sharepoint][:pid_key] = "NQTMW-K63MQ-39G6H-B2CH9-FRDWJ"

# User accounts
default[:sharepoint][:domain_admin] = "iarossi"
default[:sharepoint][:web_farm_acct] = "#{node['domain']}\sp2013-farm"
default[:sharepoint][:webapp_farm_acct] = "#{node['domain']}\sp2013-ap-webapp"
default[:sharepoint][:svc_farm_acct] = "#{node['domain']}\sp2013-ap-service"

# Sharepoint configuration info
default[:sharepoint][:config][:passphrase] = "Sharepoint 2013"
default[:sharepoint][:config][:db] = "SP2013_Configuration"
default[:sharepoint][:central_admin][:db] = "SP2013_Content_CentralAdministration"
default[:sharepoint][:central_admin][:port] = 11111
default[:sharepoint][:central_admin][:auth] = "NTLM"


default[:sharepoint][:windows_features] = [
  "AppServer",
  "IIS-WebServerRole",
  "IIS-WebServer"
]
default[:sharepoint][:download_url] = "http://192.168.2.6/SharePointServer_x64_en-us.img"
default[:sharepoint][:config_path] = "#{Chef::Config[:file_cache_path]}/config.xml"
default[:sharepoint][:prereq_packages] = {
  "AppFabric1.1-RTM-KB2671763-x64-ENU.exe" => {
    "installer_type" => :custom,
    "options" => "/quiet"
  },
  "MicrosoftIdentityExtensions-64.msi" => {
    "installer_type" => :msi
  },
  "setup_msipc_x64.msi" => {
    "installer_type" => :msi
  },
  "sqlncli.msi" => {
    "installer_type" => :msi
  },
  "Synchronization.msi" => {
    "installer_type" => :msi
  },
  "WcfDataServices.exe" => {
    "installer_type" => :custom,
    "options" => "/quiet"
  },
  "WindowsServerAppFabricSetup_x64.exe" => {
    "installer_type" => :custom,
    "options" => "/i"
  }
}
default[:sharepoint][:prereq_hotfixes] = {
  "Windows6.1-KB2506143-x64.msu" => "KB2506143",
  "Windows6.1-KB974405-x64.msu" => "KB974405"
}
