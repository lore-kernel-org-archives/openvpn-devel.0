From: Arne Schwabe <arne@...1227...>
Date: Thu, 26 Mar 2020 18:23:30 +0100
Message-Id: <20200326172332.2356-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/3] [Auth-token] Fix session id and initial
 timestamp not begin preserved
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

In the initial state of checking whether an auth-token has been
validated, the check check if multi->auth_token is already set and
only then sets the value. This defeats the purpose and lead to always
a new auth-token with new session id and lifetime being generated when
the server restarts or the client reconnect to another server.
---
 src/openvpn/ssl_verify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index da0966c5..226daf3d 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1381,7 +1381,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
              * to store the auth-token in multi->auth_token, so
              * the initial timestamp and session id can be extracted from it
              */
-            if (multi->auth_token && (multi->auth_token_state_flags & AUTH_TOKEN_HMAC_OK)
+            if ((multi->auth_token_state_flags & AUTH_TOKEN_HMAC_OK)
                 && !(multi->auth_token_state_flags & AUTH_TOKEN_EXPIRED))
             {
                 multi->auth_token = strdup(up->password);
-- 
2.26.0


