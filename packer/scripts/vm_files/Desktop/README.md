Welcome to the UNED Developer machine for the OpenDaylight (ODL) project.

http://www.opendaylight.org/

This Developer machine has been created as a tool to help developers understand and use the ODL technology. Any issues or feedback can be provided via this project in GitHub: https://github.com/matuteana/uned-sdn-dev-vm

On this machine you will find all of the tools, utilities and code you will need to build and explore ODL. You will also find instructions on how to use those tools in these exercises:

 - [Using Chrome](./Using_Chrome.md)
 - [ODL and Mininet](./ODL_and_Mininet.md) 
 - [ODL and VIRL](./ODL_and_VIRL.md)
 - [Yang and RESTCONF](./Yang_and_RESTCONF.md)

# Why?

Creating a stable build and test environment for ODL requires that a number of different versions of software all be installed properly, with the appropriate environment variables, and that various other aspects of the environment be aligned with that. This development VM packages all of that for you in one easy to use environment and includes instructions, with links to videos, for how to use the VM and explore ODL.

# Keyboard Settings

It is quite likely that the default keyboard layout will not work for you. There is a bookmark in Chrome to this page which will help you change that:

http://www.wikihow.com/Change-Keyboard-Layout-in-Ubuntu

# What Next?

The instructions below describe how to, either, build ODL, OR download a distribution bundle, and then how to start ODL. 

# Why Would I Build ODL Rather Than Use the Released Distribution?

Release of ODL are created at fixed periods, and made available via download here:

http://www.opendaylight.org/software/downloads

The releases on that dowload page have passed testing and so will be expected to work properly for most main use cases. They will, inevitably, also have bugs, as illustrated in this video: https://www.youtube.com/watch?v=H0-cewXbPYE

If you want the latest version of ODL, with bug fixes, then you can choose to build that yourself. You should note, though, that the latest code in the Git repository may not always work either, so there is a balance to be struck here.

# Using the Build Bundle

This video shows you how to download and start ODL: https://www.youtube.com/watch?v=H0-cewXbPYE

Building ODL does take some time, and exposes you to the vagaries of a changing code base (this *is* an open source project, and is under constant development, will all the (dis)advantages that this implies in terms of stability and latest features). If you want to do that anyway, you can use the Desktop shortcuts as explained in "Clone and Build ODL and Tutorials with the Desktop Icons" below.

If you just want to run ODL, then you can get a pre-built distribution from the download page at the OpenDaylight site:

http://www.opendaylight.org/software/downloads

That site is in the bookmarks included with the Chrome browser on this VM.

You can also use this command:

```bash
wget https://nexus.opendaylight.org/content/groups/public/org/opendaylight/integration/distribution-karaf/0.3.0-Lithium/distribution-karaf-0.3.0-Lithium.tar.gz
```

By default, when using a browser to download, files are saved into the ~/Downloads directory. The file size is ~250-300MB, which can download in 90 secs, or 30 min, it varies a lot.

Follow these instructions to unpack the distribution:

 - Open up a terminal with "Ctrl-Alt-t", which will open a Gnome Terminal.

 - In the terminal, enter `cd ~/Downloads`

 - In the ~/Downloads directory type `ls` and expect to see something like:

`distribution-karaf-0.3.0-Lithium.tar.gz`

 - Type `tar xf <bundle_file_name>`, e.g. `tar xf distribution-karaf-0.3.0-Lithium.tar.gz` to unpack the compressed tar file.

 - Move the directory that is created to your location of choice, which we will call ODL_DIR below, e.g. `mv distribution-karaf-0.3.0-Lithium ~`

 - You also set the ODL_DIR environment variable with the command `export ODL_DIR=~/distribution-karaf-0.3.0-Lithium`

 - In the terminal change directory to the `$ODL_DIR/bin`, e.g. `cd ~/distribution-karaf-0.3.0-Lithium/bin", or, if you have set the variable above, "cd $ODL_DIR/bin`

**DO NOT delete your downloaded distribution bundle, you will be needing it.**

# Clone and Build ODL and Tutorials with the Desktop Icons

This video shows how to use the desktop icons to build ODL: https://www.youtube.com/watch?v=G0UWIXU1j_M

On the Desktop are a number of shortcuts to help automate building, starting, stopping, and checking the status of the built version of ODL. Note that these icons are designed to be used with a version of ODL you build yourself in this VM.

This VM is shipped WITHOUT a populated ~/.m2/repository or git projects. The "Clone and Build ODL" Desktop shortcut automates the process of cloning ODL and running the Maven build for the [`integration`](https://git.opendaylight.org/gerrit/gitweb?p=integration.git;a=tree;hb=HEAD) component. This script can take hours to run. There are similar Desktop shortcuts for the ODL tutorials and the ODL Python and Postman client code.

The version of ODL built by the "Clone and Build ODL" Desktop shortcut will be in the `~git/odl-lithium/integration/distributions/karaf/target/assembly` directory. Within that directory are `bin` and `etc` directories.

The "Start ODL" Desktop shortcut will copy the `odl.cfg` file from the Desktop to the `org.apache.karaf.features.cfg` file in the `etc` directory of the built assembly, and then start ODL. The "ODL Status" shortcut will check the status of the running instance. The "Stop ODL" shortcut will stop the running instance of ODL using the `stop` script in the `bin` directory of the of the built assembly.

Note that it is possible to start ODL twice, in which case you will need to use "ps -eaf | grep karaf" to get the process number of the running karaf process, and then "kill -9 <process number>" to kill it.

Once ODL has been started, and it can take a while, open the Chrome browser from the desktop icon, and click on the "RestConf Documentation" or "DLUX UI" bookmarks. The login credentials are "admin/admin", if you are prompted for them.  When you see all of the bottom part of the RestConf Documentation page populated with a list of APIs, or a UI page with a topology screen, then ODL has started. If not, wait a bit and then refresh the page.

# Python and Postman Client Utilities

Python code and Postman scripts for ODL are available at https://github.com/CiscoDevNet/cosc-learning-labs. You can use that code to help you understand how to use the REST APIs for ODL. See this video also: http://youtu.be/6GNxAzPmClk

# Starting and Stopping ODL

See this video for an illustration of using karaf: https://www.youtube.com/watch?v=H0-cewXbPYE

ODL is started via Karaf, which loads features defined in the `org.apache.karaf.features.cfg` file if you use the `bin/start` script, or defined manually via the karaf CLI, if you use the `bin/karaf` CLI directly.

If you built ODL from source, then your `ODL_DIR` is `~/git/odl-lithium/integration/distributions/karaf/target/assembly`, so the `.cfg` file is in `~/git/odl-lithium/integration/distributions/karaf/target/assembly/etc`.

If you used the bundle method, then your `ODL_DIR` is (version depending) `~/distribution-karaf-0.3.0-Lithium` and the `.cfg` file is in the `~/distribution-karaf-0.3.0-Lithium/etc` directory.

A peer of the `etc` directory, `../bin`, contains a `karaf` command, so that you can use the karaf CLI. Or you can use the  `start` script which will load the features defined in the `etc/org.apache.karaf.features.cfg` file. There are also `stop` and `status` scripts in the `bin` dir.

You can start ODL like this:

```bash
cd $ODL_DIR/bin
./karaf
...

Hit '<tab>' for a list of available commands
and '[cmd] --help' for help on a specific command.
Hit '<ctrl-d>' or type 'system:shutdown' or 'logout' to shutdown OpenDaylight.

opendaylight-user@root>
```

The next steps vary depending on whether you are using a distribution, or you have built from git. If you are using a distribution, then you do NOT need to add the feature repositories as shown here, and you can proceed to the `feature:install` step below.

If you have built from git then you can use the desktop icons. If you want to use the karaf CLI with a built distribution then you need to add the feature repositories, as in the example shown below. Note that the specific feature repositories you will need to add will change over time, so what is below is just an *example*. The definitive list of feature repositories can be found in the "featuresRepositories" section of the `~/git/odl-lithium/integration/distributions/karaf/target/assembly/etc/org.apache.karaf.features.cfg` file. Also note that the configuration file has a comma-delimited list of feature repositories, whereas, at the karaf CLI, one needs to add the feature repositories one by one as shown below.

```
opendaylight-user@root>feature:repo-add mvn:org.apache.karaf.features/standard/3.0.3/xml/features
opendaylight-user@root>feature:repo-add mvn:org.apache.karaf.features/enterprise/3.0.3/xml/features
opendaylight-user@root>feature:repo-add mvn:org.ops4j.pax.web/pax-web-features/3.1.4/xml/features
opendaylight-user@root>feature:repo-add mvn:org.apache.karaf.features/spring/3.0.3/xml/features
opendaylight-user@root>feature:repo-add mvn:org.opendaylight.integration/features-integration-index/0.3.1-SNAPSHOT/xml/features

opendaylight-user@root>
```

At the prompt above, you will need to enter the following, where the feature list will vary according to your needs:

```
opendaylight-user@root>feature:install odl-base-all odl-mdsal-broker odl-restconf odl-yangtools-models odl-dlux-core odl-mdsal-apidocs odl-netconf-all odl-openflowjava-protocol odl-openflowplugin-all odl-netconf-connector-ssh odl-bgpcep-pcep-all odl-bgpcep-bgp-all odl-l2switch-switch odl-nsf-all odl-aaa-authn odl-dlux-node odl-dlux-yangui odl-dlux-all
```

The feature list shown here is from the odl.cfg file on the desktop, which contains configuration for a feature set supporting Netconf/Yang, BGP-LS, PCEP, OpenFlow and the available DLUX UI tools.

# What to do When It Does Not Work the Second Time

For reasons related to caches and locks, ODL will often work a first time, for a given installation, but not a second time for the *same* installation in the same directory.

When that happens, or as a matter of general practice, you should delete the distribution directory, i.e. `rm -rf $ODL_DIR`, and create a new directory by untaring the downloaded bundle, OR to rebuild the distribution in the local git repo, using these commands:

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
  
# What to do When the Disk Fills Up

The base box for this project has a disk of 30GB, which is enough to build the integration module with some space to spare.

If you build ODL on a regular basis you will likely fill the Maven repository with "snapshots". Additionally, if you build multiple projects in the git directory, in addition to the integration module, you can also use up a lot of disk space. Since ODL is a growing project, how much exactly varies over time. It is likely that the machine disk will fill up if you try to build too much though.

At the start of the Build ODL script, `~odldev/bin/build_controller.sh`, the snapshots in the Maven repository are deleted to save space.

To save even more space, you can `rm -rf  ~/.m2/repository`. This will mean, though, that when you build the next time, the Maven repository will have to be re-populated, though with fewer files as you will have removed old snapshots. A build with an empty repository can take some time (hours). 

At the end of the script is a command that will find every Maven pom.xml and run a "clean" build, to remove all of the build artefacts. This is not run by default, so you have to copy it and run it yourself in the git directory if you think you need to.

```bash
cd /home/odldev/git
find . -name pom.xml -exec mvn clean -fn -f -nsu {} \; 
```

# Build Optimisation

There are a number of techniques that one can use to optimise the performance of a Maven build. As always, there is a tradeoff between performance and accuracy, so think before you use these techniques:

 - No snapshot upgrades - The `-nsu` option will stop Maven downloading the snapshot metadata, which will speed up the build considerably, but you will not see the latest code changes.
 - Offline - The `-o` option will run Maven offline, so that only the contents of the local repository, `~/.m2/repository`, will be used for a build, i.e. Maven will not look for new artefacts in remote repositories and so will not be making HTTP requests during the build, but you will not see the latest code changes.

# Contents

This machine is based on a Ubuntu 14.04.2 LTS Desktop image, with certain packages not required for development, e.g. Libre Office removed to save space. See http://www.ubuntu.com/download/desktop and http://www.ubuntu.com/legal/terms-and-policies/intellectual-property-policy.

References to the "Apache License 2.0" below refer to http://www.apache.org/licenses/LICENSE-2.0.txt.

References to the "Eclipse Public License 1.0" or "EPL 1.0" refer to https://www.eclipse.org/legal/epl-v10.html.

References to the "GNU General Public License, version 2" or "GPL 2" refer to https://www.gnu.org/licenses/gpl-2.0.html. 

Installed on this machine, in addition to the standard Linux developer tools, are:

 - Maven, which is a project build tool used to build OpenDaylight projects and tutorials. Distributed under the Apache License 2.0. See http://maven.apache.org/.
 - Eclipse JEE version, with PyDev and Code Recommenders Tools for Java Developers, as well as settings specific to the m2e plugin and the ODL build. Distributed under the EPL 1.0. See http://www.eclipse.org/downloads/packages/eclipse-ide-java-ee-developers/lunasr2
 - IntelliJ IDEA Java IDE, community edition. Distributed under the Apache License 2.0. See https://www.jetbrains.com/idea/
 - PyCharm Python IDE, community edition. Distributed under the Apache License 2.0. See https://www.jetbrains.com/pycharm/
 - Wireshark, which is a tool for "sniffing" network traffic and analysing the contents, very useful for debugging purposes in network infrastructure development. Distributed under the GPL 2. See https://www.wireshark.org/
 - Mininet, which is an OpenFlow switch simulator. Distributed under the Mininet Pre-Beta License, https://github.com/bigswitch/mininet/blob/master/LICENSE. See http://mininet.org/
 - VMMaestro, which is the client GUI for Cisco´s Virtual Internet Routing Laboratory. Based on Eclipse distributed under the EPL 1.0, with additional components copyright Cisco Systems 2014, 2015. See http://virl.cisco.com
 - Google Chrome, with Postman, for accessing REST APIs. Copyright 2015 Google Inc. under these terms of service: https://www.google.com/chrome/browser/privacy/eula_text.html and https://www.getpostman.com/licenses/postman_base_app. See https://www.google.com/chrome/browser/desktop/ and https://www.getpostman.com/
