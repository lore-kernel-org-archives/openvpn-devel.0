From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:17 -0500
Message-Id: <20211214165928.30676-8-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 07/18] Enable signing via provider for
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

v2 changes: Method to do digest added to match the changes in
            the provider signature callback.
TODO:
 - Allow passing the undigested message to management interface
 - Add pkcs1 DigestInfo header when required

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/ssl_openssl.c |   4 +-
 src/openvpn/xkey_common.h |   7 ++-
 src/openvpn/xkey_helper.c | 108 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 113 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 23c74f55..8f0281b1 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1169,7 +1169,7 @@ end:
 }
 
 
-#ifdef ENABLE_MANAGEMENT
+#if defined(ENABLE_MANAGEMENT) && !defined(HAVE_XKEY_PROVIDER)
 
 /* encrypt */
 static int
@@ -1470,7 +1470,9 @@ err:
     return 0;
 }
 #endif /* OPENSSL_VERSION_NUMBER > 1.1.0 dev && !defined(OPENSSL_NO_EC) */
+#endif /* ENABLE_MANAGEMENT && !HAVE_XKEY_PROVIDER */
 
+#ifdef ENABLE_MANAGEMENT
 int
 tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
 {
diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index 5bda5e30..608afe99 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -67,10 +67,13 @@ typedef struct {
  *
  * @returns 1 on success, 0 on error.
  *
- * The data in tbs is just the digest with no DigestInfo header added. This is
+ * If sigalg.op = "Sign", the data in tbs is the digest. If sigalg.op = "DigestSign"
+ * it is the message that the backend should hash wih appropriate hash algorithm before
+ * signing. In the former case no DigestInfo header is added to tbs. This is
  * unlike the deprecated RSA_sign callback which provides encoded digest.
  * For RSA_PKCS1 signatures, the external signing function must encode the digest
- * before signing. The digest algorithm used is passed in the sigalg structure.
+ * before signing. The digest algorithm used (or to be used) is passed in the sigalg
+ * structure.
  */
 typedef int (XKEY_EXTERNAL_SIGN_fn)(void *handle, unsigned char *sig, size_t *siglen,
                                  const unsigned char *tbs, size_t tbslen,
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 51cfb12b..aac78a2c 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -32,6 +32,8 @@
 #include "error.h"
 #include "buffer.h"
 #include "xkey_common.h"
+#include "manage.h"
+#include "base64.h"
 
 #ifdef HAVE_XKEY_PROVIDER
 
@@ -48,6 +50,31 @@ static const char *const props = XKEY_PROV_PROPS;
 
 XKEY_EXTERNAL_SIGN_fn xkey_management_sign;
 
+/** helper to compute digest */
+static int
+xkey_digest(const unsigned char *src, size_t srclen, unsigned char *buf,
+            size_t *buflen, const char *mdname)
+{
+    dmsg(D_LOW, "In xkey_digest");
+    EVP_MD *md = EVP_MD_fetch(NULL, mdname, NULL); /* from default context */
+    if (!md)
+    {
+        msg(M_WARN, "WARN: xkey_digest: MD_fetch failed for <%s>", mdname);
+        return 0;
+    }
+
+    unsigned int len = (unsigned int) *buflen;
+    if (EVP_Digest(src, srclen, buf, &len, md, NULL) != 1)
+    {
+        msg(M_WARN, "WARN: xkey_digest: EVP_Digest failed");
+        return 0;
+    }
+    EVP_MD_free(md);
+
+    *buflen = len;
+    return 1;
+}
+
 /**
  * Load external key for signing via management interface.
  * The public key must be passed in by the caller as we may not
@@ -94,13 +121,88 @@ xkey_load_management_key(OSSL_LIB_CTX *libctx, EVP_PKEY *pubkey)
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
+ * @param tbs           hash or message to be signed
+ * @param tbslen        len of data in dgst
+ * @param sigalg        extra signature parameters
+ *
+ * @return              signature length or -1 on error.
+ */
 int
 xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
                      const unsigned char *tbs, size_t tbslen, XKEY_SIGALG alg)
 {
-    msg(M_FATAL, "FATAL ERROR: A sign callback for this key is not implemented.");
-    return 0;
+    (void) unused;
+    char alg_str[128];
+    unsigned char buf[EVP_MAX_MD_SIZE]; /* for computing digest if required */
+    size_t buflen = sizeof(buf);
+
+    if (!strcmp(alg.op, "DigestSign"))
+    {
+        dmsg(D_LOW, "xkey_management_sign: computing digest");
+        if (xkey_digest(tbs, tbslen, buf, &buflen, alg.mdname))
+        {
+            tbs = buf;
+            tbslen = buflen;
+            alg.op = "Sign";
+        }
+        else
+        {
+            return 0;
+        }
+    }
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
2.30.2


