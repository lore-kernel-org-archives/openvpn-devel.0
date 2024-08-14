From: "selvanair (Code Review)" <gerrit@...515...>
Date: Wed, 14 Aug 2024 22:19:32 +0000
References: <gerrit.1723673969000.I82b32d5ab472926e7889a5f4a90caba14231879a@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1e7f00068be1a2a2ea036ab40f128f65c04d53e5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9g2H6BdEzVk="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Interpret --key and
 --cert option argument as URI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9g2H6BdEzVk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/726?usp=3Demail

to review the following change.


Change subject: Interpret --key and --cert option argument as URI
......................................................................

Interpret --key and --cert option argument as URI

OpenSSL 3 has providers which can load keys and certificates
from various key stores and HSMs using a provider-specific URI.
While certificates are generally exportable, and some providers
support a PEM file that acts as a proxy for non-exportable private
keys, not all providers are expected to do so. A generic capability
to read keys and certificates from URIs appears useful.

This patch does this by extending the scope of the argument for
"--key" and "--cert" options to include URIs. Many of OpenSSL 3
utilities also work the same way: e.g., the "-in" option for
"openssl pkey" or "openssl x509" could be a filename or URI.
Other applications have started emulating this behaviour:
e.g., pkcs11: URI works as an alternative to a file name for
certificates and keys in apache. Even for files, this has a nice
side effect that non-PEM files get transparently parsed. E.g., a
pkcs12 file could be used in place of a PEM file without needing
any extra options.

This is backward compatible as OpenSSL falls back to treating URIs
with no scheme or unrecognized scheme as file names.

Parsing of inlined keys and certificates is unchanged (those
should be in PEM format).

Specification of URIs that OpenSSL accepts depends on the
providers that support them. Some are standard URIs such as
"file:/path", but providers may support non-standard URIs
with arbitrary scheme names. OpenSSL by itself recognizes
only file URI.  However, the implementation is agnostic to the
URI specification as parsing is done by the provider that supports
the URI. A new URI gets automatically recognized when the provider
that supports it is loaded.

Below are some usage examples:

Relative or absolute path to a file or as a URI "file:/absolute/path":

   --key mykey.pem      (same as what is currently supported)
   --key file:/path/to/mykey.pem
   --cert file:/path/to/mycert.pem

Other file types supported by OpenSSL would also work:

   --key client.p12
   --cert client.p12

pkcs11-provider supports "pkcs11:" URI (RFC 7512):

   --key pkcs11:token=3DFoo;id=3D%01
   --cert pkcs11:token=3DFoo;id=3D%01

tpm2-provider recognizes a custom URI "handle:<hex>":

   --key handle:0x81000000

These examples assume that required providers, if any, are loaded
and configured.

Change-Id: I82b32d5ab472926e7889a5f4a90caba14231879a
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M doc/man-sections/tls-options.rst
M src/openvpn/options.c
M src/openvpn/ssl_openssl.c
M tests/unit_tests/openvpn/test_ssl.c
4 files changed, 280 insertions(+), 27 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/726/1

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst
index de74c0d..cdb8571 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -85,10 +85,17 @@
   OpenVPN will log the usual warning in the logs if the relevant CRL is
   missing, but the connection will be allowed.

---cert file
-  Local peer's signed certificate in .pem format -- must be signed by a
-  certificate authority whose certificate is in ``--ca file``. Each peer
-  in an OpenVPN link running in TLS mode should have its own certificate
+--cert file|uri
+  Local peer's signed certificate in .pem format or as a URI -- must be
+  signed by a certificate authority whose certificate is in ``--ca file``
+  in the peer configuration. URI is supported only when built with
+  OpenSSL 3.0 or later and any required providers are loaded. Types
+  of URIs supported and their syntax depends on providers. OpenSSL has
+  internal support for "file:/absolute/path" URI in which case the scheme
+  "file:" is optional, and any file format recognized by OpenSSL (e.g., PE=
M,
+  PKCS12) is supported. PKCS#11 URI (RFC 7512) is supported by pkcs11-prov=
ider.
+
+  Each peer in an OpenVPN link running in TLS mode should have its own cer=
tificate
   and private key file. In addition, each certificate should have been
   signed by the key of a certificate authority whose public key resides in
   the ``--ca`` certificate authority file. You can easily make your own
@@ -203,10 +210,11 @@
   The ``--hand-window`` parameter also controls the amount of time that
   the OpenVPN client repeats the pull request until it times out.

---key file
-  Local peer's private key in .pem format. Use the private key which was
-  generated when you built your peer's certificate (see ``--cert file``
-  above).
+--key file|uri
+  Local peer's private key in .pem format or a URI. Use the private key
+  which was generated when you built your peer's certificate (see
+  ``--cert file`` above). URI is supported only when built with OpenSSL 3.0
+  or later and any required providers are loaded. (See `--cert` for more d=
etails).

 --pkcs12 file
   Specify a PKCS #12 file containing local private key, local certificate,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ba9b05e..a5f0784 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -567,10 +567,10 @@
     "--dh file       : File containing Diffie Hellman parameters\n"
     "                  in .pem format (for --tls-server only).\n"
     "                  Use \"openssl dhparam -out dh1024.pem 1024\" to gen=
erate.\n"
-    "--cert file     : Local certificate in .pem format -- must be signed\=
n"
-    "                  by a Certificate Authority in --ca file.\n"
+    "--cert file     : Local certificate in .pem format or a URI -- must b=
e signed\n"
+    "                  by a Certificate Authority in --ca file used by the=
 peer.\n"
     "--extra-certs file : one or more PEM certs that complete the cert cha=
in.\n"
-    "--key file      : Local private key in .pem format.\n"
+    "--key file      : Local private key in .pem format or a URI.\n"
     "--tls-version-min <version> ['or-highest'] : sets the minimum TLS ver=
sion we\n"
     "    will accept from the peer.  If version is unrecognized and 'or-hi=
ghest'\n"
     "    is specified, require max TLS version supported by SSL implementa=
tion.\n"
@@ -3851,6 +3851,7 @@
 #define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is it writable? */
 #define CHKACC_ACPTSTDIN (1<<3)  /** If filename is stdin, it's allowed an=
d "exists" */
 #define CHKACC_PRIVATE (1<<4)    /** Warn if this (private) file is group/=
others accessible */
+#define CHKACC_ACCEPT_URI (1<<5) /** If filename is a URI, no check is don=
e unless it starts with file: */

 static bool
 check_file_access(const int type, const char *file, const int mode, const =
char *opt)
@@ -3871,6 +3872,21 @@
         return false;
     }

+    /* file name is a URI if its first segment  has ":" (i.e., before any =
"/")
+     * Then no checks done if CHKACC_ACCEPT_URI is set and the URI does no=
t start with "file:"
+     */
+    if ((type & CHKACC_ACCEPT_URI) && strchr(file, ':'))
+    {
+        if (!strncmp(file, "file:", 5))
+        {
+            file +=3D 5;
+        }
+        else if (!strchr(file, '/') || strchr(file, '/') > strchr(file, ':=
'))
+        {
+            return false;
+        }
+    }
+
     /* Is the directory path leading to the given file accessible? */
     if (type & CHKACC_DIRPATH)
     {
@@ -4069,7 +4085,7 @@
     errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE,
                                      options->ca_path, R_OK, "--capath");

-    errs |=3D check_file_access_inline(options->cert_file_inline, CHKACC_F=
ILE,
+    errs |=3D check_file_access_inline(options->cert_file_inline, CHKACC_F=
ILE|CHKACC_ACCEPT_URI,
                                      options->cert_file, R_OK, "--cert");

     errs |=3D check_file_access_inline(options->extra_certs_file, CHKACC_F=
ILE,
@@ -4079,7 +4095,7 @@
     if (!(options->management_flags & MF_EXTERNAL_KEY))
     {
         errs |=3D check_file_access_inline(options->priv_key_file_inline,
-                                         CHKACC_FILE|CHKACC_PRIVATE,
+                                         CHKACC_FILE|CHKACC_PRIVATE|CHKACC=
_ACCEPT_URI,
                                          options->priv_key_file, R_OK, "--=
key");
     }

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index e8a30a3..05555a3 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -65,6 +65,12 @@
 #include <openssl/ec.h>
 #endif

+#if OPENSSL_VERSION_NUMBER >=3D 0x30000000L
+#define HAVE_OPENSSL_STORE_API
+#include <openssl/ui.h>
+#include <openssl/store.h>
+#endif
+
 #if defined(_MSC_VER) && !defined(_M_ARM64)
 #include <openssl/applink.c>
 #endif
@@ -768,6 +774,111 @@
 #endif /* OPENSSL_NO_EC */
 }

+#if defined(HAVE_OPENSSL_STORE_API)
+/**
+ * A wrapper for pem_password_callback for use with OpenSSL UI_METHOD.
+ */
+static int
+ui_reader(UI *ui, UI_STRING *uis)
+{
+    SSL_CTX *ctx =3D UI_get0_user_data(ui);
+
+    if (UI_get_string_type(uis) =3D=3D UIT_PROMPT)
+    {
+        const char *prompt =3D UI_get0_output_string(uis);
+
+        /* If pkcs#11 Use custom prompt similar to pkcs11-helper */
+        if (strstr(prompt, "PKCS#11"))
+        {
+            struct user_pass up;
+            get_user_pass(&up, NULL, "PKCS#11 token", GET_USER_PASS_MANAGE=
MENT|GET_USER_PASS_PASSWORD_ONLY);
+            UI_set_result(ui, uis, up.password);
+            purge_user_pass(&up, true);
+        }
+        else /* use our generic 'Private Key' passphrase callback */
+        {
+            char password[64];
+            pem_password_cb *cb =3D SSL_CTX_get_default_passwd_cb(ctx);
+            void *d =3D SSL_CTX_get_default_passwd_cb_userdata(ctx);
+
+            cb(password, sizeof(password), 0, d);
+            UI_set_result(ui, uis, password);
+            secure_memzero(password, sizeof(password));
+        }
+
+        return 1;
+    }
+    return 0;
+}
+#endif /* defined(HAVE_OPENSSL_STORE_API) */
+
+/**
+ * Load private key from OSSL_STORE URI or file
+ * uri : URI of object or filename
+ * ssl_ctx : SSL_CTX for UI prompt
+ *
+ * Return a pointer to the key or NULL if not found.
+ * Caller must free the key after use.
+ */
+static void *
+load_pkey_from_uri(const char *uri, SSL_CTX *ssl_ctx)
+{
+    EVP_PKEY *pkey =3D NULL;
+
+#if !defined(HAVE_OPENSSL_STORE_API)
+
+    /* Treat the uri as file name */
+    BIO *in =3D BIO_new_file(uri, "r");
+    if (!in)
+    {
+        return NULL;
+    }
+    pkey =3D PEM_read_bio_PrivateKey(in, NULL,
+                                   SSL_CTX_get_default_passwd_cb(ssl_ctx),
+                                   SSL_CTX_get_default_passwd_cb_userdata(=
ssl_ctx));
+    BIO_free(in);
+
+#else /* defined(HAVE_OPENSSL_STORE_API) */
+
+    OSSL_STORE_CTX *store_ctx =3D NULL;
+    OSSL_STORE_INFO *info =3D NULL;
+
+    UI_METHOD *ui_method =3D UI_create_method("openvpn");
+    if (!ui_method)
+    {
+        msg(M_WARN, "OpenSSL UI creation failed");
+        return NULL;
+    }
+    UI_method_set_reader(ui_method, ui_reader);
+
+    store_ctx =3D OSSL_STORE_open_ex(uri, tls_libctx, NULL, ui_method, ssl=
_ctx,
+                                   NULL, NULL, NULL);
+    if (!store_ctx)
+    {
+        goto end;
+    }
+    if (OSSL_STORE_expect(store_ctx, OSSL_STORE_INFO_PKEY) !=3D 1)
+    {
+        goto end;
+    }
+    info =3D OSSL_STORE_load(store_ctx);
+    if (!info)
+    {
+        goto end;
+    }
+    pkey =3D OSSL_STORE_INFO_get1_PKEY(info);
+    OSSL_STORE_INFO_free(info);
+    msg(D_TLS_DEBUG_MED, "Found pkey in store using URI: %s", uri);
+
+end:
+    OSSL_STORE_close(store_ctx);
+    UI_destroy_method(ui_method);
+
+#endif /* defined(HAVE_OPENSSL_STORE_API) */
+
+    return pkey;
+}
+
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
                     bool pkcs12_file_inline, bool load_ca_file)
@@ -945,9 +1056,103 @@
     }
 }

-void
-tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
-                       bool cert_file_inline)
+static bool
+cert_uri_supported(void)
+{
+#if defined(HAVE_OPENSSL_STORE_API)
+    return 1;
+#else
+    return 0;
+#endif
+}
+
+static void
+tls_ctx_load_cert_uri(struct tls_root_ctx *tls_ctx, const char *uri)
+{
+#if defined(HAVE_OPENSSL_STORE_API)
+    X509 *x =3D NULL;
+    int ret =3D 0;
+    OSSL_STORE_CTX *store_ctx =3D NULL;
+    OSSL_STORE_INFO *info =3D NULL;
+
+    ASSERT(NULL !=3D tls_ctx);
+
+    UI_METHOD *ui_method =3D UI_create_method("openvpn");
+    if (!ui_method)
+    {
+        msg(M_WARN, "OpenSSL UI method creation failed");
+        goto end;
+    }
+    UI_method_set_reader(ui_method, ui_reader);
+
+    store_ctx =3D OSSL_STORE_open_ex(uri, tls_libctx, NULL, ui_method, tls=
_ctx->ctx,
+                                   NULL, NULL, NULL);
+    if (!store_ctx)
+    {
+        goto end;
+    }
+    if (OSSL_STORE_expect(store_ctx, OSSL_STORE_INFO_CERT) !=3D 1)
+    {
+        goto end;
+    }
+
+    info =3D OSSL_STORE_load(store_ctx);
+    if (!info)
+    {
+        goto end;
+    }
+
+    x =3D OSSL_STORE_INFO_get0_CERT(info);
+    if (x =3D=3D NULL)
+    {
+        goto end;
+    }
+    msg(D_TLS_DEBUG_MED, "Found cert in store using URI: %s", uri);
+
+    ret =3D SSL_CTX_use_certificate(tls_ctx->ctx, x);
+    if (!ret)
+    {
+        goto end;
+    }
+    OSSL_STORE_INFO_free(info);
+
+    /* iterate through the store and add extra certificates if any to the =
chain */
+    info =3D OSSL_STORE_load(store_ctx);
+    while (info && !OSSL_STORE_eof(store_ctx))
+    {
+        x =3D OSSL_STORE_INFO_get1_CERT(info);
+        if (x && SSL_CTX_add_extra_chain_cert(tls_ctx->ctx, x) !=3D 1)
+        {
+            X509_free(x);
+            crypto_msg(M_FATAL, "Error adding extra certificate");
+            break;
+        }
+        OSSL_STORE_INFO_free(info);
+        info =3D OSSL_STORE_load(store_ctx);
+    }
+
+end:
+    if (!ret)
+    {
+        crypto_print_openssl_errors(M_WARN);
+        crypto_msg(M_FATAL, "Cannot load certificate from URI <%s>", uri);
+    }
+    else
+    {
+        crypto_print_openssl_errors(M_DEBUG);
+    }
+
+    UI_destroy_method(ui_method);
+    OSSL_STORE_INFO_free(info);
+    OSSL_STORE_close(store_ctx);
+#else /* defined(HAVE_OPENSSL_STORE_API */
+    ASSERT(0);
+#endif /* defined(HAVE_OPENSSL_STORE_API */
+}
+
+static void
+tls_ctx_load_cert_pem_file(struct tls_root_ctx *ctx, const char *cert_file,
+                           bool cert_file_inline)
 {
     BIO *in =3D NULL;
     X509 *x =3D NULL;
@@ -961,7 +1166,7 @@
     }
     else
     {
-        in =3D BIO_new_file(cert_file, "r");
+        in =3D BIO_new_file((char *) cert_file, "r");
     }

     if (in =3D=3D NULL)
@@ -1007,6 +1212,20 @@
     X509_free(x);
 }

+void
+tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
+                       bool cert_file_inline)
+{
+    if (cert_uri_supported() && !cert_file_inline)
+    {
+        tls_ctx_load_cert_uri(ctx, cert_file);
+    }
+    else
+    {
+        tls_ctx_load_cert_pem_file(ctx, cert_file, cert_file_inline);
+    }
+}
+
 int
 tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
                        bool priv_key_file_inline)
@@ -1023,21 +1242,19 @@
     if (priv_key_file_inline)
     {
         in =3D BIO_new_mem_buf((char *) priv_key_file, -1);
+        if (in =3D=3D NULL)
+        {
+            goto end;
+        }
+        pkey =3D PEM_read_bio_PrivateKey(in, NULL,
+                                       SSL_CTX_get_default_passwd_cb(ctx->=
ctx),
+                                       SSL_CTX_get_default_passwd_cb_userd=
ata(ctx->ctx));
     }
     else
     {
-        in =3D BIO_new_file(priv_key_file, "r");
+        pkey =3D load_pkey_from_uri(priv_key_file, ssl_ctx);
     }

-    if (!in)
-    {
-        goto end;
-    }
-
-    pkey =3D PEM_read_bio_PrivateKey(in, NULL,
-                                   SSL_CTX_get_default_passwd_cb(ctx->ctx),
-                                   SSL_CTX_get_default_passwd_cb_userdata(=
ctx->ctx));
-
     if (!pkey || !SSL_CTX_use_PrivateKey(ssl_ctx, pkey))
     {
 #ifdef ENABLE_MANAGEMENT
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 5da5b1c..da375af 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -66,6 +66,18 @@
 }
 #endif

+/* stubs for some unused functions instead of pulling in too many dependen=
cies */
+bool
+get_user_pass_cr(struct user_pass *up, const char *auth_file, const char *=
prefix,
+                 const unsigned int flags, const char *auth_challenge)
+{
+    return false;
+}
+void
+purge_user_pass(struct user_pass *up, bool force)
+{
+    return;
+}

 const char *unittest_cert =3D "-----BEGIN CERTIFICATE-----\n"
                             "MIIBuTCCAUCgAwIBAgIUTLtjSBzx53qZRvZ6Ur7D9kgoO=
HkwCgYIKoZIzj0EAwIw\n"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/726?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I82b32d5ab472926e7889a5f4a90caba14231879a
Gerrit-Change-Number: 726
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--9g2H6BdEzVk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>selvanair would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/726?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Interpret --key and --cert option argument as URI<br><br>Open=
SSL 3 has providers which can load keys and certificates<br>from various ke=
y stores and HSMs using a provider-specific URI.<br>While certificates are =
generally exportable, and some providers<br>support a PEM file that acts as=
 a proxy for non-exportable private<br>keys, not all providers are expected=
 to do so. A generic capability<br>to read keys and certificates from URIs =
appears useful.<br><br>This patch does this by extending the scope of the a=
rgument for<br>&quot;--key&quot; and &quot;--cert&quot; options to include =
URIs. Many of OpenSSL 3<br>utilities also work the same way: e.g., the &quo=
t;-in&quot; option for<br>&quot;openssl pkey&quot; or &quot;openssl x509&qu=
ot; could be a filename or URI.<br>Other applications have started emulatin=
g this behaviour:<br>e.g., pkcs11: URI works as an alternative to a file na=
me for<br>certificates and keys in apache. Even for files, this has a nice<=
br>side effect that non-PEM files get transparently parsed. E.g., a<br>pkcs=
12 file could be used in place of a PEM file without needing<br>any extra o=
ptions.<br><br>This is backward compatible as OpenSSL falls back to treatin=
g URIs<br>with no scheme or unrecognized scheme as file names.<br><br>Parsi=
ng of inlined keys and certificates is unchanged (those<br>should be in PEM=
 format).<br><br>Specification of URIs that OpenSSL accepts depends on the<=
br>providers that support them. Some are standard URIs such as<br>&quot;fil=
e:/path&quot;, but providers may support non-standard URIs<br>with arbitrar=
y scheme names. OpenSSL by itself recognizes<br>only file URI.  However, th=
e implementation is agnostic to the<br>URI specification as parsing is done=
 by the provider that supports<br>the URI. A new URI gets automatically rec=
ognized when the provider<br>that supports it is loaded.<br><br>Below are s=
ome usage examples:<br><br>Relative or absolute path to a file or as a URI =
&quot;file:/absolute/path&quot;:<br><br>   --key mykey.pem      (same as wh=
at is currently supported)<br>   --key file:/path/to/mykey.pem<br>   --cert=
 file:/path/to/mycert.pem<br><br>Other file types supported by OpenSSL woul=
d also work:<br><br>   --key client.p12<br>   --cert client.p12<br><br>pkcs=
11-provider supports &quot;pkcs11:&quot; URI (RFC 7512):<br><br>   --key pk=
cs11:token=3DFoo;id=3D%01<br>   --cert pkcs11:token=3DFoo;id=3D%01<br><br>t=
pm2-provider recognizes a custom URI &quot;handle:&lt;hex&gt;&quot;:<br><br=
>   --key handle:0x81000000<br><br>These examples assume that required prov=
iders, if any, are loaded<br>and configured.<br><br>Change-Id: I82b32d5ab47=
2926e7889a5f4a90caba14231879a<br>Signed-off-by: Selva Nair &lt;selva.nair@...220...=
..277...&gt;<br>---<br>M doc/man-sections/tls-options.rst<br>M src/openvpn/=
options.c<br>M src/openvpn/ssl_openssl.c<br>M tests/unit_tests/openvpn/test=
_ssl.c<br>4 files changed, 280 insertions(+), 27 deletions(-)<br><br></pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/726/1</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst</span><br><span>index de74c0d..cdb8571 100644</span><br><span>--- a/d=
oc/man-sections/tls-options.rst</span><br><span>+++ b/doc/man-sections/tls-=
options.rst</span><br><span>@@ -85,10 +85,17 @@</span><br><span>   OpenVPN =
will log the usual warning in the logs if the relevant CRL is</span><br><sp=
an>   missing, but the connection will be allowed.</span><br><span> </span>=
<br><span>---cert file</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  Local peer&#39;s signed certificate in .pem format -- must be signed by =
a</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  certificate author=
ity whose certificate is in ``--ca file``. Each peer</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  in an OpenVPN link running in TLS mode sh=
ould have its own certificate</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+--cert file|uri</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  Local peer&#39;s signed certificate in .pem format or as a URI -- m=
ust be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  signed by a=
 certificate authority whose certificate is in ``--ca file``</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  in the peer configuration. URI i=
s supported only when built with</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  OpenSSL 3.0 or later and any required providers are loaded. =
Types</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  of URIs supp=
orted and their syntax depends on providers. OpenSSL has</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  internal support for &quot;file:/abs=
olute/path&quot; URI in which case the scheme</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &quot;file:&quot; is optional, and any file for=
mat recognized by OpenSSL (e.g., PEM,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  PKCS12) is supported. PKCS#11 URI (RFC 7512) is support=
ed by pkcs11-provider.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Each peer in a=
n OpenVPN link running in TLS mode should have its own certificate</span><b=
r><span>   and private key file. In addition, each certificate should have =
been</span><br><span>   signed by the key of a certificate authority whose =
public key resides in</span><br><span>   the ``--ca`` certificate authority=
 file. You can easily make your own</span><br><span>@@ -203,10 +210,11 @@</=
span><br><span>   The ``--hand-window`` parameter also controls the amount =
of time that</span><br><span>   the OpenVPN client repeats the pull request=
 until it times out.</span><br><span> </span><br><span>---key file</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  Local peer&#39;s private key=
 in .pem format. Use the private key which was</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  generated when you built your peer&#39;s certifi=
cate (see ``--cert file``</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  above).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--key =
file|uri</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Local pee=
r&#39;s private key in .pem format or a URI. Use the private key</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  which was generated when you=
 built your peer&#39;s certificate (see</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  ``--cert file`` above). URI is supported only when bu=
ilt with OpenSSL 3.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  or later and any required providers are loaded. (See `--cert` for more d=
etails).</span><br><span> </span><br><span> --pkcs12 file</span><br><span> =
  Specify a PKCS #12 file containing local private key, local certificate,<=
/span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c<=
/span><br><span>index ba9b05e..a5f0784 100644</span><br><span>--- a/src/ope=
nvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>=
@@ -567,10 +567,10 @@</span><br><span>     &quot;--dh file       : File con=
taining Diffie Hellman parameters\n&quot;</span><br><span>     &quot;      =
            in .pem format (for --tls-server only).\n&quot;</span><br><span=
>     &quot;                  Use \&quot;openssl dhparam -out dh1024.pem 10=
24\&quot; to generate.\n&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    &quot;--cert file     : Local certificate in .pem format -- mu=
st be signed\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   &quot;                  by a Certificate Authority in --ca file.\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--cert fi=
le     : Local certificate in .pem format or a URI -- must be signed\n&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;        =
          by a Certificate Authority in --ca file used by the peer.\n&quot;=
</span><br><span>     &quot;--extra-certs file : one or more PEM certs that=
 complete the cert chain.\n&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    &quot;--key file      : Local private key in .pem format.\n=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--k=
ey file      : Local private key in .pem format or a URI.\n&quot;</span><br=
><span>     &quot;--tls-version-min &lt;version&gt; [&#39;or-highest&#39;] =
: sets the minimum TLS version we\n&quot;</span><br><span>     &quot;    wi=
ll accept from the peer.  If version is unrecognized and &#39;or-highest&#3=
9;\n&quot;</span><br><span>     &quot;    is specified, require max TLS ver=
sion supported by SSL implementation.\n&quot;</span><br><span>@@ -3851,6 +3=
851,7 @@</span><br><span> #define CHKACC_FILEXSTWR (1&lt;&lt;2)  /** If fil=
e exists, is it writable? */</span><br><span> #define CHKACC_ACPTSTDIN (1&l=
t;&lt;3)  /** If filename is stdin, it&#39;s allowed and &quot;exists&quot;=
 */</span><br><span> #define CHKACC_PRIVATE (1&lt;&lt;4)    /** Warn if thi=
s (private) file is group/others accessible */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define CHKACC_ACCEPT_URI (1&lt;&lt;5) /** If fi=
lename is a URI, no check is done unless it starts with file: */</span><br>=
<span> </span><br><span> static bool</span><br><span> check_file_access(con=
st int type, const char *file, const int mode, const char *opt)</span><br><=
span>@@ -3871,6 +3872,21 @@</span><br><span>         return false;</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* file name is a URI if its first segment  has &quot;:&qu=
ot; (i.e., before any &quot;/&quot;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * Then no checks done if CHKACC_ACCEPT_URI is set and=
 the URI does not start with &quot;file:&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if ((type &amp; CHKACC_ACCEPT_URI) &amp;&amp; strchr(fil=
e, &#39;:&#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strn=
cmp(file, &quot;file:&quot;, 5))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            file +=3D 5;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else if (!strchr(file, &#39;/&#39;) || strchr(file, &#39;/&#39;) &gt;=
 strchr(file, &#39;:&#39;))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
  /* Is the directory path leading to the given file accessible? */</span><=
br><span>     if (type &amp; CHKACC_DIRPATH)</span><br><span>     {</span><=
br><span>@@ -4069,7 +4085,7 @@</span><br><span>     errs |=3D check_file_ac=
cess_chroot(options-&gt;chroot_dir, CHKACC_FILE,</span><br><span>          =
                            options-&gt;ca_path, R_OK, &quot;--capath&quot;=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   errs |=3D check_file_access_inline(options-&gt;cert_file_inline, CHKACC_=
FILE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D =
check_file_access_inline(options-&gt;cert_file_inline, CHKACC_FILE|CHKACC_A=
CCEPT_URI,</span><br><span>                                      options-&g=
t;cert_file, R_OK, &quot;--cert&quot;);</span><br><span> </span><br><span> =
    errs |=3D check_file_access_inline(options-&gt;extra_certs_file, CHKACC=
_FILE,</span><br><span>@@ -4079,7 +4095,7 @@</span><br><span>     if (!(opt=
ions-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br><span>     {</s=
pan><br><span>         errs |=3D check_file_access_inline(options-&gt;priv_=
key_file_inline,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                                    CHKACC_FILE|CHKACC_PRIVATE,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
          CHKACC_FILE|CHKACC_PRIVATE|CHKACC_ACCEPT_URI,</span><br><span>   =
                                       options-&gt;priv_key_file, R_OK, &qu=
ot;--key&quot;);</span><br><span>     }</span><br><span> </span><br><span>d=
iff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br=
><span>index e8a30a3..05555a3 100644</span><br><span>--- a/src/openvpn/ssl_=
openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@=
@ -65,6 +65,12 @@</span><br><span> #include &lt;openssl/ec.h&gt;</span><br>=
<span> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_OPENSSL_STORE_API</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;openssl/ui.h=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;op=
enssl/store.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> #if defined(_MSC_VER) &amp;&amp; !defined(_M_ARM64)</span><br><span> #in=
clude &lt;openssl/applink.c&gt;</span><br><span> #endif</span><br><span>@@ =
-768,6 +774,111 @@</span><br><span> #endif /* OPENSSL_NO_EC */</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(HAVE_OPENSSL_STORE_API)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * A wrapper for pem_password_callback for use with OpenSSL UI_METHOD.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ui_reader(UI *ui, UI_STRING *uis)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    SSL_CTX *ctx =3D UI_get0_user_data(ui);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (UI_get_string_type(uis) =3D=3D UI=
T_PROMPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *prom=
pt =3D UI_get0_output_string(uis);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* If pkcs#11 Use custom prompt similar to pkcs11-helper */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (strstr(prompt, &quo=
t;PKCS#11&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
struct user_pass up;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            get_user_pass(&amp;up, NULL, &quot;PKCS#11 token&quot;, GET_US=
ER_PASS_MANAGEMENT|GET_USER_PASS_PASSWORD_ONLY);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            UI_set_result(ui, uis, up.password=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            purge=
_user_pass(&amp;up, true);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     else /* use our generic &#39;Private Key&#39; passphrase callback */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            char password[64];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            pem_pass=
word_cb *cb =3D SSL_CTX_get_default_passwd_cb(ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            void *d =3D SSL_CTX_get_defau=
lt_passwd_cb_userdata(ctx);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 cb(password, sizeof(password), 0, d);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            UI_set_result(ui, uis, password);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            secure_memzero(pas=
sword, sizeof(password));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 1;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif /* defined(HAVE_OPENSSL_STORE_API) */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Load private key from OSSL_STORE URI or file</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * uri : URI of object or filename</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * ssl_ctx : SSL_CTX for UI pr=
ompt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Return a pointer to the key o=
r NULL if not found.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Caller must free the key after use.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static void *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+lo=
ad_pkey_from_uri(const char *uri, SSL_CTX *ssl_ctx)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    EVP_PKEY *pkey =3D NULL;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if !defined(HAVE_OPENSSL_STORE_API)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* Treat the uri as file name */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    BIO *in =3D BIO_new_file(uri, &quot;r&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!in)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return NULL;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    pkey =3D PEM_read_bio_PrivateKey(in, NULL,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
    SSL_CTX_get_default_passwd_cb(ssl_ctx),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                   SSL_CTX_get_defa=
ult_passwd_cb_userdata(ssl_ctx));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    BIO_free(in);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /=
* defined(HAVE_OPENSSL_STORE_API) */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  OSSL_STORE_CTX *store_ctx =3D NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    OSSL_STORE_INFO *info =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    UI_METHOD *ui_method =3D UI_create_method(&quot;openvpn&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ui_=
method)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;=
OpenSSL UI creation failed&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return NULL;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    UI_method_set_reader(ui_method, ui_reader);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    store_ctx =3D OSSL_STORE_open_ex(uri, tls_libctx, NULL, ui_m=
ethod, ssl_ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                               NULL, NULL, NULL);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!store_ctx)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        goto end;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (OSSL_STORE_expect(store_ctx, OSSL_STORE_INFO_PKEY) !=3D 1)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto end;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    info =3D OSSL_STORE_load(store_ctx);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!info)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        goto end;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    pkey =3D OSSL_STORE_INFO_get1_PKEY(info);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OSSL_STORE_INFO_free(info);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_TLS_DEBUG_MED, &quo=
t;Found pkey in store using URI: %s&quot;, uri);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+end:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    O=
SSL_STORE_close(store_ctx);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    UI_destroy_method(ui_method);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif /* defined(HAVE_OPENSSL_STORE_API) */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return pkey;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> int</span><br><span> tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, co=
nst char *pkcs12_file,</span><br><span>                     bool pkcs12_fil=
e_inline, bool load_ca_file)</span><br><span>@@ -945,9 +1056,103 @@</span><=
br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char =
*cert_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
             bool cert_file_inline)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+cert_uri_supported(void)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(HAVE_OPENSSL_STORE_API)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return 1;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+tls_ctx_load_cert_uri(struct tls_root_ctx *tls_ctx, const char *uri)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(HAVE_OPENSSL_STORE_API)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    X509 *x =3D NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OSSL_STORE_CTX *stor=
e_ctx =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
OSSL_STORE_INFO *info =3D NULL;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASS=
ERT(NULL !=3D tls_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    UI_METHOD *=
ui_method =3D UI_create_method(&quot;openvpn&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!ui_method)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_WARN, &quot;OpenSSL UI method creation fa=
iled&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 goto end;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    UI_method_set_reade=
r(ui_method, ui_reader);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    store_ctx =
=3D OSSL_STORE_open_ex(uri, tls_libctx, NULL, ui_method, tls_ctx-&gt;ctx,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
              NULL, NULL, NULL);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!store_ctx)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       goto end;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (OSSL_STOR=
E_expect(store_ctx, OSSL_STORE_INFO_CERT) !=3D 1)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        goto end;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info =3D OSSL_S=
TORE_load(store_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto end;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    x =3D OSSL_STORE_INFO_get0_CERT(info);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (x =3D=3D NULL)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        goto end;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    msg(D_TLS_DEBUG_MED, &quot;Found cert in store usin=
g URI: %s&quot;, uri);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D SSL_=
CTX_use_certificate(tls_ctx-&gt;ctx, x);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!ret)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        goto end;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OSSL_STORE_=
INFO_free(info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* iterate through=
 the store and add extra certificates if any to the chain */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    info =3D OSSL_STORE_load(store=
_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (in=
fo &amp;&amp; !OSSL_STORE_eof(store_ctx))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        x =3D OSSL_STORE_INFO_get1_CERT(info);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (x &amp;&amp; SSL_CTX_add_ext=
ra_chain_cert(tls_ctx-&gt;ctx, x) !=3D 1)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            X509_free(x);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            crypto_msg(M_FATAL, &quot;Error adding extra =
certificate&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        OSS=
L_STORE_INFO_free(info);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        info =3D OSSL_STORE_load(store_ctx);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+end=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ret)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        crypto_print_openssl_errors(M_=
WARN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        crypt=
o_msg(M_FATAL, &quot;Cannot load certificate from URI &lt;%s&gt;&quot;, uri=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        crypto_print_openssl_errors(M_DEBUG);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    UI_destroy_method(ui_method);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    OSSL_STORE_INFO_free(info);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    OSSL_STORE_close(store_ctx);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* defined(HAVE=
_OPENSSL_STORE_API */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ASSERT(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif /* defined(HAVE_OPENSSL_STORE_API */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_load_cert_pem_fi=
le(struct tls_root_ctx *ctx, const char *cert_file,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           bool cert_file=
_inline)</span><br><span> {</span><br><span>     BIO *in =3D NULL;</span><b=
r><span>     X509 *x =3D NULL;</span><br><span>@@ -961,7 +1166,7 @@</span><=
br><span>     }</span><br><span>     else</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        in =3D BIO_new_file(cert=
_file, &quot;r&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        in =3D BIO_new_file((char *) cert_file, &quot;r&quot;);</span><b=
r><span>     }</span><br><span> </span><br><span>     if (in =3D=3D NULL)</=
span><br><span>@@ -1007,6 +1212,20 @@</span><br><span>     X509_free(x);</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
bool cert_file_inline)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cert_ur=
i_supported() &amp;&amp; !cert_file_inline)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        tls_ctx_load_cert_uri(ctx, cert_file);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      tls_ctx_load_cert_pem_file(ctx, cert_file, cert_file_inline);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> int</span><br><span> tls_ctx_load_priv_fi=
le(struct tls_root_ctx *ctx, const char *priv_key_file,</span><br><span>   =
                     bool priv_key_file_inline)</span><br><span>@@ -1023,21=
 +1242,19 @@</span><br><span>     if (priv_key_file_inline)</span><br><span=
>     {</span><br><span>         in =3D BIO_new_mem_buf((char *) priv_key_f=
ile, -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (in =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
goto end;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pkey =3D PEM=
_read_bio_PrivateKey(in, NULL,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                       SSL_CTX_get_default_passw=
d_cb(ctx-&gt;ctx),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                      SSL_CTX_get_default_passwd_cb_userdat=
a(ctx-&gt;ctx));</span><br><span>     }</span><br><span>     else</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
in =3D BIO_new_file(priv_key_file, &quot;r&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        pkey =3D load_pkey_from_uri(priv_key=
_file, ssl_ctx);</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (!in)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        goto end;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    pkey =3D PEM_read_bio_Priv=
ateKey(in, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                              SSL_CTX_get_default_passwd_cb(ctx-&gt;ctx),</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
            SSL_CTX_get_default_passwd_cb_userdata(ctx-&gt;ctx));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (!pkey=
 || !SSL_CTX_use_PrivateKey(ssl_ctx, pkey))</span><br><span>     {</span><b=
r><span> #ifdef ENABLE_MANAGEMENT</span><br><span>diff --git a/tests/unit_t=
ests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span><br><sp=
an>index 5da5b1c..da375af 100644</span><br><span>--- a/tests/unit_tests/ope=
nvpn/test_ssl.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl.c</=
span><br><span>@@ -66,6 +66,18 @@</span><br><span> }</span><br><span> #endi=
f</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* stubs for some unused functions instead of pulling in too many dependenc=
ies */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+get_user_pass_cr(struct user=
_pass *up, const char *auth_file, const char *prefix,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 const unsigned int flags=
, const char *auth_challenge)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+purge_user_pass(struct user_pass *up, boo=
l force)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> =
const char *unittest_cert =3D &quot;-----BEGIN CERTIFICATE-----\n&quot;</sp=
an><br><span>                             &quot;MIIBuTCCAUCgAwIBAgIUTLtjSBz=
x53qZRvZ6Ur7D9kgoOHkwCgYIKoZIzj0EAwIw\n&quot;</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/726?=
usp=3Demail">change 726</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/726?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I82b32d5ab472926e7889a5f4a90=
caba14231879a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 726 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--9g2H6BdEzVk=--

