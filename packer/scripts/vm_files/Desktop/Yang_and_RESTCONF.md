See this video of how to use these instructions: http://youtu.be/nrO9kNgBoNo

In these instructions you will combine the Mininet and VIRL exercises
with the Yang UI and RESTCONF using Postman.

Before you start here, you should make sure you are familiar with these
exercises:
 - [Using Chrome](./Using_Chrome.md)
 - [ODL and Mininet](./ODL_and_Mininet.md) 
 - [ODL and VIRL](./ODL_and_VIRL.md)

# Yang Schema and RESTCONF

After startup, and upon mounting Netconf/Yang managed devices, ODL
will populate its `cache/schema` directory with the Yang schema files that
it uses. These schema are a combination of those that are use by
MD-SAL, loaded as a consequence of the features that you have
installed, and those obtained from devices that are mounted using Netconf.

The schema are text files that you can open with the `gedit
<filename>` command. The instructions below will direct you to do that
at the appropriate step.

When you examine the Yang UI, described below, and use Postman, you
will see that the URLs are constructed from elements of the Yang
schema.

This exercise will illustrate how that works with examples based on
topology, nodes and interfaces.

# VIRL Topology, Client Script Settings, VM RAM and JAVA_OPTS

In this exercise you will use the 1-XRv VIRL topology, and a
combination of Python scripts via the CLI and a Postman collection. Note that the
default value for the NETWORK_PROFILE environment variable is also
`1-XRv`, so you can use the Python scripts at the CLI directly.

Where other exercises have been carried with the VM RAM set to 4GB,
empirical testing shows that the Yang UI features work best with the
VM RAM at 6GB, and the JAVA_OPTS, that control how much RAM the Java VM
uses for the controller, set to 5GB.

Setting the RAM for the VM is provider specific, but is generally
found in the VM settings. This setting must be changed, if necessary,
when the VM is shutdown.

To check the value of the JAVA_OPTS, use this command:

```bash
env | grep JAVA_OPTS
```

If you need to change the value of JAVA_OPTS, then use this command in the same terminal that
you will use to launch karaf, which you will need to do manually:

```bash
export JAVA_OPTS=-Xmx5120m
```

You can also edit this value in the `~/.bashrc` file and restart the VM. 

# Installing Client Python Scripts and Postman Collection

After using the "Clone Python and Postman client code" desktop icon to
clone the Python code, you should use these commands to install the Python code project,
where the sudo password is, by default, "ODLDEV":

```bash
cd ~/git/cosc-learning-labs/src
sudo pip3 install -e .
sudo pip install -e .
```

Included in the `src/postman` directory of the client scripts project
are a number of Postman "collections". You should install the
`mdsal-ncmount` collection as
instructed below, and as shown in the video above.

# Prerequisites

You should ensure that you have:

 - Installed the Postman application in Chrome as described in [Using Chrome](./Using_Chrome.md)

 - Started mininet as described in
 [ODL and Mininet](./ODL_and_Mininet.md). The basic command is:

```bash
sudo mn --controller=remote,ip=127.0.0.1 --topo tree,3
```

 - Started VIRL, and used VM Maestro to launch the 1-XRv test
 topology, as described in [ODL and VIRL](./ODL_and_VIRL.md).

 - Started ODL, either from a bundle or from a build, as described in
 the [README](./README.md)

 - Used the "Nodes" DLUX UI application to confirm that the expected
 nodes are listed, which should include a number of OpenFlow nodes from the
 Mininet network, but not yet an IOS-XRv node.

# Using Postman to Mount a Device

In the [ODL and VIRL](./ODL_and_VIRL.md) exercise, you use a Python
script to call a RESTCONF API to mount devices, where the required
parameters were defined in a settings file. Here we will use Postman
to call the same RESTCONF API, so you can see what is happening under
the covers.

The Postman collection you will use here is in the `src/postman`
directory of the client code library,
i.e. `~/git/cosc-learning-labs/src/postman` in a file called
`mdsal-ncmount.json`.

In the Postman application, launched from
Chrome, you should click on the "Import" symbol in the menu bar at the
top, and then, in the import dialog, click on the "Choose Files"
button to navigate to that directory and open that file.

The imported collection will be displayed on the left of the Postman UI
window. You should select the "mount iosxrv-1" item from the list
shown, and it will be displayed in the middle panel of the UI.

You will need to set the "Authorization" parameters to use "Basic
Auth" and set the "Username" and "Password" field values to
"admin". Then you will need to select the "Body" of the request and
change this value as shown:

```
 "odl-sal-netconf-connector-cfg:address": "172.16.1.11",

```

Which matches the IP address of the IOS-XRv node running in the VIRL
topology.

You can then click on the "Send" button to cause the request to be
made to the controller, which will cause the device to be mounted, by
ODL using Netconf. You can confirm that in the DLUX UI "Nodes" application. To double check,
you can also use the `./01_inventory_connected.py` script in the
`src/learning_labs` directory to show the connected devices.

# The Yang UI and Postman

The Yang UI allows you to navigate the Yang based models created
within the controller, and to make requests, just like you did with
Postman above, using RESTCONF. You can also copy the requests made by
the Yang UI into Postman to use them there, using the "Request
history" window.

The combination of the Yang UI and Postman, then, will help you
understand how Yang schema are used to construct models, and how those
models are joined together, using extension points, to support
navigation, using RESTCONF.

When using Postman, the general method is to open a new request tab by
clicking on the `+` symbol on the right of the tabs, and then pasting
the URL copied from the Yang UI request history into the URL field to
the left of the "Send" button.

Then you need to set the "Authorization" parameters to use "Basic Auth" with the password and
username set to "admin". Having done this for one tab, you can also
paste a new URL into the same tab, and send that, without having to
set the authorisation parameters again.

# From Topology to Interfaces

Select the Yang UI in the list of DLUX UI applications on the left of
the web UI after you log in with `admin/admin`. The Yang UI first
takes a few moments loading modules from the controller, and will then
display, in the "Module" panel at the top part of the UI, all of the
top level Yang modules that are available.

For the purposes of this exercise, you should select the
`network-topology rev.2013-10-21` node and click on the `+` symbol to
expand it. The two tree nodes shown, `operational` and `config`
correspond to the
["Separation of Configuration and State Data"](https://tools.ietf.org/html/rfc6241#section-1.4)
in
[RFC-6241-Network Configuration Protocol (NETCONF)](https://tools.ietf.org/html/rfc6241). Expand
the `operational` node and select the `network-topology` node. 

In the middle of the UI is a row of fields and buttons, which change
according to the context of what has been selected in the "Modules"
panel. Having selected the `network-topology` node, you will now be
able to use the "Send" button to make a request to "Get" the topology
data from the controller.

After you have done that, the bottom panel will render the data
retrieved in a form that allows you to interact with the data
model. Note that you will likely have to expand the size of the web
browser horizontally to be able to see the data properly.

In the data you will see a `topology-list` within which are shown a
number of `topology-id` fields. These will include `flow:1`, which is the
OpenFlow topology from Mininet, and `topology-netconf`, which is the
topology containing the XRv node.

In the "Module" panel at the top, you can click on the `topology
{topology-id}` node. You will see that the middle bar contents change,
and that there is a field into which you can enter a value. This value
should be a specific `topology-id`. Enter `flow:1` into this field,
and click on the "Send" button.

In the panel at the bottom, after a moment, you will see a tree view
of the `flow:1` OpenFlow topology. This topology contains a number of
nodes, named `openflow:n`, where n is a node number corresponding to
one of the nodes in the topology created by Mininet.

In the "Modules" panel, you can expand the `topology {topology-id}`
node and you will see a node labelled `node {node-id}`. Select that
node in the tree and the middle bar will change again to show two
fields, one for the `topology-id` and one for the `node-id`.

Fill in these fields with `flow:1` and `openflow:1` respectively and
send that request. The bottom panel will show the `node list` with
that specific node selected.

Click on the "Request history" button in the middle of the UI, and a
panel will pop up showing a table of the requests you have
made. Select and copy the last request, so that you can paste that
into Postman.

Go to the Postman window, and paste the copied URL into the URL
field. Set the "Authorization" parameters as required. Then click on
"Send" to send that request to ODL. The result of the request will be
displayed in the bottom of the Postman window, and, by default, will
be a JSON document.

In this case, with the URL for the `openflow:1` OpenFlow topology
node, you will see a data structure showing that node and the
termination points associated the node.

Return to the Yang UI and repeat the same exercise with a topology-id
of `topology-netconf` and a node-id of `iosxrv-1`. In this case, you
will will be able to use the "Display mount point" button in the
middle bar to show the schemas for this node that were queried from it
when it was mounted.

As an aside, the "Display mount point" button was also available for
the OpenFlow nodes, but there are no actual mount points to display
for the OpenFlow nodes.

In the case of the XRv node, the "Modules" panel will change to show a
`yang-ext` node, which you can expand by clicking on the `+` symbol.
Drilling into the data model in this way, you will be able to
get to the `interface-configurations` model element after scrolling
about half way down. Note that there is a delay after expanding the `mount`
node, caused by the large number of schema that are being loaded.

When you select the `interface-configurations` node, the middle bar
will change to to show a request with the topology-id set to
`topology-netconf`, and the node-id field will have the value
`iosxrv-1`.

You can use the "Request history" to copy that URL and try it in
Postman. The JSON result document shown after you send that request
will show the node, with its Netconf connection
attributes, and a list of `available-capabilities`, within which the
`available-capability` element contains a comma-separated list of Yang
schema references.

These Yang schema represent models that can be used to form RESTCONF
requests to ODL, which will, in turn, make Netconf requests to the
node. They represent what can be done with the node via Netconf and
so are called the node ["capabilities"](https://tools.ietf.org/html/rfc6241#section-1.3).

The schema files for the Yang models are stored by ODL in a
`cache/schemas` directory, where the `cache` directory is a peer of
the `bin` directory containing the `karaf` executable. In the
`cache/schemas` directory you will see all of the schema files
underlying the models and URLs that you have been looking at above.

In the case of the [`network-topology` model](https://www.ietf.org/proceedings/87/slides/slides-87-netmod-3.pdf), you will see that there
are actually two schema files in the directory. If you examine the Yang UI, you
will see that the latest, with a date of `2013-10-21` is being
used. You can open the corresponding schema file
`net-topology@2013-12-21.yang` with gedit to look at its contents.

You can then use a combination of the Yang UI and Postman to see how
the schema elements map to the model displayed in the Yang UI and the
URLs in Postman. Note, for example, that the `topology-id` schema
field has the value `topology-netconf` in the model and URL, This is a
key value as denoted by the key symbol in the Yang UI. Note also
the `network-topology` container in the schema, which contains a list of
`topology`. One of these was the OpenFlow `flow:1` topology, and
another is the `topology-netconf`.

After understanding topology, which is fundamental to networking, you
can look at the model schema behind the `interface-configuration`
element you worked with above. You can go back to that element in the
Yang UI and copy the URL to use in Postman.

What you wil see in the Postman JSON result document is the
`interface-configurations` list element, within which is an
`interface-configuration` element for the `MgmtEth0/0/CPU/0`
interface. This is the management interface on the XRv node, which
has been configured with the `172.16.1.11` IPv4 address.

You will also see in the URL, after the `yang-ext:mount` element, the
name of the Yang schema that defines the model that the result
document is based on: `Cisco-IOS-XR-ifmgr-cfg`. You can copy the
schema name from the URL
and look for the schema file in `cache/schemas` as before.

As before, with topology, you can compare the elements of the schema
with the elements in the JSON document and the URL and see how the URL
and data model are derived from the schema.

The next step is to drill down into the specific interface within that
data. Return to the Yang UI and select the `interface-configuration
{active} {interface-name}` element in the Modules view at the top,
within the `interface-configurations` element.

In the middle bar, you will see the request fields populated with the
appropriate values, including the interface name. If you "Send" the
request, though, you will see an error.

The issue here is that the interface name has `\` characters in it. As
the request is sent as a URL, the `\`s in the name are interpreted as
delimiters in the model description, not as part of the name of the
`node-id` element. This is a common issue in REST interfaces, and the
solution is to "encode" the name.

In the bookmarks bar for Chrome you will see a link to a "URL
Decoder/Encoder". Use the Yang UI to go back up the model a level, and
then copy the string literal of the interface name and paste it into
the field of the "URL Decoder/Encoder", and then click on
"Encode". Copy the result, which will have `%2F` to represent the `\`s
and paste that into the `node-id` field in the Yang UI, and send
the request.

You now have a request URL in the request history that you can use in
Postman. Copy that URL, go to Postman, paste and send the URL, and you now have a
result document which is the `interface-configuration` for that
specific interface.

You can now drill into that data model by copying the element names
from the JSON document and adding them to the URL. You can drill down
as far as the `primary` address field using this technique.

**Warning**

The instructions above do work on the Dev VM, but sometimes do not
when, for example, ODL suffers memory leaks.

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






