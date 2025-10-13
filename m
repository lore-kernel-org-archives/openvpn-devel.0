From: Gert Doering <gert@...1296...>
Date: Mon, 13 Oct 2025 18:22:15 +0200
Message-ID: <20251013162221.2156-1-gert@...1296...>
In-Reply-To: <gerrit.1760359115000.Ia836e3c05a868a7e8419c2bb2f547d968260783c@...2715...>
References: <gerrit.1760359115000.Ia836e3c05a868a7e8419c2bb2f547d968260783c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] win32: Change some APIs to use DWORD
 instead of size_t
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

From: Frank Lichtenheld <frank@...2641...>

This is what the Win32 APIs use. Since we put static
integers into this (e.g. sizeof()) this doesn't
result in new conversion warnings at the caller sites.

Change-Id: Ia836e3c05a868a7e8419c2bb2f547d968260783c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1269
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1269
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 0044794..fde460a 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2840,7 +2840,7 @@
 
 /* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR on error */
 static int
-do_route_service(const bool add, const route_message_t *rt, const size_t size, HANDLE pipe)
+do_route_service(const bool add, const route_message_t *rt, const DWORD size, HANDLE pipe)
 {
     int ret = RTA_ERROR;
     ack_message_t ack;
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index eac2352..3c11ec3 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1418,13 +1418,8 @@
     return (const char *)out.data;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
-send_msg_iservice(HANDLE pipe, const void *data, size_t size, ack_message_t *ack,
+send_msg_iservice(HANDLE pipe, const void *data, DWORD size, ack_message_t *ack,
                   const char *context)
 {
     struct gc_arena gc = gc_new();
@@ -1527,7 +1522,8 @@
 
     while (expire >= now)
     {
-        DWORD status = WaitForSingleObject(win32_signal.in.read, (expire - now) * 1000);
+        DWORD wait_ms = (DWORD)((expire - now) * 1000);
+        DWORD status = WaitForSingleObject(win32_signal.in.read, wait_ms);
         if ((status == WAIT_OBJECT_0 && win32_signal_get(&win32_signal)) || status == WAIT_TIMEOUT)
         {
             return;
@@ -1539,7 +1535,7 @@
         {
             if (expire > now)
             {
-                Sleep((expire - now) * 1000);
+                Sleep((DWORD)((expire - now) * 1000));
             }
             return;
         }
@@ -1602,7 +1598,7 @@
 }
 
 bool
-protect_buffer_win32(char *buf, size_t len)
+protect_buffer_win32(char *buf, DWORD len)
 {
     bool ret;
     if (len % CRYPTPROTECTMEMORY_BLOCK_SIZE)
@@ -1620,7 +1616,7 @@
 }
 
 bool
-unprotect_buffer_win32(char *buf, size_t len)
+unprotect_buffer_win32(char *buf, DWORD len)
 {
     bool ret;
     if (len % CRYPTPROTECTMEMORY_BLOCK_SIZE)
@@ -1637,8 +1633,4 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index ff3145a..07a58d8 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -301,12 +301,14 @@
  */
 const char *win32_version_string(struct gc_arena *gc);
 
-/*
- * Send the |size| bytes in buffer |data| to the interactive service |pipe|
- * and read the result in |ack|. Returns false on communication error.
- * The string in |context| is used to prefix error messages.
+/**
+ * Send the \p size bytes in buffer \p data to the interactive service \p pipe
+ * and read the result in \p ack.
+ * The string in \p context is used to prefix error messages.
+ *
+ * @return true on success, false on communication error
  */
-bool send_msg_iservice(HANDLE pipe, const void *data, size_t size, ack_message_t *ack,
+bool send_msg_iservice(HANDLE pipe, const void *data, DWORD size, ack_message_t *ack,
                        const char *context);
 
 /*
@@ -350,7 +352,7 @@
  * - len   number of bytes to encrypt -- must be a multiple of
  *         CRYPTPROTECTMEMORY_BLOCK_SIZE = 16
  */
-bool protect_buffer_win32(char *buf, size_t len);
+bool protect_buffer_win32(char *buf, DWORD len);
 
 /**
  * Decrypt a previously encrypted region of memory using CryptUnProtectMemory()
@@ -360,7 +362,7 @@
  * - len   number of bytes to encrypt -- must be a multiple of
  *         CRYPTPROTECTMEMORY_BLOCK_SIZE = 16
  */
-bool unprotect_buffer_win32(char *buf, size_t len);
+bool unprotect_buffer_win32(char *buf, DWORD len);
 
 #endif /* ifndef OPENVPN_WIN32_H */
 #endif /* ifdef _WIN32 */
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index f5dddd6..abe223c 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -79,17 +79,19 @@
     return 0;
 }
 
+#ifdef _WIN32
 bool
-protect_buffer_win32(char *buf, size_t len)
+protect_buffer_win32(char *buf, DWORD len)
 {
     return true;
 }
 
 bool
-unprotect_buffer_win32(char *buf, size_t len)
+unprotect_buffer_win32(char *buf, DWORD len)
 {
     return true;
 }
+#endif
 
 /* tooling */
 static void

