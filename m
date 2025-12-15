From: Gert Doering <gert@...1296...>
Date: Mon, 15 Dec 2025 16:23:50 +0100
Message-ID: <20251215152355.20654-1-gert@...1296...>
In-Reply-To: <gerrit.1765538409000.I0c5ef13d6fa6c1dd15da934a33e904c2fdacb731@...2715...>
References: <gerrit.1765538409000.I0c5ef13d6fa6c1dd15da934a33e904c2fdacb731@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] manage: Avoid several conversion
 warnings by using the correct types
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

Change-Id: I0c5ef13d6fa6c1dd15da934a33e904c2fdacb731
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1438
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1438
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 6efa100..2191e55 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -206,11 +206,6 @@
     return man->settings.up.defined && !man->connection.password_verified;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
 man_check_password(struct management *man, const char *line)
 {
@@ -220,7 +215,8 @@
          * the attacker choice, it should not give any indication of the real
          * password length, use + 1 to include the NUL byte that terminates the
          * string*/
-        size_t compare_len = min_uint(strlen(line) + 1, sizeof(man->settings.up.password));
+        size_t compare_len =
+            min_size(strlen(line) + 1, sizeof(man->settings.up.password));
         if (memcmp_constant_time(line, man->settings.up.password, compare_len) == 0)
         {
             man->connection.password_verified = true;
@@ -241,10 +237,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 man_update_io_state(struct management *man)
 {
@@ -2315,19 +2307,14 @@
 
 #endif /* ifdef TARGET_ANDROID */
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-static int
+static ssize_t
 man_read(struct management *man)
 {
     /*
      * read command line from socket
      */
     unsigned char buf[256];
-    int len = 0;
+    ssize_t len = 0;
 
 #ifdef TARGET_ANDROID
     int fd;
@@ -2348,7 +2335,7 @@
     {
         bool processed_command = false;
 
-        ASSERT(len <= (int)sizeof(buf));
+        ASSERT(len <= (ssize_t)sizeof(buf));
         command_line_add(man->connection.in, buf, (size_t)len);
 
         /*
@@ -2414,11 +2401,11 @@
     return len;
 }
 
-static int
+static ssize_t
 man_write(struct management *man)
 {
     const int size_hint = 1024;
-    int sent = 0;
+    ssize_t sent = 0;
     const struct buffer *buf;
 
     buffer_list_aggregate(man->connection.out, size_hint);
@@ -2435,7 +2422,9 @@
         }
         else
 #endif
+        {
             sent = send(man->connection.sd_cli, (const void *)BPTR(buf), len, MSG_NOSIGNAL);
+        }
         if (sent >= 0)
         {
             buffer_list_advance(man->connection.out, sent);
@@ -2457,10 +2446,6 @@
     return sent;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 man_connection_clear(struct man_connection *mc)
 {
@@ -3222,8 +3207,7 @@
 
                 if (net_events & FD_WRITE)
                 {
-                    int status;
-                    status = man_write(man);
+                    ssize_t status = man_write(man);
                     if (status < 0 && WSAGetLastError() == WSAEWOULDBLOCK)
                     {
                         net_event_win32_clear_selected_events(&man->connection.ne32, FD_WRITE);

