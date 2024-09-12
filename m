From: Gert Doering <gert@...1296...>
Date: Thu, 12 Sep 2024 16:24:21 +0200
Message-ID: <20240912142421.703-1-gert@...1296...>
In-Reply-To: <gerrit.1724156602000.I235891212b15277349810913c9c1763da5c48587@...2715...>
References: <gerrit.1724156602000.I235891212b15277349810913c9c1763da5c48587@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] tun: removed unnecessary route
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
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/731
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 739e008..82c5c00 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1008,8 +1008,7 @@
 #endif /* ifdef _WIN32 */
 }
 
-#if defined(_WIN32)    \
-    || defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD)
+#if defined(_WIN32)
 
 /* some of the platforms will auto-add a "network route" pointing
  * to the interface on "ifconfig tunX 2001:db8::1/64", others need
@@ -1200,11 +1199,6 @@
                          "FreeBSD BSD 'ifconfig inet6 -ifdisabled' failed");
 #endif
 
-#if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
-    || defined(TARGET_DARWIN)
-    /* and, hooray, we explicitly need to add a route... */
-    add_route_connected_v6_net(tt, es);
-#endif
 #elif defined(TARGET_AIX)
     argv_printf(&argv, "%s %s inet6 %s/%d mtu %d up", IFCONFIG_PATH, ifname,
                 ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);

