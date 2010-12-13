From: David Sommerseth <dazo@...384...>
Date: Mon, 13 Dec 2010 10:56:09 +0100
Message-Id: <1292234169-12388-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] Use \r\n as newline in log files on Windows
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

The newline style is different from most Unices and Windows, where
Windows uses \r\n instead of just \n.

Reported-by: Thomas Reifferscheid
Signed-off-by: David Sommerseth <dazo@...384...>
---
 config-win32.h |    3 +++
 error.c        |   12 ++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/config-win32.h b/config-win32.h
index be0b320..56c40cd 100644
--- a/config-win32.h
+++ b/config-win32.h
@@ -275,6 +275,9 @@ typedef unsigned long in_addr_t;
 #error The Windows version of OpenVPN does not support PTHREAD yet
 #endif
 
+/* Windows uses a different NL style than *nix for logging */
+#define NEWLINE "\r\n"
+
 #ifdef _MSC_VER
 /* MSVC++ hacks */
 #pragma warning(disable:4244) // conversion from 'foo' to 'bar', possible loss of data
diff --git a/error.c b/error.c
index 873718c..40c8107 100644
--- a/error.c
+++ b/error.c
@@ -49,6 +49,10 @@
 #endif
 #endif
 
+#ifndef NEWLINE
+#define NEWLINE "\n"
+#endif
+
 /* Globals */
 unsigned int x_debug_level; /* GLOBAL */
 
@@ -326,7 +330,7 @@ void x_msg (const unsigned int flags, const char *format, ...)
 		       prefix,
 		       prefix_sep,
 		       m1,
-		       (flags&M_NOLF) ? "" : "\n");
+		       (flags&M_NOLF) ? "" : NEWLINE);
 	    }
 	  else
 	    {
@@ -337,14 +341,14 @@ void x_msg (const unsigned int flags, const char *format, ...)
 		       prefix,
 		       prefix_sep,
 		       m1,
-		       (flags&M_NOLF) ? "" : "\n");
+		       (flags&M_NOLF) ? "" : NEWLINE);
 #else
 	      fprintf (fp, "%s %s%s%s%s",
 		       time_string (0, 0, show_usec, &gc),
 		       prefix,
 		       prefix_sep,
 		       m1,
-		       (flags&M_NOLF) ? "" : "\n");
+		       (flags&M_NOLF) ? "" : NEWLINE);
 #endif
 	    }
 	  fflush(fp);
@@ -411,7 +415,7 @@ assert_failed (const char *filename, int line)
 void
 out_of_memory (void)
 {
-  fprintf (stderr, PACKAGE_NAME ": Out of Memory\n");
+  fprintf (stderr, PACKAGE_NAME ": Out of Memory" NEWLINE);
   exit (1);
 }
 
-- 
1.7.2.3


