MIME-version: 1.0
From: David Sommerseth <davids@...1347...>
Date: Fri, 02 Dec 2011 13:17:23 +0100
Message-id: <1322828243-21196-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH v2] Provide an access() wrapper for Windows
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

Commit 0f2bc0dd92f43c91e33bba8a66b06b98f281efc1 adds extra file and
directory checks at startup.  However, this patch makes use of some
features not directly available in Windows.

This patch avoids #include <unistd.h> on Windows and provides a
wrapper for the needed access() function.  The wrapper function
which is global for all platforms is called openvpn_access()

Signed-off-by: David Sommerseth <davids@...1347...>
Cc: Heiko Hund <heiko.hund@...1489...>
---
 misc.h    |   12 ++++++++++++
 options.c |    9 ++++-----
 syshead.h |    3 +++
 win32.h   |   20 ++++++++++++++++++++
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/misc.h b/misc.h
index 9b35f18..223467e 100644
--- a/misc.h
+++ b/misc.h
@@ -387,6 +387,18 @@ const char *openvpn_basename (const char *path);
 /* return the dirname of path - POSIX variant, which modifies the input */
 const char *openvpn_dirname (char *path);
 
+/* access() wrapper, for both Windows and POSIX environments */
+#ifdef WIN32
+static inline int
+openvpn_access( const char *path, int mode) {
+  return _access(path, mode);
+}
+#else
+static inline int
+openvpn_access( const char *path, int mode) {
+  return access(path, mode);
+}
+#endif
 /*
  * A printf-like function (that only recognizes a subset of standard printf
  * format operators) that prints arguments to an argv list instead
diff --git a/options.c b/options.c
index a29c115..891bb7f 100644
--- a/options.c
+++ b/options.c
@@ -52,7 +52,6 @@
 #include "configure.h"
 #include "forward.h"
 #include <ctype.h>
-#include <unistd.h>
 
 #include "memdbg.h"
 
@@ -2617,18 +2616,18 @@ check_file_access(const int type, const char *file, const int mode, const char *
       char *fullpath = strdup(file);  /* POSIX dirname() implementaion may modify its arguments */
       const char *dirpath = openvpn_dirname(fullpath);
 
-      if (access (dirpath, mode|X_OK) != 0)
+      if (openvpn_access (dirpath, mode|X_OK) != 0)
           errcode = errno;
       free(fullpath);
     }
 
   /* Is the file itself accessible? */
-  if (!errcode && (type & CHKACC_FILE) && (access (file, mode) != 0) )
+  if (!errcode && (type & CHKACC_FILE) && (openvpn_access (file, mode) != 0) )
       errcode = errno;
 
   /* If the file exists and is accessible, is it writable? */
-  if (!errcode && (type & CHKACC_FILEXSTWR) && (access (file, F_OK) == 0) )
-    if (access (file, W_OK) != 0)
+  if (!errcode && (type & CHKACC_FILEXSTWR) && (openvpn_access (file, F_OK) == 0) )
+    if (openvpn_access (file, W_OK) != 0)
       errcode = errno;
 
   /* Scream if an error is found */
diff --git a/syshead.h b/syshead.h
index f3c0ac9..232c214 100644
--- a/syshead.h
+++ b/syshead.h
@@ -52,9 +52,12 @@
 #ifdef WIN32
 #include <windows.h>
 #include <winsock2.h>
+#include <io.h>
 #define sleep(x) Sleep((x)*1000)
 #define random rand
 #define srandom srand
+#else
+#include <unistd.h>
 #endif
 
 #if defined(__APPLE__)
diff --git a/win32.h b/win32.h
index 23c04be..2b9cb8b 100644
--- a/win32.h
+++ b/win32.h
@@ -70,6 +70,26 @@ struct security_attributes
 
 #define HANDLE_DEFINED(h) ((h) != NULL && (h) != INVALID_HANDLE_VALUE)
 
+/* Provide wrapper for the access() function
+ * based on information found here:
+ * http://msdn.microsoft.com/en-us/library/1w06ktdy%28v=vs.80%29.aspx
+ */
+#ifndef R_OK
+#define R_OK 4
+#endif
+
+#ifndef W_OK
+#define W_OK 2
+#endif
+
+#ifndef X_OK
+#define X_OK 1
+#endif
+
+#ifndef F_OK
+#define F_OK 0
+#endif
+
 /*
  * Save old window title.
  */
-- 
1.7.4.4


