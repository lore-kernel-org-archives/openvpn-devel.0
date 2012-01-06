Message-ID: <1325868040.2547.19.camel@...1520...>
From: Frederic Crozat <fcrozat@...1519...>
Date: Fri, 06 Jan 2012 17:40:40 +0100
In-Reply-To: <4F071FD7.3060201@...1114...>
References: <1320075008.29689.31.camel@...1520...>
	<4EAF0EFD.6060106@...1114...>
	<1323712625.31471.4.camel@...1520...>
	<4F071FD7.3060201@...1114...>
Content-Type: multipart/mixed; boundary="=-L0nXbkCdlxW/uKjGGWKc"
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] adding support for systemd tty console
 wrapper
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--=-L0nXbkCdlxW/uKjGGWKc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Le vendredi 06 janvier 2012 à 17:22 +0100, David Sommerseth a écrit :
> On 12/12/11 18:57, Frederic Crozat wrote:
> > Le lundi 31 octobre 2011 à 22:11 +0100, David Sommerseth a écrit :
> >> On 31/10/11 16:30, Frederic Crozat wrote:
> [...snip...]
> 
> Hey again, and thanks for this great rework!  I've looked through it, and
> it looks a lot better now.  However ...
> 
> >> e) Consider to make use of openvpn_execve_check() or
> >> openvpn_execve() instead of the popen() - or make a popen() variant
> >> which got similar error controls to popen() as openvpn_execve*()
> >> functions.  I also think that this execution should honour the
> >> --script-security setting (which is implicitly checked for with
> >> openvpn_execve())
> 
> I like the approach of the openvpn_popen().  However, there are a few things.
> 
> +              if (pipe(pipe_stdout) == 0) {
> +		      pid = fork ();
> +		      if (pid == (pid_t)0) /* child side */
> +			{
> +			  close(pipe_stdout[0]);
> +			  dup2(pipe_stdout[1],1);
> +			  execve (cmd, argv, envp);
> +			  exit (127);
> +			}
> +		      else if (pid < (pid_t)0) /* fork failed */
> +			;
>                        ^^^^^  No error message if fork() fails?
>                               And is the (pid_t) typecasting really needed?

Well, I stole the code from openvpn_execve function ;))
I'm ok to change it, but it would be better for both function to stay
similar, I think.

> +		      else /* parent side */
> +			{
> +                            ret=pipe_stdout[0];
> +			    close(pipe_stdout[1]);
> +			}
> +	      }
> 
> And:
> 
> +  else
> +    {
> +      msg (M_WARN, "openvpn_popen: called with empty argv");
> +    }
> 
> This should probably be M_FATAL and not M_WARN.  If openvpn_popen()
> receives an empty argv array, it most likely is due to very bad
> programming.  So halting execution is quite appropriate in my eyes.

Again, I stole this part from openvpn_execve, but I'll change it to
M_FATAL.

> In get_console_input_systemd() you do:
> 
> +  *input = 0;
> 
> I think it would be better to do: CLEAR(*input) instead.  Just setting
> the first byte to 0, will not solve any leak possibilities.  An
> alternative is to use memset() directly, which the CLEAR() macro uses
> (see basic.h:47), but we prefer to use CLEAR() over memset() directly.

done (and I've also fixed some missing spaces in various location).

See the new version attached.
-- 
Frederic Crozat <fcrozat@...1519...>
SUSE

--=-L0nXbkCdlxW/uKjGGWKc
Content-Disposition: inline;
	filename="0001-Add-support-to-forward-console-query-to-systemd.patch"
Content-Type: text/x-patch;
	name="0001-Add-support-to-forward-console-query-to-systemd.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

From b3eb16e24ff354ce417fee4e8f48b8a8244e8b0c Mon Sep 17 00:00:00 2001
From: Frederic Crozat <fcrozat@...1519...>
Date: Mon, 31 Oct 2011 15:51:53 +0100
Subject: [PATCH] Add support to forward console query to systemd

Systemd requires console query to be forwarded using its own
tool.

Signed-off-by: Frederic Crozat <fcrozat@...1519...>
---
 configure.ac |   11 +++++
 misc.c       |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index a4d68e6..7143cc5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -223,6 +223,12 @@ AC_ARG_ENABLE(selinux,
    [SELINUX="yes"]
 )
 
+AC_ARG_ENABLE(systemd,
+   [  --enable-systemd        Enable systemd suppport],
+   [SYSTEMD="$enableval"],
+   [SYSTEMD="no"]
+)
+
 AC_ARG_WITH(ssl-headers,
    [  --with-ssl-headers=DIR  Crypto/SSL Include files location],
    [CS_HDR_DIR="$withval"]
@@ -930,6 +936,11 @@ if test "$PASSWORD_SAVE" = "yes"; then
    AC_DEFINE(ENABLE_PASSWORD_SAVE, 1, [Allow --askpass and --auth-user-pass passwords to be read from a file])
 fi
 
+dnl enable systemd support
+if test "$SYSTEMD" = "yes"; then
+   AC_DEFINE(ENABLE_SYSTEMD, 1, [Enable systemd support])
+fi
+
 dnl
 dnl check for SELinux library and headers
 dnl
diff --git a/misc.c b/misc.c
index 99e5bc5..b38553f 100644
--- a/misc.c
+++ b/misc.c
@@ -36,6 +36,7 @@
 #include "crypto.h"
 #include "route.h"
 #include "win32.h"
+#include <unistd.h>
 
 #include "memdbg.h"
 
@@ -610,6 +611,71 @@ openvpn_system (const char *command, const struct env_set *es, unsigned int flag
 }
 
 /*
+ * Run execve() inside a fork(), duping stdout.  Designed to replicate the semantics of popen() but
+ * in a safer way that doesn't require the invocation of a shell or the risks
+ * assocated with formatting and parsing a command line.
+ */
+int
+openvpn_popen (const struct argv *a,  const struct env_set *es)
+{
+  struct gc_arena gc = gc_new ();
+  int ret = -1;
+  static bool warn_shown = false;
+
+  if (a && a->argv[0])
+    {
+#if defined(ENABLE_EXECVE)
+      if (script_security >= SSEC_BUILT_IN)
+	{
+	      const char *cmd = a->argv[0];
+	      char *const *argv = a->argv;
+	      char *const *envp = (char *const *)make_env_array (es, true, &gc);
+	      pid_t pid;
+	      int pipe_stdout[2];
+
+              if (pipe (pipe_stdout) == 0) {
+		      pid = fork ();
+		      if (pid == (pid_t)0) /* child side */
+			{
+			  close (pipe_stdout[0]);
+			  dup2 (pipe_stdout[1],1);
+			  execve (cmd, argv, envp);
+			  exit (127);
+			}
+		      else if (pid < (pid_t)0) /* fork failed */
+			;
+		      else /* parent side */
+			{
+                            ret=pipe_stdout[0];
+			    close (pipe_stdout[1]);
+			}
+	      }
+	      else {
+		      msg (M_WARN, "openvpn_popen: unable to create stdout pipe");
+		      ret = -1;
+	      }
+	}
+      else if (!warn_shown && (script_security < SSEC_SCRIPTS))
+	{
+	  msg (M_WARN, SCRIPT_SECURITY_WARNING);
+          warn_shown = true;
+	}
+#else
+      msg (M_WARN, "openvpn_popen: execve function not available");
+#endif
+    }
+  else
+    {
+      msg (M_FATAL, "openvpn_popen: called with empty argv");
+    }
+
+  gc_free (&gc);
+  return ret;
+}
+
+
+
+/*
  * Initialize random number seed.  random() is only used
  * when "weak" random numbers are acceptable.
  * OpenSSL routines are always used when cryptographically
@@ -1328,6 +1394,56 @@ close_tty (FILE *fp)
 #endif
 
 /*
+ * is systemd running
+ */
+
+#if defined(TARGET_LINUX) && defined(ENABLE_SYSTEMD)
+bool
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
+bool
+get_console_input_systemd (const char *prompt, const bool echo, char *input, const int capacity)
+{
+  int std_out;
+  char cmd[256];
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
  * Get input from console
  */
 bool
@@ -1339,6 +1455,11 @@ get_console_input (const char *prompt, const bool echo, char *input, const int c
   ASSERT (capacity > 0);
   input[0] = '\0';
 
+#if defined(TARGET_LINUX) && defined(ENABLE_SYSTEMD)
+  if (check_systemd_running ())
+    return get_console_input_systemd (prompt, echo, input, capacity);
+#endif
+
 #if defined(WIN32)
   return get_console_input_win32 (prompt, echo, input, capacity);
 #elif defined(HAVE_GETPASS)
-- 
1.7.7


--=-L0nXbkCdlxW/uKjGGWKc--


