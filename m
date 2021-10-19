From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:31:16 +0200
Message-Id: <20211019183127.614175-11-arne@...1227...>
In-Reply-To: <20211019183127.614175-1-arne@...1227...>
References: <20211019183127.614175-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 10/21] [OSSL 3.0] Replace
 EVP_get_cipherbyname with EVP_CIPHER_fetch
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

In OpenSSL 3.0 EVP_get_cipherbyname return a non NULL algorithm
even if the algorithm is not avaialble with the currently available
provider. Luckily EVP_get_cipherbyname can be used here as drop
in replacement and returns only non NULL if the algorithm is actually
currently supported.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto_openssl.c |  6 +++---
 src/openvpn/openssl_compat.h | 17 +++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 93c85a836..b10bd7cd5 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -572,7 +572,7 @@ cipher_kt_get(const char *ciphername)
     ASSERT(ciphername);
 
     ciphername = translate_cipher_name_from_openvpn(ciphername);
-    cipher = EVP_get_cipherbyname(ciphername);
+    cipher = EVP_CIPHER_fetch(NULL, ciphername, NULL);
 
     if (NULL == cipher)
     {
@@ -658,7 +658,7 @@ cipher_kt_block_size(const EVP_CIPHER *cipher)
 
     strcpy(mode_str, "-CBC");
 
-    cbc_cipher = EVP_get_cipherbyname(translate_cipher_name_from_openvpn(name));
+    cbc_cipher = EVP_CIPHER_fetch(NULL,translate_cipher_name_from_openvpn(name), NULL);
     if (cbc_cipher)
     {
         block_size = EVP_CIPHER_block_size(cbc_cipher);
@@ -894,7 +894,7 @@ md_kt_get(const char *digest)
 {
     const EVP_MD *md = NULL;
     ASSERT(digest);
-    md = EVP_get_digestbyname(digest);
+    md = EVP_MD_fetch(NULL, digest, NULL);
     if (!md)
     {
         crypto_msg(M_FATAL, "Message hash algorithm '%s' not found", digest);
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index dda47d76c..0893bfbb2 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -758,6 +758,23 @@ SSL_CTX_new_ex(void *libctx, const char *propq, const SSL_METHOD *method)
     (void) propq;
     return SSL_CTX_new(method);
 }
+/* Mimics the functions but only when the default context without
+ * options is chosen */
+static inline const EVP_CIPHER *
+EVP_CIPHER_fetch(void *ctx, const char *algorithm, const char *properties)
+{
+    ASSERT(!ctx);
+    ASSERT(!properties);
+    return EVP_get_cipherbyname(algorithm);
+}
+
+static inline const EVP_MD*
+EVP_MD_fetch(void *ctx, const char *algorithm, const char *properties)
+{
+    ASSERT(!ctx);
+    ASSERT(!properties);
+    return EVP_get_digestbyname(algorithm);
+}
 #endif /* OPENSSL_VERSION_NUMBER < 0x30000000L */
 
 #endif /* OPENSSL_COMPAT_H_ */
-- 
2.33.0


