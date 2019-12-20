From: Simon Rozman <simon@...2293...>
Date: Fri, 20 Dec 2019 17:11:11 +0100
Message-Id: <20191220161117.1434-1-simon@...2293...>
In-Reply-To: <CAGyAFMWxED9NY_=h_jim-4cASMAGv0q5ozmqcVQ+jYTLS5YbPA@...278...>
References: <CAGyAFMWxED9NY_=h_jim-4cASMAGv0q5ozmqcVQ+jYTLS5YbPA@...278...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 1/7] tun.c: make Windows device lookup
 functions more general
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

Since the introduction of Wintun, not all network devices in Windows are
TAP-Windows6. Rather than returning a simple true/false answer, a couple
of functions were reworked to return a corresponding struct tap_reg *
or NULL instead.

As it would make the code `tr = is_tap_win(...)` a bit awkward those
functions (both static) were renamed to better reflect their nature.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpn/tun.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index ad497a71..0d6f40fe 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3976,10 +3976,10 @@ show_tap_win_adapters(int msglev, int warnlev)
 }
 
 /*
- * Confirm that GUID is a TAP-Windows adapter.
+ * Lookup a TAP-Windows or Wintun adapter by GUID.
  */
-static bool
-is_tap_win(const char *guid, const struct tap_reg *tap_reg)
+static const struct tap_reg *
+get_adapter_by_guid(const char *guid, const struct tap_reg *tap_reg)
 {
     const struct tap_reg *tr;
 
@@ -3987,11 +3987,11 @@ is_tap_win(const char *guid, const struct tap_reg *tap_reg)
     {
         if (guid && !strcmp(tr->guid, guid))
         {
-            return true;
+            return tr;
         }
     }
 
-    return false;
+    return NULL;
 }
 
 static const char *
@@ -4010,16 +4010,16 @@ guid_to_name(const char *guid, const struct panel_reg *panel_reg)
     return NULL;
 }
 
-static const char *
-name_to_guid(const char *name, const struct tap_reg *tap_reg, const struct panel_reg *panel_reg)
+static const struct tap_reg *
+get_adapter_by_name(const char *name, const struct tap_reg *tap_reg, const struct panel_reg *panel_reg)
 {
     const struct panel_reg *pr;
 
     for (pr = panel_reg; pr != NULL; pr = pr->next)
     {
-        if (name && !strcmp(pr->name, name) && is_tap_win(pr->guid, tap_reg))
+        if (name && !strcmp(pr->name, name))
         {
-            return pr->guid;
+            return get_adapter_by_guid(pr->guid, tap_reg);
         }
     }
 
@@ -4116,6 +4116,7 @@ get_device_guid(const char *name,
 {
     struct buffer ret = alloc_buf_gc(256, gc);
     struct buffer actual = clear_buf();
+    const struct tap_reg *tr;
 
     /* Make sure we have at least one TAP adapter */
     if (!tap_reg)
@@ -4131,7 +4132,8 @@ get_device_guid(const char *name,
     }
 
     /* Check if GUID was explicitly specified as --dev-node parameter */
-    if (is_tap_win(name, tap_reg))
+    tr = get_adapter_by_guid(name, tap_reg);
+    if (tr)
     {
         const char *act = guid_to_name(name, panel_reg);
         buf_printf(&ret, "%s", name);
@@ -4148,11 +4150,11 @@ get_device_guid(const char *name,
 
     /* Lookup TAP adapter in network connections list */
     {
-        const char *guid = name_to_guid(name, tap_reg, panel_reg);
-        if (guid)
+        tr = get_adapter_by_name(name, tap_reg, panel_reg);
+        if (tr)
         {
             buf_printf(&actual, "%s", name);
-            buf_printf(&ret, "%s", guid);
+            buf_printf(&ret, "%s", tr->guid);
             return BSTR(&ret);
         }
     }
@@ -4696,11 +4698,14 @@ get_adapter_index_flexible(const char *name)  /* actual name or GUID */
     {
         const struct tap_reg *tap_reg = get_tap_reg(&gc);
         const struct panel_reg *panel_reg = get_panel_reg(&gc);
-        const char *guid = name_to_guid(name, tap_reg, panel_reg);
-        index = get_adapter_index_method_1(guid);
-        if (index == TUN_ADAPTER_INDEX_INVALID)
+        const struct tap_reg *tr = get_adapter_by_name(name, tap_reg, panel_reg);
+        if (tr)
         {
-            index = get_adapter_index_method_2(guid);
+            index = get_adapter_index_method_1(tr->guid);
+            if (index == TUN_ADAPTER_INDEX_INVALID)
+            {
+                index = get_adapter_index_method_2(tr->guid);
+            }
         }
     }
     if (index == TUN_ADAPTER_INDEX_INVALID)
-- 
2.24.1.windows.2


