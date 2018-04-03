From: selva.nair@...277...
Date: Tue,  3 Apr 2018 00:30:42 -0400
Message-Id: <1522729843-28878-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1520817479-17203-1-git-send-email-selva.nair@...277...>
References: <1520817479-17203-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2 1/2] Skip expired certificates in Windows
 certificate store
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

Have the cryptoapicert option find the first matching certificate
in store that is valid at the present time. Currently the first
found item, even if expired, is returned.

This makes it possible to update certifiates in store without having
to delete old ones. As a side effect, if only expired certificates are
found, the connection fails.

Also remove some unnecessary casts.

Tested on Windows 10.
Trac #966

Signed-off-by: Selva Nair <selva.nair@...277...>
---
v2: remove the break after return 

 src/openvpn/cryptoapi.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 11b971f..ec7569a 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -601,27 +601,31 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
      * SUBJ:<certificate substring to match>
      * THUMB:<certificate thumbprint hex value>, e.g.
      *     THUMB:f6 49 24 41 01 b4 fb 44 0c ce f4 36 ae d0 c4 c9 df 7a b6 28
+     * The first matching certificate that has not expired is returned.
      */
     const CERT_CONTEXT *rv = NULL;
+    DWORD find_type;
+    const void *find_param;
+    unsigned char hash[255];
+    CRYPT_HASH_BLOB blob = {.cbData = 0, .pbData = hash};
 
     if (!strncmp(cert_prop, "SUBJ:", 5))
     {
         /* skip the tag */
-        cert_prop += 5;
-        rv = CertFindCertificateInStore(cert_store, X509_ASN_ENCODING | PKCS_7_ASN_ENCODING,
-                                        0, CERT_FIND_SUBJECT_STR_A, cert_prop, NULL);
-
+        find_param = cert_prop + 5;
+        find_type = CERT_FIND_SUBJECT_STR_A;
     }
     else if (!strncmp(cert_prop, "THUMB:", 6))
     {
-        unsigned char hash[255];
-        char *p;
+        const char *p;
         int i, x = 0;
-        CRYPT_HASH_BLOB blob;
+        find_type = CERT_FIND_HASH;
+        find_param = &blob;
 
         /* skip the tag */
         cert_prop += 6;
-        for (p = (char *) cert_prop, i = 0; *p && i < sizeof(hash); i++) {
+        for (p = cert_prop, i = 0; *p && i < sizeof(hash); i++)
+        {
             if (*p >= '0' && *p <= '9')
             {
                 x = (*p - '0') << 4;
@@ -636,7 +640,8 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
             }
             if (!*++p)  /* unexpected end of string */
             {
-                break;
+                msg(M_WARN, "WARNING: cryptoapicert: error parsing <THUMB:%s>.", cert_prop);
+                return NULL;
             }
             if (*p >= '0' && *p <= '9')
             {
@@ -657,10 +662,23 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
             }
         }
         blob.cbData = i;
-        blob.pbData = (unsigned char *) &hash;
+    }
+    while(true)
+    {
+        int validity = 1;
+        /* this frees previous rv, if not NULL */
         rv = CertFindCertificateInStore(cert_store, X509_ASN_ENCODING | PKCS_7_ASN_ENCODING,
-                                        0, CERT_FIND_HASH, &blob, NULL);
-
+                                        0, find_type, find_param, rv);
+        if (rv)
+        {
+            validity = CertVerifyTimeValidity(NULL, rv->pCertInfo);
+        }
+        if (!rv || validity == 0)
+        {
+            break;
+        }
+        msg(M_WARN, "WARNING: cryptoapicert: ignoring certificate in store %s.",
+            validity < 0 ? "not yet valid" : "that has expired");
     }
 
     return rv;
-- 
2.1.4


