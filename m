From: Gert Doering <gert@...1296...>
Date: Mon,  9 Sep 2024 14:00:36 +0200
Message-ID: <20240909120036.28723-1-gert@...1296...>
In-Reply-To: <gerrit.1724156602000.I235891212b15277349810913c9c1763da5c48587@...2715...>
References: <gerrit.1724156602000.I235891212b15277349810913c9c1763da5c48587@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] tun: removed unnecessary route
 installations
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

From: Marco Baffo <marco@...2726...>

Removed superfluous calls to 'add_route_ipv6' for adding ipv6 routes after tun opening in OpenBSD, NetBSD and Darwin.

Change-Id: I235891212b15277349810913c9c1763da5c48587
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/731
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 71b5b42..31a634a 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2244,9 +2244,6 @@
     {
         argv_printf_cat(&argv, "-link -iface %s", device);
     }
-    /* FIX ME: in NetBSD in TUN mode, the route is already added by ifconfig
-     * so add_route_ipv6 fail with 'Invalid argument' or 'File exists'
-     */
 
     argv_msg(D_ROUTE, &argv);
     bool ret = openvpn_execve_check(&argv, es, 0,
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index d878161..7bdc6c4 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1010,8 +1010,7 @@
 #endif /* ifdef _WIN32 */
 }
 
-#if defined(_WIN32)    \
-    || defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD)
+#if defined(_WIN32)
 
 /* some of the platforms will auto-add a "network route" pointing
  * to the interface on "ifconfig tunX 2001:db8::1/64", others need
@@ -1203,11 +1202,6 @@
                          "FreeBSD BSD 'ifconfig inet6 -ifdisabled' failed");
 #endif
 
-#if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
-    || defined(TARGET_DARWIN)
-    /* and, hooray, we explicitly need to add a route... */
-    add_route_connected_v6_net(tt, es, is_multipoint);
-#endif
 #elif defined(TARGET_AIX)
     argv_printf(&argv, "%s %s inet6 %s/%d mtu %d up", IFCONFIG_PATH, ifname,
                 ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);

