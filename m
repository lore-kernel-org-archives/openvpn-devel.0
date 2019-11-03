From: Tom Yan <tom.ty89@...277...>
Date: Sun,  3 Nov 2019 13:30:53 +0800
Message-Id: <20191103053053.17996-1-tom.ty89@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] networking/iproute2: support 31-bit ipv4
 prefix (RFC 3021)
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

---
 src/openvpn/networking_iproute2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 1ddeb5cf..4e2435c1 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -98,8 +98,10 @@ net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
     const char *addr_str = print_in_addr_t(*addr, 0, &ctx->gc);
     const char *brd_str = print_in_addr_t(*broadcast, 0, &ctx->gc);
 
-    argv_printf(&argv, "%s addr add dev %s %s/%d broadcast %s", iproute_path,
-                iface, addr_str, prefixlen, brd_str);
+    argv_printf(&argv, "%s addr add dev %s %s/%d", iproute_path,
+                iface, addr_str, prefixlen);
+    if (prefixlen < 31)
+        argv_printf_cat(&argv, " broadcast %s", brd_str);
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add failed");
 
-- 
2.23.0


