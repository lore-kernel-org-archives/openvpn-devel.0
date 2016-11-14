From: David Sommerseth <davids@...515...>
Date: Mon, 14 Nov 2016 23:45:08 +0100
Message-Id: <1479163508-19435-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] file checks: Merge
	warn_if_group_others_accessible() into check_file_access()
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

Commit 825e2ec1f358f2e8 cleaned up the usage of warn_if_group_others_accessible()
and moved it into options.c.  At this point there is only one caller of this
function, check_file_access().

This takes that clean-up one step further and merges everything into
check_file_access().  In addition it removes some no longer needed #ifdefs
and uses platform_stat() to allow a similar check to happen on the Windows
platform as well.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/options.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4d31e4c..369f3f4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -57,6 +57,7 @@
 #include "manage.h"
 #include "forward.h"
 #include "ssl_verify.h"
+#include "platform.h"
 #include <ctype.h>
 
 #include "memdbg.h"
@@ -2683,31 +2684,6 @@ options_postprocess_mutate (struct options *o)
  */
 #ifndef ENABLE_SMALL  /** Expect people using the stripped down version to know what they do */
 
-/*
- * Warn if a given file is group/others accessible.
- */
-static void
-warn_if_group_others_accessible (const char* filename)
-{
-#ifndef WIN32
-#ifdef HAVE_STAT
-  if (strcmp (filename, INLINE_FILE_TAG))
-    {
-      struct stat st;
-      if (stat (filename, &st))
-	{
-	  msg (M_WARN | M_ERRNO, "WARNING: cannot stat file '%s'", filename);
-	}
-      else
-	{
-	  if (st.st_mode & (S_IRWXG|S_IRWXO))
-	    msg (M_WARN, "WARNING: file '%s' is group or others accessible", filename);
-	}
-    }
-#endif
-#endif
-}
-
 #define CHKACC_FILE (1<<0)       /** Check for a file/directory precense */
 #define CHKACC_DIRPATH (1<<1)    /** Check for directory precense where a file should reside */
 #define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is it writable? */
@@ -2754,9 +2730,19 @@ check_file_access(const int type, const char *file, const int mode, const char *
     if (platform_access (file, W_OK) != 0)
       errcode = errno;
 
+  /* Warn if a given file is group/others accessible. */
   if (type & CHKACC_PRIVATE)
     {
-      warn_if_group_others_accessible (file);
+      platform_stat_t st;
+      if (platform_stat (file, &st))
+	{
+	  msg (M_WARN | M_ERRNO, "WARNING: cannot stat file '%s'", file);
+	}
+      else
+	{
+	  if (st.st_mode & (S_IRWXG|S_IRWXO))
+	    msg (M_WARN, "WARNING: file '%s' is group or others accessible", file);
+	}
     }
 
   /* Scream if an error is found */
-- 
1.8.3.1


