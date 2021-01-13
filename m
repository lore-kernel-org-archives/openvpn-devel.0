MIME-Version: 1.0
From: =?UTF-8?B?VMO1aXZvIExlZWRqw6Rydg==?= <toivol@...277...>
Date: Wed, 13 Jan 2021 20:19:05 +0100
Message-ID: <CAALvpZTo6VYxcLXtXXyMsUU-n3JRSOJ-62fny7Zfi28WSDYXmA@...278...>
Subject: [Openvpn-devel] [PATCH] Stop using deprecated getpass()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

The getpass() function is present in SUSv2, but marked LEGACY. It is
removed in POSIX.1-2001. Additionally, on Solaris getpass() returns
maximum 8 bytes. This will make longer passwords fail with no
possibility for user to know what is happening.

This patch removes usage of getpass() completely and replaces it with
direct implementation of what getpass() does: opens tty (existing code),
outputs the prompt (existing code), turns off echoing (new code), reads
one line (existing code shared with echoed mode), restores tty state
(new code) and closes tty (existing code).

Signed-off-by: T=C3=B5ivo Leedj=C3=A4rv <69477666+tleedjarv@...2243...>
---
 configure.ac                  |  4 ++-
 src/openvpn/console_builtin.c | 63 +++++++++++++++++++++--------------
 2 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1ab8fe59..2c094da7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -645,7 +645,7 @@ AC_FUNC_FORK

 AC_CHECK_FUNCS([ \
        daemon chroot getpwnam setuid nice system getpid dup dup2 \
-       getpass syslog openlog mlockall getgrnam setgid \
+       syslog openlog mlockall getgrnam setgid \
        setgroups stat flock readv writev time gettimeofday \
        ctime memset vsnprintf strdup \
        setsid chdir putenv getpeername unlink \
@@ -653,6 +653,8 @@ AC_CHECK_FUNCS([ \
        epoll_create strsep \
 ])

+AC_CHECK_HEADERS([termios.h])
+
 AC_CHECK_LIB(
        [dl],
        [dlopen],
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 445928bf..f1d91b32 100644
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
@@ -138,7 +142,7 @@ get_console_input_win32(const char *prompt, const
bool echo, char *input, const
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
@@ -201,7 +205,9 @@ get_console_input(const char *prompt, const bool
echo, char *input, const int ca

 #if defined(_WIN32)
     return get_console_input_win32(prompt, echo, input, capacity);
-#elif defined(HAVE_GETPASS)
+#elif defined(HAVE_TERMIOS_H)
+    int restore_tty =3D 0;
+    struct termios tty_a, tty_save;

     /* did we --daemon'ize before asking for passwords?
      * (in which case neither stdin or stderr are connected to a tty and
@@ -220,33 +226,40 @@ get_console_input(const char *prompt, const bool
echo, char *input, const int ca
         close(fd);
     }

-    if (echo)
-    {
-        FILE *fp;
+    FILE *fp;

-        fp =3D open_tty(true);
-        fprintf(fp, "%s", prompt);
-        fflush(fp);
-        close_tty(fp);
+    fp =3D open_tty(true);
+    fprintf(fp, "%s", prompt);
+    fflush(fp);
+    close_tty(fp);

-        fp =3D open_tty(false);
-        if (fgets(input, capacity, fp) !=3D NULL)
-        {
-            chomp(input);
-            ret =3D true;
-        }
-        close_tty(fp);
+    fp =3D open_tty(false);
+
+    if (!echo && (tcgetattr(fileno(fp), &tty_a) =3D=3D 0))
+    {
+        tty_save =3D tty_a;
+        tty_a.c_lflag &=3D ~(ECHO | ECHOE | ECHOK | ECHONL | ISIG);
+        restore_tty =3D (tcsetattr(fileno(fp), TCSAFLUSH, &tty_a) =3D=3D 0=
);
     }
-    else
+
+    if (fgets(input, capacity, fp) !=3D NULL)
     {
-        char *gp =3D getpass(prompt);
-        if (gp)
-        {
-            strncpynt(input, gp, capacity);
-            secure_memzero(gp, strlen(gp));
-            ret =3D true;
-        }
+        chomp(input);
+        ret =3D true;
     }
+
+    if (!echo && restore_tty)
+    {
+        (void) tcsetattr(fileno(fp), TCSAFLUSH, &tty_save);
+
+        /* Echo the non-echoed newline */
+        close_tty(fp);
+        fp =3D open_tty(true);
+        fprintf(fp, "\n");
+        fflush(fp);
+    }
+
+    close_tty(fp);
 #else  /* if defined(_WIN32) */
     msg(M_FATAL, "Sorry, but I can't get console input on this OS
(%s)", prompt);
 #endif /* if defined(_WIN32) */
--=20
2.26.2

