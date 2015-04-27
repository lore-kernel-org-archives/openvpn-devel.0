From: Steffan Karger <steffan@...1856...>
Date: Mon, 27 Apr 2015 10:12:22 +0200
Message-Id: <1430122342-11742-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Remove size limit for files inlined in
	config
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

As described in trac #484, the current inline file size limit of 10000
bytes is becoming an issue for some users.  Since RSA keys and signature
sizes are increasing, we need to adjust our limits.  As #484 reports,
10000 can be too small for PKCS#12 files with 4K RSA keys.  Instead of
postponing this issue by increasing the static limit, dynamically increase
the buffer size while reading. This keeps the memory usage limited but does
allow for larger inlined files.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/options.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e8cf06a..3195c5a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3698,12 +3698,21 @@ static char *
 read_inline_file (struct in_src *is, const char *close_tag, struct gc_arena *gc)
 {
   char line[OPTION_LINE_SIZE];
-  struct buffer buf = alloc_buf (10000);
+  struct buffer buf = alloc_buf (8*OPTION_LINE_SIZE);
   char *ret;
   while (in_src_get (is, line, sizeof (line)))
     {
       if (!strncmp (line, close_tag, strlen (close_tag)))
 	break;
+      if (!buf_safe (&buf, strlen(line)))
+	{
+	  /* Increase buffer size */
+	  struct buffer buf2 = alloc_buf (buf.capacity * 2);
+	  ASSERT (buf_copy (&buf2, &buf));
+	  buf_clear (&buf);
+	  free_buf (&buf);
+	  buf = buf2;
+	}
       buf_printf (&buf, "%s", line);
     }
   ret = string_alloc (BSTR (&buf), gc);
-- 
2.1.0


