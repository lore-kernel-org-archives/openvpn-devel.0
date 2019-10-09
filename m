From: Gert Doering <gert@...1296...>
Date: Wed,  9 Oct 2019 11:51:59 +0200
Message-Id: <20191009095200.9337-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] repair tap mode on
 OpenSolaris/OpenIndiana
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

commit 611fcbc48 joined the two distinct calls for "add ipv6 address
to tap interface" and "set MTU" for Solaris - but due to peculiarities
on how this platform handles IPv6 addresses ("ifconfig addif" creates
a new "tap0:1" subinterface with the new address - which does not have
a distinct MTU) this does not work.

un-join calls again.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 0591df65..ce23eb6a 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -937,9 +937,11 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
          * server will ignore the DHCPv6 packets anyway.  So we don't.
          */
 
-        /* static IPv6 addresses need to go to a subinterface (tap0:1) */
-        argv_printf(&argv, "%s %s inet6 addif %s/%d mtu %d up", IFCONFIG_PATH,
-                    ifname, ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);
+        /* static IPv6 addresses need to go to a subinterface (tap0:1)
+         * and we cannot set an mtu here (must go to the "parent")
+         */
+        argv_printf(&argv, "%s %s inet6 addif %s/%d up", IFCONFIG_PATH,
+                    ifname, ifconfig_ipv6_local, tt->netbits_ipv6 );
     }
     argv_msg(M_INFO, &argv);
 
@@ -947,6 +949,14 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
     {
         solaris_error_close(tt, es, ifname, true);
     }
+
+    if (tt->type != DEV_TYPE_TUN)
+    {
+        argv_printf(&argv, "%s %s inet6 mtu %d", IFCONFIG_PATH,
+                    ifname, tun_mtu);
+        argv_msg(M_INFO, &argv);
+        openvpn_execve_check(&argv, es, 0, "Solaris ifconfig IPv6 mtu failed");
+    }
 #elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
     || defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) \
     || defined(TARGET_DRAGONFLY)
-- 
2.23.0


