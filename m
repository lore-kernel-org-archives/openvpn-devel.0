From: David Sommerseth <davids@...515...>
Date: Sat, 28 Sep 2019 00:45:35 +0200
Message-Id: <20190927224536.27480-3-davids@...515...>
In-Reply-To: <20190927224536.27480-1-davids@...515...>
References: <20190927224536.27480-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] auth-token: Fix compiler complaints
 with --disable-management
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

When building with --disable-management, the compiler complains with
implicit declaration of function ‘ssl_clean_auth_token’.  This is due to
the ssl_clean_auth_token() function being declared inside an #ifdef
ENABLE_MANAGEMENT fence where it should not be.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/ssl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index e98c54c7..a944ca3a 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -431,6 +431,8 @@ void ssl_purge_auth(const bool auth_user_pass_only);
 
 void ssl_set_auth_token(const char *token);
 
+bool ssl_clean_auth_token(void);
+
 #ifdef ENABLE_MANAGEMENT
 /*
  * ssl_get_auth_challenge will parse the server-pushed auth-failed
@@ -439,8 +441,6 @@ void ssl_set_auth_token(const char *token);
  */
 void ssl_purge_auth_challenge(void);
 
-bool ssl_clean_auth_token(void);
-
 void ssl_put_auth_challenge(const char *cr_str);
 
 #endif
-- 
2.17.1


