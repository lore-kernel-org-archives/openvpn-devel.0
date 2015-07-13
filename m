From: Gert Doering <gert@...1296...>
Date: Mon, 13 Jul 2015 21:10:07 +0200
Message-Id: <1436814607-16707-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Produce a meaningful error message if
	--daemon gets in the way of asking for passwords.
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

With the --daemon / SSL init reordering in da9b292733, we fail if we
daemonize first and then try to ask for a private key passphrase (or,
for that matter, username+password if --auth-nocache is set) - but
no meaningful error message was printed, instead depending on operating
system and library versions, either we looped around "ssl init failed"
or died with an unspecified "fatal error".

So: check if get_user_pass_cr() is called in a context that needs
"from_stdin", but both stdin and stderr are not connected to a tty
device (which getpass() needs).  In that case, print a meaningful
error message pointing to --askpass, and die.

Trac #574 and #576

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/misc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 4fdbf17..c4438b6 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1056,6 +1056,10 @@ get_user_pass_cr (struct user_pass *up,
        */
       else if (from_stdin)
 	{
+	  /* did we --daemon'ize before asking for passwords? */
+	  if ( !isatty(0) && !isatty(2) )
+	    { msg(M_FATAL, "neither stdin nor stderr are a tty device, can't ask for %s password.  If you used --daemon, you need to use --askpass to make passphrase-protected keys work, and you can not use --auth-nocache.", prefix ); }
+
 #ifdef ENABLE_CLIENT_CR
 	  if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE))
 	    {
-- 
2.3.2


