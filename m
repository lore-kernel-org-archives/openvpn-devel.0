From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:12:18 +0200
Message-Id: <1330546342-17794-49-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 48/52] cleanup: move console related
	function into its own module
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/Makefile.am    |    1 +
 src/openvpn/console.c      |  238 ++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/console.h      |   33 ++++++
 src/openvpn/misc.c         |  125 +-----------------------
 src/openvpn/misc.h         |    3 +-
 src/openvpn/openvpn.vcproj |    8 ++
 src/openvpn/pkcs11.c       |    1 +
 src/openvpn/win32.c        |   87 +----------------
 src/openvpn/win32.h        |    5 +-
 9 files changed, 286 insertions(+), 215 deletions(-)
 create mode 100644 src/openvpn/console.c
 create mode 100644 src/openvpn/console.h

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index e170380..333eebc 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -58,6 +58,7 @@ openvpn_SOURCES = \
 	mbuf.c mbuf.h \
 	memdbg.h \
 	misc.c misc.h \
+	console.c console.h \
 	mroute.c mroute.h \
 	mss.c mss.h \
 	mstats.c mstats.h \
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
new file mode 100644
index 0000000..2464e7e
--- /dev/null
+++ b/src/openvpn/console.c
@@ -0,0 +1,238 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
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
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+#include "console.h"
+#include "error.h"
+#include "buffer.h"
+#include "misc.h"
+
+#ifdef WIN32
+
+#include "win32.h"
+
+/*
+ * Get input from console.
+ *
+ * Return false on input error, or if service
+ * exit event is signaled.
+ */
+
+static bool
+get_console_input_win32 (const char *prompt, const bool echo, char *input, const int capacity)
+{
+  HANDLE in = INVALID_HANDLE_VALUE;
+  HANDLE err = INVALID_HANDLE_VALUE;
+  DWORD len = 0;
+
+  ASSERT (prompt);
+  ASSERT (input);
+  ASSERT (capacity > 0);
+
+  input[0] = '\0';
+
+  in = GetStdHandle (STD_INPUT_HANDLE);
+  err = get_orig_stderr ();
+
+  if (in != INVALID_HANDLE_VALUE
+      && err != INVALID_HANDLE_VALUE
+      && !win32_service_interrupt (&win32_signal)
+      && WriteFile (err, prompt, strlen (prompt), &len, NULL))
+    {
+      bool is_console = (GetFileType (in) == FILE_TYPE_CHAR);
+      DWORD flags_save = 0;
+      int status = 0;
+      WCHAR *winput;
+
+      if (is_console)
+	{
+	  if (GetConsoleMode (in, &flags_save))
+	    {
+	      DWORD flags = ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT;
+	      if (echo)
+		flags |= ENABLE_ECHO_INPUT;
+	      SetConsoleMode (in, flags);
+	    }
+	  else
+	    is_console = 0;
+	}
+
+      if (is_console)
+        {
+          winput = malloc (capacity * sizeof (WCHAR));
+          if (winput == NULL)
+            return false;
+
+          status = ReadConsoleW (in, winput, capacity, &len, NULL);
+          WideCharToMultiByte (CP_UTF8, 0, winput, len, input, capacity, NULL, NULL);
+          free (winput);
+        }
+      else
+        status = ReadFile (in, input, capacity, &len, NULL);
+
+      string_null_terminate (input, (int)len, capacity);
+      chomp (input);
+
+      if (!echo)
+	WriteFile (err, "\r\n", 2, &len, NULL);
+      if (is_console)
+	SetConsoleMode (in, flags_save);
+      if (status && !win32_service_interrupt (&win32_signal))
+	return true;
+    }
+
+  return false;
+}
+
+#endif
+
+#ifdef HAVE_GETPASS
+
+static FILE *
+open_tty (const bool write)
+{
+  FILE *ret;
+  ret = fopen ("/dev/tty", write ? "w" : "r");
+  if (!ret)
+    ret = write ? stderr : stdin;
+  return ret;
+}
+
+static void
+close_tty (FILE *fp)
+{
+  if (fp != stderr && fp != stdin)
+    fclose (fp);
+}
+
+#endif
+
+#ifdef ENABLE_SYSTEMD
+
+/*
+ * is systemd running
+ */
+
+static bool
+check_systemd_running ()
+{
+  struct stat a, b;
+
+  /* We simply test whether the systemd cgroup hierarchy is
+   * mounted */
+
+  return (lstat("/sys/fs/cgroup", &a) == 0)
+	  && (lstat("/sys/fs/cgroup/systemd", &b) == 0)
+	  && (a.st_dev != b.st_dev);
+
+}
+
+static bool
+get_console_input_systemd (const char *prompt, const bool echo, char *input, const int capacity)
+{
+  int std_out;
+  bool ret = false;
+  struct argv argv;
+
+  argv_init (&argv);
+  argv_printf (&argv, "/bin/systemd-ask-password");
+  argv_printf_cat (&argv, "%s", prompt);
+
+  if ((std_out = openvpn_popen (&argv, NULL)) < 0) {
+	  return false;
+  }
+  CLEAR (*input);
+  if (read (std_out, input, capacity) != 0)
+    {
+       chomp (input);
+       ret = true;
+    }
+  close (std_out);
+
+  argv_reset (&argv);
+
+  return ret;
+}
+
+
+#endif
+
+/*
+ * Get input from console
+ */
+bool
+get_console_input (const char *prompt, const bool echo, char *input, const int capacity)
+{
+  bool ret = false;
+  ASSERT (prompt);
+  ASSERT (input);
+  ASSERT (capacity > 0);
+  input[0] = '\0';
+
+#ifdef ENABLE_SYSTEMD
+  if (check_systemd_running ())
+    return get_console_input_systemd (prompt, echo, input, capacity);
+#endif
+
+#if defined(WIN32)
+  return get_console_input_win32 (prompt, echo, input, capacity);
+#elif defined(HAVE_GETPASS)
+  if (echo)
+    {
+      FILE *fp;
+
+      fp = open_tty (true);
+      fprintf (fp, "%s", prompt);
+      fflush (fp);
+      close_tty (fp);
+
+      fp = open_tty (false);
+      if (fgets (input, capacity, fp) != NULL)
+	{
+	  chomp (input);
+	  ret = true;
+	}
+      close_tty (fp);
+    }
+  else
+    {
+      char *gp = getpass (prompt);
+      if (gp)
+	{
+	  strncpynt (input, gp, capacity);
+	  memset (gp, 0, strlen (gp));
+	  ret = true;
+	}
+    }
+#else
+  msg (M_FATAL, "Sorry, but I can't get console input on this OS");
+#endif
+  return ret;
+}
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
new file mode 100644
index 0000000..268f3fe
--- /dev/null
+++ b/src/openvpn/console.h
@@ -0,0 +1,33 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
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
+#ifndef CONSOLE_H
+#define CONSOLE_H
+
+#include "basic.h"
+
+bool
+get_console_input (const char *prompt, const bool echo, char *input, const int capacity);
+
+#endif
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 07beaf0..2571194 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -41,6 +41,7 @@
 #include "manage.h"
 #include "crypto.h"
 #include "route.h"
+#include "console.h"
 #include "win32.h"
 
 #include "memdbg.h"
@@ -1373,130 +1374,6 @@ absolute_pathname (const char *pathname)
     return false;
 }
 
-#ifdef HAVE_GETPASS
-
-static FILE *
-open_tty (const bool write)
-{
-  FILE *ret;
-  ret = fopen ("/dev/tty", write ? "w" : "r");
-  if (!ret)
-    ret = write ? stderr : stdin;
-  return ret;
-}
-
-static void
-close_tty (FILE *fp)
-{
-  if (fp != stderr && fp != stdin)
-    fclose (fp);
-}
-
-#endif
-
-/*
- * is systemd running
- */
-
-#if defined(TARGET_LINUX) && defined(ENABLE_SYSTEMD)
-bool
-check_systemd_running ()
-{
-  struct stat a, b;
-
-  /* We simply test whether the systemd cgroup hierarchy is
-   * mounted */
-
-  return (lstat("/sys/fs/cgroup", &a) == 0)
-	  && (lstat("/sys/fs/cgroup/systemd", &b) == 0)
-	  && (a.st_dev != b.st_dev);
-
-}
-
-bool
-get_console_input_systemd (const char *prompt, const bool echo, char *input, const int capacity)
-{
-  int std_out;
-  char cmd[256];
-  bool ret = false;
-  struct argv argv;
-
-  argv_init (&argv);
-  argv_printf (&argv, "/bin/systemd-ask-password");
-  argv_printf_cat (&argv, "%s", prompt);
-
-  if ((std_out = openvpn_popen (&argv, NULL)) < 0) {
-	  return false;
-  }
-  CLEAR (*input);
-  if (read (std_out, input, capacity) != 0)
-    {
-       chomp (input);
-       ret = true;
-    }
-  close (std_out);
-
-  argv_reset (&argv);
-
-  return ret;
-}
-
-
-#endif
-
-/*
- * Get input from console
- */
-bool
-get_console_input (const char *prompt, const bool echo, char *input, const int capacity)
-{
-  bool ret = false;
-  ASSERT (prompt);
-  ASSERT (input);
-  ASSERT (capacity > 0);
-  input[0] = '\0';
-
-#if defined(TARGET_LINUX) && defined(ENABLE_SYSTEMD)
-  if (check_systemd_running ())
-    return get_console_input_systemd (prompt, echo, input, capacity);
-#endif
-
-#if defined(WIN32)
-  return get_console_input_win32 (prompt, echo, input, capacity);
-#elif defined(HAVE_GETPASS)
-  if (echo)
-    {
-      FILE *fp;
-
-      fp = open_tty (true);
-      fprintf (fp, "%s", prompt);
-      fflush (fp);
-      close_tty (fp);
-
-      fp = open_tty (false);
-      if (fgets (input, capacity, fp) != NULL)
-	{
-	  chomp (input);
-	  ret = true;
-	}
-      close_tty (fp);
-    }
-  else
-    {
-      char *gp = getpass (prompt);
-      if (gp)
-	{
-	  strncpynt (input, gp, capacity);
-	  memset (gp, 0, strlen (gp));
-	  ret = true;
-	}
-    }
-#else
-  msg (M_FATAL, "Sorry, but I can't get console input on this OS");
-#endif
-  return ret;
-}
-
 /*
  * Get and store a username/password
  */
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 9bb2fa2..12a8f71 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -128,6 +128,7 @@ bool system_executed (int stat);
 const char *system_error_message (int, struct gc_arena *gc);
 
 /* wrapper around the execve() call */
+int openvpn_popen (const struct argv *a,  const struct env_set *es);
 int openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned int flags);
 bool openvpn_execve_check (const struct argv *a, const struct env_set *es, const unsigned int flags, const char *error_message);
 bool openvpn_execve_allowed (const unsigned int flags);
@@ -322,8 +323,6 @@ struct auth_challenge_info {};
 struct static_challenge_info {};
 #endif
 
-bool get_console_input (const char *prompt, const bool echo, char *input, const int capacity);
-
 /*
  * Flags for get_user_pass and management_query_user_pass
  */
diff --git a/src/openvpn/openvpn.vcproj b/src/openvpn/openvpn.vcproj
index 45c0a77..6c19621 100644
--- a/src/openvpn/openvpn.vcproj
+++ b/src/openvpn/openvpn.vcproj
@@ -191,6 +191,10 @@
 				>
 			</File>
 			<File
+				RelativePath=".\console.c"
+				>
+			</File>
+			<File
 				RelativePath=".\crypto.c"
 				>
 			</File>
@@ -457,6 +461,10 @@
 				>
 			</File>
 			<File
+				RelativePath=".\console.h"
+				>
+			</File>
+			<File
 				RelativePath=".\crypto.h"
 				>
 			</File>
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 2189208..fd609d4 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -40,6 +40,7 @@
 #include "pkcs11.h"
 #include "misc.h"
 #include "otime.h"
+#include "console.h"
 #include "pkcs11_backend.h"
 
 static
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index d7bf514..e94343b 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -514,7 +514,7 @@ win32_signal_close (struct win32_signal *ws)
 /*
  * Return true if interrupt occurs in service mode.
  */
-static bool
+bool
 win32_service_interrupt (struct win32_signal *ws)
 {
   if (ws->mode == WSO_MODE_SERVICE)
@@ -740,91 +740,6 @@ netcmd_semaphore_release (void)
 }
 
 /*
- * Get input from console.
- *
- * Return false on input error, or if service
- * exit event is signaled.
- */
-
-bool
-get_console_input_win32 (const char *prompt, const bool echo, char *input, const int capacity)
-{
-  HANDLE in = INVALID_HANDLE_VALUE;
-  HANDLE err = INVALID_HANDLE_VALUE;
-  DWORD len = 0;
-
-  ASSERT (prompt);
-  ASSERT (input);
-  ASSERT (capacity > 0);
-
-  input[0] = '\0';
-
-  in = GetStdHandle (STD_INPUT_HANDLE);
-  err = get_orig_stderr ();
-
-  if (in != INVALID_HANDLE_VALUE
-      && err != INVALID_HANDLE_VALUE
-      && !win32_service_interrupt (&win32_signal)
-      && WriteFile (err, prompt, strlen (prompt), &len, NULL))
-    {
-      bool is_console = (GetFileType (in) == FILE_TYPE_CHAR);
-      DWORD flags_save = 0;
-      int status = 0;
-      WCHAR *winput;
-
-      if (is_console)
-	{
-	  if (GetConsoleMode (in, &flags_save))
-	    {
-	      DWORD flags = ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT;
-	      if (echo)
-		flags |= ENABLE_ECHO_INPUT;
-	      SetConsoleMode (in, flags);
-	    }
-	  else
-	    is_console = 0;
-	}
-
-      if (is_console)
-        {
-          winput = malloc (capacity * sizeof (WCHAR));
-          if (winput == NULL)
-            return false;
-
-          status = ReadConsoleW (in, winput, capacity, &len, NULL);
-          WideCharToMultiByte (CP_UTF8, 0, winput, len, input, capacity, NULL, NULL);
-          free (winput);
-        }
-      else
-        status = ReadFile (in, input, capacity, &len, NULL);
-
-      string_null_terminate (input, (int)len, capacity);
-      chomp (input);
-
-      if (!echo)
-	WriteFile (err, "\r\n", 2, &len, NULL);
-      if (is_console)
-	SetConsoleMode (in, flags_save);
-      if (status && !win32_service_interrupt (&win32_signal))
-	return true;
-    }
-
-  return false;
-}
-
-/* get password from console */
-
-char *
-getpass (const char *prompt)
-{
-  static char line[256];
-  if (get_console_input_win32 (prompt, false, line, sizeof (line)))
-    return line;
-  else
-    return NULL;
-}
-
-/*
  * Return true if filename is safe to be used on Windows,
  * by avoiding the following reserved names:
  *
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index d87e987..cc18f02 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -166,6 +166,8 @@ int win32_signal_get (struct win32_signal *ws);
 
 void win32_pause (struct win32_signal *ws);
 
+bool win32_service_interrupt (struct win32_signal *ws);
+
 /*
  * Set the text on the window title bar
  */
@@ -246,9 +248,6 @@ void netcmd_semaphore_close (void);
 void netcmd_semaphore_lock (void);
 void netcmd_semaphore_release (void);
 
-bool get_console_input_win32 (const char *prompt, const bool echo, char *input, const int capacity);
-char *getpass (const char *prompt);
-
 /* Set Win32 security attributes structure to allow all access */
 bool init_security_attributes_allow_all (struct security_attributes *obj);
 
-- 
1.7.3.4


