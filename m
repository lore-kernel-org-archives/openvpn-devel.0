From: Gert Doering <gert@...1296...>
Date: Sun, 20 Sep 2020 11:09:29 +0200
Message-Id: <20200920090929.8321-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix line number reporting on config file
 errors after <inline> segments
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

<inline> segments neglected to increment the "current line number
in config file" variable (line_num), so after the first <inline>,
errors reported have the wrong line number.

Fix by introducing an extra argument to the check_inline*() /
read_inline_file() call chain: "so many lines in the inline block".

Trac: #1325

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f370a2bb..af517bab 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4634,7 +4634,8 @@ in_src_get(const struct in_src *is, char *line, const int size)
 }
 
 static char *
-read_inline_file(struct in_src *is, const char *close_tag, struct gc_arena *gc)
+read_inline_file(struct in_src *is, const char *close_tag,
+                 int *num_lines, struct gc_arena *gc)
 {
     char line[OPTION_LINE_SIZE];
     struct buffer buf = alloc_buf(8*OPTION_LINE_SIZE);
@@ -4643,6 +4644,7 @@ read_inline_file(struct in_src *is, const char *close_tag, struct gc_arena *gc)
 
     while (in_src_get(is, line, sizeof(line)))
     {
+        (*num_lines)++;
         char *line_ptr = line;
         /* Remove leading spaces */
         while (isspace(*line_ptr))
@@ -4677,9 +4679,11 @@ read_inline_file(struct in_src *is, const char *close_tag, struct gc_arena *gc)
 }
 
 static bool
-check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
+check_inline_file(struct in_src *is, char *p[],
+                  int *num_lines, struct gc_arena *gc)
 {
     bool is_inline = false;
+    *num_lines = 0;
 
     if (p[0] && !p[1])
     {
@@ -4692,7 +4696,7 @@ check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
             p[0] = string_alloc(arg + 1, gc);
             close_tag = alloc_buf(strlen(p[0]) + 4);
             buf_printf(&close_tag, "</%s>", p[0]);
-            p[1] = read_inline_file(is, BSTR(&close_tag), gc);
+            p[1] = read_inline_file(is, BSTR(&close_tag), num_lines, gc);
             p[2] = NULL;
             free_buf(&close_tag);
             is_inline = true;
@@ -4702,22 +4706,23 @@ check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
 }
 
 static bool
-check_inline_file_via_fp(FILE *fp, char *p[], struct gc_arena *gc)
+check_inline_file_via_fp(FILE *fp, char *p[],
+                         int *num_lines, struct gc_arena *gc)
 {
     struct in_src is;
     is.type = IS_TYPE_FP;
     is.u.fp = fp;
-    return check_inline_file(&is, p, gc);
+    return check_inline_file(&is, p, num_lines, gc);
 }
 
 static bool
 check_inline_file_via_buf(struct buffer *multiline, char *p[],
-                          struct gc_arena *gc)
+                          int *num_lines, struct gc_arena *gc)
 {
     struct in_src is;
     is.type = IS_TYPE_BUF;
     is.u.multiline = multiline;
-    return check_inline_file(&is, p, gc);
+    return check_inline_file(&is, p, num_lines, gc);
 }
 
 static void
@@ -4782,12 +4787,15 @@ read_config_file(struct options *options,
                 if (parse_line(line + offset, p, SIZE(p)-1, file, line_num, msglevel, &options->gc))
                 {
                     bool is_inline;
+                    int lines;
 
                     bypass_doubledash(&p[0]);
-                    is_inline = check_inline_file_via_fp(fp, p, &options->gc);
+                    is_inline = check_inline_file_via_fp(fp, p,
+                                                         &lines, &options->gc);
                     add_option(options, p, is_inline, file, line_num, level,
                                msglevel, permission_mask, option_types_found,
                                es);
+                    line_num += lines;
                 }
             }
             if (fp != stdin)
@@ -4831,11 +4839,14 @@ read_config_string(const char *prefix,
         if (parse_line(line, p, SIZE(p)-1, prefix, line_num, msglevel, &options->gc))
         {
             bool is_inline;
+            int lines;
 
             bypass_doubledash(&p[0]);
-            is_inline = check_inline_file_via_buf(&multiline, p, &options->gc);
+            is_inline = check_inline_file_via_buf(&multiline, p,
+                                                  &lines, &options->gc);
             add_option(options, p, is_inline, prefix, line_num, 0, msglevel,
                        permission_mask, option_types_found, es);
+            line_num += lines;
         }
         CLEAR(p);
     }
-- 
2.26.2


