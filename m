Message-ID: <1323712625.31471.4.camel@...1520...>
From: Frederic Crozat <fcrozat@...1519...>
Date: Mon, 12 Dec 2011 18:57:05 +0100
In-Reply-To: <4EAF0EFD.6060106@...1114...>
References: <1320075008.29689.31.camel@...1520...>
	<4EAF0EFD.6060106@...1114...>
Content-Type: multipart/mixed; boundary="=-miX0in+7olI/aCtO0owE"
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
Cc: openvpn-devel@lists.sourceforge.net

--=-miX0in+7olI/aCtO0owE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Le lundi 31 octobre 2011 à 22:11 +0100, David Sommerseth a écrit :
> On 31/10/11 16:30, Frederic Crozat wrote:
> > Hi,
> > 
> > as part of openSUSE switching to systemd by default, openVPN was made 
> > compatible with the systemd way of querying passphrase during boot 
> > (directly opening tty isn't supported).
> > 
> 
> Thanks a lot for looking into this!  I feared that we would need to do
> some changes due to systemd.

Sorry for the very slow answer.

> Generally, this looks very fine.  But I would like to see a few changes
> first before including it.
> 
> a) From what I've understood, systemd is by design a Linux only thing.
> So I'd like to see these code paths restricted to TARGET_LINUX (#ifdef
> statements).  A lot of the dependencies is kernel related, so we probably
> won't see systemd for BSD, for example.  And even less realistic is
> Solaris.  Windows already goes a different route, so this won't be
> affected here.

No problem with that.

> b) As systemd is not targetted for embedded Linux devices (it's a massive
> resource hog, esp. in RAM and looks like to be most suitable in
> desktop/laptop environments), it could be useful to have this support
> compile time confiugrable via ./configure.  I would even vote for
> disabling it by default.  Right now, systemd only got traction from SuSE,
> Fedora.  Debian is in the works and Ubuntu usually follows Debian.  Arch
> Linux will move over as well.

Well, systemd is being investigated also for embedded linux (but this is
not the topic of this discussion). I'm fine for adding configure flag
and making it disabled by default (or maybe auto enable if systemd is
installed on the system ? )

> However, I am systemd sceptic, and I would like to see if systemd really
> settles as a de-facto SySV replacement across the majority of Linux
> distributions, before enabling this support by default on Linux.  I
> struggle to see that systemd will be beneficial on (enterprise) servers,
> as if the booting goes twice as fast or not on a server isn't that
> critical compared to a desktop/laptop system.  And boot performance is
> one of the key points systemd tries to resolve.

The part for managing services is also pretty interesting, from a
service side perspective (each service in a separate cgroup, etc..). I
recommend reading the various "systemd for administrator" blog post from
systemd author ;)

> c) It would probably be better to but the "check if systemd is available"
> into it's own function, for clarity - isolated in
> #ifdef defined(TARGET_LINUX) && defined(USE_SYSTEMD) blocks.  And
> likewise, do the /bin/systemd-ask-password in a separate function similar
> fashion as what is done with Windows' get_console_input_win32().

Ok.

> d) Instead of asprintf(), use openvpn_snprintf() functions.  That can
> probably be just as fine work against a static sized buffer (say 256
> bytes - it's for a password, right?)  As this is called during startup,
> and it is serialised among all those places this might be asked for,
> there are no threading issues here, AFAICS.

this code changed now..

> e) Consider to make use of openvpn_execve_check() or openvpn_execve()
> instead of the popen() - or make a popen() variant which got similar
> error controls to popen() as openvpn_execve*() functions.  I also think
> that this execution should honour the --script-security setting (which is
> implicitly checked for with openvpn_execve())

I've tried to come up with something.

> f) There are a few mixtures between tab and spaces in your patch.  If you
> could please use space only, that would be great.  The code is a mess in
> this regard, but we're trying to (very slowly) reduce the variety in new
> patches.

Should be much better now.

Comments welcome.

-- 
Frederic Crozat <fcrozat@...1519...>
SUSE



--=-miX0in+7olI/aCtO0owE
Content-Disposition: inline;
	filename="0001-Add-support-to-forward-console-query-to-systemd.patch"
Content-Type: text/x-patch;
	name="0001-Add-support-to-forward-console-query-to-systemd.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

From caf1af91e5d6864054479476e87a752381293788 Mon Sep 17 00:00:00 2001
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
index 99e5bc5..727fbaa 100644
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
+              if (pipe(pipe_stdout) == 0) {
+		      pid = fork ();
+		      if (pid == (pid_t)0) /* child side */
+			{
+			  close(pipe_stdout[0]);
+			  dup2(pipe_stdout[1],1);
+			  execve (cmd, argv, envp);
+			  exit (127);
+			}
+		      else if (pid < (pid_t)0) /* fork failed */
+			;
+		      else /* parent side */
+			{
+                            ret=pipe_stdout[0];
+			    close(pipe_stdout[1]);
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
+      msg (M_WARN, "openvpn_popen: called with empty argv");
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
+  argv_init(&argv);
+  argv_printf(&argv, "/bin/systemd-ask-password");
+  argv_printf_cat(&argv, "%s", prompt);
+
+  if ((std_out = openvpn_popen (&argv, NULL)) < 0) {
+	  return false;
+  }
+  *input = 0;
+  if (read (std_out, input, capacity) != 0)
+    {
+       chomp (input);
+       ret = true;
+    }
+  close (std_out);
+
+  argv_reset(&argv);
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


--=-miX0in+7olI/aCtO0owE--


