From: Gilles Espinasse <g.esp@...260...>
Date: Wed, 16 Feb 2011 22:55:14 +0100
Message-Id: <1297893314-9037-1-git-send-email-g.esp@...260...>
Subject: [Openvpn-devel] [PATCH 1/1] Fix warning: format not a string
	literal and no format arguments
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

Seen with gcc-4.4.5 and -Wformat -Wformat-security

Signed-off-by: Gilles Espinasse <g.esp@...260...>
---
 options.c |    6 +++---
 push.c    |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/options.c b/options.c
index 5f1efc5..208db30 100644
--- a/options.c
+++ b/options.c
@@ -4002,7 +4002,7 @@ add_option (struct options *options,
 		    {
 		      if (options->inetd != -1)
 			{
-			  msg (msglevel, opterr);
+			  msg (msglevel, "%s", opterr);
 			  goto err;
 			}
 		      else
@@ -4012,7 +4012,7 @@ add_option (struct options *options,
 		    {
 		      if (options->inetd != -1)
 			{
-			  msg (msglevel, opterr);
+			  msg (msglevel, "%s", opterr);
 			  goto err;
 			}
 		      else
@@ -4022,7 +4022,7 @@ add_option (struct options *options,
 		    {
 		      if (name != NULL)
 			{
-			  msg (msglevel, opterr);
+			  msg (msglevel, "%s", opterr);
 			  goto err;
 			}
 		      name = p[z];
diff --git a/push.c b/push.c
index 9ddc900..86ac4a7 100644
--- a/push.c
+++ b/push.c
@@ -178,7 +178,7 @@ send_push_reply (struct context *c)
   const int extra = 64; /* extra space for possible trailing ifconfig and push-continuation */
   const int safe_cap = BCAP (&buf) - extra;
 
-  buf_printf (&buf, cmd);
+  buf_printf (&buf, "%s", cmd);
 
   while (e)
     {
@@ -194,7 +194,7 @@ send_push_reply (struct context *c)
 		  goto fail;
 		multi_push = true;
 		buf_reset_len (&buf);
-		buf_printf (&buf, cmd);
+		buf_printf (&buf, "%s", cmd);
 	      }
 	    }
 	  if (BLEN (&buf) + l >= safe_cap)
-- 
1.7.3.4


