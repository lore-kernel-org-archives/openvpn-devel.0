From: Gert Doering <gert@...1296...>
Date: Mon,  6 Oct 2025 16:58:37 +0200
Message-ID: <20251006145844.27794-1-gert@...1296...>
In-Reply-To: <gerrit.1758030602000.I88e16e15fad065cb310d38f09924053efc3a6ce5@...2715...>
References: <gerrit.1758030602000.I88e16e15fad065cb310d38f09924053efc3a6ce5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Allowing installing FreeBSD routes with
 interface instead of next-hop
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

From: Arne Schwabe <arne@...1227...>

This matches the Linux behaviour of the net_route add/delete commands

Change-Id: I88e16e15fad065cb310d38f09924053efc3a6ce5
Signed-off-by: Arne Schwabe <arne@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1193
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1193
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/src/openvpn/networking_freebsd.c b/src/openvpn/networking_freebsd.c
index b47444c..b020f51 100644
--- a/src/openvpn/networking_freebsd.c
+++ b/src/openvpn/networking_freebsd.c
@@ -15,17 +15,29 @@
     char buf1[INET_ADDRSTRLEN], buf2[INET_ADDRSTRLEN];
     in_addr_t _dst, _gw;
     struct argv argv = argv_new();
-    bool status;
+
+    ASSERT(gw || iface);
 
     _dst = ntohl(*dst);
-    _gw = ntohl(*gw);
 
-    argv_printf(&argv, "%s %s -net %s/%d %s -fib %d", ROUTE_PATH, op,
-                inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixlen,
-                inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)), table);
+    /* if gw is NULL we are installing a route with the interface as
+     * target instead */
+    if (gw)
+    {
+        _gw = ntohl(*gw);
+        argv_printf(&argv, "%s %s -net %s/%d %s -fib %d", ROUTE_PATH, op,
+                    inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixlen,
+                    inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)), table);
+    }
+    else
+    {
+        argv_printf(&argv, "%s %s -net %s/%d -iface %s -fib %d", ROUTE_PATH, op,
+                    inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixlen,
+                    iface, table);
+    }
 
     argv_msg(M_INFO, &argv);
-    status = openvpn_execve_check(&argv, NULL, 0, "ERROR: FreeBSD route command failed");
+    bool status = openvpn_execve_check(&argv, NULL, 0, "ERROR: FreeBSD route command failed");
 
     argv_free(&argv);
 
@@ -38,14 +50,26 @@
 {
     char buf1[INET6_ADDRSTRLEN], buf2[INET6_ADDRSTRLEN];
     struct argv argv = argv_new();
-    bool status;
 
-    argv_printf(&argv, "%s -6 %s -net %s/%d %s -fib %d", ROUTE_PATH, op,
-                inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,
-                inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)), table);
+    ASSERT(gw || iface);
+    /* if gw is NULL, we are installing a route with the interface as target
+     * instead */
+    if (gw)
+    {
+        argv_printf(&argv, "%s -6 %s -net %s/%d %s -fib %d", ROUTE_PATH, op,
+                    inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,
+                    inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)), table);
+    }
+    else
+    {
+        argv_printf(&argv, "%s -6 %s -net %s/%d -iface %s -fib %d", ROUTE_PATH, op,
+                    inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,
+                    iface, table);
+    }
+
 
     argv_msg(M_INFO, &argv);
-    status = openvpn_execve_check(&argv, NULL, 0, "ERROR: FreeBSD route command failed");
+    bool status = openvpn_execve_check(&argv, NULL, 0, "ERROR: FreeBSD route command failed");
 
     argv_free(&argv);
 

