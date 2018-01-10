From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 10 Jan 2018 09:34:19 +0100
Message-ID: <1515573259-20968-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix types around buffer_list_push(_data)
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

In C, strings are char pointers, not unsigned char pointers.  And
arbitrary data is represented by a void pointer.  Change buffer_list_push
and buffer_list_push_data to follow these rules, and remove any now
unneeded casts.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/buffer.c |  6 +++---
 src/openvpn/buffer.h |  4 ++--
 src/openvpn/manage.c | 12 ++++++------
 src/openvpn/manage.h |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index a0c2393..858bb08 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1169,7 +1169,7 @@ buffer_list_reset(struct buffer_list *ol)
 }
 
 void
-buffer_list_push(struct buffer_list *ol, const unsigned char *str)
+buffer_list_push(struct buffer_list *ol, const char *str)
 {
     if (str)
     {
@@ -1183,7 +1183,7 @@ buffer_list_push(struct buffer_list *ol, const unsigned char *str)
 }
 
 struct buffer_entry *
-buffer_list_push_data(struct buffer_list *ol, const uint8_t *data, size_t size)
+buffer_list_push_data(struct buffer_list *ol, const void *data, size_t size)
 {
     struct buffer_entry *e = NULL;
     if (data && (!ol->max_size || ol->size < ol->max_size))
@@ -1319,7 +1319,7 @@ buffer_list_file(const char *fn, int max_line_len)
             bl = buffer_list_new(0);
             while (fgets(line, max_line_len, fp) != NULL)
             {
-                buffer_list_push(bl, (unsigned char *)line);
+                buffer_list_push(bl, line);
             }
             free(line);
         }
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 8579cea..e588b80 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1095,9 +1095,9 @@ bool buffer_list_defined(const struct buffer_list *ol);
 
 void buffer_list_reset(struct buffer_list *ol);
 
-void buffer_list_push(struct buffer_list *ol, const unsigned char *str);
+void buffer_list_push(struct buffer_list *ol, const char *str);
 
-struct buffer_entry *buffer_list_push_data(struct buffer_list *ol, const uint8_t *data, size_t size);
+struct buffer_entry *buffer_list_push_data(struct buffer_list *ol, const void *data, size_t size);
 
 struct buffer *buffer_list_peek(struct buffer_list *ol);
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 55b106c..650f9e0 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -250,7 +250,7 @@ man_output_list_push_str(struct management *man, const char *str)
 {
     if (management_connected(man) && str)
     {
-        buffer_list_push(man->connection.out, (const unsigned char *) str);
+        buffer_list_push(man->connection.out, str);
     }
 }
 
@@ -2190,13 +2190,13 @@ man_read(struct management *man)
          * process command line if complete
          */
         {
-            const unsigned char *line;
+            const char *line;
             while ((line = command_line_get(man->connection.in)))
             {
 #ifdef MANAGEMENT_IN_EXTRA
                 if (man->connection.in_extra)
                 {
-                    if (!strcmp((char *)line, "END"))
+                    if (!strcmp(line, "END"))
                     {
                         in_extra_dispatch(man);
                     }
@@ -3791,18 +3791,18 @@ command_line_add(struct command_line *cl, const unsigned char *buf, const int le
     }
 }
 
-const unsigned char *
+const char *
 command_line_get(struct command_line *cl)
 {
     int i;
-    const unsigned char *ret = NULL;
+    const char *ret = NULL;
 
     i = buf_substring_len(&cl->buf, '\n');
     if (i >= 0)
     {
         buf_copy_excess(&cl->residual, &cl->buf, i);
         buf_chomp(&cl->buf);
-        ret = (const unsigned char *) BSTR(&cl->buf);
+        ret = BSTR(&cl->buf);
     }
     return ret;
 }
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 676be64..364488f 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -70,7 +70,7 @@ void command_line_free(struct command_line *cl);
 
 void command_line_add(struct command_line *cl, const unsigned char *buf, const int len);
 
-const unsigned char *command_line_get(struct command_line *cl);
+const char *command_line_get(struct command_line *cl);
 
 void command_line_reset(struct command_line *cl);
 
-- 
2.7.4


