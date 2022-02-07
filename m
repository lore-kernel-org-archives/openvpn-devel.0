From: Antonio Quartulli <a@...2181...>
Date: Mon,  7 Feb 2022 16:57:57 +0100
Message-Id: <20220207155757.22314-1-a@...2181...>
In-Reply-To: <Yf1iUkDpsV/wuk0X@...1296...>
References: <Yf1iUkDpsV/wuk0X@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Get rid of README.IPv6 and TODO.IPv6
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
Cc: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>

README.IPv6 is quite useless because IPv6 is not a second
class citizen anymore. Most of the content is "obvious" or explained in
the manpage along with other details/options.

TODO.IPv6 is old and many implemented things are still reported there
for no clear reason. Delete file and report still open items in our
tracking system.

Cc: Gert Doering <gert@...1296...>
Signed-off-by: Antonio Quartulli <a@...2181...>

---

Changes from v1:
* drop TODO.IPv6 and open tickets in trac for open items:
https://community.openvpn.net/openvpn/ticket/354
https://community.openvpn.net/openvpn/ticket/1449
https://community.openvpn.net/openvpn/ticket/1450
https://community.openvpn.net/openvpn/ticket/1451

---
 Makefile.am |   2 -
 README.IPv6 |  56 --------------
 TODO.IPv6   | 215 ----------------------------------------------------
 3 files changed, 273 deletions(-)
 delete mode 100644 README.IPv6
 delete mode 100644 TODO.IPv6

diff --git a/Makefile.am b/Makefile.am
index 3f0fdd4c..72618e9d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -54,7 +54,6 @@ SUBDIRS = build distro include src sample doc tests
 
 dist_doc_DATA = \
 	README \
-	README.IPv6 \
 	README.mbedtls \
 	Changes.rst \
 	COPYRIGHT.GPL \
@@ -64,7 +63,6 @@ dist_noinst_DATA = \
 	.gitignore \
 	.gitattributes \
 	PORTS \
-	README.IPv6 TODO.IPv6 \
 	README.mbedtls \
 	openvpn.sln \
 	msvc-env.bat \
diff --git a/README.IPv6 b/README.IPv6
deleted file mode 100644
index 18068fee..00000000
--- a/README.IPv6
+++ /dev/null
@@ -1,56 +0,0 @@
-Since 2.3.0, OpenVPN officially supports IPv6, and all widely used
-patches floating around for older versions have been integrated.
-
-IPv6 payload support
---------------------
-
-This is for "IPv6 inside OpenVPN", with server-pushed IPv6 configuration
-on the client, and support for IPv6 configuration on the tun/tap interface
-from within the openvpn config.
-
-The code in 2.3.0 supersedes the IPv6 payload patches from Gert Doering,
-formerly located at http://www.greenie.net/ipv6/openvpn.html
-
-
-The following options have been added to handle IPv6 configuration,
-analogous to their IPv4 counterparts (--server <-> --server-ipv6, etc.)
-
-     - server-ipv6
-     - ifconfig-ipv6
-     - ifconfig-ipv6-pool
-     - ifconfig-ipv6-push
-     - route-ipv6
-     - iroute-ipv6
-
-see "man openvpn" for details how they are used.
-
-
-
-IPv6 transport support
-----------------------
-
-This is to enable OpenVPN peers or client/servers to talk to each other
-over an IPv6 network ("OpenVPN over IPv6").
-
-The code in 2.3.0 supersedes the IPv6 transport patches from JuanJo Ciarlante,
-formerly located at http://github.com/jjo/openvpn-ipv6
-
-OpenVPN 2.4.0 includes a big overhaul of the IPv6 transport patches
-originally implemented for the Android client (ics-openvpn)
-
-IPv4/IPv6 transport is automatically is selected when resolving addresses.
-Use a 6 or 4 suffix to force IPv6/IPv4:
-
-  --proto udp6
-  --proto tcp4
-  --proto tcp6-client
-  --proto tcp4-server
-  --proto tcp6 --client / --proto tcp6 --server
-
-On systems that allow IPv4 connections on IPv6 sockets
-(all systems supporting IPV6_V6ONLY setsockopt), an OpenVPN server can
-handle IPv4 connections on the IPv6 socket as well, making it a true
-dual-stacked server. Use bind ipv6only to disable this behaviour.
-
-On other systems, as of 2.3.0, you need to run separate server instances
-for IPv4 and IPv6.
diff --git a/TODO.IPv6 b/TODO.IPv6
deleted file mode 100644
index 465eaa66..00000000
--- a/TODO.IPv6
+++ /dev/null
@@ -1,215 +0,0 @@
-TODO for IPv6 payload support
------------------------------
-
-1.) "--topology subnet" doesn't work together with IPv6 payload on FreeBSD
-    (verified for FreeBSD server, Linux/ifconfig client, problems 
-    with ICMP6 neighbor solicitations from BSD not being answered by Linux)
-
-    * 2012-01-22 fixed in platform cleanup, commit 62c613d46dc495d74
-
-2.) NetBSD IPv6 support doesn't work
-    ("connected" route is not auto-created, "route-ipv6" adding fails)
-
-    * fixed, 3.1.10 *
-
-3.) route deletion for IPv6 routes is not yet done
-
-    * fixed for configured routes, 3.1.10 *
-    * missing for manual-ifconfig-connected (NetBSD, Darwin, Win32)
-
-    * 2012-06-10 - fixed somewhere in 2010
-
-4.) do "ifconfig tun0 inet6 unplumb"  or "ifconfig tun0 destroy" for
-    Solaris, *BSD, ... at program termination time, to clean up leftovers
-    (unless tunnel persistence is desired).
-
-    For Solaris, only the "ipv6 tun0" is affected, for the *BSDs all tun0
-    stay around.
-
-    * 2012-06-10 - fixed in individual platform cleanups early-2012
-
-4a.) deconfigure IPv6 on tun interface on session termination, otherwise
-    one could end up with something like this (on NetBSD):
-
-tun0: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1500
-        inet 10.9.0.18 -> 10.9.0.17 netmask 0xffffffff
-        inet6 fe80::a00:20ff:fece:d299%tun0 ->  prefixlen 64 scopeid 0x3
-        inet6 2001:608:4:eff::2000:3 ->  prefixlen 64
-        inet6 2001:608:4:eff::1:3 ->  prefixlen 64
-
-    (pool was changed, previous address still active on tun0, breakage)
-
-    * semi-fixed for NetBSD, 28.2.10, always do tun0 destroy / tun0 create
-      before actual ifconfig -- tunnel still lingers after OpenVPN quits
-
-    * 2011-09-16 fixed in platform cleanup, commit 8ca19c014c149cf69
-
-4b.) verify this - on FreeBSD, tun0 is auto-destroyed if created by
-     opening /dev/tun (and lingers if created by "ifconfig tun0 create")
-
-     -> use for persistent tunnels on not-linux?
-
-    * 2012-06-10 tun interface behaviour is documented in "man tun(4)"
-
-5.) add new option "ifconfig-ipv6-push"
-    (per-client static IPv6 assignment, -> radiusplugin, etc)
-
-    * implemented, 14.1.10 *
-
-6.) add new option "route-ipv6-gateway"
-
-    * 2012-06-09 - decided there is no current need (but fairly trivial)
-
-7.) add "full" gateway handling for IPv6 in route.c 
-    (right now, the routes are just sent down the tun interface, if the
-    operating system in questions supports that, without care for the
-    gateway address - which does not work for gateways that are supposed
-    to point elsewhere.  Also, it doesn't work for TAP interfaces.
-
-    * 2012-06-09 use "dev tun" for tun devices, "via $gateway" for tap
-		 (and purposely do not support off-link routes)
-
-8.) full IPv6 support for TAP interfaces 
-    (main issue should be routes+gateway - and testing :-) )
-
-    test 2010/09/24: TAP itself works on linux/ifconfig+iproute2, but 
-    route-via-tap doesn't work at all (route points to "tap0" which fails)
-
-17:51:14.075412 fe:ab:6e:c5:53:71 > 33:33:ff:00:00:01, ethertype IPv6 (0x86dd), length 86: 2001:608:4:a053::1:0 > ff02::1:ff00:1: ICMP6, neighbor solicitation, who has 2001:608:4:a001::1, length 32
-
-    * 2012-06-09 missing gateway support implemented
-
-8a.)
-    how is iroute-via-tap supposed to work??
-
-    * 2012-06-10 - answer: not at all, OpenVPN doesn't do "iroute" in
-    tap mode - set up "route-ipv6" with gateway address = individual
-    client's tap0 address to get the per-client routes
-
-
-9.) verify that iroute-ipv6 and route-ipv6 interact in the same way as
-    documented for iroute/route:
-
-    A's subnet, OpenVPN must push this route to all clients
-    EXCEPT for A, since the subnet is already owned by A.
-    OpenVPN accomplishes this by not
-    not pushing a route to a client
-    if it matches one of the client's iroutes.
-
-10.) extend "ifconfig-ipv6" to handle specification of /netbits, pushing
-    of /netbits, and correctly ifconfig'ing this
-    (default, if not specified: /64)
-
-    * done * 2012-02-03
-
-11.) do not add ipv6-routes if tun-ipv6 is not set - complain instead
-
-     * done * 12.1.10
-
-12.) handle incoming [::] and [fe80:...] packets in tun-p2mp MULTI mode
-     (most likely those are DAD packets)
-     silently ignore DAD?  
-        Or accept-and-forward iff (multicast && client2client)?
-     handle NS/NA
-
-13.) from Martin List-Petersen:
-
-	One thing, and I guess this requires modifications in
-	network-manager-openvpn: It also works, BUT ignores "push
-	route-ipv6-gateway" and "push route-ipv6 ...." (obviously routes pushed
-	from the server) entirely.
-
-14.) from ##openvpn-discussion:
-
-	new features should be #ifdef'ed
-
-	(check whether this is feasible at all)
-
-15.) IPv6 related environment variables
-
-	- document all of them in openvpn.8
-	- make sure that all existing IPv4 stuff has IPv6 counterparts
-
-16.) OpenBSD
-	- implement ifconfig/route for IPv6
-	- revert ifconfig/open_tun order to "normal" (separate commit!!!)
-	  (openvpn-devel, Subject: OpenBSD)
-	- test
-
-    * 2012-02-05 platform cleanup, commit 82d4e12068774b0a6ca
-
-17.) client-option (Elwood)
-	- ignore-v6-push-options yes/no
-	- ignore-v6-route-push  ("as for IPv4 routes")
-
-18.) fail-save?  "what if 'ip -6 addr add' fails" -> fail, or fallback to v4?
-	(-> recomment setting "ignore-v6-push-options yes")
-
-19.) safety check: if connecting over IPv6 (v6 transport) and the pushed
-     route-ipv6 network encompasses the server IPv6 address, make sure 
-     we at least log a warning (until we can fiddle with external routing
-     to make this work correctly).
-
-20.) show "route add" / "route delete" commands for IPv6 in log file
-     (we show the "ifconfig" commands, so why not the routes?)
-
-     2010-08-07: this is a null-feature - it's already there, but with
-                 different debug level (M_INFO vs. D_ROUTE) so user 
-                 didn't notice
-
-21.) enable ipv6-only server operations
-      - decouple ipv6 pool handling from ipv4 pool
-      - make sure Rest of OpenVPN doesn't assume "there will always be IPv4"
-
-22.) implement --learn-address for IPv6
-
-23.) FreeBSD 8 seems to require explicit setting of the "ifconfig" IPv6
-     route, while FreeBSD 6+7 don't --> more testing, and code fix
-
-     workaround for the time being: just add
-
-	server-ipv6 2001:608:4:a051::/64
-	route-ipv6 2001:608:4:a051::/64
-
-    to the config
-
-    (problem + workaround applies both to tun and tap style devices)
-
-    * 2012-06-09 - this got fixed in one of the platform cleanups
-
-
-
-
-TODO for IPv6 transport support
--------------------------------
-
-[ Last updated: 2014-01-03. ]
-
-* All platforms:
-  o mgmt console: as currently passes straight in_addr_t bits around
-
-  o make possible to get AF from getaddrinfo() answer, ie allow openvpn to
-    use ipv4/6 if DNS returns A/AAAA without specifying protocol.
-    Hard: requires deep changes in initialization/calling logic
-    - Done by dual stack patches
-
-  o use AI_PASSIVE
-    - Done by dual stack patches
-
-  o the getaddr()/getaddr6() interface is not prepared for handling socktype
-    "tagging", currently I abuse the sockflags bits for getting the ai_socktype
-    downstream.
-    - Still done by flags, seems clean enough.
-
-  o implement comparison for mapped addresses: server in dual stack
-    listening IPv6 must permit incoming streams from allowed IPv4 peer,
-    currently you need to pass eg:  --remote ffff::1.2.3.4
-    - OpenVPN will compare all address of a remote
-      but will still fail on mapped addresses
-
-* win32:
-  o find out about mapped addresses, as I can't make it work
-    with bound at ::1 and connect to 127.0.0.1
-    - Should be fixed by 8832c6c - "Implement listing on IPv4/IPv6 dual 
-      socket on all platform"
-
-- 
2.34.1


