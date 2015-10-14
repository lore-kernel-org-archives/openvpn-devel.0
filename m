From: Arne Schwabe <arne@...1227...>
Date: Wed, 14 Oct 2015 15:05:56 +0200
Message-Id: <1444827956-2169-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH V2] Fix commit
	c67acea173dc9ee37220f5b9ff14ede081181992
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

Move things to the proper place, ensure that line_ptr is actually properly
initialized for *every* line read, not just for the first one

---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 086dcea..c2b956d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3672,13 +3672,13 @@ static char *
 read_inline_file (struct in_src *is, const char *close_tag, struct gc_arena *gc)
 {
   char line[OPTION_LINE_SIZE];
-  char *line_ptr = line;
   struct buffer buf = alloc_buf (8*OPTION_LINE_SIZE);
   char *ret;
   bool endtagfound = false;
 
   while (in_src_get (is, line, sizeof (line)))
     {
+      char *line_ptr = line;        
       /* Remove leading spaces */
       while (isspace(*line_ptr)) line_ptr++;
       if (!strncmp (line_ptr, close_tag, strlen (close_tag)))
-- 
2.3.8 (Apple Git-58)


