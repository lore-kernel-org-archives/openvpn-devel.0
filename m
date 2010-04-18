From: David Sommerseth <openvpn.list@...1114...>
Date: Sun, 18 Apr 2010 16:36:13 +0200
Message-Id: <1271601373-22374-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] Use more appropriate error codes in
	create_temp_file()
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
To: Openvpn-devel@lists.sourceforge.net
Cc: James Yonan <james@...515...>, David Sommerseth <dazo@...384...>

From: David Sommerseth <dazo@...384...>

Avoids using M_FATAL, which will terminate the OpenVPN process,
except where it really is needed.  It's considered needed when
the function fails after 5 attempts, as that most likely
indicates problem with getting enough random data for the filename.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 misc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc.c b/misc.c
index 643ffad..bd918ab 100644
--- a/misc.c
+++ b/misc.c
@@ -1190,7 +1190,7 @@ create_temp_file (const char *directory, const char *prefix, struct gc_arena *gc
       retfname = gen_path (directory, BSTR (&fname), gc);
       if (!retfname)
         {
-          msg (M_FATAL, "Failed to create temporary filename and path");
+          msg (M_WARN, "Failed to create temporary filename and path");
           return NULL;
         }
 
@@ -1206,7 +1206,7 @@ create_temp_file (const char *directory, const char *prefix, struct gc_arena *gc
         {
           /* Something else went wrong, no need to retry.  */
           struct gc_arena gcerr = gc_new ();
-          msg (M_FATAL, "Could not create temporary file '%s': %s",
+          msg (M_NONFATAL, "Could not create temporary file '%s': %s",
                retfname, strerror_ts (errno, &gcerr));
           gc_free (&gcerr);
           return NULL;
-- 
1.6.6.1


