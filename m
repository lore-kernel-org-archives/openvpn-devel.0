From: Gert Doering <gert@...1296...>
Date: Sun, 10 Jun 2012 17:41:31 +0200
Message-Id: <1339342891-28443-6-git-send-email-gert@...1296...>
In-Reply-To: <1339342891-28443-1-git-send-email-gert@...1296...>
References: <1339342891-28443-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 5/5] Update TODO.IPv6 list
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

Clarify status of each already-done item for "IPv6 payload" TODOs.

Remove TODOs from "IPv6 transport" list that have been solved in
"IPv6 payload" work.

Signed-off-by: Gert Doering <gert@...1296...>
---
 TODO.IPv6 |   35 ++++++++++++++++++++++++++++-------
 1 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/TODO.IPv6 b/TODO.IPv6
index f23cce0..29d7554 100644
--- a/TODO.IPv6
+++ b/TODO.IPv6
@@ -5,6 +5,8 @@ TODO for IPv6 payload support
     (verified for FreeBSD server, Linux/ifconfig client, problems 
     with ICMP6 neighbor solicitations from BSD not being answered by Linux)
 
+    * 2012-01-22 fixed in platform cleanup, commit 62c613d46dc495d74
+
 2.) NetBSD IPv6 support doesn't work
     ("connected" route is not auto-created, "route-ipv6" adding fails)
 
@@ -15,6 +17,8 @@ TODO for IPv6 payload support
     * fixed for configured routes, 3.1.10 *
     * missing for manual-ifconfig-connected (NetBSD, Darwin, Win32)
 
+    * 2012-06-10 - fixed somewhere in 2010
+
 4.) do "ifconfig tun0 inet6 unplumb"  or "ifconfig tun0 destroy" for
     Solaris, *BSD, ... at program termination time, to clean up leftovers
     (unless tunnel persistance is desired).
@@ -22,6 +26,8 @@ TODO for IPv6 payload support
     For Solaris, only the "ipv6 tun0" is affected, for the *BSDs all tun0
     stay around.
 
+    * 2012-06-10 - fixed in individual platform cleanups early-2012
+
 4a.) deconfigure IPv6 on tun interface on session termination, otherwise
     one could end up with something like this (on NetBSD):
 
@@ -36,11 +42,15 @@ tun0: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1500
     * semi-fixed for NetBSD, 28.2.10, always do tun0 destroy / tun0 create
       before actual ifconfig -- tunnel still lingers after OpenVPN quits
 
+    * 2011-09-16 fixed in platform cleanup, commit 8ca19c014c149cf69
+
 4b.) verify this - on FreeBSD, tun0 is auto-destroyed if created by
      opening /dev/tun (and lingers if created by "ifconfig tun0 create")
 
      -> use for persistant tunnels on not-linux?
 
+    * 2012-06-10 tun interface behaviour is documented in "man tun(4)"
+
 5.) add new option "ifconfig-ipv6-push"
     (per-client static IPv6 assignment, -> radiusplugin, etc)
 
@@ -48,12 +58,17 @@ tun0: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1500
 
 6.) add new option "route-ipv6-gateway"
 
+    * 2012-06-09 - decided there is no current need (but fairly trivial)
+
 7.) add "full" gateway handling for IPv6 in route.c 
     (right now, the routes are just sent down the tun interface, if the
     operating system in questions supports that, without care for the
     gateway address - which does not work for gateways that are supposed
     to point elsewhere.  Also, it doesn't work for TAP interfaces.
 
+    * 2012-06-09 use "dev tun" for tun devices, "via $gateway" for tap
+		 (and purposely do not support off-link routes)
+
 8.) full IPv6 support for TAP interfaces 
     (main issue should be routes+gateway - and testing :-) )
 
@@ -62,8 +77,16 @@ tun0: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1500
 
 17:51:14.075412 fe:ab:6e:c5:53:71 > 33:33:ff:00:00:01, ethertype IPv6 (0x86dd), length 86: 2001:608:4:a053::1:0 > ff02::1:ff00:1: ICMP6, neighbor solicitation, who has 2001:608:4:a001::1, length 32
 
+    * 2012-06-09 missing gateway support implemented
+
+8a.)
     how is iroute-via-tap supposed to work??
 
+    * 2012-06-10 - answer: not at all, OpenVPN doesn't do "iroute" in
+    tap mode - set up "route-ipv6" with gateway address = individual
+    client's tap0 address to get the per-client routes
+
+
 9.) verify that iroute-ipv6 and route-ipv6 interact in the same way as
     documented for iroute/route:
 
@@ -113,6 +136,8 @@ tun0: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1500
 	  (openvpn-devel, Subject: OpenBSD)
 	- test
 
+    * 2012-02-05 platform cleanup, commit 82d4e12068774b0a6ca
+
 17.) client-option (Elwood)
 	- ignore-v6-push-options yes/no
 	- ignore-v6-route-push  ("as for IPv4 routes")
@@ -150,13 +175,15 @@ tun0: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1500
 
     (problem + workaround applies both to tun and tap style devices)
 
+    * 2012-06-09 - this got fixed in one of the platform cleanups
+
 
 
 
 TODO for IPv6 transport support
 -------------------------------
 
-[ Last updated: 11-Nov-2009. ]
+[ Last updated: 10-Jun-2012. ]
 
 * All platforms:
   o mgmt console: as currently passes straight in_addr_t bits around
@@ -175,14 +202,8 @@ TODO for IPv6 transport support
     listening IPv6 must permit incoming streams from allowed IPv4 peer,
     currently you need to pass eg:  --remote ffff::1.2.3.4
 
-  o do something with multi mode learn routes, for now just ignoring
-    ipv6 addresses seems the most sensible thing to do, because there's
-    no support for intra-tunnel ipv6 stuff.
 
 * win32:
   o find out about mapped addresses, as I can't make it work
     with bound at ::1 and connect to 127.0.0.1
 
-* N/A:
-  o this is ipv6 *endpoint* support, so don't expect "ifconfig6"-like
-    support in this patch
-- 
1.7.3.4


