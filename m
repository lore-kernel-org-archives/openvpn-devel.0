From: selva.nair@...277...
Date: Mon, 24 Jan 2022 21:51:28 -0500
Message-Id: <20220125025128.2117-3-selva.nair@...277...>
In-Reply-To: <20220125025128.2117-1-selva.nair@...277...>
References: <20220125025128.2117-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] Support PSS signing using pkcs11-helper
 >= 1.28
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

- Call pkcs11h_certificate_signAny_ex() when available
  so that the signature mechanism parameters can be pased.
  (Required for RSA-PSS signature).

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/pkcs11_openssl.c | 123 +++++++++++++++++++++++++++++++++--
 1 file changed, 118 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 9cf46b2c..5d1a5de6 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -45,10 +45,112 @@
 #ifdef HAVE_XKEY_PROVIDER
 static XKEY_EXTERNAL_SIGN_fn xkey_pkcs11h_sign;
 
+#if PKCS11H_VERSION > ((1<<16) | (27<<8)) /* version > 1.27 */
+
+/* Table linking OpenSSL digest NID with CKM and CKG constants in PKCS#11 */
+#define MD_TYPE(n) {NID_sha##n, CKM_SHA##n, CKG_MGF1_SHA##n}
+static const struct
+{
+   int nid;
+   unsigned long ckm_id;
+   unsigned long mgf_id;
+} mdtypes[] = {MD_TYPE(224), MD_TYPE(256), MD_TYPE(384), MD_TYPE(512),
+              {NID_sha1, CKM_SHA_1, CKG_MGF1_SHA1}, /* SHA_1 naming is an oddity */
+              {NID_undef, 0, 0}};
+
+/* From sigalg, derive parameters for pss signature and fill in  pss_params.
+ * Its of type CK_RSA_PKCS_PSS_PARAMS struct with three fields to be filled in:
+ * {enum hashAlg, enum mgf, ulong sLen}
+ * where hashAlg is CKM_SHA256 etc., mgf is CKG_MGF1_SHA256 etc.
+ */
+static int
+set_pss_params(CK_RSA_PKCS_PSS_PARAMS *pss_params, XKEY_SIGALG sigalg,
+               pkcs11h_certificate_t cert)
+{
+    int ret = 0;
+    X509 *x509 = NULL;
+    EVP_PKEY *pubkey = NULL;
+
+    if ((x509 = pkcs11h_openssl_getX509(cert)) == NULL
+        || (pubkey = X509_get0_pubkey(x509)) == NULL)
+    {
+        msg(M_WARN, "PKCS#11: Unable get public key");
+        goto cleanup;
+    }
+
+    /* map mdname to CKM and CKG constants for hash and mgf algorithms */
+    int i = 0;
+    int nid = OBJ_sn2nid(sigalg.mdname);
+    while (mdtypes[i].nid != NID_undef && mdtypes[i].nid != nid)
+    {
+        i++;
+    }
+    pss_params->hashAlg = mdtypes[i].ckm_id;
+    pss_params->mgf = mdtypes[i].mgf_id;
+
+    /* determine salt length */
+    int mdsize = EVP_MD_size(EVP_get_digestbyname(sigalg.mdname));
+
+    int saltlen = -1;
+    if (!strcmp(sigalg.saltlen, "digest")) /* same as digest size */
+    {
+        saltlen = mdsize;
+    }
+    else if (!strcmp(sigalg.saltlen, "max")) /* maximum possible value */
+    {
+        saltlen = xkey_max_saltlen(EVP_PKEY_get_bits(pubkey), mdsize);
+    }
+
+    if (saltlen < 0 || pss_params->hashAlg == 0)
+    {
+        msg(M_WARN, "WARN: invalid RSA_PKCS1_PSS parameters: saltlen = <%s> "
+                    "mdname = <%s>.", sigalg.saltlen, sigalg.mdname);
+        goto cleanup;
+    }
+    pss_params->sLen = (unsigned long) saltlen; /* saltlen >= 0 at this point */
+
+    msg(D_XKEY, "set_pss_params: sLen = %lu, hashAlg = %lu, mgf = %lu",
+        pss_params->sLen, pss_params->hashAlg, pss_params->mgf);
+
+    ret = 1;
+
+cleanup:
+    if (x509)
+    {
+        X509_free(x509);
+    }
+    return ret;
+}
+
+#else
+
+/* Make set_pss_params a no-op that always succeeds */
+#define set_pss_params(...) (1)
+
+/* Use a wrapper for pkcs11h_certificate_signAny_ex() for versions < 1.28
+ * where its not available.
+ * We just call pkcs11h_certificate_signAny() unless the padding
+ * is PSS in which case we return an error.
+ */
+static CK_RV
+pkcs11h_certificate_signAny_ex(const pkcs11h_certificate_t cert,
+        const CK_MECHANISM *mech, const unsigned char *tbs,
+        size_t tbslen, unsigned char *sig, size_t *siglen)
+{
+    if (mech->mechanism == CKM_RSA_PKCS_PSS)
+    {
+        msg(M_NONFATAL, "PKCS#11: Error: PSS padding is not supported by "
+                        "this version of pkcs11-helper library.");
+        return CKR_MECHANISM_INVALID;
+    }
+    return pkcs11h_certificate_signAny(cert, mech->mechanism, tbs, tbslen, sig, siglen);
+}
+#endif /* PKCS11H_VERSION > 1.27 */
+
 /**
  * Sign op called from xkey provider
  *
- * We support ECDSA, RSA_NO_PADDING, RSA_PKCS1_PADDING
+ * We support ECDSA, RSA_NO_PADDING, RSA_PKCS1_PADDING, RSA_PKCS_PSS_PADDING
  */
 static int
 xkey_pkcs11h_sign(void *handle, unsigned char *sig,
@@ -62,7 +164,7 @@ xkey_pkcs11h_sign(void *handle, unsigned char *sig,
 
     if (!strcmp(sigalg.op, "DigestSign"))
     {
-        dmsg(D_LOW, "xkey_pkcs11h_sign: computing digest");
+        msg(D_XKEY, "xkey_pkcs11h_sign: computing digest");
         if (xkey_digest(tbs, tbslen, buf, &buflen, sigalg.mdname))
         {
             tbs = buf;
@@ -77,18 +179,29 @@ xkey_pkcs11h_sign(void *handle, unsigned char *sig,
 
     if (!strcmp(sigalg.keytype, "EC"))
     {
+        msg(D_XKEY, "xkey_pkcs11h_sign: signing with EC key");
         mech.mechanism = CKM_ECDSA;
     }
     else if (!strcmp(sigalg.keytype, "RSA"))
     {
+        msg(D_XKEY, "xkey_pkcs11h_sign: signing with RSA key: padmode = %s",
+            sigalg.padmode);
         if (!strcmp(sigalg.padmode,"none"))
         {
             mech.mechanism = CKM_RSA_X_509;
         }
         else if (!strcmp(sigalg.padmode, "pss"))
         {
-            msg(M_NONFATAL, "PKCS#11: Error: PSS padding is not yet supported.");
-            return 0;
+            CK_RSA_PKCS_PSS_PARAMS pss_params = {0};
+            mech.mechanism = CKM_RSA_PKCS_PSS;
+
+            if (!set_pss_params(&pss_params, sigalg, cert))
+            {
+                return 0;
+            }
+
+            mech.pParameter = &pss_params;
+            mech.ulParameterLen = sizeof(pss_params);
         }
         else if (!strcmp(sigalg.padmode, "pkcs1"))
         {
@@ -114,7 +227,7 @@ xkey_pkcs11h_sign(void *handle, unsigned char *sig,
          ASSERT(0); /* coding error -- we couldnt have created any such key */
     }
 
-    return CKR_OK == pkcs11h_certificate_signAny(cert, mech.mechanism,
+    return CKR_OK == pkcs11h_certificate_signAny_ex(cert, &mech,
                                                  tbs, tbslen, sig, siglen);
 }
 
-- 
2.30.2


