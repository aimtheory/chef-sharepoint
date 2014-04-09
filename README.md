sharepoint Cookbook
===================
This cookbook installs and configures Microsoft SharePoint 2013. Everything is pre-release and work-in-progress.

Requirements
------------
There must already be an existing domain controller and farm accounts. The domain and farm accounts can be indicated in attributes as shown below.

Platforms
----------
This cookbook initially ONLY supports SharePoint 2013 on Windows Server 2008 R2. Windows Server 2012 has different prerequisites. This cookbook will not work with Windows Server 2012.

Attributes
----------

#### sharepoint::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[:sql_server][:accept_eula]</tt></td>
    <td>Boolean</td>
    <td>Whether to accept the SQL Server EULA</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>[:sharepoint][:sql][:hostname]</tt></td>
    <td>String</td>
    <td>The hostname of the SQL Server to use for the SharePoint installation</td>
    <td><tt>sql</tt></td>
  </tr>
  <tr>
    <td><tt>[:sharepoint][:sql][:port]</tt></td>
    <td>String</td>
    <td>The port number of the SQL Server to use for the SharePoint installation</td>
    <td><tt>1433</tt></td>
  </tr>
  <tr>
    <td><tt>[:sharepoint][:sql][:user]</tt></td>
    <td>String</td>
    <td>The user of the SQL Server to use for the SharePoint installation</td>
    <td><tt>sa</tt></td>
  </tr>
  <tr>
    <td><tt>[:sharepoint][:pid_key]</tt></td>
    <td>String</td>
    <td>The PID key to use for the SharePoint installation</td>
    <td><tt>NQTMW-K63MQ-39G6H-B2CH9-FRDWJ</tt></td>
  </tr>
  <tr>
    <td><tt>[:sharepoint][:domain]</tt></td>
    <td>String</td>
    <td>The domain where SharePoint is being installed</td>
    <td><tt>example.com</tt></td>
  </tr>
  <tr>
    <td><tt>[:sharepoint][:farm_accounts]</tt></td>
    <td>Hash</td>
    <td>A hash table of the farm accounts to use for the SharePoint farm creation</td>
    <td><tt>sp2013-farm, sp2013-ap-webapp and sp2013-ap-service</tt></td>
  </tr>
  <tr>
    <td><tt>[:sharepoint][:config][:passphrase]</tt></td>
    <td>String</td>
    <td>The configuration passphrase for the SharePoint installation</td>
    <td><tt>SharePoint 2013</tt></td>
  </tr>
  <tr>
    <td><tt>[:sharepoint][:config][:db]</tt></td>
    <td>String</td>
    <td>The name of configuration database for the SharePoint installation</td>
    <td><tt>SP2013_Configuration</tt></td>
  </tr>
  <tr>
    <td><tt>[:sharepoint][:central_admin][:db]</tt></td>
    <td>String</td>
    <td>The Central Administration database name for SharePoint installation</td>
    <td><tt>SP2013_Content_Central_Administration</tt></td>
  </tr>
  <tr>
    <td><tt>[:sharepoint][:central_admin][:auth]</tt></td>
    <td>String</td>
    <td>The auth type to use for the SharePoint installation</td>
    <td><tt>NTLM</tt></td>
  </tr>
  <tr>
    <td><tt>[:sharepoint][:windows_features]</tt></td>
    <td>Array</td>
    <td>An array of Windows features name to install as SharePoint prerequisites</td>
    <td><tt>AppServer, IIS-WebServerRole, IIS-WebServer</tt></td>
  </tr>
  <tr>
    <td><tt>[:sharepoint][:download_url]</tt></td>
    <td>String</td>
    <td>The download URL for the SharePoint 2013 img file</td>
    <td><tt>empty</tt></td>
  </tr>
  <tr>
    <td><tt>[:sharepoint][:config_path]</tt></td>
    <td>String</td>
    <td>The configuration file path for SharePoint installation</td>
    <td><tt>#{Chef::Config[:file_cache_path]}/config.xml</tt></td>
  </tr>
  <tr>
    <td><tt>[:sharepoint][:prereq_packages]</tt></td>
    <td>Hash</td>
    <td>This is a hash table of all the software packages that are prerequisites for SharePoint 2013 on Windows 2008 R2.</td>
    <td><tt>Please see the default.rb attribute file.</tt></td>
  </tr>
  
  
</table>

Recipes
-----
#### sharepoint::default.rb
Does nothing

#### sharepoint::sql_server
Installs SQL Server

#### sharepoint::prerequisites
Downloads all prerequisites for SharePoint 2013 on Windows Server 2008 R2 from a pre-loaded repository (already set up by the user) and installs them.

#### sharepoint::install
Downloads the SharePoint 2013 img file from the pre-loaded repo and installs SharePoint 2013.

#### sharepoint::configure
Creates and configures the SharePoint 2013 farm and the Central Administration site.

Usage
-----

e.g.
Just include a recipe in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sharepoint::prerequisites]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
License: Apache License 2.0
Author: Ian D. Rossi
