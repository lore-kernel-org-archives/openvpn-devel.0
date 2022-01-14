From: Antonio Quartulli <a@...2181...>
Date: Fri, 14 Jan 2022 18:14:44 +0100
Message-Id: <20220114171446.26446-6-a@...2181...>
In-Reply-To: <20220114171446.26446-1-a@...2181...>
References: <20220114171446.26446-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [RFC v2 5/7] tun: extract close_tun_handle into its
 own fucntion and print correct type
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
Cc: Arne Schwabe <arne@...1227...>, Antonio Quartulli <a@...2181...>

From: Arne Schwabe <arne@...1227...>

This moves closing the tun handle into its own function and also prints
the adapter type we are operating on, instead hardcoding it to
tap-windows.

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/tun.c | 75 ++++++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 418ac1ab..74b12dc3 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6770,6 +6770,46 @@ netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc
     argv_free(&argv);
 }
 
+static
+void close_tun_handle(struct tuntap* tt)
+{
+    const char* adaptertype = print_windows_driver(tt->windows_driver);
+    if (tt->hand != NULL)
+    {
+        dmsg(D_WIN32_IO_LOW, "Attempting CancelIO on %s adapter", adaptertype);
+        if (!CancelIo(tt->hand))
+        {
+            msg(M_WARN | M_ERRNO, "Warning: CancelIO failed on %s adapter", adaptertype);
+        }
+    }
+
+    dmsg(D_WIN32_IO_LOW, "Attempting close of overlapped read event on %s adapter", adaptertype);
+    overlapped_io_close(&tt->reads);
+
+    dmsg(D_WIN32_IO_LOW, "Attempting close of overlapped write event on %s adapter", adaptertype);
+    overlapped_io_close(&tt->writes);
+
+    if (tt->hand != NULL)
+    {
+        dmsg(D_WIN32_IO_LOW, "Attempting CloseHandle on %s adapter", adaptertype);
+        if (!CloseHandle(tt->hand))
+        {
+            msg(M_WARN | M_ERRNO, "Warning: CloseHandle failed on %s adapter", adaptertype);
+        }
+        tt->hand = NULL;
+    }
+
+    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
+    {
+        CloseHandle(tt->rw_handle.read);
+        CloseHandle(tt->rw_handle.write);
+        UnmapViewOfFile(tt->wintun_send_ring);
+        UnmapViewOfFile(tt->wintun_receive_ring);
+        CloseHandle(tt->wintun_send_ring_handle);
+        CloseHandle(tt->wintun_receive_ring_handle);
+    }
+}
+
 void
 close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
@@ -6839,43 +6879,10 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 
     dhcp_release(tt);
 
-    if (tt->hand != NULL)
-    {
-        dmsg(D_WIN32_IO_LOW, "Attempting CancelIO on TAP-Windows adapter");
-        if (!CancelIo(tt->hand))
-        {
-            msg(M_WARN | M_ERRNO, "Warning: CancelIO failed on TAP-Windows adapter");
-        }
-    }
-
-    dmsg(D_WIN32_IO_LOW, "Attempting close of overlapped read event on TAP-Windows adapter");
-    overlapped_io_close(&tt->reads);
-
-    dmsg(D_WIN32_IO_LOW, "Attempting close of overlapped write event on TAP-Windows adapter");
-    overlapped_io_close(&tt->writes);
-
-    if (tt->hand != NULL)
-    {
-        dmsg(D_WIN32_IO_LOW, "Attempting CloseHandle on TAP-Windows adapter");
-        if (!CloseHandle(tt->hand))
-        {
-            msg(M_WARN | M_ERRNO, "Warning: CloseHandle failed on TAP-Windows adapter");
-        }
-    }
+    close_tun_handle(tt);
 
     free(tt->actual_name);
 
-    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
-    {
-        CloseHandle(tt->rw_handle.read);
-        CloseHandle(tt->rw_handle.write);
-        UnmapViewOfFile(tt->wintun_send_ring);
-        UnmapViewOfFile(tt->wintun_receive_ring);
-        CloseHandle(tt->wintun_send_ring_handle);
-        CloseHandle(tt->wintun_receive_ring_handle);
-    }
-
-
     clear_tuntap(tt);
     free(tt);
     gc_free(&gc);
-- 
2.34.1


