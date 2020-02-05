From: Simon Rozman <simon@...2293...>
Date: Wed,  5 Feb 2020 18:55:56 +0100
Message-Id: <20200205175556.1877-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] tun.c: refactor driver detection and make
 it case-insensitive
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

Hardware IDs are case insensitive on Windows.

Furthermore the driver detection logic has been made more explicit and
easier to read.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpn/tun.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index af09e676..070b0fa0 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3692,11 +3692,19 @@ get_tap_reg(struct gc_arena *gc)
 
                 if (status == ERROR_SUCCESS && data_type == REG_SZ)
                 {
+                    /* Is this adapter supported? */
                     enum windows_driver_type windows_driver = WINDOWS_DRIVER_UNSPECIFIED;
+                    if (strcasecmp(component_id, TAP_WIN_COMPONENT_ID) == 0 ||
+                        strcasecmp(component_id, "root\\" TAP_WIN_COMPONENT_ID) == 0)
+                    {
+                        windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6;
+                    }
+                    else if (strcasecmp(component_id, WINTUN_COMPONENT_ID) == 0)
+                    {
+                        windows_driver = WINDOWS_DRIVER_WINTUN;
+                    }
 
-                    if ((windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6, !strcmp(component_id, TAP_WIN_COMPONENT_ID))
-                        || (windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6, !strcmp(component_id, "root\\" TAP_WIN_COMPONENT_ID))
-                        || (windows_driver = WINDOWS_DRIVER_WINTUN, !strcmp(component_id, WINTUN_COMPONENT_ID)))
+                    if (windows_driver != WINDOWS_DRIVER_UNSPECIFIED)
                     {
                         struct tap_reg *reg;
                         ALLOC_OBJ_CLEAR_GC(reg, struct tap_reg, gc);
-- 
2.24.1.windows.2


