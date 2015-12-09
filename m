From: Gert Doering <gert@...1296...>
Date: Wed,  9 Dec 2015 21:03:55 +0100
Message-Id: <1449691435-5928-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix isatty() check for good.
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

Commit 079e5b9c13 introduced a check to see if we --daemon'ized before
trying to ask for a password (which would then fail with a non-intuitive
error), breaking querying systemd under certain conditions.

Move check from get_user_pass_cr() to get_console_input() and make it
"full featured" by not only checking isatty() for stdin/stderr but also
trying to open /dev/tty in case we still have a controlling tty - which
is what getpass() does under the hood, so if either of this works, we're
fine.

Trac #618 and #630

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/console.c | 13 +++++++++++++
 src/openvpn/misc.c    |  6 ------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index d66d408..e1d46c4 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -208,6 +208,19 @@ get_console_input (const char *prompt, const bool echo, char *input, const int c
 #if defined(WIN32)
   return get_console_input_win32 (prompt, echo, input, capacity);
 #elif defined(HAVE_GETPASS)
+
+  /* did we --daemon'ize before asking for passwords?
+   * (in which case neither stdin or stderr are connected to a tty and
+   * /dev/tty can not be open()ed anymore)
+   */
+  if ( !isatty(0) && !isatty(2) )
+    {
+      int fd = open( "/dev/tty", O_RDWR );
+      if ( fd < 0 )
+	{ msg(M_FATAL, "neither stdin nor stderr are a tty device and you have neither a controlling tty nor systemd - can't ask for '%s'.  If you used --daemon, you need to use --askpass to make passphrase-protected keys work, and you can not use --auth-nocache.", prompt ); }
+      close(fd);
+    }
+
   if (echo)
     {
       FILE *fp;
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 5713d2e..bc411bf 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1137,12 +1137,6 @@ get_user_pass_cr (struct user_pass *up,
        */
       if (username_from_stdin || password_from_stdin)
 	{
-#ifndef WIN32
-	  /* did we --daemon'ize before asking for passwords? */
-	  if ( !isatty(0) && !isatty(2) )
-	    { msg(M_FATAL, "neither stdin nor stderr are a tty device, can't ask for %s password.  If you used --daemon, you need to use --askpass to make passphrase-protected keys work, and you can not use --auth-nocache.", prefix ); }
-#endif
-
 #ifdef ENABLE_CLIENT_CR
 	  if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE))
 	    {
-- 
2.4.9


