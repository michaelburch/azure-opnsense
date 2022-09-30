# azure-opnsense
This is a template for deploying an OPNsense Firewall on an Azure VM using opnsense-bootstrap

The template allows you to deploy an OPNsense Firewall VM using the opnsense-bootsrtap installation method. The provided configuration is generic enough to be used on nearly any Azure VM with two network interfaces. The primary interface is configured as the WAN and may have a public IP assigned. The secondary interface is configured as the LAN and exposes SSH and HTTPS. 

This template and script have been tested with FreeBSD 13.1 on Azure using OPNSense 22.7. The latest Azure Agent is installed and the serial console works if enabled. This is not intended as a complete configuration, but an expedient way to get a running firewall appliance that can be used as an inexpensive NVA in hub and spoke architectures. 

The login credentials are set during the installation process to:

- Username: root
- Password: opnsense (lowercase)

*** **Please** *** Change *default password!!!* 


## Credits

Thanks to [Daniel Mauser](https://github.com/dmauser/opnazure) as this is largely based on his work. 
