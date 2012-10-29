From: David Sommerseth <dazo@...384...>
Date: Mon, 29 Oct 2012 20:35:52 +0100
Message-Id: <1351539352-17371-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] Remove the support for using system() when
	executing external programs or scripts
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

This patch removes the support for the system() call, and enforces the usage of execve()
on the *nix platform and CreateProcessW() on Windows.  This is to enhance the overall
security when calling external scripts.  Using system() is prone to shell expansions,
which may lead to security breaches.  Which is also why the execve() approach has
been the default since commit a82813527551f0e79c6d6ed5a9c1162e3c171bcf which
re-introduced the system() in Nov. 2008.

After having asked on the mailing list and checked around on the IRC channels, the
genereal consensus is that very few uses system() these days.

The only annoyance I've been made aware of is that this will now require adding a full
path to the script interpreter together with the script, and not just put in the
script name alone.  But to just use the script name in Windows, you had to configure
--script-security with the 'system' flag earlier too.  So my conclusion is that it's
better to add a full path to the script interpreter in Windows and raise the overal
security with OpenVPN, than to continue to have a possible potentially risky
OpenVPN configuration just to make life "easier" for Windows script users.

Removal of the system() call, also solves a nasty bug related to the usage of putenv()
on the *nix platforms.

For more information please see:
http://thread.gmane.org/gmane.network.openvpn.devel/7090
https://community.openvpn.net/openvpn/ticket/228

Trac-ticket: 228
Signed-off-by: David Sommerseth <davids@...1347...>
---
 doc/openvpn.8          |   48 ++++++++++++------
 src/openvpn/init.c     |    3 --
 src/openvpn/misc.c     |   98 ++++++++-----------------------------
 src/openvpn/misc.h     |    5 --
 src/openvpn/options.c  |   16 +-----
 src/openvpn/platform.c |   27 +---------
 src/openvpn/platform.h |    4 +-
 src/openvpn/win32.c    |  127 +++++++++++++-----------------------------------
 8 files changed, 89 insertions(+), 239 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index aa653ec..2ed5201 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1886,7 +1886,7 @@ is a safety precaution to prevent a LD_PRELOAD style attack
 from a malicious or compromised server.
 .\"*********************************************************
 .TP
-.B \-\-script-security level [method]
+.B \-\-script-security level
 This directive offers policy-level control over OpenVPN's usage of external programs
 and scripts.  Lower
 .B level
@@ -1905,24 +1905,40 @@ Allow calling of built-in executables and user-defined scripts.
 .B 3 \-\-
 Allow passwords to be passed to scripts via environmental variables (potentially unsafe).
 
-The
+OpenVPN releases before v2.3 also supported a
 .B method
-parameter indicates how OpenVPN should call external commands and scripts.
-Settings for
-.B method:
+flag which indicated how OpenVPN should call external commands and scripts.  This
+could be either
+.B execve
+or 
+.B system. 
+As of OpenVPN v2.3, this flag is no longer accepted.  In most *nix environments the execve()
+approach has been used without any issues.
+
+To run scripts in Windows in earlier OpenVPN
+versions you needed to either add a full path to the script interpreter which can parse the
+script or use the
+.B system
+flag to run these scripts.  As of OpenVPN v2.3 it is now a strict requirement to have
+full path to the script interpreter when running non-executables files.
+This is not needed for executable files, such as .exe, .com, .bat or .cmd files.  For
+example, if you have a Visual Basic script, you must use this syntax now:
 
-.B execve \-\-
-(default) Use execve() function on Unix family OSes and CreateProcess() on Windows.
-.br
-.B system \-\-
-Use system() function (deprecated and less safe since the external program command
-line is subject to shell expansion).
+.nf
+.ft 3
+.in +4
+\-\-up 'C:\\\\Windows\\\\System32\\\\wscript.exe C:\\\\Program\\ Files\\\\OpenVPN\\\\config\\\\my-up-script.vbs'
+.in -4
+.ft
+.fi
 
-The
-.B \-\-script-security
-option was introduced in OpenVPN 2.1_rc9.  For configuration file compatibility
-with previous OpenVPN versions, use:
-.B \-\-script-security 3 system
+Please note the single quote marks and the escaping of the backslashes (\\) and
+the space character.
+
+The reason the support for the
+.B system
+flag was removed is due to the security implications with shell expansions
+when executing scripts via the system() call.
 .\"*********************************************************
 .TP
 .B \-\-disable-occ
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 270ee6a..25d8225 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2487,9 +2487,6 @@ do_option_warnings (struct context *c)
     msg (M_WARN, "WARNING: the current --script-security setting may allow passwords to be passed to scripts via environmental variables");
   else
     msg (M_WARN, "NOTE: " PACKAGE_NAME " 2.1 requires '--script-security 2' or higher to call user-defined scripts or executables");
-
-  if (script_method == SM_SYSTEM)
-    msg (M_WARN, "NOTE: --script-security method='system' is deprecated due to the fact that passed parameters will be subject to shell expansion");
 }
 
 static void
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index d2882d8..53f6d03 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -53,9 +53,6 @@ const char *iproute_path = IPROUTE_PATH; /* GLOBAL */
 /* contains an SSEC_x value defined in misc.h */
 int script_security = SSEC_BUILT_IN; /* GLOBAL */
 
-/* contains SM_x value defined in misc.h */
-int script_method = SM_EXECVE; /* GLOBAL */
-
 /*
  * Pass tunnel endpoint and MTU parms to a user-supplied script.
  * Used to execute the up/down script/plugins.
@@ -303,36 +300,25 @@ openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned i
 #if defined(ENABLE_FEATURE_EXECVE)
       if (openvpn_execve_allowed (flags))
 	{
-	  if (script_method == SM_EXECVE)
-	    {
-	      const char *cmd = a->argv[0];
-	      char *const *argv = a->argv;
-	      char *const *envp = (char *const *)make_env_array (es, true, &gc);
-	      pid_t pid;
-
-	      pid = fork ();
-	      if (pid == (pid_t)0) /* child side */
-		{
-		  execve (cmd, argv, envp);
-		  exit (127);
-		}
-	      else if (pid < (pid_t)0) /* fork failed */
-		msg (M_ERR, "openvpn_execve: unable to fork");
-	      else /* parent side */
-		{
-		  if (waitpid (pid, &ret, 0) != pid)
-		    ret = -1;
-		}
-	    }
-	  else if (script_method == SM_SYSTEM)
-	    {
-	      ret = openvpn_system (argv_system_str (a), es, flags);
-	    }
-	  else
-	    {
-	      ASSERT (0);
-	    }
-	}
+          const char *cmd = a->argv[0];
+          char *const *argv = a->argv;
+          char *const *envp = (char *const *)make_env_array (es, true, &gc);
+          pid_t pid;
+
+          pid = fork ();
+          if (pid == (pid_t)0) /* child side */
+            {
+              execve (cmd, argv, envp);
+              exit (127);
+            }
+          else if (pid < (pid_t)0) /* fork failed */
+            msg (M_ERR, "openvpn_execve: unable to fork");
+          else /* parent side */
+            {
+              if (waitpid (pid, &ret, 0) != pid)
+                ret = -1;
+            }
+        }
       else if (!warn_shown && (script_security < SSEC_SCRIPTS))
 	{
 	  msg (M_WARN, SCRIPT_SECURITY_WARNING);
@@ -353,52 +339,6 @@ openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned i
 #endif
 
 /*
- * Wrapper around the system() call.
- */
-int
-openvpn_system (const char *command, const struct env_set *es, unsigned int flags)
-{
-#ifdef HAVE_SYSTEM
-  int ret;
-
-  perf_push (PERF_SCRIPT);
-
-  /*
-   * add env_set to environment.
-   */
-  if (flags & S_SCRIPT)
-    env_set_add_to_environment (es);
-
-
-  /* debugging */
-  dmsg (D_SCRIPT, "SYSTEM[%u] '%s'", flags, command);
-  if (flags & S_SCRIPT)
-    env_set_print (D_SCRIPT, es);
-
-  /*
-   * execute the command
-   */
-  ret = platform_system(command);
-
-  /* debugging */
-  dmsg (D_SCRIPT, "SYSTEM return=%u", ret);
-
-  /*
-   * remove env_set from environment
-   */
-  if (flags & S_SCRIPT)
-    env_set_remove_from_environment (es);
-
-  perf_pop ();
-  return ret;
-
-#else
-  msg (M_FATAL, "Sorry but I can't execute the shell command '%s' because this operating system doesn't appear to support the system() call", command);
-  return -1; /* NOTREACHED */
-#endif
-}
-
-/*
  * Run execve() inside a fork(), duping stdout.  Designed to replicate the semantics of popen() but
  * in a safer way that doesn't require the invocation of a shell or the risks
  * assocated with formatting and parsing a command line.
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index b6da3f4..183898e 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -96,7 +96,6 @@ int openvpn_popen (const struct argv *a,  const struct env_set *es);
 int openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned int flags);
 bool openvpn_execve_check (const struct argv *a, const struct env_set *es, const unsigned int flags, const char *error_message);
 bool openvpn_execve_allowed (const unsigned int flags);
-int openvpn_system (const char *command, const struct env_set *es, unsigned int flags);
 
 static inline bool
 openvpn_run_script (const struct argv *a, const struct env_set *es, const unsigned int flags, const char *hook)
@@ -322,10 +321,6 @@ extern const char *iproute_path;
 #define SSEC_PW_ENV    3 /* allow calling of built-in programs and user-defined scripts that may receive a password as an environmental variable */
 extern int script_security; /* GLOBAL */
 
-#define SM_EXECVE 0      /* call external programs with execve() or CreateProcess() */
-#define SM_SYSTEM 1      /* call external programs with system() */
-extern int script_method; /* GLOBAL */
-
 /* return the next largest power of 2 */
 size_t adjust_power_of_2 (size_t u);
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index edc9195..9baa4ff 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -248,7 +248,7 @@ static const char usage_message[] =
   "--setenv name value : Set a custom environmental variable to pass to script.\n"
   "--setenv FORWARD_COMPATIBLE 1 : Relax config file syntax checking to allow\n"
   "                  directives for future OpenVPN versions to be ignored.\n"
-  "--script-security level mode : mode='execve' (default) or 'system', level=\n"
+  "--script-security level: Where level can be:\n"
   "                  0 -- strictly no calling of external programs\n"
   "                  1 -- (default) only call built-ins such as ifconfig\n"
   "                  2 -- allow calling of built-ins and scripts\n"
@@ -5293,20 +5293,6 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       script_security = atoi (p[1]);
-      if (p[2])
-	{
-	  if (streq (p[2], "execve"))
-	    script_method = SM_EXECVE;
-	  else if (streq (p[2], "system"))
-	    script_method = SM_SYSTEM;
-	  else
-	    {
-	      msg (msglevel, "unknown --script-security method: %s", p[2]);
-	      goto err;
-	    }
-	}
-      else
-	script_method = SM_EXECVE;
     }
   else if (streq (p[0], "mssfix"))
     {
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index c79f680..e79de7a 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -205,7 +205,7 @@ platform_chdir (const char* dir)
 }
 
 /*
- * convert system() return into a success/failure value
+ * convert execve() return into a success/failure value
  */
 bool
 platform_system_ok (int stat)
@@ -217,19 +217,6 @@ platform_system_ok (int stat)
 #endif
 }
 
-/*
- * did system() call execute the given command?
- */
-bool
-platform_system_executed (int stat)
-{
-#ifdef WIN32
-  return stat != -1;
-#else
-  return stat != -1 && WEXITSTATUS (stat) != 127;
-#endif
-}
-
 int
 platform_access (const char *path, int mode)
 {
@@ -288,18 +275,6 @@ platform_unlink (const char *filename)
 #endif
 }
 
-int platform_system(const char *command) {
-  int ret;
-#ifdef WIN32
-  struct gc_arena gc = gc_new ();
-  ret = _wsystem (wide_string (command, &gc));
-  gc_free (&gc);
-#else
-  ret = system (command);
-#endif
-  return ret;
-}
-
 int platform_putenv(char *string)
 {
   int status;
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index 7bd2067..7c0a4d7 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -113,10 +113,8 @@ void platform_mlockall (bool print_msg); /* Disable paging */
 
 int platform_chdir (const char* dir);
 
-/* interpret the status code returned by system()/execve() */
+/* interpret the status code returned by execve() */
 bool platform_system_ok (int stat);
-bool platform_system_executed (int stat);
-int platform_system(const char *command);
 
 int platform_access (const char *path, int mode);
 
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index d00088e..2db96a8 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -82,51 +82,6 @@ struct semaphore netcmd_semaphore; /* GLOBAL */
  */
 static char *win_sys_path = NULL; /* GLOBAL */
 
-/*
- * Configure PATH.  On Windows, sometimes PATH is not set correctly
- * by default.
- */
-static void
-configure_win_path (void)
-{
-  static bool done = false; /* GLOBAL */
-  if (!done)
-    {
-      FILE *fp;
-      fp = fopen ("c:\\windows\\system32\\route.exe", "rb");
-      if (fp)
-	{
-	  const int bufsiz = 4096;
-	  struct gc_arena gc = gc_new ();
-	  struct buffer oldpath = alloc_buf_gc (bufsiz, &gc);
-	  struct buffer newpath = alloc_buf_gc (bufsiz, &gc);
-	  const char* delim = ";";
-	  DWORD status;
-	  fclose (fp);
-	  status = GetEnvironmentVariable ("PATH", BPTR(&oldpath), (DWORD)BCAP(&oldpath));
-#if 0
-	  status = 0;
-#endif
-	  if (!status)
-	    {
-	      *BPTR(&oldpath) = '\0';
-	      delim = "";
-	    }
-	  buf_printf (&newpath, "C:\\WINDOWS\\System32;C:\\WINDOWS;C:\\WINDOWS\\System32\\Wbem%s%s",
-		      delim,
-		      BSTR(&oldpath));
-	  SetEnvironmentVariable ("PATH", BSTR(&newpath));
-#if 0
-	  status = GetEnvironmentVariable ("PATH", BPTR(&oldpath), (DWORD)BCAP(&oldpath));
-	  if (status > 0)
-	    printf ("PATH: %s\n", BSTR(&oldpath));
-#endif
-	  gc_free (&gc);
-	  done = true;
-	}
-    }
-}
-
 void
 init_win32 (void)
 {
@@ -907,53 +862,41 @@ openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned i
     {
       if (openvpn_execve_allowed (flags))
 	{
-	  if (script_method == SM_EXECVE)
-	    {
-	      struct gc_arena gc = gc_new ();
-	      STARTUPINFOW start_info;
-	      PROCESS_INFORMATION proc_info;
-
-	      char *env = env_block (es);
-	      WCHAR *cl = wide_cmd_line (a, &gc);
-	      WCHAR *cmd = wide_string (a->argv[0], &gc);
-
-	      CLEAR (start_info);
-	      CLEAR (proc_info);
-
-	      /* fill in STARTUPINFO struct */
-	      GetStartupInfoW(&start_info);
-	      start_info.cb = sizeof(start_info);
-	      start_info.dwFlags = STARTF_USESHOWWINDOW;
-	      start_info.wShowWindow = SW_HIDE;
-
-	      if (CreateProcessW (cmd, cl, NULL, NULL, FALSE, 0, env, NULL, &start_info, &proc_info))
-		{
-		  DWORD exit_status = 0;
-		  CloseHandle (proc_info.hThread);
-		  WaitForSingleObject (proc_info.hProcess, INFINITE);
-		  if (GetExitCodeProcess (proc_info.hProcess, &exit_status))
-		    ret = (int)exit_status;
-		  else
-		    msg (M_WARN|M_ERRNO, "openvpn_execve: GetExitCodeProcess %S failed", cmd);
-		  CloseHandle (proc_info.hProcess);
-		}
-	      else
-		{
-		  msg (M_WARN|M_ERRNO, "openvpn_execve: CreateProcess %S failed", cmd);
-		}
-	      free (env);
-	      gc_free (&gc);
-	    }
-	  else if (script_method == SM_SYSTEM)
-	    {
-	      configure_win_path ();
-	      ret = openvpn_system (argv_system_str (a), es, flags);
-	    }
-	  else
-	    {
-	      ASSERT (0);
-	    }
-	}
+          struct gc_arena gc = gc_new ();
+          STARTUPINFOW start_info;
+          PROCESS_INFORMATION proc_info;
+
+          char *env = env_block (es);
+          WCHAR *cl = wide_cmd_line (a, &gc);
+          WCHAR *cmd = wide_string (a->argv[0], &gc);
+
+          CLEAR (start_info);
+          CLEAR (proc_info);
+
+          /* fill in STARTUPINFO struct */
+          GetStartupInfoW(&start_info);
+          start_info.cb = sizeof(start_info);
+          start_info.dwFlags = STARTF_USESHOWWINDOW;
+          start_info.wShowWindow = SW_HIDE;
+
+          if (CreateProcessW (cmd, cl, NULL, NULL, FALSE, 0, env, NULL, &start_info, &proc_info))
+            {
+              DWORD exit_status = 0;
+              CloseHandle (proc_info.hThread);
+              WaitForSingleObject (proc_info.hProcess, INFINITE);
+              if (GetExitCodeProcess (proc_info.hProcess, &exit_status))
+                ret = (int)exit_status;
+              else
+                msg (M_WARN|M_ERRNO, "openvpn_execve: GetExitCodeProcess %S failed", cmd);
+              CloseHandle (proc_info.hProcess);
+            }
+          else
+            {
+              msg (M_WARN|M_ERRNO, "openvpn_execve: CreateProcess %S failed", cmd);
+            }
+          free (env);
+          gc_free (&gc);
+        }
       else if (!exec_warn && (script_security < SSEC_SCRIPTS))
 	{
 	  msg (M_WARN, SCRIPT_SECURITY_WARNING);
-- 
1.7.10.2


