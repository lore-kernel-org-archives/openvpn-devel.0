From: Antonio Quartulli <a@...2181...>
Date: Sun, 10 Nov 2019 14:35:23 +0100
Message-Id: <20191110133525.6069-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] auth_token_kt: ensure key_type object
 is initialized
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>

Fixes the following warning:

auth_token.c: In function 'auth_token_init_secret':
auth_token.c:47: warning: 'kt.cipher_length' is used uninitialized in this function
auth_token.c:34: note: 'kt.cipher_length' was declared here

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/auth_token.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 1edc8069..6275299d 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -31,7 +31,7 @@ const char *auth_token_pem_name = "OpenVPN auth-token server key";
 static struct key_type
 auth_token_kt(void)
 {
-    struct key_type kt;
+    struct key_type kt = { 0 };
     /* We do not encrypt our session tokens */
     kt.cipher = NULL;
     kt.digest = md_kt_get("SHA256");
-- 
2.24.0


