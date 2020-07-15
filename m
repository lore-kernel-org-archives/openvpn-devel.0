From: David Sommerseth <davids@...515...>
Date: Thu, 16 Jul 2020 00:30:08 +0200
Message-Id: <20200715223013.11726-12-davids@...515...>
In-Reply-To: <20200715223013.11726-1-davids@...515...>
References: <20200715223013.11726-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 11/16] doc/man: Cleaned up the examples
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Removed a lot of outdated information.  The loading of the tun module is
not needed on current Linux distributions; it is automatically loaded
when needed.

Also removed all the iptables references and rather refer the reader to
figure out how firewalling is configured on their system.  The reason is
that iptables is moving towards being deprecated in faviour of
nftables/nft.  In addition many Linux distributions provide their own
wrappers around it (ufw, firewalld, to mention a couple).  In addition
it makes the man page less Linux-centric.

The only Linux specific reference left is configuration of IP
forwarding.  But extended the text to ask the reader to find the
preferred way of configuring IP forwarding in a persistent way.  Many
Linux distributions uses their own set of network configuration tools as
well (NetworkManager, systemd-networkd, netplan, to mention a few).

The rest of the instructions should be fairly OS neutral and is a quick
introduction how to get tunnels configured and gradually expand the
configuration and improve the security along the way.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/man-sections/examples.rst | 105 ++++------------------------------
 1 file changed, 11 insertions(+), 94 deletions(-)

diff --git a/doc/man-sections/examples.rst b/doc/man-sections/examples.rst
index 0bea7f5a..ecc2a29f 100644
--- a/doc/man-sections/examples.rst
+++ b/doc/man-sections/examples.rst
@@ -7,32 +7,12 @@ installed OpenVPN, consult the INSTALL file included in the OpenVPN
 distribution.
 
 
-TUN/TAP Setup:
---------------
-
-If you are using Linux 2.4 or higher, make the tun device node and load
-the tun module:
-
-::
-
-    mknod /dev/net/tun c 10 200
-    modprobe tun
-
-If you installed from RPM, the ``mknod`` step may be omitted, because
-the RPM install does that for you.
-
-Only Linux 2.4 and newer are supported.
-
-For other platforms, consult the INSTALL file at
-https://openvpn.net/community-resources/the-standard-install-file-included-in-the-source-distribution/
-for more information.
-
-
 Firewall Setup:
 ---------------
 
 If firewalls exist between the two machines, they should be set to
-forward UDP port 1194 in both directions. If you do not have control
+forward the port OpenVPN is configured to use, in both directions.
+The default for OpenVPN is 1194/udp.  If you do not have control
 over the firewalls between the two machines, you may still be able to
 use OpenVPN by adding ``--ping 15`` to each of the ``openvpn`` commands
 used below in the examples (this will cause each peer to send out a UDP
@@ -40,13 +20,8 @@ ping to its remote peer once every 15 seconds which will cause many
 stateful firewalls to forward packets in both directions without an
 explicit firewall rule).
 
-If you are using a Linux iptables-based firewall, you may need to enter
-the following command to allow incoming packets on the TUN device:
-
-:code:`iptables -A INPUT -i tun+ -j ACCEPT`
-
-See the firewalls section below for more information on configuring
-firewalls for use with OpenVPN.
+Please see your operating system guides for how to configure the firewall
+on your systems.
 
 
 VPN Address Setup:
@@ -239,10 +214,14 @@ enable routing:
 
     echo 1 > /proc/sys/net/ipv4/ip_forward
 
-and enable TUN packet forwarding through the firewall:
-::
+This setting is not persistent.  Please see your operating systems
+documentation how to properly configure IP forwarding, which is also
+persistent through system boots.
 
-   iptables -A FORWARD -i tun+ -j ACCEPT
+If you system is configured with a firewall.  Please see your operating
+systems guide on how to configure the firewall.  You typically want to
+allow traffic coming from and going to the tun/tap adapter OpenVPN is
+configured to use.
 
 On bob:
 ::
@@ -260,65 +239,3 @@ Now any machine on the *10.0.0.0/24* subnet can access any machine on the
 In a production environment, you could put the route command(s) in a
 script and execute with the ``--up`` option.
 
-
-FIREWALLS
-=========
-
-OpenVPN's usage of a single UDP port makes it fairly firewall-friendly.
-You should add an entry to your firewall rules to allow incoming OpenVPN
-packets. On Linux 2.4+:
-::
-
-   iptables -A INPUT -p udp -s 1.2.3.4 --dport 1194 -j ACCEPT
-
-This will allow incoming packets on UDP port :code:`1194` (OpenVPN's
-default UDP port) from an OpenVPN peer at :code:`1.2.3.4`.
-
-If you are using HMAC-based packet authentication (the default in any of
-OpenVPN's secure modes), having the firewall filter on source address
-can be considered optional, since HMAC packet authentication is a much
-more secure method of verifying the authenticity of a packet source. In
-that case:
-::
-
-   iptables -A INPUT -p udp --dport 1194 -j ACCEPT
-
-would be adequate and would not render the host inflexible with respect
-to its peer having a dynamic IP address.
-
-OpenVPN also works well on stateful firewalls. In some cases, you may
-not need to add any static rules to the firewall list if you are using a
-stateful firewall that knows how to track UDP connections. If you
-specify ``--ping n``, OpenVPN will be guaranteed to send a packet to its
-peer at least once every ``n`` seconds. If ``n`` is less than the
-stateful firewall connection timeout, you can maintain an OpenVPN
-connection indefinitely without explicit firewall rules.
-
-You should also add firewall rules to allow incoming IP traffic on TUN
-or TAP devices such as:
-::
-
-   iptables -A INPUT -i tun+ -j ACCEPT
-
-to allow input packets from tun devices,
-::
-
-   iptables -A FORWARD -i tun+ -j ACCEPT
-
-to allow input packets from tun devices to be forwarded to other hosts
-on the local network,
-::
-
-   iptables -A INPUT -i tap+ -j ACCEPT
-
-to allow input packets from tap devices, and
-::
-
-   iptables -A FORWARD -i tap+ -j ACCEPT
-
-to allow input packets from tap devices to be forwarded to other hosts
-on the local network.
-
-These rules are secure if you use packet authentication, since no
-incoming packets will arrive on a TUN or TAP virtual device unless they
-first pass an HMAC authentication test.  
-- 
2.26.0


