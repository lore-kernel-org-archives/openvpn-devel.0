From: David Sommerseth <dazo@...384...>
Date: Fri, 17 Sep 2010 17:18:55 +0200
Message-Id: <1284736735-25248-1-git-send-email-dazo@...384...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fixed compiler warnings reported on Ubuntu
	10.04
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
Cc: David Sommerseth <dazo@...384...>

The warnings reported where:
--------------------------------------------------------
misc.c:158: warning: ignoring return value of ‘nice’, declared with attribute warn_unused_result
options.c:4033: warning: format not a string literal and no format arguments
options.c:4043: warning: format not a string literal and no format arguments
options.c:4053: warning: format not a string literal and no format arguments
push.c:182: warning: format not a string literal and no format arguments
push.c:199: warning: format not a string literal and no format arguments
push.c:235: warning: format not a string literal and no format arguments
status.c:171: warning: ignoring return value of ‘ftruncate’, declared with attribute warn_unused_result
--------------------------------------------------------

Signed-off-by: David Sommerseth <dazo@...384...>
---
 misc.c    |    5 ++---
 options.c |    6 +++---
 push.c    |    6 +++---
 status.c  |    4 +++-
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/misc.c b/misc.c
index eafd892..1e863f2 100644
--- a/misc.c
+++ b/misc.c
@@ -155,9 +155,8 @@ set_nice (int niceval)
     {
 #ifdef HAVE_NICE
       errno = 0;
-      nice (niceval);
-      if (errno != 0)
-	msg (M_WARN | M_ERRNO, "WARNING: nice %d failed", niceval);
+      if (nice (niceval) < 0 && errno != 0)
+	msg (M_WARN | M_ERRNO, "WARNING: nice %d failed: %s", niceval, strerror(errno));
       else
 	msg (M_INFO, "nice %d succeeded", niceval);
 #else
diff --git a/options.c b/options.c
index d40c7f0..3d0c5e3 100644
--- a/options.c
+++ b/options.c
@@ -4030,7 +4030,7 @@ add_option (struct options *options,
 		    {
 		      if (options->inetd != -1)
 			{
-			  msg (msglevel, opterr);
+			  msg (msglevel, "%s", opterr);
 			  goto err;
 			}
 		      else
@@ -4040,7 +4040,7 @@ add_option (struct options *options,
 		    {
 		      if (options->inetd != -1)
 			{
-			  msg (msglevel, opterr);
+			  msg (msglevel, "%s", opterr);
 			  goto err;
 			}
 		      else
@@ -4050,7 +4050,7 @@ add_option (struct options *options,
 		    {
 		      if (name != NULL)
 			{
-			  msg (msglevel, opterr);
+			  msg (msglevel, "%s", opterr);
 			  goto err;
 			}
 		      name = p[z];
diff --git a/push.c b/push.c
index 1320bec..40e64c3 100644
--- a/push.c
+++ b/push.c
@@ -179,7 +179,7 @@ send_push_reply (struct context *c)
   const int safe_cap = BCAP (&buf) - extra;
   bool push_sent = false;
 
-  buf_printf (&buf, cmd);
+  buf_printf (&buf, "%s", cmd);
 
   while (e)
     {
@@ -196,7 +196,7 @@ send_push_reply (struct context *c)
 		push_sent = true;
 		multi_push = true;
 		buf_reset_len (&buf);
-		buf_printf (&buf, cmd);
+		buf_printf (&buf, "%s", cmd);
 	      }
 	    }
 	  if (BLEN (&buf) + l >= safe_cap)
@@ -232,7 +232,7 @@ send_push_reply (struct context *c)
       bool status = false;
 
       buf_reset_len (&buf);
-      buf_printf (&buf, cmd);
+      buf_printf (&buf, "%s", cmd);
       status = send_control_channel_string (c, BSTR(&buf), D_PUSH);
       if (!status)
 	goto fail;
diff --git a/status.c b/status.c
index 92fc7bc..dd6fe1e 100644
--- a/status.c
+++ b/status.c
@@ -168,7 +168,9 @@ status_flush (struct status_output *so)
 #if defined(HAVE_FTRUNCATE)
       {
 	const off_t off = lseek (so->fd, (off_t)0, SEEK_CUR);
-	ftruncate (so->fd, off);
+	if (ftruncate (so->fd, off) != 0) {
+	  msg (M_WARN, "Failed to truncate status file: %s", strerror(errno));
+	}
       }
 #elif defined(HAVE_CHSIZE)
       {
-- 
1.7.2.3


