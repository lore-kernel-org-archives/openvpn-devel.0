From: David Sommerseth <davids@...1347...>
Date: Thu,  8 Dec 2011 16:24:20 +0100
Message-Id: <1323357860-2506-1-git-send-email-davids@...1347...>
In-Reply-To: <1323301588-29815-1-git-send-email-davids@...1347...>
References: <1323301588-29815-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH v3] Move away from openvpn_basename() over
	to platform provided basename()
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

This kicks out the openvpn_basename() function from misc.[ch] and puts
glibc equivalents into compat.[ch].  This is to provide the same
functionality on platforms not having a native basename() function
available.

In addition this patch adds dirname() which commit 0f2bc0dd92f43c91e
depends.  Without dirname(), openvpn won't build in Visual Studio.

v2: Move all functions from compat.h to compat.c
v3: Use glibc versions of basename() and dirname() instead

Signed-off-by: David Sommerseth <davids@...1347...>
---
 Makefile.am  |    1 +
 compat.c     |  129 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 compat.h     |   42 +++++++++++++++++++
 configure.ac |    2 +-
 init.c       |    6 ++-
 misc.c       |   23 +---------
 misc.h       |    3 -
 options.c    |    1 -
 syshead.h    |    2 +
 9 files changed, 182 insertions(+), 27 deletions(-)
 create mode 100644 compat.c
 create mode 100644 compat.h

diff --git a/Makefile.am b/Makefile.am
index 075270f..437f939 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -84,6 +84,7 @@ openvpn_SOURCES = \
 	circ_list.h \
 	clinat.c clinat.h \
 	common.h \
+	compat.h compat.c \
 	config-win32.h \
 	crypto.c crypto.h crypto_backend.h \
 	crypto_openssl.c crypto_openssl.h \
diff --git a/compat.c b/compat.c
new file mode 100644
index 0000000..cb599b0
--- /dev/null
+++ b/compat.c
@@ -0,0 +1,129 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2011 - David Sommerseth <davids@...1347...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include "syshead.h"
+#include "compat.h"
+#include <string.h>
+
+
+#ifndef HAVE_DIRNAME
+/* Unoptimised version of glibc memrchr().
+ * This is considered fast enough, as only this compat
+ * version of dirname() depends on it.
+ */
+static const char *
+__memrchr(const char *str, int c, size_t n)
+{
+  const char *end = str;
+
+  end += n - 1; /* Go to the end of the string */
+  while (end >= str) {
+    if(c == *end)
+      return end;
+    else
+      end--;
+  }
+  return NULL;
+}
+
+/* Modified version based on glibc-2.14.1 by Ulrich Drepper <drepper@...1529...>
+ * This version is extended to handle both / and \ in path names.
+ */
+char *
+dirname (char *path)
+{
+  static const char dot[] = ".";
+  char *last_slash;
+  char separator = '/';
+
+  /* Find last '/'.  */
+  last_slash = path != NULL ? strrchr (path, '/') : NULL;
+  /* If NULL, check for \ instead ... might be Windows a path */
+  if (!last_slash) {
+    last_slash = path != NULL ? strrchr (path, '\\') : NULL;
+    separator = last_slash ? '\\' : '/';  /* Change the separator if \ was found */
+  }
+
+  if (last_slash != NULL && last_slash != path && last_slash[1] == '\0') {
+      /* Determine whether all remaining characters are slashes.  */
+      char *runp;
+
+      for (runp = last_slash; runp != path; --runp)
+	if (runp[-1] != separator)
+	  break;
+
+      /* The '/' is the last character, we have to look further.  */
+      if (runp != path)
+	last_slash = (char *) __memrchr (path, separator, runp - path);
+    }
+
+  if (last_slash != NULL) {
+      /* Determine whether all remaining characters are slashes.  */
+      char *runp;
+
+      for (runp = last_slash; runp != path; --runp)
+	if (runp[-1] != separator)
+	  break;
+
+      /* Terminate the path.  */
+      if (runp == path) {
+	  /* The last slash is the first character in the string.  We have to
+	     return "/".  As a special case we have to return "//" if there
+	     are exactly two slashes at the beginning of the string.  See
+	     XBD 4.10 Path Name Resolution for more information.  */
+	  if (last_slash == path + 1)
+	    ++last_slash;
+	  else
+	    last_slash = path + 1;
+	}
+      else
+	last_slash = runp;
+
+      last_slash[0] = '\0';
+  } else
+    /* This assignment is ill-designed but the XPG specs require to
+       return a string containing "." in any case no directory part is
+       found and so a static and constant string is required.  */
+    path = (char *) dot;
+
+  return path;
+}
+#endif /* HAVE_DIRNAME */
+
+
+#ifndef HAVE_BASENAME
+/* Modified version based on glibc-2.14.1 by Roland McGrath <roland@...1269...>
+ * This version is extended to handle both / and \ in path names
+ */
+char *
+basename (const char *filename)
+{
+  char *p = strrchr (filenamem, '/');
+  if (!p) {
+    /* If NULL, check for \ instead ... might be Windows a path */
+    p = strrchr (filename, '\\');
+  }
+  return p ? p + 1 : (char *) filename;
+}
+#endif /* HAVE_BASENAME */
diff --git a/compat.h b/compat.h
new file mode 100644
index 0000000..b380f0b
--- /dev/null
+++ b/compat.h
@@ -0,0 +1,42 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2011 - David Sommerseth <davids@...1347...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef COMPAT_H
+#define COMPAT_H
+
+#include "config.h"
+
+#if defined(HAVE_BASENAME) || defined(HAVE_DIRNAME)
+#include <libgen.h>
+#endif
+
+#ifndef HAVE_DIRNAME
+char * dirname(char *str);
+#endif /* HAVE_DIRNAME */
+
+#ifndef HAVE_BASENAME
+char * basename(char *str);
+#endif /* HAVE_BASENAME */
+
+#endif /* COMPAT_H */
diff --git a/configure.ac b/configure.ac
index a4d68e6..173d6e2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -515,7 +515,7 @@ AC_CHECK_FUNCS(daemon chroot getpwnam setuid nice system getpid dup dup2 dnl
 	       getpass strerror syslog openlog mlockall getgrnam setgid dnl
 	       setgroups stat flock readv writev time dnl
 	       setsid chdir putenv getpeername unlink dnl
-	       chsize ftruncate execve getpeereid umask)
+	       chsize ftruncate execve getpeereid umask basename dirname)
 
 # Windows use stdcall for winsock so we cannot auto detect these
 m4_define([SOCKET_FUNCS], [socket recv recvfrom send sendto listen dnl
diff --git a/init.c b/init.c
index 82c1000..368adb4 100644
--- a/init.c
+++ b/init.c
@@ -862,8 +862,10 @@ init_verb_mute (struct context *c, unsigned int flags)
 void
 init_options_dev (struct options *options)
 {
-  if (!options->dev)
-    options->dev = openvpn_basename (options->dev_node);
+  if (!options->dev && options->dev_node) {
+    char *dev_node = strdup(options->dev_node); /* POSIX basename() implementaions may modify its arguments */
+    options->dev = basename (dev_node);
+  }
 }
 
 bool
diff --git a/misc.c b/misc.c
index 99e5bc5..aec12b8 100644
--- a/misc.c
+++ b/misc.c
@@ -2022,13 +2022,15 @@ argv_extract_cmd_name (const char *path)
 {
   if (path)
     {
-      const char *bn = openvpn_basename (path);
+      char *path_cp = strdup(path); /* POSIX basename() implementaions may modify its arguments */
+      const char *bn = basename (path_cp);
       if (bn)
 	{
 	  char *ret = string_alloc (bn, NULL);
 	  char *dot = strrchr (ret, '.');
 	  if (dot)
 	    *dot = '\0';
+	  free(path_cp);
 	  if (ret[0] != '\0')
 	    return ret;
 	}
@@ -2370,25 +2372,6 @@ argv_test (void)
 }
 #endif
 
-const char *
-openvpn_basename (const char *path)
-{
-  const char *ret;
-  const int dirsep = OS_SPECIFIC_DIRSEP;
-
-  if (path)
-    {
-      ret = strrchr (path, dirsep);
-      if (ret && *ret)
-	++ret;
-      else
-	ret = path;
-      if (*ret)
-	return ret;
-    }
-  return NULL;
-}
-
 /*
  * Remove security-sensitive strings from control message
  * so that they will not be output to log file.
diff --git a/misc.h b/misc.h
index b2e6f91..b1badd9 100644
--- a/misc.h
+++ b/misc.h
@@ -381,9 +381,6 @@ extern int script_method; /* GLOBAL */
 /* return the next largest power of 2 */
 size_t adjust_power_of_2 (size_t u);
 
-/* return the basename of path */
-const char *openvpn_basename (const char *path);
-
 /*
  * A printf-like function (that only recognizes a subset of standard printf
  * format operators) that prints arguments to an argv list instead
diff --git a/options.c b/options.c
index 3a819c9..2280e9b 100644
--- a/options.c
+++ b/options.c
@@ -53,7 +53,6 @@
 #include "forward.h"
 #include <ctype.h>
 #include <unistd.h>
-#include <libgen.h>
 
 #include "memdbg.h"
 
diff --git a/syshead.h b/syshead.h
index f3c0ac9..020b81f 100644
--- a/syshead.h
+++ b/syshead.h
@@ -36,6 +36,8 @@
 #include "config.h"
 #endif
 
+#include "compat.h"
+
 /* branch prediction hints */
 #if defined(__GNUC__)
 # define likely(x)       __builtin_expect((x),1)
-- 
1.7.4.4


