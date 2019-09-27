From: David Sommerseth <davids@...515...>
Date: Sat, 28 Sep 2019 00:45:36 +0200
Message-Id: <20190927224536.27480-4-davids@...515...>
In-Reply-To: <20190927224536.27480-1-davids@...515...>
References: <20190927224536.27480-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH 3/3] Improve the comments related to
 auth-token-hmac patches
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

A couple of places the documentation was not clear enough or not even
correct.  Just improve this to avoid confusion later on.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/auth_token.h | 2 --
 src/openvpn/ssl_common.h | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
index c10afde9..4b014d44 100644
--- a/src/openvpn/auth_token.h
+++ b/src/openvpn/auth_token.h
@@ -61,8 +61,6 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi);
  * Verifies the auth token to be in the format that generate_auth_token
  * create and checks if the token is valid.
  *
- * Also calls generate_auth_token to update the auth-token to extend
- * its validity
  */
 unsigned
 verify_auth_token(struct user_pass *up, struct tls_multi *multi,
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 5e21009e..8dd08862 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -559,7 +559,7 @@ struct tls_multi
      * Auth-token is only valid for an empty username
      * and not the username actually supplied from the client
      *
-     * OpenVPN 3 clients sometimes the empty username with a
+     * OpenVPN 3 clients sometimes wipes or replaces the username with a
      * username hint from their config.
      */
     int auth_token_state_flags;
-- 
2.17.1


