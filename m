From: Heiko Wundram <heiko.wundram@...2614...>
Date: Fri,  4 Jun 2021 16:31:25 +0200
Message-Id: <20210604143125.4946-1-heiko.wundram@...2614...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Implement Windows CA template match for
 Crypto-API selector
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

The certificate selection process for the Crypto API certificates
is currently fixed to match on subject or identifier. Especially
if certificates that are used for OpenVPN are managed by a Windows CA,
it is appropriate to select the certificate to use by the template
that it is generated from, especially on domain-joined clients which
automatically acquire/renew the corresponding certificate.

The attached match implements the match on TMPL: with either a template
name (which is looked up through CryptFindOIDInfo) or by specifying the
OID of the template directly, which then is matched against the
corresponding X509 extensions specifying the template that the certificate
was generated from.

The logic requires to walk all certificates in the underlying store and
to match the certificate extensions directly. The hook which is
implemented in the certificate selection logic is generic to allow
other Crypto-API certificate matches to also be implemented at some
point in the future.

The logic to match the certificate template is taken from the
implementation in the .NET core runtime, see Pal.Windows/FindPal.cs in
in the implementation of System.Security.Cryptography.X509Certificates.

Signed-off-by: Heiko Wundram <heiko.wundram@...2614...>
---
 src/openvpn/cryptoapi.c | 142 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 135 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index ded8c914..3532a9a0 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -732,6 +732,115 @@ err:
 
 #endif /* OPENSSL_VERSION_NUMBER >= 1.1.0 */
 
+static void *
+decode_object(struct gc_arena *gc, LPCSTR struct_type, const CRYPT_OBJID_BLOB *val, DWORD flags, DWORD *cb)
+{
+    /* get byte count for decoding */
+    BYTE *buf;
+    if (!CryptDecodeObject(X509_ASN_ENCODING | PKCS_7_ASN_ENCODING, struct_type, val->pbData, val->cbData, flags, NULL, cb))
+    {
+        return NULL;
+    }
+
+    /* do the actual decode */
+    buf = gc_malloc(*cb, false, gc);
+    if (!CryptDecodeObject(X509_ASN_ENCODING | PKCS_7_ASN_ENCODING, struct_type, val->pbData, val->cbData, flags, buf, cb))
+    {
+        return NULL;
+    }
+
+    return buf;
+}
+
+static const CRYPT_OID_INFO *
+find_oid(DWORD keytype, const void *key, DWORD groupid, bool fallback)
+{
+    const CRYPT_OID_INFO *info = NULL;
+
+    /* force resolve from local as first step */
+    if (groupid != CRYPT_HASH_ALG_OID_GROUP_ID
+        && groupid != CRYPT_ENCRYPT_ALG_OID_GROUP_ID
+        && groupid != CRYPT_PUBKEY_ALG_OID_GROUP_ID
+        && groupid != CRYPT_SIGN_ALG_OID_GROUP_ID
+        && groupid != CRYPT_RDN_ATTR_OID_GROUP_ID
+        && groupid != CRYPT_EXT_OR_ATTR_OID_GROUP_ID
+        && groupid != CRYPT_KDF_OID_GROUP_ID)
+    {
+        info = CryptFindOIDInfo(keytype, (void*)key, groupid | CRYPT_OID_DISABLE_SEARCH_DS_FLAG);
+    }
+
+    /* try proper resolve if not found yet, also including AD */
+    if (!info)
+    {
+        info = CryptFindOIDInfo(keytype, (void*)key, groupid);
+    }
+
+    /* fall back to all groups if not found yet and fallback requested */
+    if (!info && fallback && groupid)
+    {
+        info = CryptFindOIDInfo(keytype, (void*)key, 0);
+    }
+
+    return info;
+}
+
+static bool
+test_certificate_template(const char *cert_prop, const CERT_CONTEXT *cert_ctx)
+{
+    const CERT_INFO *info = cert_ctx->pCertInfo;
+    const CERT_EXTENSION *ext;
+    DWORD cbext;
+    void *pvext;
+    struct gc_arena gc = gc_new();
+    const WCHAR *tmpl_name = wide_string(cert_prop, &gc);
+
+    /* check for V1 extension (Windows 2K and below) */
+    ext = CertFindExtension(szOID_ENROLL_CERTTYPE_EXTENSION, info->cExtension, info->rgExtension);
+    if (ext)
+    {
+        pvext = decode_object(&gc, X509_UNICODE_ANY_STRING, &ext->Value, 0, &cbext);
+        if (pvext && cbext >= sizeof(CERT_NAME_VALUE))
+        {
+            const CERT_NAME_VALUE *nv = (const CERT_NAME_VALUE*)pvext;
+            if (nv->Value.cbData >= sizeof(WCHAR) * (wcslen(tmpl_name) + 1)
+                && !_wcsicmp((const WCHAR*)nv->Value.pbData, tmpl_name))
+            {
+                /* data content matches extension name */
+                gc_free(&gc);
+                return true;
+            }
+        }
+    }
+
+    /* check for V2 extension (Windows 2003+) */
+    ext = CertFindExtension(szOID_CERTIFICATE_TEMPLATE, info->cExtension, info->rgExtension);
+    if (ext)
+    {
+        pvext = decode_object(&gc, X509_CERTIFICATE_TEMPLATE, &ext->Value, 0, &cbext);
+        if (pvext && cbext >= sizeof(CERT_TEMPLATE_EXT))
+        {
+            const CERT_TEMPLATE_EXT *cte = (const CERT_TEMPLATE_EXT*)pvext;
+            const CRYPT_OID_INFO *tmpl_oid = find_oid(CRYPT_OID_INFO_NAME_KEY, tmpl_name, CRYPT_TEMPLATE_OID_GROUP_ID, true);
+            if (tmpl_oid && !stricmp(tmpl_oid->pszOID, cte->pszObjId))
+            {
+                /* found OID match in extension against resolved key */
+                gc_free(&gc);
+                return true;
+            }
+            else if (!tmpl_oid && !stricmp(cert_prop, cte->pszObjId))
+            {
+                /* found direct OID match with certificate property specified */
+                gc_free(&gc);
+                return true;
+            }
+        }
+    }
+
+    /* no extension found, exit */
+    gc_free(&gc);
+    return false;
+}
+
 static const CERT_CONTEXT *
 find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
 {
@@ -743,17 +852,25 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
      * The first matching certificate that has not expired is returned.
      */
     const CERT_CONTEXT *rv = NULL;
-    DWORD find_type;
-    const void *find_param;
+    DWORD find_type = CERT_FIND_ANY;
+    const void *find_param = NULL;
+    bool (*find_test)(const char*, const CERT_CONTEXT*) = NULL;
     unsigned char hash[255];
     CRYPT_HASH_BLOB blob = {.cbData = 0, .pbData = hash};
     struct gc_arena gc = gc_new();
 
-    if (!strncmp(cert_prop, "SUBJ:", 5))
+    if (!strncmp(cert_prop, "TMPL:", 5))
+    {
+        /* skip the tag */
+        cert_prop += 5;
+        find_test = &test_certificate_template;
+    }
+    else if (!strncmp(cert_prop, "SUBJ:", 5))
     {
         /* skip the tag */
-        find_param = wide_string(cert_prop + 5, &gc);
+        cert_prop += 5;
         find_type = CERT_FIND_SUBJECT_STR_W;
+        find_param = wide_string(cert_prop, &gc);
     }
     else if (!strncmp(cert_prop, "THUMB:", 6))
     {
@@ -819,12 +936,23 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
         {
             validity = CertVerifyTimeValidity(NULL, rv->pCertInfo);
         }
-        if (!rv || validity == 0)
+        else
         {
             break;
         }
-        msg(M_WARN, "WARNING: cryptoapicert: ignoring certificate in store %s.",
-            validity < 0 ? "not yet valid" : "that has expired");
+
+        if (validity == 0)
+        {
+            if (!find_test || find_test(cert_prop, rv))
+            {
+                break;
+            }
+        }
+        else
+        {
+            msg(M_WARN, "WARNING: cryptoapicert: ignoring certificate in store %s.",
+                validity < 0 ? "not yet valid" : "that has expired");
+        }
     }
 
 out:
-- 
2.20.1


