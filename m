From: Arne Schwabe <arne@...1227...>
Date: Thu, 26 Mar 2020 18:23:31 +0100
Message-Id: <20200326172332.2356-2-arne@...1227...>
In-Reply-To: <20200326172332.2356-1-arne@...1227...>
References: <20200326172332.2356-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/3] [Auth-token] Fix session id in env
 missing first byte
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

sizeof for a constant string return the size including the null byte.
For copying the session id this meant that we do not copy the first
byte. This made the session id reported to the external authenticator
one byte shorter than it was indented to be.
---
 src/openvpn/auth_token.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 6275299d..585679dc 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -121,7 +121,7 @@ add_session_token_env(struct tls_session *session, struct tls_multi *multi,
      */
 
     char session_id[AUTH_TOKEN_SESSION_ID_LEN*2] = {0};
-    memcpy(session_id, session_id_source + sizeof(SESSION_ID_PREFIX),
+    memcpy(session_id, session_id_source + strlen(SESSION_ID_PREFIX),
            AUTH_TOKEN_SESSION_ID_LEN*8/6);
 
     setenv_str(session->opt->es, "session_id", session_id);
-- 
2.26.0


