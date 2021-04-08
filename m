From: Arne Schwabe <arne@...1227...>
Date: Thu,  8 Apr 2021 15:36:26 +0200
Message-Id: <20210408133626.29232-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Ensure using const variables with
 EVP_PKEY_get0_*
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

These functions return const pointers in OpenSSL 3.0.0alpha14, so
our pointers should be also const to avoid casting the const away.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_openssl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index cb8ac7727..a9bc342b0 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1248,12 +1248,11 @@ static int
 tls_ctx_use_external_rsa_key(struct tls_root_ctx *ctx, EVP_PKEY *pkey)
 {
     RSA *rsa = NULL;
-    RSA *pub_rsa;
     RSA_METHOD *rsa_meth;
 
     ASSERT(NULL != ctx);
 
-    pub_rsa = EVP_PKEY_get0_RSA(pkey);
+    const RSA *pub_rsa = EVP_PKEY_get0_RSA(pkey);
     ASSERT(NULL != pub_rsa);
 
     /* allocate custom RSA method object */
@@ -2031,7 +2030,7 @@ print_cert_details(X509 *cert, char *buf, size_t buflen)
 #ifndef OPENSSL_NO_EC
     if (typeid == EVP_PKEY_EC && EVP_PKEY_get0_EC_KEY(pkey) != NULL)
     {
-        EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
+        const EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
         const EC_GROUP *group = EC_KEY_get0_group(ec);
 
         int nid = EC_GROUP_get_curve_name(group);
-- 
2.31.1


