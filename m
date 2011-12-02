MIME-version: 1.0
From: David Sommerseth <davids@...1347...>
Date: Fri, 02 Dec 2011 12:02:14 +0100
Message-id: <1322823734-17993-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Windows does not have dirname() -
 reimplement a portable version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Commit 0f2bc0dd92f43c91e33bba8a66b06b98f281efc1 adds some extra
checks on configured files and directories.  This required use of
the dirname() function.  Unfortunately, this function is not available
on Windows.

This function reimplements the POSIX variant of dirname(), using the
framework already available in openvpn_basename().  The POSIX variant
of dirname() will modify the input data.

Signed-off-by: David Sommerseth <davids@...1347...>
Cc: Heiko Hund <heiko.hund@...1489...>
---
 misc.c    |   36 ++++++++++++++++++++++++++++++++----
 misc.h    |    3 +++
 options.c |    3 +--
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/misc.c b/misc.c
index 99e5bc5..eb04918 100644
--- a/misc.c
+++ b/misc.c
@@ -2370,10 +2370,13 @@ argv_test (void)
 }
 #endif
 
-const char *
-openvpn_basename (const char *path)
+
+enum ovpn_dirbasename_t { DIRNAME, BASENAME };
+
+static inline char *
+openvpn_dirbasename(char *path, enum ovpn_dirbasename_t type)
 {
-  const char *ret;
+  char *ret;
   const int dirsep = OS_SPECIFIC_DIRSEP;
 
   if (path)
@@ -2384,11 +2387,36 @@ openvpn_basename (const char *path)
       else
 	ret = path;
       if (*ret)
-	return ret;
+        switch( type ) {
+        case BASENAME:
+          return ret;
+
+        case DIRNAME:
+          /* This implements the POSIX variant of dirname(),
+           * which do modify the input
+           */
+          *(ret-1) = 0;
+          return path;
+        }
     }
   return NULL;
 }
 
+const char *
+openvpn_basename (const char *path)
+{
+  /* the path is recasted as non-const, as we are sure it will not be modified
+   * in the basename type
+   */
+  return (const char *) openvpn_dirbasename((char *) path, BASENAME);
+}
+
+const char *
+openvpn_dirname (char *path)
+{
+        return openvpn_dirbasename(path, DIRNAME);
+}
+
 /*
  * Remove security-sensitive strings from control message
  * so that they will not be output to log file.
diff --git a/misc.h b/misc.h
index b2e6f91..9b35f18 100644
--- a/misc.h
+++ b/misc.h
@@ -384,6 +384,9 @@ size_t adjust_power_of_2 (size_t u);
 /* return the basename of path */
 const char *openvpn_basename (const char *path);
 
+/* return the dirname of path - POSIX variant, which modifies the input */
+const char *openvpn_dirname (char *path);
+
 /*
  * A printf-like function (that only recognizes a subset of standard printf
  * format operators) that prints arguments to an argv list instead
diff --git a/options.c b/options.c
index 28296a5..a29c115 100644
--- a/options.c
+++ b/options.c
@@ -53,7 +53,6 @@
 #include "forward.h"
 #include <ctype.h>
 #include <unistd.h>
-#include <libgen.h>
 
 #include "memdbg.h"
 
@@ -2616,7 +2615,7 @@ check_file_access(const int type, const char *file, const int mode, const char *
   if (type & CHKACC_DIRPATH)
     {
       char *fullpath = strdup(file);  /* POSIX dirname() implementaion may modify its arguments */
-      char *dirpath = dirname(fullpath);
+      const char *dirpath = openvpn_dirname(fullpath);
 
       if (access (dirpath, mode|X_OK) != 0)
           errcode = errno;
-- 
1.7.4.4


