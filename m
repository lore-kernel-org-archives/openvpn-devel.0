From: David Sommerseth <dazo@...384...>
Date: Mon, 15 Nov 2010 09:05:43 +0100
Message-Id: <1289808348-17463-3-git-send-email-dazo@...384...>
In-Reply-To: <1289808348-17463-1-git-send-email-dazo@...384...>
References: <1289808348-17463-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 1/6] Use stricter snprintf() formatting in
	socks_username_password_auth()
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

This patch makes sure that the %c parts in the string only gets 8 bits of data,
which seems to be the intension.  strlen() is used to determine the values passed
to the %c places in, but it was not taken into consideration that size_t which
strlen() returns might not be the same as int or char.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 socks.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/socks.c b/socks.c
index 58b3648..219accd 100644
--- a/socks.c
+++ b/socks.c
@@ -114,8 +114,8 @@ socks_username_password_auth (struct socks_proxy_info *p,
   creds.defined = 0;
 
   get_user_pass (&creds, p->authfile, UP_TYPE_SOCKS, GET_USER_PASS_MANAGEMENT);
-  snprintf (to_send, sizeof (to_send), "\x01%c%s%c%s", strlen(creds.username),
-            creds.username, strlen(creds.password), creds.password);
+  snprintf (to_send, sizeof (to_send), "\x01%c%s%c%s", (int) strlen(creds.username) & 0xff,
+            creds.username, (int) strlen(creds.password) & 0xff, creds.password);
   size = send (sd, to_send, strlen(to_send), MSG_NOSIGNAL);
 
   if (size != strlen (to_send))
-- 
1.7.2.3


