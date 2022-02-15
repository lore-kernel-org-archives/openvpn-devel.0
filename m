From: Antonio Quartulli <a@...2181...>
Date: Tue, 15 Feb 2022 13:31:57 +0100
Message-Id: <20220215123157.10615-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] auth_token/tls_crypt: fix usage of
 md_valid()
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>, Richard T Bonhomme <tincantech@...2282...>

With b39725cf ("Remove md_kt_t and change crypto API to use const char*")
the logic for validating ciphers and md algorithms has been changed.

We should now *always* use md_valid() when validating a digest alg.

At the same time, add '!' (negation) when validating the digest algorithm
in the tls-crypt code, in order to restore the proper logic.

Cc: Arne Schwabe <arne@...1227...>
Fixes: b39725cf ("Remove md_kt_t and change crypto API to use const char*")
Reported-by: Richard T Bonhomme <tincantech@...2282...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v1:
* fixed doc for md_valid()


 src/openvpn/auth_token.c     | 2 +-
 src/openvpn/crypto_backend.h | 3 +--
 src/openvpn/tls_crypt.c      | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index ceae68f6..10c9dde6 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -38,7 +38,7 @@ auth_token_kt(void)
     kt.cipher = "none";
     kt.digest = "SHA256";
 
-    if (!kt.digest)
+    if (!md_valid(kt.digest))
     {
         msg(M_WARN, "ERROR: --tls-crypt requires HMAC-SHA-256 support.");
         return (struct key_type) { 0 };
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index abf1b876..6d89b9e5 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -520,8 +520,7 @@ static inline bool md_defined(const char* mdname)
  *
  * @param digest        Name of the digest to verify, e.g. \c MD5).
  *
- * @return              A statically allocated structure containing parameters
- *                      for the given message digest.
+ * @return              Whether a digest of the given name is available
  */
 bool md_valid(const char *digest);
 
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 610168b0..aae2a917 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -59,7 +59,7 @@ tls_crypt_kt(void)
         msg(M_WARN, "ERROR: --tls-crypt requires AES-256-CTR support.");
         return (struct key_type) { 0 };
     }
-    if (cipher_valid(kt.digest))
+    if (!md_valid(kt.digest))
     {
         msg(M_WARN, "ERROR: --tls-crypt requires HMAC-SHA-256 support.");
         return (struct key_type) { 0 };
-- 
2.34.1


