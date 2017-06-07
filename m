MIME-Version: 1.0
From: Guido Vranken <guidovranken@...277...>
Date: Thu, 8 Jun 2017 01:02:38 +0200
Message-ID: <CAO5O-EKCLjPpdKUH6cCoqoZDAfekSafpc7Ga55H2_5Hs4rBopg@...278...>
Subject: [Openvpn-devel] [PATCH] Add one element (a terminating NULL
 pointer) to the array into which parse_line() stores the arguments. This
 prevents that options that traverse this array until a terminator is seen
 (for instance options that call no_more_than_n_args) will peek beyond
 buffer bounds. In the worst case this might lead to a crash (stack overflow,
 not likely in practice).
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Guido Vranken <guidovranken@...277...>
---
 src/openvpn/options.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 452087a..91d8280 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4531,7 +4531,7 @@ read_config_file(struct options *options,
     FILE *fp;
     int line_num;
     char line[OPTION_LINE_SIZE+1];
-    char *p[MAX_PARMS];
+    char *p[MAX_PARMS+1];

     ++level;
     if (level <= max_recursive_levels)
@@ -4563,7 +4563,7 @@ read_config_file(struct options *options,
                 {
                     offset = 3;
                 }
-                if (parse_line(line + offset, p, SIZE(p), file,
line_num, msglevel, &options->gc))
+                if (parse_line(line + offset, p, SIZE(p)-1, file,
line_num, msglevel, &options->gc))
                 {
                     bypass_doubledash(&p[0]);
                     check_inline_file_via_fp(fp, p, &options->gc);
@@ -4605,10 +4605,10 @@ read_config_string(const char *prefix,

     while (buf_parse(&multiline, '\n', line, sizeof(line)))
     {
-        char *p[MAX_PARMS];
+        char *p[MAX_PARMS+1];
         CLEAR(p);
         ++line_num;
-        if (parse_line(line, p, SIZE(p), prefix, line_num, msglevel,
&options->gc))
+        if (parse_line(line, p, SIZE(p)-1, prefix, line_num,
msglevel, &options->gc))
         {
             bypass_doubledash(&p[0]);
             check_inline_file_via_buf(&multiline, p, &options->gc);
@@ -4739,14 +4739,14 @@ apply_push_options(struct options *options,

     while (buf_parse(buf, ',', line, sizeof(line)))
     {
-        char *p[MAX_PARMS];
+        char *p[MAX_PARMS+1];
         CLEAR(p);
         ++line_num;
         if (!apply_pull_filter(options, line))
         {
             return false; /* Cause push/pull error and stop push processing */
         }
-        if (parse_line(line, p, SIZE(p), file, line_num, msglevel,
&options->gc))
+        if (parse_line(line, p, SIZE(p)-1, file, line_num, msglevel,
&options->gc))
         {
             add_option(options, p, file, line_num, 0, msglevel,
permission_mask, option_types_found, es);
         }
-- 
2.1.4

