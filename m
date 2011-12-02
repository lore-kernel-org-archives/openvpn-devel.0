MIME-version: 1.0
From: David Sommerseth <davids@...1347...>
Date: Fri, 02 Dec 2011 12:02:35 +0100
Message-id: <1322823755-18052-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Provide an access() wrapper for Windows
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
wrapper for the needed access() function.

Signed-off-by: David Sommerseth <davids@...1347...>
Cc: Heiko Hund <heiko.hund@...1489...>
---
 options.c |    1 -
 syshead.h |    3 +++
 win32.h   |   21 +++++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/options.c b/options.c
index a29c115..090bbde 100644
--- a/options.c
+++ b/options.c
@@ -52,7 +52,6 @@
 #include "configure.h"
 #include "forward.h"
 #include <ctype.h>
-#include <unistd.h>
 
 #include "memdbg.h"
 
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
index 23c04be..f973849 100644
--- a/win32.h
+++ b/win32.h
@@ -70,6 +70,27 @@ struct security_attributes
 
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
+static inline int
+access( const char *path, int mode) {
+  return _access(path, mode);
+}
+
 /*
  * Save old window title.
  */
-- 
1.7.4.4


