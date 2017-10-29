Message-ID: <1509289652.3116.11.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Sun, 29 Oct 2017 15:07:32 +0000
In-Reply-To: <CAFHpkQHXWrXn42B1xr0YuPvQUrOSvUqQU6h8RkP_EgP_iBP5Qw@...278...>
References: <1509192147.3021.6.camel@...2316...>
 <1509192205.3021.7.camel@...2316...>
 <CAFHpkQHXWrXn42B1xr0YuPvQUrOSvUqQU6h8RkP_EgP_iBP5Qw@...278...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 1/1] openssl: add engine method for
 loading the key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?=D0=98=D0=BB=D1=8C=D1=8F_=D0=A8=D0=B8=D0=BF=D0=B8=D1=86?= =?UTF-8?Q?=D0=B8=D0=BD?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Sun, 2017-10-29 at 17:34 +0500, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:
> 2017-10-28 17:03 GMT+05:00 James Bottomley <
> James.Bottomley@...2317...>:
>=20
> >=20
> > As well as doing crypto acceleration, engines can also be used to
> > load
> > key files.=C2=A0=C2=A0If the engine is set, and the private key loading=
 fails
> > for bio methods, this patch makes openvpn try to get the engine to
> > load the key.=C2=A0=C2=A0If that succeeds, we end up using an engine ba=
sed
> > key.
> > This can be used with the openssl tpm engines to make openvpn use a
> > TPM wrapped key file.
> >=20
>=20
>=20
> it fails on mbedtls and openssl-1.1.0
>=20
> https://travis-ci.org/chipitsine/openvpn/builds/294429659

It looks like it needs better config guarding; incremental attached
below.

However, it exposes an openvpn problem: engines aren't built with
openssl-1.1 because the configure.ac check for ENGINE_cleanup doesn't
find the function (it became a #define). =C2=A0I'll see if I can fix that.

The mbedtls one looks like the function def needs to be in
crypto_openssl.h; I've moved it but can't compile check

James

---

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 0b4a9ce9..cc8f138f 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -669,17 +669,5 @@ const char *translate_cipher_name_from_openvpn(const c=
har *cipher_name);
  */
 const char *translate_cipher_name_to_openvpn(const char *cipher_name);
=20
-/**
- * Load a key file from an engine
- *
- * @param file	The engine file to load
- * @param ui	The UI method for the password prompt
- * @param data	The data to pass to the UI method
- *
- * @return	The private key if successful or NULL if not
- */
-EVP_PKEY *
-engine_load_key(const char *file, SSL_CTX *ctx);
-
=20
 #endif /* CRYPTO_BACKEND_H_ */
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index ee16a496..1fcb80a6 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -969,6 +969,7 @@ hmac_ctx_final(HMAC_CTX *ctx, uint8_t *dst)
     HMAC_Final(ctx, dst, &in_hmac_len);
 }
=20
+#ifdef HAVE_OPENSSL_ENGINE
 static int
 ui_read(UI *ui, UI_STRING *uis)
 {
@@ -986,10 +987,12 @@ ui_read(UI *ui, UI_STRING *uis)
     }
     return 0;
 }
+#endif
=20
 EVP_PKEY *
 engine_load_key(const char *file, SSL_CTX *ctx)
 {
+#ifdef HAVE_OPENSSL_ENGINE
     UI_METHOD *ui;
     EVP_PKEY *pkey;
=20
@@ -1016,6 +1019,9 @@ engine_load_key(const char *file, SSL_CTX *ctx)
  out:
     UI_destroy_method(ui);
     return pkey;
+#else
+    return NULL;
+#endif
 }
=20
 #endif /* ENABLE_CRYPTO && ENABLE_CRYPTO_OPENSSL */
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 60a28123..759dc927 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -101,5 +101,17 @@ void crypto_print_openssl_errors(const unsigned int fl=
ags);
         msg((flags), __VA_ARGS__); \
     } while (false)
=20
+/**
+ * Load a key file from an engine
+ *
+ * @param file	The engine file to load
+ * @param ui	The UI method for the password prompt
+ * @param data	The data to pass to the UI method
+ *
+ * @return	The private key if successful or NULL if not
+ */
+EVP_PKEY *
+engine_load_key(const char *file, SSL_CTX *ctx);
+
=20
 #endif /* CRYPTO_OPENSSL_H_ */

