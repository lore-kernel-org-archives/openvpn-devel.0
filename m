From: Wayne Davison <wayne@...2099...>
Date: Tue, 15 Dec 2015 22:16:31 +0000
Message-Id: <1450217793-17974-1-git-send-email-wayne@...2099...>
In-Reply-To: <CAHSx_SuB8wu8_RWcfTfDhFQhrek89-Wu-pBo1FXbBNfHxRUTYg@...278...>
References: <CAHSx_SuB8wu8_RWcfTfDhFQhrek89-Wu-pBo1FXbBNfHxRUTYg@...278...>
Subject: [Openvpn-devel] [PATCH 1/3] Fix CR prompting when user & pass are
	read from a file.
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

The code that reads the challenge response (both dynamic & static) will
not prompt the user if the username and password information was read
from a file.  In the latest code this can be fixed by simply removing
the "if (username_from_stdin || password_from_stdin)" condition because
all the deeper code is already conditionalized adequately to only prompt
for the missing information.

NOTE: indentation left too deep so that changes are clearly seen.
---
 src/openvpn/misc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 05ed073..a9259f0 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1141,8 +1141,6 @@ get_user_pass_cr (struct user_pass *up,
       /*
        * Get username/password from standard input?
        */
-      if (username_from_stdin || password_from_stdin)
-	{
 #ifdef ENABLE_CLIENT_CR
 	  if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE))
 	    {
@@ -1206,7 +1204,6 @@ get_user_pass_cr (struct user_pass *up,
 		}
 #endif
 	    }
-	}
 
       string_mod (up->username, CC_PRINT, CC_CRLF, 0);
       string_mod (up->password, CC_PRINT, CC_CRLF, 0);
-- 
1.9.1


