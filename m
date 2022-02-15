From: Arne Schwabe <arne@...1227...>
Date: Tue, 15 Feb 2022 11:54:07 +0100
Message-Id: <20220215105407.3936338-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix checks of SHA256 in tls-crypt and
 auth-token
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
Cc: tincntech@...2282...

These checks were not correctly updated. The check in auth-token
did nothing at all and the check in tls-crypt was the wrong check
but that was hidden by the condition being inverted as well.

Reported-By: tincntech@...2282...
---
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
index abf1b876..78260057 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -520,8 +520,7 @@ static inline bool md_defined(const char* mdname)
  *
  * @param digest        Name of the digest to verify, e.g. \c MD5).
  *
- * @return              A statically allocated structure containing parameters
- *                      for the given message digest.
+ * @return              the availability of the digest of the given name.
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
2.33.0


