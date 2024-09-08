From: selva.nair@...277...
Date: Sun,  8 Sep 2024 18:42:20 -0400
Message-Id: <20240908224220.478684-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Initialize before use struct user_pass in
 ui_reader()
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

From: Selva Nair <selva.nair@...277...>

This was missed in commit 3512e8d3ad
Also add a comment to clarify how pem_password_callback is accessed
in ui_reader().

Change-Id: I82835ff8e1e31e067efd81bfb6e8cd19ee004d9c
Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/ssl_openssl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 05555a38..0d845f4a 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -776,7 +776,9 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name)
 
 #if defined(HAVE_OPENSSL_STORE_API)
 /**
- * A wrapper for pem_password_callback for use with OpenSSL UI_METHOD.
+ * A wrapper for password callback for use with OpenSSL UI_METHOD.
+ * The callback is obtained using SSL_CTX_get_default_passwd_cb()
+ * which is set to pem_password_callback() in tls_ctx_set_options().
  */
 static int
 ui_reader(UI *ui, UI_STRING *uis)
@@ -791,6 +793,7 @@ ui_reader(UI *ui, UI_STRING *uis)
         if (strstr(prompt, "PKCS#11"))
         {
             struct user_pass up;
+            CLEAR(up);
             get_user_pass(&up, NULL, "PKCS#11 token", GET_USER_PASS_MANAGEMENT|GET_USER_PASS_PASSWORD_ONLY);
             UI_set_result(ui, uis, up.password);
             purge_user_pass(&up, true);
-- 
2.40.1


