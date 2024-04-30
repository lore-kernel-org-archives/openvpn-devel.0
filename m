From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 30 Apr 2024 15:47:45 +0000
In-Reply-To: <gerrit.1714407751000.I90875311a4e4c403e77e30b609c1878cbaaaad45@...2715...>
References: <gerrit.1714407751000.I90875311a4e4c403e77e30b609c1878cbaaaad45@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <c6c6103e1da90c9ff2e1aebde7a73dcdd83a158e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="prxNzzShq1Q="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove OpenSSL 1.0.2
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--prxNzzShq1Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/559?usp=3Demail

to look at the new patch set (#5).


Change subject: Remove OpenSSL 1.0.2 support
......................................................................

Remove OpenSSL 1.0.2 support

With Centos 7/Red Hat Enterprise Linux 7 being EOL this June, the last
distributions that still support OpenSSL 1.0.2 are finally EOL. This
means we no longer need to support OpenSSL 1.0.2

Change-Id: I90875311a4e4c403e77e30b609c1878cbaaaad45
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M Changes.rst
M INSTALL
M configure.ac
M src/openvpn/crypto_openssl.c
M src/openvpn/openssl_compat.h
M src/openvpn/ssl_openssl.c
6 files changed, 26 insertions(+), 692 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/559/5

diff --git a/Changes.rst b/Changes.rst
index b2278ab..8bcef38 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -32,6 +32,10 @@
     ``--topology net30`` to the config should fix the problem.
     By default ``--topology`` is pushed from server to client.

+OpenSSL 1.0.2 support
+    Support for building with OpenSSL 1.0.2 has been removed. The minimum
+    supported OpenSSL version is now 1.1.0.
+
 Overview of changes in 2.6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

diff --git a/INSTALL b/INSTALL
index a63bab6..6007338 100644
--- a/INSTALL
+++ b/INSTALL
@@ -66,7 +66,7 @@
   (1) TUN and/or TAP driver to allow user-space programs to control
       a virtual point-to-point IP or Ethernet device.
       See TUN/TAP Driver References section below for more info.
-  (2a) OpenSSL library, necessary for encryption, version 1.0.2 or higher
+  (2a) OpenSSL library, necessary for encryption, version 1.1.0 or higher
       required, available from http://www.openssl.org/
       or
   (2b) mbed TLS library, an alternative for encryption, version 2.0 or hig=
her
diff --git a/configure.ac b/configure.ac
index ce8b2b0..965ed1a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -888,7 +888,7 @@
 		# if the user did not explicitly specify flags, try to autodetect
 		PKG_CHECK_MODULES(
 			[OPENSSL],
-			[openssl >=3D 1.0.2],
+			[openssl >=3D 1.1.0],
 			[have_openssl=3D"yes"],
 			[AC_MSG_WARN([OpenSSL not found by pkg-config ${pkg_config_found}])] # =
If this fails, we will do another test next
 		)
@@ -903,7 +903,7 @@
 	# If pkgconfig check failed or OPENSSL_CFLAGS/OPENSSL_LIBS env vars
 	# are used, check the version directly in the OpenSSL include file
 	if test "${have_openssl}" !=3D "yes"; then
-		AC_MSG_CHECKING([additionally if OpenSSL is available and version >=3D 1=
.0.2])
+		AC_MSG_CHECKING([additionally if OpenSSL is available and version >=3D 1=
.1.0])
 		AC_COMPILE_IFELSE(
 			[AC_LANG_PROGRAM(
 				[[
@@ -911,7 +911,7 @@
 				]],
 				[[
 /*	     Version encoding: MNNFFPPS - see opensslv.h for details */
-#if OPENSSL_VERSION_NUMBER < 0x10002000L
+#if OPENSSL_VERSION_NUMBER < 0x10100000L
 #error OpenSSL too old
 #endif
 				]]
@@ -981,7 +981,7 @@
 		[AC_MSG_ERROR([OpenSSL check for AES-256-GCM support failed])]
 	)

-	# All supported OpenSSL version (>=3D 1.0.2)
+	# All supported OpenSSL version (>=3D 1.1.0)
 	# have this feature
 	have_export_keying_material=3D"yes"

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index b2c4eb6..64ad346 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -49,7 +49,7 @@
 #include <openssl/rand.h>
 #include <openssl/ssl.h>

-#if (OPENSSL_VERSION_NUMBER >=3D 0x10100000L) && !defined(LIBRESSL_VERSION=
_NUMBER)
+#if !defined(LIBRESSL_VERSION_NUMBER)
 #include <openssl/kdf.h>
 #endif
 #if OPENSSL_VERSION_NUMBER >=3D 0x30000000L
@@ -193,11 +193,7 @@
 void
 crypto_init_lib(void)
 {
-#if (OPENSSL_VERSION_NUMBER >=3D 0x10100000L)
     OPENSSL_init_crypto(OPENSSL_INIT_LOAD_CONFIG, NULL);
-#else
-    OPENSSL_config(NULL);
-#endif
     /*
      * If you build the OpenSSL library and OpenVPN with
      * CRYPTO_MDEBUG, you will get a listing of OpenSSL
@@ -1376,7 +1372,7 @@

     return ret;
 }
-#elif (OPENSSL_VERSION_NUMBER >=3D 0x10100000L) && !defined(LIBRESSL_VERSI=
ON_NUMBER)
+#elif !defined(LIBRESSL_VERSION_NUMBER)
 bool
 ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
              int secret_len, uint8_t *output, int output_len)
@@ -1422,7 +1418,7 @@
     EVP_PKEY_CTX_free(pctx);
     return ret;
 }
-#else  /* if OPENSSL_VERSION_NUMBER >=3D 0x10100000L */
+#else  /* if defined(LIBRESSL_VERSION_NUMBER) */
 /*
  * Generate the hash required by for the \c tls1_PRF function.
  *
@@ -1601,5 +1597,5 @@
     gc_free(&gc);
     return ret;
 }
-#endif /* if OPENSSL_VERSION_NUMBER >=3D 0x10100000L */
+#endif /* if LIBRESSL_VERSION_NUMBER */
 #endif /* ENABLE_CRYPTO_OPENSSL */
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index c9fa719..95417b2 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -50,8 +50,8 @@
 #define SSL_CTX_set1_groups SSL_CTX_set1_curves
 #endif

-/* Functionality missing in LibreSSL before 3.5 and OpenSSL 1.0.2 */
-#if (OPENSSL_VERSION_NUMBER < 0x10100000L || (defined(LIBRESSL_VERSION_NUM=
BER) && LIBRESSL_VERSION_NUMBER < 0x3050000fL)) && !defined(ENABLE_CRYPTO_W=
OLFSSL)
+/* Functionality missing in LibreSSL before 3.5 */
+#if defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x305000=
0fL
 /**
  * Destroy a X509 object
  *
@@ -71,659 +71,14 @@
 #define EVP_CTRL_AEAD_GET_TAG                EVP_CTRL_GCM_GET_TAG
 #endif

-#if (OPENSSL_VERSION_NUMBER < 0x10100000L || defined(LIBRESSL_VERSION_NUMB=
ER)) && !defined(ENABLE_CRYPTO_WOLFSSL)
+#if defined(LIBRESSL_VERSION_NUMBER)
 #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
 #endif

-#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(ENABLE_CRYPTO_WOLFSS=
L)) || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x305=
0400fL)
+#if defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x305040=
0fL
 #define SSL_get_peer_tmp_key SSL_get_server_tmp_key
 #endif

-/* Functionality missing in 1.0.2 */
-#if OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(ENABLE_CRYPTO_WOLFSSL)
-/**
- * Reset a message digest context
- *
- * @param ctx                 The message digest context
- * @return                    1 on success, 0 on error
- */
-static inline int
-EVP_MD_CTX_reset(EVP_MD_CTX *ctx)
-{
-    EVP_MD_CTX_cleanup(ctx);
-    return 1;
-}
-
-/**
- * Free an existing message digest context
- *
- * @param ctx                 The message digest context
- */
-static inline void
-EVP_MD_CTX_free(EVP_MD_CTX *ctx)
-{
-    free(ctx);
-}
-
-/**
- * Allocate a new message digest object
- *
- * @return                    A zero'ed message digest object
- */
-static inline EVP_MD_CTX *
-EVP_MD_CTX_new(void)
-{
-    EVP_MD_CTX *ctx =3D NULL;
-    ALLOC_OBJ_CLEAR(ctx, EVP_MD_CTX);
-    return ctx;
-}
-
-#define EVP_CIPHER_CTX_reset EVP_CIPHER_CTX_init
-#define X509_get0_notBefore X509_get_notBefore
-#define X509_get0_notAfter X509_get_notAfter
-
-/**
- * Reset a HMAC context
- *
- * OpenSSL 1.1+ removes APIs HMAC_CTX_init() and HMAC_CTX_cleanup()
- * and replace them with a single call that does a cleanup followed
- * by an init. A proper _reset() for OpenSSL < 1.1 should perform
- * a similar set of operations.
- *
- * It means that before we kill a HMAC context, we'll have to cleanup
- * again, as we probably have allocated a few resources when we forced
- * an init.
- *
- * @param ctx                 The HMAC context
- * @return                    1 on success, 0 on error
- */
-static inline int
-HMAC_CTX_reset(HMAC_CTX *ctx)
-{
-    HMAC_CTX_cleanup(ctx);
-    HMAC_CTX_init(ctx);
-    return 1;
-}
-
-/**
- * Cleanup and free an existing HMAC context
- *
- * @param ctx                 The HMAC context
- */
-static inline void
-HMAC_CTX_free(HMAC_CTX *ctx)
-{
-    HMAC_CTX_cleanup(ctx);
-    free(ctx);
-}
-
-/**
- * Allocate a new HMAC context object
- *
- * @return                    A zero'ed HMAC context object
- */
-static inline HMAC_CTX *
-HMAC_CTX_new(void)
-{
-    HMAC_CTX *ctx =3D NULL;
-    ALLOC_OBJ_CLEAR(ctx, HMAC_CTX);
-    return ctx;
-}
-
-/**
- * Fetch the default password callback user data from the SSL context
- *
- * @param ctx                SSL context
- * @return                   The password callback user data
- */
-static inline void *
-SSL_CTX_get_default_passwd_cb_userdata(SSL_CTX *ctx)
-{
-    return ctx ? ctx->default_passwd_callback_userdata : NULL;
-}
-
-/**
- * Fetch the default password callback from the SSL context
- *
- * @param ctx                SSL context
- * @return                   The password callback
- */
-static inline pem_password_cb *
-SSL_CTX_get_default_passwd_cb(SSL_CTX *ctx)
-{
-    return ctx ? ctx->default_passwd_callback : NULL;
-}
-
-/**
- * Get the public key from a X509 certificate
- *
- * @param x                  X509 certificate
- * @return                   The certificate public key
- */
-static inline EVP_PKEY *
-X509_get0_pubkey(const X509 *x)
-{
-    return (x && x->cert_info && x->cert_info->key) ?
-           x->cert_info->key->pkey : NULL;
-}
-
-/**
- * Fetch the X509 object stack from the X509 store
- *
- * @param store              X509 object store
- * @return                   the X509 object stack
- */
-static inline STACK_OF(X509_OBJECT)
-*X509_STORE_get0_objects(X509_STORE *store)
-{
-    return store ? store->objs : NULL;
-}
-
-/**
- * Get the type of an X509 object
- *
- * @param obj                X509 object
- * @return                   The underlying object type
- */
-static inline int
-X509_OBJECT_get_type(const X509_OBJECT *obj)
-{
-    return obj ? obj->type : X509_LU_FAIL;
-}
-
-/**
- * Get the RSA object of a public key
- *
- * @param pkey                Public key object
- * @return                    The underlying RSA object
- */
-static inline RSA *
-EVP_PKEY_get0_RSA(EVP_PKEY *pkey)
-{
-    return (pkey && pkey->type =3D=3D EVP_PKEY_RSA) ? pkey->pkey.rsa : NUL=
L;
-}
-
-/**
- * Get the EC_KEY object of a public key
- *
- * @param pkey                Public key object
- * @return                    The underlying EC_KEY object
- */
-static inline EC_KEY *
-EVP_PKEY_get0_EC_KEY(EVP_PKEY *pkey)
-{
-    return (pkey && pkey->type =3D=3D EVP_PKEY_EC) ? pkey->pkey.ec : NULL;
-}
-
-
-/**
- * Get the DSA object of a public key
- *
- * @param pkey                Public key object
- * @return                    The underlying DSA object
- */
-static inline DSA *
-EVP_PKEY_get0_DSA(EVP_PKEY *pkey)
-{
-    return (pkey && pkey->type =3D=3D EVP_PKEY_DSA) ? pkey->pkey.dsa : NUL=
L;
-}
-
-/**
- * Set the RSA flags
- *
- * @param rsa                 The RSA object
- * @param flags               New flags value
- */
-static inline void
-RSA_set_flags(RSA *rsa, int flags)
-{
-    if (rsa)
-    {
-        rsa->flags =3D flags;
-    }
-}
-
-/**
- * Get the RSA parameters
- *
- * @param rsa                 The RSA object
- * @param n                   The @c n parameter
- * @param e                   The @c e parameter
- * @param d                   The @c d parameter
- */
-static inline void
-RSA_get0_key(const RSA *rsa, const BIGNUM **n,
-             const BIGNUM **e, const BIGNUM **d)
-{
-    if (n !=3D NULL)
-    {
-        *n =3D rsa ? rsa->n : NULL;
-    }
-    if (e !=3D NULL)
-    {
-        *e =3D rsa ? rsa->e : NULL;
-    }
-    if (d !=3D NULL)
-    {
-        *d =3D rsa ? rsa->d : NULL;
-    }
-}
-
-/**
- * Set the RSA parameters
- *
- * @param rsa                 The RSA object
- * @param n                   The @c n parameter
- * @param e                   The @c e parameter
- * @param d                   The @c d parameter
- * @return                    1 on success, 0 on error
- */
-static inline int
-RSA_set0_key(RSA *rsa, BIGNUM *n, BIGNUM *e, BIGNUM *d)
-{
-    if ((rsa->n =3D=3D NULL && n =3D=3D NULL)
-        || (rsa->e =3D=3D NULL && e =3D=3D NULL))
-    {
-        return 0;
-    }
-
-    if (n !=3D NULL)
-    {
-        BN_free(rsa->n);
-        rsa->n =3D n;
-    }
-    if (e !=3D NULL)
-    {
-        BN_free(rsa->e);
-        rsa->e =3D e;
-    }
-    if (d !=3D NULL)
-    {
-        BN_free(rsa->d);
-        rsa->d =3D d;
-    }
-
-    return 1;
-}
-
-/**
- * Number of significant RSA bits
- *
- * @param rsa                The RSA object ; shall not be NULL
- * @return                   The number of RSA bits or 0 on error
- */
-static inline int
-RSA_bits(const RSA *rsa)
-{
-    const BIGNUM *n =3D NULL;
-    RSA_get0_key(rsa, &n, NULL, NULL);
-    return n ? BN_num_bits(n) : 0;
-}
-
-/**
- * Get the DSA parameters
- *
- * @param dsa                 The DSA object
- * @param p                   The @c p parameter
- * @param q                   The @c q parameter
- * @param g                   The @c g parameter
- */
-static inline void
-DSA_get0_pqg(const DSA *dsa, const BIGNUM **p,
-             const BIGNUM **q, const BIGNUM **g)
-{
-    if (p !=3D NULL)
-    {
-        *p =3D dsa ? dsa->p : NULL;
-    }
-    if (q !=3D NULL)
-    {
-        *q =3D dsa ? dsa->q : NULL;
-    }
-    if (g !=3D NULL)
-    {
-        *g =3D dsa ? dsa->g : NULL;
-    }
-}
-
-/**
- * Number of significant DSA bits
- *
- * @param rsa                The DSA object ; shall not be NULL
- * @return                   The number of DSA bits or 0 on error
- */
-static inline int
-DSA_bits(const DSA *dsa)
-{
-    const BIGNUM *p =3D NULL;
-    DSA_get0_pqg(dsa, &p, NULL, NULL);
-    return p ? BN_num_bits(p) : 0;
-}
-
-/**
- * Allocate a new RSA method object
- *
- * @param name               The object name
- * @param flags              Configuration flags
- * @return                   A new RSA method object
- */
-static inline RSA_METHOD *
-RSA_meth_new(const char *name, int flags)
-{
-    RSA_METHOD *rsa_meth =3D NULL;
-    ALLOC_OBJ_CLEAR(rsa_meth, RSA_METHOD);
-    rsa_meth->name =3D string_alloc(name, NULL);
-    rsa_meth->flags =3D flags;
-    return rsa_meth;
-}
-
-/**
- * Free an existing RSA_METHOD object
- *
- * @param meth               The RSA_METHOD object
- */
-static inline void
-RSA_meth_free(RSA_METHOD *meth)
-{
-    if (meth)
-    {
-        /* OpenSSL defines meth->name to be a const pointer, yet we
-         * feed it with an allocated string (from RSA_meth_new()).
-         * Thus we are allowed to free it here. In order to avoid a
-         * "passing 'const char *' to parameter of type 'void *' discards
-         * qualifiers" warning, we force the pointer to be a non-const val=
ue.
-         */
-        free((char *)meth->name);
-        free(meth);
-    }
-}
-
-/**
- * Set the public encoding function of an RSA_METHOD object
- *
- * @param meth               The RSA_METHOD object
- * @param pub_enc            the public encoding function
- * @return                   1 on success, 0 on error
- */
-static inline int
-RSA_meth_set_pub_enc(RSA_METHOD *meth,
-                     int (*pub_enc)(int flen, const unsigned char *from,
-                                    unsigned char *to, RSA *rsa,
-                                    int padding))
-{
-    if (meth)
-    {
-        meth->rsa_pub_enc =3D pub_enc;
-        return 1;
-    }
-    return 0;
-}
-
-/**
- * Set the public decoding function of an RSA_METHOD object
- *
- * @param meth               The RSA_METHOD object
- * @param pub_dec            the public decoding function
- * @return                   1 on success, 0 on error
- */
-static inline int
-RSA_meth_set_pub_dec(RSA_METHOD *meth,
-                     int (*pub_dec)(int flen, const unsigned char *from,
-                                    unsigned char *to, RSA *rsa,
-                                    int padding))
-{
-    if (meth)
-    {
-        meth->rsa_pub_dec =3D pub_dec;
-        return 1;
-    }
-    return 0;
-}
-
-/**
- * Set the private encoding function of an RSA_METHOD object
- *
- * @param meth               The RSA_METHOD object
- * @param priv_enc           the private encoding function
- * @return                   1 on success, 0 on error
- */
-static inline int
-RSA_meth_set_priv_enc(RSA_METHOD *meth,
-                      int (*priv_enc)(int flen, const unsigned char *from,
-                                      unsigned char *to, RSA *rsa,
-                                      int padding))
-{
-    if (meth)
-    {
-        meth->rsa_priv_enc =3D priv_enc;
-        return 1;
-    }
-    return 0;
-}
-
-/**
- * Set the private decoding function of an RSA_METHOD object
- *
- * @param meth               The RSA_METHOD object
- * @param priv_dec           the private decoding function
- * @return                   1 on success, 0 on error
- */
-static inline int
-RSA_meth_set_priv_dec(RSA_METHOD *meth,
-                      int (*priv_dec)(int flen, const unsigned char *from,
-                                      unsigned char *to, RSA *rsa,
-                                      int padding))
-{
-    if (meth)
-    {
-        meth->rsa_priv_dec =3D priv_dec;
-        return 1;
-    }
-    return 0;
-}
-
-/**
- * Set the init function of an RSA_METHOD object
- *
- * @param meth               The RSA_METHOD object
- * @param init               the init function
- * @return                   1 on success, 0 on error
- */
-static inline int
-RSA_meth_set_init(RSA_METHOD *meth, int (*init)(RSA *rsa))
-{
-    if (meth)
-    {
-        meth->init =3D init;
-        return 1;
-    }
-    return 0;
-}
-
-/**
- * Set the sign function of an RSA_METHOD object
- *
- * @param meth               The RSA_METHOD object
- * @param sign               The sign function
- * @return                   1 on success, 0 on error
- */
-static inline
-int
-RSA_meth_set_sign(RSA_METHOD *meth,
-                  int (*sign)(int type, const unsigned char *m,
-                              unsigned int m_length,
-                              unsigned char *sigret, unsigned int *siglen,
-                              const RSA *rsa))
-{
-    meth->rsa_sign =3D sign;
-    return 1;
-}
-
-/**
- * Set the finish function of an RSA_METHOD object
- *
- * @param meth               The RSA_METHOD object
- * @param finish             the finish function
- * @return                   1 on success, 0 on error
- */
-static inline int
-RSA_meth_set_finish(RSA_METHOD *meth, int (*finish)(RSA *rsa))
-{
-    if (meth)
-    {
-        meth->finish =3D finish;
-        return 1;
-    }
-    return 0;
-}
-
-/**
- * Set the application data of an RSA_METHOD object
- *
- * @param meth               The RSA_METHOD object
- * @param app_data           Application data
- * @return                   1 on success, 0 on error
- */
-static inline int
-RSA_meth_set0_app_data(RSA_METHOD *meth, void *app_data)
-{
-    if (meth)
-    {
-        meth->app_data =3D app_data;
-        return 1;
-    }
-    return 0;
-}
-
-/**
- * Get the application data of an RSA_METHOD object
- *
- * @param meth               The RSA_METHOD object
- * @return                   pointer to application data, may be NULL
- */
-static inline void *
-RSA_meth_get0_app_data(const RSA_METHOD *meth)
-{
-    return meth ? meth->app_data : NULL;
-}
-
-/**
- * Gets the number of bits of the order of an EC_GROUP
- *
- *  @param  group               EC_GROUP object
- *  @return                     number of bits of group order.
- */
-static inline int
-EC_GROUP_order_bits(const EC_GROUP *group)
-{
-    BIGNUM *order =3D BN_new();
-    EC_GROUP_get_order(group, order, NULL);
-    int bits =3D BN_num_bits(order);
-    BN_free(order);
-    return bits;
-}
-
-/* SSLeay symbols have been renamed in OpenSSL 1.1 */
-#define OPENSSL_VERSION SSLEAY_VERSION
-#define OpenSSL_version SSLeay_version
-
-/** Return the min SSL protocol version currently enabled in the context.
- *  If no valid version >=3D TLS1.0 is found, return 0. */
-static inline int
-SSL_CTX_get_min_proto_version(SSL_CTX *ctx)
-{
-    long sslopt =3D SSL_CTX_get_options(ctx);
-    if (!(sslopt & SSL_OP_NO_TLSv1))
-    {
-        return TLS1_VERSION;
-    }
-    if (!(sslopt & SSL_OP_NO_TLSv1_1))
-    {
-        return TLS1_1_VERSION;
-    }
-    if (!(sslopt & SSL_OP_NO_TLSv1_2))
-    {
-        return TLS1_2_VERSION;
-    }
-    return 0;
-}
-
-/** Return the max SSL protocol version currently enabled in the context.
- *  If no valid version >=3D TLS1.0 is found, return 0. */
-static inline int
-SSL_CTX_get_max_proto_version(SSL_CTX *ctx)
-{
-    long sslopt =3D SSL_CTX_get_options(ctx);
-    if (!(sslopt & SSL_OP_NO_TLSv1_2))
-    {
-        return TLS1_2_VERSION;
-    }
-    if (!(sslopt & SSL_OP_NO_TLSv1_1))
-    {
-        return TLS1_1_VERSION;
-    }
-    if (!(sslopt & SSL_OP_NO_TLSv1))
-    {
-        return TLS1_VERSION;
-    }
-    return 0;
-}
-
-/** Mimics SSL_CTX_set_min_proto_version for OpenSSL < 1.1 */
-static inline int
-SSL_CTX_set_min_proto_version(SSL_CTX *ctx, long tls_ver_min)
-{
-    long sslopt =3D SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3; /* Never do < TLS 1=
.0 */
-
-    if (tls_ver_min > TLS1_VERSION)
-    {
-        sslopt |=3D SSL_OP_NO_TLSv1;
-    }
-#ifdef SSL_OP_NO_TLSv1_1
-    if (tls_ver_min > TLS1_1_VERSION)
-    {
-        sslopt |=3D SSL_OP_NO_TLSv1_1;
-    }
-#endif
-#ifdef SSL_OP_NO_TLSv1_2
-    if (tls_ver_min > TLS1_2_VERSION)
-    {
-        sslopt |=3D SSL_OP_NO_TLSv1_2;
-    }
-#endif
-    SSL_CTX_set_options(ctx, sslopt);
-
-    return 1;
-}
-
-/** Mimics SSL_CTX_set_max_proto_version for OpenSSL < 1.1 */
-static inline int
-SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_ver_max)
-{
-    long sslopt =3D 0;
-
-    if (tls_ver_max < TLS1_VERSION)
-    {
-        sslopt |=3D SSL_OP_NO_TLSv1;
-    }
-#ifdef SSL_OP_NO_TLSv1_1
-    if (tls_ver_max < TLS1_1_VERSION)
-    {
-        sslopt |=3D SSL_OP_NO_TLSv1_1;
-    }
-#endif
-#ifdef SSL_OP_NO_TLSv1_2
-    if (tls_ver_max < TLS1_2_VERSION)
-    {
-        sslopt |=3D SSL_OP_NO_TLSv1_2;
-    }
-#endif
-    SSL_CTX_set_options(ctx, sslopt);
-
-    return 1;
-}
-#endif /* if OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(ENABLE_CRYPT=
O_WOLFSSL) */
-
 /* Functionality missing in 1.1.1 */
 #if OPENSSL_VERSION_NUMBER < 0x30000000L && !defined(OPENSSL_NO_EC)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index a158617..efdd882 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -84,13 +84,6 @@
 void
 tls_init_lib(void)
 {
-#if OPENSSL_VERSION_NUMBER < 0x10100000L
-    SSL_library_init();
-#ifndef ENABLE_SMALL
-    SSL_load_error_strings();
-#endif
-    OpenSSL_add_all_algorithms();
-#endif
     mydata_index =3D SSL_get_ex_new_index(0, "struct session *", NULL, NUL=
L, NULL);
     ASSERT(mydata_index >=3D 0);
 }
@@ -98,12 +91,6 @@
 void
 tls_free_lib(void)
 {
-#if OPENSSL_VERSION_NUMBER < 0x10100000L
-    EVP_cleanup();
-#ifndef ENABLE_SMALL
-    ERR_free_strings();
-#endif
-#endif
 }

 void
@@ -526,7 +513,8 @@
 void
 tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
 {
-#if OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(LIBRESSL_VERSION_NUMB=
ER)
+#if OPENSSL_VERSION_NUMBER > 0x10100000L    \
+    || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER >  0x3=
060000fL)
     /* OpenSSL does not have certificate profiles, but a complex set of
      * callbacks that we could try to implement to achieve something simil=
ar.
      * For now, use OpenSSL's security levels to achieve similar (but not =
equal)
@@ -555,7 +543,7 @@
 #else  /* if OPENSSL_VERSION_NUMBER > 0x10100000L */
     if (profile)
     {
-        msg(M_WARN, "WARNING: OpenSSL 1.0.2 and LibreSSL do not support "
+        msg(M_WARN, "WARNING: OpenSSL 1.1.0 and LibreSSL do not support "
             "--tls-cert-profile, ignoring user-set profile: '%s'", profile=
);
     }
 #endif /* if OPENSSL_VERSION_NUMBER > 0x10100000L */
@@ -744,15 +732,6 @@
     }
     else
     {
-#if OPENSSL_VERSION_NUMBER < 0x10100000L
-
-        /* OpenSSL 1.0.2 and newer can automatically handle ECDH parameter
-         * loading */
-        SSL_CTX_set_ecdh_auto(ctx->ctx, 1);
-
-        /* OpenSSL 1.1.0 and newer have always ecdh auto loading enabled,
-         * so do nothing */
-#endif
         return;
     }

@@ -1348,7 +1327,7 @@
     return 0;
 }

-#if OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(OPENSSL_NO_EC)
+#if !defined(OPENSSL_NO_EC)

 /* called when EC_KEY is destroyed */
 static void
@@ -1469,7 +1448,7 @@
     EC_KEY_free(ec);
     return 0;
 }
-#endif /* OPENSSL_VERSION_NUMBER > 1.1.0 dev && !defined(OPENSSL_NO_EC) */
+#endif /* !defined(OPENSSL_NO_EC) */
 #endif /* ENABLE_MANAGEMENT && !HAVE_XKEY_PROVIDER */

 #ifdef ENABLE_MANAGEMENT
@@ -1509,7 +1488,7 @@
             goto cleanup;
         }
     }
-#if (OPENSSL_VERSION_NUMBER > 0x10100000L) && !defined(OPENSSL_NO_EC)
+#if !defined(OPENSSL_NO_EC)
 #if OPENSSL_VERSION_NUMBER < 0x30000000L
     else if (EVP_PKEY_id(pkey) =3D=3D EVP_PKEY_EC)
 #else /* OPENSSL_VERSION_NUMBER < 0x30000000L */
@@ -1526,13 +1505,13 @@
         crypto_msg(M_WARN, "management-external-key requires an RSA or EC =
certificate");
         goto cleanup;
     }
-#else  /* OPENSSL_VERSION_NUMBER > 1.1.0 dev && !defined(OPENSSL_NO_EC) */
+#else  /* !defined(OPENSSL_NO_EC) */
     else
     {
         crypto_msg(M_WARN, "management-external-key requires an RSA certif=
icate");
         goto cleanup;
     }
-#endif /* OPENSSL_VERSION_NUMBER > 1.1.0 dev && !defined(OPENSSL_NO_EC) */
+#endif /* !defined(OPENSSL_NO_EC) */

 #endif /* HAVE_XKEY_PROVIDER */

@@ -2166,7 +2145,7 @@
     EVP_PKEY_free(pkey);
 }

-#if (!defined(LIBRESSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >=3D 0x10=
10000fL) \
+#if !defined(LIBRESSL_VERSION_NUMBER) \
     || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER >=3D 0=
x3090000fL)
 /**
  * Translate an OpenSSL NID into a more human readable name

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/559?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I90875311a4e4c403e77e30b609c1878cbaaaad45
Gerrit-Change-Number: 559
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-MessageType: newpatchset

--prxNzzShq1Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/559?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Remove OpenSSL 1.0.2 support<br><br>With Centos 7/Red Hat Enterprise =
Linux 7 being EOL this June, the last<br>distributions that still support O=
penSSL 1.0.2 are finally EOL. This<br>means we no longer need to support Op=
enSSL 1.0.2<br><br>Change-Id: I90875311a4e4c403e77e30b609c1878cbaaaad45<br>=
Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M Changes.rst=
<br>M INSTALL<br>M configure.ac<br>M src/openvpn/crypto_openssl.c<br>M src/=
openvpn/openssl_compat.h<br>M src/openvpn/ssl_openssl.c<br>6 files changed,=
 26 insertions(+), 692 deletions(-)<br><br></pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/59/559/5</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/Changes.rst b=
/Changes.rst</span><br><span>index b2278ab..8bcef38 100644</span><br><span>=
--- a/Changes.rst</span><br><span>+++ b/Changes.rst</span><br><span>@@ -32,=
6 +32,10 @@</span><br><span>     ``--topology net30`` to the config should =
fix the problem.</span><br><span>     By default ``--topology`` is pushed f=
rom server to client.</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+OpenSSL 1.0.2 support</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    Support for building with OpenSSL 1.0.2 has been =
removed. The minimum</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    supported OpenSSL version is now 1.1.0.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> Overview of changes in 2.6</span=
><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</span><br><span> </span><br><span>diff --git a/INSTALL b/IN=
STALL</span><br><span>index a63bab6..6007338 100644</span><br><span>--- a/I=
NSTALL</span><br><span>+++ b/INSTALL</span><br><span>@@ -66,7 +66,7 @@</spa=
n><br><span>   (1) TUN and/or TAP driver to allow user-space programs to co=
ntrol</span><br><span>       a virtual point-to-point IP or Ethernet device=
.</span><br><span>       See TUN/TAP Driver References section below for mo=
re info.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (2a) OpenSS=
L library, necessary for encryption, version 1.0.2 or higher</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  (2a) OpenSSL library, necessary =
for encryption, version 1.1.0 or higher</span><br><span>       required, av=
ailable from http://www.openssl.org/</span><br><span>       or</span><br><s=
pan>   (2b) mbed TLS library, an alternative for encryption, version 2.0 or=
 higher</span><br><span>diff --git a/configure.ac b/configure.ac</span><br>=
<span>index ce8b2b0..965ed1a 100644</span><br><span>--- a/configure.ac</spa=
n><br><span>+++ b/configure.ac</span><br><span>@@ -888,7 +888,7 @@</span><b=
r><span> 		# if the user did not explicitly specify flags, try to autodetec=
t</span><br><span> 		PKG_CHECK_MODULES(</span><br><span> 			[OPENSSL],</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-			[openssl &gt;=3D 1.0.2]=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			[openssl &gt;=
=3D 1.1.0],</span><br><span> 			[have_openssl=3D&quot;yes&quot;],</span><br=
><span> 			[AC_MSG_WARN([OpenSSL not found by pkg-config ${pkg_config_found=
}])] # If this fails, we will do another test next</span><br><span> 		)</sp=
an><br><span>@@ -903,7 +903,7 @@</span><br><span> 	# If pkgconfig check fai=
led or OPENSSL_CFLAGS/OPENSSL_LIBS env vars</span><br><span> 	# are used, c=
heck the version directly in the OpenSSL include file</span><br><span> 	if =
test &quot;${have_openssl}&quot; !=3D &quot;yes&quot;; then</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-		AC_MSG_CHECKING([additionally if Op=
enSSL is available and version &gt;=3D 1.0.2])</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+		AC_MSG_CHECKING([additionally if OpenSSL is av=
ailable and version &gt;=3D 1.1.0])</span><br><span> 		AC_COMPILE_IFELSE(</=
span><br><span> 			[AC_LANG_PROGRAM(</span><br><span> 				[[</span><br><spa=
n>@@ -911,7 +911,7 @@</span><br><span> 				]],</span><br><span> 				[[</spa=
n><br><span> /*	     Version encoding: MNNFFPPS - see opensslv.h for detail=
s */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSI=
ON_NUMBER &lt; 0x10002000L</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if OPENSSL_VERSION_NUMBER &lt; 0x10100000L</span><br><span> #error =
OpenSSL too old</span><br><span> #endif</span><br><span> 				]]</span><br><=
span>@@ -981,7 +981,7 @@</span><br><span> 		[AC_MSG_ERROR([OpenSSL check fo=
r AES-256-GCM support failed])]</span><br><span> 	)</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	# All supported OpenSSL ve=
rsion (&gt;=3D 1.0.2)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	# All supported OpenSSL version (&gt;=3D 1.1.0)</span><br><span> 	# have=
 this feature</span><br><span> 	have_export_keying_material=3D&quot;yes&quo=
t;</span><br><span> </span><br><span>diff --git a/src/openvpn/crypto_openss=
l.c b/src/openvpn/crypto_openssl.c</span><br><span>index b2c4eb6..64ad346 1=
00644</span><br><span>--- a/src/openvpn/crypto_openssl.c</span><br><span>++=
+ b/src/openvpn/crypto_openssl.c</span><br><span>@@ -49,7 +49,7 @@</span><b=
r><span> #include &lt;openssl/rand.h&gt;</span><br><span> #include &lt;open=
ssl/ssl.h&gt;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if (OPENSSL_VERSION_NUMBER &gt;=3D 0x10100000L) &amp;&amp; !defi=
ned(LIBRESSL_VERSION_NUMBER)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if !defined(LIBRESSL_VERSION_NUMBER)</span><br><span> #include &l=
t;openssl/kdf.h&gt;</span><br><span> #endif</span><br><span> #if OPENSSL_VE=
RSION_NUMBER &gt;=3D 0x30000000L</span><br><span>@@ -193,11 +193,7 @@</span=
><br><span> void</span><br><span> crypto_init_lib(void)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if (OPENSSL_VERSION_N=
UMBER &gt;=3D 0x10100000L)</span><br><span>     OPENSSL_init_crypto(OPENSSL=
_INIT_LOAD_CONFIG, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OPENSSL_=
config(NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span>     /*</span><br><span>      * If you build the OpenSSL lib=
rary and OpenVPN with</span><br><span>      * CRYPTO_MDEBUG, you will get a=
 listing of OpenSSL</span><br><span>@@ -1376,7 +1372,7 @@</span><br><span> =
</span><br><span>     return ret;</span><br><span> }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#elif (OPENSSL_VERSION_NUMBER &gt;=3D 0x101=
00000L) &amp;&amp; !defined(LIBRESSL_VERSION_NUMBER)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#elif !defined(LIBRESSL_VERSION_NUMBER)</=
span><br><span> bool</span><br><span> ssl_tls1_PRF(const uint8_t *seed, int=
 seed_len, const uint8_t *secret,</span><br><span>              int secret_=
len, uint8_t *output, int output_len)</span><br><span>@@ -1422,7 +1418,7 @@=
</span><br><span>     EVP_PKEY_CTX_free(pctx);</span><br><span>     return =
ret;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#else  /* if OPENSSL_VERSION_NUMBER &gt;=3D 0x10100000L */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#else  /* if defined(LIBRESSL_VERS=
ION_NUMBER) */</span><br><span> /*</span><br><span>  * Generate the hash re=
quired by for the \c tls1_PRF function.</span><br><span>  *</span><br><span=
>@@ -1601,5 +1597,5 @@</span><br><span>     gc_free(&amp;gc);</span><br><sp=
an>     return ret;</span><br><span> }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif /* if OPENSSL_VERSION_NUMBER &gt;=3D 0x10100000L */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if LIBRES=
SL_VERSION_NUMBER */</span><br><span> #endif /* ENABLE_CRYPTO_OPENSSL */</s=
pan><br><span>diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/opens=
sl_compat.h</span><br><span>index c9fa719..95417b2 100644</span><br><span>-=
-- a/src/openvpn/openssl_compat.h</span><br><span>+++ b/src/openvpn/openssl=
_compat.h</span><br><span>@@ -50,8 +50,8 @@</span><br><span> #define SSL_CT=
X_set1_groups SSL_CTX_set1_curves</span><br><span> #endif</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Functionality miss=
ing in LibreSSL before 3.5 and OpenSSL 1.0.2 */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if (OPENSSL_VERSION_NUMBER &lt; 0x10100000L || (=
defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &lt; 0x=
3050000fL)) &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* Functionality missing in LibreSSL bef=
ore 3.5 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &lt; 0x30500=
00fL</span><br><span> /**</span><br><span>  * Destroy a X509 object</span><=
br><span>  *</span><br><span>@@ -71,659 +71,14 @@</span><br><span> #define =
EVP_CTRL_AEAD_GET_TAG                EVP_CTRL_GCM_GET_TAG</span><br><span> =
#endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if (OPENSSL_VERSION_NUMBER &lt; 0x10100000L || defined(LIBRESSL_VERSION=
_NUMBER)) &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(LIBRESSL_VERSION_NUMBER)</spa=
n><br><span> #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRI=
VATE_ENCRYPT</span><br><span> #endif</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#if (OPENSSL_VERSION_NUMBER &lt; 0x1010000=
0L &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)) || (defined(LIBRESSL_VERSION=
_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &lt; 0x3050400fL)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(LIBRESSL_VERSION_NUMB=
ER) &amp;&amp; LIBRESSL_VERSION_NUMBER &lt; 0x3050400fL</span><br><span> #d=
efine SSL_get_peer_tmp_key SSL_get_server_tmp_key</span><br><span> #endif</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Fu=
nctionality missing in 1.0.2 */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if OPENSSL_VERSION_NUMBER &lt; 0x10100000L &amp;&amp; !defined(E=
NABLE_CRYPTO_WOLFSSL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Reset a message=
 digest context</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param ctx            =
     The message digest context</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @return                    1 on success, 0 on error</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-EVP_MD_CTX_reset(EVP_MD_CTX *ctx)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    EVP_MD_CTX_cleanup(ctx);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return 1;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * Free an existing message digest context</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param ctx                 The message d=
igest context</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-EVP_MD_CTX_free(EVP_MD_CTX *c=
tx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    free(ctx);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * Allocate a new message d=
igest object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * @return                  =
  A zero&#39;ed message digest object</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
atic inline EVP_MD_CTX *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-EVP_MD_CTX_new(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    EVP_MD_CTX *ct=
x =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_=
OBJ_CLEAR(ctx, EVP_MD_CTX);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define EVP_CIPHER_CTX_reset EVP_CIPHER_C=
TX_init</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define X509_g=
et0_notBefore X509_get_notBefore</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define X509_get0_notAfter X509_get_notAfter</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Re=
set a HMAC context</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * OpenSSL 1.1+ remove=
s APIs HMAC_CTX_init() and HMAC_CTX_cleanup()</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * and replace them with a single call that does a =
cleanup followed</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * by=
 an init. A proper _reset() for OpenSSL &lt; 1.1 should perform</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * a similar set of operations.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * It means that before we kill a HMAC con=
text, we&#39;ll have to cleanup</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * again, as we probably have allocated a few resources when we f=
orced</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * an init.</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param ctx                 The HMAC cont=
ext</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return        =
            1 on success, 0 on error</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-HMAC_CT=
X_reset(HMAC_CTX *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    HMAC_CTX_cleanu=
p(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    HMAC_CTX_i=
nit(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 1=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * C=
leanup and free an existing HMAC context</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @param ctx                 The HMAC context</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-HMAC_CTX_free(HMAC_CTX *ctx)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    HMAC_=
CTX_cleanup(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
free(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * Allocate a new HMAC context object</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * @return                    A zero&#39;ed HMAC context object</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static inline HMAC_CTX *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-HMAC_CTX_new(void)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    HMAC_CTX *ctx =3D NULL;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ALLOC_OBJ_CLEAR(ctx, HMAC_CTX);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return ctx;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * Fetch the default password callback =
user data from the SSL context</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param =
ctx                SSL context</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @return                   The password callback user data</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline void *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-SSL_CTX_get_default_passwd_cb_userdata(SSL_=
CTX *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return ctx ? ctx-&gt;default=
_passwd_callback_userdata : NULL;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * Fetch the default password callback from the=
 SSL context</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * @param ctx               =
 SSL context</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @retur=
n                   The password callback</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-static inline pem_password_cb *</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-SSL_CTX_get_default_passwd_cb(SSL_CTX *ctx)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return ctx ? ctx-&gt;default_passwd_callback : NULL;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Get the=
 public key from a X509 certificate</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @p=
aram x                  X509 certificate</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * @return                   The certificate public key<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static inline EVP_PKEY *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-X509_get0_pubkey(const X509 *x)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    return (x &amp;&amp; x-&gt;cert_info &amp;&=
amp; x-&gt;cert_info-&gt;key) ?</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-           x-&gt;cert_info-&gt;key-&gt;pkey : NULL;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Fetch the X509 o=
bject stack from the X509 store</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param=
 store              X509 object store</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @return                   the X509 object stack</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-static inline STACK_OF(X509_OBJECT)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-*X509_STORE_get0_objects(X509_STOR=
E *store)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return store ? store-&gt;obj=
s : NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * Get the type of an X509 object</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
@param obj                X509 object</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @return                   The underlying object type</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-X509_OBJECT_get_type(const X509_OBJECT *obj)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return obj ? obj-&gt;type : X509_LU_FAI=
L;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
Get the RSA object of a public key</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @pa=
ram pkey                Public key object</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * @return                    The underlying RSA object=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static inline RSA *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-EVP_PKEY_get0_RSA(EVP_PKEY *pkey)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return (pkey &amp;&amp; pkey-&gt;type =3D=3D =
EVP_PKEY_RSA) ? pkey-&gt;pkey.rsa : NULL;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * Get the EC_KEY object of a public ke=
y</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * @param pkey                Public ke=
y object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return   =
                 The underlying EC_KEY object</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-static inline EC_KEY *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-EVP_PKEY_get0_EC_KEY(EVP_PKEY *pkey)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    return (pkey &amp;&amp; pkey-&gt;type =3D=3D EVP_PKEY_EC) ? pkey-&gt;=
pkey.ec : NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Get the =
DSA object of a public key</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param pkey=
                Public key object</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * @return                    The underlying DSA object</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static inline DSA *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-EVP_PKEY_get0_DSA(EVP_PKEY *pkey)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    return (pkey &amp;&amp; pkey-&gt;type =3D=3D EVP_PKEY=
_DSA) ? pkey-&gt;pkey.dsa : NULL;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * Set the RSA flags</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * @param rsa                 The RSA object</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param flags               New flags val=
ue</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-RSA_set_flags(RSA *rsa, int flags)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (rsa)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        rsa-&gt;flags =3D flags;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * Get the RSA parameters</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* @param rsa                 The RSA object</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * @param n                   The @c n parameter</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param e               =
    The @c e parameter</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * @param d                   The @c d parameter</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-static inline void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-RSA_get0_key(const RSA *rsa, const BIGNUM **n,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-             const BIGNUM **e, const BIGNUM=
 **d)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (n !=3D NULL)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        *n =3D rsa ? rsa-&gt;n : NULL;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (e !=3D NULL)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        *e =3D rsa ? rsa-&gt;e : NULL;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (d !=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *d=
 =3D rsa ? rsa-&gt;d : NULL;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * Set the RSA parameters</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @para=
m rsa                 The RSA object</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * @param n                   The @c n parameter</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * @param e                   The=
 @c e parameter</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @pa=
ram d                   The @c d parameter</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * @return                    1 on success, 0 on error=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-RSA_set0_key(RSA *rsa, BIGNUM *n, BIGNUM *e=
, BIGNUM *d)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((rsa-&gt;n =3D=3D NUL=
L &amp;&amp; n =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        || (rsa-&gt;e =3D=3D NULL &amp;&amp; e =3D=3D NULL))</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (n !=
=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        BN_free(rsa-&gt;n);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        rsa-&gt;n =3D =
n;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (e !=3D NULL)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        BN_free(rsa-&gt;e);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        rsa-&gt;e =3D e;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (d !=3D NULL)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       BN_free(rsa-&gt;d);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        rsa-&gt;d =3D d;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return 1;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Number of signific=
ant RSA bits</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * @param rsa               =
 The RSA object ; shall not be NULL</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * @return                   The number of RSA bits or 0 on e=
rror</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-RSA_bits(const RSA *rsa)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const BIGNUM *n =3D NULL;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    RSA_get0_key(rsa, &amp;n, NULL, NULL);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    return n ? BN_num_bits(=
n) : 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * Get the DSA parameters</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param dsa=
                 The DSA object</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @param p                   The @c p parameter</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * @param q                   The @c q=
 parameter</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param g=
                   The @c g parameter</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
atic inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-DSA_g=
et0_pqg(const DSA *dsa, const BIGNUM **p,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-             const BIGNUM **q, const BIGNUM **g)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (p !=3D NULL)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        *p =3D dsa ? dsa-&gt;p : NULL;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (q !=3D NULL)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  *q =3D dsa ? dsa-&gt;q : NULL;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (g !=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *g =3D dsa ? d=
sa-&gt;g : NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Nu=
mber of significant DSA bits</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param rs=
a                The DSA object ; shall not be NULL</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @return                   The number of =
DSA bits or 0 on error</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-DSA_bits(const DSA *d=
sa)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    const BIGNUM *p =3D NULL;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    DSA_get0_pqg(dsa, &amp;p, =
NULL, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n p ? BN_num_bits(p) : 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * Allocate a new RSA method object</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * @param name               The object name</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * @param flags              Configur=
ation flags</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return=
                   A new RSA method object</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-static inline RSA_METHOD *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-RSA_meth_new(const char *name, int flags)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    RSA_METHOD *rsa_meth =3D NULL;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    ALLOC_OBJ_CLEAR(rsa_meth, RSA_METHOD);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    rsa_meth-&gt;name =3D string_=
alloc(name, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 rsa_meth-&gt;flags =3D flags;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    return rsa_meth;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Free an existing RSA_METHOD object</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * @param meth               The RSA_METHOD object</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-RSA_meth_free(RSA_METHOD *meth)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (meth)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   /* OpenSSL defines meth-&gt;name to be a const pointer, yet we</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-         * feed it with an allo=
cated string (from RSA_meth_new()).</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-         * Thus we are allowed to free it here. In order to a=
void a</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * &quo=
t;passing &#39;const char *&#39; to parameter of type &#39;void *&#39; disc=
ards</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * qualif=
iers&quot; warning, we force the pointer to be a non-const value.</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        free((char *)meth-&gt;name);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        free(meth);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * Set the public encoding =
function of an RSA_METHOD object</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @para=
m meth               The RSA_METHOD object</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * @param pub_enc            the public encoding funct=
ion</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return        =
           1 on success, 0 on error</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-RSA_meth=
_set_pub_enc(RSA_METHOD *meth,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                     int (*pub_enc)(int flen, const unsigned char =
*from,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                     unsigned char *to, RSA *rsa,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                                    int padding=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (meth)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        meth-&gt;rsa_pub_enc =3D pub_enc;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return 1;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * Set the public decoding function of an RSA_METHOD ob=
ject</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * @param meth               The RSA=
_METHOD object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @par=
am pub_dec            the public decoding function</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * @return                   1 on success, 0 o=
n error</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-RSA_meth_set_pub_dec(RSA_METHOD *met=
h,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
  int (*pub_dec)(int flen, const unsigned char *from,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                    unsigne=
d char *to, RSA *rsa,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                    int padding))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (meth)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        meth-&gt=
;rsa_pub_dec =3D pub_dec;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        return 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Set =
the private encoding function of an RSA_METHOD object</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * @param meth               The RSA_METHOD object</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * @param priv_enc           the =
private encoding function</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @return                   1 on success, 0 on error</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-RSA_meth_set_priv_enc(RSA_METHOD *meth,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                      int (*priv_enc)(int f=
len, const unsigned char *from,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                      unsigned char *to, RSA *rsa=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
                  int padding))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (me=
th)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        meth-&gt;rsa_priv_enc =3D =
priv_enc;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * Set the private decod=
ing function of an RSA_METHOD object</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @=
param meth               The RSA_METHOD object</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * @param priv_dec           the private decoding =
function</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return   =
                1 on success, 0 on error</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-RSA=
_meth_set_priv_dec(RSA_METHOD *meth,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                      int (*priv_dec)(int flen, const unsign=
ed char *from,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                               unsigned char *to, RSA *rsa,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
 int padding))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (meth)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        meth-&gt;rsa_priv_dec =3D priv_dec;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return 1;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * Set the init function of an RSA_METHOD=
 object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * @param meth               The =
RSA_METHOD object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @=
param init               the init function</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * @return                   1 on success, 0 on error<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-RSA_meth_set_init(RSA_METHOD *meth, int (*i=
nit)(RSA *rsa))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (meth)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        meth-&gt;init =3D init;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Set the sign function of an RSA_METHOD object</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param meth               The RSA_METHOD=
 object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param sign=
               The sign function</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * @return                   1 on success, 0 on error</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-static inline</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-R=
SA_meth_set_sign(RSA_METHOD *meth,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                  int (*sign)(int type, const unsigned char *m=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
          unsigned int m_length,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                              unsigned char *sigret, unsigned in=
t *siglen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                   const RSA *rsa))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    me=
th-&gt;rsa_sign =3D sign;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * Set the finish function of an RSA_METHOD object</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * @param meth               The RSA_METHOD object<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param finish      =
       the finish function</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * @return                   1 on success, 0 on error</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-RSA_meth_set_finish(RSA_METHOD *meth, int (*finish)(RSA *rsa=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (meth)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        meth-&gt;finish =3D finish;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        return 1;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * Set the application data of an RSA_METHOD object</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * @param meth               The RSA_METHOD object=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param app_data   =
        Application data</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @return                   1 on success, 0 on error</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-RSA_meth_set0_app_data(RSA_METHOD *meth, void *app_data)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (meth)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        meth-&gt;app_data =3D app_data;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        return 1;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * Get the application data of an RSA_METHOD object</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * @param meth               The RSA_METHOD object</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return               =
    pointer to application data, may be NULL</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static inline void *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-RSA_meth_get0_app_data(const RSA_METHOD *meth)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    return meth ? meth-&gt;app_data : NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * Gets the number of bits =
of the order of an EC_GROUP</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  @param  g=
roup               EC_GROUP object</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  @return                     number of bits of group order.=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-EC_GROUP_order_bits(const EC_GROUP *group)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    BIGNUM *order =3D BN_new();</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    EC_GROUP_get_order(group, or=
der, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int bi=
ts =3D BN_num_bits(order);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    BN_free(order);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return bits;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* SSLeay symbols have been renamed in Open=
SSL 1.1 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPE=
NSSL_VERSION SSLEAY_VERSION</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define OpenSSL_version SSLeay_version</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/** Return the min SSL protocol version currently enabled in the context.=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  If no valid versi=
on &gt;=3D TLS1.0 is found, return 0. */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-SSL_CTX_get_min_proto_version(SSL_CTX *ctx)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    long sslopt =3D SSL_CTX_get_options(ctx);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (!(sslopt &amp; SSL_OP_NO_T=
LSv1))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return TLS1_VERSION;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (!(sslopt &amp; SSL_OP_NO_TLSv1_1=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        return TLS1_1_VERSION;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (!(sslopt &amp; SSL_OP_NO_TLSv1_2))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        return TLS1_2_VERSION;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Return the ma=
x SSL protocol version currently enabled in the context.</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *  If no valid version &gt;=3D TLS1.0 i=
s found, return 0. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SSL_=
CTX_get_max_proto_version(SSL_CTX *ctx)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  long sslopt =3D SSL_CTX_get_options(ctx);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!(sslopt &amp; SSL_OP_NO_TLSv1_2))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        return TLS1_2_VERSION;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (!(sslopt &amp; SSL_OP_NO_TLSv1_1))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        return TLS1_1_VERSION;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (!(sslopt &amp; SSL_OP_NO_TLSv1))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        return TLS1_VERSION;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/** Mimics SSL_CTX_set_min_proto_vers=
ion for OpenSSL &lt; 1.1 */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-SSL_CTX_set_min_proto_version(SSL_CTX *ctx, long tls_ver_min)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    long sslopt =3D SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3=
; /* Never do &lt; TLS 1.0 */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tls_v=
er_min &gt; TLS1_VERSION)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sslo=
pt |=3D SSL_OP_NO_TLSv1;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef SSL_OP=
_NO_TLSv1_1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tl=
s_ver_min &gt; TLS1_1_VERSION)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 sslopt |=3D SSL_OP_NO_TLSv1_1;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef SSL_OP_NO_TLSv=
1_2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tls_ver_mi=
n &gt; TLS1_2_VERSION)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sslopt =
|=3D SSL_OP_NO_TLSv1_2;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    SSL_CTX_set_options(ctx, =
sslopt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return 1;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Mimi=
cs SSL_CTX_set_max_proto_version for OpenSSL &lt; 1.1 */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-SSL_CTX_set_max_proto_version(SSL_CTX *ctx,=
 long tls_ver_max)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    long sslopt =3D 0;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (tls_ver_max &lt; TLS1_VERSION)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        sslopt |=3D SSL_OP_NO_TLSv1;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef SSL_OP_NO_TLSv1_1</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (tls_ver_max &lt; TLS1_1_VERSION)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        sslopt |=3D SSL_OP_NO_TLSv1_1=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef SSL_OP_NO_TLSv1_2</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (tls_ver_max &lt; TLS1_2_VERSION)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        sslopt |=3D SSL_OP_NO_TLSv1_2;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    SSL_CTX_set_options(ctx, sslopt);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return 1;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if OP=
ENSSL_VERSION_NUMBER &lt; 0x10100000L &amp;&amp; !defined(ENABLE_CRYPTO_WOL=
FSSL) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> /* Functionality missing in 1.1.1 */</span><br><span> #if OPENSSL_VERS=
ION_NUMBER &lt; 0x30000000L &amp;&amp; !defined(OPENSSL_NO_EC)</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/=
ssl_openssl.c</span><br><span>index a158617..efdd882 100644</span><br><span=
>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_open=
ssl.c</span><br><span>@@ -84,13 +84,6 @@</span><br><span> void</span><br><s=
pan> tls_init_lib(void)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt; 0x10100000L</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    SSL_library_init();</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    SSL_load_error_strings();</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    OpenSSL_add_all_algorithms();</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>   =
  mydata_index =3D SSL_get_ex_new_index(0, &quot;struct session *&quot;, NU=
LL, NULL, NULL);</span><br><span>     ASSERT(mydata_index &gt;=3D 0);</span=
><br><span> }</span><br><span>@@ -98,12 +91,6 @@</span><br><span> void</spa=
n><br><span> tls_free_lib(void)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt; 0x10100000L</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    EVP_cleanup();</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ERR_free_strings();</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> }</span><br><span=
> </span><br><span> void</span><br><span>@@ -526,7 +513,8 @@</span><br><spa=
n> void</span><br><span> tls_ctx_set_cert_profile(struct tls_root_ctx *ctx,=
 const char *profile)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &gt; 0x10100000L &amp;&amp; !=
defined(LIBRESSL_VERSION_NUMBER)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if OPENSSL_VERSION_NUMBER &gt; 0x10100000L    \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    || (defined(LIBRESSL_VERSION_=
NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &gt;  0x3060000fL)</span><br><sp=
an>     /* OpenSSL does not have certificate profiles, but a complex set of=
</span><br><span>      * callbacks that we could try to implement to achiev=
e something similar.</span><br><span>      * For now, use OpenSSL&#39;s sec=
urity levels to achieve similar (but not equal)</span><br><span>@@ -555,7 +=
543,7 @@</span><br><span> #else  /* if OPENSSL_VERSION_NUMBER &gt; 0x101000=
00L */</span><br><span>     if (profile)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;WARNING=
: OpenSSL 1.0.2 and LibreSSL do not support &quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;WARNING: OpenSSL 1=
.1.0 and LibreSSL do not support &quot;</span><br><span>             &quot;=
--tls-cert-profile, ignoring user-set profile: &#39;%s&#39;&quot;, profile)=
;</span><br><span>     }</span><br><span> #endif /* if OPENSSL_VERSION_NUMB=
ER &gt; 0x10100000L */</span><br><span>@@ -744,15 +732,6 @@</span><br><span=
>     }</span><br><span>     else</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt; 0x101000=
00L</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        /* OpenSSL 1.0.2 and newer can =
automatically handle ECDH parameter</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-         * loading */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        SSL_CTX_set_ecdh_auto(ctx-&gt;ctx, 1);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        /* OpenSSL 1.1.0 and newer have always ecdh auto =
loading enabled,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
    * so do nothing */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span>         return;</span><br><span>     }</span><br><=
span> </span><br><span>@@ -1348,7 +1327,7 @@</span><br><span>     return 0;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &gt; 0x10100000L &amp;&amp; !def=
ined(OPENSSL_NO_EC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if !defined(OPENSSL_NO_EC)</span><br><span> </span><br><span> /* called wh=
en EC_KEY is destroyed */</span><br><span> static void</span><br><span>@@ -=
1469,7 +1448,7 @@</span><br><span>     EC_KEY_free(ec);</span><br><span>   =
  return 0;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif /* OPENSSL_VERSION_NUMBER &gt; 1.1.0 dev &amp;&amp; !define=
d(OPENSSL_NO_EC) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif /* !defined(OPENSSL_NO_EC) */</span><br><span> #endif /* ENABLE_MANA=
GEMENT &amp;&amp; !HAVE_XKEY_PROVIDER */</span><br><span> </span><br><span>=
 #ifdef ENABLE_MANAGEMENT</span><br><span>@@ -1509,7 +1488,7 @@</span><br><=
span>             goto cleanup;</span><br><span>         }</span><br><span>=
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if (OPENSSL_VE=
RSION_NUMBER &gt; 0x10100000L) &amp;&amp; !defined(OPENSSL_NO_EC)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(OPENSSL_NO_EC)</=
span><br><span> #if OPENSSL_VERSION_NUMBER &lt; 0x30000000L</span><br><span=
>     else if (EVP_PKEY_id(pkey) =3D=3D EVP_PKEY_EC)</span><br><span> #else=
 /* OPENSSL_VERSION_NUMBER &lt; 0x30000000L */</span><br><span>@@ -1526,13 =
+1505,13 @@</span><br><span>         crypto_msg(M_WARN, &quot;management-ex=
ternal-key requires an RSA or EC certificate&quot;);</span><br><span>      =
   goto cleanup;</span><br><span>     }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#else  /* OPENSSL_VERSION_NUMBER &gt; 1.1.0 dev &amp;&amp=
; !defined(OPENSSL_NO_EC) */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#else  /* !defined(OPENSSL_NO_EC) */</span><br><span>     else</sp=
an><br><span>     {</span><br><span>         crypto_msg(M_WARN, &quot;manag=
ement-external-key requires an RSA certificate&quot;);</span><br><span>    =
     goto cleanup;</span><br><span>     }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif /* OPENSSL_VERSION_NUMBER &gt; 1.1.0 dev &amp;&a=
mp; !defined(OPENSSL_NO_EC) */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif /* !defined(OPENSSL_NO_EC) */</span><br><span> </span><br=
><span> #endif /* HAVE_XKEY_PROVIDER */</span><br><span> </span><br><span>@=
@ -2166,7 +2145,7 @@</span><br><span>     EVP_PKEY_free(pkey);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if (!defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; OPENSSL_VERSION_NUMBER=
 &gt;=3D 0x1010000fL) \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if !defined(LIBRESSL_VERSION_NUMBER) \</span><br><span>     || (define=
d(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &gt;=3D 0x309=
0000fL)</span><br><span> /**</span><br><span>  * Translate an OpenSSL NID i=
nto a more human readable name</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/559?usp=3Demail">ch=
ange 559</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/559?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I90875311a4e4c403e77e30b609c=
1878cbaaaad45 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 559 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--prxNzzShq1Q=--

