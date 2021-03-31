From: Arne Schwabe <arne@...1227...>
Date: Wed, 31 Mar 2021 17:55:08 +0200
Message-Id: <20210331155508.19423-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix binary and used instead auth-token
 check instead of logical and
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

AUTH_TOKEN_HMAC_OK is 1, so the first term is always 0/1 and the bool
from the second part is also 0/1, so the & does the same in this instance
as &&.

In this specific case & instead && does not change behaviour but using
&& is the intended semantic behaviour.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/auth_token.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index cc70c06c3..d571b686e 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -99,7 +99,7 @@ add_session_token_env(struct tls_session *session, struct tls_multi *multi,
     /* We had a valid session id before */
     const char *session_id_source;
     if (multi->auth_token_state_flags & AUTH_TOKEN_HMAC_OK
-        &!(multi->auth_token_state_flags & AUTH_TOKEN_EXPIRED))
+        && !(multi->auth_token_state_flags & AUTH_TOKEN_EXPIRED))
     {
         session_id_source = up->password;
     }
-- 
2.30.1


