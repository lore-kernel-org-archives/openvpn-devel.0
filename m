From: selva.nair@...277...
Date: Wed,  8 Feb 2017 14:25:44 -0500
Message-Id: <1486581944-29627-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Make auth-nocache cooperate with auth-token
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

From: Selva Nair <selva.nair@...277...>

- Keep the username even if auth-nocache is specified so that
  any auth_token pushed by the server could be utilized
- When auth-token is received, set nocache = false in user_pass

Note: When handling of auth failure due to token expiry is fixed, remember
to re-instate nocache after clearing the token

Trac: #840

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/misc.c | 6 ++++--
 src/openvpn/ssl.c  | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index a2f45b6..5954eea 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1490,10 +1490,12 @@ purge_user_pass(struct user_pass *up, const bool force)
 void
 set_auth_token(struct user_pass *up, const char *token)
 {
-    if (token && strlen(token) && up && up->defined && !up->nocache)
+    if (token && strlen(token) && up && strlen(up->username))
     {
-        CLEAR(up->password);
+        secure_memzero(up->password, sizeof(up->password));
         strncpynt(up->password, token, USER_PASS_LEN);
+        up->nocache = false;
+        up->defined = true;
     }
 }
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 86450fe..e25e99d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2383,7 +2383,11 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
         {
             goto error;
         }
+        /* keep username for use with any auth-token pushed by the server */
+        char username[USER_PASS_LEN];
+        strncpynt(username, auth_user_pass.username, sizeof(username));
         purge_user_pass(&auth_user_pass, false);
+        strncpynt(auth_user_pass.username, username, sizeof(auth_user_pass.username));
     }
     else
     {
-- 
2.1.4


