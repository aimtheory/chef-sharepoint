sharepoint Cookbook
===================
This cookbook installs and configure Microsoft SharePoint 2013. Everything is pre-release and work-in-progress.

Requirements
------------
There must already be an existing domain controller and farm accounts. The domain and farm accounts can be indicated in attributes as shown below.


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
    <td><tt>[:sharepoint][:config][:passphrase]</tt></td>
    <td>String</td>
    <td>The configuration passphrase for SharePoint installation</td>
    <td><tt>NQTMW-K63MQ-39G6H-B2CH9-FRDWJ</tt></td>
  </tr>
  
  
</table>

Usage
-----
#### sharepoint::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `sharepoint` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sharepoint]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
