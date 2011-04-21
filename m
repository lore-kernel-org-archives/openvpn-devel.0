From: David Sommerseth <davids@...1347...>
Date: Thu, 21 Apr 2011 20:47:09 +0200
Message-Id: <1303411629-8344-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Improve the mysprintf() issue in
	openvpnserv.c
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

From: David Sommerseth <dazo@...384...>

A quick and dirty compile fix was introduced in commit 77d244050964525417,
and was accepted under the condition that it would be a temporary fix.

As the usage of _snprintf() is realy not ideal on Windows, this patch
uses the same well tested openvpn_snprintf() function from buffer.c.
It was a longer discussion of several possibilities to re-use that code,
but in the end it seemed easier to just copy-paste this function to
openvpnserv.c for now.

The reason for this conclusion was that the function is really simple,
well defined and will most likely not be changed much in the future.
It is also added a comment in openvpnserv.c where this function
has its origins.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 service-win32/openvpnserv.c |   39 ++++++++++++++++++++++++++++-----------
 1 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/service-win32/openvpnserv.c b/service-win32/openvpnserv.c
index b5d8d37..5b0eb6e 100755
--- a/service-win32/openvpnserv.c
+++ b/service-win32/openvpnserv.c
@@ -37,6 +37,7 @@
 #include <windows.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <stdarg.h>
 #include <process.h>
 #include "service.h"
 
@@ -79,13 +80,6 @@ static HANDLE exit_event = NULL;
 /* clear an object */
 #define CLEAR(x) memset(&(x), 0, sizeof(x))
 
-/* snprintf with guaranteed null termination */
-#define mysnprintf(out, ...) \
-        { \
-           _snprintf (out, sizeof(out), __VA_ARGS__); \
-           out [sizeof (out) - 1] = '\0'; \
-        }
-
 /*
  * Message handling
  */
@@ -97,7 +91,7 @@ static HANDLE exit_event = NULL;
 #define MSG(flags, ...) \
         { \
            char x_msg[256]; \
-           mysnprintf (x_msg, __VA_ARGS__); \
+           openvpn_snprintf (x_msg, sizeof(x_msg), __VA_ARGS__);      \
            AddToMessageLog ((flags), x_msg); \
         }
 
@@ -129,6 +123,28 @@ static HANDLE exit_event = NULL;
       } \
   }
 
+/*
+ * This is necessary due to certain buggy implementations of snprintf,
+ * that don't guarantee null termination for size > 0.
+ * (copied from ../buffer.c, line 217)
+ * (git: 100644 blob e2f8caab0a5b2a870092c6cd508a1a50c21c3ba3	buffer.c)
+ */
+
+int openvpn_snprintf(char *str, size_t size, const char *format, ...)
+{
+  va_list arglist;
+  int ret = 0;
+  if (size > 0)
+    {
+      va_start (arglist, format);
+      ret = vsnprintf (str, size, format, arglist);
+      va_end (arglist);
+      str[size - 1] = 0;
+    }
+  return ret;
+}
+
+
 bool
 init_security_attributes_allow_all (struct security_attributes *obj)
 {
@@ -353,7 +369,7 @@ VOID ServiceStart (DWORD dwArgc, LPTSTR *lpszArgv)
     BOOL more_files;
     char find_string[MAX_PATH];
 
-    mysnprintf (find_string, "%s\\*", config_dir);
+    openvpn_snprintf (find_string, MAX_PATH, "%s\\*", config_dir);
 
     find_handle = FindFirstFile (find_string, &find_obj);
     if (find_handle == INVALID_HANDLE_VALUE)
@@ -395,10 +411,11 @@ VOID ServiceStart (DWORD dwArgc, LPTSTR *lpszArgv)
 	      FindClose (find_handle);
 	      goto finish;
 	    }
-	  mysnprintf (log_path, "%s\\%s", log_dir, log_file);
+	  openvpn_snprintf (log_path, sizeof(log_path),
+                            "%s\\%s", log_dir, log_file);
 
 	  /* construct command line */
-	  mysnprintf (command_line, PACKAGE " --service %s 1 --config \"%s\"",
+	  openvpn_snprintf (command_line, sizeof(command_line), PACKAGE " --service %s 1 --config \"%s\"",
 		      EXIT_EVENT_NAME,
 		      find_obj.cFileName);
 
-- 
1.7.4.4


