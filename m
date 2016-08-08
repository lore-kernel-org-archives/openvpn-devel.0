From: David Sommerseth <davids@...515...>
Date: Mon,  8 Aug 2016 21:28:05 +0200
Message-Id: <1470684488-21307-2-git-send-email-davids@...515...>
In-Reply-To: <1470684488-21307-1-git-send-email-davids@...515...>
References: <1470684488-21307-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH v4 1/4] Rework the user input interface to
	make it more modular
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

This is will provide an interface for other mechanisms to be used to
query the user for information, such as usernames, passwords, etc.

It has also been a goal to make it possible to query for all the
information in one call and not do it sequencially as before.

 [v4 - add a simple wrapper combining query_user_{init,add,exec}()
     - change disapproved &= syntax ]

 [v3 - Avoid the dynamic list, use a static list of QUERY_USER_NUMSLOTS
     - The list of query_user data is now a global variable
     - Replaced query_user_init() with query_user_clear()
     - Make query_user_add() a void function
     - Rebased against master/600dd9a16fc61 ]

 [v2 - Removed the QUERY_USER_FOREACH macro
     - Avoided using underscore prefix in function names
     - Make query_user_init() do M_FATAL and become a void function
       instead of returning false in these unlikely situations ]

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/Makefile.am       |   2 +-
 src/openvpn/console.c         | 228 +++++-------------------------------
 src/openvpn/console.h         |  89 +++++++++++++-
 src/openvpn/console_builtin.c | 261 ++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/misc.c            |  58 +++++++---
 src/openvpn/pkcs11.c          |   7 +-
 6 files changed, 420 insertions(+), 225 deletions(-)
 create mode 100644 src/openvpn/console_builtin.c

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 9d4bf61..8d6d39f 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -68,7 +68,7 @@ openvpn_SOURCES = \
 	memdbg.h \
 	misc.c misc.h \
 	platform.c platform.h \
-	console.c console.h \
+	console.c console.h console_builtin.c \
 	mroute.c mroute.h \
 	mss.c mss.h \
 	mstats.c mstats.h \
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 86331a1..c3bb7c3 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -6,6 +6,8 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
+ *  Copyright (C) 2016      David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -38,219 +40,43 @@
 #include <systemd/sd-daemon.h>
 #endif
 
-#ifdef WIN32
 
-#include "win32.h"
+struct _query_user query_user[QUERY_USER_NUMSLOTS];  /* GLOBAL */
 
-/*
- * Get input from console.
- *
- * Return false on input error, or if service
- * exit event is signaled.
- */
-
-static bool
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
-#endif
-
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
 
-#ifdef ENABLE_SYSTEMD
-
-/*
- * is systemd running
- */
-
-static bool
-check_systemd_running ()
+void query_user_clear()
 {
-  struct stat c;
-
-  /* We simply test whether the systemd cgroup hierarchy is
-   * mounted, as well as the systemd-ask-password executable
-   * being available */
+    int i;
 
-  return (sd_booted() > 0)
-	  && (stat(SYSTEMD_ASK_PASSWORD_PATH, &c) == 0);
-
-}
-
-static bool
-get_console_input_systemd (const char *prompt, const bool echo, char *input, const int capacity)
-{
-  int std_out;
-  bool ret = false;
-  struct argv argv;
-
-  argv_init (&argv);
-  argv_printf (&argv, SYSTEMD_ASK_PASSWORD_PATH);
-  argv_printf_cat (&argv, "%s", prompt);
-
-  if ((std_out = openvpn_popen (&argv, NULL)) < 0) {
-	  return false;
-  }
-
-  memset (input, 0, capacity);
-  if (read (std_out, input, capacity-1) > 0)
-    {
-       chomp (input);
-       ret = true;
+    for( i = 0; i < QUERY_USER_NUMSLOTS; i++ ) {
+	CLEAR(query_user[i]);
     }
-  close (std_out);
-
-  argv_reset (&argv);
-
-  return ret;
 }
 
 
-#endif
-
-/*
- * Get input from console
- */
-bool
-get_console_input (const char *prompt, const bool echo, char *input, const int capacity)
+void query_user_add(char *prompt, size_t prompt_len,
+                    char *resp, size_t resp_len,
+                    bool echo)
 {
-  bool ret = false;
-  ASSERT (prompt);
-  ASSERT (input);
-  ASSERT (capacity > 0);
-  input[0] = '\0';
-
-#ifdef ENABLE_SYSTEMD
-  if (check_systemd_running ())
-    return get_console_input_systemd (prompt, echo, input, capacity);
-#endif
+    int i;
 
-#if defined(WIN32)
-  return get_console_input_win32 (prompt, echo, input, capacity);
-#elif defined(HAVE_GETPASS)
+    /* Ensure input is sane.  All these must be present otherwise it is
+     * a programming error.
+     */
+    ASSERT( prompt_len > 0 && prompt != NULL && resp_len > 0 && resp != NULL );
 
-  /* did we --daemon'ize before asking for passwords?
-   * (in which case neither stdin or stderr are connected to a tty and
-   * /dev/tty can not be open()ed anymore)
-   */
-  if ( !isatty(0) && !isatty(2) )
-    {
-      int fd = open( "/dev/tty", O_RDWR );
-      if ( fd < 0 )
-	{ msg(M_FATAL, "neither stdin nor stderr are a tty device and you have neither a controlling tty nor systemd - can't ask for '%s'.  If you used --daemon, you need to use --askpass to make passphrase-protected keys work, and you can not use --auth-nocache.", prompt ); }
-      close(fd);
-    }
-
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
+    /* Seek to the last unused slot */
+    for (i = 0; i < QUERY_USER_NUMSLOTS; i++) {
+	if( query_user[i].prompt == NULL ) {
+	    break;
 	}
-      close_tty (fp);
     }
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
-  msg (M_FATAL, "Sorry, but I can't get console input on this OS (%s)", prompt);
-#endif
-  return ret;
+    ASSERT( i < QUERY_USER_NUMSLOTS );  /* Unlikely, but we want to panic if it happens */
+
+    /* Save the information needed for the user interaction */
+    query_user[i].prompt = prompt;
+    query_user[i].prompt_len = prompt_len;
+    query_user[i].response = resp;
+    query_user[i].response_len = resp_len;
+    query_user[i].echo = echo;
 }
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 268f3fe..44d49ef 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -6,6 +6,8 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
+ *  Copyright (C) 2016      David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -27,7 +29,90 @@
 
 #include "basic.h"
 
-bool
-get_console_input (const char *prompt, const bool echo, char *input, const int capacity);
+/**
+ *  Configuration setup for declaring what kind of information to ask a user for
+ */
+struct _query_user {
+    char *prompt;             /**< Prompt to present to the user */
+    size_t prompt_len;        /**< Lenght of the prompt string */
+    char *response;           /**< The user's response */
+    size_t response_len;      /**< Lenght the of the user reposone */
+    bool echo;                /**< True: The user should see what is being typed, otherwise mask it */
+};
+
+#define QUERY_USER_NUMSLOTS 10
+extern struct _query_user query_user[];  /**< Global variable, declared in console.c */
+
+/**
+ * Wipes all data put into all of the query_user structs
+ *
+ */
+void query_user_clear ();
+
+
+/**
+ * Adds an item to ask the user for
+ *
+ * @param prompt     Prompt to display to the user
+ * @param prompt_len Length of the prompt string
+ * @param resp       String containing the user response
+ * @param resp_len   Lenght of the response string
+ * @param echo       Should the user input be echoed to the user?  If False, input will be masked
+ *
+ */
+void query_user_add (char *prompt, size_t prompt_len,
+                     char *resp, size_t resp_len,
+                     bool echo);
+
+
+/**
+ * Executes a configured setup, using the built-in method for querying the user.
+ * This method uses the console/TTY directly.
+ *
+ * @param setup    Pointer to the setup defining what to ask the user
+ *
+ * @return True if executing all the defined steps completed successfully
+ */
+bool query_user_exec_builtin ();
+
+
+#ifdef QUERY_USER_EXEC_ALTERNATIVE
+/**
+ * Executes a configured setup, using the compiled method for querying the user
+ *
+ * @param setup    Pointer to the setup defining what to ask the user
+ *
+ * @return True if executing all the defined steps completed successfully
+ */
+bool query_user_exec ();
+
+#else  /* QUERY_USER_EXEC_ALTERNATIVE not defined*/
+/**
+ * Wrapper function enabling query_user_exec() if no alternative methods have
+ * been enabled
+ *
+ */
+static bool query_user_exec ()
+{
+    return query_user_exec_builtin();
+}
+#endif  /* QUERY_USER_EXEC_ALTERNATIVE */
+
+
+/**
+ * A plain "make Gert happy" wrapper.  Same arguments as @query_user_add
+ *
+ * FIXME/TODO: Remove this when refactoring the complete user query process
+ *             to be called at start-up initialization of OpenVPN.
+ *
+ */
+static bool query_user_SINGLE (char *prompt, size_t prompt_len,
+                     char *resp, size_t resp_len,
+                     bool echo)
+{
+    query_user_clear();
+    query_user_add(prompt, prompt_len, resp, resp_len, echo);
+    return query_user_exec();
+}
 
 #endif
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
new file mode 100644
index 0000000..0434f60
--- /dev/null
+++ b/src/openvpn/console_builtin.c
@@ -0,0 +1,261 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2016  OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2014-2015  David Sommerseth <davids@...1347...>
+ *  Copyright (C) 2016       David Sommerseth <davids@...515...>
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
+/*
+ *  These functions covers handing user input/output using the default consoles
+ *
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
+/**
+ * Get input from a Windows console.
+ *
+ * @param prompt    Prompt to display to the user
+ * @param echo      Should the user input be displayed in the console
+ * @param input     Pointer to the buffer the user input will be saved
+ * @param capacity  Size of the buffer for the user input
+ *
+ * @return Return false on input error, or if service
+ *         exit event is signaled.
+ */
+static bool get_console_input_win32 (const char *prompt, const bool echo, char *input, const int capacity)
+{
+    HANDLE in = INVALID_HANDLE_VALUE;
+    HANDLE err = INVALID_HANDLE_VALUE;
+    DWORD len = 0;
+
+    ASSERT (prompt);
+    ASSERT (input);
+    ASSERT (capacity > 0);
+
+    input[0] = '\0';
+
+    in = GetStdHandle (STD_INPUT_HANDLE);
+    err = get_orig_stderr ();
+
+    if (in != INVALID_HANDLE_VALUE
+        && err != INVALID_HANDLE_VALUE
+        && !win32_service_interrupt (&win32_signal)
+        && WriteFile (err, prompt, strlen (prompt), &len, NULL))
+    {
+        bool is_console = (GetFileType (in) == FILE_TYPE_CHAR);
+        DWORD flags_save = 0;
+        int status = 0;
+        WCHAR *winput;
+
+        if (is_console)
+	{
+            if (GetConsoleMode (in, &flags_save))
+	    {
+                DWORD flags = ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT;
+                if (echo)
+                    flags |= ENABLE_ECHO_INPUT;
+                SetConsoleMode (in, flags);
+	    } else
+                is_console = 0;
+	}
+
+        if (is_console)
+        {
+            winput = malloc (capacity * sizeof (WCHAR));
+            if (winput == NULL)
+                return false;
+
+            status = ReadConsoleW (in, winput, capacity, &len, NULL);
+            WideCharToMultiByte (CP_UTF8, 0, winput, len, input, capacity, NULL, NULL);
+            free (winput);
+        } else
+            status = ReadFile (in, input, capacity, &len, NULL);
+
+        string_null_terminate (input, (int)len, capacity);
+        chomp (input);
+
+        if (!echo)
+            WriteFile (err, "\r\n", 2, &len, NULL);
+        if (is_console)
+            SetConsoleMode (in, flags_save);
+        if (status && !win32_service_interrupt (&win32_signal))
+            return true;
+    }
+
+    return false;
+}
+
+#endif   /* WIN32 */
+
+
+#ifdef HAVE_GETPASS
+
+/**
+ * Open the current console TTY for read/write operations
+ *
+ * @params write   If true, the user wants to write to the console
+ *                 otherwise read from the console
+ *
+ * @returns Returns a FILE pointer to either the TTY in read or write mode
+ *          or stdin/stderr, depending on the write flag
+ *
+ */
+static FILE * open_tty (const bool write)
+{
+    FILE *ret;
+    ret = fopen ("/dev/tty", write ? "w" : "r");
+    if (!ret)
+        ret = write ? stderr : stdin;
+    return ret;
+}
+
+/**
+ * Closes the TTY FILE pointer, but only if it is not a stdin/stderr FILE object.
+ *
+ * @params fp     FILE pointer to close
+ *
+ */
+static void close_tty (FILE *fp)
+{
+    if (fp != stderr && fp != stdin)
+        fclose (fp);
+}
+
+#endif   /* HAVE_GETPASS */
+
+
+/**
+ *  Core function for getting input from console
+ *
+ *  @params prompt    The prompt to present to the user
+ *  @params echo      Should the user see what is being typed
+ *  @params input     Pointer to the buffer used to save the user input
+ *  @params capacity  Size of the input buffer
+ *
+ *  @returns Returns True if user input was gathered
+ */
+static bool get_console_input (const char *prompt, const bool echo, char *input, const int capacity)
+{
+    bool ret = false;
+    ASSERT (prompt);
+    ASSERT (input);
+    ASSERT (capacity > 0);
+    input[0] = '\0';
+
+#if defined(WIN32)
+    return get_console_input_win32 (prompt, echo, input, capacity);
+#elif defined(HAVE_GETPASS)
+
+    /* did we --daemon'ize before asking for passwords?
+     * (in which case neither stdin or stderr are connected to a tty and
+     * /dev/tty can not be open()ed anymore)
+     */
+    if ( !isatty(0) && !isatty(2) )
+    {
+        int fd = open( "/dev/tty", O_RDWR );
+        if ( fd < 0 )
+        {
+            msg(M_FATAL, "neither stdin nor stderr are a tty device and you have neither a "
+                "controlling tty nor systemd - can't ask for '%s'.  If you used --daemon, "
+                "you need to use --askpass to make passphrase-protected keys work, and you "
+                "can not use --auth-nocache.", prompt );
+        }
+        close(fd);
+    }
+
+    if (echo)
+    {
+        FILE *fp;
+
+        fp = open_tty (true);
+        fprintf (fp, "%s", prompt);
+        fflush (fp);
+        close_tty (fp);
+
+        fp = open_tty (false);
+        if (fgets (input, capacity, fp) != NULL)
+        {
+            chomp (input);
+            ret = true;
+        }
+        close_tty (fp);
+    } else {
+        char *gp = getpass (prompt);
+        if (gp)
+        {
+            strncpynt (input, gp, capacity);
+            memset (gp, 0, strlen (gp));
+            ret = true;
+        }
+    }
+#else
+    msg (M_FATAL, "Sorry, but I can't get console input on this OS (%s)", prompt);
+#endif
+    return ret;
+}
+
+
+/**
+ * @copydoc query_user_exec()
+ *
+ * Default method for querying user using default stdin/stdout on a console.
+ * This needs to be available as a backup interface for the alternative
+ * implementations in case they cannot query through their implementation
+ * specific methods.
+ *
+ * If no alternative implementation is declared, a wrapper in console.h will ensure
+ * query_user_exec() will call this function instead.
+ *
+ */
+bool query_user_exec_builtin()
+{
+    bool ret = true; /* Presume everything goes okay */
+    int i;
+
+    /* Loop through configured query_user slots */
+    for (i = 0; i < QUERY_USER_NUMSLOTS && query_user[i].response != NULL; i++)
+    {
+	if (!get_console_input(query_user[i].prompt, query_user[i].echo,
+			      query_user[i].response, query_user[i].response_len) )
+	{
+	    /* Force the final result state to failed on failure */
+	    ret = false;
+	}
+    }
+
+    return ret;
+}
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 0991d79..dd9a276 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -6,6 +6,8 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
+ *  Copyright (C) 2016      David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -1085,9 +1087,11 @@ get_user_pass_cr (struct user_pass *up,
 	  struct buffer user_prompt = alloc_buf_gc (128, &gc);
 
 	  buf_printf (&user_prompt, "NEED-OK|%s|%s:", prefix, up->username);
-	  
-	  if (!get_console_input (BSTR (&user_prompt), true, up->password, USER_PASS_LEN))
-	    msg (M_FATAL, "ERROR: could not read %s ok-confirmation from stdin", prefix);
+	  if (!query_user_SINGLE (BSTR(&user_prompt), BLEN(&user_prompt),
+                                  up->password, USER_PASS_LEN, false))
+            {
+              msg (M_FATAL, "ERROR: could not read %s ok-confirmation from stdin", prefix);
+            }
 	  
 	  if (!strlen (up->password))
 	    strcpy (up->password, "ok");
@@ -1163,13 +1167,17 @@ get_user_pass_cr (struct user_pass *up,
 	      if (ac)
 		{
 		  char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
-		  struct buffer packed_resp;
+		  struct buffer packed_resp, challenge;
 
+		  challenge = alloc_buf_gc (14+strlen(ac->challenge_text), &gc);
+		  buf_printf (&challenge, "CHALLENGE: %s", ac->challenge_text);
 		  buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
-		  msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", ac->challenge_text);
-                  if (!get_console_input (ac->challenge_text, BOOL_CAST(ac->flags&CR_ECHO),
-                                          response, USER_PASS_LEN))
-		    msg (M_FATAL, "ERROR: could not read challenge response from stdin");
+
+		  if (!query_user_SINGLE (BSTR(&challenge), BLEN(&challenge),
+                                          response, USER_PASS_LEN, BOOL_CAST(ac->flags&CR_ECHO)))
+		    {
+		      msg (M_FATAL, "ERROR: could not read challenge response from stdin");
+		    }
 		  strncpynt (up->username, ac->user, USER_PASS_LEN);
 		  buf_printf (&packed_resp, "CRV1::%s::%s", ac->state_id, response);
 		}
@@ -1184,32 +1192,46 @@ get_user_pass_cr (struct user_pass *up,
 	      struct buffer user_prompt = alloc_buf_gc (128, &gc);
 	      struct buffer pass_prompt = alloc_buf_gc (128, &gc);
 
+	      query_user_clear ();
 	      buf_printf (&user_prompt, "Enter %s Username:", prefix);
 	      buf_printf (&pass_prompt, "Enter %s Password:", prefix);
 
 	      if (username_from_stdin && !(flags & GET_USER_PASS_PASSWORD_ONLY))
 		{
-		  if (!get_console_input (BSTR (&user_prompt), true, up->username, USER_PASS_LEN))
-		    msg (M_FATAL, "ERROR: could not read %s username from stdin", prefix);
+		  query_user_add (BSTR(&user_prompt), BLEN(&user_prompt),
+                                  up->username, USER_PASS_LEN, true);
+		}
+
+	      query_user_add (BSTR(&pass_prompt), BLEN(&pass_prompt),
+                              up->password, USER_PASS_LEN, false);
+
+	      if( !query_user_exec () )
+		{
+		  msg( M_FATAL, "ERROR: Failed retrieving username or password");
+		}
+
+	      if (!(flags & GET_USER_PASS_PASSWORD_ONLY))
+		{
 		  if (strlen (up->username) == 0)
 		    msg (M_FATAL, "ERROR: %s username is empty", prefix);
 		}
 
-	      if (password_from_stdin && !get_console_input (BSTR (&pass_prompt), false, up->password, USER_PASS_LEN))
-		msg (M_FATAL, "ERROR: could not not read %s password from stdin", prefix);
-
 #ifdef ENABLE_CLIENT_CR
               if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE) && response_from_stdin)
 		{
 		  char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
-		  struct buffer packed_resp;
+		  struct buffer packed_resp, challenge;
 		  char *pw64=NULL, *resp64=NULL;
 
-		  msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", auth_challenge);
+		  challenge = alloc_buf_gc (14+strlen(auth_challenge), &gc);
+		  buf_printf (&challenge, "CHALLENGE: %s", auth_challenge);
 
-                  if (!get_console_input (auth_challenge, BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO),
-                                          response, USER_PASS_LEN))
-		    msg (M_FATAL, "ERROR: could not read static challenge response from stdin");
+		  if (!query_user_SINGLE (BSTR(&challenge), BLEN(&challenge),
+                                          response, USER_PASS_LEN,
+                                          BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO)))
+		    {
+		      msg (M_FATAL, "ERROR: could not retrieve static challenge response");
+		    }
 		  if (openvpn_base64_encode(up->password, strlen(up->password), &pw64) == -1
 		      || openvpn_base64_encode(response, strlen(response), &resp64) == -1)
 		    msg (M_FATAL, "ERROR: could not base64-encode password/static_response");
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index a1f13c5..2621058 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -744,9 +744,10 @@ _pkcs11_openvpn_show_pkcs11_ids_pin_prompt (
 	ASSERT (token!=NULL);
 
 	buf_printf (&pass_prompt, "Please enter '%s' token PIN or 'cancel': ", token->display);
-
-	if (!get_console_input (BSTR (&pass_prompt), false, pin, pin_max)) {
-		msg (M_FATAL, "Cannot read password from stdin");
+	if (!query_user_SINGLE(BSTR(&pass_prompt), BLEN(&pass_prompt),
+		       pin, pin_max, false))
+	{
+	    msg (M_FATAL, "Could not retrieve the PIN");
 	}
 
 	gc_free (&gc);
-- 
1.8.3.1


