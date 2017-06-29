Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: Emmanuel Deloget <logout@...260...>
Date: Thu, 29 Jun 2017 16:21:18 +0200
Message-Id: <20170629142119.29502-1-logout@...260...>
Subject: [Openvpn-devel] [PATCH 1/2] OpenSSL: remove EVP_CIPHER_CTX_new()
 from the compat layer
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

For unknown reason, the write of the compat layer seemed to think that
this function was only present in OpenSSL 1.1. This is not the case at
all, since it has been introduced in OpenSSL before version 0.9.8.

Thus, there is no need to add this function to the compat layer, and it
can be safely removed.

Signed-off-by: Emmanuel Deloget <logout@...260...>
---
 configure.ac                 |  1 -
 src/openvpn/openssl_compat.h | 15 ---------------
 2 files changed, 16 deletions(-)

diff --git a/configure.ac b/configure.ac
index 22f91cb6..cb121795 100644
--- a/configure.ac
+++ b/configure.ac
@@ -919,7 +919,6 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 
 	AC_CHECK_FUNCS(
 		[ \
-			EVP_CIPHER_CTX_new \
 			EVP_CIPHER_CTX_free \
 			HMAC_CTX_new \
 			HMAC_CTX_free \
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 617410e0..cd25bd37 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -101,21 +101,6 @@ EVP_CIPHER_CTX_free(EVP_CIPHER_CTX *c)
 }
 #endif
 
-#if !defined(HAVE_EVP_CIPHER_CTX_NEW)
-/**
- * Allocate a new cipher context object
- *
- * @return                    A zero'ed cipher context object
- */
-static inline EVP_CIPHER_CTX *
-EVP_CIPHER_CTX_new(void)
-{
-    EVP_CIPHER_CTX *ctx = NULL;
-    ALLOC_OBJ_CLEAR(ctx, EVP_CIPHER_CTX);
-    return ctx;
-}
-#endif
-
 #if !defined(HAVE_HMAC_CTX_RESET)
 /**
  * Reset a HMAC context
-- 
2.11.0


