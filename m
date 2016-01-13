From: Steffan Karger <steffan@...1856...>
Date: Wed, 13 Jan 2016 17:09:08 +0100
Message-Id: <1452701348-9577-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] socks.c: fix check on get_user_pass()
	return value(s)
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

My compiler rightfully complains that the checks on creds.username and
creds.password always evaluate to true, so remove those checks.

Judging from the code, they were meant to check the returned values by
get_user_pass().  So instead of these non-functioning checks, just check
the return value of get_user_pass().

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/socks.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 72bdf55..cef7a35 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -103,10 +103,13 @@ socks_username_password_auth (struct socks_proxy_info *p,
   ssize_t size;
 
   creds.defined = 0;
-  get_user_pass (&creds, p->authfile, UP_TYPE_SOCKS, GET_USER_PASS_MANAGEMENT);
+  if (!get_user_pass (&creds, p->authfile, UP_TYPE_SOCKS, GET_USER_PASS_MANAGEMENT))
+    {
+      msg (M_NONFATAL, "SOCKS failed to get username/password.");
+      return false;
+    }
 
-  if( !creds.username || (strlen(creds.username) > 255)
-      || !creds.password || (strlen(creds.password) > 255) ) {
+  if( (strlen(creds.username) > 255) || (strlen(creds.password) > 255) ) {
           msg (M_NONFATAL,
                "SOCKS username and/or password exceeds 255 characters.  "
                "Authentication not possible.");
-- 
2.5.0


