From: James Yonan <jim@...41...>
Message-ID: <Pine.LNX.4.58.0509062125110.12112@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] New subnet topology feature ready for testing
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Sep  8 02:37:09 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

OpenVPN Addressing Topology
---------------------------

OpenVPN addressing topology has been the subject of considerable debate,
specifically the /30 addressing scheme, where each tun client is allocated
a dynamic /30 subnet, so as to play nicely with the limitations of the 
TAP-Win32 driver.

Neil Brown suggested back in 2004 that OpenVPN should support the ability
to configure tun interfaces as a subnet, i.e. with an IP and netmask,
rather than the traditional point-to-point semantics of local endpoint and
remote endpoint:

http://openvpn.net/archive/openvpn-devel/2004-07/msg00056.html

While an interested idea, it didn't get much traction at the time because
the TAP-Win32 driver didn't support being configured with an IP/netmask in
tun mode.

But the discussion continued, and more recently we hit upon the idea to
use a proxy-ARP mechanism to allow the TAP-Win32 driver to support
tun-mode subnets:

http://openvpn.net/archive/openvpn-devel/2005-06/msg00017.html

The result, which I've just completed, is a patch to 2.0 which 
supports a new "topology" directive in "dev tun" mode.

"topology net30" is the current default which is supported by the current 
2.0.x releases.  This tells the OpenVPN server to hand out /30 subnets to 
connecting clients.

"topology p2p" sets true point-to-point semantics.  This was previously 
known in 2.0.x as "ifconfig-pool-linear".  The problem with this option is 
that it didn't work with Windows clients, so its applicability was 
limited.

However, now I've put together a brand new topology, called "topology
subnet".  This topology is very intuitive, like the "dev tap" topology
where each client gets a single IP address from a pool, the server gets
the .1 address, clients get .2, .3, .4, etc., and all clients and the
server can communicate by virtue of possessing a single IP address taken
out of the shared VPN subnet.  Plus -- a very cool property of this
feature is that it works on Windows clients as well as any *nix system
which supports tun interfaces being configured by ifconfig with an
IP/netmask rather than the usual local and remote endpoint (Linux supports 
this, I haven't tried any of the BSDs yet).

So far my testing has gone very well, with a Linux server + Linux 
and Windows XP clients.  At this point, I'd like to get more people 
involved in testing this feature.

Please Test!
------------

Download openvpn-2.0.2_TO1 from http://openvpn.net/beta/to/

Tarball, zip, and Windows installer is provided.  In order to use the new
topology feature, all clients and servers must be updated to this release.  

Testing is quite easy.  Simply add this line to your "dev tun" based 
server config:

  topology subnet

If you have an ifconfig-pool-persist file, delete it so that OpenVPN will 
be free of any previously existing associations.

If your server has a standard "server" directive such as

  server 10.8.0.0 255.255.255.0

you will see your server take 10.8.0.1, client #1 will take 10.8.0.2, 
client #2 will take 10.8.0.3, etc.

Other interesting features
--------------------------

"redirect-gateway bypass-dhcp" gets around the problem of DHCP packets 
to the local DHCP server being incorrectly routed into the tunnel.

Merging Schedule
----------------

With sufficient testing, this code will be a candidate for inclusion in 
2.1 or higher, and will be applicable to the 2.0.x branch via manual 
merging.  While this patch is not huge, it's deep enough that I don't plan 
on merging it in 2.0.x anytime soon.

Change Log
----------

2005.09.07 -- Version 2.0.2-TO1

* Added --topology directive.  See man page.
* Added --redirect-gateway bypass-dhcp option to add a route
  allowing DHCP packets to bypass the tunnel, when the
  DHCP server is non-local.  Currently only implemented
  on Windows clients (Developers: to port this feature to other
  OSes, write a get_dhcp_server_addr function in route.c).
* Modified OpenVPN Service on Windows to declare the DHCP
  client service as a dependency.
* Extended the plugin interface to allow plugins to declare
  per-client constructor and destructor functions, to make
  it simpler for plugins to maintain per-client state.

Excerpts from Man Page
----------------------

       --topology mode
              Configure  virtual addressing topology when running
              in --dev tun mode.  This directive has  no  meaning
              in  --dev  tap  mode,  which  always  uses a subnet
              topology.

              If you  set  this  directive  on  the  server,  the
              --server  and --server-bridge directives will auto
              matically push  your  chosen  topology  setting  to
              clients  as well.  This directive can also be manu
              ally pushed to clients.  Like the --dev  directive,
              this  directive  must  always be compatible between
              client and server.

              mode can be one of:

              net30 -- Use a point-to-point topology, by allocat
              ing one /30 subnet per client.  This is designed to
              allow point-to-point semantics when some or all  of
              the  connecting  clients  might be Windows systems.
              This is the default on OpenVPN 2.0.

              p2p -- Use a point-to-point topology where the  re
              mote  endpoint of the client's tun interface always
              points to the local endpoint of  the  server's  tun
              interface.  This mode allocates a single IP address
              per connecting client.  Only use when none  of  the
              connecting  clients are Windows systems.  This mode
              is functionally equivalent to the  --ifconfig-pool-
              linear  directive which is available in OpenVPN 2.0
              and is now deprecated.

              subnet -- Use a subnet rather than a point-to-point
              topology  by  configuring  the tun interface with a
              local IP address and subnet mask,  similar  to  the
              topology  used  in  --dev tap and ethernet bridging
              mode.  This mode allocates a single IP address  per
              connecting  client  and  works  on Windows as well.
              Only available when server and clients are  OpenVPN
              2.1 or higher, or OpenVPN 2.0.x which has been man
              ually patched with the --topology  directive  code.
              When used on Windows, requires version 8.2 or high
              er of the TAP-Win32 driver.  When used on *nix, re
              quires  that the tun driver supports an ifconfig(8)
              command which sets a subnet  instead  of  a  remote
              endpoint IP address.

James

