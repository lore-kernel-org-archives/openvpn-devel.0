From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:54:57 +0200
Message-ID: <1308909312-17824-5-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 13/28] Refactored maximum cipher and hmac
	length constants
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
 crypto.c         |   12 ------------
 crypto.h         |   24 ------------------------
 crypto_backend.h |   34 ++++++++++++++++++++++++++++++++++
 crypto_openssl.c |   12 ++++++++++++
 4 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/crypto.c b/crypto.c
index 8af5b7a..a1986e0 100644
--- a/crypto.c
+++ b/crypto.c
@@ -34,18 +34,6 @@
 #include "memdbg.h"
 
 /*
- * Check for key size creepage.
- */
-
-#if MAX_CIPHER_KEY_LENGTH < EVP_MAX_KEY_LENGTH
-#warning Some OpenSSL EVP ciphers now support key lengths greater than MAX_CIPHER_KEY_LENGTH -- consider increasing MAX_CIPHER_KEY_LENGTH
-#endif
-
-#if MAX_HMAC_KEY_LENGTH < EVP_MAX_MD_SIZE
-#warning Some OpenSSL HMAC message digests now support key lengths greater than MAX_HMAC_KEY_LENGTH -- consider increasing MAX_HMAC_KEY_LENGTH
-#endif
-
-/*
  * Encryption and Compression Routines.
  *
  * On entry, buf contains the input data and length.
diff --git a/crypto.h b/crypto.h
index f56456d..069a66f 100644
--- a/crypto.h
+++ b/crypto.h
@@ -173,29 +173,6 @@ cipher_ok (const char* name)
 #endif
 
 /*
- * Max size in bytes of any cipher key that might conceivably be used.
- *
- * This value is checked at compile time in crypto.c to make sure
- * it is always at least EVP_MAX_KEY_LENGTH.
- *
- * We define our own value, since this parameter
- * is used to control the size of static key files.
- * If the OpenSSL library increases EVP_MAX_KEY_LENGTH,
- * we don't want our key files to be suddenly rendered
- * unusable.
- */
-#define MAX_CIPHER_KEY_LENGTH 64
-
-/*
- * Max size in bytes of any HMAC key that might conceivably be used.
- *
- * This value is checked at compile time in crypto.c to make sure
- * it is always at least EVP_MAX_MD_SIZE.  We define our own value
- * for the same reason as above.
- */
-#define MAX_HMAC_KEY_LENGTH 64
-
-/*
  * Defines a key type and key length for both cipher and HMAC.
  */
 struct key_type
@@ -206,7 +183,6 @@ struct key_type
   const EVP_MD *digest;
 };
 
-
 /**
  * Container for unidirectional cipher and HMAC %key material.
  * @ingroup control_processor
diff --git a/crypto_backend.h b/crypto_backend.h
index 9f8eb04..31935ed 100644
--- a/crypto_backend.h
+++ b/crypto_backend.h
@@ -58,4 +58,38 @@
  */
 int rand_bytes (uint8_t *output, int len);
 
+/*
+ *
+ * Generic cipher key type functions
+ *
+ */
+/*
+ * Max size in bytes of any cipher key that might conceivably be used.
+ *
+ * This value is checked at compile time in crypto.c to make sure
+ * it is always at least EVP_MAX_KEY_LENGTH.
+ *
+ * We define our own value, since this parameter
+ * is used to control the size of static key files.
+ * If the OpenSSL library increases EVP_MAX_KEY_LENGTH,
+ * we don't want our key files to be suddenly rendered
+ * unusable.
+ */
+#define MAX_CIPHER_KEY_LENGTH 64
+
+/*
+ *
+ * Generic message digest information functions
+ *
+ */
+
+/*
+ * Max size in bytes of any HMAC key that might conceivably be used.
+ *
+ * This value is checked at compile time in crypto.c to make sure
+ * it is always at least EVP_MAX_MD_SIZE.  We define our own value
+ * for the same reason as above.
+ */
+#define MAX_HMAC_KEY_LENGTH 64
+
 #endif /* CRYPTO_BACKEND_H_ */
diff --git a/crypto_openssl.c b/crypto_openssl.c
index cbe559a..9e547b4 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -38,6 +38,18 @@
 #include <openssl/des.h>
 
 /*
+ * Check for key size creepage.
+ */
+
+#if MAX_CIPHER_KEY_LENGTH < EVP_MAX_KEY_LENGTH
+#warning Some OpenSSL EVP ciphers now support key lengths greater than MAX_CIPHER_KEY_LENGTH -- consider increasing MAX_CIPHER_KEY_LENGTH
+#endif
+
+#if MAX_HMAC_KEY_LENGTH < EVP_MAX_MD_SIZE
+#warning Some OpenSSL HMAC message digests now support key lengths greater than MAX_HMAC_KEY_LENGTH -- consider increasing MAX_HMAC_KEY_LENGTH
+#endif
+
+/*
  *
  * Random number functions, used in cases where we want
  * reasonably strong cryptographic random number generation
-- 
1.7.4.1


