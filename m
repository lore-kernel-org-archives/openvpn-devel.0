From: Arne Schwabe <arne@...1227...>
Date: Fri,  3 Jan 2014 15:49:40 +0100
Message-Id: <1388760580-7548-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Update IPv6 related readme files
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

---
 README.IPv6 | 29 ++++++++++-------------------
 TODO.IPv6   | 11 +++++++++--
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/README.IPv6 b/README.IPv6
index 56c97ab..3d8fbeb 100644
--- a/README.IPv6
+++ b/README.IPv6
@@ -35,31 +35,22 @@ over an IPv6 network ("OpenVPN over IPv6").
 The code in 2.3.0 supersedes the IPv6 transport patches from JuanJo Ciarlante,
 formerly located at http://github.com/jjo/openvpn-ipv6
 
+Android 2.4.0 includes a big overhaul of the IPv6 transport patches 
+originally implemented for the Android client (ics-openvpn)
 
-Use the following options to select IPv6 transport:
+IPv4/IPv6 transport is automatically is selected when resolving addresses.
+Use a 6 or 4 suffix to force IPv6/IPv4:
 
   --proto udp6
+  --proto tcp4
   --proto tcp6-client
-  --proto tcp6-server
+  --proto tcp4-server
   --proto tcp6 --client / --proto tcp6 --server
 
-On systems that permit IPv4 connections on IPv6 sockets (Linux by
-default, FreeBSD and NetBSD if you turn off the "v6only" sysctl by
-running "sysctl -w net.inet6.ip6.v6only=0"), an OpenVPN server can
+On systems that allow IPv4 connections on IPv6 sockets
+(all systems supporting IPV6_V6ONLY setsockopt), an OpenVPN server can
 handle IPv4 connections on the IPv6 socket as well, making it a true
-dual-stacked server.
+dual-stacked server. Use bind ipv6only to disable this behaviour.
 
 On other systems, as of 2.3.0, you need to run separate server instances
-for IPv4 and IPv6.
-
-The client side code is not really "dual-stacked" yet, as it does not
-automatically try both address families when connecting to a dual-stacked
-server.  For now, you can achieve this with <connection> stanzas in your
-openvpn config:
-
-  <connection>
-     remote my.dual.stack.server 1194 udp6
-  </connection>
-  <connection>
-     remote my.dual.stack.server 1194 udp
-  </connection>
+for IPv4 and IPv6.
\ No newline at end of file
diff --git a/TODO.IPv6 b/TODO.IPv6
index 29d7554..378358c 100644
--- a/TODO.IPv6
+++ b/TODO.IPv6
@@ -183,7 +183,7 @@ tun0: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1500
 TODO for IPv6 transport support
 -------------------------------
 
-[ Last updated: 10-Jun-2012. ]
+[ Last updated: 03-01-2013. ]
 
 * All platforms:
   o mgmt console: as currently passes straight in_addr_t bits around
@@ -191,19 +191,26 @@ TODO for IPv6 transport support
   o make possible to get AF from getaddrinfo() answer, ie allow openvpn to
     use ipv4/6 if DNS returns A/AAAA without specifying protocol.
     Hard: requires deep changes in initialization/calling logic
+    - Done by dual stack patches
 
   o use AI_PASSIVE
+    - Done by dual stack patches
 
   o the getaddr()/getaddr6() interface is not prepared for handling socktype
     "tagging", currently I abuse the sockflags bits for getting the ai_socktype
     downstream.
+    - Still done by flags, seems clean enough.
 
   o implement comparison for mapped addesses: server in dual stack
     listening IPv6 must permit incoming streams from allowed IPv4 peer,
     currently you need to pass eg:  --remote ffff::1.2.3.4
-
+    - OpenVPN will compare all address of a remote 
+      but will still fail on mapped addresses
 
 * win32:
   o find out about mapped addresses, as I can't make it work
     with bound at ::1 and connect to 127.0.0.1
+    - Should be fixed by 8832c6c - "Implement listing on IPv4/IPv6 dual socket on all platform"
+
+
 
-- 
1.8.3.4 (Apple Git-47)


