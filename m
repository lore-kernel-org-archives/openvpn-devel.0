From: selva.nair@...277...
Date: Wed, 22 Sep 2021 17:12:52 -0400
Message-Id: <20210922211254.7570-8-selva.nair@...277...>
In-Reply-To: <20210922211254.7570-1-selva.nair@...277...>
References: <20210922211254.7570-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 7/9] Enable signing via provider for
 management-external-key
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

- Add a function to set as sign_op during key import. The
  function passes the signature request to management interface,
  and returns the result to the provider.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/xkey_common.h |  4 +++
 src/openvpn/xkey_helper.c | 68 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index 751f18a0..6a00c382 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -35,6 +35,10 @@
  */
 OSSL_provider_init_fn xkey_provider_init;
 
+#else
+
+#define OSSL_LIB_CTX void
+
 #endif /* HAVE_XKEY_PROVIDER */
 
 #define XKEY_PROV_PROPS "provider=ovpn.xkey"
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index aa9f23b8..c9e8d218 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -33,6 +33,8 @@
 #include "error.h"
 #include "buffer.h"
 #include "xkey_common.h"
+#include "manage.h"
+#include "base64.h"
 
 #include <openssl/provider.h>
 #include <openssl/params.h>
@@ -84,13 +86,73 @@ xkey_load_management_key(OSSL_LIB_CTX *libctx, EVP_PKEY *pubkey)
     return pkey;
 }
 
-/* not yet implemented */
+/**
+ * Signature callback for xkey_provider with management-external-key
+ *
+ * @param handle        Unused -- may be null
+ * @param sig           On successful return signature is in sig.
+ * @param siglen        On entry *siglen has length of buffer sig,
+ *                      on successful return size of signature
+ * @param tbs           hash to be signed
+ * @param tbslen        len of data in dgst
+ * @param sigalg        extra signature parameters
+ *
+ * @return              signature length or -1 on error.
+ * For PKCS1 signature, the passed in hash is pure messaged digest
+ * not encoded with digest info even for the TLS 1.1 MD5_SHA hashes.
+ */
 int
 xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
                      const unsigned char *tbs, size_t tbslen, XKEY_SIGALG alg)
 {
-    msg(M_FATAL, "FATAL ERROR: A sign callback for this key is not implemented.");
-    return 0;
+    (void) unused;
+    char alg_str[64];
+
+    if (!strcmp(alg.keytype, "EC"))
+    {
+        strncpynt(alg_str, "ECDSA", sizeof(alg_str));
+    }
+    /* else assume RSA key */
+    else if (!strcmp(alg.padmode, "pkcs1"))
+    {
+        strncpynt(alg_str, "RSA_PKCS1_PADDING", sizeof(alg_str));
+    }
+    else if (!strcmp(alg.padmode, "none"))
+    {
+        strncpynt(alg_str, "RSA_NO_PADDING", sizeof(alg_str));
+    }
+    else if (!strcmp(alg.padmode, "pss"))
+    {
+        openvpn_snprintf(alg_str, sizeof(alg_str), "%s,hashalg=%s,saltlen=%s",
+                       "RSA_PKCS1_PSS_PADDING", alg.mdname,alg.saltlen);
+    }
+    else {
+        msg(M_NONFATAL, "Unsupported RSA padding mode in signature request<%s>",
+            alg.padmode);
+        return 0;
+    }
+    dmsg(D_LOW, "xkey management_sign: requesting sig with algorithm <%s>", alg_str);
+
+    char *in_b64 = NULL;
+    char *out_b64 = NULL;
+    int len = -1;
+
+    int bencret = openvpn_base64_encode(tbs, (int) tbslen, &in_b64);
+
+    if (management && bencret > 0)
+    {
+        out_b64 = management_query_pk_sig(management, in_b64, alg_str);
+    }
+    if (out_b64)
+    {
+        len = openvpn_base64_decode(out_b64, sig, (int) *siglen);
+    }
+    free(in_b64);
+    free(out_b64);
+
+    *siglen = (len > 0) ? len : 0;
+
+    return (*siglen > 0);
 }
 
 #endif /* HAVE_XKEY_PROVIDER */
-- 
2.20.1


