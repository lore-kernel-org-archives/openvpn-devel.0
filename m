From: Gert Doering <gert@...1296...>
Date: Sun,  6 Dec 2020 13:57:11 +0100
Message-Id: <20201206125711.12071-1-gert@...1296...>
In-Reply-To: <20200920090929.8321-1-gert@...1296...>
References: <20200920090929.8321-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Fix line number reporting on config file
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

Fix by introducing an extra argument to read_inline_file() function:
"so many lines in the inline block", and changing the return values of
the "check_inline*()" functions to "int", changing this from "false/true"
to "0 = no inline, 1...N = inline with <N> lines".

On calling add_options() this is implicitly converted back to bool.

v2: use int return value, not extra call-by-reference parameter

Trac: #1325
---
 src/openvpn/options.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 21f8d494..d8a86560 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4659,7 +4659,8 @@ in_src_get(const struct in_src *is, char *line, const int size)
 }
 
 static char *
-read_inline_file(struct in_src *is, const char *close_tag, struct gc_arena *gc)
+read_inline_file(struct in_src *is, const char *close_tag,
+                 int *num_lines, struct gc_arena *gc)
 {
     char line[OPTION_LINE_SIZE];
     struct buffer buf = alloc_buf(8*OPTION_LINE_SIZE);
@@ -4668,6 +4669,7 @@ read_inline_file(struct in_src *is, const char *close_tag, struct gc_arena *gc)
 
     while (in_src_get(is, line, sizeof(line)))
     {
+        (*num_lines)++;
         char *line_ptr = line;
         /* Remove leading spaces */
         while (isspace(*line_ptr))
@@ -4701,10 +4703,10 @@ read_inline_file(struct in_src *is, const char *close_tag, struct gc_arena *gc)
     return ret;
 }
 
-static bool
+static int
 check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
 {
-    bool is_inline = false;
+    int num_inline_lines = 0;
 
     if (p[0] && !p[1])
     {
@@ -4717,16 +4719,15 @@ check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
             p[0] = string_alloc(arg + 1, gc);
             close_tag = alloc_buf(strlen(p[0]) + 4);
             buf_printf(&close_tag, "</%s>", p[0]);
-            p[1] = read_inline_file(is, BSTR(&close_tag), gc);
+            p[1] = read_inline_file(is, BSTR(&close_tag), &num_inline_lines, gc);
             p[2] = NULL;
             free_buf(&close_tag);
-            is_inline = true;
         }
     }
-    return is_inline;
+    return num_inline_lines;
 }
 
-static bool
+static int
 check_inline_file_via_fp(FILE *fp, char *p[], struct gc_arena *gc)
 {
     struct in_src is;
@@ -4735,7 +4736,7 @@ check_inline_file_via_fp(FILE *fp, char *p[], struct gc_arena *gc)
     return check_inline_file(&is, p, gc);
 }
 
-static bool
+static int
 check_inline_file_via_buf(struct buffer *multiline, char *p[],
                           struct gc_arena *gc)
 {
@@ -4806,13 +4807,13 @@ read_config_file(struct options *options,
                 }
                 if (parse_line(line + offset, p, SIZE(p)-1, file, line_num, msglevel, &options->gc))
                 {
-                    bool is_inline;
-
                     bypass_doubledash(&p[0]);
-                    is_inline = check_inline_file_via_fp(fp, p, &options->gc);
-                    add_option(options, p, is_inline, file, line_num, level,
+                    int lines_inline =
+                            check_inline_file_via_fp(fp, p, &options->gc);
+                    add_option(options, p, lines_inline, file, line_num, level,
                                msglevel, permission_mask, option_types_found,
                                es);
+                    line_num += lines_inline;
                 }
             }
             if (fp != stdin)
@@ -4855,12 +4856,12 @@ read_config_string(const char *prefix,
         ++line_num;
         if (parse_line(line, p, SIZE(p)-1, prefix, line_num, msglevel, &options->gc))
         {
-            bool is_inline;
-
             bypass_doubledash(&p[0]);
-            is_inline = check_inline_file_via_buf(&multiline, p, &options->gc);
-            add_option(options, p, is_inline, prefix, line_num, 0, msglevel,
+            int lines_inline =
+                    check_inline_file_via_buf(&multiline, p, &options->gc);
+            add_option(options, p, lines_inline, prefix, line_num, 0, msglevel,
                        permission_mask, option_types_found, es);
+            line_num += lines_inline;
         }
         CLEAR(p);
     }
-- 
2.26.2


