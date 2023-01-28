From: selva.nair@...277...
Date: Sat, 28 Jan 2023 17:34:19 -0500
Message-Id: <20230128223421.2207802-3-selva.nair@...277...>
In-Reply-To: <20230128223421.2207802-1-selva.nair@...277...>
References: <20230128223421.2207802-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/4] cyryptapi.c: log the selected
 certificate's name
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

- With various ways of specifying the selector-string to the
  "--cryptoapicert" option, its not immediately obvious
  which certificate gets selected from the store. Log it.

  The "name" logged is a friendly name (if present), or a
  representative element of the subject (usually the common-name).

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/cryptoapi.c  | 29 +++++++++++++++++++++++++++++
 src/openvpn/win32-util.c | 15 +++++++++++++++
 src/openvpn/win32-util.h |  3 +++
 3 files changed, 47 insertions(+)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 39eeec1b..e3c0bc99 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -939,12 +939,31 @@ xkey_cng_sign(void *handle, unsigned char *sig, size_t *siglen, const unsigned c
 
 #endif /* HAVE_XKEY_PROVIDER */
 
+static char *
+get_cert_name(const CERT_CONTEXT *cc, struct gc_arena *gc)
+{
+    DWORD len = CertGetNameStringW(cc, CERT_NAME_FRIENDLY_DISPLAY_TYPE, 0, NULL, NULL, 0);
+    char *name = NULL;
+    if (len)
+    {
+        wchar_t *wname = gc_malloc(len*sizeof(wchar_t), false, gc);
+        if (!wname
+            || CertGetNameStringW(cc, CERT_NAME_FRIENDLY_DISPLAY_TYPE, 0, NULL, wname, len) == 0)
+        {
+            return NULL;
+        }
+        name = utf16to8(wname, gc);
+    }
+    return name;
+}
+
 int
 SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
 {
     HCERTSTORE cs;
     X509 *cert = NULL;
     CAPI_DATA *cd = calloc(1, sizeof(*cd));
+    struct gc_arena gc = gc_new();
 
     if (cd == NULL)
     {
@@ -979,6 +998,13 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
         }
     }
 
+    /* try to log the "name" of the selected certificate */
+    char *cert_name = get_cert_name(cd->cert_context, &gc);
+    if (cert_name)
+    {
+        msg(D_LOW, "cryptapicert: using certificate with name <%s>", cert_name);
+    }
+
     /* cert_context->pbCertEncoded is the cert X509 DER encoded. */
     cert = d2i_X509(NULL, (const unsigned char **) &cd->cert_context->pbCertEncoded,
                     cd->cert_context->cbCertEncoded);
@@ -1022,6 +1048,7 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     EVP_PKEY *privkey = xkey_load_generic_key(tls_libctx, cd, pkey,
                                               xkey_cng_sign, (XKEY_PRIVKEY_FREE_fn *) CAPI_DATA_free);
     SSL_CTX_use_PrivateKey(ssl_ctx, privkey);
+    gc_free(&gc);
     return 1; /* do not free cd -- its kept by xkey provider */
 
 #else  /* ifdef HAVE_XKEY_PROVIDER */
@@ -1047,12 +1074,14 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
         goto err;
     }
     CAPI_DATA_free(cd); /* this will do a ref_count-- */
+    gc_free(gc);
     return 1;
 
 #endif /* HAVE_XKEY_PROVIDER */
 
 err:
     CAPI_DATA_free(cd);
+    gc_free(&gc);
     return 0;
 }
 #endif                          /* _WIN32 */
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index 35f2a311..32f7a00b 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -48,6 +48,21 @@ wide_string(const char *utf8, struct gc_arena *gc)
     return ucs16;
 }
 
+char *
+utf16to8(const wchar_t *utf16, struct gc_arena *gc)
+{
+    char *utf8 = NULL;
+    int n = WideCharToMultiByte(CP_UTF8, 0, utf16, -1, NULL, 0, NULL, NULL);
+    if (n > 0)
+    {
+        utf8 = gc_malloc(n, true, gc);
+        if (utf8)
+        {
+            WideCharToMultiByte(CP_UTF8, 0, utf16, -1, utf8, n, NULL, NULL);
+        }
+    }
+    return utf8;
+}
 
 /*
  * Return true if filename is safe to be used on Windows,
diff --git a/src/openvpn/win32-util.h b/src/openvpn/win32-util.h
index b24242c8..ac37979f 100644
--- a/src/openvpn/win32-util.h
+++ b/src/openvpn/win32-util.h
@@ -34,6 +34,9 @@
 /* Convert a string from UTF-8 to UCS-2 */
 WCHAR *wide_string(const char *utf8, struct gc_arena *gc);
 
+/* Convert a string from UTF-16 to UTF-8 */
+char *utf16to8(const wchar_t *utf16, struct gc_arena *gc);
+
 /* return true if filename is safe to be used on Windows */
 bool win_safe_filename(const char *fn);
 
-- 
2.34.1


