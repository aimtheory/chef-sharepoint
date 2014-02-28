include_recipe "windows::reboot_handler"
include_recipe "7-zip"

# All prereqs must be installed in a specific order which
# precludes easily iterating over a list packages. Therefore,
# explicit resources set for each prerequisite.

# Install .NET Framework 4.5
windows_package "dotNetFx45_Full_setup.exe" do
  source "http://192.168.2.6/dotNetFx45_Full_setup.exe"
  installer_type :custom
  options "/q"
  action :install
  not_if { File.exists?('C:/Windows/Microsoft.NET/Framework/v4.0.30319/Microsoft.Activities.Build.dll') }
end

# Install Windows Management Framework 3.0
powershell_script "Windows6.1-KB2506143-x64.msu" do
  cwd Chef::Config[:file_cache_path]
  code "wusa #{Chef::Config[:file_cache_path]}/Windows6.1-KB2506143-x64.msu /quiet"
  not_if "get hotfix -id KB2506143"
end

# Install Application Server and IIS Roles
node[:sharepoint][:windows_features].each do |f|
  windows_feature f do
    action :install
  end
end

# Install Microsoft SQL Server native client
windows_package "sqlncli.msi" do
  source "http://192.168.2.6/sqlncli.msi"
  installer_type :custom
  options "/quiet"
  action :install
end

# Install Windows Identity Foundation
powershell_script "Windows6.1-KB974405-x64.msu" do
  cwd Chef::Config[:file_cache_path]
  code "wusa #{Chef::Config[:file_cache_path]}/Windows6.1-KB974405-x64.msu /quiet"
  not_if "get hotfix -id KB974405"
end

# Install Microsoft Sync Framework Runtime v1.0 SP1 (x64)
windows_package "Synchronization.msi" do
  source "http://192.168.2.6/Synchronization.msi"
  installer_type :msi
  action :install
end

# Install Microsoft Identity Extensions
windows_package "MicrosoftIdentityExtensions-64.msi" do
  source "http://192.168.2.6/MicrosoftIdentityExtensions-64.msi"
  installer_type :custom
  options "/quiet"
  action :install
end

# Install Microsoft Information Protection and Control Client
windows_package "setup_msipc_x64.msi" do
  source "http://192.168.2.6/setup_msipc_x64.msi"
  installer_type :msi
  action :install
end

# Install Microsoft WCF Data Services 5.0
windows_package "WcfDataServices.exe" do
  source "http://192.168.2.6/WcfDataServices.exe"
  installer_type :custom
  options "/quiet"
  action :install
end

# Install Windows Server AppFabric
windows_package "WindowsServerAppFabricSetup_x64.exe" do
  source "http://192.168.2.6/WindowsServerAppFabricSetup_x64.exe"
  installer_type :custom
  options "/i"
  action :install
end

# Install Cumulative Update Package 1 for Microsoft AppFabric 1.1 for Windows Server (KB 2671763)
windows_package "AppFabric1.1-RTM-KB2671763-x64-ENU.exe" do
  source "http://192.168.2.6/AppFabric1.1-RTM-KB2671763-x64-ENU.exe"
  installer_type :custom
  options "/quiet"
  action :install
end



