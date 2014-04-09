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
