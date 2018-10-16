From: Simon Rozman <simon@...2293...>
Date: Tue, 16 Oct 2018 12:26:27 +0200
Message-Id: <20181016102627.18676-5-simon@...2293...>
In-Reply-To: <20181016102627.18676-1-simon@...2293...>
References: <20181010192337.6984-1-simon@...2293...>
 <20181016102627.18676-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/5] Detect TAP interfaces with
 root-enumerated hardware ID
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

This patch extends the TAP interface enumerating to detect the TAP
interfaces registered using "root\tap0901" hardware ID. Before, only TAP
interfaces with legacy "tap0901" HWID were detected by openvpn.exe.

The openvpnmsica.dll and tapctl.exe install TAP interfaces using root-
enumerated HWIDs, and were not detected by openvpn.exe.
---
 src/openvpn/tun.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 948fd17d..5fde2ab8 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3524,7 +3524,8 @@ get_tap_reg(struct gc_arena *gc)
 
                 if (status == ERROR_SUCCESS && data_type == REG_SZ)
                 {
-                    if (!strcmp(component_id, TAP_WIN_COMPONENT_ID))
+                    if (!strcmp(component_id, TAP_WIN_COMPONENT_ID) ||
+                        !strcmp(component_id, "root\\" TAP_WIN_COMPONENT_ID))
                     {
                         struct tap_reg *reg;
                         ALLOC_OBJ_CLEAR_GC(reg, struct tap_reg, gc);
-- 
2.19.0.windows.1


