From: selva.nair@...277...
Date: Mon, 24 Jan 2022 21:51:27 -0500
Message-Id: <20220125025128.2117-2-selva.nair@...277...>
In-Reply-To: <20220125025128.2117-1-selva.nair@...277...>
References: <20220125025128.2117-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] Fix max saltlen calculation in
 cryptoapi.c
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

(nbits - 1)/8 should have been rounded up. Fix and move it to
an inlined function for reuse in pkcs11_openssl.c (used in the
next commit).

Note: The error is not triggered in normal use as OpenSSL
always seems to use saltlen="digest" for signing.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/cryptoapi.c   |  2 +-
 src/openvpn/xkey_common.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 8e0ceba7..56cab962 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -843,7 +843,7 @@ xkey_cng_rsa_sign(CAPI_DATA *cd, unsigned char *sig, size_t *siglen, const unsig
         int saltlen = tbslen; /* digest size by default */
         if (!strcmp(sigalg.saltlen, "max"))
         {
-            saltlen = (EVP_PKEY_bits(cd->pubkey) - 1)/8 - tbslen - 2;
+            saltlen = xkey_max_saltlen(EVP_PKEY_bits(cd->pubkey), tbslen);
             if (saltlen < 0)
             {
                 msg(M_NONFATAL, "Error in cryptoapicert: invalid salt length (%d)", saltlen);
diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index 75ca5011..1e51e672 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -153,6 +153,20 @@ xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY *pubkey,
 
 extern OSSL_LIB_CTX *tls_libctx; /* Global */
 
+/**
+ * Maximum salt length for PSS signature.
+ *
+ * @param modBits    Number of bits in RSA modulus
+ * @param hLen       Length of digest to be signed
+ * @returns the maximum allowed salt length. Caller must check it's not < 0.
+ */
+static inline int
+xkey_max_saltlen(int modBits, int hLen)
+{
+    int emLen = (modBits - 1 + 7)/8; /* ceil((modBits - 1)/8) */
+
+    return emLen - hLen - 2;
+}
 #endif /* HAVE_XKEY_PROVIDER */
 
 #endif /* XKEY_COMMON_H_ */
-- 
2.30.2


