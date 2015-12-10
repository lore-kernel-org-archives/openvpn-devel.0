From: Arne Schwabe <arne@...1227...>
Date: Thu, 10 Dec 2015 13:37:10 +0100
Message-Id: <1449751030-10703-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Detect config lines that are too long and
	give a warning/error
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

This closes Trac ticket 631
---
 src/openvpn/options.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4347525..be4ba52 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3798,7 +3798,7 @@ read_config_file (struct options *options,
   const int max_recursive_levels = 10;
   FILE *fp;
   int line_num;
-  char line[OPTION_LINE_SIZE];
+  char line[OPTION_LINE_SIZE+1];
   char *p[MAX_PARMS];
 
   ++level;
@@ -3816,6 +3816,10 @@ read_config_file (struct options *options,
               int offset = 0;
 	      CLEAR (p);
 	      ++line_num;
+          if (strlen(line) == OPTION_LINE_SIZE)
+              msg (msglevel, "In %s:%d: Maximum optione line length (%d) exceeded, line starts with %s",
+                   file, line_num, OPTION_LINE_SIZE, line);
+
               /* Ignore UTF-8 BOM at start of stream */
               if (line_num == 1 && strncmp (line, "\xEF\xBB\xBF", 3) == 0)
                 offset = 3;
-- 
2.5.4 (Apple Git-61)


