See this video of how to use these instructions: http://youtu.be/6GNxAzPmClk

VIRL (http://virl.cisco.com) is a comprehensive network design and simulation platform. VIRL includes a powerful graphical user interface for network design and simulation control, a configuration engine that can build complete Cisco configuration at the push of a button, Cisco virtual machines running the same network operating systems as used in Cisco’s physical routers and switches, all running on top of OpenStack.

A combination of this Dev VM running ODL, VIRL for virtual networks, and the client code project with VIRL topologies, Python and Postman collections allows you to experiment with ODL using Netconf/Yang, BGP-LS, PCEP and other networking capabilities.

# Instructions

The instructions here consist of these main parts, and assume that a controller is running as discussed in the [README] (./README.md):

 - Installing VIRL, and VM Maestro on the Dev VM
 - Cloning and installing the client code and test topologies
 - Using the test topologies with VIRL
 - Running the client code and seeing the results in the ODL web UI

At the end of these instructions you will have caused ODL to use Netconf to mount the Yang models for a number of IOS-XR based virtual network (XRv) devices.

# Installing VIRL

The VIRL software is available for purchase from http://virl.cisco.com/about-virl-2. At the time of writing the academic price for VIRL is $79.99 and there is no free version of VIRL.

The VIRL installation instructions are at http://virl-dev-innovate.cisco.com. The instructions vary over time, and for different platforms. No attempt is made to cover those instructions here, except for a brief discussion of RAM requirements and guest user roles below.

Note that VIRL only works, at the time of writing, with the latest versions of VMware virtualisation products on a hardware platform that supports nested virtualisation. VIRL will NOT run on VirtualBox. Because of limitations in the network configuration capabilities of the free VMware Player on Windows platforms, this configuration has not been tested with the free VMware Player.

There are many videos describing how to use VIRL here: http://virl-dev-innovate.cisco.com/videos.php

# VIRL RAM Settings

When using VIRL with XRv based network elements for the purposes of working with Netconf/Yang with ODL and the Dev VM, you need to calculate RAM requirements as follows:

 - The Dev VM requires 4-6GB (when using the Yang UI, 6 GB is required)
 - VIRL, without any network devices running, requires 2GB
 - Each XRv network element requires 3GB

So, for a network with one XRv network element, and allowing for 2GB for the host OS, you need a host machine with at least 11GB. For each additional XRv network element you would want to run, you would need an additional 3GB. The video above, showing 3 XRv network elements, was recorded on an iMac with 32GB of RAM.

# Static IP Addresses and "guest" User Admin Role

The test topologies used with the client code below are designed with static IP addresses for the network elements, so that the addresses correspond to the configuration in the settings for the client code. It is a feature of OpenStack, which VIRL uses to manage virtual network element images, that using static IP addresses requires administrator privileges. That means that the "guest" user in OpenStack needs to be in the "admin" group, which it may not be by default.

The "guest" user role may be edited via the "User Workspace Management" web application running on the VIRL server. In Chrome, type the IP address of the VIRL server in the address bar and press return. The VIRL Server page will be displayed, with a button at the top of the left column for the "User Workspace Management" application. Click on that button and login with "uwmadmin/password".

The "User Workspace Management" application has a number of options on the left side of the page. Select the "Users" option. Under the "Options" column of the "Users" page (which may not display correctly if the browser page is not wide enough) select "Modify".

In the "Edit User guest" page, select the "admin" option for the "Role" and then click on "Save".

# Installing VM Maestro

VM Maestro is the Eclipse RCP based client for VIRL. The version of VM Maestro required for a given installation of VIRL for a given platform (Windows, OS X or Linux) is available at http://<VIRL server IP address>/download/.

There are several videos describing how to use VM Maestro in the "Using VM Maestro" section here: http://virl-dev-innovate.cisco.com/videos.php

The video above shows how to use VM Maestro for the purposes of this exercise. The required steps are described below in the section on "Using VM Maestro".

When you first start VM Maestro, you will need to agree to licencing terms and conditions, and choose whether to provide usage information for "User Experience Improvement", then you will need to supply the IP address of the running VIRL server. The user name and password for the VIRL server in VM Maestro is "guest/guest", which is set by default.

# Cloning and Installing the Client Code

The exercises using VIRL networks are focused on using the RESTCONF APIs exposed by ODL, called by client code based on Python or Postman. The source for the client code, and some of the Postman collections, is in a Git project which needs to be "cloned" to the Dev VM and installed. The video above shows how to do that, and the steps are listed below.

 - Go to https://github.com/CiscoDevNet/cosc-learning-labs in Chrome
 - Look for the field below the "HTTPS clone URL" label on the right of the page
 - Click on the clipboard symbol to the right of that field
 - Open a terminal window
 - Type and enter: `cd; mkdir -p git; cd git`
 - Type and enter: `git clone ` followed by the pasted (Ctrl-v) contents of the clipboard. e.g. `git clone https://github.com/CiscoDevNet/cosc-learning-labs.git`.
 - Type and enter: `cd cosc-learning-labs/src`
 - Type and enter: `sudo pip3 install -e .`, where the sudo password is, by default, "ODLDEV"
 - Type and enter: `sudo pip install -e .`, where the sudo password is, by default, "ODLDEV"

You will now have the client code, utility code and associated test VIRL topologies on the Dev VM, and you will have installed the Python client libraries used by the Python code for Python versions 2 and 3. Below you will use the test topologies in VM Maestro and the Python code in Eclipse.

# Using the Test Topologies in VM Maestro

The project that you cloned in the previous section contains some test topologies designed to work with the Python code. Which test topology you use depends on the amount of RAM you have available, as discussed in the "Installing VIRL" section above.

To open a test topology file, you will need to import the Git projects. You do that by following these steps within VM Maestro after starting and configuring it as described in the "Installing VM Maestro" section above.

 - Select the "Window->Show View->Other..." menu item from the menu bar
 - Open up the "Git" section of the tree view in the "Show View" dialog, select the "Git Repositories" option and click on "OK"
 - A "Git Repositories" panel will appear at the bottom right of the VM Maestro window
 - Click on "Add an existing local Git repository"
 - The "Add Git Repositories" dialog will appear, select the "cosc-learning-labs" project in the panel in the bottom half of the dialog and click on "Finish"
  - The added project will now appear in the "Git Repositories" panel.
  - Bring up the context menu (typically with the right mouse button) on that project, and select "Import Projects ..."
  - The "Import Projects from Git Repository ..." dialog will appear.
  - Click on the "Next", and then "Finish"
  - The project will appear in the "Projects" panel on the bottom left of the VM Maestro window

You can open the project and then the "topology" directory, within which you will find a number of topologies of the form "n-XRV.virl", where n corresponds to the number of XRv elements in the topology. You should select and open a topology that corresponds to the RAM available for VIRL and the host as discussed above in the "Installing VIRL" section.

Once the topology is opened you will see a topology diagram in the middle panel of the UI. In the menu bar at the top of the UI you will see a button with a green circle symbol with a white arrow in the middle. Click on that button to start the topology, and accept the default option to switch to the simulation view when prompted to do so.

# Using the Python Client Code in Eclipse

To enable ODL to communicate with the XRv network elements via Netconf, you will need to configure each network element with a cryptographic key, to enable SSH connectivity, and enable the Netconf/Yang agent to support management of the device via the Netconf protocol. After you have done that, you can use the RESTCONF APIs on ODL to cause ODL to mount the devices in ODL using Netconf, and then manage the devices via the capabilities exposed by the Yang models.

Start Eclipse using the desktop icon in the Dev VM, and accept the default workspace. Once Eclipse starts, you should go to the "Workbench" by clicking on the arrow symbol in the top right of the page that is initially displayed.

Then you should follow the same instructions as for VM Maestro above to import the  "cosc-learning-labs" project.

Once the project has been imported it will appear in the "Project Explorer" on the left of the UI. Navigate to the "src/settings" folder in the project, by double clicking on the folder to open each folder level. Open the n-XRv.py file, corresponding to the network started in VIRL, by double clicking on it. Note the IP addresses of the network elements, which should match those of the network elements in the VIRL network started with VM Maestro. Note that 'n' corresponds to the number of XRv elements you are running.

Open the `src/utils` folder and then open the `crypto_and_agent.py` file. Edit the `network_devices` list so that it contains the same IP addresses that are found in the `n-XRv.py` file. Then use the context menu (right mouse button) in the editor panel to select "Run As->Python Run". That will execute the Python code, which will automatically, using [pexpect](https://github.com/pexpect/pexpect), telnet to the network elements, create a cryptographic key, for Netconf/SSH, and configure the netconf-yang agent. Note that, although the agent is configured already, it is best to do so again after configuring the cryptographic key.

You need to set the "NETWORK_PROFILE" environment variable to determine which of the settings files will be used by the scripts that call the ODL RESTCONF APIs. Use the "Windows" menu and select "Preferences". In "Preferences" dialog, navigate to "PyDev->Interpreters->Python Interpreter" and then select the "Environment" tab. In the "Environment" tab click on "New ...", which will cause the "New Environment Variable" dialog to be displayed. The "Name:" should be "NETWORK_PROFILE", and the "Value:" should be, for example, "3-XRv", corresponding to the topology that you started above with VM Maestro. Click on "OK" for the "New Environment Variable" dialog and again for the "Preferences" dialog. 

Check that you have a running ODL controller on the Dev VM before attempting the next step.

Open the `src/learning_lab` folder in the client code project and use the context menu on 00_controller.py to "Run As->Python Run". You should expect to see the output in the "Console" tab at the bottom of the UI report that the script connected successfully to the controller defined in the settings file identified by the "NETWORK_PROFILE" environment variable. If you do not see that, check that you can log into ODL with Chrome.

You need to cause ODL to "mount" the network device Yang models using Netconf. Before you do that, use the DLUX UI Nodes application to check that there are no nodes already in the inventory.

In Eclipse, use the context menu on `01_inventory_mount.py` to  "Run As->Python Run". You should expect to see the output in the "Console" tab at the bottom of the UI report that `device_mount` is being called for the devices defined in the settings file identified by the "NETWORK_PROFILE" environment variable. Check the DLUX UI Nodes application to confirm that the devices are present in the inventory of ODL.

**Warning**

The instructions above do work on the Dev VM, but sometimes do not for reasons that are unclear.

If at first you don't succeed, then reboot the VM and try again, remembering to delete the distribution directory in ~, and create a new directory by untaring the downloaded bundle, OR to rebuild the distribution in the local git repo, using these commands:

```bash
cd
rm -rf distribution-karaf-0.3.0-Lithium/
cd Downloads/
tar xf distribution-karaf-0.3.0-Lithium.tar.gz 
mv distribution-karaf-0.3.0-Lithium ..
```

OR

```bash
cd ~/git/odl-lithium/integration/distributions/karaf/
mvn clean install -nsu
```

