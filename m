From: David Sommerseth <dazo@...384...>
Date: Mon, 15 Nov 2010 21:50:46 +0100
Message-Id: <1289854246-16196-1-git-send-email-dazo@...384...>
In-Reply-To: <4CE1949C.6010707@...1114...>
References: <4CE1949C.6010707@...1114...>
Subject: [Openvpn-devel] [PATCH] Use stricter snprintf() formatting in
	socks_username_password_auth() (v2)
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
Cc: David Sommerseth <dazo@...384...>

commit fc1fa9ffc7e3356458ec3 added a new function which needs to have a
stricter string formatting.  This was detected due to a compiler warning.

This patch makes sure that the length of username and password is not longer
than 255 bytes.  It also adds extra checks to avoid NULL pointer issues with
strlen() on these two parameters.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 socks.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/socks.c b/socks.c
index 58b3648..b48701d 100644
--- a/socks.c
+++ b/socks.c
@@ -112,10 +112,17 @@ socks_username_password_auth (struct socks_proxy_info *p,
   ssize_t size;
 
   creds.defined = 0;
-
   get_user_pass (&creds, p->authfile, UP_TYPE_SOCKS, GET_USER_PASS_MANAGEMENT);
-  snprintf (to_send, sizeof (to_send), "\x01%c%s%c%s", strlen(creds.username),
-            creds.username, strlen(creds.password), creds.password);
+
+  if( !creds.username || (strlen(creds.username) > 255)
+      || !creds.password || (strlen(creds.password) > 255) ) {
+          msg (M_NONFATAL,
+               "socks username and/or password exceeds 255 characters.  "
+               "Authentiaction not possible.");
+          return false;
+  }
+  snprintf (to_send, sizeof (to_send), "\x01%c%s%c%s", (int) strlen(creds.username),
+            creds.username, (int) strlen(creds.password), creds.password);
   size = send (sd, to_send, strlen(to_send), MSG_NOSIGNAL);
 
   if (size != strlen (to_send))
-- 
1.7.2.3


