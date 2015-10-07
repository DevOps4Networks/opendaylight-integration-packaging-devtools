See this video of how to use these instructions: https://youtu.be/ToIFalBYooA

Mininet (http://mininet.org/) creates a realistic virtual network, running real kernel, switch and application code, on a single machine (VM, cloud or native), in seconds, with a single command, e.g.:

```bash
sudo mn --controller=remote,ip=127.0.0.1 --topo tree,3
```

Because you can easily interact with your network using the Mininet CLI (and API), customize it, share it with others, or deploy it on real hardware, Mininet is useful for development, teaching, and research.

Mininet is also a great way to develop, share, and experiment with OpenFlow and Software-Defined Networking systems. In particular the OpenDaylight controller, by following the instructions below:

Open a terminal window (Ctrl-Alt-t) and type and enter:

```bash
sudo mn --controller=remote,ip=127.0.0.1 --topo tree,3
```

Where the sudo password is " ODLDEV" by default. Note that best results are achieved if mininet is started *before* ODL is started.

Either, build, if necessary, and start ODL, using the desktop icons, OR

Open the README and follow the instructions to start ODL. In summary, those instructions are:

 - Download a controller bundle from OpenDaylight, using the bookmark link in Chrome
 - Open a terminal window with Ctrl-Alt-t
 - `cd ~/Downloads`
 - `tar xf` the bundle file, and `mv distribution-karaf-0.3.0-Lithium ..` (the name may change over time)
 - `cd ~/distribution-karaf-0.3.0-Lithium/bin`
 - `./karaf`
 - `opendaylight-user@root>feature:install <feature list from odl.cfg>`
 - Wait, for at least five minutes, for ODL to start up and for the karaf prompt to reappear

- Use the "Lithium DLUX" bookmark in Chrome to display the DLUX UI, login "admin/admin"

Then you should expect to see the network topology displayed, and you should be able to select the "Nodes" application icon on the left to see a summary of the nodes.

**Warning**

The instructions above do work on the Dev VM, but sometimes do not when, for example, the ovs-controller crashes.

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


