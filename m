From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:55:10 +0200
Message-ID: <1308909312-17824-18-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 26/28] Removed stale OpenSSL defines from
	crypto.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

---
 crypto.h         |  119 ------------------------------------------------------
 crypto_openssl.c |    2 +
 ssl.c            |    3 +
 3 files changed, 5 insertions(+), 119 deletions(-)

diff --git a/crypto.h b/crypto.h
index dd99598..24ab9fa 100644
--- a/crypto.h
+++ b/crypto.h
@@ -34,22 +34,6 @@
 
 #define ALLOW_NON_CBC_CIPHERS
 
-#include <openssl/objects.h>
-#include <openssl/rand.h>
-#include <openssl/evp.h>
-#include <openssl/hmac.h>
-#include <openssl/des.h>
-#include <openssl/md5.h>
-#if NTLM
-#include <openssl/md4.h>
-#endif
-#include <openssl/sha.h>
-#include <openssl/err.h>
-
-#if SSLEAY_VERSION_NUMBER >= 0x00907000L
-#include <openssl/des_old.h>
-#endif
-
 #include "crypto_backend.h"
 #include "basic.h"
 #include "buffer.h"
@@ -57,109 +41,6 @@
 #include "mtu.h"
 
 /*
- * Workarounds for incompatibilites between OpenSSL libraries.
- * Right now we accept OpenSSL libraries from 0.9.5 to 0.9.7.
- */
-
-#if SSLEAY_VERSION_NUMBER < 0x00907000L
-
-/* Workaround: EVP_CIPHER_mode is defined wrong in OpenSSL 0.9.6 but is fixed in 0.9.7 */
-#undef EVP_CIPHER_mode
-#define EVP_CIPHER_mode(e)                (((e)->flags) & EVP_CIPH_MODE)
-
-#define DES_cblock                        des_cblock
-#define DES_is_weak_key                   des_is_weak_key
-#define DES_check_key_parity              des_check_key_parity
-#define DES_set_odd_parity                des_set_odd_parity
-
-#define HMAC_CTX_init(ctx)                CLEAR (*ctx)
-#define HMAC_Init_ex(ctx,sec,len,md,impl) HMAC_Init(ctx, sec, len, md) 
-#define HMAC_CTX_cleanup(ctx)             HMAC_cleanup(ctx)
-#define EVP_MD_CTX_cleanup(md)            CLEAR (*md)
-
-#define INFO_CALLBACK_SSL_CONST
-
-#endif
-
-#ifndef INFO_CALLBACK_SSL_CONST
-#define INFO_CALLBACK_SSL_CONST const
-#endif
-
-#if SSLEAY_VERSION_NUMBER < 0x00906000
-
-#undef EVP_CIPHER_mode
-#define EVP_CIPHER_mode(x) 1
-#define EVP_CIPHER_CTX_mode(x) 1
-#define EVP_CIPHER_flags(x) 0
-
-#define EVP_CIPH_CBC_MODE 1
-#define EVP_CIPH_CFB_MODE 0
-#define EVP_CIPH_OFB_MODE 0
-#define EVP_CIPH_VARIABLE_LENGTH 0
-
-#define OPENSSL_malloc(x) malloc(x)
-#define OPENSSL_free(x) free(x)
-
-static inline int
-EVP_CipherInit_ov (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, uint8_t *key, uint8_t *iv, int enc)
-{
-  EVP_CipherInit (ctx, type, key, iv, enc);
-  return 1;
-}
-
-static inline int
-EVP_CipherUpdate_ov (EVP_CIPHER_CTX *ctx, uint8_t *out, int *outl, uint8_t *in, int inl)
-{
-  EVP_CipherUpdate (ctx, out, outl, in, inl);
-  return 1;
-}
-
-static inline bool
-cipher_ok (const char* name)
-{
-  const int i = strlen (name) - 4;
-  if (i >= 0)
-    return !strcmp (name + i, "-CBC");
-  else
-    return false;
-}
-
-#else
-
-static inline int
-EVP_CipherInit_ov (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, uint8_t *key, uint8_t *iv, int enc)
-{
-  return EVP_CipherInit (ctx, type, key, iv, enc);
-}
-
-static inline int
-EVP_CipherUpdate_ov (EVP_CIPHER_CTX *ctx, uint8_t *out, int *outl, uint8_t *in, int inl)
-{
-  return EVP_CipherUpdate (ctx, out, outl, in, inl);
-}
-
-static inline bool
-cipher_ok (const char* name)
-{
-  return true;
-}
-
-#endif
-
-#if SSLEAY_VERSION_NUMBER < 0x0090581f
-#undef DES_check_key_parity
-#define DES_check_key_parity(x) 1
-#endif
-
-#ifndef EVP_CIPHER_name
-#define EVP_CIPHER_name(e)		OBJ_nid2sn(EVP_CIPHER_nid(e))
-#endif
-
-#ifndef EVP_MD_name
-#define EVP_MD_name(e)			OBJ_nid2sn(EVP_MD_type(e))
-#endif
-
-/*
  * Defines a key type and key length for both cipher and HMAC.
  */
 struct key_type
diff --git a/crypto_openssl.c b/crypto_openssl.c
index 57f10ae..0981117 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -139,6 +139,8 @@ cipher_ok (const char* name)
 
 #if SSLEAY_VERSION_NUMBER < 0x0090581f
 
+#undef DES_check_key_parity
+#define DES_check_key_parity(x) 1
 #endif /* SSLEAY_VERSION_NUMBER < 0x0090581f */
 
 #ifndef EVP_CIPHER_name
diff --git a/ssl.c b/ssl.c
index 4effb49..c20f1ae 100644
--- a/ssl.c
+++ b/ssl.c
@@ -1639,6 +1639,9 @@ tls_deauthenticate (struct tls_multi *multi)
     }
 }
 
+#ifndef INFO_CALLBACK_SSL_CONST
+#define INFO_CALLBACK_SSL_CONST const
+#endif
 /*
  * Print debugging information on SSL/TLS session negotiation.
  */
-- 
1.7.4.1


