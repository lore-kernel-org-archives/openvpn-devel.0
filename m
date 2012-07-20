From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 20 Jul 2012 11:42:26 +0200
Message-ID: <1342777346-5062-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] query socks credentials by management
	interface
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

Support --management-query-passwords for SOCKS 5 proxies
as well.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/socks.c |   38 +++++++++++++++-----------------------
 src/openvpn/socks.h |    4 ++--
 2 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 235982e..e0ce5f7 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -72,14 +72,9 @@ socks_proxy_new (const char *server,
   ASSERT (server);
   ASSERT (legal_ipv4_port (port));
 
-  strncpynt (p->server, server, sizeof (p->server));
+  p->server = server;
   p->port = port;
-
-  if (authfile)
-    strncpynt (p->authfile, authfile, sizeof (p->authfile));
-  else
-    p->authfile[0] = 0;
-
+  p->authfile = authfile;
   p->retry = retry;
   p->defined = true;
 
@@ -107,13 +102,18 @@ socks_username_password_auth (struct socks_proxy_info *p,
   creds.defined = 0;
   get_user_pass (&creds, p->authfile, UP_TYPE_SOCKS, GET_USER_PASS_MANAGEMENT);
 
-  if( !creds.username || (strlen(creds.username) > 255)
-      || !creds.password || (strlen(creds.password) > 255) ) {
-          msg (M_NONFATAL,
-               "SOCKS username and/or password exceeds 255 characters.  "
-               "Authentication not possible.");
-          return false;
-  }
+  if (creds.username == NULL || creds.password == NULL)
+    {
+      msg (D_LINK_ERRORS, "socks_username_password_auth: "
+           "server asked for auth but no credentials were provided");
+      return false;
+    }
+  else if (strlen (creds.username) > 255 || strlen (creds.password) > 255)
+    {
+      msg (M_NONFATAL, "SOCKS username and/or password exceed 255 characters. "
+           "Authentication not possible.");
+      return false;
+    }
   openvpn_snprintf (to_send, sizeof (to_send), "\x01%c%s%c%s", (int) strlen(creds.username),
             creds.username, (int) strlen(creds.password), creds.password);
   size = send (sd, to_send, strlen(to_send), MSG_NOSIGNAL);
@@ -259,16 +259,8 @@ socks_handshake (struct socks_proxy_info *p,
       break;
 
     case 2: /* login/password */
-      if (!p->authfile[0])
-      {
-	msg(D_LINK_ERRORS, "socks_handshake: server asked for username/login auth but we were "
-	                   "not provided any credentials");
+      if (!socks_username_password_auth (p, sd, signal_received))
 	return false;
-      }
-
-      if (!socks_username_password_auth(p, sd, signal_received))
-	return false;
-
       break;
 
     default: /* unknown auth method */
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index b55ff6f..6afc8bd 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -41,9 +41,9 @@ struct socks_proxy_info {
   bool defined;
   bool retry;
 
-  char server[128];
+  const char *server;
   int port;
-  char authfile[256];
+  const char *authfile;
 };
 
 void socks_adjust_frame_parameters (struct frame *frame, int proto);
-- 
1.7.9.5


