From: David Sommerseth <dazo@...384...>
Date: Mon, 15 Nov 2010 09:05:48 +0100
Message-Id: <1289808348-17463-8-git-send-email-dazo@...384...>
In-Reply-To: <1289808348-17463-1-git-send-email-dazo@...384...>
References: <1289808348-17463-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 6/6] Merged add_bypass_address() and
	add_host_route_if_nonlocal()
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
Cc: David Sommerseth <dazo@...384...>

The add_host_route_if_nonlocal() function is too simple to really
benefit from calling add_bypass_address() when this function is the
only caller to this function.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 route.c |   34 ++++++++++++----------------------
 1 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/route.c b/route.c
index 612bcbe..f78893e 100644
--- a/route.c
+++ b/route.c
@@ -59,26 +59,6 @@ print_bypass_addresses (const struct route_bypass *rb)
 
 #endif
 
-static bool
-add_bypass_address (struct route_bypass *rb, const in_addr_t a)
-{
-  int i;
-  for (i = 0; i < rb->n_bypass; ++i)
-    {
-      if (a == rb->bypass[i]) /* avoid duplicates */
-	return true;
-    }
-  if (rb->n_bypass < N_ROUTE_BYPASS)
-    {
-      rb->bypass[rb->n_bypass++] = a;
-      return true;
-    }
-  else
-    {
-      return false;
-    }
-}
-
 struct route_option_list *
 new_route_option_list (const int max_routes, struct gc_arena *a)
 {
@@ -2124,8 +2104,18 @@ netmask_to_netbits (const in_addr_t network, const in_addr_t netmask, int *netbi
 static void
 add_host_route_if_nonlocal (struct route_bypass *rb, const in_addr_t addr)
 {
-  if (test_local_addr(addr) == TLA_NONLOCAL && addr != 0 && addr != ~0)
-    add_bypass_address (rb, addr);
+  if (test_local_addr(addr) == TLA_NONLOCAL && addr != 0 && addr != ~0) {
+    int i;
+    for (i = 0; i < rb->n_bypass; ++i)
+      {
+        if (addr == rb->bypass[i]) /* avoid duplicates */
+          return;
+      }
+    if (rb->n_bypass < N_ROUTE_BYPASS)
+      {
+        rb->bypass[rb->n_bypass++] = addr;
+      }
+  }
 }
 
 static void
-- 
1.7.2.3


