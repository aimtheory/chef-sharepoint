#
# Cookbook Name:: sharepoint
# Recipe:: default
#
# Copyright 2014, Ian D. Rossi
#
include_recipe "7-zip"

=begin
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
=end

# Download the SharePoint 2013 img
remote_file "#{Chef::Config[:file_cache_path]}/SharePointServer_x64_en-us.img" do
  source "http://162.242.216.238:8080/SharePointServer_x64_en-us.img"
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
