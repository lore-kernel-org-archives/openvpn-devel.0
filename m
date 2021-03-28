From: =?UTF-8?q?T=C3=B5ivo=20Leedj=C3=A4rv?= <toivol@...277...>
Date: Sun, 28 Mar 2021 17:11:51 +0000
Message-Id: <20210328171151.12056-1-toivol@...277...>
In-Reply-To: <20210328155748.GF976@...1296...>
References: <20210328155748.GF976@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Stop using deprecated getpass()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The getpass() function is present in SUSv2, but marked LEGACY. It is
removed in POSIX.1-2001. Additionally, on Solaris getpass() returns
maximum 9 bytes. This will make longer passwords fail with no
possibility for user to know what is happening.

This patch removes usage of getpass() completely and replaces it with
direct implementation of what getpass() does: opens tty (existing code),
outputs the prompt (existing code), turns off echoing (new code), reads
one line (existing code shared with echoed mode), restores tty state
(new code) and closes tty (existing code).

Patch v2: incorporate review feedback, incl. style fixes, merge
          termios.h check in configure.ac with an existing
          AC_CHECK_HEADERS, add error check and logging after
          tcsettattr() when restoring tty settings

Signed-off-by: Tõivo Leedjärv <toivol@...277...>
---
 configure.ac                  |  4 +--
 src/openvpn/console_builtin.c | 60 +++++++++++++++++++++--------------
 2 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/configure.ac b/configure.ac
index 428bebed..6668bbcf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -438,7 +438,7 @@ AC_CHECK_HEADERS([ \
 	sys/time.h sys/ioctl.h sys/stat.h \
 	sys/mman.h sys/file.h sys/wait.h \
 	unistd.h signal.h libgen.h stropts.h \
-	syslog.h pwd.h grp.h \
+	syslog.h pwd.h grp.h termios.h \
 	sys/sockio.h sys/uio.h linux/sockios.h \
 	linux/types.h poll.h sys/epoll.h err.h \
 ])
@@ -652,7 +652,7 @@ AC_FUNC_FORK
 
 AC_CHECK_FUNCS([ \
 	daemon chroot getpwnam setuid nice system getpid dup dup2 \
-	getpass syslog openlog mlockall getrlimit getgrnam setgid \
+	syslog openlog mlockall getrlimit getgrnam setgid \
 	setgroups stat flock readv writev time gettimeofday \
 	ctime memset vsnprintf strdup \
 	setsid chdir putenv getpeername unlink \
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 445928bf..22ac9f79 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -40,6 +40,10 @@
 #include "buffer.h"
 #include "misc.h"
 
+#ifdef HAVE_TERMIOS_H
+#include <termios.h>
+#endif
+
 #ifdef _WIN32
 
 #include "win32.h"
@@ -138,7 +142,7 @@ get_console_input_win32(const char *prompt, const bool echo, char *input, const
 #endif   /* _WIN32 */
 
 
-#ifdef HAVE_GETPASS
+#ifdef HAVE_TERMIOS_H
 
 /**
  * Open the current console TTY for read/write operations
@@ -177,7 +181,7 @@ close_tty(FILE *fp)
     }
 }
 
-#endif   /* HAVE_GETPASS */
+#endif   /* HAVE_TERMIOS_H */
 
 
 /**
@@ -201,7 +205,9 @@ get_console_input(const char *prompt, const bool echo, char *input, const int ca
 
 #if defined(_WIN32)
     return get_console_input_win32(prompt, echo, input, capacity);
-#elif defined(HAVE_GETPASS)
+#elif defined(HAVE_TERMIOS_H)
+    bool restore_tty = false;
+    struct termios tty_tmp, tty_save;
 
     /* did we --daemon'ize before asking for passwords?
      * (in which case neither stdin or stderr are connected to a tty and
@@ -220,33 +226,41 @@ get_console_input(const char *prompt, const bool echo, char *input, const int ca
         close(fd);
     }
 
-    if (echo)
-    {
-        FILE *fp;
+    FILE *fp = open_tty(true);
+    fprintf(fp, "%s", prompt);
+    fflush(fp);
+    close_tty(fp);
 
-        fp = open_tty(true);
-        fprintf(fp, "%s", prompt);
-        fflush(fp);
-        close_tty(fp);
+    fp = open_tty(false);
 
-        fp = open_tty(false);
-        if (fgets(input, capacity, fp) != NULL)
-        {
-            chomp(input);
-            ret = true;
-        }
-        close_tty(fp);
+    if (!echo && (tcgetattr(fileno(fp), &tty_tmp) == 0))
+    {
+        tty_save = tty_tmp;
+        tty_tmp.c_lflag &= ~(ECHO | ECHOE | ECHOK | ECHONL | ISIG);
+        restore_tty = (tcsetattr(fileno(fp), TCSAFLUSH, &tty_tmp) == 0);
     }
-    else
+
+    if (fgets(input, capacity, fp) != NULL)
+    {
+        chomp(input);
+        ret = true;
+    }
+
+    if (restore_tty)
     {
-        char *gp = getpass(prompt);
-        if (gp)
+        if (tcsetattr(fileno(fp), TCSAFLUSH, &tty_save) == -1)
         {
-            strncpynt(input, gp, capacity);
-            secure_memzero(gp, strlen(gp));
-            ret = true;
+            msg(M_WARN | M_ERRNO, "tcsetattr() failed to restore tty settings");
         }
+
+        /* Echo the non-echoed newline */
+        close_tty(fp);
+        fp = open_tty(true);
+        fprintf(fp, "\n");
+        fflush(fp);
     }
+
+    close_tty(fp);
 #else  /* if defined(_WIN32) */
     msg(M_FATAL, "Sorry, but I can't get console input on this OS (%s)", prompt);
 #endif /* if defined(_WIN32) */
-- 
2.26.2


