From: Arne Schwabe <arne@...1227...>
Date: Mon, 29 Jun 2015 14:46:35 +0200
Message-Id: <1435581995-11820-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Report missing endtags of inline files as
	warnings
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

---
 src/openvpn/options.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 74276d4..24efb59 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3703,10 +3703,15 @@ read_inline_file (struct in_src *is, const char *close_tag, struct gc_arena *gc)
   char line[OPTION_LINE_SIZE];
   struct buffer buf = alloc_buf (8*OPTION_LINE_SIZE);
   char *ret;
+  bool endtagfound = false;
+
   while (in_src_get (is, line, sizeof (line)))
     {
       if (!strncmp (line, close_tag, strlen (close_tag)))
-	break;
+	{
+	  endtagfound = true;
+	  break;
+	}
       if (!buf_safe (&buf, strlen(line)))
 	{
 	  /* Increase buffer size */
@@ -3718,6 +3723,8 @@ read_inline_file (struct in_src *is, const char *close_tag, struct gc_arena *gc)
 	}
       buf_printf (&buf, "%s", line);
     }
+  if (!endtagfound)
+    msg (M_WARN, "WARNING: Endtag %s missing", close_tag);
   ret = string_alloc (BSTR (&buf), gc);
   buf_clear (&buf);
   free_buf (&buf);
-- 
2.3.2 (Apple Git-55)


