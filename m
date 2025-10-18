From: Gert Doering <gert@...1296...>
Date: Sat, 18 Oct 2025 19:02:32 +0200
Message-ID: <20251018170237.21928-1-gert@...1296...>
In-Reply-To: <gerrit.1760698129000.I4113d14c6ce33818573b0ca5857a9ab39b35a8f4@...2715...>
References: <gerrit.1760698129000.I4113d14c6ce33818573b0ca5857a9ab39b35a8f4@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] push_util: Fix conversion warnings
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

Mostly just use better types.

Change-Id: I4113d14c6ce33818573b0ca5857a9ab39b35a8f4
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: mrbff <marco@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1283
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1283
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
mrbff <marco@...2726...>

        
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 06b4c8b..8c1a503 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -10,18 +10,13 @@
 #include "ssl_util.h"
 #endif
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 int
 process_incoming_push_update(struct context *c, unsigned int permission_mask,
                              unsigned int *option_types_found, struct buffer *buf,
                              bool msg_sender)
 {
     int ret = PUSH_MSG_ERROR;
-    const uint8_t ch = buf_read_u8(buf);
+    const int ch = buf_read_u8(buf);
     if (ch == ',')
     {
         if (apply_push_options(c, &c->options, buf, permission_mask, option_types_found, c->c2.es,
@@ -57,8 +52,8 @@
  * Return index of last `,` or `0` if it didn't find any.
  * If there is a comma at index `0` it's an error anyway
  */
-static int
-find_first_comma_of_next_bundle(const char *str, int ix)
+static size_t
+find_first_comma_of_next_bundle(const char *str, size_t ix)
 {
     while (ix > 0)
     {
@@ -75,8 +70,8 @@
 static struct buffer
 forge_msg(const char *src, const char *continuation, struct gc_arena *gc)
 {
-    int src_len = strlen(src);
-    int con_len = continuation ? strlen(continuation) : 0;
+    size_t src_len = strlen(src);
+    size_t con_len = continuation ? strlen(continuation) : 0;
     struct buffer buf = alloc_buf_gc(src_len + sizeof(push_update_cmd) + con_len + 2, gc);
 
     buf_printf(&buf, "%s,%s%s", push_update_cmd, src, continuation ? continuation : "");
@@ -93,11 +88,11 @@
     return ret;
 }
 
-/* It split the messagge (if necessay) and fill msgs with the message chunks.
+/* It split the messagge (if necessary) and fill msgs with the message chunks.
  * Return `false` on failure an `true` on success.
  */
 static bool
-message_splitter(const char *s, struct buffer *msgs, struct gc_arena *gc, const int safe_cap)
+message_splitter(const char *s, struct buffer *msgs, struct gc_arena *gc, const size_t safe_cap)
 {
     if (!s || !*s)
     {
@@ -105,7 +100,7 @@
     }
 
     char *str = gc_strdup(s, gc);
-    int i = 0;
+    size_t i = 0;
     int im = 0;
 
     while (*str)
@@ -113,7 +108,7 @@
         /* + ',' - '/0' */
         if (strlen(str) > safe_cap)
         {
-            int ci = find_first_comma_of_next_bundle(str, safe_cap);
+            size_t ci = find_first_comma_of_next_bundle(str, safe_cap);
             if (!ci)
             {
                 /* if no commas were found go to fail, do not send any message */
@@ -219,7 +214,7 @@
  * @return The number of clients to which the message was sent. Might return < 0 in case of error.
  */
 static int
-send_push_update(struct multi_context *m, const void *target, const char *msg, const push_update_type type, const int push_bundle_size)
+send_push_update(struct multi_context *m, const void *target, const char *msg, const push_update_type type, const size_t push_bundle_size)
 {
     if (dco_enabled(&m->top.options))
     {
@@ -228,19 +223,19 @@
         return 0;
     }
 
-    if (!msg || !*msg || !m
-        || (!target && type != UPT_BROADCAST))
+    if (!msg || !*msg || !m || (!target && type != UPT_BROADCAST))
     {
         return -EINVAL;
     }
 
     struct gc_arena gc = gc_new();
     /* extra space for possible trailing ifconfig and push-continuation */
-    const int extra = 84 + sizeof(push_update_cmd);
+    const size_t extra = 84 + sizeof(push_update_cmd);
     /* push_bundle_size is the maximum size of a message, so if the message
      * we want to send exceeds that size we have to split it into smaller messages */
-    const int safe_cap = push_bundle_size - extra;
-    int msgs_num = (strlen(msg) / safe_cap) + ((strlen(msg) % safe_cap) != 0);
+    ASSERT(push_bundle_size > extra);
+    const size_t safe_cap = push_bundle_size - extra;
+    size_t msgs_num = (strlen(msg) / safe_cap) + ((strlen(msg) % safe_cap) != 0);
     struct buffer *msgs = gc_malloc((msgs_num + 1) * sizeof(struct buffer), true, &gc);
 
     unsigned int option_types_found = 0;
@@ -354,7 +349,3 @@
     RETURN_UPDATE_STATUS(n_sent);
 }
 #endif /* ifdef ENABLE_MANAGEMENT */
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

