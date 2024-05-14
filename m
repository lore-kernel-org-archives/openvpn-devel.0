From: Gert Doering <gert@...1296...>
Date: Tue, 14 May 2024 16:15:50 +0200
Message-ID: <20240514141550.17544-1-gert@...1296...>
In-Reply-To: <gerrit.1714407751000.I90875311a4e4c403e77e30b609c1878cbaaaad45@...2715...>
References: <gerrit.1714407751000.I90875311a4e4c403e77e30b609c1878cbaaaad45@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] Remove OpenSSL 1.0.2 support
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

From: Arne Schwabe <arne@...1227...>

With Centos 7/Red Hat Enterprise Linux 7 being EOL this June, the last
distributions that still support OpenSSL 1.0.2 are finally EOL. This
means we no longer need to support OpenSSL 1.0.2

Change-Id: I90875311a4e4c403e77e30b609c1878cbaaaad45
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/559
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/Changes.rst b/Changes.rst
index fa0fb22..4bc3bb3 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -33,6 +33,10 @@
     ``--topology net30`` to the config should fix the problem.
     By default ``--topology`` is pushed from server to client.
 
+OpenSSL 1.0.2 support
+    Support for building with OpenSSL 1.0.2 has been removed. The minimum
+    supported OpenSSL version is now 1.1.0.
+
 Overview of changes in 2.6
 ==========================
 
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
   (2b) mbed TLS library, an alternative for encryption, version 2.0 or higher
diff --git a/configure.ac b/configure.ac
index ce8b2b0..965ed1a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -888,7 +888,7 @@
 		# if the user did not explicitly specify flags, try to autodetect
 		PKG_CHECK_MODULES(
 			[OPENSSL],
-			[openssl >= 1.0.2],
+			[openssl >= 1.1.0],
 			[have_openssl="yes"],
 			[AC_MSG_WARN([OpenSSL not found by pkg-config ${pkg_config_found}])] # If this fails, we will do another test next
 		)
@@ -903,7 +903,7 @@
 	# If pkgconfig check failed or OPENSSL_CFLAGS/OPENSSL_LIBS env vars
 	# are used, check the version directly in the OpenSSL include file
 	if test "${have_openssl}" != "yes"; then
-		AC_MSG_CHECKING([additionally if OpenSSL is available and version >= 1.0.2])
+		AC_MSG_CHECKING([additionally if OpenSSL is available and version >= 1.1.0])
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
 
-	# All supported OpenSSL version (>= 1.0.2)
+	# All supported OpenSSL version (>= 1.1.0)
 	# have this feature
 	have_export_keying_material="yes"
 
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 1649ab7..0473fad 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -49,7 +49,7 @@
 #include <openssl/rand.h>
 #include <openssl/ssl.h>
 
-#if (OPENSSL_VERSION_NUMBER >= 0x10100000L) && !defined(LIBRESSL_VERSION_NUMBER)
+#if !defined(LIBRESSL_VERSION_NUMBER)
 #include <openssl/kdf.h>
 #endif
 #if OPENSSL_VERSION_NUMBER >= 0x30000000L
@@ -193,11 +193,7 @@
 void
 crypto_init_lib(void)
 {
-#if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
     OPENSSL_init_crypto(OPENSSL_INIT_LOAD_CONFIG, NULL);
-#else
-    OPENSSL_config(NULL);
-#endif
     /*
      * If you build the OpenSSL library and OpenVPN with
      * CRYPTO_MDEBUG, you will get a listing of OpenSSL
@@ -1401,7 +1397,7 @@
 
     return ret;
 }
-#elif (OPENSSL_VERSION_NUMBER >= 0x10100000L) && !defined(LIBRESSL_VERSION_NUMBER)
+#elif !defined(LIBRESSL_VERSION_NUMBER)
 bool
 ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
              int secret_len, uint8_t *output, int output_len)
@@ -1447,7 +1443,7 @@
     EVP_PKEY_CTX_free(pctx);
     return ret;
 }
-#else  /* if OPENSSL_VERSION_NUMBER >= 0x10100000L */
+#else  /* if defined(LIBRESSL_VERSION_NUMBER) */
 /*
  * Generate the hash required by for the \c tls1_PRF function.
  *
@@ -1626,5 +1622,5 @@
     gc_free(&gc);
     return ret;
 }
-#endif /* if OPENSSL_VERSION_NUMBER >= 0x10100000L */
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
-#if (OPENSSL_VERSION_NUMBER < 0x10100000L || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x3050000fL)) && !defined(ENABLE_CRYPTO_WOLFSSL)
+/* Functionality missing in LibreSSL before 3.5 */
+#if defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x3050000fL
 /**
  * Destroy a X509 object
  *
@@ -71,659 +71,14 @@
 #define EVP_CTRL_AEAD_GET_TAG                EVP_CTRL_GCM_GET_TAG
 #endif
 
-#if (OPENSSL_VERSION_NUMBER < 0x10100000L || defined(LIBRESSL_VERSION_NUMBER)) && !defined(ENABLE_CRYPTO_WOLFSSL)
+#if defined(LIBRESSL_VERSION_NUMBER)
 #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
 #endif
 
-#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(ENABLE_CRYPTO_WOLFSSL)) || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x3050400fL)
+#if defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x3050400fL
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
-    EVP_MD_CTX *ctx = NULL;
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
-    HMAC_CTX *ctx = NULL;
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
-    return (pkey && pkey->type == EVP_PKEY_RSA) ? pkey->pkey.rsa : NULL;
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
-    return (pkey && pkey->type == EVP_PKEY_EC) ? pkey->pkey.ec : NULL;
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
-    return (pkey && pkey->type == EVP_PKEY_DSA) ? pkey->pkey.dsa : NULL;
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
-        rsa->flags = flags;
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
-    if (n != NULL)
-    {
-        *n = rsa ? rsa->n : NULL;
-    }
-    if (e != NULL)
-    {
-        *e = rsa ? rsa->e : NULL;
-    }
-    if (d != NULL)
-    {
-        *d = rsa ? rsa->d : NULL;
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
-    if ((rsa->n == NULL && n == NULL)
-        || (rsa->e == NULL && e == NULL))
-    {
-        return 0;
-    }
-
-    if (n != NULL)
-    {
-        BN_free(rsa->n);
-        rsa->n = n;
-    }
-    if (e != NULL)
-    {
-        BN_free(rsa->e);
-        rsa->e = e;
-    }
-    if (d != NULL)
-    {
-        BN_free(rsa->d);
-        rsa->d = d;
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
-    const BIGNUM *n = NULL;
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
-    if (p != NULL)
-    {
-        *p = dsa ? dsa->p : NULL;
-    }
-    if (q != NULL)
-    {
-        *q = dsa ? dsa->q : NULL;
-    }
-    if (g != NULL)
-    {
-        *g = dsa ? dsa->g : NULL;
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
-    const BIGNUM *p = NULL;
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
-    RSA_METHOD *rsa_meth = NULL;
-    ALLOC_OBJ_CLEAR(rsa_meth, RSA_METHOD);
-    rsa_meth->name = string_alloc(name, NULL);
-    rsa_meth->flags = flags;
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
-         * qualifiers" warning, we force the pointer to be a non-const value.
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
-        meth->rsa_pub_enc = pub_enc;
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
-        meth->rsa_pub_dec = pub_dec;
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
-        meth->rsa_priv_enc = priv_enc;
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
-        meth->rsa_priv_dec = priv_dec;
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
-        meth->init = init;
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
-    meth->rsa_sign = sign;
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
-        meth->finish = finish;
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
-        meth->app_data = app_data;
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
-    BIGNUM *order = BN_new();
-    EC_GROUP_get_order(group, order, NULL);
-    int bits = BN_num_bits(order);
-    BN_free(order);
-    return bits;
-}
-
-/* SSLeay symbols have been renamed in OpenSSL 1.1 */
-#define OPENSSL_VERSION SSLEAY_VERSION
-#define OpenSSL_version SSLeay_version
-
-/** Return the min SSL protocol version currently enabled in the context.
- *  If no valid version >= TLS1.0 is found, return 0. */
-static inline int
-SSL_CTX_get_min_proto_version(SSL_CTX *ctx)
-{
-    long sslopt = SSL_CTX_get_options(ctx);
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
- *  If no valid version >= TLS1.0 is found, return 0. */
-static inline int
-SSL_CTX_get_max_proto_version(SSL_CTX *ctx)
-{
-    long sslopt = SSL_CTX_get_options(ctx);
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
-    long sslopt = SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3; /* Never do < TLS 1.0 */
-
-    if (tls_ver_min > TLS1_VERSION)
-    {
-        sslopt |= SSL_OP_NO_TLSv1;
-    }
-#ifdef SSL_OP_NO_TLSv1_1
-    if (tls_ver_min > TLS1_1_VERSION)
-    {
-        sslopt |= SSL_OP_NO_TLSv1_1;
-    }
-#endif
-#ifdef SSL_OP_NO_TLSv1_2
-    if (tls_ver_min > TLS1_2_VERSION)
-    {
-        sslopt |= SSL_OP_NO_TLSv1_2;
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
-    long sslopt = 0;
-
-    if (tls_ver_max < TLS1_VERSION)
-    {
-        sslopt |= SSL_OP_NO_TLSv1;
-    }
-#ifdef SSL_OP_NO_TLSv1_1
-    if (tls_ver_max < TLS1_1_VERSION)
-    {
-        sslopt |= SSL_OP_NO_TLSv1_1;
-    }
-#endif
-#ifdef SSL_OP_NO_TLSv1_2
-    if (tls_ver_max < TLS1_2_VERSION)
-    {
-        sslopt |= SSL_OP_NO_TLSv1_2;
-    }
-#endif
-    SSL_CTX_set_options(ctx, sslopt);
-
-    return 1;
-}
-#endif /* if OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(ENABLE_CRYPTO_WOLFSSL) */
-
 /* Functionality missing in 1.1.1 */
 #if OPENSSL_VERSION_NUMBER < 0x30000000L && !defined(OPENSSL_NO_EC)
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 6efef4f..7e74f2f 100644
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
     mydata_index = SSL_get_ex_new_index(0, "struct session *", NULL, NULL, NULL);
     ASSERT(mydata_index >= 0);
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
-#if OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER)
+#if OPENSSL_VERSION_NUMBER > 0x10100000L \
+    && (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER >  0x3060000fL)
     /* OpenSSL does not have certificate profiles, but a complex set of
      * callbacks that we could try to implement to achieve something similar.
      * For now, use OpenSSL's security levels to achieve similar (but not equal)
@@ -555,7 +543,7 @@
 #else  /* if OPENSSL_VERSION_NUMBER > 0x10100000L */
     if (profile)
     {
-        msg(M_WARN, "WARNING: OpenSSL 1.0.2 and LibreSSL do not support "
+        msg(M_WARN, "WARNING: OpenSSL 1.1.0 and LibreSSL do not support "
             "--tls-cert-profile, ignoring user-set profile: '%s'", profile);
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
     else if (EVP_PKEY_id(pkey) == EVP_PKEY_EC)
 #else /* OPENSSL_VERSION_NUMBER < 0x30000000L */
@@ -1526,13 +1505,13 @@
         crypto_msg(M_WARN, "management-external-key requires an RSA or EC certificate");
         goto cleanup;
     }
-#else  /* OPENSSL_VERSION_NUMBER > 1.1.0 dev && !defined(OPENSSL_NO_EC) */
+#else  /* !defined(OPENSSL_NO_EC) */
     else
     {
         crypto_msg(M_WARN, "management-external-key requires an RSA certificate");
         goto cleanup;
     }
-#endif /* OPENSSL_VERSION_NUMBER > 1.1.0 dev && !defined(OPENSSL_NO_EC) */
+#endif /* !defined(OPENSSL_NO_EC) */
 
 #endif /* HAVE_XKEY_PROVIDER */
 
@@ -2166,7 +2145,7 @@
     EVP_PKEY_free(pkey);
 }
 
-#if (!defined(LIBRESSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >= 0x1010000fL) \
+#if !defined(LIBRESSL_VERSION_NUMBER) \
     || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER >= 0x3090000fL)
 /**
  * Translate an OpenSSL NID into a more human readable name
@@ -2222,7 +2201,7 @@
     }
 #endif
 
-#if (!defined(LIBRESSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >= 0x1010000fL) \
+#if !defined(LIBRESSL_VERSION_NUMBER) \
     || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER >= 0x3090000fL)
     /* LibreSSL 3.7.x and 3.8.x implement this function but do not export it
      * and fail linking with an unresolved symbol */

