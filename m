From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 16 Feb 2023 18:01:29 +0200
Message-Id: <20230216160129.994-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add logging for windows driver selection
 process
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/tun.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 20f80798..a1414d23 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3705,6 +3705,7 @@ get_device_instance_id_interface(struct gc_arena *gc)
         msg(M_FATAL, "Error [%u] opening device information set key: %s", (unsigned int)err, strerror_win32(err, gc));
     }
 
+    msg(D_TAP_WIN_DEBUG, "Enumerate device interface lists:");
     for (DWORD i = 0;; ++i)
     {
         SP_DEVINFO_DATA device_info_data;
@@ -3790,6 +3791,10 @@ get_device_instance_id_interface(struct gc_arena *gc)
             dev_iif->net_cfg_instance_id = (unsigned char *)string_alloc((char *)net_cfg_instance_id, gc);
             dev_iif->device_interface = string_alloc(dev_if, gc);
 
+            msg(D_TAP_WIN_DEBUG, "NetCfgInstanceId: %s, Device Interface: %s",
+                dev_iif->net_cfg_instance_id,
+                dev_iif->device_interface);
+
             /* link into return list */
             if (!first)
             {
@@ -3835,6 +3840,7 @@ get_tap_reg(struct gc_arena *gc)
         msg(M_FATAL, "Error opening registry key: %s", ADAPTER_KEY);
     }
 
+    msg(D_TAP_WIN_DEBUG, "Enumerate drivers in registy: ");
     while (true)
     {
         char enum_name[256];
@@ -3942,6 +3948,9 @@ get_tap_reg(struct gc_arena *gc)
                             last->next = reg;
                         }
                         last = reg;
+
+                        msg(D_TAP_WIN_DEBUG, "NetCfgInstanceId: %s, Driver: %s",
+                            reg->guid, print_windows_driver(reg->windows_driver));
                     }
                 }
             }
@@ -6520,6 +6529,8 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
         path = tuntap_device_path;
     }
 
+    msg(D_TAP_WIN_DEBUG, "Using device interface: %s", path);
+
     tt->hand = CreateFile(path,
                           GENERIC_READ | GENERIC_WRITE,
                           0,         /* was: FILE_SHARE_READ */
@@ -6529,7 +6540,7 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
                           0);
     if (tt->hand == INVALID_HANDLE_VALUE)
     {
-        msg(D_TUNTAP_INFO, "CreateFile failed on %s device: %s", print_windows_driver(tt->windows_driver), path);
+        msg(D_TUNTAP_INFO | M_ERRNO, "CreateFile failed on %s device: %s", print_windows_driver(tt->windows_driver), path);
         return false;
     }
 
-- 
2.23.0.windows.1


