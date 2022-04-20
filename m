From: David Sommerseth <openvpn@...2080...>
Date: Wed, 20 Apr 2022 16:30:50 +0200
Message-Id: <20220420143050.52790-1-openvpn@...2080...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] The Great Reformatting of 2022
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
Cc: David Sommerseth <davids@...515...>

From: David Sommerseth <davids@...515...>

It was agreed it was time to do a full reformat fix-up of the whole
source tree again.  Over time (since late 2016) small changes has not
adhered to our uncrustify defined coding style.  This realigns to our
current standards.

Signed-off-by: David Sommerseth <davids@...515...>

---
Note: One change was applied manually before reformatting the code.
      The test_digest and good_sig const arrays had the starting
      curly brace moved up after the equal sign. This was to avoid the
      whole array data to be left aligned at column 0. Moving the curly
      brace opening after the equal sign gave a nicer indenting of the
      block.
---
 sample/sample-plugins/defer/multi-auth.c      |  23 ++--
 .../keyingmaterialexporter.c                  |   2 +-
 src/compat/compat-versionhelpers.h            |   2 +-
 src/openvpn/auth_token.c                      |   2 +-
 src/openvpn/console_builtin.c                 |   2 +-
 src/openvpn/crypto_backend.h                  |   9 +-
 src/openvpn/crypto_mbedtls.c                  |  23 ++--
 src/openvpn/crypto_openssl.c                  |  48 +++++----
 src/openvpn/cryptoapi.c                       |  16 +--
 src/openvpn/dns.h                             |   2 +-
 src/openvpn/error.c                           |   3 +-
 src/openvpn/forward.c                         |   3 +-
 src/openvpn/init.c                            |  56 +++++-----
 src/openvpn/init.h                            |   1 +
 src/openvpn/manage.c                          |   2 +-
 src/openvpn/misc.h                            |   4 +-
 src/openvpn/mss.c                             |  12 +--
 src/openvpn/mss.h                             |   2 +-
 src/openvpn/mtu.c                             |   2 +-
 src/openvpn/multi.c                           |   7 +-
 src/openvpn/networking_sitnl.c                |   2 +
 src/openvpn/openssl_compat.h                  |  15 +--
 src/openvpn/openvpn.c                         |  14 +--
 src/openvpn/options.c                         |  74 ++++++-------
 src/openvpn/options.h                         |   8 +-
 src/openvpn/pkcs11_openssl.c                  |  32 +++---
 src/openvpn/platform.c                        |   8 +-
 src/openvpn/push.c                            |  12 ++-
 src/openvpn/ring_buffer.h                     |   2 +-
 src/openvpn/route.c                           |   4 +-
 src/openvpn/run_command.h                     |   2 +-
 src/openvpn/socket.h                          |   8 +-
 src/openvpn/socks.c                           |   2 +-
 src/openvpn/ssl.c                             |  34 +++---
 src/openvpn/ssl_backend.h                     |   2 +-
 src/openvpn/ssl_common.h                      |  25 +++--
 src/openvpn/ssl_mbedtls.c                     |  21 ++--
 src/openvpn/ssl_mbedtls.h                     |   2 +-
 src/openvpn/ssl_ncp.c                         |  32 +++---
 src/openvpn/ssl_openssl.c                     |  26 ++---
 src/openvpn/ssl_verify.c                      |  46 ++++----
 src/openvpn/ssl_verify_openssl.c              |   2 +-
 src/openvpn/syshead.h                         |   4 +-
 src/openvpn/tun.c                             |  38 +++----
 src/openvpn/xkey_common.h                     |  14 +--
 src/openvpn/xkey_helper.c                     |  26 ++---
 src/openvpn/xkey_provider.c                   |  98 ++++++++---------
 src/openvpnmsica/openvpnmsica.h               |   8 +-
 src/openvpnserv/common.c                      |   6 +-
 src/openvpnserv/interactive.c                 | 101 +++++++++---------
 src/openvpnserv/service.c                     |   8 +-
 src/plugins/auth-pam/auth-pam.c               |  22 ++--
 src/tapctl/main.c                             |   3 +-
 src/tapctl/tap.c                              |  30 +++---
 tests/unit_tests/openvpn/test_crypto.c        |  10 +-
 tests/unit_tests/openvpn/test_misc.c          |   6 +-
 tests/unit_tests/openvpn/test_ncp.c           |   2 +-
 tests/unit_tests/openvpn/test_provider.c      |  60 ++++++-----
 tests/unit_tests/openvpn/test_tls_crypt.c     |   2 +-
 .../auth-pam/test_search_and_replace.c        |  21 ++--
 60 files changed, 549 insertions(+), 504 deletions(-)

diff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sample-plugins/defer/multi-auth.c
index 20c9dac5..c2672981 100644
--- a/sample/sample-plugins/defer/multi-auth.c
+++ b/sample/sample-plugins/defer/multi-auth.c
@@ -72,7 +72,8 @@ struct plugin_context {
 
 /* local wrapping of the log function, to add more details */
 static plugin_vlog_t _plugin_vlog_func = NULL;
-static void plog(const struct plugin_context *ctx, int flags, char *fmt, ...)
+static void
+plog(const struct plugin_context *ctx, int flags, char *fmt, ...)
 {
     char logid[129];
 
@@ -243,11 +244,11 @@ do_auth_user_pass(struct plugin_context *context,
                   const char *username, const char *password)
 {
     plog(context, PLOG_NOTE,
-        "expect_user=%s, received_user=%s, expect_passw=%s, received_passw=%s",
-        np(context->test_valid_user),
-        np(username),
-        np(context->test_valid_pass),
-        np(password));
+         "expect_user=%s, received_user=%s, expect_passw=%s, received_passw=%s",
+         np(context->test_valid_user),
+         np(username),
+         np(context->test_valid_pass),
+         np(password));
 
     if (context->test_valid_user && context->test_valid_pass)
     {
@@ -255,13 +256,13 @@ do_auth_user_pass(struct plugin_context *context,
             || (strcmp(context->test_valid_pass, password) != 0))
         {
             plog(context, PLOG_ERR,
-                "User/Password auth result: FAIL");
+                 "User/Password auth result: FAIL");
             return false;
         }
         else
         {
             plog(context, PLOG_NOTE,
-                "User/Password auth result: PASS");
+                 "User/Password auth result: PASS");
             return true;
         }
     }
@@ -282,7 +283,7 @@ auth_user_pass_verify(struct plugin_context *context,
     {
         plog(context, PLOG_NOTE, "Direct authentication");
         return do_auth_user_pass(context, username, password) ?
-                OPENVPN_PLUGIN_FUNC_SUCCESS : OPENVPN_PLUGIN_FUNC_ERROR;
+               OPENVPN_PLUGIN_FUNC_SUCCESS : OPENVPN_PLUGIN_FUNC_ERROR;
     }
 
     /* get auth_control_file filename from envp string array*/
@@ -334,7 +335,7 @@ auth_user_pass_verify(struct plugin_context *context,
 
     /* do mighty complicated work that will really take time here... */
     plog(context, PLOG_NOTE, "in async/deferred handler, usleep(%d)",
-        context->test_deferred_auth*1000);
+         context->test_deferred_auth*1000);
     usleep(context->test_deferred_auth*1000);
 
     /* now signal success state to openvpn */
@@ -342,7 +343,7 @@ auth_user_pass_verify(struct plugin_context *context,
     if (fd < 0)
     {
         plog(context, PLOG_ERR|PLOG_ERRNO,
-            "open('%s') failed", auth_control_file);
+             "open('%s') failed", auth_control_file);
         exit(1);
     }
 
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index e2820418..16648a3e 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -55,7 +55,7 @@ struct plugin {
 
 struct session {
     char user[48];
-    char key [48];
+    char key[48];
 };
 
 /*
diff --git a/src/compat/compat-versionhelpers.h b/src/compat/compat-versionhelpers.h
index 9e25470e..27d65559 100644
--- a/src/compat/compat-versionhelpers.h
+++ b/src/compat/compat-versionhelpers.h
@@ -19,7 +19,7 @@
 #define _WIN32_WINNT_WINBLUE    0x0603
 
 #ifndef _WIN32_WINNT_WINTHRESHOLD
-#define _WIN32_WINNT_WINTHRESHOLD    0x0A00 // Windows 10
+#define _WIN32_WINNT_WINTHRESHOLD    0x0A00 /* Windows 10 */
 #endif
 
 VERSIONHELPERAPI
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 9a85655f..096edc75 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -387,7 +387,7 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
                                 strlen(SESSION_ID_PREFIX) + AUTH_TOKEN_SESSION_ID_BASE64_LEN))
     {
         msg(M_WARN, "--auth-gen-token: session id in token changed (Rejecting "
-                    "token.");
+            "token.");
         ret = 0;
     }
     return ret;
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 0c5023d9..3b97aad9 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -69,7 +69,7 @@ get_console_input_win32(const char *prompt, const bool echo, char *input, const
     input[0] = '\0';
 
     HANDLE in = GetStdHandle(STD_INPUT_HANDLE);
-    int orig_stderr = get_orig_stderr(); // guaranteed to be always valid
+    int orig_stderr = get_orig_stderr(); /* guaranteed to be always valid */
     if ((in == INVALID_HANDLE_VALUE)
         || win32_service_interrupt(&win32_signal)
         || (_write(orig_stderr, prompt, strlen(prompt)) == -1))
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 6d89b9e5..8b489938 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -211,7 +211,8 @@ bool cipher_valid_reason(const char *ciphername, const char **reason);
  *
  * @return              if the cipher is valid
  */
-static inline bool cipher_valid(const char *ciphername)
+static inline bool
+cipher_valid(const char *ciphername)
 {
     const char *reason;
     return cipher_valid_reason(ciphername, &reason);
@@ -224,7 +225,8 @@ static inline bool cipher_valid(const char *ciphername)
  *                      be NULL
  * @return              The cipher is defined and not the null (none) cipher
  */
-static inline bool cipher_defined(const char *ciphername)
+static inline bool
+cipher_defined(const char *ciphername)
 {
     ASSERT(ciphername);
     return strcmp(ciphername, "none") != 0;
@@ -509,7 +511,8 @@ int cipher_ctx_final_check_tag(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len,
  * @param mdname    Name of the digest
  * @return
  */
-static inline bool md_defined(const char* mdname)
+static inline bool
+md_defined(const char *mdname)
 {
     return strcmp(mdname, "none") != 0;
 }
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index a771777e..10c21edb 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -69,7 +69,8 @@ crypto_init_lib_engine(const char *engine_name)
         "available");
 }
 
-provider_t *crypto_load_provider(const char *provider)
+provider_t *
+crypto_load_provider(const char *provider)
 {
     if (provider)
     {
@@ -78,7 +79,8 @@ provider_t *crypto_load_provider(const char *provider)
     return NULL;
 }
 
-void crypto_unload_provider(const char *provname, provider_t *provider)
+void
+crypto_unload_provider(const char *provname, provider_t *provider)
 {
 }
 
@@ -391,7 +393,7 @@ rand_bytes(uint8_t *output, int len)
  *
  */
 static const mbedtls_cipher_info_t *
-cipher_get(const char* ciphername)
+cipher_get(const char *ciphername)
 {
     ASSERT(ciphername);
 
@@ -620,25 +622,28 @@ cipher_ctx_mode(const mbedtls_cipher_context_t *ctx)
     return cipher_kt_mode(ctx->cipher_info);
 }
 
-bool cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)
+bool
+cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)
 {
     return ctx && cipher_ctx_mode(ctx) == OPENVPN_MODE_CBC;
 }
 
 
-bool cipher_ctx_mode_ofb_cfb(const cipher_ctx_t *ctx)
+bool
+cipher_ctx_mode_ofb_cfb(const cipher_ctx_t *ctx)
 {
     return ctx && (cipher_ctx_mode(ctx) == OPENVPN_MODE_OFB
-        || cipher_ctx_mode(ctx) == OPENVPN_MODE_CFB);
+                   || cipher_ctx_mode(ctx) == OPENVPN_MODE_CFB);
 }
 
-bool cipher_ctx_mode_aead(const cipher_ctx_t *ctx)
+bool
+cipher_ctx_mode_aead(const cipher_ctx_t *ctx)
 {
     return ctx && (cipher_ctx_mode(ctx) == OPENVPN_MODE_GCM
 #ifdef MBEDTLS_CHACHAPOLY_C
-        || cipher_ctx_mode(ctx) == MBEDTLS_MODE_CHACHAPOLY
+                   || cipher_ctx_mode(ctx) == MBEDTLS_MODE_CHACHAPOLY
 #endif
-    );
+                   );
 }
 
 int
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index e553ee6d..3bedc03f 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -174,7 +174,8 @@ crypto_load_provider(const char *provider)
 #endif
 }
 
-void crypto_unload_provider(const char *provname, provider_t *provider)
+void
+crypto_unload_provider(const char *provname, provider_t *provider)
 {
 #if OPENSSL_VERSION_NUMBER >= 0x30000000L
     if (!OSSL_PROVIDER_unload(provider))
@@ -325,13 +326,14 @@ struct collect_ciphers {
     size_t num;
 };
 
-static void collect_ciphers(EVP_CIPHER *cipher, void *list)
+static void
+collect_ciphers(EVP_CIPHER *cipher, void *list)
 {
     if (!cipher)
     {
         return;
     }
-    struct collect_ciphers* cipher_list = list;
+    struct collect_ciphers *cipher_list = list;
     if (cipher_list->num == SIZE(cipher_list->list))
     {
         msg(M_WARN, "WARNING: Too many ciphers, not showing all");
@@ -342,10 +344,10 @@ static void collect_ciphers(EVP_CIPHER *cipher, void *list)
 
     if (ciphername && (cipher_kt_mode_cbc(ciphername)
 #ifdef ENABLE_OFB_CFB_MODE
-        || cipher_kt_mode_ofb_cfb(ciphername)
+                       || cipher_kt_mode_ofb_cfb(ciphername)
 #endif
-        || cipher_kt_mode_aead(ciphername)
-    ))
+                       || cipher_kt_mode_aead(ciphername)
+                       ))
     {
         cipher_list->list[cipher_list->num++] = cipher;
     }
@@ -400,7 +402,7 @@ show_available_ciphers(void)
 }
 
 void
-print_digest(EVP_MD* digest, void* unused)
+print_digest(EVP_MD *digest, void *unused)
 {
     printf("%s %d bit digest size\n", EVP_MD_get0_name(digest),
            EVP_MD_size(digest) * 8);
@@ -595,7 +597,7 @@ cipher_valid_reason(const char *ciphername, const char **reason)
     if (FIPS_mode() && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_FIPS))
     {
         msg(D_LOW, "Cipher algorithm '%s' is known by OpenSSL library but "
-                    "currently disabled by running in FIPS mode.", ciphername);
+            "currently disabled by running in FIPS mode.", ciphername);
         *reason = "disabled by FIPS mode";
         goto out;
     }
@@ -753,11 +755,11 @@ cipher_kt_mode_cbc(const char *ciphername)
     evp_cipher_type *cipher = cipher_get(ciphername);
 
     bool ret = cipher && (cipher_kt_mode(cipher) == OPENVPN_MODE_CBC
-           /* Exclude AEAD cipher modes, they require a different API */
+                          /* Exclude AEAD cipher modes, they require a different API */
 #ifdef EVP_CIPH_FLAG_CTS
-           && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_CTS)
+                          && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_CTS)
 #endif
-           && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER));
+                          && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER));
     EVP_CIPHER_free(cipher);
     return ret;
 }
@@ -767,9 +769,9 @@ cipher_kt_mode_ofb_cfb(const char *ciphername)
 {
     evp_cipher_type *cipher = cipher_get(ciphername);
     bool ofb_cfb = cipher && (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB
-                      || cipher_kt_mode(cipher) == OPENVPN_MODE_CFB)
-                      /* Exclude AEAD cipher modes, they require a different API */
-                      && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER);
+                              || cipher_kt_mode(cipher) == OPENVPN_MODE_CFB)
+                   /* Exclude AEAD cipher modes, they require a different API */
+                   && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER);
     EVP_CIPHER_free(cipher);
     return ofb_cfb;
 }
@@ -879,11 +881,11 @@ cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)
     int mode = EVP_CIPHER_CTX_mode(ctx);
 
     return mode == EVP_CIPH_CBC_MODE
-        /* Exclude AEAD cipher modes, they require a different API */
+           /* Exclude AEAD cipher modes, they require a different API */
 #ifdef EVP_CIPH_FLAG_CTS
-        && !(flags & EVP_CIPH_FLAG_CTS)
+           && !(flags & EVP_CIPH_FLAG_CTS)
 #endif
-        && !(flags & EVP_CIPH_FLAG_AEAD_CIPHER);
+           && !(flags & EVP_CIPH_FLAG_AEAD_CIPHER);
 }
 
 bool
@@ -897,8 +899,8 @@ cipher_ctx_mode_ofb_cfb(const cipher_ctx_t *ctx)
     int mode = EVP_CIPHER_CTX_get_mode(ctx);
 
     return (mode == EVP_CIPH_OFB_MODE || mode == EVP_CIPH_CFB_MODE)
-        /* Exclude AEAD cipher modes, they require a different API */
-        && !(EVP_CIPHER_CTX_flags(ctx) & EVP_CIPH_FLAG_AEAD_CIPHER);
+           /* Exclude AEAD cipher modes, they require a different API */
+           && !(EVP_CIPHER_CTX_flags(ctx) & EVP_CIPH_FLAG_AEAD_CIPHER);
 }
 
 bool
@@ -985,7 +987,7 @@ cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
     }
 
     unsigned char key3[DES_KEY_LENGTH*3];
-    for (int i = 0;i < 3;i++)
+    for (int i = 0; i < 3; i++)
     {
         memcpy(key3 + (i * DES_KEY_LENGTH), key, DES_KEY_LENGTH);
     }
@@ -1001,7 +1003,7 @@ cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
      * though there is nothing to encrypt anymore, provide space for that to
      * not overflow the stack */
     unsigned char dst2[DES_KEY_LENGTH * 2];
-    if(!EVP_EncryptUpdate(ctx, dst2, &len, src, DES_KEY_LENGTH))
+    if (!EVP_EncryptUpdate(ctx, dst2, &len, src, DES_KEY_LENGTH))
     {
         crypto_msg(M_FATAL, "%s: EVP_EncryptUpdate() failed", __func__);
     }
@@ -1223,7 +1225,7 @@ hmac_ctx_final(HMAC_CTX *ctx, uint8_t *dst)
 
     HMAC_Final(ctx, dst, &in_hmac_len);
 }
-#else
+#else  /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
 hmac_ctx_t *
 hmac_ctx_new(void)
 {
@@ -1315,7 +1317,7 @@ hmac_ctx_final(hmac_ctx_t *ctx, uint8_t *dst)
 
     EVP_MAC_final(ctx->ctx, dst, &in_hmac_len, in_hmac_len);
 }
-#endif
+#endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
 
 int
 memcmp_constant_time(const void *a, const void *b, size_t size)
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index f8818963..9fa081f0 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -63,7 +63,7 @@ static EVP_PKEY_METHOD *pmethod;
 static int (*default_pkey_sign_init) (EVP_PKEY_CTX *ctx);
 static int (*default_pkey_sign) (EVP_PKEY_CTX *ctx, unsigned char *sig,
                                  size_t *siglen, const unsigned char *tbs, size_t tbslen);
-#else
+#else  /* ifndef HAVE_XKEY_PROVIDER */
 static XKEY_EXTERNAL_SIGN_fn xkey_cng_sign;
 #endif /* HAVE_XKEY_PROVIDER */
 
@@ -828,7 +828,7 @@ xkey_cng_ec_sign(CAPI_DATA *cd, unsigned char *sig, size_t *siglen, const unsign
 /** Sign hash in tbs using RSA key in cd and NCryptSignHash */
 static int
 xkey_cng_rsa_sign(CAPI_DATA *cd, unsigned char *sig, size_t *siglen, const unsigned char *tbs,
-               size_t tbslen, XKEY_SIGALG sigalg)
+                  size_t tbslen, XKEY_SIGALG sigalg)
 {
     dmsg(D_LOW, "In xkey_cng_rsa_sign");
 
@@ -869,7 +869,7 @@ xkey_cng_rsa_sign(CAPI_DATA *cd, unsigned char *sig, size_t *siglen, const unsig
         }
 
         msg(D_LOW, "Signing using NCryptSignHash with PSS padding: hashalg <%s>, saltlen <%d>",
-                    sigalg.mdname, saltlen);
+            sigalg.mdname, saltlen);
 
         BCRYPT_PSS_PADDING_INFO padinfo = {hashalg, (DWORD) saltlen}; /* cast is safe as saltlen >= 0 */
         status = NCryptSignHash(cd->crypt_prov, &padinfo, (BYTE *)tbs, (DWORD) tbslen,
@@ -895,7 +895,7 @@ xkey_cng_rsa_sign(CAPI_DATA *cd, unsigned char *sig, size_t *siglen, const unsig
 /** Dispatch sign op to xkey_cng_<rsa/ec>_sign */
 static int
 xkey_cng_sign(void *handle, unsigned char *sig, size_t *siglen, const unsigned char *tbs,
-               size_t tbslen, XKEY_SIGALG sigalg)
+              size_t tbslen, XKEY_SIGALG sigalg)
 {
     dmsg(D_LOW, "In xkey_cng_sign");
 
@@ -910,7 +910,7 @@ xkey_cng_sign(void *handle, unsigned char *sig, size_t *siglen, const unsigned c
     /* compute digest if required */
     if (!strcmp(sigalg.op, "DigestSign"))
     {
-        if(!xkey_digest(tbs, tbslen, mdbuf, &buflen, sigalg.mdname))
+        if (!xkey_digest(tbs, tbslen, mdbuf, &buflen, sigalg.mdname))
         {
             return 0;
         }
@@ -992,7 +992,7 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     {
         /* private key may be in a token not available, or incompatible with CNG */
         msg(M_NONFATAL|M_ERRNO, "Error in cryptoapicert: failed to acquire key. Key not present or "
-                                "is in a legacy token not supported by Windows CNG API");
+            "is in a legacy token not supported by Windows CNG API");
         goto err;
     }
 
@@ -1015,11 +1015,11 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
 #ifdef HAVE_XKEY_PROVIDER
 
     EVP_PKEY *privkey = xkey_load_generic_key(tls_libctx, cd, pkey,
-                        xkey_cng_sign, (XKEY_PRIVKEY_FREE_fn *) CAPI_DATA_free);
+                                              xkey_cng_sign, (XKEY_PRIVKEY_FREE_fn *) CAPI_DATA_free);
     SSL_CTX_use_PrivateKey(ssl_ctx, privkey);
     return 1; /* do not free cd -- its kept by xkey provider */
 
-#else
+#else  /* ifdef HAVE_XKEY_PROVIDER */
 
     if (EVP_PKEY_id(pkey) == EVP_PKEY_RSA)
     {
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index d9cdb9ba..f49d1f33 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -93,7 +93,7 @@ bool dns_server_priority_parse(long *priority, const char *str, bool pulled);
  * @param   priority    Priority of the DNS server to find / create
  * @param   gc          The gc new list items should be allocated in
  */
-struct dns_server * dns_server_get(struct dns_server **entry, long priority, struct gc_arena *gc);
+struct dns_server *dns_server_get(struct dns_server **entry, long priority, struct gc_arena *gc);
 
 /**
  * Appends DNS domain parameters to a linked list.
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index b0e9a48c..603d6c63 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -493,7 +493,8 @@ close_syslog(void)
 #ifdef _WIN32
 static int orig_stderr;
 
-int get_orig_stderr()
+int
+get_orig_stderr()
 {
     return orig_stderr ? orig_stderr : _fileno(stderr);
 }
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index c615eed4..8930e578 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -335,7 +335,8 @@ send_control_channel_string_dowork(struct tls_multi *multi,
     return stat;
 }
 
-void reschedule_multi_process(struct context *c)
+void
+reschedule_multi_process(struct context *c)
 {
     interval_action(&c->c2.tmp_int);
     context_immediate_reschedule(c); /* ZERO-TIMEOUT */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 21adc3cf..b233b9d8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2160,8 +2160,8 @@ do_deferred_p2p_ncp(struct context *c)
     else if (!c->options.enable_ncp_fallback)
     {
         msg(D_TLS_ERRORS, "ERROR: failed to negotiate cipher with peer and "
-                          "--data-ciphers-fallback not enabled. No usable "
-                          "data channel cipher");
+            "--data-ciphers-fallback not enabled. No usable "
+            "data channel cipher");
         return false;
     }
 
@@ -2174,7 +2174,7 @@ do_deferred_p2p_ncp(struct context *c)
 #endif
 
     if (!tls_session_update_crypto_params(session, &c->options, &c->c2.frame,
-                                         frame_fragment, get_link_socket_info(c)))
+                                          frame_fragment, get_link_socket_info(c)))
     {
         msg(D_TLS_ERRORS, "ERROR: failed to set crypto cipher");
         return false;
@@ -2467,7 +2467,7 @@ frame_finalize_options(struct context *c, const struct options *o)
 
 
     /* the space that is reserved before the payload to add extra headers to it
-    * we always reserve the space for the worst case */
+     * we always reserve the space for the worst case */
     size_t headroom = 0;
 
     /* includes IV and packet ID */
@@ -2496,8 +2496,8 @@ frame_finalize_options(struct context *c, const struct options *o)
 
 #ifdef USE_COMP
     msg(D_MTU_DEBUG, "MTU: adding %lu buffer tailroom for compression for %lu "
-                     "bytes of payload",
-                     COMP_EXTRA_BUFFER(payload_size), payload_size);
+        "bytes of payload",
+        COMP_EXTRA_BUFFER(payload_size), payload_size);
     tailroom += COMP_EXTRA_BUFFER(payload_size);
 #endif
 
@@ -2698,25 +2698,25 @@ do_init_crypto_tls_c1(struct context *c)
             return;
         }
 
-       /*
-        * BF-CBC is allowed to be used only when explicitly configured
-        * as NCP-fallback or when NCP has been disabled or explicitly
-        * allowed in the in ncp_ciphers list.
-        * In all other cases do not attempt to initialize BF-CBC as it
-        * may not even be supported by the underlying SSL library.
-        *
-        * Therefore, the key structure has to be initialized when:
-        * - any non-BF-CBC cipher was selected; or
-        * - BF-CBC is selected, NCP is enabled and fallback is enabled
-        *   (BF-CBC will be the fallback).
-        * - BF-CBC is in data-ciphers and we negotiate to use BF-CBC:
-        *   If the negotiated cipher and options->ciphername are the
-        *   same we do not reinit the cipher
-        *
-        * Note that BF-CBC will still be part of the OCC string to retain
-        * backwards compatibility with older clients.
-        */
-        const char* ciphername = options->ciphername;
+        /*
+         * BF-CBC is allowed to be used only when explicitly configured
+         * as NCP-fallback or when NCP has been disabled or explicitly
+         * allowed in the in ncp_ciphers list.
+         * In all other cases do not attempt to initialize BF-CBC as it
+         * may not even be supported by the underlying SSL library.
+         *
+         * Therefore, the key structure has to be initialized when:
+         * - any non-BF-CBC cipher was selected; or
+         * - BF-CBC is selected, NCP is enabled and fallback is enabled
+         *   (BF-CBC will be the fallback).
+         * - BF-CBC is in data-ciphers and we negotiate to use BF-CBC:
+         *   If the negotiated cipher and options->ciphername are the
+         *   same we do not reinit the cipher
+         *
+         * Note that BF-CBC will still be part of the OCC string to retain
+         * backwards compatibility with older clients.
+         */
+        const char *ciphername = options->ciphername;
         if (streq(options->ciphername, "BF-CBC")
             && !tls_item_in_cipher_list("BF-CBC", options->ncp_ciphers)
             && !options->enable_ncp_fallback)
@@ -3079,14 +3079,14 @@ do_init_frame(struct context *c)
     if (c->options.ce.fragment > 0 && c->options.ce.mssfix > c->options.ce.fragment)
     {
         msg(M_WARN, "WARNING: if you use --mssfix and --fragment, you should "
-                    "set --fragment (%d) larger or equal than --mssfix (%d)",
-                    c->options.ce.fragment, c->options.ce.mssfix);
+            "set --fragment (%d) larger or equal than --mssfix (%d)",
+            c->options.ce.fragment, c->options.ce.mssfix);
     }
     if (c->options.ce.fragment > 0 && c->options.ce.mssfix > 0
         && c->options.ce.fragment_encap != c->options.ce.mssfix_encap)
     {
         msg(M_WARN, "WARNING: if you use --mssfix and --fragment, you should "
-                    "use the \"mtu\" flag for both or none of of them.");
+            "use the \"mtu\" flag for both or none of of them.");
     }
 #endif
 }
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 0c5a2e99..2b8c2dcc 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -144,6 +144,7 @@ void open_plugins(struct context *c, const bool import_options, int init_point);
 void tun_abort(void);
 
 void write_pid_file(const char *filename, const char *chroot_dir);
+
 void remove_pid_file(void);
 
 #endif /* ifndef INIT_H */
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 496042a6..9b03b057 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -947,7 +947,7 @@ parse_cid(const char *str, unsigned long *cid)
 }
 
 static bool
-parse_uint(const char *str, const char* what, unsigned int *uint)
+parse_uint(const char *str, const char *what, unsigned int *uint)
 {
     if (sscanf(str, "%u", uint) == 1)
     {
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index d8a15650..2a6c0b8b 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -216,8 +216,8 @@ prepend_dir(const char *dir, const char *path, struct gc_arena *gc);
 #define MAC_FMT _STRINGIFY(%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx)
 /* *INDENT-ON* */
 #define MAC_PRINT_ARG(_mac) _mac[0], _mac[1], _mac[2],  \
-        _mac[3], _mac[4], _mac[5]
+    _mac[3], _mac[4], _mac[5]
 #define MAC_SCAN_ARG(_mac) &_mac[0], &_mac[1], &_mac[2], \
-        &_mac[3], &_mac[4], &_mac[5]
+    &_mac[3], &_mac[4], &_mac[5]
 
 #endif /* ifndef MISC_H */
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 22f9fcf2..381e61a2 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -368,9 +368,9 @@ frame_adjust_path_mtu(struct context *c)
     if (pmtu < o->ce.mssfix
         || (o->ce.mssfix_encap && pmtu < o->ce.mssfix + encap_overhead))
     {
-        const char* mtustr = o->ce.mssfix_encap ? " mtu" : "";
+        const char *mtustr = o->ce.mssfix_encap ? " mtu" : "";
         msg(D_MTU_INFO, "Note adjusting 'mssfix %d%s' to 'mssfix %d mtu' "
-                        "according to path MTU discovery", o->ce.mssfix,
+            "according to path MTU discovery", o->ce.mssfix,
             mtustr, pmtu);
         o->ce.mssfix = pmtu;
         o->ce.mssfix_encap = true;
@@ -378,12 +378,12 @@ frame_adjust_path_mtu(struct context *c)
     }
 
 #if defined(ENABLE_FRAGMENT)
-    if (pmtu < o->ce.fragment ||
-        (o->ce.fragment_encap && pmtu < o->ce.fragment + encap_overhead))
+    if (pmtu < o->ce.fragment
+        || (o->ce.fragment_encap && pmtu < o->ce.fragment + encap_overhead))
     {
-        const char* mtustr = o->ce.fragment_encap ? " mtu" : "";
+        const char *mtustr = o->ce.fragment_encap ? " mtu" : "";
         msg(D_MTU_INFO, "Note adjusting 'fragment %d%s' to 'fragment %d mtu' "
-                        "according to path MTU discovery", o->ce.fragment,
+            "according to path MTU discovery", o->ce.fragment,
             mtustr, pmtu);
         o->ce.fragment = pmtu;
         o->ce.fragment_encap = true;
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index 4b809b1c..8e2986b7 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -47,4 +47,4 @@ void frame_calculate_dynamic(struct frame *frame, struct key_type *kt,
  */
 void frame_adjust_path_mtu(struct context *c);
 
-#endif
+#endif /* ifndef MSS_H */
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index aa810f1c..44bd0a47 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -179,7 +179,7 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
      * by pretending to have no encryption enabled and by manually adding
      * the required packet overhead to the MTU computation.
      */
-    const char* ciphername = o->ciphername;
+    const char *ciphername = o->ciphername;
 
     unsigned int overhead = 0;
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 8fc74321..ba2f6d58 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1847,7 +1847,7 @@ multi_client_set_protocol_options(struct context *c)
     if (!ret)
     {
         auth_set_client_reason(tls_multi, "Data channel cipher negotiation "
-                                          "failed (no shared cipher)");
+                               "failed (no shared cipher)");
     }
 
     gc_free(&gc);
@@ -2463,7 +2463,7 @@ multi_client_connect_compress_migrate(struct multi_context *m,
 
     if (o->comp.flags & COMP_F_MIGRATE && mi->context.c2.tls_multi->remote_usescomp)
     {
-        if(peer_info && strstr(peer_info, "IV_COMP_STUBv2=1"))
+        if (peer_info && strstr(peer_info, "IV_COMP_STUBv2=1"))
         {
             push_option(o, "compress stub-v2", M_USAGE);
         }
@@ -3894,7 +3894,8 @@ init_management_callback_multi(struct multi_context *m)
 #endif /* ifdef ENABLE_MANAGEMENT */
 }
 
-void multi_assign_peer_id(struct multi_context *m, struct multi_instance *mi)
+void
+multi_assign_peer_id(struct multi_context *m, struct multi_instance *mi)
 {
     /* max_clients must be less then max peer-id value */
     ASSERT(m->max_clients < MAX_PEER_ID);
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 98e0685e..e6328090 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1362,7 +1362,9 @@ net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
     int ifindex = if_nametoindex(iface);
 
     if (!ifindex)
+    {
         return errno;
+    }
 
     req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags = NLM_F_REQUEST;
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 81a71566..b3ee94f1 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -726,15 +726,16 @@ SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_ver_max)
  * is good enough for our case of printing certificate details during
  * handshake */
 static inline
-int EVP_PKEY_get_group_name(EVP_PKEY *pkey, char *gname, size_t gname_sz,
-                            size_t *gname_len)
+int
+EVP_PKEY_get_group_name(EVP_PKEY *pkey, char *gname, size_t gname_sz,
+                        size_t *gname_len)
 {
-    const EC_KEY* ec = EVP_PKEY_get0_EC_KEY(pkey);
+    const EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
     if (ec == NULL)
     {
         return 0;
     }
-    const EC_GROUP* group = EC_KEY_get0_group(ec);
+    const EC_GROUP *group = EC_KEY_get0_group(ec);
     int nid = EC_GROUP_get_curve_name(group);
 
     if (nid == 0)
@@ -753,7 +754,7 @@ int EVP_PKEY_get_group_name(EVP_PKEY *pkey, char *gname, size_t gname_sz,
     *gname_len = strlen(curve);
     return 1;
 }
-#endif
+#endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L && !defined(OPENSSL_NO_EC) */
 
 #if OPENSSL_VERSION_NUMBER < 0x30000000L
 #define EVP_MD_get0_name EVP_MD_name
@@ -762,7 +763,7 @@ int EVP_PKEY_get_group_name(EVP_PKEY *pkey, char *gname, size_t gname_sz,
 
 /** Reduce SSL_CTX_new_ex() to SSL_CTX_new() for OpenSSL < 3 */
 #define SSL_CTX_new_ex(libctx, propq, method)                \
-        SSL_CTX_new((method))
+    SSL_CTX_new((method))
 
 /* Some safe typedefs to avoid too many ifdefs */
 typedef void OSSL_LIB_CTX;
@@ -778,7 +779,7 @@ EVP_CIPHER_fetch(void *ctx, const char *algorithm, const char *properties)
     return EVP_get_cipherbyname(algorithm);
 }
 
-static inline const EVP_MD*
+static inline const EVP_MD *
 EVP_MD_fetch(void *ctx, const char *algorithm, const char *properties)
 {
     ASSERT(!ctx);
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index d185aec4..a6389fed 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -105,7 +105,8 @@ tunnel_point_to_point(struct context *c)
 
 #undef PROCESS_SIGNAL_P2P
 
-void init_early(struct context *c)
+void
+init_early(struct context *c)
 {
     net_ctx_init(c, &c->net_ctx);
 
@@ -113,18 +114,19 @@ void init_early(struct context *c)
     init_verb_mute(c, IVM_LEVEL_1);
 
     /* Initialise OpenSSL provider, this needs to be initialised this
-    * early since option post-processing and also openssl info
-    * printing depends on it */
-    for (int j=1; j < MAX_PARMS && c->options.providers.names[j]; j++)
+     * early since option post-processing and also openssl info
+     * printing depends on it */
+    for (int j = 1; j < MAX_PARMS && c->options.providers.names[j]; j++)
     {
         c->options.providers.providers[j] =
             crypto_load_provider(c->options.providers.names[j]);
     }
 }
 
-static void uninit_early(struct context *c)
+static void
+uninit_early(struct context *c)
 {
-    for (int j=1; j < MAX_PARMS && c->options.providers.providers[j]; j++)
+    for (int j = 1; j < MAX_PARMS && c->options.providers.providers[j]; j++)
     {
         crypto_unload_provider(c->options.providers.names[j],
                                c->options.providers.providers[j]);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fd4a407b..7f5c903d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -959,7 +959,7 @@ pull_filter_type_name(int type)
 #define SHOW_UNSIGNED(var)  SHOW_PARM(var, o->var, "0x%08x")
 #define SHOW_BOOL(var)      SHOW_PARM(var, (o->var ? "ENABLED" : "DISABLED"), "%s");
 
-#endif
+#endif /* ifndef ENABLE_SMALL */
 
 static void
 setenv_connection_entry(struct env_set *es,
@@ -1161,7 +1161,7 @@ parse_hash_fingerprint_multiline(const char *str, int nbytes, int msglevel,
     while ((line = strsep(&lines, "\n")))
     {
         /* ignore leading whitespace */
-        while(isspace(*line))
+        while (isspace(*line))
         {
             line++;
         }
@@ -1192,7 +1192,7 @@ parse_hash_fingerprint_multiline(const char *str, int nbytes, int msglevel,
 #ifndef ENABLE_SMALL
 
 static void
-show_dhcp_option_list(const char *name, const char * const*array, int len)
+show_dhcp_option_list(const char *name, const char *const *array, int len)
 {
     int i;
     for (i = 0; i < len; ++i)
@@ -2138,16 +2138,16 @@ check_ca_required(const struct options *options)
 #ifndef ENABLE_CRYPTO_MBEDTLS
         || options->ca_path
 #endif
-       )
+        )
     {
         return;
     }
 
-    const char* const str = "You must define CA file (--ca)"
+    const char *const str = "You must define CA file (--ca)"
 #ifndef ENABLE_CRYPTO_MBEDTLS
-        " or CA path (--capath)"
+                            " or CA path (--capath)"
 #endif
-        " and/or peer fingerprint verification (--peer-fingerprint)";
+                            " and/or peer fingerprint verification (--peer-fingerprint)";
     msg(M_USAGE, str);
 }
 
@@ -2381,7 +2381,7 @@ options_postprocess_verify_ce(const struct options *options,
     if (options->mode == MODE_SERVER)
     {
 #define USAGE_VALID_SERVER_PROTOS "--mode server currently only supports " \
-      "--proto values of udp, tcp-server, tcp4-server, or tcp6-server"
+    "--proto values of udp, tcp-server, tcp4-server, or tcp6-server"
 #ifdef TARGET_ANDROID
         msg(M_FATAL, "--mode server not supported on Android");
 #endif
@@ -2652,10 +2652,10 @@ options_postprocess_verify_ce(const struct options *options,
     if (!options->tls_server && !options->tls_client)
     {
         msg(M_INFO, "DEPRECATION: No tls-client or tls-server option in "
-                    "configuration detected. OpenVPN 2.7 will remove the "
-                    "functionality to run a VPN without TLS. "
-                    "See the examples section in the manual page for "
-                    "examples of a similar quick setup with peer-fingerprint.");
+            "configuration detected. OpenVPN 2.7 will remove the "
+            "functionality to run a VPN without TLS. "
+            "See the examples section in the manual page for "
+            "examples of a similar quick setup with peer-fingerprint.");
     }
 
     if (options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL))
@@ -2821,9 +2821,9 @@ options_postprocess_verify_ce(const struct options *options,
                     if (!options->auth_user_pass_file)
                     {
                         msg(M_USAGE, "No client-side authentication method is "
-                                     "specified.  You must use either "
-                                     "--cert/--key, --pkcs12, or "
-                                     "--auth-user-pass");
+                            "specified.  You must use either "
+                            "--cert/--key, --pkcs12, or "
+                            "--auth-user-pass");
                     }
                 }
                 else if (sum == 2)
@@ -3224,10 +3224,10 @@ options_postprocess_cipher(struct options *o)
         o->ciphername = "BF-CBC";
 
         msg(M_INFO, "Note: --cipher is not set. OpenVPN versions before 2.5 "
-                    "defaulted to BF-CBC as fallback when cipher negotiation "
-                    "failed in this case. If you need this fallback please add "
-                    "'--data-ciphers-fallback 'BF-CBC' to your configuration "
-                    "and/or add BF-CBC to --data-ciphers.");
+            "defaulted to BF-CBC as fallback when cipher negotiation "
+            "failed in this case. If you need this fallback please add "
+            "'--data-ciphers-fallback 'BF-CBC' to your configuration "
+            "and/or add BF-CBC to --data-ciphers.");
     }
     else if (!o->enable_ncp_fallback
              && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers))
@@ -3240,13 +3240,13 @@ options_postprocess_cipher(struct options *o)
 }
 
 /**
- * The option --compat-mode is used to set up default settings to values 
+ * The option --compat-mode is used to set up default settings to values
  * used on the specified openvpn version and earlier.
  *
  * This function is used in various "default option" paths to test if the
  * user requested compatibility with a version before the one specified
- * as argument. This way some default settings can be automatically 
- * altered to guarantee compatibility with the version specified by the 
+ * as argument. This way some default settings can be automatically
+ * altered to guarantee compatibility with the version specified by the
  * user via --compat-mode.
  *
  * @param version   need compatibility with openvpn versions before the
@@ -3268,7 +3268,7 @@ options_set_backwards_compatible_options(struct options *o)
 {
     /* TLS min version is not set */
     int tls_ver_min = (o->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT)
-                          & SSLF_TLS_VERSION_MIN_MASK;
+                      & SSLF_TLS_VERSION_MIN_MASK;
     if (tls_ver_min == 0)
     {
         int tls_ver_max = (o->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
@@ -5432,7 +5432,8 @@ show_compression_warning(struct compress_options *info)
 }
 #endif
 
-bool key_is_external(const struct options *options)
+bool
+key_is_external(const struct options *options)
 {
     bool ret = false;
 #ifdef ENABLE_MANAGEMENT
@@ -6301,7 +6302,7 @@ add_option(struct options *options,
             msg(msglevel, "Unknown parameter to --fragment: %s", p[2]);
         }
     }
-#endif
+#endif /* ifdef ENABLE_FRAGMENT */
     else if (streq(p[0], "mtu-disc") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
@@ -6351,9 +6352,9 @@ add_option(struct options *options,
         }
     }
 #ifdef TARGET_LINUX
-    else if (streq (p[0], "bind-dev") && p[1])
+    else if (streq(p[0], "bind-dev") && p[1])
     {
-        VERIFY_PERMISSION (OPT_P_SOCKFLAGS);
+        VERIFY_PERMISSION(OPT_P_SOCKFLAGS);
         options->bind_dev = p[1];
     }
 #endif
@@ -6425,7 +6426,7 @@ add_option(struct options *options,
         {
             int64_t val = atoll(p[2]);
             options->inactivity_minimum_bytes = (val < 0) ? 0 : val;
-            if ( options->inactivity_minimum_bytes > INT_MAX )
+            if (options->inactivity_minimum_bytes > INT_MAX)
             {
                 msg(M_WARN, "WARNING: '--inactive' with a 'bytes' value"
                     " >2 Gbyte was silently ignored in older versions.  If "
@@ -7696,7 +7697,8 @@ add_option(struct options *options,
         else if (streq(p[1], "server") && p[2] && p[3] && p[4])
         {
             long priority;
-            if (!dns_server_priority_parse(&priority, p[2], pull_mode)) {
+            if (!dns_server_priority_parse(&priority, p[2], pull_mode))
+            {
                 msg(msglevel, "--dns server: invalid priority value '%s'", p[2]);
                 goto err;
             }
@@ -7707,7 +7709,7 @@ add_option(struct options *options,
             {
                 for (int i = 4; p[i]; i++)
                 {
-                    if(!dns_server_addr_parse(server, p[i]))
+                    if (!dns_server_addr_parse(server, p[i]))
                     {
                         msg(msglevel, "--dns server %ld: malformed or duplicate address '%s'", priority, p[i]);
                         goto err;
@@ -7818,7 +7820,7 @@ add_option(struct options *options,
             o->netbios_node_type = t;
         }
         else if ((streq(p[1], "DNS") || streq(p[1], "DNS6")) && p[2] && !p[3]
-                && (!strstr(p[2], ":") || ipv6_addr_safe(p[2])))
+                 && (!strstr(p[2], ":") || ipv6_addr_safe(p[2])))
         {
             if (strstr(p[2], ":"))
             {
@@ -8416,7 +8418,7 @@ add_option(struct options *options,
 #endif /* ENABLE_CRYPTO_MBEDTLS */
     else if (streq(p[0], "providers") && p[1])
     {
-        for (size_t j = 1; j < MAX_PARMS && p[j] != NULL;j++)
+        for (size_t j = 1; j < MAX_PARMS && p[j] != NULL; j++)
         {
             options->providers.names[j] = p[j];
         }
@@ -8496,8 +8498,8 @@ add_option(struct options *options,
         if (streq(p[0], "verify-hash"))
         {
             msg(M_WARN, "DEPRECATED OPTION: The option --verify-hash is deprecated. "
-            "You should switch to the either use the level 1 certificate as "
-            "--ca option, use --tls-verify or use --peer-fingerprint");
+                "You should switch to the either use the level 1 certificate as "
+                "--ca option, use --tls-verify or use --peer-fingerprint");
             /* verify level 1 cert, i.e. the CA that signed the leaf cert */
             verify_hash_depth = 1;
         }
@@ -8509,7 +8511,7 @@ add_option(struct options *options,
         if (options->verify_hash && options->verify_hash_depth != verify_hash_depth)
         {
             msg(msglevel, "ERROR: Setting %s not allowed. --verify-hash and"
-                          " --peer-fingerprint are mutually exclusive", p[0]);
+                " --peer-fingerprint are mutually exclusive", p[0]);
             goto err;
         }
 
@@ -8523,7 +8525,7 @@ add_option(struct options *options,
             else if (p[2] && !streq(p[2], "SHA256"))
             {
                 msg(msglevel, "invalid or unsupported hashing algorithm: %s "
-                              "(only SHA1 and SHA256 are supported)", p[2]);
+                    "(only SHA1 and SHA256 are supported)", p[2]);
                 goto err;
             }
         }
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 114fe5f6..055789b3 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -79,8 +79,8 @@ struct options_pre_connect
 
     struct dns_options dns_options;
 
-    const char* ciphername;
-    const char* authname;
+    const char *ciphername;
+    const char *authname;
 
     int ping_send_timeout;
     int ping_rec_timeout;
@@ -242,7 +242,7 @@ struct options
     /* enable forward compatibility for post-2.1 features */
     bool forward_compatible;
     /** What version we should try to be compatible with as major * 10000 +
-      * minor * 100 + patch, e.g. 2.4.7 => 20407 */
+     * minor * 100 + patch, e.g. 2.4.7 => 20407 */
     unsigned int backwards_compatible;
 
     /* list of options that should be ignored even if unknown */
@@ -533,7 +533,7 @@ struct options
     int key_direction;
     const char *ciphername;
     bool enable_ncp_fallback;      /**< If defined fall back to
-                                    * ciphername if NCP fails */
+                                   * ciphername if NCP fails */
     const char *ncp_ciphers;
     const char *authname;
     const char *engine;
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index c4f88816..d561fc08 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -48,15 +48,15 @@ static XKEY_EXTERNAL_SIGN_fn xkey_pkcs11h_sign;
 #if PKCS11H_VERSION > ((1<<16) | (27<<8)) /* version > 1.27 */
 
 /* Table linking OpenSSL digest NID with CKM and CKG constants in PKCS#11 */
-#define MD_TYPE(n) {NID_sha##n, CKM_SHA##n, CKG_MGF1_SHA##n}
+#define MD_TYPE(n) {NID_sha ## n, CKM_SHA ## n, CKG_MGF1_SHA ## n}
 static const struct
 {
-   int nid;
-   unsigned long ckm_id;
-   unsigned long mgf_id;
+    int nid;
+    unsigned long ckm_id;
+    unsigned long mgf_id;
 } mdtypes[] = {MD_TYPE(224), MD_TYPE(256), MD_TYPE(384), MD_TYPE(512),
-              {NID_sha1, CKM_SHA_1, CKG_MGF1_SHA1}, /* SHA_1 naming is an oddity */
-              {NID_undef, 0, 0}};
+               {NID_sha1, CKM_SHA_1, CKG_MGF1_SHA1}, /* SHA_1 naming is an oddity */
+               {NID_undef, 0, 0}};
 
 /* From sigalg, derive parameters for pss signature and fill in  pss_params.
  * Its of type CK_RSA_PKCS_PSS_PARAMS struct with three fields to be filled in:
@@ -93,7 +93,7 @@ set_pss_params(CK_RSA_PKCS_PSS_PARAMS *pss_params, XKEY_SIGALG sigalg,
     if (!md)
     {
         msg(M_WARN, "WARN: set_pss_params: EVP_get_digestbyname returned NULL "
-                    "for mdname = <%s>", sigalg.mdname);
+            "for mdname = <%s>", sigalg.mdname);
         goto cleanup;
     }
     int mdsize = EVP_MD_get_size(md);
@@ -111,7 +111,7 @@ set_pss_params(CK_RSA_PKCS_PSS_PARAMS *pss_params, XKEY_SIGALG sigalg,
     if (saltlen < 0 || pss_params->hashAlg == 0)
     {
         msg(M_WARN, "WARN: invalid RSA_PKCS1_PSS parameters: saltlen = <%s> "
-                    "mdname = <%s>.", sigalg.saltlen, sigalg.mdname);
+            "mdname = <%s>.", sigalg.saltlen, sigalg.mdname);
         goto cleanup;
     }
     pss_params->sLen = (unsigned long) saltlen; /* saltlen >= 0 at this point */
@@ -129,7 +129,7 @@ cleanup:
     return ret;
 }
 
-#else
+#else  /* if PKCS11H_VERSION > ((1<<16) | (27<<8)) */
 
 /* Make set_pss_params a no-op that always succeeds */
 #define set_pss_params(...) (1)
@@ -141,13 +141,13 @@ cleanup:
  */
 static CK_RV
 pkcs11h_certificate_signAny_ex(const pkcs11h_certificate_t cert,
-        const CK_MECHANISM *mech, const unsigned char *tbs,
-        size_t tbslen, unsigned char *sig, size_t *siglen)
+                               const CK_MECHANISM *mech, const unsigned char *tbs,
+                               size_t tbslen, unsigned char *sig, size_t *siglen)
 {
     if (mech->mechanism == CKM_RSA_PKCS_PSS)
     {
         msg(M_NONFATAL, "PKCS#11: Error: PSS padding is not supported by "
-                        "this version of pkcs11-helper library.");
+            "this version of pkcs11-helper library.");
         return CKR_MECHANISM_INVALID;
     }
     return pkcs11h_certificate_signAny(cert, mech->mechanism, tbs, tbslen, sig, siglen);
@@ -161,7 +161,7 @@ pkcs11h_certificate_signAny_ex(const pkcs11h_certificate_t cert,
  */
 static int
 xkey_pkcs11h_sign(void *handle, unsigned char *sig,
-            size_t *siglen, const unsigned char *tbs, size_t tbslen, XKEY_SIGALG sigalg)
+                  size_t *siglen, const unsigned char *tbs, size_t tbslen, XKEY_SIGALG sigalg)
 {
     pkcs11h_certificate_t cert = handle;
     CK_MECHANISM mech = {CKM_RSA_PKCS, NULL, 0}; /* default value */
@@ -231,11 +231,11 @@ xkey_pkcs11h_sign(void *handle, unsigned char *sig,
     }
     else
     {
-         ASSERT(0); /* coding error -- we couldnt have created any such key */
+        ASSERT(0);  /* coding error -- we couldnt have created any such key */
     }
 
     return CKR_OK == pkcs11h_certificate_signAny_ex(cert, &mech,
-                                                 tbs, tbslen, sig, siglen);
+                                                    tbs, tbslen, sig, siglen);
 }
 
 /* wrapper for handle free */
@@ -258,7 +258,7 @@ xkey_handle_free(void *handle)
  */
 static int
 xkey_load_from_pkcs11h(pkcs11h_certificate_t certificate,
-                        struct tls_root_ctx *const ctx)
+                       struct tls_root_ctx *const ctx)
 {
     int ret = 0;
 
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 450f28ba..61afee83 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -220,7 +220,7 @@ platform_mlockall(bool print_msg)
             }
         }
     }
-#endif
+#endif /* if defined(HAVE_GETRLIMIT) && defined(RLIMIT_MEMLOCK) */
 
     if (mlockall(MCL_CURRENT | MCL_FUTURE))
     {
@@ -232,7 +232,7 @@ platform_mlockall(bool print_msg)
     }
 #else  /* ifdef HAVE_MLOCKALL */
     msg(M_WARN, "WARNING: mlockall call failed (function not implemented)");
-#endif
+#endif /* ifdef HAVE_MLOCKALL */
 }
 
 /*
@@ -282,7 +282,7 @@ platform_ret_code(int stat)
         return -1;
     }
 }
-#else
+#else  /* ifdef _WIN32 */
 int
 platform_ret_code(int stat)
 {
@@ -301,7 +301,7 @@ platform_ret_code(int stat)
         return -1;
     }
 }
-#endif
+#endif /* ifdef _WIN32 */
 
 int
 platform_access(const char *path, int mode)
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 9c4b52f6..70fd1c3c 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -284,12 +284,14 @@ void
 receive_auth_pending(struct context *c, const struct buffer *buffer)
 {
     if (!c->options.pull)
+    {
         return;
+    }
 
     /* Cap the increase at the maximum time we are willing stay in the
      * pending authentication state */
     unsigned int max_timeout = max_uint(c->options.renegotiate_seconds/2,
-                               c->options.handshake_window);
+                                        c->options.handshake_window);
 
     /* try to parse parameter keywords, default to hand-winow timeout if the
      * server does not supply a timeout */
@@ -297,8 +299,8 @@ receive_auth_pending(struct context *c, const struct buffer *buffer)
     parse_auth_pending_keywords(buffer, &server_timeout);
 
     msg(D_PUSH, "AUTH_PENDING received, extending handshake timeout from %us "
-                "to %us", c->options.handshake_window,
-                min_uint(max_timeout, server_timeout));
+        "to %us", c->options.handshake_window,
+        min_uint(max_timeout, server_timeout));
 
     const struct key_state *ks = get_primary_key(c->c2.tls_multi);
     c->c2.push_request_timeout = ks->established + min_uint(max_timeout, server_timeout);
@@ -395,8 +397,8 @@ send_auth_pending_messages(struct tls_multi *tls_multi, const char *extra,
     else
     {
         static const char auth_pre[] = "AUTH_PENDING,timeout ";
-        // Assume a worst case of 8 byte uint64 in decimal which
-        // needs 20 bytes
+        /* Assume a worst case of 8 byte uint64 in decimal which */
+        /* needs 20 bytes */
         size_t len = 20 + 1 + sizeof(auth_pre);
         struct buffer buf = alloc_buf_gc(len, &gc);
         buf_printf(&buf, auth_pre);
diff --git a/src/openvpn/ring_buffer.h b/src/openvpn/ring_buffer.h
index 089076be..cc48c024 100644
--- a/src/openvpn/ring_buffer.h
+++ b/src/openvpn/ring_buffer.h
@@ -116,7 +116,7 @@ register_ring_buffers(HANDLE device,
     rr.receive.tail_moved = receive_tail_moved;
 
     res = DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr, sizeof(rr),
-      NULL, 0, &bytes_returned, NULL);
+                          NULL, 0, &bytes_returned, NULL);
 
     return res != FALSE;
 }
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 40476798..200f82c5 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -50,7 +50,7 @@
 #endif
 
 #if defined(TARGET_NETBSD)
-#include <net/route.h>			/* RT_ROUNDUP(), RT_ADVANCE() */
+#include <net/route.h>                  /* RT_ROUNDUP(), RT_ADVANCE() */
 #endif
 
 #ifdef _WIN32
@@ -1480,7 +1480,7 @@ setenv_route_ipv6(struct env_set *es, const struct route_ipv6 *r6, int i)
         if (r6->flags & RT_METRIC_DEFINED)
         {
             struct buffer name3 = alloc_buf_gc( 256, &gc );
-            buf_printf( &name3, "route_ipv6_metric_%d", i) ;
+            buf_printf( &name3, "route_ipv6_metric_%d", i);
             setenv_int( es, BSTR(&name3), r6->metric);
         }
     }
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index cf38462f..966283ab 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -54,7 +54,7 @@ int openvpn_popen(const struct argv *a,  const struct env_set *es);
 bool openvpn_execve_allowed(const unsigned int flags);
 
 int openvpn_execve_check(const struct argv *a, const struct env_set *es,
-                          const unsigned int flags, const char *error_message);
+                         const unsigned int flags, const char *error_message);
 
 /**
  * Will run a script and return the exit code of the script if between
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 8fb58e14..270a829f 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -279,8 +279,8 @@ static inline BOOL
 SocketHandleGetOverlappedResult(sockethandle_t sh, struct overlapped_io *io)
 {
     return sh.is_handle ?
-        GetOverlappedResult(sh.h, &io->overlapped, &io->size, FALSE) :
-        WSAGetOverlappedResult(sh.s, &io->overlapped, &io->size, FALSE, &io->flags);
+           GetOverlappedResult(sh.h, &io->overlapped, &io->size, FALSE) :
+           WSAGetOverlappedResult(sh.s, &io->overlapped, &io->size, FALSE, &io->flags);
 }
 
 static inline int
@@ -305,7 +305,7 @@ SocketHandleSetInvalError(sockethandle_t sh)
 
 #define openvpn_close_socket(s) close(s)
 
-#endif
+#endif /* ifdef _WIN32 */
 
 struct link_socket *link_socket_new(void);
 
@@ -585,7 +585,7 @@ proto_is_dgram(int proto)
 }
 
 /**
-  * @brief returns if the proto is a TCP variant (tcp-server, tcp-client or tcp)
+ * @brief returns if the proto is a TCP variant (tcp-server, tcp-client or tcp)
  */
 static inline bool
 proto_is_tcp(int proto)
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 768bb613..ef178a35 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -308,7 +308,7 @@ recv_socks_reply(socket_descriptor_t sd,
     char atyp = '\0';
     int alen = 0;
     int len = 0;
-    char buf[270];		/* 4 + alen(max 256) + 2 */
+    char buf[270];              /* 4 + alen(max 256) + 2 */
     const int timeout_sec = 5;
 
     if (addr != NULL)
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 14a943a7..f2613228 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -319,7 +319,7 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
                         packet_id_size(true) + OPENVPN_MAX_HMAC_SIZE);
 
     /* TCP length field and opcode */
-    overhead+= 3;
+    overhead += 3;
 
     /* ACK array and remote SESSION ID (part of the ACK array) */
     overhead += ACK_SIZE(RELIABLE_ACK_SIZE);
@@ -812,10 +812,13 @@ ks_auth_name(enum ks_auth_state auth)
     {
         case KS_AUTH_TRUE:
             return "KS_AUTH_TRUE";
+
         case KS_AUTH_DEFERRED:
             return "KS_AUTH_DEFERRED";
+
         case KS_AUTH_FALSE:
             return "KS_AUTH_FALSE";
+
         default:
             return "KS_????";
     }
@@ -1865,9 +1868,9 @@ cleanup:
 
 bool
 tls_session_update_crypto_params_do_work(struct tls_session *session,
-                                 struct options* options, struct frame *frame,
-                                 struct frame *frame_fragment,
-                                 struct link_socket_info *lsi)
+                                         struct options *options, struct frame *frame,
+                                         struct frame *frame_fragment,
+                                         struct link_socket_info *lsi)
 {
     if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
     {
@@ -1919,7 +1922,7 @@ tls_session_update_crypto_params(struct tls_session *session,
 {
 
     bool cipher_allowed_as_fallback = options->enable_ncp_fallback
-        && streq(options->ciphername, session->opt->config_ciphername);
+                                      && streq(options->ciphername, session->opt->config_ciphername);
 
     if (!session->opt->server && !cipher_allowed_as_fallback
         && !tls_item_in_cipher_list(options->ciphername, options->ncp_ciphers))
@@ -2249,11 +2252,11 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
                 if (e->string)
                 {
                     if ((((strncmp(e->string, "UV_", 3) == 0
-                        || strncmp(e->string, "IV_PLAT_VER=", sizeof("IV_PLAT_VER=") - 1) == 0)
-                        && session->opt->push_peer_info_detail >= 2)
-                        || (strncmp(e->string, "IV_GUI_VER=", sizeof("IV_GUI_VER=") - 1) == 0)
-                        || (strncmp(e->string, "IV_SSO=", sizeof("IV_SSO=") - 1) == 0)
-                    )
+                           || strncmp(e->string, "IV_PLAT_VER=", sizeof("IV_PLAT_VER=") - 1) == 0)
+                          && session->opt->push_peer_info_detail >= 2)
+                         || (strncmp(e->string, "IV_GUI_VER=", sizeof("IV_GUI_VER=") - 1) == 0)
+                         || (strncmp(e->string, "IV_SSO=", sizeof("IV_SSO=") - 1) == 0)
+                         )
                         && buf_safe(&out, strlen(e->string) + 1))
                     {
                         buf_printf(&out, "%s\n", e->string);
@@ -2326,7 +2329,7 @@ key_method_2_write(struct buffer *buf, struct tls_multi *multi, struct tls_sessi
     {
 #ifdef USE_COMP
         if (multi->remote_usescomp && session->opt->mode == MODE_SERVER
-           && multi->opt.comp_options.flags & COMP_F_MIGRATE)
+            && multi->opt.comp_options.flags & COMP_F_MIGRATE)
         {
             if (!write_compat_local_options(buf, session->opt->local_options))
             {
@@ -2575,7 +2578,7 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
         if (multi->opt.comp_options.flags & COMP_F_MIGRATE && multi->remote_usescomp)
         {
             msg(D_SHOW_OCC, "Note: 'compress migrate' detected remote peer "
-                            "with compression enabled.");
+                "with compression enabled.");
             remote_options = options_string_compat_lzo(remote_options, &gc);
         }
 #endif
@@ -3151,8 +3154,8 @@ tls_multi_process(struct tls_multi *multi,
             if (ks->state == S_ACTIVE && ks->authenticated == KS_AUTH_TRUE)
             {
                 /* Session is now fully authenticated.
-                 * tls_session_generate_data_channel_keys will move ks->state
-                 * from S_ACTIVE to S_GENERATED_KEYS */
+                * tls_session_generate_data_channel_keys will move ks->state
+                * from S_ACTIVE to S_GENERATED_KEYS */
                 if (!tls_session_generate_data_channel_keys(session))
                 {
                     msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion failed");
@@ -3843,7 +3846,8 @@ error:
     return false;
 }
 
-struct key_state *tls_select_encryption_key(struct tls_multi *multi)
+struct key_state *
+tls_select_encryption_key(struct tls_multi *multi)
 {
     struct key_state *ks_select = NULL;
     for (int i = 0; i < KEY_SCAN_SIZE; ++i)
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 4eff77dc..1bd33699 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -405,7 +405,7 @@ void backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx,
  */
 bool
 key_state_export_keying_material(struct tls_session *session,
-                                 const char* label, size_t label_size,
+                                 const char *label, size_t label_size,
                                  void *ekm, size_t ekm_size);
 
 /**************************************************************************/
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 8a077c74..cef2611b 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -96,8 +96,8 @@
                                  *   handshake window.  Deferred auth and
                                  *   client connect can still be pending. */
 #define S_GENERATED_KEYS  7     /**< The data channel keys have been generated
-                                  *  The TLS session is fully authenticated
-                                  *  when reaching this state. */
+                                 *  The TLS session is fully authenticated
+                                 *  when reaching this state. */
 
 /* Note that earlier versions also had a S_OP_NORMAL state that was
  * virtually identical with S_ACTIVE and the code still assumes everything
@@ -141,14 +141,14 @@ struct key_source2 {
  * Only KS_AUTH_TRUE is fully authenticated
  */
 enum ks_auth_state {
-  KS_AUTH_FALSE,              /**< Key state is not authenticated  */
-  KS_AUTH_DEFERRED,           /**< Key state authentication is being deferred,
-                                * by async auth */
-  KS_AUTH_TRUE                /**< Key state is authenticated. TLS and user/pass
-                                * succeeded. This includes AUTH_PENDING/OOB
-                                * authentication as those hold the
-                                * connection artificially in KS_AUTH_DEFERRED
-                                */
+    KS_AUTH_FALSE,            /**< Key state is not authenticated  */
+    KS_AUTH_DEFERRED,         /**< Key state authentication is being deferred,
+                               * by async auth */
+    KS_AUTH_TRUE              /**< Key state is authenticated. TLS and user/pass
+                               * succeeded. This includes AUTH_PENDING/OOB
+                               * authentication as those hold the
+                               * connection artificially in KS_AUTH_DEFERRED
+                               */
 };
 
 struct auth_deferred_status
@@ -648,10 +648,13 @@ get_key_scan(struct tls_multi *multi, int index)
     {
         case 0:
             return &multi->session[TM_ACTIVE].key[KS_PRIMARY];
+
         case 1:
             return &multi->session[TM_ACTIVE].key[KS_LAME_DUCK];
+
         case 2:
             return &multi->session[TM_LAME_DUCK].key[KS_LAME_DUCK];
+
         default:
             ASSERT(false);
             return NULL; /* NOTREACHED */
@@ -664,7 +667,7 @@ get_key_scan(struct tls_multi *multi, int index)
 static inline const struct key_state *
 get_primary_key(const struct tls_multi *multi)
 {
-        return &multi->session[TM_ACTIVE].key[KS_PRIMARY];
+    return &multi->session[TM_ACTIVE].key[KS_PRIMARY];
 }
 
 #endif /* SSL_COMMON_H_ */
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index a7e5802d..e86c95b6 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -69,9 +69,10 @@
  * rely on function detection at configure time.
  */
 #ifndef HAVE_CTR_DRBG_UPDATE_RET
-static int mbedtls_ctr_drbg_update_ret(mbedtls_ctr_drbg_context *ctx,
-                                       const unsigned char *additional,
-                                       size_t add_len)
+static int
+mbedtls_ctr_drbg_update_ret(mbedtls_ctr_drbg_context *ctx,
+                            const unsigned char *additional,
+                            size_t add_len)
 {
     mbedtls_ctr_drbg_update(ctx, additional, add_len);
     return 0;
@@ -203,7 +204,7 @@ mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms,
     struct tls_key_cache *cache = &ks_ssl->tls_key_cache;
 
     static_assert(sizeof(ks_ssl->ctx->session->master)
-                    == sizeof(cache->master_secret), "master size mismatch");
+                  == sizeof(cache->master_secret), "master size mismatch");
 
     memcpy(cache->client_server_random, client_random, 32);
     memcpy(cache->client_server_random + 32, server_random, 32);
@@ -215,7 +216,7 @@ mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms,
 
 bool
 key_state_export_keying_material(struct tls_session *session,
-                                 const char* label, size_t label_size,
+                                 const char *label, size_t label_size,
                                  void *ekm, size_t ekm_size)
 {
     ASSERT(strlen(label) == label_size);
@@ -242,13 +243,13 @@ key_state_export_keying_material(struct tls_session *session,
     else
     {
         secure_memzero(ekm, session->opt->ekm_size);
-        return  false;
+        return false;
     }
 }
-#else
+#else  /* ifdef HAVE_EXPORT_KEYING_MATERIAL */
 bool
 key_state_export_keying_material(struct tls_session *session,
-                                 const char* label, size_t label_size,
+                                 const char *label, size_t label_size,
                                  void *ekm, size_t ekm_size)
 {
     /* Dummy function to avoid ifdefs in the common code */
@@ -1108,8 +1109,8 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
     }
 
     /* Disable TLS renegotiations if the mbedtls library supports that feature.
-     * OpenVPN's renegotiation creates new SSL sessions and does not depend on
-     * this feature and TLS renegotiations have been problematic in the past. */
+    * OpenVPN's renegotiation creates new SSL sessions and does not depend on
+    * this feature and TLS renegotiations have been problematic in the past. */
 #if defined(MBEDTLS_SSL_RENEGOTIATION)
     mbedtls_ssl_conf_renegotiation(ks_ssl->ssl_config, MBEDTLS_SSL_RENEGOTIATION_DISABLED);
 #endif /* MBEDTLS_SSL_RENEGOTIATION */
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 52a53bb4..175e6bd9 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -91,7 +91,7 @@ struct tls_key_cache {
     mbedtls_tls_prf_types tls_prf_type;
     unsigned char master_secret[48];
 };
-#else
+#else  /* ifdef HAVE_EXPORT_KEYING_MATERIAL */
 struct tls_key_cache { };
 #endif
 
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 470a387b..5d7e6dd3 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -125,14 +125,14 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
         if (nonecipher)
         {
             msg(M_WARN, "WARNING: cipher 'none' specified for --data-ciphers. "
-                        "This allows negotiation of NO encryption and "
-                        "tunnelled data WILL then be transmitted in clear text "
-                        "over the network! "
-                        "PLEASE DO RECONSIDER THIS SETTING!");
+                "This allows negotiation of NO encryption and "
+                "tunnelled data WILL then be transmitted in clear text "
+                "over the network! "
+                "PLEASE DO RECONSIDER THIS SETTING!");
         }
         if (!nonecipher && !cipher_valid(token))
         {
-            const char* optstr = optional ? "optional ": "";
+            const char *optstr = optional ? "optional " : "";
             msg(M_WARN, "Unsupported %scipher in --data-ciphers: %s", optstr, token);
             error_found = error_found || !optional;
         }
@@ -255,8 +255,8 @@ ncp_get_best_cipher(const char *server_list, const char *peer_info,
     /* non-NCP client without OCC?  "assume nothing" */
     /* For client doing the newer version of NCP (that send IV_CIPHER)
      * we cannot assume that they will accept remote_cipher */
-    if (remote_cipher == NULL ||
-        (peer_info && strstr(peer_info, "IV_CIPHERS=")))
+    if (remote_cipher == NULL
+        || (peer_info && strstr(peer_info, "IV_CIPHERS=")))
     {
         remote_cipher = "";
     }
@@ -316,7 +316,7 @@ check_pull_client_ncp(struct context *c, const int found)
 
     /* If the server did not push a --cipher, we will switch to the
      * remote cipher if it is in our ncp-ciphers list */
-    if(tls_poor_mans_ncp(&c->options, c->c2.tls_multi->remote_ciphername))
+    if (tls_poor_mans_ncp(&c->options, c->c2.tls_multi->remote_ciphername))
     {
         return true;
     }
@@ -350,7 +350,7 @@ check_pull_client_ncp(struct context *c, const int found)
     }
 }
 
-const char*
+const char *
 get_p2p_ncp_cipher(struct tls_session *session, const char *peer_info,
                    struct gc_arena *gc)
 {
@@ -364,8 +364,8 @@ get_p2p_ncp_cipher(struct tls_session *session, const char *peer_info,
         return NULL;
     }
 
-    const char* server_ciphers;
-    const char* client_ciphers;
+    const char *server_ciphers;
+    const char *client_ciphers;
 
     if (session->opt->server)
     {
@@ -416,7 +416,7 @@ p2p_ncp_set_options(struct tls_multi *multi, struct tls_session *session)
     if (iv_proto_peer & IV_PROTO_DATA_V2)
     {
         multi->use_peer_id = true;
-        multi->peer_id = 0x76706e; // 'v' 'p' 'n'
+        multi->peer_id = 0x76706e; /* 'v' 'p' 'n' */
     }
 
 #if defined(HAVE_EXPORT_KEYING_MATERIAL)
@@ -439,7 +439,7 @@ p2p_ncp_set_options(struct tls_multi *multi, struct tls_session *session)
                  * happen or very likely the TLS encryption key exporter will
                  * also fail */
                 msg(M_NONFATAL, "TLS key export for P2P peer id failed. "
-                                "Continuing anyway, expect problems");
+                    "Continuing anyway, expect problems");
             }
             else
             {
@@ -448,7 +448,7 @@ p2p_ncp_set_options(struct tls_multi *multi, struct tls_session *session)
 
         }
     }
-#endif
+#endif /* if defined(HAVE_EXPORT_KEYING_MATERIAL) */
 }
 
 void
@@ -461,7 +461,7 @@ p2p_mode_ncp(struct tls_multi *multi, struct tls_session *session)
 
     /* Query the common cipher here to log it as part of our message.
      * We postpone switching the cipher to do_up */
-    const char* common_cipher = get_p2p_ncp_cipher(session, multi->peer_info, &gc);
+    const char *common_cipher = get_p2p_ncp_cipher(session, multi->peer_info, &gc);
 
     if (!common_cipher)
     {
@@ -484,7 +484,7 @@ p2p_mode_ncp(struct tls_multi *multi, struct tls_session *session)
     }
 
     msg(D_TLS_DEBUG_LOW, "P2P mode NCP negotiation result: "
-                         "TLS_export=%d, DATA_v2=%d, peer-id %d, cipher=%s",
+        "TLS_export=%d, DATA_v2=%d, peer-id %d, cipher=%s",
         (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT),
         multi->use_peer_id, multi->peer_id, common_cipher);
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index af97dabc..1ae144ab 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -167,11 +167,11 @@ tls_ctx_initialised(struct tls_root_ctx *ctx)
 
 bool
 key_state_export_keying_material(struct tls_session *session,
-                                 const char* label, size_t label_size,
+                                 const char *label, size_t label_size,
                                  void *ekm, size_t ekm_size)
 
 {
-    SSL* ssl = session->key[KS_PRIMARY].ks_ssl.ssl;
+    SSL *ssl = session->key[KS_PRIMARY].ks_ssl.ssl;
 
     if (SSL_export_keying_material(ssl, ekm, ekm_size, label,
                                    label_size, NULL, 0, 0) == 1)
@@ -619,13 +619,13 @@ tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
                    groups);
     }
     gc_free(&gc);
-#else
+#else  /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
     if (!SSL_CTX_set1_groups_list(ctx->ctx, groups))
     {
         crypto_msg(M_FATAL, "Failed to set allowed TLS group list: %s",
                    groups);
     }
-#endif
+#endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
 }
 
 void
@@ -704,7 +704,7 @@ tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
 
     msg(D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with %d bit key",
         8 * EVP_PKEY_get_size(dh));
-#else
+#else  /* if OPENSSL_VERSION_NUMBER >= 0x30000000L */
     DH *dh = PEM_read_bio_DHparams(bio, NULL, NULL, NULL);
     BIO_free(bio);
 
@@ -722,7 +722,7 @@ tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
         8 * DH_size(dh));
 
     DH_free(dh);
-#endif
+#endif /* if OPENSSL_VERSION_NUMBER >= 0x30000000L */
 }
 
 void
@@ -732,8 +732,8 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name)
     if (curve_name != NULL)
     {
         msg(M_WARN, "WARNING: OpenSSL 3.0+ builds do not support specifying an "
-                    "ECDH curve with --ecdh-curve, using default curves. Use "
-                    "--tls-groups to specify groups.");
+            "ECDH curve with --ecdh-curve, using default curves. Use "
+            "--tls-groups to specify groups.");
     }
 #elif !defined(OPENSSL_NO_EC)
     int nid = NID_undef;
@@ -849,7 +849,7 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
         if (!PKCS12_parse(p12, password, &pkey, &cert, &ca))
         {
             crypto_msg(M_WARN, "Decoding PKCS12 failed. Probably wrong password "
-                               "or unsupported/legacy encryption");
+                       "or unsupported/legacy encryption");
 #ifdef ENABLE_MANAGEMENT
             if (management && (ERR_GET_REASON(ERR_peek_error()) == PKCS12_R_MAC_VERIFY_FAILURE))
             {
@@ -1506,7 +1506,7 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
         goto cleanup;
     }
     EVP_PKEY_free(privkey);
-#else
+#else  /* ifdef HAVE_XKEY_PROVIDER */
     if (EVP_PKEY_id(pkey) == EVP_PKEY_RSA)
     {
         if (!tls_ctx_use_external_rsa_key(ctx, pkey))
@@ -2088,9 +2088,9 @@ print_cert_details(X509 *cert, char *buf, size_t buflen)
     if (typeid == EVP_PKEY_EC)
     {
         size_t len;
-        if(EVP_PKEY_get_group_name(pkey, groupname, sizeof(groupname), &len))
+        if (EVP_PKEY_get_group_name(pkey, groupname, sizeof(groupname), &len))
         {
-           curve = groupname;
+            curve = groupname;
         }
         else
         {
@@ -2365,7 +2365,7 @@ load_xkey_provider(void)
         if (!OSSL_PROVIDER_load(tls_libctx, "ovpn.xkey"))
         {
             msg(M_NONFATAL, "ERROR: failed loading external key provider: "
-                            "Signing with external keys will not work.");
+                "Signing with external keys will not work.");
         }
     }
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 3b6b58fa..c01841fa 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -930,7 +930,7 @@ key_state_check_auth_pending_file(struct auth_deferred_status *ads,
             if (!lines->head || !lines->head->next || !lines->head->next->next)
             {
                 msg(M_WARN, "auth pending control file is not at least "
-                            "three lines long.");
+                    "three lines long.");
                 buffer_list_free(lines);
                 return false;
             }
@@ -951,7 +951,7 @@ key_state_check_auth_pending_file(struct auth_deferred_status *ads,
                 return false;
             }
 
-            const char* pending_method = BSTR(iv_buf);
+            const char *pending_method = BSTR(iv_buf);
             if (!check_auth_pending_method(multi->peer_info, pending_method))
             {
                 char buf[128];
@@ -960,7 +960,7 @@ key_state_check_auth_pending_file(struct auth_deferred_status *ads,
                                  "method '%s' not supported", pending_method);
                 auth_set_client_reason(multi, buf);
                 msg(M_INFO, "Client does not supported auth pending method "
-                            "'%s'", pending_method);
+                    "'%s'", pending_method);
                 ret = false;
             }
             else
@@ -1021,9 +1021,9 @@ key_state_gen_auth_control_files(struct auth_deferred_status *ads,
 }
 
 /**
- * Checks the auth control status from a file. The function will try 
- * to read and update the cached status if the status is still pending 
- * and the parameter cached is false. 
+ * Checks the auth control status from a file. The function will try
+ * to read and update the cached status if the status is still pending
+ * and the parameter cached is false.
  * The function returns the most recent known status.
  *
  * @param ads       deferred status control structure
@@ -1086,7 +1086,7 @@ update_key_auth_status(bool cached, struct key_state *ks)
         ASSERT(auth_plugin < 4 && auth_script < 4 && auth_man < 4);
 
         if (auth_plugin == ACF_FAILED || auth_script == ACF_FAILED
-           || auth_man == ACF_FAILED)
+            || auth_man == ACF_FAILED)
         {
             ks->authenticated = KS_AUTH_FALSE;
             return;
@@ -1298,7 +1298,7 @@ verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
     if (!key_state_gen_auth_control_files(&ks->script_auth, session->opt))
     {
         msg(D_TLS_ERRORS, "TLS Auth Error (%s): "
-                          "could not create deferred auth control file", __func__);
+            "could not create deferred auth control file", __func__);
         return OPENVPN_PLUGIN_FUNC_ERROR;
     }
 
@@ -1307,22 +1307,24 @@ verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
                                         "--auth-user-pass-verify");
     switch (script_ret)
     {
-       case 0:
-           retval = OPENVPN_PLUGIN_FUNC_SUCCESS;
-           break;
-       case 2:
-           retval = OPENVPN_PLUGIN_FUNC_DEFERRED;
-           break;
-       default:
-           retval = OPENVPN_PLUGIN_FUNC_ERROR;
-           break;
+        case 0:
+            retval = OPENVPN_PLUGIN_FUNC_SUCCESS;
+            break;
+
+        case 2:
+            retval = OPENVPN_PLUGIN_FUNC_DEFERRED;
+            break;
+
+        default:
+            retval = OPENVPN_PLUGIN_FUNC_ERROR;
+            break;
     }
     if (retval == OPENVPN_PLUGIN_FUNC_DEFERRED)
     {
         /* Check if we the plugin has written the pending auth control
          * file and send the pending auth to the client */
-        if(!key_state_check_auth_pending_file(&ks->script_auth,
-                                              multi))
+        if (!key_state_check_auth_pending_file(&ks->script_auth,
+                                               multi))
         {
             retval = OPENVPN_PLUGIN_FUNC_ERROR;
             key_state_rm_auth_control_files(&ks->script_auth);
@@ -1378,7 +1380,7 @@ verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
     {
         /* Check if the plugin has written the pending auth control
          * file and send the pending auth to the client */
-        if(!key_state_check_auth_pending_file(&ks->plugin_auth, multi))
+        if (!key_state_check_auth_pending_file(&ks->plugin_auth, multi))
         {
             retval = OPENVPN_PLUGIN_FUNC_ERROR;
             key_state_rm_auth_control_files(&ks->plugin_auth);
@@ -1577,10 +1579,10 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
     }
     /* auth succeeded? */
     bool plugin_ok = plugin_status == OPENVPN_PLUGIN_FUNC_SUCCESS
-        || plugin_status == OPENVPN_PLUGIN_FUNC_DEFERRED;
+                     || plugin_status == OPENVPN_PLUGIN_FUNC_DEFERRED;
 
     bool script_ok =  script_status == OPENVPN_PLUGIN_FUNC_SUCCESS
-        || script_status ==  OPENVPN_PLUGIN_FUNC_DEFERRED;
+                     || script_status ==  OPENVPN_PLUGIN_FUNC_DEFERRED;
 
     if (script_ok && plugin_ok && tls_lock_username(multi, up->username)
 #ifdef ENABLE_MANAGEMENT
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index d39a4f2f..5f0c9638 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -285,7 +285,7 @@ backend_x509_get_username(char *common_name, int cn_len,
         gc_free(&gc);
     }
     else
-#endif
+#endif /* ifdef ENABLE_X509ALTUSERNAME */
     if (FAILURE == extract_x509_field_ssl(X509_get_subject_name(peer_cert),
                                           x509_username_field, common_name, cn_len))
     {
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index a638b3dd..3dd9f0bf 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -497,8 +497,8 @@ socket_defined(const socket_descriptor_t sd)
 /*
  * Do we have CryptoAPI capability?
  */
-#if defined(_WIN32) && defined(ENABLE_CRYPTO_OPENSSL) && \
-        !defined(ENABLE_CRYPTO_WOLFSSL)
+#if defined(_WIN32) && defined(ENABLE_CRYPTO_OPENSSL)    \
+    && !defined(ENABLE_CRYPTO_WOLFSSL)
 #define ENABLE_CRYPTOAPI
 #endif
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 9b6d8d68..394b9364 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -179,7 +179,7 @@ do_dns_domain_service(bool add, const struct tuntap *tt)
      */
 
     msg(D_LOW, "%s dns domain on '%s' (if_index = %d) using service",
-            (add ? "Setting" : "Deleting"), dns.iface.name, dns.iface.index);
+        (add ? "Setting" : "Deleting"), dns.iface.name, dns.iface.index);
     if (!send_msg_iservice(pipe, &dns, sizeof(dns), &ack, "TUN"))
     {
         goto out;
@@ -480,7 +480,7 @@ check_addr_clash(const char *name,
         if (type == DEV_TYPE_TUN)
         {
             const in_addr_t test_netmask = 0xFFFFFF00;
-            const in_addr_t public_net = public & test_netmask;
+            const in_addr_t public_net = public &test_netmask;
             const in_addr_t local_net = local & test_netmask;
             const in_addr_t remote_net = remote_netmask & test_netmask;
 
@@ -508,7 +508,7 @@ check_addr_clash(const char *name,
         }
         else if (type == DEV_TYPE_TAP)
         {
-            const in_addr_t public_network = public & remote_netmask;
+            const in_addr_t public_network = public &remote_netmask;
             const in_addr_t virtual_network = local & remote_netmask;
             if (public_network == virtual_network)
             {
@@ -1156,7 +1156,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
         /* If IPv4 is not enabled, set DNS domain here */
         if (!tt->did_ifconfig_setup)
         {
-           do_dns_domain_service(true, tt);
+            do_dns_domain_service(true, tt);
         }
     }
     else
@@ -2074,7 +2074,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
 /* TUNSETGROUP appeared in 2.6.23 */
 #ifndef TUNSETGROUP
-# define TUNSETGROUP   _IOW('T', 206, int)
+#define TUNSETGROUP   _IOW('T', 206, int)
 #endif
 
 void
@@ -5710,15 +5710,15 @@ write_dhcp_str(struct buffer *buf, const int type, const char *str, bool *error)
  *  0x1D  0x7 openvpn 0x3 net 0x00 0x0A duckduckgo 0x3 com 0x00
  */
 static void
-write_dhcp_search_str(struct buffer *buf, const int type, const char * const *str_array,
+write_dhcp_search_str(struct buffer *buf, const int type, const char *const *str_array,
                       int array_len, bool *error)
 {
-    char         tmp_buf[256];
-    int          i;
-    int          len = 0;
-    int          label_length_pos;
+    char tmp_buf[256];
+    int i;
+    int len = 0;
+    int label_length_pos;
 
-    for (i=0; i < array_len; i++)
+    for (i = 0; i < array_len; i++)
     {
         const char  *ptr = str_array[i];
 
@@ -5729,7 +5729,7 @@ write_dhcp_search_str(struct buffer *buf, const int type, const char * const *st
             return;
         }
         /* Loop over all subdomains separated by a dot and replace the dot
-           with the length of the subdomain */
+         * with the length of the subdomain */
 
         /* label_length_pos points to the byte to be replaced by the length
          * of the following domain label */
@@ -5737,7 +5737,7 @@ write_dhcp_search_str(struct buffer *buf, const int type, const char * const *st
 
         while (true)
         {
-            if (*ptr == '.' || *ptr == '\0' )
+            if (*ptr == '.' || *ptr == '\0')
             {
                 tmp_buf[label_length_pos] = (len-label_length_pos)-1;
                 label_length_pos = len;
@@ -5797,8 +5797,8 @@ build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
     if (o->domain_search_list_len > 0)
     {
         write_dhcp_search_str(buf, 119, o->domain_search_list,
-                                        o->domain_search_list_len,
-                                       &error);
+                              o->domain_search_list_len,
+                              &error);
     }
 
     /* the MS DHCP server option 'Disable Netbios-over-TCP/IP
@@ -6185,9 +6185,9 @@ wintun_register_ring_buffer(struct tuntap *tt, const char *device_guid)
             {
                 case ERROR_ACCESS_DENIED:
                     msg(M_FATAL, "ERROR:  Wintun requires SYSTEM privileges and therefore "
-                                 "should be used with interactive service. If you want to "
-                                 "use openvpn from command line, you need to do SYSTEM "
-                                 "elevation yourself (for example with psexec).");
+                        "should be used with interactive service. If you want to "
+                        "use openvpn from command line, you need to do SYSTEM "
+                        "elevation yourself (for example with psexec).");
                     break;
 
                 case ERROR_ALREADY_INITIALIZED:
@@ -6493,7 +6493,7 @@ next:
 
     /* translate high-level device name into a device instance
      * GUID using the registry */
-    tt->actual_name = string_alloc((const char*)actual_buffer, NULL);
+    tt->actual_name = string_alloc((const char *)actual_buffer, NULL);
 
     msg(M_INFO, "%s device [%s] opened", print_windows_driver(tt->windows_driver), tt->actual_name);
     tt->adapter_index = get_adapter_index(*device_guid);
diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index 16242b00..35cbcf57 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -47,11 +47,11 @@ OSSL_provider_init_fn xkey_provider_init;
  * to sign operation.
  */
 typedef struct {
-   const char *padmode; /**< "pkcs1", "pss" or "none" */
-   const char *mdname;  /**< "SHA256" or "SHA2-256" etc. */
-   const char *saltlen; /**< "digest", "auto" or "max" */
-   const char *keytype; /**< "EC" or "RSA" */
-   const char *op;      /**< "Sign" or "DigestSign" */
+    const char *padmode; /**< "pkcs1", "pss" or "none" */
+    const char *mdname; /**< "SHA256" or "SHA2-256" etc. */
+    const char *saltlen; /**< "digest", "auto" or "max" */
+    const char *keytype; /**< "EC" or "RSA" */
+    const char *op;     /**< "Sign" or "DigestSign" */
 } XKEY_SIGALG;
 
 /**
@@ -79,8 +79,8 @@ typedef struct {
  * structure.
  */
 typedef int (XKEY_EXTERNAL_SIGN_fn)(void *handle, unsigned char *sig, size_t *siglen,
-                                 const unsigned char *tbs, size_t tbslen,
-                                 XKEY_SIGALG sigalg);
+                                    const unsigned char *tbs, size_t tbslen,
+                                    XKEY_SIGALG sigalg);
 /**
  * Signature of private key free function callback used
  * to free the opaque private key handle obtained from the
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index d42ea9ec..ecc7b120 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -101,7 +101,7 @@ xkey_load_management_key(OSSL_LIB_CTX *libctx, EVP_PKEY *pubkey)
      * stored in the key. We use a dummy pointer as we do need a
      * non-NULL value to indicate private key is available.
      */
-    void *dummy = & "dummy";
+    void *dummy = &"dummy";
 
     XKEY_EXTERNAL_SIGN_fn *sign_op = xkey_management_sign;
 
@@ -127,7 +127,8 @@ xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY *pubkey,
         {"handle", OSSL_PARAM_OCTET_PTR, &handle, sizeof(handle), 0},
         {"sign_op", OSSL_PARAM_OCTET_PTR, (void **) &sign_op, sizeof(void *), 0},
         {"free_op", OSSL_PARAM_OCTET_PTR, (void **) &free_op, sizeof(void *), 0},
-        {NULL, 0, NULL, 0, 0}};
+        {NULL, 0, NULL, 0, 0}
+    };
 
     /* Do not use EVP_PKEY_new_from_pkey as that will take keymgmt from pubkey */
     EVP_PKEY_CTX *ctx = EVP_PKEY_CTX_new_from_name(libctx, EVP_PKEY_get0_type_name(pubkey), props);
@@ -223,20 +224,21 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
         else
         {
             openvpn_snprintf(alg_str, sizeof(alg_str), "%s,hashalg=%s",
-                            "RSA_PKCS1_PADDING", alg.mdname);
+                             "RSA_PKCS1_PADDING", alg.mdname);
         }
     }
     else if (!strcmp(alg.padmode, "none") && (flags & MF_EXTERNAL_KEY_NOPADDING)
-             &&!strcmp(alg.op, "Sign")) /* NO_PADDING requires digested data */
+             && !strcmp(alg.op, "Sign")) /* NO_PADDING requires digested data */
     {
         strncpynt(alg_str, "RSA_NO_PADDING", sizeof(alg_str));
     }
     else if (!strcmp(alg.padmode, "pss") && (flags & MF_EXTERNAL_KEY_PSSPAD))
     {
         openvpn_snprintf(alg_str, sizeof(alg_str), "%s,hashalg=%s,saltlen=%s",
-                       "RSA_PKCS1_PSS_PADDING", alg.mdname,alg.saltlen);
+                         "RSA_PKCS1_PSS_PADDING", alg.mdname,alg.saltlen);
     }
-    else {
+    else
+    {
         msg(M_NONFATAL, "RSA padding mode not supported by management-client <%s>",
             alg.padmode);
         return 0;
@@ -312,17 +314,17 @@ encode_pkcs1(unsigned char *enc, size_t *enc_len, const char *mdname,
     const unsigned char sha224[] = {0x30, 0x2d, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86, 0x48,
                                     0x01, 0x65, 0x03, 0x04, 0x02, 0x04, 0x05, 0x00, 0x04, 0x1c};
     const unsigned char sha512_224[] = {0x30, 0x2d, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86, 0x48,
-                                    0x01, 0x65, 0x03, 0x04, 0x02, 0x05, 0x05, 0x00, 0x04, 0x1c};
+                                        0x01, 0x65, 0x03, 0x04, 0x02, 0x05, 0x05, 0x00, 0x04, 0x1c};
     const unsigned char sha512_256[] = {0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86, 0x48,
-                                    0x01, 0x65, 0x03, 0x04, 0x02, 0x06, 0x05, 0x00, 0x04, 0x20};
+                                        0x01, 0x65, 0x03, 0x04, 0x02, 0x06, 0x05, 0x00, 0x04, 0x20};
 
     typedef struct {
-       const int nid;
-       const unsigned char *header;
-       size_t sz;
+        const int nid;
+        const unsigned char *header;
+        size_t sz;
     } DIG_INFO;
 
-#define MAKE_DI(x) {NID_##x, x, sizeof(x)}
+#define MAKE_DI(x) {NID_ ## x, x, sizeof(x)}
 
     DIG_INFO dinfo[] = {MAKE_DI(sha1), MAKE_DI(sha256), MAKE_DI(sha384),
                         MAKE_DI(sha512), MAKE_DI(sha224), MAKE_DI(sha512_224),
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index 3640faea..46e57e0f 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -54,10 +54,10 @@ typedef struct
 
 /* helper to print debug messages */
 #define xkey_dmsg(f, ...) \
-        do {                                                        \
-              dmsg(f|M_NOLF, "xkey_provider: In %s: ", __func__);    \
-              dmsg(f|M_NOPREFIX, __VA_ARGS__);                      \
-           } while(0)
+    do {                                                        \
+        dmsg(f|M_NOLF, "xkey_provider: In %s: ", __func__);    \
+        dmsg(f|M_NOPREFIX, __VA_ARGS__);                      \
+    } while(0)
 
 typedef enum
 {
@@ -262,7 +262,7 @@ keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[], const ch
     EVP_PKEY_CTX *ctx = EVP_PKEY_CTX_new_from_name(key->prov->libctx, name, NULL);
     if (!ctx
         || (EVP_PKEY_fromdata_init(ctx) != 1)
-        || (EVP_PKEY_fromdata(ctx, &pkey, selection_pub, (OSSL_PARAM*) params) !=1))
+        || (EVP_PKEY_fromdata(ctx, &pkey, selection_pub, (OSSL_PARAM *) params) !=1))
     {
         msg(M_WARN, "Error: keymgmt_import failed for key type <%s>", name);
         if (pkey)
@@ -282,7 +282,7 @@ keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[], const ch
     {
         /* create private key */
         pkey = NULL;
-        if (EVP_PKEY_fromdata(ctx, &pkey, selection, (OSSL_PARAM*) params) == 1)
+        if (EVP_PKEY_fromdata(ctx, &pkey, selection, (OSSL_PARAM *) params) == 1)
         {
             key->handle = pkey;
             key->free = (XKEY_PRIVKEY_FREE_fn *) EVP_PKEY_free;
@@ -324,7 +324,7 @@ keymgmt_import_types(int selection)
 
     if (selection & OSSL_KEYMGMT_SELECT_PUBLIC_KEY)
     {
-       return key_types;
+        return key_types;
     }
     return NULL;
 }
@@ -557,34 +557,34 @@ ec_keymgmt_name(int id)
 }
 
 static const OSSL_DISPATCH rsa_keymgmt_functions[] = {
-    {OSSL_FUNC_KEYMGMT_NEW, (void (*)(void)) keymgmt_new},
-    {OSSL_FUNC_KEYMGMT_FREE, (void (*)(void)) keymgmt_free},
-    {OSSL_FUNC_KEYMGMT_LOAD, (void (*)(void)) keymgmt_load},
-    {OSSL_FUNC_KEYMGMT_HAS, (void (*)(void)) keymgmt_has},
-    {OSSL_FUNC_KEYMGMT_MATCH, (void (*)(void)) keymgmt_match},
-    {OSSL_FUNC_KEYMGMT_IMPORT, (void (*)(void)) rsa_keymgmt_import},
-    {OSSL_FUNC_KEYMGMT_IMPORT_TYPES, (void (*)(void)) keymgmt_import_types},
-    {OSSL_FUNC_KEYMGMT_GETTABLE_PARAMS, (void (*) (void)) keymgmt_gettable_params},
-    {OSSL_FUNC_KEYMGMT_GET_PARAMS, (void (*) (void)) keymgmt_get_params},
-    {OSSL_FUNC_KEYMGMT_SET_PARAMS, (void (*) (void)) keymgmt_set_params},
-    {OSSL_FUNC_KEYMGMT_SETTABLE_PARAMS, (void (*) (void)) keymgmt_gettable_params}, /* same as gettable */
-    {OSSL_FUNC_KEYMGMT_QUERY_OPERATION_NAME, (void (*)(void)) rsa_keymgmt_name},
+    {OSSL_FUNC_KEYMGMT_NEW, (void (*)(void))keymgmt_new},
+    {OSSL_FUNC_KEYMGMT_FREE, (void (*)(void))keymgmt_free},
+    {OSSL_FUNC_KEYMGMT_LOAD, (void (*)(void))keymgmt_load},
+    {OSSL_FUNC_KEYMGMT_HAS, (void (*)(void))keymgmt_has},
+    {OSSL_FUNC_KEYMGMT_MATCH, (void (*)(void))keymgmt_match},
+    {OSSL_FUNC_KEYMGMT_IMPORT, (void (*)(void))rsa_keymgmt_import},
+    {OSSL_FUNC_KEYMGMT_IMPORT_TYPES, (void (*)(void))keymgmt_import_types},
+    {OSSL_FUNC_KEYMGMT_GETTABLE_PARAMS, (void (*)(void))keymgmt_gettable_params},
+    {OSSL_FUNC_KEYMGMT_GET_PARAMS, (void (*)(void))keymgmt_get_params},
+    {OSSL_FUNC_KEYMGMT_SET_PARAMS, (void (*)(void))keymgmt_set_params},
+    {OSSL_FUNC_KEYMGMT_SETTABLE_PARAMS, (void (*)(void))keymgmt_gettable_params},   /* same as gettable */
+    {OSSL_FUNC_KEYMGMT_QUERY_OPERATION_NAME, (void (*)(void))rsa_keymgmt_name},
     {0, NULL }
 };
 
 static const OSSL_DISPATCH ec_keymgmt_functions[] = {
-    {OSSL_FUNC_KEYMGMT_NEW, (void (*)(void)) keymgmt_new},
-    {OSSL_FUNC_KEYMGMT_FREE, (void (*)(void)) keymgmt_free},
-    {OSSL_FUNC_KEYMGMT_LOAD, (void (*)(void)) keymgmt_load},
-    {OSSL_FUNC_KEYMGMT_HAS, (void (*)(void)) keymgmt_has},
-    {OSSL_FUNC_KEYMGMT_MATCH, (void (*)(void)) keymgmt_match},
-    {OSSL_FUNC_KEYMGMT_IMPORT, (void (*)(void)) ec_keymgmt_import},
-    {OSSL_FUNC_KEYMGMT_IMPORT_TYPES, (void (*)(void)) keymgmt_import_types},
-    {OSSL_FUNC_KEYMGMT_GETTABLE_PARAMS, (void (*) (void)) keymgmt_gettable_params},
-    {OSSL_FUNC_KEYMGMT_GET_PARAMS, (void (*) (void)) keymgmt_get_params},
-    {OSSL_FUNC_KEYMGMT_SET_PARAMS, (void (*) (void)) keymgmt_set_params},
-    {OSSL_FUNC_KEYMGMT_SETTABLE_PARAMS, (void (*) (void)) keymgmt_gettable_params}, /* same as gettable */
-    {OSSL_FUNC_KEYMGMT_QUERY_OPERATION_NAME, (void (*)(void)) ec_keymgmt_name},
+    {OSSL_FUNC_KEYMGMT_NEW, (void (*)(void))keymgmt_new},
+    {OSSL_FUNC_KEYMGMT_FREE, (void (*)(void))keymgmt_free},
+    {OSSL_FUNC_KEYMGMT_LOAD, (void (*)(void))keymgmt_load},
+    {OSSL_FUNC_KEYMGMT_HAS, (void (*)(void))keymgmt_has},
+    {OSSL_FUNC_KEYMGMT_MATCH, (void (*)(void))keymgmt_match},
+    {OSSL_FUNC_KEYMGMT_IMPORT, (void (*)(void))ec_keymgmt_import},
+    {OSSL_FUNC_KEYMGMT_IMPORT_TYPES, (void (*)(void))keymgmt_import_types},
+    {OSSL_FUNC_KEYMGMT_GETTABLE_PARAMS, (void (*)(void))keymgmt_gettable_params},
+    {OSSL_FUNC_KEYMGMT_GET_PARAMS, (void (*)(void))keymgmt_get_params},
+    {OSSL_FUNC_KEYMGMT_SET_PARAMS, (void (*)(void))keymgmt_set_params},
+    {OSSL_FUNC_KEYMGMT_SETTABLE_PARAMS, (void (*)(void))keymgmt_gettable_params},   /* same as gettable */
+    {OSSL_FUNC_KEYMGMT_QUERY_OPERATION_NAME, (void (*)(void))ec_keymgmt_name},
     {0, NULL }
 };
 
@@ -619,8 +619,8 @@ typedef struct
     XKEY_SIGALG sigalg;
 } XKEY_SIGNATURE_CTX;
 
-static const XKEY_SIGALG default_sigalg = { .mdname="MD5-SHA1", .saltlen="digest",
-                                            .padmode="pkcs1", .keytype = "RSA"};
+static const XKEY_SIGALG default_sigalg = { .mdname = "MD5-SHA1", .saltlen = "digest",
+                                            .padmode = "pkcs1", .keytype = "RSA"};
 
 const struct {
     int nid;
@@ -1055,18 +1055,18 @@ xkey_native_sign(XKEY_KEYDATA *key, unsigned char *sig, size_t *siglen,
 }
 
 static const OSSL_DISPATCH signature_functions[] = {
-    {OSSL_FUNC_SIGNATURE_NEWCTX, (void (*)(void)) signature_newctx},
-    {OSSL_FUNC_SIGNATURE_FREECTX, (void (*)(void)) signature_freectx},
-    {OSSL_FUNC_SIGNATURE_SIGN_INIT, (void (*)(void)) signature_sign_init},
-    {OSSL_FUNC_SIGNATURE_SIGN, (void (*)(void)) signature_sign},
-    {OSSL_FUNC_SIGNATURE_DIGEST_VERIFY_INIT, (void (*)(void)) signature_digest_verify_init},
-    {OSSL_FUNC_SIGNATURE_DIGEST_VERIFY, (void (*)(void)) signature_digest_verify},
-    {OSSL_FUNC_SIGNATURE_DIGEST_SIGN_INIT, (void (*)(void)) signature_digest_sign_init},
-    {OSSL_FUNC_SIGNATURE_DIGEST_SIGN, (void (*)(void)) signature_digest_sign},
-    {OSSL_FUNC_SIGNATURE_SET_CTX_PARAMS, (void (*)(void)) signature_set_ctx_params},
-    {OSSL_FUNC_SIGNATURE_SETTABLE_CTX_PARAMS, (void (*)(void)) signature_settable_ctx_params},
-    {OSSL_FUNC_SIGNATURE_GET_CTX_PARAMS, (void (*)(void)) signature_get_ctx_params},
-    {OSSL_FUNC_SIGNATURE_GETTABLE_CTX_PARAMS, (void (*)(void)) signature_gettable_ctx_params},
+    {OSSL_FUNC_SIGNATURE_NEWCTX, (void (*)(void))signature_newctx},
+    {OSSL_FUNC_SIGNATURE_FREECTX, (void (*)(void))signature_freectx},
+    {OSSL_FUNC_SIGNATURE_SIGN_INIT, (void (*)(void))signature_sign_init},
+    {OSSL_FUNC_SIGNATURE_SIGN, (void (*)(void))signature_sign},
+    {OSSL_FUNC_SIGNATURE_DIGEST_VERIFY_INIT, (void (*)(void))signature_digest_verify_init},
+    {OSSL_FUNC_SIGNATURE_DIGEST_VERIFY, (void (*)(void))signature_digest_verify},
+    {OSSL_FUNC_SIGNATURE_DIGEST_SIGN_INIT, (void (*)(void))signature_digest_sign_init},
+    {OSSL_FUNC_SIGNATURE_DIGEST_SIGN, (void (*)(void))signature_digest_sign},
+    {OSSL_FUNC_SIGNATURE_SET_CTX_PARAMS, (void (*)(void))signature_set_ctx_params},
+    {OSSL_FUNC_SIGNATURE_SETTABLE_CTX_PARAMS, (void (*)(void))signature_settable_ctx_params},
+    {OSSL_FUNC_SIGNATURE_GET_CTX_PARAMS, (void (*)(void))signature_get_ctx_params},
+    {OSSL_FUNC_SIGNATURE_GETTABLE_CTX_PARAMS, (void (*)(void))signature_gettable_ctx_params},
     {0, NULL }
 };
 
@@ -1148,10 +1148,10 @@ teardown(void *provctx)
 }
 
 static const OSSL_DISPATCH dispatch_table[] = {
-    {OSSL_FUNC_PROVIDER_GETTABLE_PARAMS, (void (*)(void)) gettable_params},
-    {OSSL_FUNC_PROVIDER_GET_PARAMS, (void (*)(void)) get_params},
-    {OSSL_FUNC_PROVIDER_QUERY_OPERATION, (void (*)(void)) query_operation},
-    {OSSL_FUNC_PROVIDER_TEARDOWN, (void (*)(void)) teardown},
+    {OSSL_FUNC_PROVIDER_GETTABLE_PARAMS, (void (*)(void))gettable_params},
+    {OSSL_FUNC_PROVIDER_GET_PARAMS, (void (*)(void))get_params},
+    {OSSL_FUNC_PROVIDER_QUERY_OPERATION, (void (*)(void))query_operation},
+    {OSSL_FUNC_PROVIDER_TEARDOWN, (void (*)(void))teardown},
     {0, NULL}
 };
 
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index a2d2d3f4..ec059706 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -52,10 +52,10 @@ extern DWORD openvpnmsica_thread_data_idx;
  * Set MSI session handle in thread local storage.
  */
 #define OPENVPNMSICA_SAVE_MSI_SESSION(hInstall) \
-{ \
-    struct openvpnmsica_thread_data *s = (struct openvpnmsica_thread_data *)TlsGetValue(openvpnmsica_thread_data_idx); \
-    s->hInstall = (hInstall); \
-}
+    { \
+        struct openvpnmsica_thread_data *s = (struct openvpnmsica_thread_data *)TlsGetValue(openvpnmsica_thread_data_idx); \
+        s->hInstall = (hInstall); \
+    }
 
 
 /*
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 972d7a96..f9406120 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -111,7 +111,7 @@ GetOpenvpnSettings(settings_t *s)
     }
 
     openvpn_swprintf(default_value, _countof(default_value), TEXT("%ls\\bin\\openvpn.exe"),
-                      install_path);
+                     install_path);
     error = GetRegString(key, TEXT("exe_path"), s->exe_path, sizeof(s->exe_path), default_value);
     if (error != ERROR_SUCCESS)
     {
@@ -260,8 +260,8 @@ MsgToEventLog(DWORD flags, LPCTSTR format, ...)
     if (hEventSource != NULL)
     {
         openvpn_swprintf(msg[0], _countof(msg[0]),
-                          TEXT("%ls%ls%ls: %ls"), APPNAME, service_instance,
-                          (flags & MSG_FLAGS_ERROR) ? TEXT(" error") : TEXT(""), err_msg);
+                         TEXT("%ls%ls%ls: %ls"), APPNAME, service_instance,
+                         (flags & MSG_FLAGS_ERROR) ? TEXT(" error") : TEXT(""), err_msg);
 
         va_start(arglist, format);
         openvpn_vswprintf(msg[1], _countof(msg[1]), format, arglist);
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 38d9dcc5..5b396e01 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -382,8 +382,8 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options, WCHAR *
     if (!argv)
     {
         openvpn_swprintf(errmsg, capacity,
-	                 L"Cannot validate options: CommandLineToArgvW failed with error = 0x%08x",
-	                 GetLastError());
+                         L"Cannot validate options: CommandLineToArgvW failed with error = 0x%08x",
+                         GetLastError());
         goto out;
     }
 
@@ -564,19 +564,19 @@ InterfaceLuid(const char *iface_name, PNET_LUID luid)
 static DWORD
 ConvertInterfaceNameToIndex(const wchar_t *ifname, NET_IFINDEX *index)
 {
-   NET_LUID luid;
-   DWORD err;
-
-   err = ConvertInterfaceAliasToLuid(ifname, &luid);
-   if (err == ERROR_SUCCESS)
-   {
-       err = ConvertInterfaceLuidToIndex(&luid, index);
-   }
-   if (err != ERROR_SUCCESS)
-   {
-       MsgToEventLog(M_ERR, L"Failed to find interface index for <%ls>", ifname);
-   }
-   return err;
+    NET_LUID luid;
+    DWORD err;
+
+    err = ConvertInterfaceAliasToLuid(ifname, &luid);
+    if (err == ERROR_SUCCESS)
+    {
+        err = ConvertInterfaceLuidToIndex(&luid, index);
+    }
+    if (err != ERROR_SUCCESS)
+    {
+        MsgToEventLog(M_ERR, L"Failed to find interface index for <%ls>", ifname);
+    }
+    return err;
 }
 
 static BOOL
@@ -1083,15 +1083,15 @@ wmic_nicconfig_cmd(const wchar_t *action, const NET_IFINDEX if_index,
     /* comma separated list must be enclosed in parenthesis */
     if (data && wcschr(data, L','))
     {
-       fmt = L"wmic nicconfig where (InterfaceIndex=%ld) call %ls (%ls)";
+        fmt = L"wmic nicconfig where (InterfaceIndex=%ld) call %ls (%ls)";
     }
     else
     {
-       fmt = L"wmic nicconfig where (InterfaceIndex=%ld) call %ls \"%ls\"";
+        fmt = L"wmic nicconfig where (InterfaceIndex=%ld) call %ls \"%ls\"";
     }
 
     size_t ncmdline = wcslen(fmt) + 20 + wcslen(action) /* max 20 for ifindex */
-                    + (data ? wcslen(data) + 1 : 1);
+                      + (data ? wcslen(data) + 1 : 1);
     cmdline = malloc(ncmdline*sizeof(wchar_t));
     if (!cmdline)
     {
@@ -1099,7 +1099,7 @@ wmic_nicconfig_cmd(const wchar_t *action, const NET_IFINDEX if_index,
     }
 
     openvpn_swprintf(cmdline, ncmdline, fmt, if_index, action,
-                      data? data : L"");
+                     data ? data : L"");
     err = ExecCommand(argv0, cmdline, timeout);
 
     free(cmdline);
@@ -1139,41 +1139,41 @@ CmpWString(LPVOID item, LPVOID str)
 static DWORD
 SetDNSDomain(const wchar_t *if_name, const char *domain, undo_lists_t *lists)
 {
-   NET_IFINDEX if_index;
-
-   DWORD err  = ConvertInterfaceNameToIndex(if_name, &if_index);
-   if (err != ERROR_SUCCESS)
-   {
-       return err;
-   }
-
-   wchar_t *wdomain = utf8to16(domain); /* utf8 to wide-char */
-   if (!wdomain)
-   {
-       return ERROR_OUTOFMEMORY;
-   }
-
-   /* free undo list if previously set */
-   if (lists)
-   {
-       free(RemoveListItem(&(*lists)[undo_domain], CmpWString, (void *)if_name));
-   }
-
-   err = wmic_nicconfig_cmd(L"SetDNSDomain", if_index, wdomain);
-
-   /* Add to undo list if domain is non-empty */
-   if (err == 0 && wdomain[0] && lists)
-   {
+    NET_IFINDEX if_index;
+
+    DWORD err  = ConvertInterfaceNameToIndex(if_name, &if_index);
+    if (err != ERROR_SUCCESS)
+    {
+        return err;
+    }
+
+    wchar_t *wdomain = utf8to16(domain); /* utf8 to wide-char */
+    if (!wdomain)
+    {
+        return ERROR_OUTOFMEMORY;
+    }
+
+    /* free undo list if previously set */
+    if (lists)
+    {
+        free(RemoveListItem(&(*lists)[undo_domain], CmpWString, (void *)if_name));
+    }
+
+    err = wmic_nicconfig_cmd(L"SetDNSDomain", if_index, wdomain);
+
+    /* Add to undo list if domain is non-empty */
+    if (err == 0 && wdomain[0] && lists)
+    {
         wchar_t *tmp_name = _wcsdup(if_name);
         if (!tmp_name || AddListItem(&(*lists)[undo_domain], tmp_name))
         {
             free(tmp_name);
             err = ERROR_OUTOFMEMORY;
         }
-   }
+    }
 
-   free(wdomain);
-   return err;
+    free(wdomain);
+    return err;
 }
 
 static DWORD
@@ -1314,7 +1314,7 @@ HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
 }
 
 static DWORD
-OvpnDuplicateHandle(HANDLE ovpn_proc, HANDLE orig_handle, HANDLE* new_handle)
+OvpnDuplicateHandle(HANDLE ovpn_proc, HANDLE orig_handle, HANDLE *new_handle)
 {
     DWORD err = ERROR_SUCCESS;
 
@@ -1576,6 +1576,7 @@ Undo(undo_lists_t *lists)
                                              interface_data->metric_v6);
                     }
                     break;
+
                 case _undo_type_max:
                     /* unreachable */
                     break;
@@ -1773,7 +1774,7 @@ RunOpenvpn(LPVOID p)
     }
 
     openvpn_swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
-                      TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service_%lu"), service_instance, GetCurrentThreadId());
+                     TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service_%lu"), service_instance, GetCurrentThreadId());
     ovpn_pipe = CreateNamedPipe(ovpn_pipe_name,
                                 PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,
                                 PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT, 1, 128, 128, 0, NULL);
@@ -1806,7 +1807,7 @@ RunOpenvpn(LPVOID p)
         goto out;
     }
     openvpn_swprintf(cmdline, cmdline_size, L"openvpn %ls --msg-channel %lu",
-                      sud.options, svc_pipe);
+                     sud.options, svc_pipe);
 
     if (!CreateEnvironmentBlock(&user_env, imp_token, FALSE))
     {
diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
index c27878dc..a71f5c69 100644
--- a/src/openvpnserv/service.c
+++ b/src/openvpnserv/service.c
@@ -280,10 +280,10 @@ _tmain(int argc, TCHAR *argv[])
 
                 wprintf(TEXT("\nService run-time parameters:\n"));
                 wprintf(TEXT("-instance interactive <id>\n")
-                         TEXT("   Runs the service as an alternate instance.\n")
-                         TEXT("   The service settings will be loaded from\n")
-                         TEXT("   HKLM\\Software\\" PACKAGE_NAME "<id> registry key, and the service will accept\n")
-                         TEXT("   requests on \\\\.\\pipe\\" PACKAGE "<id>\\service named pipe.\n"));
+                        TEXT("   Runs the service as an alternate instance.\n")
+                        TEXT("   The service settings will be loaded from\n")
+                        TEXT("   HKLM\\Software\\" PACKAGE_NAME "<id> registry key, and the service will accept\n")
+                        TEXT("   requests on \\\\.\\pipe\\" PACKAGE "<id>\\service named pipe.\n"));
 
                 return 0;
             }
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 33492e9c..f893b51f 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -660,9 +660,9 @@ my_conv(int n, const struct pam_message **msg_array,
         if (DEBUG(up->verb))
         {
             plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: my_conv[%d] query='%s' style=%d",
-                    i,
-                    msg->msg ? msg->msg : "NULL",
-                    msg->msg_style);
+                       i,
+                       msg->msg ? msg->msg : "NULL",
+                       msg->msg_style);
         }
 
         if (up->name_value_list && up->name_value_list->len > 0)
@@ -685,9 +685,9 @@ my_conv(int n, const struct pam_message **msg_array,
                     if (DEBUG(up->verb))
                     {
                         plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: name match found, query/match-string ['%s', '%s'] = '%s'",
-                                msg->msg,
-                                match_name,
-                                match_value);
+                                   msg->msg,
+                                   match_name,
+                                   match_value);
                     }
 
                     if (strstr(match_value, "USERNAME"))
@@ -803,8 +803,8 @@ pam_auth(const char *service, const struct user_pass *up)
         if (!ret)
         {
             plugin_log(PLOG_ERR, MODULE, "BACKGROUND: user '%s' failed to authenticate: %s",
-                    up->username,
-                    pam_strerror(pamh, status));
+                       up->username,
+                       pam_strerror(pamh, status));
         }
 
         /* Close PAM */
@@ -958,7 +958,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                     || recv_string(fd, ac_file_name, sizeof(ac_file_name)) == -1)
                 {
                     plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: read error on command channel: code=%d, exiting",
-                            command);
+                               command);
                     goto done;
                 }
 
@@ -966,7 +966,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                 {
 #if 0
                     plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: USER/PASS: %s/%s",
-                            up.username, up.password);
+                               up.username, up.password);
 #else
                     plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: USER: %s", up.username);
 #endif
@@ -1015,7 +1015,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
 
             default:
                 plugin_log(PLOG_ERR, MODULE, "BACKGROUND: unknown command code: code=%d, exiting",
-                        command);
+                           command);
                 goto done;
         }
         plugin_secure_memzero(up.response, sizeof(up.response));
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index b44c6425..df73a965 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -187,8 +187,7 @@ _tmain(int argc, LPCTSTR argv[])
             {
                 szName = argv[++i];
             }
-            else
-            if (_tcsicmp(argv[i], TEXT("--hwid")) == 0)
+            else if (_tcsicmp(argv[i], TEXT("--hwid")) == 0)
             {
                 szHwId = argv[++i];
             }
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 62705dc2..80cbc85c 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -70,15 +70,15 @@ find_function(const WCHAR *libname, const char *funcname, HMODULE *m)
     /* Make sure the dll is loaded from the system32 folder */
     if (!GetSystemDirectoryW(libpath, _countof(libpath)))
     {
-       return NULL;
+        return NULL;
     }
 
     /* +1 for the path seperator '\' */
     const size_t path_length = wcslen(libpath) + 1 + wcslen(libname);
     if (path_length >= _countof(libpath))
     {
-       SetLastError(ERROR_INSUFFICIENT_BUFFER);
-       return NULL;
+        SetLastError(ERROR_INSUFFICIENT_BUFFER);
+        return NULL;
     }
     wcscat_s(libpath, _countof(libpath), L"\\");
     wcscat_s(libpath, _countof(libpath), libname);
@@ -86,14 +86,14 @@ find_function(const WCHAR *libname, const char *funcname, HMODULE *m)
     *m = LoadLibraryW(libpath);
     if (*m == NULL)
     {
-       return NULL;
+        return NULL;
     }
     fptr = GetProcAddress(*m, funcname);
     if (!fptr)
     {
-       FreeLibrary(*m);
-       *m = NULL;
-       return NULL;
+        FreeLibrary(*m);
+        *m = NULL;
+        return NULL;
     }
     return fptr;
 }
@@ -819,10 +819,10 @@ tap_create_adapter(
     if (!DiInstallDevice(hwndParent, hDevInfoList, &devinfo_data, NULL, 0, pbRebootRequired))
 #else
     /* mingw does not resolve DiInstallDevice, so load it at run time. */
-    typedef BOOL (WINAPI *DiInstallDeviceFn) (HWND, HDEVINFO, SP_DEVINFO_DATA *,
-                                                  SP_DRVINFO_DATA *, DWORD, BOOL *);
+    typedef BOOL (WINAPI *DiInstallDeviceFn)(HWND, HDEVINFO, SP_DEVINFO_DATA *,
+                                             SP_DRVINFO_DATA *, DWORD, BOOL *);
     DiInstallDeviceFn installfn
-           = find_function (L"newdev.dll", "DiInstallDevice", &libnewdev);
+        = find_function(L"newdev.dll", "DiInstallDevice", &libnewdev);
 
     if (!installfn)
     {
@@ -1025,13 +1025,13 @@ tap_enable_adapter(
 
 /* stripped version of ExecCommand in interactive.c */
 static DWORD
-ExecCommand(const WCHAR* cmdline)
+ExecCommand(const WCHAR *cmdline)
 {
     DWORD exit_code;
     STARTUPINFOW si;
     PROCESS_INFORMATION pi;
     DWORD proc_flags = CREATE_NO_WINDOW | CREATE_UNICODE_ENVIRONMENT;
-    WCHAR* cmdline_dup = NULL;
+    WCHAR *cmdline_dup = NULL;
 
     ZeroMemory(&si, sizeof(si));
     ZeroMemory(&pi, sizeof(pi));
@@ -1041,7 +1041,7 @@ ExecCommand(const WCHAR* cmdline)
     /* CreateProcess needs a modifiable cmdline: make a copy */
     cmdline_dup = _wcsdup(cmdline);
     if (cmdline_dup && CreateProcessW(NULL, cmdline_dup, NULL, NULL, FALSE,
-        proc_flags, NULL, NULL, &si, &pi))
+                                      proc_flags, NULL, NULL, &si, &pi))
     {
         WaitForSingleObject(pi.hProcess, INFINITE);
         if (!GetExitCodeProcess(pi.hProcess, &exit_code))
@@ -1117,10 +1117,10 @@ tap_set_adapter_name(
     }
 
     /* rename adapter via netsh call */
-    const TCHAR* szFmt = TEXT("netsh interface set interface name=\"%")
+    const TCHAR *szFmt = TEXT("netsh interface set interface name=\"%")
                          TEXT(PRIsLPTSTR) TEXT("\" newname=\"%") TEXT(PRIsLPTSTR) TEXT("\"");
     size_t ncmdline = _tcslen(szFmt) + _tcslen(szOldName) + _tcslen(szName) + 1;
-    WCHAR* szCmdLine = malloc(ncmdline * sizeof(TCHAR));
+    WCHAR *szCmdLine = malloc(ncmdline * sizeof(TCHAR));
     _stprintf_s(szCmdLine, ncmdline, szFmt, szOldName, szName);
 
     free(szOldName);
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index ca170547..83572b82 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -144,7 +144,7 @@ static uint8_t good_prf[32] = {0xd9, 0x8c, 0x85, 0x18, 0xc8, 0x5e, 0x94, 0x69,
                                0xb1, 0x56, 0x7e, 0x4b, 0x4b, 0x14, 0x59, 0xe6,
                                0xa9, 0x04, 0xac, 0x2d, 0xda, 0xb7, 0x2d, 0x67};
 
-static const char* ipsumlorem = "Lorem ipsum dolor sit amet, consectetur "
+static const char *ipsumlorem = "Lorem ipsum dolor sit amet, consectetur "
                                 "adipisici elit, sed eiusmod tempor incidunt "
                                 "ut labore et dolore magna aliqua.";
 
@@ -406,7 +406,7 @@ test_mssfix_mtu_calculation(void **state)
     o.authname = "none";
     init_key_type(&kt, o.ciphername, o.authname, false, false);
 
-    for (int i = 990;i <= 1010;i++)
+    for (int i = 990; i <= 1010; i++)
     {
         /* 992 - 1008 should end up with the same mssfix value all they
          * all result in the same CBC block size/padding and <= 991 and >=1008
@@ -432,7 +432,7 @@ test_mssfix_mtu_calculation(void **state)
     /* Same but with compression added. Compression adds one byte extra to the
      * payload so the payload should be reduced by compared to the no
      * compression calculation before */
-    for (int i = 990;i <= 1010;i++)
+    for (int i = 990; i <= 1010; i++)
     {
         /* 992 - 1008 should end up with the same mssfix value all they
          * all result in the same CBC block size/padding and <= 991 and >=1008
@@ -453,7 +453,7 @@ test_mssfix_mtu_calculation(void **state)
         }
     }
     o.comp.alg = COMP_ALG_UNDEF;
-#endif
+#endif /* ifdef USE_COMP */
 
     /* tls client, auth SHA1, cipher AES-256-GCM */
     o.authname = "SHA1";
@@ -463,7 +463,7 @@ test_mssfix_mtu_calculation(void **state)
     o.use_peer_id = true;
     init_key_type(&kt, o.ciphername, o.authname, true, false);
 
-    for (int i=900;i <= 1200;i++)
+    for (int i = 900; i <= 1200; i++)
     {
         /* For stream ciphers, the value should not be influenced by block
          * sizes or similar but always have the same difference */
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index f6eb4fff..636fc45d 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -43,9 +43,9 @@ test_compat_lzo_string(void **state)
 {
     struct gc_arena gc = gc_new();
 
-    const char* input = "V4,dev-type tun,link-mtu 1457,tun-mtu 1400,proto UDPv4,auth SHA1,keysize 128,key-method 2,tls-server";
+    const char *input = "V4,dev-type tun,link-mtu 1457,tun-mtu 1400,proto UDPv4,auth SHA1,keysize 128,key-method 2,tls-server";
 
-    const char* output = options_string_compat_lzo(input, &gc);
+    const char *output = options_string_compat_lzo(input, &gc);
 
     assert_string_equal(output, "V4,dev-type tun,link-mtu 1458,tun-mtu 1400,proto UDPv4,auth SHA1,keysize 128,key-method 2,tls-server,comp-lzo");
 
@@ -70,7 +70,7 @@ test_compat_lzo_string(void **state)
     assert_string_equal(output, "V4,dev-type tun,link-mtu 1000,tun-mtu 1400,proto UDPv4,auth SHA1,keysize 128,key-method 2,tls-server,comp-lzo");
 
     gc_free(&gc);
-};
+}
 
 const struct CMUnitTest misc_tests[] = {
     cmocka_unit_test(test_compat_lzo_string),
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 6456d26e..18c40362 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -49,7 +49,7 @@ const char *aes_ciphers = "AES-256-GCM:AES-128-GCM";
  * leads to having to include even more unrelated code */
 bool
 key_state_export_keying_material(struct tls_session *session,
-                                 const char* label, size_t label_size,
+                                 const char *label, size_t label_size,
                                  void *ekm, size_t ekm_size)
 {
     ASSERT(0);
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index 7f34df7a..0b0952ee 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -51,39 +51,40 @@ static int mgmt_callback_called;
 static OSSL_PROVIDER *prov[2];
 
 /* public keys for testing -- RSA and EC */
-static const char * const pubkey1 = "-----BEGIN PUBLIC KEY-----\n"
-    "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7GWP6RLCGlvmVioIqYI6\n"
-    "LUR4owA7sJ/nJxBAk+/xzD6gqgSigBsTqeb+gdZwkKjY1N4w2DUA0r5i8Eja/BWN\n"
-    "xMZtC5nxK4MACtMqIwvlzfk130NhFXKtlZj2cyFBXqDdRyeg1ZrUQagcHVcgcReP\n"
-    "9yiePgfO7NUOQk8edEeOR53SFCgnLBQQ9dGWtZN0hO/5BN6NSm/fd6vq0VjTRP5a\n"
-    "BAH/BnqX9/3jV0jh8N9AE59mI1rjVVQ9VDnuAPkS8dLfdC661/CNxt0YWByTIgt1\n"
-    "+qjW4LUvLbnU/rlPhuJ1SBZg+z/JtDBCKfs7syu5WYFqRvNFg7/91Rr/NwxvW/1h\n"
-    "8QIDAQAB\n"
-    "-----END PUBLIC KEY-----\n";
-
-static const char * const pubkey2 = "-----BEGIN PUBLIC KEY-----\n"
-    "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAEO85iXW+HgnUkwlj1DohNVw0GsnGIh1gZ\n"
-    "u95ff1JiUaJIkYNIkZA+hwIPFVH5aJcSCv3SPIeDS2VUAESNKHZJBQ==\n"
-    "-----END PUBLIC KEY-----\n";
+static const char *const pubkey1 = "-----BEGIN PUBLIC KEY-----\n"
+                                   "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7GWP6RLCGlvmVioIqYI6\n"
+                                   "LUR4owA7sJ/nJxBAk+/xzD6gqgSigBsTqeb+gdZwkKjY1N4w2DUA0r5i8Eja/BWN\n"
+                                   "xMZtC5nxK4MACtMqIwvlzfk130NhFXKtlZj2cyFBXqDdRyeg1ZrUQagcHVcgcReP\n"
+                                   "9yiePgfO7NUOQk8edEeOR53SFCgnLBQQ9dGWtZN0hO/5BN6NSm/fd6vq0VjTRP5a\n"
+                                   "BAH/BnqX9/3jV0jh8N9AE59mI1rjVVQ9VDnuAPkS8dLfdC661/CNxt0YWByTIgt1\n"
+                                   "+qjW4LUvLbnU/rlPhuJ1SBZg+z/JtDBCKfs7syu5WYFqRvNFg7/91Rr/NwxvW/1h\n"
+                                   "8QIDAQAB\n"
+                                   "-----END PUBLIC KEY-----\n";
+
+static const char *const pubkey2 = "-----BEGIN PUBLIC KEY-----\n"
+                                   "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAEO85iXW+HgnUkwlj1DohNVw0GsnGIh1gZ\n"
+                                   "u95ff1JiUaJIkYNIkZA+hwIPFVH5aJcSCv3SPIeDS2VUAESNKHZJBQ==\n"
+                                   "-----END PUBLIC KEY-----\n";
 
 static const char *pubkeys[] = {pubkey1, pubkey2};
 
 static const char *prov_name = "ovpn.xkey";
 
-static const char* test_msg = "Lorem ipsum dolor sit amet, consectetur "
+static const char *test_msg = "Lorem ipsum dolor sit amet, consectetur "
                               "adipisici elit, sed eiusmod tempor incidunt "
                               "ut labore et dolore magna aliqua.";
 
-static const char* test_msg_b64 =
+static const char *test_msg_b64 =
     "TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2ljaS"
     "BlbGl0LCBzZWQgZWl1c21vZCB0ZW1wb3IgaW5jaWR1bnQgdXQgbGFib3JlIGV0IGRv"
     "bG9yZSBtYWduYSBhbGlxdWEu";
 
 /* Sha256 digest of test_msg excluding NUL terminator */
-static const uint8_t test_digest[] =
-    {0x77, 0x38, 0x65, 0x00, 0x1e, 0x96, 0x48, 0xc6, 0x57, 0x0b, 0xae,
-     0xc0, 0xb7, 0x96, 0xf9, 0x66, 0x4d, 0x5f, 0xd0, 0xb7, 0xdb, 0xf3,
-     0x3a, 0xbf, 0x02, 0xcc, 0x78, 0x61, 0x83, 0x20, 0x20, 0xee};
+static const uint8_t test_digest[] = {
+    0x77, 0x38, 0x65, 0x00, 0x1e, 0x96, 0x48, 0xc6, 0x57, 0x0b, 0xae,
+    0xc0, 0xb7, 0x96, 0xf9, 0x66, 0x4d, 0x5f, 0xd0, 0xb7, 0xdb, 0xf3,
+    0x3a, 0xbf, 0x02, 0xcc, 0x78, 0x61, 0x83, 0x20, 0x20, 0xee
+};
 
 static const char *test_digest_b64 = "dzhlAB6WSMZXC67At5b5Zk1f0Lfb8zq/Asx4YYMgIO4=";
 
@@ -92,9 +93,10 @@ static const char *test_digest_b64 = "dzhlAB6WSMZXC67At5b5Zk1f0Lfb8zq/Asx4YYMgIO
  * --- the smallest size of the actual signature with the above
  * keys.
  */
-static const uint8_t good_sig[] =
-   {0xd8, 0xa7, 0xd9, 0x81, 0xd8, 0xaa, 0xd8, 0xad, 0x20, 0xd9, 0x8a, 0xd8,
-    0xa7, 0x20, 0xd8, 0xb3, 0xd9, 0x85, 0xd8, 0xb3, 0xd9, 0x85, 0x0};
+static const uint8_t good_sig[] = {
+    0xd8, 0xa7, 0xd9, 0x81, 0xd8, 0xaa, 0xd8, 0xad, 0x20, 0xd9, 0x8a, 0xd8,
+    0xa7, 0x20, 0xd8, 0xb3, 0xd9, 0x85, 0xd8, 0xb3, 0xd9, 0x85, 0x0
+};
 
 static const char *good_sig_b64 = "2KfZgdiq2K0g2YrYpyDYs9mF2LPZhQA=";
 
@@ -155,8 +157,8 @@ management_query_pk_sig(struct management *man, const char *b64_data,
     const char *expected_tbs = test_digest_b64;
     if (strstr(algorithm, "data=message"))
     {
-         expected_tbs = test_msg_b64;
-         assert_non_null(strstr(algorithm, "hashalg=SHA256"));
+        expected_tbs = test_msg_b64;
+        assert_non_null(strstr(algorithm, "hashalg=SHA256"));
     }
     assert_string_equal(b64_data, expected_tbs);
 
@@ -238,14 +240,14 @@ digest_sign(EVP_PKEY *pkey)
     }
 
     /* sign with sig = NULL to get required siglen */
-    assert_int_equal(EVP_DigestSign(mctx, sig, &siglen, (uint8_t*)test_msg, strlen(test_msg)), 1);
+    assert_int_equal(EVP_DigestSign(mctx, sig, &siglen, (uint8_t *)test_msg, strlen(test_msg)), 1);
     assert_true(siglen > 0);
 
     if ((sig = test_calloc(1, siglen)) == NULL)
     {
         fail_msg("Out of memory");
     }
-    assert_int_equal(EVP_DigestSign(mctx, sig, &siglen, (uint8_t*)test_msg, strlen(test_msg)), 1);
+    assert_int_equal(EVP_DigestSign(mctx, sig, &siglen, (uint8_t *)test_msg, strlen(test_msg)), 1);
 
 done:
     if (mctx)
@@ -357,7 +359,7 @@ xkey_provider_test_generic_sign_cb(void **state)
         pubkey = load_pubkey(pubkeys[i]);
         assert_true(pubkey != NULL);
 
-        EVP_PKEY *privkey = xkey_load_generic_key(NULL, (void*)dummy, pubkey, xkey_sign, xkey_free);
+        EVP_PKEY *privkey = xkey_load_generic_key(NULL, (void *)dummy, pubkey, xkey_sign, xkey_free);
         assert_true(privkey != NULL);
 
         xkey_sign_called = 0;
@@ -394,7 +396,7 @@ main(void)
     uninit_test();
     return ret;
 }
-#else
+#else  /* ifdef HAVE_XKEY_PROVIDER */
 int
 main(void)
 {
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 12ea9452..82bb0a26 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -581,7 +581,7 @@ test_tls_crypt_v2_write_client_key_file_metadata(void **state)
     /* Test writing the client key */
     expect_string(__wrap_buffer_write_file, filename, filename);
     expect_memory(__wrap_buffer_write_file, pem, test_client_key_metadata,
-                strlen(test_client_key_metadata));
+                  strlen(test_client_key_metadata));
     will_return(__wrap_buffer_write_file, true);
 
     /* Key generation re-reads the created file as a sanity check */
diff --git a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c b/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
index e80bffbc..34a9a884 100644
--- a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
+++ b/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
@@ -9,7 +9,8 @@
 #include "utils.h"
 
 static void
-pass_any_null_param__returns_null() {
+pass_any_null_param__returns_null()
+{
 
     char DUMMY[] = "DUMMY";
 
@@ -19,7 +20,8 @@ pass_any_null_param__returns_null() {
 }
 
 static void
-pass_any_empty_string__returns_null() {
+pass_any_empty_string__returns_null()
+{
 
     char DUMMY[] = "DUMMY";
     char EMPTY[] = "";
@@ -30,7 +32,8 @@ pass_any_empty_string__returns_null() {
 }
 
 static void
-replace_single_char__one_time__match_is_replaced() {
+replace_single_char__one_time__match_is_replaced()
+{
     char *replaced = searchandreplace("X","X","Y");
 
     assert_non_null(replaced);
@@ -40,7 +43,8 @@ replace_single_char__one_time__match_is_replaced() {
 }
 
 static void
-replace_single_char__multiple_times__match_all_matches_are_replaced() {
+replace_single_char__multiple_times__match_all_matches_are_replaced()
+{
     char *replaced = searchandreplace("XaX","X","Y");
 
     assert_non_null(replaced);
@@ -50,7 +54,8 @@ replace_single_char__multiple_times__match_all_matches_are_replaced() {
 }
 
 static void
-replace_longer_text__multiple_times__match_all_matches_are_replaced() {
+replace_longer_text__multiple_times__match_all_matches_are_replaced()
+{
     char *replaced = searchandreplace("XXaXX","XX","YY");
 
     assert_non_null(replaced);
@@ -60,7 +65,8 @@ replace_longer_text__multiple_times__match_all_matches_are_replaced() {
 }
 
 static void
-pattern_not_found__returns_original() {
+pattern_not_found__returns_original()
+{
     char *replaced = searchandreplace("abc","X","Y");
 
     assert_non_null(replaced);
@@ -71,7 +77,8 @@ pattern_not_found__returns_original() {
 
 
 int
-main(void) {
+main(void)
+{
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(pass_any_null_param__returns_null),
         cmocka_unit_test(pass_any_empty_string__returns_null),
-- 
2.27.0


