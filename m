From: Simon Rozman <simon@...2293...>
Date: Sun, 21 Mar 2021 15:46:24 +0100
Message-Id: <20210321144627.1621-2-simon@...2293...>
In-Reply-To: <20210321144627.1621-1-simon@...2293...>
References: <20210321144627.1621-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/5] tun.c: Remove dead code
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

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpn/tun.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 6c51a52d..6b7c8ef1 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -85,8 +85,6 @@ static void netsh_command(const struct argv *a, int n, int msglevel);
 
 static const char *netsh_get_id(const char *dev_node, struct gc_arena *gc);
 
-static DWORD get_adapter_index_flexible(const char *name);
-
 static bool
 do_address_service(const bool add, const short family, const struct tuntap *tt)
 {
@@ -4877,38 +4875,6 @@ get_adapter_index(const char *guid)
     return index;
 }
 
-static DWORD
-get_adapter_index_flexible(const char *name)  /* actual name or GUID */
-{
-    struct gc_arena gc = gc_new();
-    DWORD index;
-    index = get_adapter_index_method_1(name);
-    if (index == TUN_ADAPTER_INDEX_INVALID)
-    {
-        index = get_adapter_index_method_2(name);
-    }
-    if (index == TUN_ADAPTER_INDEX_INVALID)
-    {
-        const struct tap_reg *tap_reg = get_tap_reg(&gc);
-        const struct panel_reg *panel_reg = get_panel_reg(&gc);
-        const struct tap_reg *tr = get_adapter_by_name(name, tap_reg, panel_reg);
-        if (tr)
-        {
-            index = get_adapter_index_method_1(tr->guid);
-            if (index == TUN_ADAPTER_INDEX_INVALID)
-            {
-                index = get_adapter_index_method_2(tr->guid);
-            }
-        }
-    }
-    if (index == TUN_ADAPTER_INDEX_INVALID)
-    {
-        msg(M_INFO, "NOTE: could not get adapter index for name/GUID '%s'", name);
-    }
-    gc_free(&gc);
-    return index;
-}
-
 /*
  * Return a string representing a PIP_ADDR_STRING
  */
-- 
2.30.0.windows.2


