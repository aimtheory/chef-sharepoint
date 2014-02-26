include_recipe "7-zip"

# Download the Sharepoint installer img
remote_file "#{Chef::Config[:file_cache_path]}/SharePointServer_x64_en-us.img" do
  source node[:sharepoint][:download_url]
  backup false
end

# Extract the img
powershell_script "extract_sharepoint_img" do
  cwd Chef::Config[:file_cache_path]
  not_if { File.exist?("#{Chef::Config[:file_cache_path]}/SP2013Installer") }
  code "C:/7-Zip/7z.exe x #{Chef::Config[:file_cache_path]}/SharePointServer_x64_en-us.img -o#{Chef::Config[:file_cache_path]}/SP2013Installer"
end

# Run the prereq installer
powershell_script "prereq_installer" do
  cwd Chef::Config[:file_cache_path]
  code "#{Chef::Config[:file_cache_path]}/SP2013Installer/prerequisiteinstaller.exe /unattended"
end

#windows_package "prerequisites" do
#  source "#{Chef::Config[:file_cache_path]}/SP2013Installer/prerequisiteinstaller.exe"
#  action :install
#  options "/unattended"
#end
