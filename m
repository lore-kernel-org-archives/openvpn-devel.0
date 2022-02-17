From: Antonio Quartulli <a@...2181...>
Date: Thu, 17 Feb 2022 15:23:06 +0100
Message-Id: <20220217142306.8108-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] crypto: unify key_type creation code
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
Cc: Antonio Quartulli <a@...2181...>

At the moment we have tls_crypt_kt() and auth_token_kt that basically do
the same thing, but with different algorithms used to inizialise the
structure.

In order to avoid code duplication and copy/paste errors, unify code and
make it parametric, so that it can be re-used in various places.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/auth_token.c | 20 +-------------------
 src/openvpn/crypto.h     | 31 +++++++++++++++++++++++++++++++
 src/openvpn/tls_crypt.c  | 27 +++------------------------
 3 files changed, 35 insertions(+), 43 deletions(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 10c9dde6..6aae73c9 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -30,24 +30,6 @@ const char *auth_token_pem_name = "OpenVPN auth-token server key";
 /* Size of the data of the token (not b64 encoded and without prefix) */
 #define TOKEN_DATA_LEN (2 * sizeof(int64_t) + AUTH_TOKEN_SESSION_ID_LEN + 32)
 
-static struct key_type
-auth_token_kt(void)
-{
-    struct key_type kt = { 0 };
-    /* We do not encrypt our session tokens */
-    kt.cipher = "none";
-    kt.digest = "SHA256";
-
-    if (!md_valid(kt.digest))
-    {
-        msg(M_WARN, "ERROR: --tls-crypt requires HMAC-SHA-256 support.");
-        return (struct key_type) { 0 };
-    }
-
-    return kt;
-}
-
-
 void
 add_session_token_env(struct tls_session *session, struct tls_multi *multi,
                       const struct user_pass *up)
@@ -138,7 +120,7 @@ void
 auth_token_init_secret(struct key_ctx *key_ctx, const char *key_file,
                        bool key_inline)
 {
-    struct key_type kt = auth_token_kt();
+    struct key_type kt = create_kt("none", "SHA256", "auth-gen-token");
 
     struct buffer server_secret_key = alloc_buf(2048);
 
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 6e505517..734b696c 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -547,4 +547,35 @@ key_ctx_bi_defined(const struct key_ctx_bi *key)
  */
 const char *print_key_filename(const char *str, bool is_inline);
 
+/**
+ * Creates and validates an instance of struct key_type with the provided
+ * algs.
+ *
+ * @param cipher    the cipher algorithm to use (must be a string literal)
+ * @param md        the digest algorithm to use (must be a string literal)
+ *
+ * @return          the initialized key_type instance
+ */
+static inline struct key_type
+create_kt(const char *cipher, const char *md, const char *optname)
+{
+    struct key_type kt;
+    kt.cipher = cipher;
+    kt.digest = md;
+
+    if (cipher_defined(kt.cipher) && !cipher_valid(kt.cipher))
+    {
+        msg(M_WARN, "ERROR: --%s requires %s support.", optname, kt.cipher);
+        return (struct key_type) { 0 };
+    }
+    if (md_defined(kt.digest) && !md_valid(kt.digest))
+    {
+        msg(M_WARN, "ERROR: --%s requires %s support.", optname, kt.digest);
+        return (struct key_type) { 0 };
+    }
+
+    return kt;
+}
+
+
 #endif /* CRYPTO_H */
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index aae2a917..99e85010 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -47,27 +47,6 @@ static const uint8_t TLS_CRYPT_METADATA_TYPE_USER           = 0x00;
 /** Metadata contains a 64-bit unix timestamp in network byte order */
 static const uint8_t TLS_CRYPT_METADATA_TYPE_TIMESTAMP      = 0x01;
 
-static struct key_type
-tls_crypt_kt(void)
-{
-    struct key_type kt;
-    kt.cipher = "AES-256-CTR";
-    kt.digest = "SHA256";
-
-    if (!cipher_valid(kt.cipher))
-    {
-        msg(M_WARN, "ERROR: --tls-crypt requires AES-256-CTR support.");
-        return (struct key_type) { 0 };
-    }
-    if (!md_valid(kt.digest))
-    {
-        msg(M_WARN, "ERROR: --tls-crypt requires HMAC-SHA-256 support.");
-        return (struct key_type) { 0 };
-    }
-
-    return kt;
-}
-
 int
 tls_crypt_buf_overhead(void)
 {
@@ -80,7 +59,7 @@ tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
 {
     const int key_direction = tls_server ?
                               KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVERSE;
-    struct key_type kt = tls_crypt_kt();
+    struct key_type kt = create_kt("AES-256-CTR", "SHA256", "tls-crypt");
     if (!kt.cipher || !kt.digest)
     {
         msg(M_FATAL, "ERROR: --tls-crypt not supported");
@@ -271,7 +250,7 @@ tls_crypt_v2_load_client_key(struct key_ctx_bi *key, const struct key2 *key2,
 {
     const int key_direction = tls_server ?
                               KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVERSE;
-    struct key_type kt = tls_crypt_kt();
+    struct key_type kt = create_kt("AES-256-CTR", "SHA256", "tls-crypt");
     if (!kt.cipher || !kt.digest)
     {
         msg(M_FATAL, "ERROR: --tls-crypt-v2 not supported");
@@ -319,7 +298,7 @@ tls_crypt_v2_init_server_key(struct key_ctx *key_ctx, bool encrypt,
         msg(M_FATAL, "ERROR: invalid tls-crypt-v2 server key format");
     }
 
-    struct key_type kt = tls_crypt_kt();
+    struct key_type kt = create_kt("AES-256-CTR", "SHA256", "tls-crypt");
     if (!kt.cipher || !kt.digest)
     {
         msg(M_FATAL, "ERROR: --tls-crypt-v2 not supported");
-- 
2.34.1


