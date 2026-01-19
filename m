From: Gert Doering <gert@...1296...>
Date: Mon, 19 Jan 2026 12:37:42 +0100
Message-ID: <20260119113747.10912-1-gert@...1296...>
In-Reply-To: <gerrit.1768224415000.I789022af7c4977c4dff4f7671f491fe5836828fa@...2715...>
References: <gerrit.1768224415000.I789022af7c4977c4dff4f7671f491fe5836828fa@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] cryptoapi: Avoid conversion warnings
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

From: Frank Lichtenheld <frank@...2641...>

Due to the differences in the types of APIs
between xkey provider and Windows cryptoapi
we can't avoid the casts. And they should be
safe generally since the involved sizes should
be small compared to the maximum values. So
just add asserts and explicit cast to avoid
the warnings.

Change-Id: I789022af7c4977c4dff4f7671f491fe5836828fa
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Selva Nair <selva.nair@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1464
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1464
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Selva Nair <selva.nair@...277...>

        
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index b18b9d4..49f5bbb 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -61,7 +61,7 @@
     return 0;
 }
 
-#else /* HAVE_XKEY_PROVIDER */
+#else  /* HAVE_XKEY_PROVIDER */
 
 static XKEY_EXTERNAL_SIGN_fn xkey_cng_sign;
 
@@ -341,21 +341,18 @@
     return rv;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /** Sign hash in tbs using EC key in cd and NCryptSignHash */
 static int
 xkey_cng_ec_sign(CAPI_DATA *cd, unsigned char *sig, size_t *siglen, const unsigned char *tbs,
                  size_t tbslen)
 {
-    DWORD len = *siglen;
+    ASSERT(*siglen <= UINT_MAX);
+    ASSERT(tbslen <= UINT_MAX);
+    DWORD len = (DWORD)*siglen;
 
     msg(D_LOW, "Signing using NCryptSignHash with EC key");
 
-    DWORD status = NCryptSignHash(cd->crypt_prov, NULL, (BYTE *)tbs, tbslen, sig, len, &len, 0);
+    DWORD status = NCryptSignHash(cd->crypt_prov, NULL, (BYTE *)tbs, (DWORD)tbslen, sig, len, &len, 0);
 
     if (status != ERROR_SUCCESS)
     {
@@ -383,7 +380,9 @@
 
     ASSERT(cd);
     ASSERT(sig);
+    ASSERT(*siglen <= UINT_MAX);
     ASSERT(tbs);
+    ASSERT(tbslen <= INT_MAX);
 
     DWORD status = ERROR_SUCCESS;
     DWORD len = 0;
@@ -406,10 +405,10 @@
     }
     else if (!strcmp(sigalg.padmode, "pss"))
     {
-        int saltlen = tbslen; /* digest size by default */
+        int saltlen = (int)tbslen; /* digest size by default */
         if (!strcmp(sigalg.saltlen, "max"))
         {
-            saltlen = xkey_max_saltlen(EVP_PKEY_bits(cd->pubkey), tbslen);
+            saltlen = xkey_max_saltlen(EVP_PKEY_bits(cd->pubkey), saltlen);
             if (saltlen < 0)
             {
                 msg(M_NONFATAL, "Error in cryptoapicert: invalid salt length (%d)", saltlen);
@@ -420,8 +419,8 @@
         msg(D_LOW, "Signing using NCryptSignHash with PSS padding: hashalg <%s>, saltlen <%d>",
             sigalg.mdname, saltlen);
 
-        BCRYPT_PSS_PADDING_INFO padinfo = { hashalg,
-                                            (DWORD)saltlen }; /* cast is safe as saltlen >= 0 */
+        /* cast is safe as saltlen >= 0 */
+        BCRYPT_PSS_PADDING_INFO padinfo = { hashalg, (DWORD)saltlen };
         status = NCryptSignHash(cd->crypt_prov, &padinfo, (BYTE *)tbs, (DWORD)tbslen, sig,
                                 (DWORD)*siglen, &len, BCRYPT_PAD_PSS);
     }
@@ -442,10 +441,6 @@
     return (*siglen > 0);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /** Dispatch sign op to xkey_cng_<rsa/ec>_sign */
 static int
 xkey_cng_sign(void *handle, unsigned char *sig, size_t *siglen, const unsigned char *tbs,

