From: Simon Rozman <simon@...2293...>
Date: Thu, 19 Dec 2019 23:39:12 +0100
Message-Id: <20191219223917.1614-2-simon@...2293...>
In-Reply-To: <20191219223917.1614-1-simon@...2293...>
References: <20191219223917.1614-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/7] tun.c: upgrade get_device_guid() to
 return the Windows driver type
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
 src/openvpn/tun.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 053a8232..623ed37b 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -4110,6 +4110,7 @@ static const char *
 get_device_guid(const char *name,
                 char *actual_name,
                 int actual_name_size,
+                bool *wintun,
                 const struct tap_reg *tap_reg,
                 const struct panel_reg *panel_reg,
                 struct gc_arena *gc)
@@ -4145,6 +4146,10 @@ get_device_guid(const char *name,
         {
             buf_printf(&actual, "%s", name);
         }
+        if (wintun)
+        {
+            *wintun = tr->wintun;
+        }
         return BSTR(&ret);
     }
 
@@ -4154,6 +4159,10 @@ get_device_guid(const char *name,
         if (tr)
         {
             buf_printf(&actual, "%s", name);
+            if (wintun)
+            {
+                *wintun = tr->wintun;
+            }
             buf_printf(&ret, "%s", tr->guid);
             return BSTR(&ret);
         }
@@ -4838,7 +4847,7 @@ tap_allow_nonadmin_access(const char *dev_node)
     if (dev_node)
     {
         /* Get the device GUID for the device specified with --dev-node. */
-        device_guid = get_device_guid(dev_node, actual_buffer, sizeof(actual_buffer), tap_reg, panel_reg, &gc);
+        device_guid = get_device_guid(dev_node, actual_buffer, sizeof(actual_buffer), NULL, tap_reg, panel_reg, &gc);
 
         if (!device_guid)
         {
@@ -5412,7 +5421,7 @@ netsh_get_id(const char *dev_node, struct gc_arena *gc)
 
     if (dev_node)
     {
-        guid = get_device_guid(dev_node, BPTR(&actual), BCAP(&actual), tap_reg, panel_reg, gc);
+        guid = get_device_guid(dev_node, BPTR(&actual), BCAP(&actual), NULL, tap_reg, panel_reg, gc);
     }
     else
     {
@@ -6132,7 +6141,7 @@ tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_gui
     if (dev_node)
     {
         /* Get the device GUID for the device specified with --dev-node. */
-        *device_guid = get_device_guid(dev_node, actual_buffer, sizeof(actual_buffer), tap_reg, panel_reg, &gc);
+        *device_guid = get_device_guid(dev_node, actual_buffer, sizeof(actual_buffer), NULL, tap_reg, panel_reg, &gc);
 
         if (!*device_guid)
         {
-- 
2.24.1.windows.2


