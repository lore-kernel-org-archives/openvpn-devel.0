From: Selva Nair <selva.nair@...277...>
Date: Wed, 25 Nov 2015 01:34:21 -0500
Message-Id: <1448433261-13581-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Unbreak reading username-password from
	management
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

Fix a bug introduced by commit 6e9373c84639382c16d9eb8f1f78f60079bb89df

Signed-off-by: Selva Nair <selva.nair@...277...>
---
Without this, management-query-passwords is broken. After successfully
taking the username and password from management the code falls 
to the if block where it is prompted from stdin.
As authfile defaults stdin, the read-from-stdin block should be 
in an else clause as in the previous version. Oh boy, those
if-else blocks are too long and far too many..

 src/openvpn/misc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index b6c8854..1ff4e1a 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1106,7 +1106,7 @@ get_user_pass_cr (struct user_pass *up,
       /*
        * Get username/password from standard input?
        */
-      if (username_from_stdin || password_from_stdin)
+      else if (username_from_stdin || password_from_stdin)
 	{
 #ifndef WIN32
 	  /* did we --daemon'ize before asking for passwords? */
-- 
1.7.10.4


