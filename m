From: Arne Schwabe <arne@...1227...>
Date: Mon, 27 Jul 2015 17:33:11 +0200
Message-Id: <1438011191-19389-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix commit e473b7c if an inline file
	happens to have a line break exactly at buffer limit
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

The check does only for strlen(line) space and buf_printf will only use at most space -1
and not print the final character ('\n') in this corner. Since a missing \n only breaks
certificates at the start and end marker, missing line breaks otherwise do not trigger this
error.
---
 src/openvpn/buffer.h  | 5 ++++-
 src/openvpn/options.c | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 5695f64..0dc511b 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -329,7 +329,10 @@ has_digit (const unsigned char* src)
 }
 
 /*
- * printf append to a buffer with overflow check
+ * printf append to a buffer with overflow check,
+ * due to usage of vsnprintf, it will leave space for
+ * a final null character and thus use only
+ * capacity - 1
  */
 bool buf_printf (struct buffer *buf, const char *format, ...)
 #ifdef __GNUC__
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 93baa2b..737d9a2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3712,7 +3712,7 @@ read_inline_file (struct in_src *is, const char *close_tag, struct gc_arena *gc)
 	  endtagfound = true;
 	  break;
 	}
-      if (!buf_safe (&buf, strlen(line)))
+      if (!buf_safe (&buf, strlen(line)+1))
 	{
 	  /* Increase buffer size */
 	  struct buffer buf2 = alloc_buf (buf.capacity * 2);
@@ -3722,6 +3722,7 @@ read_inline_file (struct in_src *is, const char *close_tag, struct gc_arena *gc)
 	  buf = buf2;
 	}
       buf_printf (&buf, "%s", line);
+
     }
   if (!endtagfound)
     msg (M_FATAL, "ERROR: Endtag %s missing", close_tag);
-- 
1.9.1


