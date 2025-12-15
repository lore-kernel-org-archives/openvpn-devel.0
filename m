From: Gert Doering <gert@...1296...>
Date: Mon, 15 Dec 2025 15:58:35 +0100
Message-ID: <20251215145840.18310-1-gert@...1296...>
In-Reply-To: <gerrit.1761570487000.I88cd7e1ebb49e97db33bad75c4fbbe23d196e964@...2715...>
References: <gerrit.1761570487000.I88cd7e1ebb49e97db33bad75c4fbbe23d196e964@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] multi: Fix various conversion warnings
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

Mostly make required casts explicit.

Change-Id: I88cd7e1ebb49e97db33bad75c4fbbe23d196e964
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1313
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1313
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 20d72c1..92eac6f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -245,11 +245,6 @@
 
 #endif
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 #ifdef ENABLE_ASYNC_PUSH
 static uint32_t
 /*
@@ -2809,8 +2804,8 @@
 multi_process_file_closed(struct multi_context *m, const unsigned int mpp_flags)
 {
     char buffer[INOTIFY_EVENT_BUFFER_SIZE];
-    size_t buffer_i = 0;
-    int r = read(m->top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_SIZE);
+    ssize_t buffer_i = 0;
+    ssize_t r = read(m->top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_SIZE);
 
     while (buffer_i < r)
     {
@@ -2942,21 +2937,23 @@
 static inline unsigned int
 compute_wakeup_sigma(const struct timeval *delta)
 {
+    ASSERT(delta->tv_sec >= 0);
+    ASSERT(delta->tv_usec >= 0);
     if (delta->tv_sec < 1)
     {
         /* if < 1 sec, fuzz = # of microseconds / 8 */
-        return delta->tv_usec >> 3;
+        return (unsigned int)(delta->tv_usec >> 3);
     }
     else
     {
         /* if < 10 minutes, fuzz = 13.1% of timeout */
         if (delta->tv_sec < 600)
         {
-            return delta->tv_sec << 17;
+            return (unsigned int)(delta->tv_sec << 17);
         }
         else
         {
-            return 120000000; /* if >= 10 minutes, fuzz = 2 minutes */
+            return 120 * 1000000; /* if >= 10 minutes, fuzz = 2 minutes */
         }
     }
 }
@@ -3743,7 +3740,7 @@
 
         for (i = 0; i < parm.packet_size; ++i)
         {
-            ASSERT(buf_write_u8(&buf, get_random() & 0xFF));
+            ASSERT(buf_write_u8(&buf, (uint8_t)(get_random() & 0xFF)));
         }
 
         for (i = 0; i < parm.n_packets; ++i)
@@ -3959,10 +3956,6 @@
     return count;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 management_delete_event(void *arg, event_t event)
 {

