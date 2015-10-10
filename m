From: janjust@...1147...
Date: Sat, 10 Oct 2015 18:12:49 +0200
Message-Id: <1444493569-24026-1-git-send-email-janjust@...1147...>
Subject: [Openvpn-devel] [PATCH] Fix trac ticket #569
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

From: janjust <janjust@...1147...>

Fix trac ticket #569 "White space before end tags can break the config parser"
   https://community.openvpn.net/openvpn/ticket/569

---
 src/openvpn/options.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7906f46..11e327c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3694,13 +3694,16 @@ static char *
 read_inline_file (struct in_src *is, const char *close_tag, struct gc_arena *gc)
 {
   char line[OPTION_LINE_SIZE];
+  char *line_ptr = line;
   struct buffer buf = alloc_buf (8*OPTION_LINE_SIZE);
   char *ret;
   bool endtagfound = false;
 
   while (in_src_get (is, line, sizeof (line)))
     {
-      if (!strncmp (line, close_tag, strlen (close_tag)))
+      /* Remove leading spaces */
+      while (isspace(*line_ptr)) line_ptr++;
+      if (!strncmp (line_ptr, close_tag, strlen (close_tag)))
 	{
 	  endtagfound = true;
 	  break;
-- 
1.7.1


