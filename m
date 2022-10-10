From: Gert Doering <gert@...1296...>
Date: Mon, 10 Oct 2022 09:12:29 +0200
Message-Id: <20221010071229.7935-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] TLS: do not lock empty usernames
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

We do not permit username changes on renegotiation (= username is
"locked" after successful initial authentication).

Unfortunately the way this is written this gets in the way of using
auth-user-pass-optional + pushing "auth-token-user" from client-connect
(and most likely also "from management") because we'll lock an empty
username, and on renegotiation, refuse the client with

   TLS Auth Error: username attempted to change from
            '' to 'MyTokenUser' -- tunnel disabled

Fix: extend "is username a valid pointer" to "... and points to a
     non-empty string" before locking.
---
 src/openvpn/ssl_verify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 76cb9f19..4206cf9c 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -166,7 +166,7 @@ tls_lock_username(struct tls_multi *multi, const char *username)
     }
     else
     {
-        if (username)
+        if (username && *username)
         {
             multi->locked_username = string_alloc(username, NULL);
         }
-- 
2.35.1


