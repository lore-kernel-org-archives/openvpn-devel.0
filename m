From: selva.nair@...277...
Date: Fri,  7 Dec 2018 14:17:37 -0500
Message-Id: <1544210258-8754-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 1/2] Move OpenSSL vs CNG signature digest
 type mapping to a function
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

From: Selva Nair <selva.nair@...277...>

Also add a function to map  OpenSSL padding identifier to
corresponding CNG constant.

This is to help add support for additional padding
types: only refactoring, no functional changes.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/cryptoapi.c | 120 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 82 insertions(+), 38 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index fa057cb..1ce97f5 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -113,6 +113,77 @@ typedef struct _CAPI_DATA {
     int ref_count;
 } CAPI_DATA;
 
+/* Translate OpenSSL padding type to CNG padding type
+ * Returns 0 for unknown/unsupported padding.
+ */
+static DWORD
+cng_padding_type(int padding)
+{
+    DWORD pad = 0;
+
+    switch (padding)
+    {
+        case RSA_NO_PADDING:
+            break;
+
+        case RSA_PKCS1_PADDING:
+            pad = BCRYPT_PAD_PKCS1;
+            break;
+
+        case RSA_PKCS1_PSS_PADDING:
+            pad = BCRYPT_PAD_PSS;
+            break;
+
+        default:
+            msg(M_WARN|M_INFO, "cryptoapicert: unknown OpenSSL padding type %d.",
+                padding);
+    }
+
+    return pad;
+}
+
+/*
+ * Translate OpenSSL hash OID to CNG algorithm name. Returns
+ * "UNKNOWN" for unsupported algorithms and NULL for MD5+SHA1
+ * mixed hash used in TLS 1.1 and earlier.
+ */
+static const wchar_t *
+cng_hash_algo(int md_type)
+{
+    const wchar_t *alg = L"UNKNOWN";
+    switch (md_type)
+    {
+        case NID_md5:
+            alg = BCRYPT_MD5_ALGORITHM;
+            break;
+
+        case NID_sha1:
+            alg = BCRYPT_SHA1_ALGORITHM;
+            break;
+
+        case NID_sha256:
+            alg = BCRYPT_SHA256_ALGORITHM;
+            break;
+
+        case NID_sha384:
+            alg = BCRYPT_SHA384_ALGORITHM;
+            break;
+
+        case NID_sha512:
+            alg = BCRYPT_SHA512_ALGORITHM;
+            break;
+
+        case NID_md5_sha1:
+        case 0:
+            alg = NULL;
+            break;
+        default:
+            msg(M_WARN|M_INFO, "cryptoapicert: Unknown hash type NID=0x%x", md_type);
+            break;
+    }
+    return alg;
+}
+
 static void
 CAPI_DATA_free(CAPI_DATA *cd)
 {
@@ -253,7 +324,7 @@ rsa_pub_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, in
  */
 static int
 priv_enc_CNG(const CAPI_DATA *cd, const wchar_t *hash_algo, const unsigned char *from,
-             int flen, unsigned char *to, int tlen, int padding)
+             int flen, unsigned char *to, int tlen, DWORD padding)
 {
     NCRYPT_KEY_HANDLE hkey = cd->crypt_prov;
     DWORD len = 0;
@@ -268,7 +339,7 @@ priv_enc_CNG(const CAPI_DATA *cd, const wchar_t *hash_algo, const unsigned char
     DWORD status;
 
     status = NCryptSignHash(hkey, padding? &padinfo : NULL, (BYTE*) from, flen,
-                            to, tlen, &len, padding? BCRYPT_PAD_PKCS1 : 0);
+                            to, tlen, &len, padding);
     if (status != ERROR_SUCCESS)
     {
         SetLastError(status);
@@ -302,7 +373,8 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
     }
     if (cd->key_spec == CERT_NCRYPT_KEY_SPEC)
     {
-        return priv_enc_CNG(cd, NULL, from, flen, to, RSA_size(rsa), padding);
+        return priv_enc_CNG(cd, NULL, from, flen, to, RSA_size(rsa),
+                            cng_padding_type(padding));
     }
 
     /* Unfortunately, there is no "CryptSign()" function in CryptoAPI, that would
@@ -388,44 +460,16 @@ rsa_sign_CNG(int type, const unsigned char *m, unsigned int m_len,
         return 0;
     }
 
-    switch (type)
+    alg = cng_hash_algo(type);
+    if (alg && wcscmp(alg, L"UNKNOWN") == 0)
     {
-        case NID_md5:
-            alg = BCRYPT_MD5_ALGORITHM;
-            break;
-
-        case NID_sha1:
-            alg = BCRYPT_SHA1_ALGORITHM;
-            break;
-
-        case NID_sha256:
-            alg = BCRYPT_SHA256_ALGORITHM;
-            break;
-
-        case NID_sha384:
-            alg = BCRYPT_SHA384_ALGORITHM;
-            break;
-
-        case NID_sha512:
-            alg = BCRYPT_SHA512_ALGORITHM;
-            break;
-
-        case NID_md5_sha1:
-            if (m_len != SSL_SIG_LENGTH)
-            {
-                RSAerr(RSA_F_RSA_SIGN, RSA_R_INVALID_MESSAGE_LENGTH);
-                return 0;
-            }
-            /* No DigestInfo header is required -- set alg-name to NULL */
-            alg = NULL;
-            break;
-        default:
-            msg(M_WARN, "cryptoapicert: Unknown hash type NID=0x%x", type);
-            RSAerr(RSA_F_RSA_SIGN, RSA_R_UNKNOWN_ALGORITHM_TYPE);
-            return 0;
+        RSAerr(RSA_F_RSA_SIGN, RSA_R_UNKNOWN_ALGORITHM_TYPE);
+        return 0;
     }
 
-    *siglen = priv_enc_CNG(cd, alg, m, (int)m_len, sig, RSA_size(rsa), padding);
+    *siglen = priv_enc_CNG(cd, alg, m, (int)m_len, sig, RSA_size(rsa),
+                           cng_padding_type(padding));
+
     return (siglen == 0) ? 0 : 1;
 }
 
-- 
2.1.4


