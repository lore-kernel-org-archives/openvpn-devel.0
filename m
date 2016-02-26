From: Selva Nair <selva.nair@...277...>
Date: Thu, 25 Feb 2016 22:24:51 -0500
Message-Id: <1456457091-3872-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1456457091-3872-1-git-send-email-selva.nair@...277...>
References: <20160225125008.GD24952@...1296...>
	<1456457091-3872-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 2/2] Add support for block-outside-dns
	through the interactive service
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

- Add a new message type in openvpn-msg.h
- Pass msg_channel HANDLE to win_wfp_block_dns and win_wfp_uninit
- Add a handler in interactive.c for block_dns request

The service build now depends on block_dns.[ch] in src/openvpn

v2 changes:
- Make CmpEngine non-nested (be nice with non-gcc compilers)
- Print error code in hex

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 include/openvpn-msg.h         |    9 ++++-
 src/openvpn/init.c            |    4 +-
 src/openvpn/win32.c           |   62 +++++++++++++++++++++++++++--
 src/openvpn/win32.h           |    4 +-
 src/openvpnserv/Makefile.am   |    7 ++--
 src/openvpnserv/interactive.c |   88 ++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 161 insertions(+), 13 deletions(-)

diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 0dcc72f..7470512 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -35,7 +35,9 @@ typedef enum {
   msg_del_dns_cfg,
   msg_add_nbt_cfg,
   msg_del_nbt_cfg,
-  msg_flush_neighbors
+  msg_flush_neighbors,
+  msg_add_block_dns,
+  msg_del_block_dns
 } message_type_t;
 
 typedef struct {
@@ -105,4 +107,9 @@ typedef struct {
   int error_number;
 } ack_message_t;
 
+typedef struct {
+  message_header_t header;
+  interface_t iface;
+} block_dns_message_t;
+
 #endif
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index cb73a3d..7f54c3c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1508,7 +1508,7 @@ do_open_tun (struct context *c)
       if (c->options.block_outside_dns)
       {
         dmsg (D_LOW, "Blocking outside DNS");
-        if (!win_wfp_block_dns(c->c1.tuntap->adapter_index))
+        if (!win_wfp_block_dns(c->c1.tuntap->adapter_index, c->options.msg_channel))
             msg (M_FATAL, "Blocking DNS failed!");
       }
 #endif
@@ -1656,7 +1656,7 @@ do_close_tun (struct context *c, bool force)
 #if defined(WIN32)
             if (c->options.block_outside_dns)
             {
-                if (!win_wfp_uninit())
+                if (!win_wfp_uninit(c->options.msg_channel))
                     msg (M_FATAL, "Uninitialising WFP failed!");
             }
 #endif
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 9efc0bc..f4d3237 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1092,6 +1092,45 @@ win_get_tempdir()
   return tmpdir;
 }
 
+static bool
+win_block_dns_service (bool add, int index, const HANDLE pipe)
+{
+  DWORD len;
+  bool ret = false;
+  ack_message_t ack;
+  struct gc_arena gc = gc_new ();
+
+  block_dns_message_t data = {
+    .header = {
+      (add ? msg_add_block_dns : msg_del_block_dns),
+      sizeof (block_dns_message_t),
+      0 },
+    .iface = { .index = index, .name = "" }
+  };
+
+  if (!WriteFile (pipe, &data, sizeof (data), &len, NULL) ||
+      !ReadFile (pipe, &ack, sizeof (ack), &len, NULL))
+    {
+      msg (M_WARN, "Block_DNS: could not talk to service: %s [%lu]",
+           strerror_win32 (GetLastError (), &gc), GetLastError ());
+      goto out;
+    }
+
+  if (ack.error_number != NO_ERROR)
+    {
+      msg (M_WARN, "Block_DNS: %s block dns filters using service failed: %s [status=0x%x if_index=%d]",
+           (add ? "adding" : "deleting"), strerror_win32 (ack.error_number, &gc),
+           ack.error_number, data.iface.index);
+      goto out;
+    }
+
+  ret = true;
+  msg (M_INFO, "%s outside dns using service succeeded.", (add ? "Blocking" : "Unblocking"));
+out:
+  gc_free (&gc);
+  return ret;
+}
+
 static void
 block_dns_msg_handler (DWORD err, const char *msg)
 {
@@ -1103,7 +1142,7 @@ block_dns_msg_handler (DWORD err, const char *msg)
     }
   else
     {
-      msg (M_WARN, "Error in add_block_dns_filters(): %s : %s [status=%lu]",
+      msg (M_WARN, "Error in add_block_dns_filters(): %s : %s [status=0x%lx]",
            msg, strerror_win32 (err, &gc), err);
     }
 
@@ -1111,12 +1150,19 @@ block_dns_msg_handler (DWORD err, const char *msg)
 }
 
 bool
-win_wfp_block_dns (const NET_IFINDEX index)
+win_wfp_block_dns (const NET_IFINDEX index, const HANDLE msg_channel)
 {
   WCHAR openvpnpath[MAX_PATH];
   bool ret = false;
   DWORD status;
 
+  if (msg_channel)
+    {
+      dmsg (D_LOW, "Using service to add block dns filters");
+      ret = win_block_dns_service (true, index, msg_channel);
+      goto out;
+    }
+
   status = GetModuleFileNameW (NULL, openvpnpath, sizeof(openvpnpath));
   if (status == 0 || status == sizeof(openvpnpath))
     {
@@ -1134,11 +1180,19 @@ out:
 }
 
 bool
-win_wfp_uninit()
+win_wfp_uninit(const HANDLE msg_channel)
 {
     dmsg (D_LOW, "Uninitializing WFP");
 
-    delete_block_dns_filters (m_hEngineHandle);
+    if (msg_channel)
+      {
+        msg (D_LOW, "Using service to delete block dns filters");
+        win_block_dns_service (false, -1, msg_channel);
+      }
+    else
+      {
+        delete_block_dns_filters (m_hEngineHandle);
+      }
 
     return true;
 }
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 1e98207..619878f 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -271,8 +271,8 @@ const char *win_get_tempdir();
 /* Convert a string from UTF-8 to UCS-2 */
 WCHAR *wide_string (const char* utf8, struct gc_arena *gc);
 
-bool win_wfp_block_dns(const NET_IFINDEX index);
-bool win_wfp_uninit();
+bool win_wfp_block_dns(const NET_IFINDEX index, const HANDLE msg_channel);
+bool win_wfp_uninit(const HANDLE msg_channel);
 
 #define WIN_XP 0
 #define WIN_VISTA 1
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index 5aba53a..3c757d6 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -18,7 +18,7 @@ EXTRA_DIST = \
 	openvpnserv.vcxproj.filters
 
 AM_CPPFLAGS = \
-	-I$(top_srcdir)/include
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn
 
 if WIN32
 sbin_PROGRAMS = openvpnserv
@@ -26,7 +26,7 @@ openvpnserv_CFLAGS = \
 	-municode -D_UNICODE \
 	-UNTDDI_VERSION -U_WIN32_WINNT \
 	-D_WIN32_WINNT=_WIN32_WINNT_VISTA
-openvpnserv_LDADD = -ladvapi32 -luserenv -liphlpapi -lshlwapi -lnetapi32 -lws2_32
+openvpnserv_LDADD = -ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 -lshlwapi -lnetapi32 -lws2_32
 endif
 
 openvpnserv_SOURCES = \
@@ -34,5 +34,6 @@ openvpnserv_SOURCES = \
 	automatic.c \
 	interactive.c \
 	service.c service.h \
-        validate.c validate.h \
+	validate.c validate.h \
+	$(top_srcdir)/src/openvpn/block_dns.c $(top_srcdir)/src/openvpn/block_dns.h \
 	openvpnserv_resources.rc
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 22239b2..dc8faf4 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -37,6 +37,7 @@
 
 #include "openvpn-msg.h"
 #include "validate.h"
+#include "block_dns.h"
 
 #define IO_TIMEOUT  2000 /*ms*/
 
@@ -77,6 +78,7 @@ typedef struct _list_item {
 typedef enum {
   address,
   route,
+  block_dns,
   _undo_type_max
 } undo_type_t;
 typedef list_item_t* undo_lists_t[_undo_type_max];
@@ -601,7 +603,6 @@ out:
   return err;
 }
 
-
 static BOOL
 CmpRoute (LPVOID item, LPVOID route)
 {
@@ -729,6 +730,78 @@ HandleFlushNeighborsMessage (flush_neighbors_message_t *msg)
   return flush_fn (msg->family, msg->iface.index);
 }
 
+static void
+BlockDNSErrHandler (DWORD err, const char *msg)
+{
+  TCHAR buf[256];
+  LPCTSTR err_str;
+
+  if (!err) return;
+
+  err_str = TEXT("Unknown Win32 Error");
+
+  if (FormatMessage (FORMAT_MESSAGE_IGNORE_INSERTS | FORMAT_MESSAGE_FROM_SYSTEM
+                          | FORMAT_MESSAGE_ARGUMENT_ARRAY,
+                          NULL, err, 0, buf, sizeof (buf), NULL))
+    {
+      err_str = buf;
+    }
+
+#ifdef UNICODE
+  MsgToEventLog (M_ERR, L"%S (status = %lu): %s", msg, err, err_str);
+#else
+  MsgToEventLog (M_ERR, "%s (status = %lu): %s", msg, err, err_str);
+#endif
+
+}
+
+/* Use an always-true match_fn to get the head of the list */
+static BOOL
+CmpEngine (LPVOID item, LPVOID any)
+{
+  return TRUE;
+}
+
+static DWORD
+HandleBlockDNSMessage (const block_dns_message_t *msg, undo_lists_t *lists)
+{
+  DWORD err = 0;
+  HANDLE engine = NULL;
+  LPCWSTR exe_path;
+
+#ifdef UNICODE
+  exe_path = settings.exe_path;
+#else
+  WCHAR wide_path[MAX_PATH];
+  MultiByteToWideChar (CP_UTF8, 0, settings.exe_path, MAX_PATH, wide_path, MAX_PATH);
+  exe_path = wide_path;
+#endif
+
+  if (msg->header.type == msg_add_block_dns)
+    {
+      err = add_block_dns_filters (&engine, msg->iface.index, exe_path, BlockDNSErrHandler);
+      if (!err)
+        err = AddListItem (&(*lists)[block_dns], engine);
+    }
+  else
+    {
+      engine = RemoveListItem (&(*lists)[block_dns], CmpEngine, NULL);
+      if (engine)
+        {
+          err = delete_block_dns_filters (engine);
+          engine = NULL;
+        }
+      else
+        MsgToEventLog (M_ERR, TEXT("No previous block DNS filters to delete"));
+    }
+
+  if (err && engine)
+    {
+      delete_block_dns_filters (engine);
+    }
+
+  return err;
+}
 
 static VOID
 HandleMessage (HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
@@ -739,6 +812,7 @@ HandleMessage (HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_list
     address_message_t address;
     route_message_t route;
     flush_neighbors_message_t flush_neighbors;
+    block_dns_message_t block_dns;
   } msg;
   ack_message_t ack = {
     .header = {
@@ -774,8 +848,15 @@ HandleMessage (HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_list
         ack.error_number = HandleFlushNeighborsMessage (&msg.flush_neighbors);
       break;
 
+    case msg_add_block_dns:
+    case msg_del_block_dns:
+      if (msg.header.size == sizeof (msg.block_dns))
+        ack.error_number = HandleBlockDNSMessage (&msg.block_dns, lists);
+      break;
+
     default:
       ack.error_number = ERROR_MESSAGE_TYPE;
+      MsgToEventLog (MSG_FLAGS_ERROR, TEXT("Unknown message type %d"), msg.header.type);
       break;
     }
 
@@ -803,6 +884,11 @@ Undo (undo_lists_t *lists)
             case route:
               DeleteRoute (item->data);
               break;
+
+            case block_dns:
+              delete_block_dns_filters (item->data);
+              item->data = NULL;
+              break;
             }
 
           /* Remove from the list and free memory */
-- 
1.7.10.4


