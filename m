Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: logout@...260...
Date: Fri, 17 Feb 2017 23:00:49 +0100
Message-Id: <cce237dbf3716cc6b2d7c47da9e750365925bc62.1487368114.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
Subject: [Openvpn-devel] [RFC PATCH v1 10/15] OpenSSL: don't use direct
	access to the internal of EVP_MD_CTX
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

From: Emmanuel Deloget <logout@...260...>

OpenSSL 1.1 does not allow us to directly access the internal of
any data type, including EVP_MD_CTX. We have to use the defined
functions to do so.

Compatibility with OpenSSL 1.0 is kept by defining the corresponding
functions when they are not found in the library.

Signed-off-by: Emmanuel Deloget <logout@...260...>
---
 configure.ac                 |  3 ++
 src/openvpn/crypto_backend.h | 14 ++++++++
 src/openvpn/crypto_mbedtls.c | 12 +++++++
 src/openvpn/crypto_openssl.c | 18 ++++++++--
 src/openvpn/httpdigest.c     | 78 +++++++++++++++++++++++---------------------
 src/openvpn/misc.c           | 14 ++++----
 src/openvpn/openssl_compat.h | 50 ++++++++++++++++++++++++++++
 src/openvpn/openvpn.h        |  2 +-
 src/openvpn/push.c           | 11 ++++---
 9 files changed, 150 insertions(+), 52 deletions(-)

diff --git a/configure.ac b/configure.ac
index 3f59ba051692fa40304a203355c82812ca0962e8..c7e9df5e3ef3f3740f2db79fef6d5c1587c47800 100644
--- a/configure.ac
+++ b/configure.ac
@@ -900,6 +900,9 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 
 	AC_CHECK_FUNCS(
 		[ \
+			EVP_MD_CTX_new \
+			EVP_MD_CTX_free \
+			EVP_MD_CTX_reset \
 			SSL_CTX_get_default_passwd_cb \
 			SSL_CTX_get_default_passwd_cb_userdata \
 			X509_get0_pubkey \
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 2c79baa15c2021d679e1bddf269f4662e1686e5f..9b35cdaaf5a5f6c9f2b6af766fbb1b439db4c58f 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -502,6 +502,20 @@ int md_kt_size(const md_kt_t *kt);
 int md_full(const md_kt_t *kt, const uint8_t *src, int src_len, uint8_t *dst);
 
 /*
+ * Allocate a new message digest context
+ *
+ * @return              a new zeroed MD context
+ */
+md_ctx_t *md_ctx_new(void);
+
+/*
+ * Free an existing, non-null message digest context
+ *
+ * @param ctx           Message digest context
+ */
+void md_ctx_free(md_ctx_t *ctx);
+
+/*
  * Initialises the given message digest context.
  *
  * @param ctx           Message digest context
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 942684ce03f62761bee538ec1abf53e958218ad1..d67415233cd4f7d7b75a43ac30ad864458b75b47 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -766,6 +766,18 @@ md_full(const md_kt_t *kt, const uint8_t *src, int src_len, uint8_t *dst)
     return 0 == mbedtls_md(kt, src, src_len, dst);
 }
 
+mbedtls_md_context_t *
+md_ctx_new(void)
+{
+    mbedtls_md_context_t *ctx;
+    ALLOC_OBJ_CLEAR(ctx, mbedtls_md_context_t);
+    return ctx;
+}
+
+void md_ctx_free(mbedtls_md_context_t *ctx)
+{
+    free(ctx);
+}
 
 void
 md_ctx_init(mbedtls_md_context_t *ctx, const mbedtls_md_info_t *kt)
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index e4557156106ae099ea07979a3dcc656995659502..da3abfb7ef30fe23d7b47cd398c5cbdf61a9718b 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -42,6 +42,7 @@
 #include "integer.h"
 #include "crypto.h"
 #include "crypto_backend.h"
+#include "openssl_compat.h"
 
 #include <openssl/des.h>
 #include <openssl/err.h>
@@ -846,13 +847,24 @@ md_full(const EVP_MD *kt, const uint8_t *src, int src_len, uint8_t *dst)
     return EVP_Digest(src, src_len, dst, &in_md_len, kt, NULL);
 }
 
+EVP_MD_CTX *
+md_ctx_new(void)
+{
+    EVP_MD_CTX *ctx = EVP_MD_CTX_new();
+    check_malloc_return(ctx);
+    return ctx;
+}
+
+void md_ctx_free(EVP_MD_CTX *ctx)
+{
+    EVP_MD_CTX_free(ctx);
+}
+
 void
 md_ctx_init(EVP_MD_CTX *ctx, const EVP_MD *kt)
 {
     ASSERT(NULL != ctx && NULL != kt);
 
-    CLEAR(*ctx);
-
     EVP_MD_CTX_init(ctx);
     EVP_DigestInit(ctx, kt);
 }
@@ -860,7 +872,7 @@ md_ctx_init(EVP_MD_CTX *ctx, const EVP_MD *kt)
 void
 md_ctx_cleanup(EVP_MD_CTX *ctx)
 {
-    EVP_MD_CTX_cleanup(ctx);
+    EVP_MD_CTX_reset(ctx);
 }
 
 int
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index ae4a638fbf9f1307a7e91da02c42edff95cc9307..2a66d9b8470d205e242463b55c0f549fd766d6f4 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -81,27 +81,28 @@ DigestCalcHA1(
     )
 {
     HASH HA1;
-    md_ctx_t md5_ctx;
+    md_ctx_t *md5_ctx = md_ctx_new();
     const md_kt_t *md5_kt = md_kt_get("MD5");
 
-    md_ctx_init(&md5_ctx, md5_kt);
-    md_ctx_update(&md5_ctx, (const uint8_t *) pszUserName, strlen(pszUserName));
-    md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
-    md_ctx_update(&md5_ctx, (const uint8_t *) pszRealm, strlen(pszRealm));
-    md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
-    md_ctx_update(&md5_ctx, (const uint8_t *) pszPassword, strlen(pszPassword));
-    md_ctx_final(&md5_ctx, HA1);
+    md_ctx_init(md5_ctx, md5_kt);
+    md_ctx_update(md5_ctx, (const uint8_t *) pszUserName, strlen(pszUserName));
+    md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
+    md_ctx_update(md5_ctx, (const uint8_t *) pszRealm, strlen(pszRealm));
+    md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
+    md_ctx_update(md5_ctx, (const uint8_t *) pszPassword, strlen(pszPassword));
+    md_ctx_final(md5_ctx, HA1);
     if (pszAlg && strcasecmp(pszAlg, "md5-sess") == 0)
     {
-        md_ctx_init(&md5_ctx, md5_kt);
-        md_ctx_update(&md5_ctx, HA1, HASHLEN);
-        md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
-        md_ctx_update(&md5_ctx, (const uint8_t *) pszNonce, strlen(pszNonce));
-        md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
-        md_ctx_update(&md5_ctx, (const uint8_t *) pszCNonce, strlen(pszCNonce));
-        md_ctx_final(&md5_ctx, HA1);
+        md_ctx_init(md5_ctx, md5_kt);
+        md_ctx_update(md5_ctx, HA1, HASHLEN);
+        md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
+        md_ctx_update(md5_ctx, (const uint8_t *) pszNonce, strlen(pszNonce));
+        md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
+        md_ctx_update(md5_ctx, (const uint8_t *) pszCNonce, strlen(pszCNonce));
+        md_ctx_final(md5_ctx, HA1);
     }
-    md_ctx_cleanup(&md5_ctx);
+    md_ctx_cleanup(md5_ctx);
+    md_ctx_free(md5_ctx);
     CvtHex(HA1, SessionKey);
 }
 
@@ -123,40 +124,41 @@ DigestCalcResponse(
     HASH RespHash;
     HASHHEX HA2Hex;
 
-    md_ctx_t md5_ctx;
+    md_ctx_t *md5_ctx = md_ctx_new();
     const md_kt_t *md5_kt = md_kt_get("MD5");
 
     /* calculate H(A2) */
-    md_ctx_init(&md5_ctx, md5_kt);
-    md_ctx_update(&md5_ctx, (const uint8_t *) pszMethod, strlen(pszMethod));
-    md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
-    md_ctx_update(&md5_ctx, (const uint8_t *) pszDigestUri, strlen(pszDigestUri));
+    md_ctx_init(md5_ctx, md5_kt);
+    md_ctx_update(md5_ctx, (const uint8_t *) pszMethod, strlen(pszMethod));
+    md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
+    md_ctx_update(md5_ctx, (const uint8_t *) pszDigestUri, strlen(pszDigestUri));
     if (strcasecmp(pszQop, "auth-int") == 0)
     {
-        md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
-        md_ctx_update(&md5_ctx, HEntity, HASHHEXLEN);
+        md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
+        md_ctx_update(md5_ctx, HEntity, HASHHEXLEN);
     }
-    md_ctx_final(&md5_ctx, HA2);
+    md_ctx_final(md5_ctx, HA2);
     CvtHex(HA2, HA2Hex);
 
     /* calculate response */
-    md_ctx_init(&md5_ctx, md5_kt);
-    md_ctx_update(&md5_ctx, HA1, HASHHEXLEN);
-    md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
-    md_ctx_update(&md5_ctx, (const uint8_t *) pszNonce, strlen(pszNonce));
-    md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
+    md_ctx_init(md5_ctx, md5_kt);
+    md_ctx_update(md5_ctx, HA1, HASHHEXLEN);
+    md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
+    md_ctx_update(md5_ctx, (const uint8_t *) pszNonce, strlen(pszNonce));
+    md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
     if (*pszQop)
     {
-        md_ctx_update(&md5_ctx, (const uint8_t *) pszNonceCount, strlen(pszNonceCount));
-        md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
-        md_ctx_update(&md5_ctx, (const uint8_t *) pszCNonce, strlen(pszCNonce));
-        md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
-        md_ctx_update(&md5_ctx, (const uint8_t *) pszQop, strlen(pszQop));
-        md_ctx_update(&md5_ctx, (const uint8_t *) ":", 1);
+        md_ctx_update(md5_ctx, (const uint8_t *) pszNonceCount, strlen(pszNonceCount));
+        md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
+        md_ctx_update(md5_ctx, (const uint8_t *) pszCNonce, strlen(pszCNonce));
+        md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
+        md_ctx_update(md5_ctx, (const uint8_t *) pszQop, strlen(pszQop));
+        md_ctx_update(md5_ctx, (const uint8_t *) ":", 1);
     }
-    md_ctx_update(&md5_ctx, HA2Hex, HASHHEXLEN);
-    md_ctx_final(&md5_ctx, RespHash);
-    md_ctx_cleanup(&md5_ctx);
+    md_ctx_update(md5_ctx, HA2Hex, HASHHEXLEN);
+    md_ctx_final(md5_ctx, RespHash);
+    md_ctx_cleanup(md5_ctx);
+    md_ctx_free(md5_ctx);
     CvtHex(RespHash, Response);
 }
 
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index a2f45b61c1aa1dd279fddaf5031fc2bc9aa82145..0c422dd128a6f01f04b0943f86ed4648c4cb2576 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1439,7 +1439,7 @@ get_user_pass_auto_userid(struct user_pass *up, const char *tag)
     static const uint8_t hashprefix[] = "AUTO_USERID_DIGEST";
 
     const md_kt_t *md5_kt = md_kt_get("MD5");
-    md_ctx_t ctx;
+    md_ctx_t *ctx;
 
     CLEAR(*up);
     buf_set_write(&buf, (uint8_t *)up->username, USER_PASS_LEN);
@@ -1447,11 +1447,13 @@ get_user_pass_auto_userid(struct user_pass *up, const char *tag)
     if (get_default_gateway_mac_addr(macaddr))
     {
         dmsg(D_AUTO_USERID, "GUPAU: macaddr=%s", format_hex_ex(macaddr, sizeof(macaddr), 0, 1, ":", &gc));
-        md_ctx_init(&ctx, md5_kt);
-        md_ctx_update(&ctx, hashprefix, sizeof(hashprefix) - 1);
-        md_ctx_update(&ctx, macaddr, sizeof(macaddr));
-        md_ctx_final(&ctx, digest);
-        md_ctx_cleanup(&ctx)
+        ctx = md_ctx_new();
+        md_ctx_init(ctx, md5_kt);
+        md_ctx_update(ctx, hashprefix, sizeof(hashprefix) - 1);
+        md_ctx_update(ctx, macaddr, sizeof(macaddr));
+        md_ctx_final(ctx, digest);
+        md_ctx_cleanup(ctx);
+        md_ctx_free(ctx);
         buf_printf(&buf, "%s", format_hex_ex(digest, sizeof(digest), 0, 256, " ", &gc));
     }
     else
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index d4f16e4a2ce485d80ad82ca1ef677cf6c4c4ebf7..3be0f4a5abe913e5b67115b86f840a4d107f9c56 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -46,6 +46,56 @@
 #include <openssl/ssl.h>
 #include <openssl/x509.h>
 
+#include <openssl/des.h>
+#include <openssl/err.h>
+#include <openssl/evp.h>
+#include <openssl/objects.h>
+#include <openssl/rand.h>
+#include <openssl/ssl.h>
+
+#if !defined(HAVE_EVP_MD_CTX_RESET)
+/**
+ * Reset a message digest context
+ *
+ * @param ctx                 The message digest context
+ * @return                    1 on success, 0 on error
+ */
+static inline int
+EVP_MD_CTX_reset(EVP_MD_CTX *ctx)
+{
+    EVP_MD_CTX_cleanup(ctx);
+    return 1;
+}
+#endif
+
+#if !defined(HAVE_EVP_MD_CTX_FREE)
+/**
+ * Free an existing message digest context
+ *
+ * @param ctx                 The message digest context
+ */
+static inline void
+EVP_MD_CTX_free(EVP_MD_CTX *ctx)
+{
+    free(ctx);
+}
+#endif
+
+#if !defined(HAVE_EVP_MD_CTX_NEW)
+/**
+ * Allocate a new message digest object
+ *
+ * @return                    A zero'ed message digest object
+ */
+static inline EVP_MD_CTX *
+EVP_MD_CTX_new(void)
+{
+    EVP_MD_CTX *ctx = NULL;
+    ALLOC_OBJ_CLEAR(ctx, EVP_MD_CTX);
+    return ctx;
+}
+#endif
+
 #if !defined(HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA)
 /**
  * Fetch the default password callback user data from the SSL context
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 893296edc539800db6463b5861e6f7c83cbac115..e6cea506e37f987c8dffcef33033556d6f2c37ee 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -472,7 +472,7 @@ struct context_2
 
     /* hash of pulled options, so we can compare when options change */
     bool pulled_options_digest_init_done;
-    md_ctx_t pulled_options_state;
+    md_ctx_t *pulled_options_state;
     struct sha256_digest pulled_options_digest;
 
     struct event_timeout scheduled_exit;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 8c3104ed7690cdf24463c1d610cecf955d744cf4..7479f7c2f925dd2f74011c73e283a4421ed60bf6 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -722,7 +722,8 @@ process_incoming_push_msg(struct context *c,
             struct buffer buf_orig = buf;
             if (!c->c2.pulled_options_digest_init_done)
             {
-                md_ctx_init(&c->c2.pulled_options_state, md_kt_get("SHA256"));
+                c->c2.pulled_options_state = md_ctx_new();
+                md_ctx_init(c->c2.pulled_options_state, md_kt_get("SHA256"));
                 c->c2.pulled_options_digest_init_done = true;
             }
             if (!c->c2.did_pre_pull_restore)
@@ -736,14 +737,16 @@ process_incoming_push_msg(struct context *c,
                                    option_types_found,
                                    c->c2.es))
             {
-                push_update_digest(&c->c2.pulled_options_state, &buf_orig,
+                push_update_digest(c->c2.pulled_options_state, &buf_orig,
                                    &c->options);
                 switch (c->options.push_continuation)
                 {
                     case 0:
                     case 1:
-                        md_ctx_final(&c->c2.pulled_options_state, c->c2.pulled_options_digest.digest);
-                        md_ctx_cleanup(&c->c2.pulled_options_state);
+                        md_ctx_final(c->c2.pulled_options_state, c->c2.pulled_options_digest.digest);
+                        md_ctx_cleanup(c->c2.pulled_options_state);
+                        md_ctx_free(c->c2.pulled_options_state);
+                        c->c2.pulled_options_state = NULL;
                         c->c2.pulled_options_digest_init_done = false;
                         ret = PUSH_MSG_REPLY;
                         break;
-- 
2.7.4


