From: Antonio Quartulli <a@...2181...>
Date: Thu, 17 Feb 2022 17:31:59 +0100
Message-Id: <20220217163159.7936-1-a@...2181...>
In-Reply-To: <20220217143241.18766-1-a@...2181...>
References: <20220217143241.18766-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] crypto: unify key_type creation code
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
the same thing, but with different algorithms used to initialise the
structure.

In order to avoid code duplication and copy/paste errors, unify code and
make it parametric, so that it can be re-used in various places.

Signed-off-by: Antonio Quartulli <a@...2181...>

---

Changes from v1:
* added doc for optname param
Changes from v2:
* restore original helper functions and reduce their bodies to calling
  the generic create_kt(). This way users of those funcs are not harmed.
---
 src/openvpn/auth_token.c | 14 +-------------
 src/openvpn/crypto.h     | 31 +++++++++++++++++++++++++++++++
 src/openvpn/tls_crypt.c  | 17 +----------------
 3 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 10c9dde6..9a85655f 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -33,21 +33,9 @@ const char *auth_token_pem_name = "OpenVPN auth-token server key";
 static struct key_type
 auth_token_kt(void)
 {
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
+    return create_kt("none", "SHA256", "auth-gen-token");
 }
 
-
 void
 add_session_token_env(struct tls_session *session, struct tls_multi *multi,
                       const struct user_pass *up)
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 6e505517..806632ed 100644
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
+ * @param optname   the name of the option requiring the key_type object
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
 #endif /* CRYPTO_H */
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index aae2a917..88730a99 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -50,22 +50,7 @@ static const uint8_t TLS_CRYPT_METADATA_TYPE_TIMESTAMP      = 0x01;
 static struct key_type
 tls_crypt_kt(void)
 {
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
+    return create_kt("AES-256-CTR", "SHA256", "tls-crypt");
 }
 
 int
-- 
2.34.1


