From: Gert Doering <gert@...1296...>
Date: Fri, 25 Jan 2013 12:39:14 +0100
Message-Id: <1359113954-25768-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Update README.IPv6 to match what is in 2.3.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

IPv6 is no longer provided by external patches - all has been
integrated.  Document that fact, point at the new configuration options,
and at potential caveats.
---
 README.IPv6 |  140 +++++++++++++++++++++++------------------------------------
 1 files changed, 55 insertions(+), 85 deletions(-)

diff --git a/README.IPv6 b/README.IPv6
index d504f4f..5f77088 100644
--- a/README.IPv6
+++ b/README.IPv6
@@ -1,97 +1,67 @@
+Since 2.3.0, OpenVPN officially supports IPv6, and all widely used
+patches floating around for older versions have been integrated.
+
 IPv6 payload support
 --------------------
 
-Latest IPv6 payload support code and documentation can be found from here:
+This is for "IPv6 inside OpenVPN", with server-pushed IPv6 configuration
+on the client, and support for IPv6 configuration on the tun/tap interface
+from within the openvpn config.
+
+The code in 2.3.0 supersedes the IPv6 payload patches from Gert Doering, 
+formerly located at http://www.greenie.net/ipv6/openvpn.html
 
-  http://www.greenie.net/ipv6/openvpn.html
 
-For TODO list, see TODO.IPv6.
+The following options have been added to handle IPv6 configuration, 
+analogous to their IPv4 counterparts (--server <-> --server-ipv6, etc.)
 
-Gert Doering, 31.12.2009
+     - server-ipv6
+     - ifconfig-ipv6
+     - ifconfig-ipv6-pool
+     - ifconfig-ipv6-push
+     - route-ipv6
+     - iroute-ipv6
+
+see "man openvpn" for details how they are used.
 
 
 
 IPv6 transport support
 ----------------------
 
-[ Last updated: 25-Mar-2011. ]
-
-OpenVPN-2.1 over UDP6/TCP6 README for ipv6-0.4.x patch releases:
-( --udp6 and --tcp6-{client,server} )
-
-* Availability
-  Source code under GPLv2 from http://github.com/jjo/openvpn-ipv6
-
-  Distro ready repos/packages:
-  o Debian sid official repo, by Alberto Gonzalez Iniesta,
-    starting from openvpn_2.1~rc20-2
-  o Gentoo official portage tree, by Marcel Pennewiss:
-    - https://bugs.gentoo.org/show_bug.cgi?id=287896
-  o Ubuntu package, by Bernhard Schmidt:
-    - https://launchpad.net/~berni/+archive/ipv6/+packages
-  o Freetz.org, milestone freetz-1.2
-    - http://trac.freetz.org/milestone/freetz-1.2
-
-* Status:
-  o OK:
-    - upd6,tcp6: GNU/Linux, win32, openbsd-4.7, freebsd-8.1
-    - udp4->upd6,tcp4->tcp6 (ipv4/6 mapped): GNU/Linux
-      (gives a warning on local!=remote proto matching)
-  o NOT:
-    - win32: tcp4->tcp6 (ipv4/6 mapped) fails w/connection refused
-  o NOT tested:
-    - mgmt console
-
-* Build setup:
-  ./configure --enable-ipv6        (by default)
-
-* Usage:
-  For IPv6 just specify "-p upd6" an proper IPv6 hostnames, adapting the example
-  from man page ...
-
-  On may:
-    openvpn --proto udp6 --remote <june_IPv6_addr> --dev tun1 \
-      --ifconfig 10.4.0.1 10.4.0.2 --verb 5 --secret key
-
-  On june:
-    openvpn --proto udp6 --remote <may_IPv6_addr>  --dev tun1 \
-      --ifconfig 10.4.0.2 10.4.0.1 --verb 5 --secret key
-
-  Same for --proto tcp6-client, tcp6-server.
-
-* Main code changes summary:
-  - socket.h: New struct openvpn_sockaddr type that holds sockaddrs and pktinfo,
-    (here I omitted #ifdef USE_PF_xxxx, see socket.h )
-
-    struct openvpn_sockaddr {
-	union {
-		struct sockaddr sa;
-		struct sockaddr_in in;
-		struct sockaddr_in6 in6;
-	} addr;
-    };
-
-    struct link_socket_addr
-    {
-            struct openvpn_sockaddr local;
-            struct openvpn_sockaddr remote;
-            struct openvpn_sockaddr actual;
-    };
-
-    PRO: allows simple type overloading: local.addr.sa, local.addr.in, local.addr.in6 ... etc
-    (also local.pi.in and local.pi.in6)
-
-  - several function prototypes moved from sockaddr_in to openvpn_sockaddr
-  - several new sockaddr functions needed to "generalize" AF_xxxx operations:
-    addr_copy(), addr_zero(), ...etc
-    proto_is_udp(), proto_is_dgram(), proto_is_net()
-
-* For TODO list, see TODO.IPv6
-
---
-JuanJo Ciarlante   jjo () google () com ............................
-:                                                                  :
-.                                         Linux IP Aliasing author .
-.   Modular algo (AES et all) support for FreeSWAN/OpenSWAN author .
-.                                        OpenVPN over IPv6 support .
-:......     plus other scattered free software bits in the wild ...:
+This is to enable OpenVPN peers or client/servers to talk to each other
+over an IPv6 network ("OpenVPN over IPv6").
+
+The code in 2.3.0 supersedes the IPv6 transport patches from JuanJo Ciarlante,
+formerly located at http://github.com/jjo/openvpn-ipv6
+
+
+Use the following options to select IPv6 transport:
+
+  --proto udp6
+  --proto tcp6-client
+  --proto tcp6-server
+  --proto tcp6 --client / --proto tcp6 --server
+
+On systems that permit IPv4 connections on IPv6 sockets (Linux by
+default, FreeBSD and NetBSD if you turn off the "v6only" sysctl by
+running "sysctl -w net.inet6.ip6.v6only=0"), an OpenVPN server can
+handle IPv4 connections on the IPv6 socket as well, making it a true 
+dual-stacked server.  
+
+On other systems, as of 2.3.0, you need to run separate server instances 
+for IPv4 and IPv6.
+
+The client side code is not really "dual-stacked" yet, as it does not
+automatically try both address families when connecting to a dual-stacked 
+server.  For now, you can achieve this with <connection> stanzas in your
+openvpn config:
+
+  <connection>
+     remote my.dual.stack.server 1194 udp6
+  </connection>
+  <connection>
+     remote my.dual.stack.server 1194 udp
+  </connection>
+
+
-- 
1.7.8.6


