From: Gert Doering <gert@...1296...>
Date: Thu,  6 Jun 2024 12:34:41 +0200
Message-ID: <20240606103441.26598-1-gert@...1296...>
In-Reply-To: <gerrit.1716917280000.Ia2c3e4c5c83ecccce1618c43b489dbe811de5351@...2715...>
References: <gerrit.1716917280000.Ia2c3e4c5c83ecccce1618c43b489dbe811de5351@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Implement Windows CA template match for
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

From: Heiko Wundram <heiko.wundram@...2614...>

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

Change-Id: Ia2c3e4c5c83ecccce1618c43b489dbe811de5351
Signed-off-by: Heiko Wundram <heiko.wundram@...2614...>
Signed-off-by: Hannes Domani <ssbssa@...360...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/621
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/windows-options.rst
index e87291f..1955869 100644
--- a/doc/man-sections/windows-options.rst
+++ b/doc/man-sections/windows-options.rst
@@ -55,6 +55,13 @@
 
      cryptoapicert "ISSUER:Sample CA"
 
+  To select a certificate based on a certificate's template name or
+  OID of the template:
+  ::
+
+     cryptoapicert "TMPL:Name of Template"
+     cryptoapicert "TMPL:1.3.6.1.4..."
+
   The first non-expired certificate found in the user's store or the
   machine store that matches the select-string is used.
 
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index f7e5b67..0cf8e2b 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -178,6 +178,87 @@
     return i;
 }
 
+static void *
+decode_object(struct gc_arena *gc, LPCSTR struct_type,
+              const CRYPT_OBJID_BLOB *val, DWORD flags, DWORD *cb)
+{
+    /* get byte count for decoding */
+    BYTE *buf;
+    if (!CryptDecodeObject(X509_ASN_ENCODING | PKCS_7_ASN_ENCODING, struct_type,
+                           val->pbData, val->cbData, flags, NULL, cb))
+    {
+        return NULL;
+    }
+
+    /* do the actual decode */
+    buf = gc_malloc(*cb, false, gc);
+    if (!CryptDecodeObject(X509_ASN_ENCODING | PKCS_7_ASN_ENCODING, struct_type,
+                           val->pbData, val->cbData, flags, buf, cb))
+    {
+        return NULL;
+    }
+
+    return buf;
+}
+
+static const CRYPT_OID_INFO *
+find_oid(DWORD keytype, const void *key, DWORD groupid)
+{
+    const CRYPT_OID_INFO *info = NULL;
+
+    /* try proper resolve, also including AD */
+    info = CryptFindOIDInfo(keytype, (void*)key, groupid);
+
+    /* fall back to all groups if not found yet and fallback requested */
+    if (!info && groupid)
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
+    /* check for V2 extension (Windows 2003+) */
+    ext = CertFindExtension(szOID_CERTIFICATE_TEMPLATE, info->cExtension, info->rgExtension);
+    if (ext)
+    {
+        pvext = decode_object(&gc, X509_CERTIFICATE_TEMPLATE, &ext->Value, 0, &cbext);
+        if (pvext && cbext >= sizeof(CERT_TEMPLATE_EXT))
+        {
+            const CERT_TEMPLATE_EXT *cte = (const CERT_TEMPLATE_EXT*)pvext;
+            if (!stricmp(cert_prop, cte->pszObjId))
+            {
+                /* found direct OID match with certificate property specified */
+                gc_free(&gc);
+                return true;
+            }
+
+            const CRYPT_OID_INFO *tmpl_oid = find_oid(CRYPT_OID_INFO_NAME_KEY, tmpl_name,
+                                                      CRYPT_TEMPLATE_OID_GROUP_ID);
+            if (tmpl_oid && !stricmp(tmpl_oid->pszOID, cte->pszObjId))
+            {
+                /* found OID match in extension against resolved key */
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
@@ -186,6 +267,7 @@
      * SUBJ:<certificate substring to match>
      * THUMB:<certificate thumbprint hex value>, e.g.
      *     THUMB:f6 49 24 41 01 b4 fb 44 0c ce f4 36 ae d0 c4 c9 df 7a b6 28
+     * TMPL:<template name or OID>
      * The first matching certificate that has not expired is returned.
      */
     const CERT_CONTEXT *rv = NULL;
@@ -218,6 +300,12 @@
             goto out;
         }
     }
+    else if (!strncmp(cert_prop, "TMPL:", 5))
+    {
+        cert_prop += 5;
+        find_param = NULL;
+        find_type = CERT_FIND_HAS_PRIVATE_KEY;
+    }
     else
     {
         msg(M_NONFATAL, "Error in cryptoapicert: unsupported certificate specification <%s>", cert_prop);
@@ -230,11 +318,18 @@
         /* this frees previous rv, if not NULL */
         rv = CertFindCertificateInStore(cert_store, X509_ASN_ENCODING | PKCS_7_ASN_ENCODING,
                                         0, find_type, find_param, rv);
-        if (rv)
+        if (!rv)
         {
-            validity = CertVerifyTimeValidity(NULL, rv->pCertInfo);
+            break;
         }
-        if (!rv || validity == 0)
+        /* if searching by template name, check now if it matches */
+        if (find_type == CERT_FIND_HAS_PRIVATE_KEY
+            && !test_certificate_template(cert_prop, rv))
+        {
+            continue;
+        }
+        validity = CertVerifyTimeValidity(NULL, rv->pCertInfo);
+        if (validity == 0)
         {
             break;
         }

