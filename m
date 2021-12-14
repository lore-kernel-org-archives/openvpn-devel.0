From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:18 -0500
Message-Id: <20211214165928.30676-9-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 08/18] Add a function to encode digests
 with PKCS1 DigestInfo wrapper
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

The EVP_PKEY interface as well as provider passes the raw
digest to the sign() function. In case of RSA_PKCS1,
our management interface expects an encoded hash, which
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

v2 changes: Use hard-coded headers for known hash algorithms instead
of assembling it from the ASN.1 objects.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/xkey_common.h |  20 ++++++
 src/openvpn/xkey_helper.c | 130 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index 608afe99..c04c9c5c 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -96,6 +96,26 @@ typedef void (XKEY_PRIVKEY_FREE_fn)(void *handle);
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
+encode_pkcs1(unsigned char *enc, size_t *enc_len, const char *mdname,
+             const unsigned char *tbs, size_t tbslen);
+
 #endif /* HAVE_XKEY_PROVIDER */
 
 #endif /* XKEY_COMMON_H_ */
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index aac78a2c..b2546cec 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -143,6 +143,9 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
     unsigned char buf[EVP_MAX_MD_SIZE]; /* for computing digest if required */
     size_t buflen = sizeof(buf);
 
+    unsigned char enc[EVP_MAX_MD_SIZE + 32]; /* 32 bytes enough for digest inf structure */
+    size_t enc_len = sizeof(enc);
+
     if (!strcmp(alg.op, "DigestSign"))
     {
         dmsg(D_LOW, "xkey_management_sign: computing digest");
@@ -165,6 +168,14 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
     /* else assume RSA key */
     else if (!strcmp(alg.padmode, "pkcs1"))
     {
+        /* management interface expects a pkcs1 encoded digest -- add it */
+        if (!encode_pkcs1(enc, &enc_len, alg.mdname, tbs, tbslen))
+        {
+            return 0;
+        }
+        tbs = enc;
+        tbslen = enc_len;
+
         strncpynt(alg_str, "RSA_PKCS1_PADDING", sizeof(alg_str));
     }
     else if (!strcmp(alg.padmode, "none"))
@@ -205,4 +216,123 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
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
+ */
+bool
+encode_pkcs1(unsigned char *enc, size_t *enc_len, const char *mdname,
+             const unsigned char *tbs, size_t tbslen)
+{
+    ASSERT(enc_len != NULL);
+    ASSERT(tbs != NULL);
+
+    /* Tabulate the digest info header for expected hash algorithms
+     * These were pre-computed using the DigestInfo definition:
+     * DigestInfo ::= SEQUENCE {
+     *    digestAlgorithm DigestAlgorithmIdentifier,
+     *    digest Digest }
+     * Also see the table in RFC 8017 section 9.2, Note 1.
+     */
+
+    const unsigned char sha1[] = {0x30, 0x21, 0x30, 0x09, 0x06, 0x05, 0x2b,
+                                  0x0e, 0x03, 0x02, 0x1a, 0x05, 0x00, 0x04, 0x14};
+    const unsigned char sha256[] = {0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86, 0x48,
+                                    0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05, 0x00, 0x04, 0x20};
+    const unsigned char sha384[] = {0x30, 0x41, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86, 0x48,
+                                    0x01, 0x65, 0x03, 0x04, 0x02, 0x02, 0x05, 0x00, 0x04, 0x30};
+    const unsigned char sha512[] = {0x30, 0x51, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86, 0x48,
+                                    0x01, 0x65, 0x03, 0x04, 0x02, 0x03, 0x05, 0x00, 0x04, 0x40};
+    const unsigned char sha224[] = {0x30, 0x2d, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86, 0x48,
+                                    0x01, 0x65, 0x03, 0x04, 0x02, 0x04, 0x05, 0x00, 0x04, 0x1c};
+    const unsigned char sha512_224[] = {0x30, 0x2d, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86, 0x48,
+                                    0x01, 0x65, 0x03, 0x04, 0x02, 0x05, 0x05, 0x00, 0x04, 0x1c};
+    const unsigned char sha512_256[] = {0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86, 0x48,
+                                    0x01, 0x65, 0x03, 0x04, 0x02, 0x06, 0x05, 0x00, 0x04, 0x20};
+
+    typedef struct {
+       const int nid;
+       const unsigned char *header;
+       size_t sz;
+    } DIG_INFO;
+
+#define MAKE_DI(x) {NID_##x, x, sizeof(x)}
+
+    DIG_INFO dinfo[] = {MAKE_DI(sha1), MAKE_DI(sha256), MAKE_DI(sha384),
+                        MAKE_DI(sha512), MAKE_DI(sha224), MAKE_DI(sha512_224),
+                        MAKE_DI(sha512_256), {0,NULL,0}};
+
+    int out_len = 0;
+    int ret = 0;
+
+    int nid = OBJ_sn2nid(mdname);
+    if(nid == NID_undef)
+    {
+        /* try harder  -- name variants like SHA2-256 doesn't work */
+        nid = EVP_MD_type(EVP_get_digestbyname(mdname));
+        if(nid == NID_undef)
+        {
+            msg(M_WARN, "Error: encode_pkcs11: invalid digest name <%s>", mdname);
+            goto done;
+        }
+    }
+
+    if (tbslen != EVP_MD_size(EVP_get_digestbyname(mdname)))
+    {
+        msg(M_WARN, "Error: encode_pkcs11: invalid input length <%d>", (int)tbslen);
+        goto done;
+    }
+
+    if (nid == NID_md5_sha1) /* no encoding needed -- just copy */
+    {
+        if (enc && (*enc_len >= tbslen))
+        {
+            memcpy(enc, tbs, tbslen);
+            ret = true;
+        }
+        out_len = tbslen;
+        goto done;
+    }
+
+    /* locate entry for nid in dinfo table */
+    DIG_INFO *di = dinfo;
+    while((di->nid != nid) && (di->nid != 0))
+    {
+        di++;
+    }
+    if (di->nid != nid) /* not found in our table */
+    {
+        msg(M_WARN, "Error: encode_pkcs11: unsupported hash algorithm <%s>", mdname);
+        goto done;
+    }
+
+    out_len = tbslen + di->sz;
+
+    if (enc && (out_len <= (int) *enc_len))
+    {
+        /* combine header and digest */
+        memcpy(enc, di->header, di->sz);
+        memcpy(enc + di->sz, tbs, tbslen);
+        dmsg(D_LOW, "encode_pkcs1: digest length = %d encoded length = %d",
+             (int) tbslen, (int) out_len);
+        ret = true;
+    }
+
+done:
+    *enc_len = out_len; /* assignment safe as out_len is > 0 at this point */
+
+    return ret;
+}
+
 #endif /* HAVE_XKEY_PROVIDER */
-- 
2.30.2


