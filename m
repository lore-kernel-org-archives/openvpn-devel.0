From: selva.nair@...277...
Date: Wed, 22 Sep 2021 17:12:53 -0400
Message-Id: <20210922211254.7570-9-selva.nair@...277...>
In-Reply-To: <20210922211254.7570-1-selva.nair@...277...>
References: <20210922211254.7570-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 8/9] Add a function to encode digests with
 PKCS1 DigestInfo wrapper
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

The EVP_PKEY interface as well as provider provides the raw
digest to the sign() function. In case of RSA_PKCS1,
our management interface expects expects an encoded hash, which
has the DigestInfo header added as per PKCSv1.5 specs,
unless the hash algorithm is legacy MD5_SHA1.

Fix this by
 - add a function to perform the pkcs1 encoding before passing the
   data to sign to the management interface. The implementation
   is not pretty, but should work.
   (Unfortunately OpenSSL does not expose a function for this).

Note:
1. cryptoki interface used by pkcs11-helper also requires this
to be done before calling the Sign op. This will come handy there
too.
2. We have a similar function in ssl_mbedtls.c but its not prettier,
   and require porting.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/xkey_common.h |  20 ++++++
 src/openvpn/xkey_helper.c | 127 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index 6a00c382..e92d4868 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -97,4 +97,24 @@ typedef void (XKEY_PRIVKEY_FREE_fn)(void *handle);
  */
 EVP_PKEY *xkey_load_management_key(OSSL_LIB_CTX *libctx, EVP_PKEY *pubkey);
 
+/**
+ * Add PKCS1 DigestInfo to tbs and return the result in *enc.
+ *
+ * @param enc           pointer to output buffer
+ * @param enc_len       capacity in bytes of output buffer
+ * @param mdname        name of the hash algorithm (SHA256, SHA1 etc.)
+ * @param tbs           pointer to digest to be encoded
+ * @param tbslen        length of data in bytes
+ *
+ * @return              false on error, true  on success
+ *
+ * On return enc_len is  set to actual size of the result.
+ * enc is NULL or enc_len is not enough to store the result, it is set
+ * to the required size and false is returned.
+ *
+ */
+bool
+encode_pkcs1(unsigned char **enc, size_t *enc_len, const char *mdname,
+             const unsigned char *tbs, size_t tbslen);
+
 #endif /* XKEY_PUBLIC_H_ */
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index c9e8d218..4d41631b 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -115,6 +115,17 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
     /* else assume RSA key */
     else if (!strcmp(alg.padmode, "pkcs1"))
     {
+        /* management interface expects a pkcs1 encoded digest -- add it */
+        unsigned char enc[EVP_MAX_MD_SIZE + 32]; /* 32 bytes enough for digest inf structure */
+        size_t enc_len = sizeof(enc);
+
+        if (!encode_pkcs1((unsigned char **)&enc, &enc_len, alg.mdname, tbs, tbslen))
+        {
+            return 0;
+        }
+        tbs = enc;
+        tbslen = enc_len;
+
         strncpynt(alg_str, "RSA_PKCS1_PADDING", sizeof(alg_str));
     }
     else if (!strcmp(alg.padmode, "none"))
@@ -155,4 +166,120 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
     return (*siglen > 0);
 }
 
+/**
+ * Add PKCS1 DigestInfo to tbs and return the result in *enc.
+ *
+ * @param enc           pointer to output buffer
+ * @param enc_len       capacity in bytes of output buffer
+ * @param mdname        name of the hash algorithm (SHA256, SHA1 etc.)
+ * @param tbs           pointer to digest to be encoded
+ * @param tbslen        length of data in bytes
+ *
+ * @return              false on error, true  on success
+ *
+ * On return enc_len is  set to actual size of the result.
+ * enc is NULL or enc_len is not enough to store the result, it is set
+ * to the required size and false is returned.
+ *
+ */
+bool
+encode_pkcs1(unsigned char **enc, size_t *enc_len, const char *mdname,
+             const unsigned char *tbs, size_t tbslen)
+{
+    bool ret = false;
+    unsigned char *ptr;
+    int out_len = 0;
+    int tmp_len;
+    X509_ALGOR *algor = NULL;
+    ASN1_STRING *digest = NULL;
+
+    ASSERT(enc_len != NULL);
+    ASSERT(tbs != NULL);
+
+    int nid = OBJ_sn2nid(mdname);
+    if(nid == NID_undef)
+    {
+        msg(M_WARN, "Error: encode_pkcs11: invalid digest name <%s>", mdname);
+        return false;
+    }
+
+    if (nid == NID_md5_sha1) /* no encoding needed -- just copy */
+    {
+        out_len = (int) tbslen;
+        if (enc && (*enc_len >= out_len))
+        {
+            memcpy(*enc, tbs, out_len);
+        }
+        *enc_len = tbslen;
+        ret = 1;
+        goto cleanup;
+    }
+
+    if((algor = X509_ALGOR_new()) == NULL
+        || X509_ALGOR_set0(algor, OBJ_nid2obj(nid), V_ASN1_NULL, NULL) <= 0
+        || (digest = ASN1_STRING_type_new(V_ASN1_OCTET_STRING)) == NULL
+        || ASN1_STRING_set(digest, tbs, tbslen) <= 0)
+    {
+        msg(M_WARN, "Error: encode_pkcs11: failed to create ASN1 strings");
+        goto cleanup;
+    }
+
+    if(algor->algorithm == NULL || OBJ_length(algor->algorithm) == 0)
+    {
+        msg(M_WARN, "Error: encode_pkcs11: invalide digest type(nid = %d)", nid);
+        goto cleanup;
+    }
+
+    /* We want DER encoding of X509_SIG = {algor, digest} which could be
+     * computed as i2d_X509_SIG(), but, unfortunately, the X509_SIG struct
+     * is opaque and has no constructor. Hence we combine the two elements
+     * into a sequence ourselves -- not pretty
+     */
+
+    /* find required size for the buffer */
+    if((tmp_len = i2d_X509_ALGOR(algor, NULL)) < 0)
+    {
+        goto cleanup;
+    }
+    out_len = tmp_len;
+
+    if((tmp_len = i2d_ASN1_OCTET_STRING(digest, NULL)) < 0)
+    {
+        goto cleanup;
+    }
+    out_len += tmp_len + 2 ; /* extra 2 bytes for sequence header added below */
+
+    if ((out_len > (int) *enc_len) || !enc)
+    {
+        *enc_len = out_len;
+        goto cleanup;
+    }
+
+    ptr = *enc;
+    *ptr++ = V_ASN1_SEQUENCE | V_ASN1_CONSTRUCTED;
+    *ptr++ = out_len - 2;
+
+    /* compute and append the DER of algor and digest to ptr */
+    i2d_X509_ALGOR(algor, &ptr);  /* this advances ptr */
+    i2d_ASN1_OCTET_STRING(digest, &ptr);
+
+    *enc_len = out_len; /* assignment safe as out_len is > 0 at this point */
+    ret = 1;
+
+    dmsg(D_LOW, "encode_pkcs1: digest length = %d encoded length = %d",
+                 (int) tbslen, out_len);
+
+cleanup:
+    if(digest)
+    {
+        ASN1_STRING_free(digest);
+    }
+    if(algor)
+    {
+        X509_ALGOR_free(algor);
+    }
+
+    return ret;
+}
+
 #endif /* HAVE_XKEY_PROVIDER */
-- 
2.20.1


