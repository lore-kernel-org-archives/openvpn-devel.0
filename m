From: Gert Doering <gert@...1296...>
Date: Sun, 14 Sep 2025 19:46:29 +0200
Message-ID: <20250914174638.6867-1-gert@...1296...>
In-Reply-To: <gerrit.1754490554000.Ifc183e42b190e19e1d8c351d1cd460a038626e63@...2715...>
References: <gerrit.1754490554000.Ifc183e42b190e19e1d8c351d1cd460a038626e63@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] manage: Change command_line_* API to use
 size_t for lengths
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

The used functions already expect this.

Change-Id: Ifc183e42b190e19e1d8c351d1cd460a038626e63
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1136
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 16b1b73..9750d58 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2247,7 +2247,7 @@
         bool processed_command = false;
 
         ASSERT(len <= (int)sizeof(buf));
-        command_line_add(man->connection.in, buf, len);
+        command_line_add(man->connection.in, buf, (size_t)len);
 
         /*
          * Reset output object
@@ -3786,7 +3786,7 @@
  */
 
 struct command_line *
-command_line_new(const int buf_len)
+command_line_new(const size_t buf_len)
 {
     struct command_line *cl;
     ALLOC_OBJ_CLEAR(cl, struct command_line);
@@ -3816,10 +3816,9 @@
 }
 
 void
-command_line_add(struct command_line *cl, const unsigned char *buf, const int len)
+command_line_add(struct command_line *cl, const unsigned char *buf, const size_t len)
 {
-    int i;
-    for (i = 0; i < len; ++i)
+    for (size_t i = 0; i < len; ++i)
     {
         if (buf[i] && char_class(buf[i], (CC_PRINT | CC_NEWLINE)))
         {
@@ -3834,10 +3833,9 @@
 const char *
 command_line_get(struct command_line *cl)
 {
-    int i;
     const char *ret = NULL;
 
-    i = buf_substring_len(&cl->buf, '\n');
+    int i = buf_substring_len(&cl->buf, '\n');
     if (i >= 0)
     {
         buf_copy_excess(&cl->residual, &cl->buf, i);
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 01d180a..e234df7 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -83,11 +83,11 @@
     struct buffer residual;
 };
 
-struct command_line *command_line_new(const int buf_len);
+struct command_line *command_line_new(const size_t buf_len);
 
 void command_line_free(struct command_line *cl);
 
-void command_line_add(struct command_line *cl, const unsigned char *buf, const int len);
+void command_line_add(struct command_line *cl, const unsigned char *buf, const size_t len);
 
 const char *command_line_get(struct command_line *cl);
 

