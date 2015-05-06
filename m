From: David Sommerseth <openvpn.list@...1114...>
Date: Wed,  6 May 2015 22:06:18 +0200
Message-Id: <1430942781-31363-2-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1430942781-31363-1-git-send-email-openvpn.list@...1114...>
References: <1430942781-31363-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCHv2 1/4] Rework the user input interface to
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

From: David Sommerseth <davids@...1347...>

This is will provide an interface for other mechanisms to be used to
query the user for information, such as usernames, passwords, etc.

It has also been a goal to make it possible to query for all the
information in one call and not do it sequencially as before.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/Makefile.am       |   2 +-
 src/openvpn/console.c         | 225 ++++++--------------------------------
 src/openvpn/console.h         |  94 +++++++++++++++-
 src/openvpn/console_builtin.c | 246 ++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/misc.c            |  81 +++++++++++---
 src/openvpn/pkcs11.c          |  16 ++-
 6 files changed, 450 insertions(+), 214 deletions(-)
 create mode 100644 src/openvpn/console_builtin.c

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index d089f50..e07389f 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -69,7 +69,7 @@ openvpn_SOURCES = \
 	memdbg.h \
 	misc.c misc.h \
 	platform.c platform.h \
-	console.c console.h \
+	console.c console.h console_builtin.c \
 	mroute.c mroute.h \
 	mss.c mss.h \
 	mstats.c mstats.h \
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index d66d408..c7fbe4f 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -5,7 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2015 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -30,213 +31,53 @@
 
 #include "syshead.h"
 #include "console.h"
-#include "error.h"
 #include "buffer.h"
-#include "misc.h"
 
-#ifdef ENABLE_SYSTEMD
-#include <systemd/sd-daemon.h>
-#endif
-
-#ifdef WIN32
-
-#include "win32.h"
-
-/*
- * Get input from console.
- *
- * Return false on input error, or if service
- * exit event is signaled.
- */
 
-static bool
-get_console_input_win32 (const char *prompt, const bool echo, char *input, const int capacity)
+bool query_user_init(struct gc_arena *gc, struct query_user ** setup)
 {
-  HANDLE in = INVALID_HANDLE_VALUE;
-  HANDLE err = INVALID_HANDLE_VALUE;
-  DWORD len = 0;
+    ASSERT (&gc != NULL);
 
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
+    *setup = (struct query_user *) gc_malloc (sizeof(**setup)+2, true, gc);
+    if( *setup == NULL )
     {
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
+        return false;
     }
-
-  return false;
+    (*setup)->_gc = gc;
+    (*setup)->next = NULL;  /* Pure fail safety */
+    return true;
 }
 
-#endif
-
-#ifdef HAVE_GETPASS
 
-static FILE *
-open_tty (const bool write)
+bool query_user_add(struct query_user * setup,
+                    char *prompt, size_t prompt_len,
+                    char *resp, size_t resp_len,
+                    bool query, bool echo)
 {
-  FILE *ret;
-  ret = fopen ("/dev/tty", write ? "w" : "r");
-  if (!ret)
-    ret = write ? stderr : stdin;
-  return ret;
-}
+    struct query_user *p = NULL;
 
-static void
-close_tty (FILE *fp)
-{
-  if (fp != stderr && fp != stdin)
-    fclose (fp);
-}
-
-#endif
-
-#ifdef ENABLE_SYSTEMD
-
-/*
- * is systemd running
- */
+    ASSERT (setup != NULL);
 
-static bool
-check_systemd_running ()
-{
-  struct stat c;
-
-  /* We simply test whether the systemd cgroup hierarchy is
-   * mounted, as well as the systemd-ask-password executable
-   * being available */
-
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
-  CLEAR (*input);
-  if (read (std_out, input, capacity) != 0)
+    /* Ensure prompt_len is set and we have info about the response buffer
+     * if asked to query the user for user input
+     */
+    if( prompt_len == 0 || (query == true && (resp_len == 0 || resp == NULL)) )
     {
-       chomp (input);
-       ret = true;
+        return false;
     }
-  close (std_out);
-
-  argv_reset (&argv);
-
-  return ret;
-}
-
 
-#endif
+    /* Seek to the end of the pointer chain */
+    QUERY_USER_FOREACH(setup, p);
 
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
+    /* Save the information needed for the user interaction */
+    p->_gc = setup->_gc;
+    p->prompt = prompt;
+    p->prompt_len = prompt_len;
+    p->response = resp;
+    p->response_len = resp_len;
+    p->query = query;
+    p->echo = echo;
+    query_user_init(p->_gc, &p->next);
 
-#ifdef ENABLE_SYSTEMD
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
-  msg (M_FATAL, "Sorry, but I can't get console input on this OS (%s)", prompt);
-#endif
-  return ret;
+    return (p->next != NULL) ? true : false;
 }
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 268f3fe..6025b44 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -5,7 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2015 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -26,8 +27,95 @@
 #define CONSOLE_H
 
 #include "basic.h"
+#include "buffer.h"
 
-bool
-get_console_input (const char *prompt, const bool echo, char *input, const int capacity);
+/**
+ *  Configuration setup for declaring what kind of information to ask a user for
+ */
+struct query_user {
+    struct gc_arena *_gc;     /**< Local pointer to the gc_arena maintaining this chained list */
+    char *prompt;             /**< Prompt to present to the user */
+    size_t prompt_len;        /**< Lenght of the prompt string */
+    char *response;           /**< The user's response */
+    size_t response_len;      /**< Lenght the of the user reposone */
+    bool query;               /**< True: Expect user to provide a response, False: only print  */
+    bool echo;                /**< True: The user should see what is being typed, otherwise mask it */
+    struct query_user *next;  /**<  Next information to query for, NULL indicates end of list */
+};
+
+
+/**
+ * Initializes the framework for querying for user input
+ *
+ * @param gc     Reference to an gc_arena object, taking care of memory management
+ * @param setup  Returns the initialized object for user input information
+ *
+ * @return True if initialization was successfull, otherwise False.
+ */
+bool query_user_init (struct gc_arena *gc, struct query_user ** setup);
+
+
+/**
+ * Adds an item to ask the user for
+ *
+ * @param setup      Pointer to the setup defining what to ask the user
+ * @param prompt     Prompt to display to the user
+ * @param prompt_len Length of the prompt string
+ * @param resp       String containing the user response
+ * @param resp_len   Lenght of the response string
+ * @param query      Is a user response expected?  If False, only present information to user
+ * @param echo       Should the user input be echoed to the user?  If False, input will be masked
+ *
+ * @return True if adding this information to the setup was successful, otherwise False
+ *
+ */
+bool query_user_add (struct query_user * setup,
+                     char *prompt, size_t prompt_len,
+                     char *resp, size_t resp_len,
+                     bool query, bool echo);
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
+bool query_user_exec_builtin (struct query_user * setup);
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
+bool query_user_exec (struct query_user * setup);
+
+#else  /* QUERY_USER_EXEC_ALTERNATIVE not defined*/
+/**
+ * Wrapper function enabling query_user_exec() if no alternative methods have
+ * been enabled
+ *
+ */
+static bool query_user_exec (struct query_user * setup)
+{
+    return query_user_exec_builtin(setup);
+}
+#endif  /* QUERY_USER_EXEC_DECLARED */
+
+
+/**
+ * Simple for-loop helper for traversing the query setup
+ *
+ * @param setup_start   Starting point to start the traversing
+ * @param element       Current element to be processed
+ *
+ */
+#define QUERY_USER_FOREACH(setup_start, element)   for (element=setup_start; element->next != NULL; element=element->next)
 
 #endif
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
new file mode 100644
index 0000000..d55dfa4
--- /dev/null
+++ b/src/openvpn/console_builtin.c
@@ -0,0 +1,246 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2015  OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2014-2015  David Sommerseth <davids@...1347...>
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
+static bool _get_console_input_win32 (const char *prompt, const bool echo, char *input, const int capacity)
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
+static bool _get_console_input (const char *prompt, const bool echo, char *input, const int capacity)
+{
+    bool ret = false;
+    ASSERT (prompt);
+    ASSERT (input);
+    ASSERT (capacity > 0);
+    input[0] = '\0';
+
+#if defined(WIN32)
+    return _get_console_input_win32 (prompt, echo, input, capacity);
+#elif defined(HAVE_GETPASS)
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
+bool query_user_exec_builtin(struct query_user * setup)
+{
+    struct query_user *p;
+    bool ret = true;
+
+    ASSERT( setup != NULL );
+
+    /* Loop through the complete query setup and when needed, collect the information */
+    QUERY_USER_FOREACH(setup, p)
+    {
+        if( p->query )
+        {
+            /* If the user is expected to provide some data */
+            ret &= _get_console_input(p->prompt, p->echo, p->response, p->response_len);
+        } else {
+            /* If the prompt should only be presented to the user with no further action */
+            msg(M_INFO|M_NOPREFIX, "%s", p->prompt);
+        }
+    }
+
+    return ret;
+}
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 5627cb9..215c3c7 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -5,7 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2015 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -1049,11 +1050,20 @@ get_user_pass_cr (struct user_pass *up,
        */
       if (flags & GET_USER_PASS_NEED_OK)
 	{
+	  struct query_user *qucfg = NULL;
 	  struct buffer user_prompt = alloc_buf_gc (128, &gc);
 
+          if( !query_user_init (&gc, &qucfg) )
+            {
+              msg (M_FATAL,
+                   "ERROR: Could not prepare for retrieving user input for %s ok-confirmation",
+                   prefix);
+            }
 	  buf_printf (&user_prompt, "NEED-OK|%s|%s:", prefix, up->username);
+	  query_user_add (qucfg, BSTR(&user_prompt), BLEN(&user_prompt), up->password, USER_PASS_LEN,
+                          true, true);
 	  
-	  if (!get_console_input (BSTR (&user_prompt), true, up->password, USER_PASS_LEN))
+	  if (!query_user_exec (qucfg))
 	    msg (M_FATAL, "ERROR: could not read %s ok-confirmation from stdin", prefix);
 	  
 	  if (!strlen (up->password))
@@ -1071,13 +1081,26 @@ get_user_pass_cr (struct user_pass *up,
 	      struct auth_challenge_info *ac = get_auth_challenge (auth_challenge, &gc);
 	      if (ac)
 		{
+		  struct query_user *qucfg = NULL;
 		  char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
-		  struct buffer packed_resp;
+		  struct buffer packed_resp, challenge;
 
+		  if( !query_user_init (&gc, &qucfg) )
+		    {
+		      msg (M_FATAL, "ERROR: Could not prepare for challenge/response dialogue");
+		    }
+
+		  challenge = alloc_buf_gc (14+strlen(ac->challenge_text), &gc);
+		  buf_printf (&challenge, "CHALLENGE: %s", ac->challenge_text);
 		  buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
-		  msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", ac->challenge_text);
-		  if (!get_console_input ("Response:", BOOL_CAST(ac->flags&CR_ECHO), response, USER_PASS_LEN))
-		    msg (M_FATAL, "ERROR: could not read challenge response from stdin");
+
+		  query_user_add (qucfg, BSTR(&challenge), BLEN(&challenge), response, USER_PASS_LEN,
+                                  true, BOOL_CAST(ac->flags&CR_ECHO));
+
+		  if (!query_user_exec (qucfg))
+		    {
+		      msg (M_FATAL, "ERROR: could not read challenge response from stdin");
+		    }
 		  strncpynt (up->username, ac->user, USER_PASS_LEN);
 		  buf_printf (&packed_resp, "CRV1::%s::%s", ac->state_id, response);
 		}
@@ -1089,33 +1112,61 @@ get_user_pass_cr (struct user_pass *up,
 	  else
 #endif
 	    {
+	      struct query_user *qucfg = NULL;
 	      struct buffer user_prompt = alloc_buf_gc (128, &gc);
 	      struct buffer pass_prompt = alloc_buf_gc (128, &gc);
 
+	      if( !query_user_init (&gc, &qucfg) )
+		{
+		  msg (M_FATAL, "ERROR: Could not prepare for username/password dialogue");
+		}
+
 	      buf_printf (&user_prompt, "Enter %s Username:", prefix);
 	      buf_printf (&pass_prompt, "Enter %s Password:", prefix);
 
 	      if (!(flags & GET_USER_PASS_PASSWORD_ONLY))
 		{
-		  if (!get_console_input (BSTR (&user_prompt), true, up->username, USER_PASS_LEN))
-		    msg (M_FATAL, "ERROR: could not read %s username from stdin", prefix);
+		  query_user_add (qucfg, BSTR(&user_prompt), BLEN(&user_prompt),
+                                  up->username, USER_PASS_LEN, true, true);
+		}
+
+	      query_user_add (qucfg, BSTR(&pass_prompt), BLEN(&pass_prompt),
+                              up->password, USER_PASS_LEN, true, false);
+
+	      if( !query_user_exec (qucfg) )
+		{
+		  msg( M_FATAL, "ERROR: Failed retrieving username or password");
+		}
+
+	      if (!(flags & GET_USER_PASS_PASSWORD_ONLY))
+		{
 		  if (strlen (up->username) == 0)
 		    msg (M_FATAL, "ERROR: %s username is empty", prefix);
 		}
 
-	      if (!get_console_input (BSTR (&pass_prompt), false, up->password, USER_PASS_LEN))
-		msg (M_FATAL, "ERROR: could not not read %s password from stdin", prefix);
-
 #ifdef ENABLE_CLIENT_CR
 	      if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
 		{
+		  struct query_user *qucfg = NULL;
 		  char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
-		  struct buffer packed_resp;
+		  struct buffer packed_resp, challenge;
 		  char *pw64=NULL, *resp64=NULL;
 
-		  msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", auth_challenge);
-		  if (!get_console_input ("Response:", BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO), response, USER_PASS_LEN))
-		    msg (M_FATAL, "ERROR: could not read static challenge response from stdin");
+		  if( !query_user_init (&gc, &qucfg) )
+		    {
+		      msg (M_FATAL, "ERROR: Could not prepare for username/password dialogue");
+		    }
+
+		  challenge = alloc_buf_gc (14+strlen(auth_challenge), &gc);
+		  buf_printf (&challenge, "CHALLENGE: %s", auth_challenge);
+
+		  query_user_add (qucfg, BSTR(&challenge), BLEN(&challenge), response, USER_PASS_LEN,
+				 true, BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO));
+
+		  if (!query_user_exec (qucfg))
+		    {
+		      msg (M_FATAL, "ERROR: could not retrieve static challenge response");
+		    }
 		  if (openvpn_base64_encode(up->password, strlen(up->password), &pw64) == -1
 		      || openvpn_base64_encode(response, strlen(response), &resp64) == -1)
 		    msg (M_FATAL, "ERROR: could not base64-encode password/static_response");
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 3a15ef6..8e57a85 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -5,7 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2015 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -740,6 +741,7 @@ _pkcs11_openvpn_show_pkcs11_ids_pin_prompt (
 	const size_t pin_max
 ) {
 	struct gc_arena gc = gc_new ();
+	struct query_user *qucfg = NULL;
 	struct buffer pass_prompt = alloc_buf_gc (128, &gc);
 
 	(void)global_data;
@@ -748,10 +750,18 @@ _pkcs11_openvpn_show_pkcs11_ids_pin_prompt (
 
 	ASSERT (token!=NULL);
 
+	if( !query_user_init (&gc, &qucfg) )
+	{
+	    msg (M_FATAL, "ERROR: Could not prepare for token PIN dialogue");
+	}
+
 	buf_printf (&pass_prompt, "Please enter '%s' token PIN or 'cancel': ", token->display);
+	query_user_add(qucfg, BSTR(&pass_prompt), BLEN(&pass_prompt),
+		       pin, pin_max, true, false);
 
-	if (!get_console_input (BSTR (&pass_prompt), false, pin, pin_max)) {
-		msg (M_FATAL, "Cannot read password from stdin");
+	if (!query_user_exec (qucfg))
+	{
+	    msg (M_FATAL, "Could not retrieve the PIN");
 	}
 
 	gc_free (&gc);
-- 
1.8.3.1


