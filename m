From: Kristof Provost <kprovost@...2661...>
Date: Mon, 22 Aug 2022 11:28:34 +0200
Message-Id: <20220822092834.14231-2-kprovost@...2661...>
In-Reply-To: <20220822092834.14231-1-kprovost@...2661...>
References: <20220812134154.16729-3-kprovost@...2661...>
 <20220822092834.14231-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] FreeBSD networking cleanup
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

Address a few minor code review remarks:

 - use constants for the inet_ntop() buffers
 - replace argv_printf() + argv_printf_cat() with a single argv_printf()
 - net_route_v4/6 both add and remove, so adjust the error message to
   reflect that.

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 src/openvpn/networking_freebsd.c | 34 +++++++++++++++-----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/networking_freebsd.c b/src/openvpn/networking_freebsd.c
index 5fcb738e..0633dce7 100644
--- a/src/openvpn/networking_freebsd.c
+++ b/src/openvpn/networking_freebsd.c
@@ -15,7 +15,7 @@ net_route_v4(const char *op, const in_addr_t *dst, int prefixlen,
              const in_addr_t *gw, const char *iface, uint32_t table,
              int metric)
 {
-    char buf1[16], buf2[16];
+    char buf1[INET_ADDRSTRLEN], buf2[INET_ADDRSTRLEN];
     in_addr_t _dst, _gw;
     struct argv argv = argv_new();
     bool status;
@@ -23,17 +23,16 @@ net_route_v4(const char *op, const in_addr_t *dst, int prefixlen,
     _dst = ntohl(*dst);
     _gw = ntohl(*gw);
 
-    argv_printf(&argv, "%s %s",
-                ROUTE_PATH, op);
-    argv_printf_cat(&argv, "-net %s/%d %s -fib %d",
-                    inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)),
-                    prefixlen,
-                    inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)),
-                    table);
+    argv_printf(&argv, "%s %s -net %s/%d %s -fib %d",
+                ROUTE_PATH, op,
+                inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)),
+                prefixlen,
+                inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)),
+                table);
 
     argv_msg(M_INFO, &argv);
     status = openvpn_execve_check(&argv, NULL, 0,
-                                  "ERROR: FreeBSD route add command failed");
+                                  "ERROR: FreeBSD route command failed");
 
     argv_free(&argv);
 
@@ -45,21 +44,20 @@ net_route_v6(const char *op, const struct in6_addr *dst,
              int prefixlen, const struct in6_addr *gw, const char *iface,
              uint32_t table, int metric)
 {
-    char buf1[64], buf2[64];
+    char buf1[INET6_ADDRSTRLEN], buf2[INET6_ADDRSTRLEN];
     struct argv argv = argv_new();
     bool status;
 
-    argv_printf(&argv, "%s -6 %s",
-                ROUTE_PATH, op);
-    argv_printf_cat(&argv, "-net %s/%d %s -fib %d",
-                    inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)),
-                    prefixlen,
-                    inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)),
-                    table);
+    argv_printf(&argv, "%s -6 %s -net %s/%d %s -fib %d",
+                ROUTE_PATH, op,
+                inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)),
+                prefixlen,
+                inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)),
+                table);
 
     argv_msg(M_INFO, &argv);
     status = openvpn_execve_check(&argv, NULL, 0,
-                                  "ERROR: FreeBSD route add command failed");
+                                  "ERROR: FreeBSD route command failed");
 
     argv_free(&argv);
 
-- 
2.37.2


