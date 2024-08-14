From: "selvanair (Code Review)" <gerrit@...515...>
Date: Wed, 14 Aug 2024 22:35:12 +0000
In-Reply-To: <gerrit.1723673969000.I82b32d5ab472926e7889a5f4a90caba14231879a@...2715...>
References: <gerrit.1723673969000.I82b32d5ab472926e7889a5f4a90caba14231879a@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <66725e82d19a5ce21bdf77dcbeb6caa3bf77ae21-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8RHspNAFQvw="; charset=UTF-8
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

--8RHspNAFQvw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/726?usp=3Demail

to look at the new patch set (#2).


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

v2: same as PR 591 but with the fixup commit that addresses review comments=
 is squashed.

Change-Id: I82b32d5ab472926e7889a5f4a90caba14231879a
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M doc/man-sections/tls-options.rst
M src/openvpn/options.c
M src/openvpn/ssl_openssl.c
M tests/unit_tests/openvpn/test_ssl.c
4 files changed, 280 insertions(+), 27 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/726/2

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
=20
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
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--8RHspNAFQvw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>selvanair <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/726?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Interpret --key and --cert option argument as URI<br><br>OpenSSL 3 ha=
s providers which can load keys and certificates<br>from various key stores=
 and HSMs using a provider-specific URI.<br>While certificates are generall=
y exportable, and some providers<br>support a PEM file that acts as a proxy=
 for non-exportable private<br>keys, not all providers are expected to do s=
o. A generic capability<br>to read keys and certificates from URIs appears =
useful.<br><br>This patch does this by extending the scope of the argument =
for<br>&quot;--key&quot; and &quot;--cert&quot; options to include URIs. Ma=
ny of OpenSSL 3<br>utilities also work the same way: e.g., the &quot;-in&qu=
ot; option for<br>&quot;openssl pkey&quot; or &quot;openssl x509&quot; coul=
d be a filename or URI.<br>Other applications have started emulating this b=
ehaviour:<br>e.g., pkcs11: URI works as an alternative to a file name for<b=
r>certificates and keys in apache. Even for files, this has a nice<br>side =
effect that non-PEM files get transparently parsed. E.g., a<br>pkcs12 file =
could be used in place of a PEM file without needing<br>any extra options.<=
br><br>This is backward compatible as OpenSSL falls back to treating URIs<b=
r>with no scheme or unrecognized scheme as file names.<br><br>Parsing of in=
lined keys and certificates is unchanged (those<br>should be in PEM format)=
.<br><br>Specification of URIs that OpenSSL accepts depends on the<br>provi=
ders that support them. Some are standard URIs such as<br>&quot;file:/path&=
quot;, but providers may support non-standard URIs<br>with arbitrary scheme=
 names. OpenSSL by itself recognizes<br>only file URI.  However, the implem=
entation is agnostic to the<br>URI specification as parsing is done by the =
provider that supports<br>the URI. A new URI gets automatically recognized =
when the provider<br>that supports it is loaded.<br><br>Below are some usag=
e examples:<br><br>Relative or absolute path to a file or as a URI &quot;fi=
le:/absolute/path&quot;:<br><br>   --key mykey.pem      (same as what is cu=
rrently supported)<br>   --key file:/path/to/mykey.pem<br>   --cert file:/p=
ath/to/mycert.pem<br><br>Other file types supported by OpenSSL would also w=
ork:<br><br>   --key client.p12<br>   --cert client.p12<br><br>pkcs11-provi=
der supports &quot;pkcs11:&quot; URI (RFC 7512):<br><br>   --key pkcs11:tok=
en=3DFoo;id=3D%01<br>   --cert pkcs11:token=3DFoo;id=3D%01<br><br>tpm2-prov=
ider recognizes a custom URI &quot;handle:&lt;hex&gt;&quot;:<br><br>   --ke=
y handle:0x81000000<br><br>These examples assume that required providers, i=
f any, are loaded<br>and configured.<br><br>v2: same as PR 591 but with the=
 fixup commit that addresses review comments is squashed.<br><br>Change-Id:=
 I82b32d5ab472926e7889a5f4a90caba14231879a<br>Signed-off-by: Selva Nair &lt=
;selva.nair@...277...&gt;<br>---<br>M doc/man-sections/tls-options.rst<br>M=
 src/openvpn/options.c<br>M src/openvpn/ssl_openssl.c<br>M tests/unit_tests=
/openvpn/test_ssl.c<br>4 files changed, 280 insertions(+), 27 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/7=
26/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/doc/man-sections/tls-options.rst b/doc/man-sectio=
ns/tls-options.rst</span><br><span>index de74c0d..cdb8571 100644</span><br>=
<span>--- a/doc/man-sections/tls-options.rst</span><br><span>+++ b/doc/man-=
sections/tls-options.rst</span><br><span>@@ -85,10 +85,17 @@</span><br><spa=
n>   OpenVPN will log the usual warning in the logs if the relevant CRL is<=
/span><br><span>   missing, but the connection will be allowed.</span><br><=
span> </span><br><span>---cert file</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  Local peer&#39;s signed certificate in .pem format -- must =
be signed by a</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  certi=
ficate authority whose certificate is in ``--ca file``. Each peer</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  in an OpenVPN link running in=
 TLS mode should have its own certificate</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+--cert file|uri</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  Local peer&#39;s signed certificate in .pem format or a=
s a URI -- must be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 signed by a certificate authority whose certificate is in ``--ca file``</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  in the peer configur=
ation. URI is supported only when built with</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  OpenSSL 3.0 or later and any required providers =
are loaded. Types</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
of URIs supported and their syntax depends on providers. OpenSSL has</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  internal support for &qu=
ot;file:/absolute/path&quot; URI in which case the scheme</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  &quot;file:&quot; is optional, and =
any file format recognized by OpenSSL (e.g., PEM,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  PKCS12) is supported. PKCS#11 URI (RFC 7512=
) is supported by pkcs11-provider.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Ea=
ch peer in an OpenVPN link running in TLS mode should have its own certific=
ate</span><br><span>   and private key file. In addition, each certificate =
should have been</span><br><span>   signed by the key of a certificate auth=
ority whose public key resides in</span><br><span>   the ``--ca`` certifica=
te authority file. You can easily make your own</span><br><span>@@ -203,10 =
+210,11 @@</span><br><span>   The ``--hand-window`` parameter also controls=
 the amount of time that</span><br><span>   the OpenVPN client repeats the =
pull request until it times out.</span><br><span> </span><br><span>---key f=
ile</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Local peer&#39;s=
 private key in .pem format. Use the private key which was</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  generated when you built your peer&#=
39;s certificate (see ``--cert file``</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  above).</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+--key file|uri</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  Local peer&#39;s private key in .pem format or a URI. Use the private ke=
y</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  which was genera=
ted when you built your peer&#39;s certificate (see</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  ``--cert file`` above). URI is supporte=
d only when built with OpenSSL 3.0</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  or later and any required providers are loaded. (See `--ce=
rt` for more details).</span><br><span> </span><br><span> --pkcs12 file</sp=
an><br><span>   Specify a PKCS #12 file containing local private key, local=
 certificate,</span><br><span>diff --git a/src/openvpn/options.c b/src/open=
vpn/options.c</span><br><span>index ba9b05e..a5f0784 100644</span><br><span=
>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</s=
pan><br><span>@@ -567,10 +567,10 @@</span><br><span>     &quot;--dh file   =
    : File containing Diffie Hellman parameters\n&quot;</span><br><span>   =
  &quot;                  in .pem format (for --tls-server only).\n&quot;</=
span><br><span>     &quot;                  Use \&quot;openssl dhparam -out=
 dh1024.pem 1024\&quot; to generate.\n&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    &quot;--cert file     : Local certificate in .pe=
m format -- must be signed\n&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    &quot;                  by a Certificate Authority in --ca=
 file.\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
quot;--cert file     : Local certificate in .pem format or a URI -- must be=
 signed\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&quot;                  by a Certificate Authority in --ca file used by the=
 peer.\n&quot;</span><br><span>     &quot;--extra-certs file : one or more =
PEM certs that complete the cert chain.\n&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    &quot;--key file      : Local private key in =
.pem format.\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;--key file      : Local private key in .pem format or a URI.\n&q=
uot;</span><br><span>     &quot;--tls-version-min &lt;version&gt; [&#39;or-=
highest&#39;] : sets the minimum TLS version we\n&quot;</span><br><span>   =
  &quot;    will accept from the peer.  If version is unrecognized and &#39=
;or-highest&#39;\n&quot;</span><br><span>     &quot;    is specified, requi=
re max TLS version supported by SSL implementation.\n&quot;</span><br><span=
>@@ -3851,6 +3851,7 @@</span><br><span> #define CHKACC_FILEXSTWR (1&lt;&lt;=
2)  /** If file exists, is it writable? */</span><br><span> #define CHKACC_=
ACPTSTDIN (1&lt;&lt;3)  /** If filename is stdin, it&#39;s allowed and &quo=
t;exists&quot; */</span><br><span> #define CHKACC_PRIVATE (1&lt;&lt;4)    /=
** Warn if this (private) file is group/others accessible */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_ACCEPT_URI (1&lt;&l=
t;5) /** If filename is a URI, no check is done unless it starts with file:=
 */</span><br><span> </span><br><span> static bool</span><br><span> check_f=
ile_access(const int type, const char *file, const int mode, const char *op=
t)</span><br><span>@@ -3871,6 +3872,21 @@</span><br><span>         return f=
alse;</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* file name is a URI if its first segment  =
has &quot;:&quot; (i.e., before any &quot;/&quot;)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * Then no checks done if CHKACC_ACCEPT_=
URI is set and the URI does not start with &quot;file:&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if ((type &amp; CHKACC_ACCEPT_URI) &amp;&a=
mp; strchr(file, &#39;:&#39;))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (!strncmp(file, &quot;file:&quot;, 5))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            file +=3D 5;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        else if (!strchr(file, &#39;/&#39;) || strchr(file, &#3=
9;/&#39;) &gt; strchr(file, &#39;:&#39;))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     /* Is the directory path leading to the given file accessib=
le? */</span><br><span>     if (type &amp; CHKACC_DIRPATH)</span><br><span>=
     {</span><br><span>@@ -4069,7 +4085,7 @@</span><br><span>     errs |=3D=
 check_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE,</span><br><s=
pan>                                      options-&gt;ca_path, R_OK, &quot;=
--capath&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    errs |=3D check_file_access_inline(options-&gt;cert_file_i=
nline, CHKACC_FILE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    errs |=3D check_file_access_inline(options-&gt;cert_file_inline, CHKACC=
_FILE|CHKACC_ACCEPT_URI,</span><br><span>                                  =
    options-&gt;cert_file, R_OK, &quot;--cert&quot;);</span><br><span> </sp=
an><br><span>     errs |=3D check_file_access_inline(options-&gt;extra_cert=
s_file, CHKACC_FILE,</span><br><span>@@ -4079,7 +4095,7 @@</span><br><span>=
     if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br><=
span>     {</span><br><span>         errs |=3D check_file_access_inline(opt=
ions-&gt;priv_key_file_inline,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                         CHKACC_FILE|CHKACC_PRIVAT=
E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                        CHKACC_FILE|CHKACC_PRIVATE|CHKACC_ACCEPT_URI,</span=
><br><span>                                          options-&gt;priv_key_f=
ile, R_OK, &quot;--key&quot;);</span><br><span>     }</span><br><span> </sp=
an><br><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_opens=
sl.c</span><br><span>index e8a30a3..05555a3 100644</span><br><span>--- a/sr=
c/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</sp=
an><br><span>@@ -65,6 +65,12 @@</span><br><span> #include &lt;openssl/ec.h&=
gt;</span><br><span> #endif</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_OPENSSL_S=
TORE_API</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;openssl/ui.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &lt;openssl/store.h&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> #if defined(_MSC_VER) &amp;&amp; !defined(_M_ARM64)</span>=
<br><span> #include &lt;openssl/applink.c&gt;</span><br><span> #endif</span=
><br><span>@@ -768,6 +774,111 @@</span><br><span> #endif /* OPENSSL_NO_EC *=
/</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(HAVE_OPENSSL_STORE_API)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * A wrapper for pem_password_callback for use with Open=
SSL UI_METHOD.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ui_reader(UI *ui, UI_STRING *u=
is)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    SSL_CTX *ctx =3D UI_get0_user_=
data(ui);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (UI_get_string_type(ui=
s) =3D=3D UIT_PROMPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cons=
t char *prompt =3D UI_get0_output_string(uis);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        /* If pkcs#11 Use custom prompt similar to pkcs11-helper */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (strstr(=
prompt, &quot;PKCS#11&quot;))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            struct user_pass up;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            get_user_pass(&amp;up, NULL, &quot;PKCS#11 token&q=
uot;, GET_USER_PASS_MANAGEMENT|GET_USER_PASS_PASSWORD_ONLY);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            UI_set_result(ui, uis,=
 up.password);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       purge_user_pass(&amp;up, true);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        else /* use our generic &#39;Private Key&#39; passphrase c=
allback */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            char pa=
ssword[64];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    pem_password_cb *cb =3D SSL_CTX_get_default_passwd_cb(ctx);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            void *d =3D SSL_CTX=
_get_default_passwd_cb_userdata(ctx);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           cb(password, sizeof(password), 0, d);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            UI_set_result(ui, uis, password);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            secure_m=
emzero(password, sizeof(password));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif /* defined(HAVE_OPENSSL_STORE_API) */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Load private key from OSSL_STORE URI or file</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * uri : URI of object or filename<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ssl_ctx : SSL_CTX=
 for UI prompt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return a pointer to=
 the key or NULL if not found.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Caller must free the key after use.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+load_pkey_from_uri(const char *uri, SSL_CTX *ssl_ctx)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    EVP_PKEY *pkey =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if !defined(HAVE_OPENSSL_STORE_API)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Treat the uri as file name */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    BIO *in =3D BIO_new_file(uri, &quot;r=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!in=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    pkey =3D PEM_read_bio_PrivateKey(in, NULL=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                 SSL_CTX_get_default_passwd_cb(ssl_ctx),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                   SSL=
_CTX_get_default_passwd_cb_userdata(ssl_ctx));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    BIO_free(in);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#else /* defined(HAVE_OPENSSL_STORE_API) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    OSSL_STORE_CTX *store_ctx =3D NULL;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    OSSL_STORE_INFO *info =3D NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    UI_METHOD *ui_method =3D UI_create_method(&=
quot;openvpn&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!ui_method)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M=
_WARN, &quot;OpenSSL UI creation failed&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return NULL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    UI_method_set_reader(ui_method, ui_reader);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    store_ctx =3D OSSL_STORE_open_ex(uri, tls_libct=
x, NULL, ui_method, ssl_ctx,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                   NULL, NULL, NULL);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!store_ctx)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        goto end;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (OSSL_STORE_expect(store_ctx, OSSL_STORE_INFO_PKEY) !=
=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        goto end;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    info =3D OSSL_STORE_load(store_ctx);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!info)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        goto end;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    pkey =3D OSSL_STORE_INFO_get1_PKEY(info);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    OSSL_STORE_INFO_free(info=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_TLS_DEB=
UG_MED, &quot;Found pkey in store using URI: %s&quot;, uri);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+end:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    OSSL_STORE_close(store_ctx);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    UI_destroy_method(ui_method);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif /* defined(HAVE_OPENSSL_STORE_API) */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return pkey;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> int</span><br><span> tls_ctx_load_pkcs12(struct tls_root_=
ctx *ctx, const char *pkcs12_file,</span><br><span>                     boo=
l pkcs12_file_inline, bool load_ca_file)</span><br><span>@@ -945,9 +1056,10=
3 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-tls_ctx_load_cert_file(struct tls_root_ctx *ctx, =
const char *cert_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                       bool cert_file_inline)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+cert_uri_supported(void)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(HAVE_OPENSSL_STORE_API)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return 1;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+tls_ctx_load_cert_uri(struct tls_root_ctx *tls_ctx, const char=
 *uri)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(HAVE_OPENSSL_STORE_=
API)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    X509 *x =3D=
 NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OSSL_STOR=
E_CTX *store_ctx =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    OSSL_STORE_INFO *info =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ASSERT(NULL !=3D tls_ctx);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
UI_METHOD *ui_method =3D UI_create_method(&quot;openvpn&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!ui_method)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;OpenSSL UI method c=
reation failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        goto end;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    UI_method=
_set_reader(ui_method, ui_reader);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
store_ctx =3D OSSL_STORE_open_ex(uri, tls_libctx, NULL, ui_method, tls_ctx-=
&gt;ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                        NULL, NULL, NULL);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!store_ctx)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        goto end;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(OSSL_STORE_expect(store_ctx, OSSL_STORE_INFO_CERT) !=3D 1)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        goto end;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info =
=3D OSSL_STORE_load(store_ctx);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!info)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 goto end;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    x =3D OSSL_STORE_INFO_get0_CERT(info)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (x =3D=3D N=
ULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        goto end;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    msg(D_TLS_DEBUG_MED, &quot;Found cert in =
store using URI: %s&quot;, uri);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
t =3D SSL_CTX_use_certificate(tls_ctx-&gt;ctx, x);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!ret)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        goto end;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    O=
SSL_STORE_INFO_free(info);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* itera=
te through the store and add extra certificates if any to the chain */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    info =3D OSSL_STORE_=
load(store_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 while (info &amp;&amp; !OSSL_STORE_eof(store_ctx))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        x =3D OSSL_STORE_INFO_get1_CERT(info);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (x &amp;&amp; SSL=
_CTX_add_extra_chain_cert(tls_ctx-&gt;ctx, x) !=3D 1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            X509_free(x);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            crypto_msg(M_FATAL, &quot;Error a=
dding extra certificate&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        OSSL_STORE_INFO_free(info);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        info =3D OSSL_STORE_load(store_ctx);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+end:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!ret)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        crypto_print_opens=
sl_errors(M_WARN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       crypto_msg(M_FATAL, &quot;Cannot load certificate from URI &lt;%s&gt=
;&quot;, uri);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        crypto_print_openssl_errors(M_DEBUG)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    UI_destroy_method(ui_method);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    OSSL_STORE_INFO_free(info);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    OSSL_STORE_close(stor=
e_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* def=
ined(HAVE_OPENSSL_STORE_API */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ASSERT(0);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif /* defined(HAVE_OPENSSL_STORE_API */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_load_ce=
rt_pem_file(struct tls_root_ctx *ctx, const char *cert_file,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                           bool ce=
rt_file_inline)</span><br><span> {</span><br><span>     BIO *in =3D NULL;</=
span><br><span>     X509 *x =3D NULL;</span><br><span>@@ -961,7 +1166,7 @@<=
/span><br><span>     }</span><br><span>     else</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        in =3D BIO_new_fi=
le(cert_file, &quot;r&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        in =3D BIO_new_file((char *) cert_file, &quot;r&quot;);</=
span><br><span>     }</span><br><span> </span><br><span>     if (in =3D=3D =
NULL)</span><br><span>@@ -1007,6 +1212,20 @@</span><br><span>     X509_free=
(x);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_fi=
le,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
       bool cert_file_inline)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
cert_uri_supported() &amp;&amp; !cert_file_inline)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        tls_ctx_load_cert_uri(ctx, cert_file);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        tls_ctx_load_cert_pem_file(ctx, cert_file, cert_file_inline);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> tls_ctx_load_=
priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,</span><br><s=
pan>                        bool priv_key_file_inline)</span><br><span>@@ -=
1023,21 +1242,19 @@</span><br><span>     if (priv_key_file_inline)</span><b=
r><span>     {</span><br><span>         in =3D BIO_new_mem_buf((char *) pri=
v_key_file, -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (in =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       goto end;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pkey =
=3D PEM_read_bio_PrivateKey(in, NULL,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                       SSL_CTX_get_defaul=
t_passwd_cb(ctx-&gt;ctx),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                       SSL_CTX_get_default_passwd_cb_=
userdata(ctx-&gt;ctx));</span><br><span>     }</span><br><span>     else</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       in =3D BIO_new_file(priv_key_file, &quot;r&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        pkey =3D load_pkey_from_uri(p=
riv_key_file, ssl_ctx);</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (!in)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        goto end;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    pkey =3D PEM_read_b=
io_PrivateKey(in, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                   SSL_CTX_get_default_passwd_cb(ctx-&gt;=
ctx),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                   SSL_CTX_get_default_passwd_cb_userdata(ctx-&gt;ctx));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if=
 (!pkey || !SSL_CTX_use_PrivateKey(ssl_ctx, pkey))</span><br><span>     {</=
span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>diff --git a/tests=
/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span>=
<br><span>index 5da5b1c..da375af 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/test_ssl.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
ssl.c</span><br><span>@@ -66,6 +66,18 @@</span><br><span> }</span><br><span=
> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* stubs for some unused functions instead of pulling in too many de=
pendencies */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_user_pass_cr(stru=
ct user_pass *up, const char *auth_file, const char *prefix,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 const unsigned in=
t flags, const char *auth_challenge)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+purge_user_pass(struct user_pass *up=
, bool force)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><s=
pan> const char *unittest_cert =3D &quot;-----BEGIN CERTIFICATE-----\n&quot=
;</span><br><span>                             &quot;MIIBuTCCAUCgAwIBAgIUTL=
tjSBzx53qZRvZ6Ur7D9kgoOHkwCgYIKoZIzj0EAwIw\n&quot;</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/726?usp=3Demail">change 726</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/726?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I82b32d5ab472926e7889a5f4a90=
caba14231879a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 726 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--8RHspNAFQvw=--

