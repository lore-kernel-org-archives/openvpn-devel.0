From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 29 Apr 2024 16:22:35 +0000
References: <gerrit.1714407751000.I90875311a4e4c403e77e30b609c1878cbaaaad45@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <5a52619e114652a33de461bbc01acf7aae94d434-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P7QMWgPQ9rA="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--P7QMWgPQ9rA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/559?usp=3Demail

to review the following change.


Change subject: Remove OpenSSL 1.0.2 support
......................................................................

Remove OpenSSL 1.0.2 support

With Centos 7/Red Hat Enterprise Linux 7 being EOL this June, the last
distributions that still support OpenSSL 1.0.2 are finally EOL. This
means we no longer need to support OpenSSL 1.0.2

Change-Id: I90875311a4e4c403e77e30b609c1878cbaaaad45
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M configure.ac
M src/openvpn/crypto_openssl.c
M src/openvpn/openssl_compat.h
M src/openvpn/ssl_openssl.c
4 files changed, 15 insertions(+), 686 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/559/1

diff --git a/configure.ac b/configure.ac
index ce8b2b0..51f00a4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -911,7 +911,7 @@
 				]],
 				[[
 /*	     Version encoding: MNNFFPPS - see opensslv.h for details */
-#if OPENSSL_VERSION_NUMBER < 0x10002000L
+#if OPENSSL_VERSION_NUMBER < 0x10100000L
 #error OpenSSL too old
 #endif
 				]]
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
index a158617..e13fe11 100644
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
@@ -744,15 +731,6 @@
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

@@ -1348,7 +1326,7 @@
     return 0;
 }

-#if OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(OPENSSL_NO_EC)
+#if !defined(OPENSSL_NO_EC)

 /* called when EC_KEY is destroyed */
 static void
@@ -1469,7 +1447,7 @@
     EC_KEY_free(ec);
     return 0;
 }
-#endif /* OPENSSL_VERSION_NUMBER > 1.1.0 dev && !defined(OPENSSL_NO_EC) */
+#endif /* !defined(OPENSSL_NO_EC) */
 #endif /* ENABLE_MANAGEMENT && !HAVE_XKEY_PROVIDER */

 #ifdef ENABLE_MANAGEMENT
@@ -1509,7 +1487,7 @@
             goto cleanup;
         }
     }
-#if (OPENSSL_VERSION_NUMBER > 0x10100000L) && !defined(OPENSSL_NO_EC)
+#if !defined(OPENSSL_NO_EC)
 #if OPENSSL_VERSION_NUMBER < 0x30000000L
     else if (EVP_PKEY_id(pkey) =3D=3D EVP_PKEY_EC)
 #else /* OPENSSL_VERSION_NUMBER < 0x30000000L */
@@ -1526,13 +1504,13 @@
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

@@ -2166,7 +2144,7 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--P7QMWgPQ9rA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/559?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove OpenSSL 1.0.2 support<br><br>With Centos 7/Red Hat Ent=
erprise Linux 7 being EOL this June, the last<br>distributions that still s=
upport OpenSSL 1.0.2 are finally EOL. This<br>means we no longer need to su=
pport OpenSSL 1.0.2<br><br>Change-Id: I90875311a4e4c403e77e30b609c1878cbaaa=
ad45<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M con=
figure.ac<br>M src/openvpn/crypto_openssl.c<br>M src/openvpn/openssl_compat=
.h<br>M src/openvpn/ssl_openssl.c<br>4 files changed, 15 insertions(+), 686=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/59/559/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac</span><=
br><span>index ce8b2b0..51f00a4 100644</span><br><span>--- a/configure.ac</=
span><br><span>+++ b/configure.ac</span><br><span>@@ -911,7 +911,7 @@</span=
><br><span> 				]],</span><br><span> 				[[</span><br><span> /*	     Versio=
n encoding: MNNFFPPS - see opensslv.h for details */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt; 0x10002000L=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if OPENSSL_VERSION=
_NUMBER &lt; 0x10100000L</span><br><span> #error OpenSSL too old</span><br>=
<span> #endif</span><br><span> 				]]</span><br><span>diff --git a/src/open=
vpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c</span><br><span>index b=
2c4eb6..64ad346 100644</span><br><span>--- a/src/openvpn/crypto_openssl.c</=
span><br><span>+++ b/src/openvpn/crypto_openssl.c</span><br><span>@@ -49,7 =
+49,7 @@</span><br><span> #include &lt;openssl/rand.h&gt;</span><br><span> =
#include &lt;openssl/ssl.h&gt;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#if (OPENSSL_VERSION_NUMBER &gt;=3D 0x10100000L)=
 &amp;&amp; !defined(LIBRESSL_VERSION_NUMBER)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if !defined(LIBRESSL_VERSION_NUMBER)</span><br><=
span> #include &lt;openssl/kdf.h&gt;</span><br><span> #endif</span><br><spa=
n> #if OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</span><br><span>@@ -193,1=
1 +193,7 @@</span><br><span> void</span><br><span> crypto_init_lib(void)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if (=
OPENSSL_VERSION_NUMBER &gt;=3D 0x10100000L)</span><br><span>     OPENSSL_in=
it_crypto(OPENSSL_INIT_LOAD_CONFIG, NULL);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    OPENSSL_config(NULL);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span>     /*</span><br><span>      * If you buil=
d the OpenSSL library and OpenVPN with</span><br><span>      * CRYPTO_MDEBU=
G, you will get a listing of OpenSSL</span><br><span>@@ -1376,7 +1372,7 @@<=
/span><br><span> </span><br><span>     return ret;</span><br><span> }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif (OPENSSL_VERSION_NUMB=
ER &gt;=3D 0x10100000L) &amp;&amp; !defined(LIBRESSL_VERSION_NUMBER)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#elif !defined(LIBRESSL_VE=
RSION_NUMBER)</span><br><span> bool</span><br><span> ssl_tls1_PRF(const uin=
t8_t *seed, int seed_len, const uint8_t *secret,</span><br><span>          =
    int secret_len, uint8_t *output, int output_len)</span><br><span>@@ -14=
22,7 +1418,7 @@</span><br><span>     EVP_PKEY_CTX_free(pctx);</span><br><sp=
an>     return ret;</span><br><span> }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#else  /* if OPENSSL_VERSION_NUMBER &gt;=3D 0x10100000L */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* if define=
d(LIBRESSL_VERSION_NUMBER) */</span><br><span> /*</span><br><span>  * Gener=
ate the hash required by for the \c tls1_PRF function.</span><br><span>  *<=
/span><br><span>@@ -1601,5 +1597,5 @@</span><br><span>     gc_free(&amp;gc)=
;</span><br><span>     return ret;</span><br><span> }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* if OPENSSL_VERSION_NUMBER &gt;=3D=
 0x10100000L */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if /* if LIBRESSL_VERSION_NUMBER */</span><br><span> #endif /* ENABLE_CRYPT=
O_OPENSSL */</span><br><span>diff --git a/src/openvpn/openssl_compat.h b/sr=
c/openvpn/openssl_compat.h</span><br><span>index c9fa719..95417b2 100644</s=
pan><br><span>--- a/src/openvpn/openssl_compat.h</span><br><span>+++ b/src/=
openvpn/openssl_compat.h</span><br><span>@@ -50,8 +50,8 @@</span><br><span>=
 #define SSL_CTX_set1_groups SSL_CTX_set1_curves</span><br><span> #endif</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Fun=
ctionality missing in LibreSSL before 3.5 and OpenSSL 1.0.2 */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if (OPENSSL_VERSION_NUMBER &lt; 0=
x10100000L || (defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION=
_NUMBER &lt; 0x3050000fL)) &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Functionality missing =
in LibreSSL before 3.5 */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMB=
ER &lt; 0x3050000fL</span><br><span> /**</span><br><span>  * Destroy a X509=
 object</span><br><span>  *</span><br><span>@@ -71,659 +71,14 @@</span><br>=
<span> #define EVP_CTRL_AEAD_GET_TAG                EVP_CTRL_GCM_GET_TAG</s=
pan><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if (OPENSSL_VERSION_NUMBER &lt; 0x10100000L || defined(L=
IBRESSL_VERSION_NUMBER)) &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(LIBRESSL_VERSIO=
N_NUMBER)</span><br><span> #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA=
_F_RSA_EAY_PRIVATE_ENCRYPT</span><br><span> #endif</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if (OPENSSL_VERSION_NUMBER =
&lt; 0x10100000L &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)) || (defined(LI=
BRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &lt; 0x3050400fL)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(LIBRESS=
L_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &lt; 0x3050400fL</span=
><br><span> #define SSL_get_peer_tmp_key SSL_get_server_tmp_key</span><br><=
span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-/* Functionality missing in 1.0.2 */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt; 0x10100000L &amp;&a=
mp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * R=
eset a message digest context</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param c=
tx                 The message digest context</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * @return                    1 on success, 0 on er=
ror</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-EVP_MD_CTX_reset(EVP_MD_CTX *ctx)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    EVP_MD_CTX_cleanup(ctx);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return 1;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * Free an existing message diges=
t context</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * @param ctx                 T=
he message digest context</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-EVP_MD_CTX_free(E=
VP_MD_CTX *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    free(ctx);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Allocate a new=
 message digest object</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return        =
            A zero&#39;ed message digest object</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static inline EVP_MD_CTX *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-EVP_MD_CTX_new(void)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    EVP_=
MD_CTX *ctx =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    ALLOC_OBJ_CLEAR(ctx, EVP_MD_CTX);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return ctx;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define EVP_CIPHER_CTX_reset EV=
P_CIPHER_CTX_init</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine X509_get0_notBefore X509_get_notBefore</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define X509_get0_notAfter X509_get_notAfter</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * Reset a HMAC context</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * OpenSSL 1=
.1+ removes APIs HMAC_CTX_init() and HMAC_CTX_cleanup()</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * and replace them with a single call th=
at does a cleanup followed</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * by an init. A proper _reset() for OpenSSL &lt; 1.1 should perform</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * a similar set of ope=
rations.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * It means that before we kill =
a HMAC context, we&#39;ll have to cleanup</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * again, as we probably have allocated a few resources=
 when we forced</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * an =
init.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * @param ctx                 The H=
MAC context</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return=
                    1 on success, 0 on error</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-HMAC_CTX_reset(HMAC_CTX *ctx)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    HMAC_CT=
X_cleanup(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    HM=
AC_CTX_init(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * Cleanup and free an existing HMAC context</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * @param ctx                 The HMAC context</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-HMAC_CTX_free(HMAC_CTX *ctx)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   HMAC_CTX_cleanup(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    free(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * Allocate a new HMAC context object</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * @return                    A zero&#39;ed HMAC context objec=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static inline HMAC_CTX *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-HMAC_CTX_new(void)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    HMAC_CTX *ctx =3D NULL;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    ALLOC_OBJ_CLEAR(ctx, HMAC_CTX);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return ctx;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * Fetch the default passwo=
rd callback user data from the SSL context</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * @param ctx                SSL context</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * @return                   The password callback use=
r data</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static inline void *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-SSL_CTX_get_default_passwd_cb_user=
data(SSL_CTX *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ctx ? ctx-&g=
t;default_passwd_callback_userdata : NULL;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * Fetch the default password callback=
 from the SSL context</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param ctx      =
          SSL context</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @return                   The password callback</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static inline pem_password_cb *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-SSL_CTX_get_default_passwd_cb(SSL_CTX *ctx)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return ctx ? ctx-&gt;default_passwd_callback : N=
ULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* Get the public key from a X509 certificate</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @param x                  X509 certificate</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * @return                   The certificate pu=
blic key</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static inline EVP_PKEY *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-X509_get0_pubkey(const X509 =
*x)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return (x &amp;&amp; x-&gt;cert_in=
fo &amp;&amp; x-&gt;cert_info-&gt;key) ?</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-           x-&gt;cert_info-&gt;key-&gt;pkey : NULL;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Fetch t=
he X509 object stack from the X509 store</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @param store              X509 object store</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * @return                   the X509 object stack=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static inline STACK_OF(X509_OBJECT)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-*X509_STORE_get0_objects(=
X509_STORE *store)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return store ? stor=
e-&gt;objs : NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * Get the type of an X509 object</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * @param obj                X509 object</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * @return                   The underlying objec=
t type</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-X509_OBJECT_get_type(const X509_OBJEC=
T *obj)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return obj ? obj-&gt;type : X5=
09_LU_FAIL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * Get the RSA object of a public key</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @param pkey                Public key object</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * @return                    The underlying R=
SA object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static inline RSA *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-EVP_PKEY_get0_RSA(EVP_PKEY *pkey=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return (pkey &amp;&amp; pkey-&gt;typ=
e =3D=3D EVP_PKEY_RSA) ? pkey-&gt;pkey.rsa : NULL;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * Get the EC_KEY object of a =
public key</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * @param pkey                =
Public key object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @=
return                    The underlying EC_KEY object</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static inline EC_KEY *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-EVP_PKEY_get0_EC_KEY(EVP_PKEY *pkey)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return (pkey &amp;&amp; pkey-&gt;type =3D=3D EVP_PKEY_EC) ?=
 pkey-&gt;pkey.ec : NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* Get the DSA object of a public key</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @=
param pkey                Public key object</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * @return                    The underlying DSA obje=
ct</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-static inline DSA *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-EVP_PKEY_get0_DSA(EVP_PKEY *pkey)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    return (pkey &amp;&amp; pkey-&gt;type =3D=
=3D EVP_PKEY_DSA) ? pkey-&gt;pkey.dsa : NULL;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * Set the RSA flags</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * @param rsa                 The RSA object</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * @param flags               Ne=
w flags value</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-RSA_set_flags(RSA *rsa, int f=
lags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (rsa)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        rsa-&gt;flags =3D flags;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * Get the RSA parameters</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * @param rsa                 The RSA object</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * @param n                   The @c n =
parameter</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param e =
                  The @c e parameter</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * @param d                   The @c d parameter</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-RSA_get0_key(const RSA *rsa, const BIGNUM **n,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-             const BIGNUM **e=
, const BIGNUM **d)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (n !=3D NULL)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        *n =3D rsa ? rsa-&gt;n : NULL;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (e !=3D NULL)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        *e =3D rsa ? rsa-&gt;e : NULL;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (d !=3D NULL)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        *d =3D rsa ? rsa-&gt;d : NULL;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * Set the RSA parameters</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * @param rsa                 The RSA object</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * @param n                   The @c n paramet=
er</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param e        =
           The @c e parameter</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * @param d                   The @c d parameter</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * @return                    1 on succe=
ss, 0 on error</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-RSA_set0_key(RSA *rsa, BIGNUM=
 *n, BIGNUM *e, BIGNUM *d)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((rsa-&g=
t;n =3D=3D NULL &amp;&amp; n =3D=3D NULL)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        || (rsa-&gt;e =3D=3D NULL &amp;&amp; e =3D=3D N=
ULL))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (n !=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        BN_free=
(rsa-&gt;n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
sa-&gt;n =3D n;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (e !=3D NULL)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        BN_free(rsa-&gt;e);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        rsa-&gt;e =3D e;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (d !=3D NULL)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        BN_free(rsa-&gt;d);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        rsa-&gt;d =3D d;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 1;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Numb=
er of significant RSA bits</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param rsa =
               The RSA object ; shall not be NULL</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * @return                   The number of RSA =
bits or 0 on error</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-RSA_bits(const RSA *rsa)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    const BIGNUM *n =3D NULL;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    RSA_get0_key(rsa, &amp;n, NULL=
, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return n =
? BN_num_bits(n) : 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * Get the DSA parameters</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * @param dsa                 The DSA object</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * @param p                   The @c p parameter</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param q             =
      The @c q parameter</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @param g                   The @c g parameter</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-DSA_get0_pqg(const DSA *dsa, const BIGNUM **p,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-             const BIGNUM **q, const BI=
GNUM **g)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (p !=3D NULL)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        *p =3D dsa ? dsa-&gt;p : NULL;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (q !=3D NULL)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        *q =3D dsa ? dsa-&gt;q : NULL;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (g !=3D NULL)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  *g =3D dsa ? dsa-&gt;g : NULL;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * Number of significant DSA bits</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @param rsa                The DSA object ; shall not be NULL</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * @return                   =
The number of DSA bits or 0 on error</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-DSA_bit=
s(const DSA *dsa)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    const BIGNUM *p =3D =
NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DSA_get0_pqg=
(dsa, &amp;p, NULL, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return p ? BN_num_bits(p) : 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * Allocate a new RSA method object</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * @param name               The object name</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param flags        =
      Configuration flags</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @return                   A new RSA method object</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static inline RSA_METHOD *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-RSA_meth_new(const char *name, int flags)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    RSA_METHOD *rsa_meth =3D NULL;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ_CLEAR(rsa_meth, RSA_METHOD=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    rsa_meth-&gt;na=
me =3D string_alloc(name, NULL);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    rsa_meth-&gt;flags =3D flags;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return rsa_meth;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * Free an existing RSA_METHOD object=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * @param meth               The RSA_MET=
HOD object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-RSA_meth_free(RSA_METHOD *meth)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (meth)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        /* OpenSSL defines meth-&gt;name to be a const pointer, ye=
t we</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * feed i=
t with an allocated string (from RSA_meth_new()).</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-         * Thus we are allowed to free it here.=
 In order to avoid a</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
        * &quot;passing &#39;const char *&#39; to parameter of type &#39;vo=
id *&#39; discards</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
      * qualifiers&quot; warning, we force the pointer to be a non-const va=
lue.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        free((char *)meth-&=
gt;name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        free=
(meth);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Set the pub=
lic encoding function of an RSA_METHOD object</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * @param meth               The RSA_METHOD object</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * @param pub_enc            the public e=
ncoding function</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @r=
eturn                   1 on success, 0 on error</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-RSA_meth_set_pub_enc(RSA_METHOD *meth,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                     int (*pub_enc)(int flen, const u=
nsigned char *from,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                                  unsigned char *to, RSA *rsa,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
  int padding))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (meth)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        meth-&gt;rsa_pub_enc =3D pub_enc;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return 1;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    return 0;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * Set the public decoding function of an =
RSA_METHOD object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param meth         =
      The RSA_METHOD object</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * @param pub_dec            the public decoding function</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * @return                   1 on=
 success, 0 on error</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-RSA_meth_set_pub_dec(RS=
A_METHOD *meth,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
               int (*pub_dec)(int flen, const unsigned char *from,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
      unsigned char *to, RSA *rsa,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                    int padding))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (meth)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     meth-&gt;rsa_pub_dec =3D pub_dec;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return 1;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * Set the private encoding function of an RSA_METHOD object</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * @param meth               The RSA_METHOD object=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param priv_enc   =
        the private encoding function</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @return                   1 on success, 0 on error</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-RSA_meth_set_priv_enc(RSA_METHOD *meth,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                      int (*p=
riv_enc)(int flen, const unsigned char *from,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                      unsigned char=
 *to, RSA *rsa,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                                int padding))</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (meth)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        meth-&gt;rsa=
_priv_enc =3D priv_enc;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        return 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Set the=
 private decoding function of an RSA_METHOD object</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @param meth               The RSA_METHOD object</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * @param priv_dec           the pri=
vate decoding function</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * @return                   1 on success, 0 on error</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-RSA_meth_set_priv_dec(RSA_METHOD *meth,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                      int (*priv_dec)(int flen=
, const unsigned char *from,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                                      unsigned char *to, RSA *rsa,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
               int padding))</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (meth)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        meth-&gt;rsa_priv_dec =3D pri=
v_dec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return =
1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * Set the init function of=
 an RSA_METHOD object</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param meth     =
          The RSA_METHOD object</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @param init               the init function</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * @return                   1 on succes=
s, 0 on error</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-RSA_meth_set_init(RSA_METHOD *=
meth, int (*init)(RSA *rsa))</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (meth)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        meth-&gt;init =3D init;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 1;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    return 0;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * Set the sign function of an RSA_METH=
OD object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * @param meth               Th=
e RSA_METHOD object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 @param sign               The sign function</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * @return                   1 on success, 0 on erro=
r</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static inline</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-RSA_meth_set_sign(RSA_METHOD *meth,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                  int (*sign)(int type, const unsi=
gned char *m,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                      unsigned int m_length,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                              unsigned char *sigret,=
 unsigned int *siglen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                              const RSA *rsa))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    meth-&gt;rsa_sign =3D sign;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return 1;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Set the finish function of an RSA_METHOD object<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * @param meth               The RSA_METH=
OD object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param fi=
nish             the finish function</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * @return                   1 on success, 0 on error</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-RSA_meth_set_finish(RSA_METHOD *meth, int (*finish=
)(RSA *rsa))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (meth)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        meth-&gt;finish =3D finish;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        return 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Set the application data of an RSA_METHOD object=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * @param meth               The RSA_MET=
HOD object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param a=
pp_data           Application data</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * @return                   1 on success, 0 on error</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-RSA_meth_set0_app_data(RSA_METHOD *meth, void *app_d=
ata)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (meth)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        meth-&gt;app_data =3D app_data;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Get the application data of an RSA_METHOD object=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * @param meth               The RSA_MET=
HOD object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return =
                  pointer to application data, may be NULL</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static inline void *</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-RSA_meth_get0_app_data(const RSA_METHOD *meth)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return meth ? meth-&gt;app_data : NULL;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Gets the nu=
mber of bits of the order of an EC_GROUP</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *  @param  group               EC_GROUP object</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  @return                     number of bits of=
 group order.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-EC_GROUP_order_bits(const EC_G=
ROUP *group)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    BIGNUM *order =3D BN_new(=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    EC_GROUP_get_or=
der(group, order, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    int bits =3D BN_num_bits(order);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    BN_free(order);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return bits;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-/* SSLeay symbols have been re=
named in OpenSSL 1.1 */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define OPENSSL_VERSION SSLEAY_VERSION</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define OpenSSL_version SSLeay_version</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/** Return the min SSL protocol version currently enabled in=
 the context.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  If n=
o valid version &gt;=3D TLS1.0 is found, return 0. */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-SSL_CTX_get_min_proto_version(SSL_CTX *ctx)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    long sslopt =3D SSL_CTX_get_options(ctx=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!(sslopt &a=
mp; SSL_OP_NO_TLSv1))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return T=
LS1_VERSION;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!(sslopt &amp; SS=
L_OP_NO_TLSv1_1))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return TLS1_=
1_VERSION;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!(sslopt &amp; SSL_=
OP_NO_TLSv1_2))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return TLS1_2_=
VERSION;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**=
 Return the max SSL protocol version currently enabled in the context.</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *  If no valid version &g=
t;=3D TLS1.0 is found, return 0. */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-SSL_CTX_get_max_proto_version(SSL_CTX *ctx)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    long sslopt =3D SSL_CTX_get_options(ctx);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (!(sslopt &amp; SSL_OP_NO_TLSv1_=
2))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        return TLS1_2_VERSION;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (!(sslopt &amp; SSL_OP_NO_TLSv1_1)=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        return TLS1_1_VERSION;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!(sslopt &amp; SSL_OP_NO_TLSv1))</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return TLS1_VERSION;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Mimics SSL_CTX_set_=
min_proto_version for OpenSSL &lt; 1.1 */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-SSL_CTX_set_min_proto_version(SSL_CTX *ctx, long tls_ver_mi=
n)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    long sslopt =3D SSL_OP_NO_SSLv2 | S=
SL_OP_NO_SSLv3; /* Never do &lt; TLS 1.0 */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (tls_ver_min &gt; TLS1_VERSION)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        sslopt |=3D SSL_OP_NO_TLSv1;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#ifdef SSL_OP_NO_TLSv1_1</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (tls_ver_min &gt; TLS1_1_VERSION)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        sslopt |=3D SSL_OP_NO_TLSv1_1;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef =
SSL_OP_NO_TLSv1_2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (tls_ver_min &gt; TLS1_2_VERSION)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       sslopt |=3D SSL_OP_NO_TLSv1_2;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SSL_CTX_set=
_options(ctx, sslopt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 1;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-/** Mimics SSL_CTX_set_max_proto_version for OpenSSL &lt; 1.1 */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-SSL_CTX_set_max_proto_version(=
SSL_CTX *ctx, long tls_ver_max)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    long s=
slopt =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (tls_ver_max &lt; TLS1_=
VERSION)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        sslopt |=3D SSL_OP_NO=
_TLSv1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef SSL_OP_NO_TLSv1_1</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tls_ver_max &lt; TL=
S1_1_VERSION)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        sslopt |=3D SSL_=
OP_NO_TLSv1_1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#ifdef SSL_OP_NO_TLSv1_2</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (tls_ver_max &lt; TLS1_2_VER=
SION)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        sslopt |=3D SSL_OP_NO_TL=
Sv1_2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    SSL_CTX_set_options(ctx, sslopt);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return 1;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if /* if OPENSSL_VERSION_NUMBER &lt; 0x10100000L &amp;&amp; !defined(ENABLE=
_CRYPTO_WOLFSSL) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> /* Functionality missing in 1.1.1 */</span><br><span> #if O=
PENSSL_VERSION_NUMBER &lt; 0x30000000L &amp;&amp; !defined(OPENSSL_NO_EC)</=
span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_openssl.c b/s=
rc/openvpn/ssl_openssl.c</span><br><span>index a158617..e13fe11 100644</spa=
n><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openv=
pn/ssl_openssl.c</span><br><span>@@ -84,13 +84,6 @@</span><br><span> void</=
span><br><span> tls_init_lib(void)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt; 0x10100000L=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SSL_library_init(=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMAL=
L</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SSL_load_error_s=
trings();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    OpenSSL_add_all_algorit=
hms();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span>     mydata_index =3D SSL_get_ex_new_index(0, &quot;struct session =
*&quot;, NULL, NULL, NULL);</span><br><span>     ASSERT(mydata_index &gt;=
=3D 0);</span><br><span> }</span><br><span>@@ -98,12 +91,6 @@</span><br><sp=
an> void</span><br><span> tls_free_lib(void)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt; 0=
x10100000L</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    EVP_cle=
anup();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE=
_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ERR_free_st=
rings();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> }</s=
pan><br><span> </span><br><span> void</span><br><span>@@ -744,15 +731,6 @@<=
/span><br><span>     }</span><br><span>     else</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBE=
R &lt; 0x10100000L</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* OpenSSL 1.0.2=
 and newer can automatically handle ECDH parameter</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-         * loading */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        SSL_CTX_set_ecdh_auto(ctx-&gt;ctx, 1);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        /* OpenSSL 1.1.0 and newer have al=
ways ecdh auto loading enabled,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-         * so do nothing */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span>         return;</span><br><span>   =
  }</span><br><span> </span><br><span>@@ -1348,7 +1326,7 @@</span><br><span=
>     return 0;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &gt; 0x10100000L=
 &amp;&amp; !defined(OPENSSL_NO_EC)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if !defined(OPENSSL_NO_EC)</span><br><span> </span><br><sp=
an> /* called when EC_KEY is destroyed */</span><br><span> static void</spa=
n><br><span>@@ -1469,7 +1447,7 @@</span><br><span>     EC_KEY_free(ec);</sp=
an><br><span>     return 0;</span><br><span> }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif /* OPENSSL_VERSION_NUMBER &gt; 1.1.0 dev &a=
mp;&amp; !defined(OPENSSL_NO_EC) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif /* !defined(OPENSSL_NO_EC) */</span><br><span> #endi=
f /* ENABLE_MANAGEMENT &amp;&amp; !HAVE_XKEY_PROVIDER */</span><br><span> <=
/span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>@@ -1509,7 +1487,=
7 @@</span><br><span>             goto cleanup;</span><br><span>         }<=
/span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#if (OPENSSL_VERSION_NUMBER &gt; 0x10100000L) &amp;&amp; !defined(OPENSSL_=
NO_EC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(=
OPENSSL_NO_EC)</span><br><span> #if OPENSSL_VERSION_NUMBER &lt; 0x30000000L=
</span><br><span>     else if (EVP_PKEY_id(pkey) =3D=3D EVP_PKEY_EC)</span>=
<br><span> #else /* OPENSSL_VERSION_NUMBER &lt; 0x30000000L */</span><br><s=
pan>@@ -1526,13 +1504,13 @@</span><br><span>         crypto_msg(M_WARN, &qu=
ot;management-external-key requires an RSA or EC certificate&quot;);</span>=
<br><span>         goto cleanup;</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#else  /* OPENSSL_VERSION_NUMBER &gt; 1.1=
.0 dev &amp;&amp; !defined(OPENSSL_NO_EC) */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#else  /* !defined(OPENSSL_NO_EC) */</span><br><sp=
an>     else</span><br><span>     {</span><br><span>         crypto_msg(M_W=
ARN, &quot;management-external-key requires an RSA certificate&quot;);</spa=
n><br><span>         goto cleanup;</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif /* OPENSSL_VERSION_NUMBER &gt; 1=
.1.0 dev &amp;&amp; !defined(OPENSSL_NO_EC) */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif /* !defined(OPENSSL_NO_EC) */</span><br><=
span> </span><br><span> #endif /* HAVE_XKEY_PROVIDER */</span><br><span> </=
span><br><span>@@ -2166,7 +2144,7 @@</span><br><span>     EVP_PKEY_free(pke=
y);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if (!defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; OPENSS=
L_VERSION_NUMBER &gt;=3D 0x1010000fL) \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if !defined(LIBRESSL_VERSION_NUMBER) \</span><br><span=
>     || (defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMB=
ER &gt;=3D 0x3090000fL)</span><br><span> /**</span><br><span>  * Translate =
an OpenSSL NID into a more human readable name</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/559=
?usp=3Demail">change 559</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/559?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I90875311a4e4c403e77e30b609c=
1878cbaaaad45 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 559 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--P7QMWgPQ9rA=--

