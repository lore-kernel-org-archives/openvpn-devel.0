From: Arne Schwabe <arne@...1227...>
Date: Thu,  1 Apr 2021 14:37:51 +0200
Message-Id: <20210401123751.31756-1-arne@...1227...>
In-Reply-To: <20210325000121.10331-2-arne@...1227...>
References: <20210325000121.10331-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2] Remove deprecated option '--keysize'
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

This option has been deprecated in OpenVPN 2.4 and the ciphers that allow
using this option fall all into the SWEET32 category of ciphers with
64 bit block size.

Patch V2: Remove superflous check in OpenSSL codepath to check keysize

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 config-msvc.h                |  1 -
 configure.ac                 |  2 +-
 src/openvpn/crypto.c         |  6 +-----
 src/openvpn/crypto.h         |  4 +---
 src/openvpn/crypto_openssl.c | 12 ++----------
 src/openvpn/init.c           |  5 ++---
 src/openvpn/options.c        | 33 ++-------------------------------
 src/openvpn/options.h        |  2 --
 src/openvpn/ssl.c            |  7 +------
 9 files changed, 10 insertions(+), 62 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index 4db9efae2..aea2628be 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -48,7 +48,6 @@
 #define HAVE_CHDIR 1
 #define HAVE_CHSIZE 1
 #define HAVE_CTIME 1
-#define HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH 1
 #define HAVE_IN_PKTINFO 1
 #define HAVE_MEMSET 1
 #define HAVE_PUTENV 1
diff --git a/configure.ac b/configure.ac
index 3cb9fc2fc..7bc6c7b90 100644
--- a/configure.ac
+++ b/configure.ac
@@ -878,7 +878,7 @@ if test "${with_crypto_library}" = "openssl"; then
 		)
 	fi
 
-	AC_CHECK_FUNCS([SSL_CTX_new EVP_CIPHER_CTX_set_key_length],
+	AC_CHECK_FUNCS([SSL_CTX_new],
 				   ,
 				   [AC_MSG_ERROR([openssl check failed])]
 	)
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 3a0bfbec4..b042514bf 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -739,7 +739,7 @@ warn_insecure_key_type(const char *ciphername, const cipher_kt_t *cipher)
  */
 void
 init_key_type(struct key_type *kt, const char *ciphername,
-              const char *authname, int keysize, bool tls_mode, bool warn)
+              const char *authname, bool tls_mode, bool warn)
 {
     bool aead_cipher = false;
 
@@ -756,10 +756,6 @@ init_key_type(struct key_type *kt, const char *ciphername,
         }
 
         kt->cipher_length = cipher_kt_key_size(kt->cipher);
-        if (keysize > 0 && keysize <= MAX_CIPHER_KEY_LENGTH)
-        {
-            kt->cipher_length = keysize;
-        }
 
         /* check legal cipher mode */
         aead_cipher = cipher_kt_mode_aead(kt->cipher);
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 1ad669ce1..b8128c7f1 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -301,14 +301,12 @@ int read_key(struct key *key, const struct key_type *kt, struct buffer *buf);
  * @param kt          The struct key_type to initialize
  * @param ciphername  The name of the cipher to use
  * @param authname    The name of the HMAC digest to use
- * @param keysize     The length of the cipher key to use, in bytes.  Only valid
- *                    for ciphers that support variable length keys.
  * @param tls_mode    Specifies whether we are running in TLS mode, which allows
  *                    more ciphers than static key mode.
  * @param warn        Print warnings when null cipher / auth is used.
  */
 void init_key_type(struct key_type *kt, const char *ciphername,
-                   const char *authname, int keysize, bool tls_mode, bool warn);
+                   const char *authname, bool tls_mode, bool warn);
 
 /*
  * Key context functions
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 573beaed7..f3e86863e 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -292,10 +292,8 @@ show_available_ciphers(void)
 #ifndef ENABLE_SMALL
     printf("The following ciphers and cipher modes are available for use\n"
            "with " PACKAGE_NAME ".  Each cipher shown below may be used as a\n"
-           "parameter to the --data-ciphers (or --cipher) option.  The\n"
-           "default key size is shown as well as whether or not it can be\n"
-           "changed with the --keysize directive.  Using a GCM or CBC mode\n"
-           "is recommended.  In static key mode only CBC mode is allowed.\n\n");
+           "parameter to the --data-ciphers (or --cipher) option. In static \n"
+           "key mode only CBC mode is allowed.\n\n");
 #endif
 
     for (nid = 0; nid < 10000; ++nid)
@@ -776,12 +774,6 @@ cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key, int key_len,
     {
         crypto_msg(M_FATAL, "EVP cipher init #1");
     }
-#ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
-    if (!EVP_CIPHER_CTX_set_key_length(ctx, key_len))
-    {
-        crypto_msg(M_FATAL, "EVP set key size");
-    }
-#endif
     if (!EVP_CipherInit_ex(ctx, NULL, NULL, key, NULL, enc))
     {
         crypto_msg(M_FATAL, "EVP cipher init #2");
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 132d47e4e..336da9414 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2599,7 +2599,7 @@ do_init_crypto_static(struct context *c, const unsigned int flags)
     {
         /* Get cipher & hash algorithms */
         init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname,
-                      options->keysize, options->test_crypto, true);
+                      options->test_crypto, true);
 
         /* Read cipher and hmac keys from shared secret file */
         crypto_read_openvpn_key(&c->c1.ks.key_type, &c->c1.ks.static_key,
@@ -2751,7 +2751,7 @@ do_init_crypto_tls_c1(struct context *c)
              || options->enable_ncp_fallback;
         /* Get cipher & hash algorithms */
         init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname,
-                      options->keysize, true, warn);
+                      true, warn);
 
         /* Initialize PRNG with config-specified digest */
         prng_init(options->prng_hash, options->prng_nonce_secret_len);
@@ -4515,7 +4515,6 @@ inherit_context_child(struct context *dest,
     /* inherit pre-NCP ciphers */
     dest->options.ciphername = src->options.ciphername;
     dest->options.authname = src->options.authname;
-    dest->options.keysize = src->options.keysize;
 
     /* inherit auth-token */
     dest->c1.ks.auth_token_key = src->c1.ks.auth_token_key;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 142da0618..6c9cd9c3a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -531,10 +531,6 @@ static const char usage_message[] =
     "--ncp-disable   : (DEPRECATED) Disable cipher negotiation.\n"
     "--prng alg [nsl] : For PRNG, use digest algorithm alg, and\n"
     "                   nonce_secret_len=nsl.  Set alg=none to disable PRNG.\n"
-#ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
-    "--keysize n     : (DEPRECATED) Size of cipher key in bits (optional).\n"
-    "                  If unspecified, defaults to cipher-specific default.\n"
-#endif
 #ifndef ENABLE_CRYPTO_MBEDTLS
     "--engine [name] : Enable OpenSSL hardware crypto engine functionality.\n"
 #endif
@@ -1733,7 +1729,6 @@ show_settings(const struct options *o)
     SHOW_STR(authname);
     SHOW_STR(prng_hash);
     SHOW_INT(prng_nonce_secret_len);
-    SHOW_INT(keysize);
 #ifndef ENABLE_CRYPTO_MBEDTLS
     SHOW_BOOL(engine);
 #endif /* ENABLE_CRYPTO_MBEDTLS */
@@ -2540,11 +2535,6 @@ options_postprocess_verify_ce(const struct options *options,
         }
     }
 
-    if (options->keysize)
-    {
-        msg(M_WARN, "WARNING: --keysize is DEPRECATED and will be removed in OpenVPN 2.6");
-    }
-
     /*
      * Check consistency of replay options
      */
@@ -3619,7 +3609,6 @@ pre_pull_save(struct options *o)
         /* NCP related options that can be overwritten by a push */
         o->pre_pull->ciphername = o->ciphername;
         o->pre_pull->authname = o->authname;
-        o->pre_pull->keysize = o->keysize;
 
         /* Ping related options should be reset to the config values on reconnect */
         o->pre_pull->ping_rec_timeout = o->ping_rec_timeout;
@@ -3675,7 +3664,6 @@ pre_pull_restore(struct options *o, struct gc_arena *gc)
 
         o->ciphername = pp->ciphername;
         o->authname = pp->authname;
-        o->keysize = pp->keysize;
 
         o->ping_rec_timeout = pp->ping_rec_timeout;
         o->ping_rec_timeout_action = pp->ping_rec_timeout_action;
@@ -3704,8 +3692,7 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
     {
         struct frame fake_frame = *frame;
         struct key_type fake_kt;
-        init_key_type(&fake_kt, o->ciphername, o->authname, o->keysize, true,
-                      false);
+        init_key_type(&fake_kt, o->ciphername, o->authname, true, false);
         frame_remove_from_extra_frame(&fake_frame, crypto_max_overhead());
         crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->replay,
                                        cipher_kt_mode_ofb_cfb(fake_kt.cipher));
@@ -3876,8 +3863,7 @@ options_string(const struct options *o,
                + (TLS_SERVER == true)
                <= 1);
 
-        init_key_type(&kt, o->ciphername, o->authname, o->keysize, true,
-                      false);
+        init_key_type(&kt, o->ciphername, o->authname, true, false);
         /* Only announce the cipher to our peer if we are willing to
          * support it */
         const char *ciphername = cipher_kt_name(kt.cipher);
@@ -8087,21 +8073,6 @@ add_option(struct options *options,
         }
     }
 #endif /* ENABLE_CRYPTO_MBEDTLS */
-#ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
-    else if (streq(p[0], "keysize") && p[1] && !p[2])
-    {
-        int keysize;
-
-        VERIFY_PERMISSION(OPT_P_NCP);
-        keysize = atoi(p[1]) / 8;
-        if (keysize < 0 || keysize > MAX_CIPHER_KEY_LENGTH)
-        {
-            msg(msglevel, "Bad keysize: %s", p[1]);
-            goto err;
-        }
-        options->keysize = keysize;
-    }
-#endif
 #ifdef ENABLE_PREDICTION_RESISTANCE
     else if (streq(p[0], "use-prediction-resistance") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d8e91fbc3..5e924e1b3 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -77,7 +77,6 @@ struct options_pre_pull
 
     const char* ciphername;
     const char* authname;
-    int keysize;
 
     int ping_send_timeout;
     int ping_rec_timeout;
@@ -521,7 +520,6 @@ struct options
     bool ncp_enabled;
     const char *ncp_ciphers;
     const char *authname;
-    int keysize;
     const char *prng_hash;
     int prng_nonce_secret_len;
     const char *engine;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 23b55f3bd..b58207a56 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1872,11 +1872,6 @@ tls_session_update_crypto_params(struct tls_session *session,
     {
         msg(D_HANDSHAKE, "Data Channel: using negotiated cipher '%s'",
             options->ciphername);
-        if (options->keysize)
-        {
-            msg(D_HANDSHAKE, "NCP: overriding user-set keysize with default");
-            options->keysize = 0;
-        }
     }
     else
     {
@@ -1887,7 +1882,7 @@ tls_session_update_crypto_params(struct tls_session *session,
     }
 
     init_key_type(&session->opt->key_type, options->ciphername,
-                  options->authname, options->keysize, true, true);
+                  options->authname, true, true);
 
     bool packet_id_long_form = cipher_kt_mode_ofb_cfb(session->opt->key_type.cipher);
     session->opt->crypto_flags &= ~(CO_PACKET_ID_LONG_FORM);
-- 
2.30.1


