From: Wayne Davison <wayne@...2099...>
Date: Tue, 15 Dec 2015 22:16:32 +0000
Message-Id: <1450217793-17974-2-git-send-email-wayne@...2099...>
In-Reply-To: <1450217793-17974-1-git-send-email-wayne@...2099...>
References: <CAHSx_SuB8wu8_RWcfTfDhFQhrek89-Wu-pBo1FXbBNfHxRUTYg@...278...>
	<1450217793-17974-1-git-send-email-wayne@...2099...>
Subject: [Openvpn-devel] [PATCH 2/3] Move 2 prompt buffers into deeper
	blocks.
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

Two buffers used for username/password prompting can be moved into a
deeper block so that they don't get set if they are not going to be
used.
---
 src/openvpn/misc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index a9259f0..e0aa5f9 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1165,22 +1165,23 @@ get_user_pass_cr (struct user_pass *up,
 	  else
 #endif
 	    {
-	      struct buffer user_prompt = alloc_buf_gc (128, &gc);
-	      struct buffer pass_prompt = alloc_buf_gc (128, &gc);
-
-	      buf_printf (&user_prompt, "Enter %s Username:", prefix);
-	      buf_printf (&pass_prompt, "Enter %s Password:", prefix);
-
 	      if (username_from_stdin && !(flags & GET_USER_PASS_PASSWORD_ONLY))
 		{
+		  struct buffer user_prompt = alloc_buf_gc (128, &gc);
+		  buf_printf (&user_prompt, "Enter %s Username:", prefix);
 		  if (!get_console_input (BSTR (&user_prompt), true, up->username, USER_PASS_LEN))
 		    msg (M_FATAL, "ERROR: could not read %s username from stdin", prefix);
 		  if (strlen (up->username) == 0)
 		    msg (M_FATAL, "ERROR: %s username is empty", prefix);
 		}
 
-	      if (password_from_stdin && !get_console_input (BSTR (&pass_prompt), false, up->password, USER_PASS_LEN))
-		msg (M_FATAL, "ERROR: could not not read %s password from stdin", prefix);
+              if (password_from_stdin)
+                {
+		  struct buffer pass_prompt = alloc_buf_gc (128, &gc);
+		  buf_printf (&pass_prompt, "Enter %s Password:", prefix);
+		  if (!get_console_input (BSTR (&pass_prompt), false, up->password, USER_PASS_LEN))
+                    msg (M_FATAL, "ERROR: could not not read %s password from stdin", prefix);
+                }
 
 #ifdef ENABLE_CLIENT_CR
 	      if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
-- 
1.9.1


