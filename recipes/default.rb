#
# Cookbook Name:: sharepoint
# Recipe:: default
#
# Copyright 2014, Ian D. Rossi
#
include_recipe "7-zip"
#include_recipe "sharepoint::prerequisites"

#include 'pry'
#binding.pry

# Join the domain
#ruby_block "join_domain" do
#  block do
#    Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
#
#    join_domain = shell_out(
#      '(Get-WmiObject win32_computersystem).rename("sharepoint");add-computer -DomainName iantest.com;Restart-Computer',
#      {
#        :user => node[:sharepoint][:domain_admin],
#        :password => "vagrant",
#        :domain => node[:sharepoint][:domain]
#      }
#    )
#  end
#end
#
# Create the farm accounts in the domain
node[:sharepoint][:farm_accounts].each do |name,options|
  ruby_block "create_user" do
    block do
      Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)

      create_user = shell_out(
        "$pwd = ConvertTo-SecureString -String \"#{options[:pwd]}\" -AsPlainText -force; New-ADUser -SamAccountName \"#{name}\" -GivenName \"#{options[:fn]}\" -Surname \"#{options[:ln]}\" -DisplayName \"#{options[:display]}\" -AccountPassword $pwd",
        {
          :user => node[:sharepoint][:domain_admin],
          :password => "vagrant",
          :domain => node[:sharepoint][:domain]
        }
      )
    end
  end

  ruby_block "add_to_domain_admins" do
    block do
      Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)

      add_to_domain_admins = shell_out(
        "Add-ADGroupMember \"Domain Admins\" name",
        {
          :user => node[:sharepoint][:domain_admin],
          :password => "vagrant",
          :domain => node[:sharepoint][:domain]
        }
      )
    end
  end
end

# Download the SharePoint 2013 img
remote_file "#{Chef::Config[:file_cache_path]}/SharePointServer_x64_en-us.img" do
  source "http://192.168.2.6/SharePointServer_x64_en-us.img"
  backup false
end

# Extract the img
powershell_script "extract_sharepoint_img" do
  cwd #{Chef::Config[:file_cache_path]}
  code "#{Chef::Config[:file_cache_path]}/SharePointServer_x64_en-us.img} -o#{Chef::Config[:file_cache_path]}/SP2013Installer"
  not_if { File.exists?("#{Chef::Config[:file_cache_path]}/SP2013Installer") }
end

# Write the config file
template "#{Chef::Config[:file_cache_path]}/config.xml" do
  source "config.xml.erb"
  variables({
    :pid_key => node[:sharepoint][:pid_key]
  })
  action :create
end

# Run the SharePoint installer
windows_package "sharepoint_installer" do
  source "#{Chef::Config[:file_cache_path]}/SP2013Installer/setup.exe"
  installer_type :custom
  options "/config #{Chef::Config[:file_cache_path]}/config.xml"
  action :install
end

# Add Powershell snapin
powershell_script "powershell_snapin" do
  cwd #{Chef::Config[:file_cache_path]}
  code "Add-PSSnapin Microsoft.SharePoint.PowerShell"
end

# Create the SharePoint farm (Configuration database)
ruby_block "create_farm" do
  block do
    Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)

    create_farm = shell_out(
      "$farm_cred = New-Object System.Management.Automation.PSCredential -ArgumentList @(\"#{node[:sharepoint][:farm_accounts][0][:upn]}\",(ConvertTo-SecureString -String \"Welcome123!\" -AsPlainText -Force)); New-SPConfigurationDatabase -DatabaseName \"#{node[:sharepoint][:config][:db]}\" -DatabaseServer \"#{node[:sharepoint][:sql][:hostname]}\" -AdministrationContentDatabaseName \"#{node[:central_admin][:db]}\" -Passphrase \"#{node[:sharepoint][:config][:passphrase]}\" -FarmCredentials $farm_cred",
      {
        :user => node[:sharepoint][:domain_admin],
        :password => "vagrant",
        :domain => node[:sharepoint][:domain]
      }
    )
  end
end

# Create the Central Administration Site
ruby_block "create_central_admin" do
  block do
    Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)

    create_central_admin = shell_out(
      "New-SPCentralAdministration -Port #{node[:sharepoint][:central_admin][:port]} -WindowsAuthProvider #{node[:sharepoint][:central_admin][:auth]}",
      {
        :user => node[:sharepoint][:domain_admin],
        :password => "vagrant",
        :domain => node[:sharepoint][:domain]
      }
    )
  end
end
