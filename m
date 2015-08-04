From: Gert Doering <gert@...1296...>
Date: Tue,  4 Aug 2015 14:53:16 +0200
Message-Id: <1438692796-14663-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Un-break --auth-user-pass on windows
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

Commit b131c7b974d9d4d3f0 introduced a check to create a meaningful
warning if we try to read a password after daemon()izing (by checking
whether stdin or stderr is connected to a tty).  For some reason this
breaks on Windows builds if run under GUI control - but since Windows
doesn't have this particular daemon() issue anyway, just #ifndef WIN32
the offending code.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/misc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 21e54b4..f20d059 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1088,9 +1088,11 @@ get_user_pass_cr (struct user_pass *up,
        */
       else if (from_stdin)
 	{
+#ifndef WIN32
 	  /* did we --daemon'ize before asking for passwords? */
 	  if ( !isatty(0) && !isatty(2) )
 	    { msg(M_FATAL, "neither stdin nor stderr are a tty device, can't ask for %s password.  If you used --daemon, you need to use --askpass to make passphrase-protected keys work, and you can not use --auth-nocache.", prefix ); }
+#endif
 
 #ifdef ENABLE_CLIENT_CR
 	  if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE))
-- 
2.3.6


