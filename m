From: Antonio Quartulli <a@...2181...>
Date: Thu,  7 May 2020 15:36:54 +0200
Message-Id: <20200507133654.15365-1-a@...2181...>
In-Reply-To: <69990cda-fe76-3cf6-e0fd-f94baffe203b@...2181...>
References: <69990cda-fe76-3cf6-e0fd-f94baffe203b@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v10] convert *_inline attributes to bool
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
Cc: Antonio Quartulli <a@...2181...>

Carrying around the INLINE_TAG is not really efficient,
because it requires a strcmp() to be performed every
time we want to understand if the data is stored inline
or not.

Convert all the *_inline attributes to bool to make the
logic easier and checks more efficient.

Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v9:
- rebased on top of latest master
- checked with uncrustify-0.69.0
- adapt test_tls_crypt.c to new inline'd logic


Changes from v8:
- rebased on top of latest master
- changed auth-token secret file inlining logic too (not present before)
- adapted test_tls_crypt.c
- adapted test_auth_token.c


Changes from v7:
- rebased on top of latest master (68e0b9db)


Changes from v6:
- rebased on top of latest master


Changes from v5:
- fix function invocation alignment in options.c:options_postprocess_filechecks()
- fix typ0 in function invocation in options.c:options_postprocess_filechecks()
- fix doxygen comment for function tls_ctx_reload_crl() in ssl.c


Changes from v4:
- remove newline accidentally added in v4


Changes from v3:
- some code style adjustment in options.c:check_inline_file()
- move print_if_inline() from misc.c to crypto.c and rename it to
  print_key_filename()
- make comment of check_file_access_inline() and
  check_file_access_chroot_inline() doxygen compliant
- remove *is_inline argument in check_inline_file() and use its
  return value instead
- move declarations of is_inline to narrower scope in options.c
- move return type of plugin_option_list_add() to its own line


Changes from v2:
- fix indentation in ssl_openssl.c
- do not attempt to push inline'd options
- do not attempt to parse inline'd plugin
- introduce check_file_access_inline() and check_file_access_chroot_inline()
- introduce OPT_P_INLINE to specify when an option is allowed to
  be inline. Options not having this permission will fail to be
  parsed if is_inline is true


Changes from v1:
- remove the INLINE_TAG from the options parsing logic at all. Now a
  boolean variable is passed around
- add print_if_inline() helper function (to misc.c/h) to make sure we
  never print the inline data, but only the INLINE tag. Such function
  checks also for NULL pointers
- make sure print_if_inline() is always used when printing possibly
  inline data
- remove the INLINE_TAG from the options parsing logic at all. Now a
  boolean variable is passed around
- fix alignment error in comment
- remove CHKACC_INLINE from check_file_access() logic: this function
  is now not invoked at all in case of inline data



 src/openvpn/auth_token.c                   |   2 +-
 src/openvpn/auth_token.h                   |   2 +-
 src/openvpn/crypto.c                       |  47 +--
 src/openvpn/crypto.h                       |  25 +-
 src/openvpn/init.c                         |   9 +-
 src/openvpn/misc.c                         |   6 +-
 src/openvpn/misc.h                         |   3 +-
 src/openvpn/options.c                      | 329 +++++++++++----------
 src/openvpn/options.h                      |  32 +-
 src/openvpn/plugin.c                       |   5 +-
 src/openvpn/plugin.h                       |   3 +-
 src/openvpn/push.c                         |   2 +-
 src/openvpn/push.h                         |   3 +-
 src/openvpn/ssl.c                          |   4 +-
 src/openvpn/ssl_backend.h                  |  55 ++--
 src/openvpn/ssl_common.h                   |   2 +-
 src/openvpn/ssl_mbedtls.c                  |  61 ++--
 src/openvpn/ssl_openssl.c                  |  85 +++---
 src/openvpn/tls_crypt.c                    |   8 +-
 src/openvpn/tls_crypt.h                    |  43 +--
 tests/unit_tests/openvpn/test_auth_token.c |   6 +-
 tests/unit_tests/openvpn/test_tls_crypt.c  |   3 +-
 22 files changed, 402 insertions(+), 333 deletions(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 6275299d..d9212ee7 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -135,7 +135,7 @@ auth_token_write_server_key_file(const char *filename)
 
 void
 auth_token_init_secret(struct key_ctx *key_ctx, const char *key_file,
-                       const char *key_inline)
+                       bool key_inline)
 {
     struct key_type kt = auth_token_kt();
 
diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
index 4b014d44..6f34b760 100644
--- a/src/openvpn/auth_token.h
+++ b/src/openvpn/auth_token.h
@@ -74,7 +74,7 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
  */
 void
 auth_token_init_secret(struct key_ctx *key_ctx, const char *key_file,
-                       const char *key_inline);
+                       bool key_inline);
 
 
 /**
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 1678cba8..672aa14a 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1184,27 +1184,38 @@ test_crypto(struct crypto_options *co, struct frame *frame)
     gc_free(&gc);
 }
 
+const char *
+print_key_filename(const char *str, bool is_inline)
+{
+    if (is_inline)
+    {
+        return INLINE_FILE_TAG;
+    }
+
+    return np(str);
+}
+
 void
 crypto_read_openvpn_key(const struct key_type *key_type,
-                        struct key_ctx_bi *ctx, const char *key_file, const char *key_inline,
-                        const int key_direction, const char *key_name, const char *opt_name)
+                        struct key_ctx_bi *ctx, const char *key_file,
+                        bool key_inline, const int key_direction,
+                        const char *key_name, const char *opt_name)
 {
     struct key2 key2;
     struct key_direction_state kds;
+    unsigned int flags = RKF_MUST_SUCCEED;
 
     if (key_inline)
     {
-        read_key_file(&key2, key_inline, RKF_MUST_SUCCEED|RKF_INLINE);
-    }
-    else
-    {
-        read_key_file(&key2, key_file, RKF_MUST_SUCCEED);
+        flags |= RKF_INLINE;
     }
+    read_key_file(&key2, key_file, flags);
 
     if (key2.n != 2)
     {
         msg(M_ERR, "File '%s' does not have OpenVPN Static Key format.  Using "
-            "free-form passphrase file is not supported anymore.", key_file);
+            "free-form passphrase file is not supported anymore.",
+            print_key_filename(key_file, key_inline));
     }
 
     /* check for and fix highly unlikely key problems */
@@ -1238,7 +1249,6 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
     struct buffer in;
     int size;
     uint8_t hex_byte[3] = {0, 0, 0};
-    const char *error_filename = file;
 
     /* parse info */
     const unsigned char *cp;
@@ -1276,7 +1286,6 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
     {
         size = strlen(file) + 1;
         buf_set_read(&in, (const uint8_t *)file, size);
-        error_filename = INLINE_FILE_TAG;
     }
     else /* 'file' is a filename which refers to a file containing the ascii key */
     {
@@ -1372,7 +1381,9 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
                 {
                     msg(M_FATAL,
                         (isprint(c) ? printable_char_fmt : unprintable_char_fmt),
-                        c, line_num, error_filename, count, onekeylen, keylen);
+                        c, line_num,
+                        print_key_filename(file, flags & RKF_INLINE), count,
+                        onekeylen, keylen);
                 }
             }
             ++line_index;
@@ -1393,13 +1404,15 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
         if (!key2->n)
         {
             msg(M_FATAL, "Insufficient key material or header text not found in file '%s' (%d/%d/%d bytes found/min/max)",
-                error_filename, count, onekeylen, keylen);
+                print_key_filename(file, flags & RKF_INLINE), count, onekeylen,
+                keylen);
         }
 
         if (state != PARSE_FINISHED)
         {
             msg(M_FATAL, "Footer text not found in file '%s' (%d/%d/%d bytes found/min/max)",
-                error_filename, count, onekeylen, keylen);
+                print_key_filename(file, flags & RKF_INLINE), count, onekeylen,
+                keylen);
         }
     }
 
@@ -1922,13 +1935,13 @@ generate_ephemeral_key(struct buffer *key, const char *key_name)
 
 bool
 read_pem_key_file(struct buffer *key, const char *pem_name,
-                  const char *key_file, const char *key_inline)
+                  const char *key_file, bool key_inline)
 {
     bool ret = false;
     struct buffer key_pem = { 0 };
     struct gc_arena gc = gc_new();
 
-    if (strcmp(key_file, INLINE_FILE_TAG))
+    if (!key_inline)
     {
         key_pem = buffer_read_from_file(key_file, &gc);
         if (!buf_valid(&key_pem))
@@ -1940,7 +1953,7 @@ read_pem_key_file(struct buffer *key, const char *pem_name,
     }
     else
     {
-        buf_set_read(&key_pem, (const void *)key_inline, strlen(key_inline) + 1);
+        buf_set_read(&key_pem, (const void *)key_file, strlen(key_file) + 1);
     }
 
     if (!crypto_pem_decode(pem_name, key, &key_pem))
@@ -1951,7 +1964,7 @@ read_pem_key_file(struct buffer *key, const char *pem_name,
 
     ret = true;
 cleanup:
-    if (strcmp(key_file, INLINE_FILE_TAG))
+    if (!key_inline)
     {
         buf_clear(&key_pem);
     }
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index dadf0a90..999f643e 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -444,13 +444,15 @@ generate_ephemeral_key(struct buffer *key, const char *pem_name);
  * Read key material from a PEM encoded files into the key structure
  * @param key           the key structure that will hold the key material
  * @param pem_name      the name used in the pem encoding start/end lines
- * @param key_file      name of the file to read
- * @param key_inline    a string holding the data in case of an inline key
+ * @param key_file      name of the file to read or the key itself if
+ *                      key_inline is true
+ * @param key_inline    True if key_file contains an inline key, False
+ *                      otherwise.
  * @return              true if reading into key was successful
  */
 bool
 read_pem_key_file(struct buffer *key, const char *pem_name,
-                  const char *key_file, const char *key_inline);
+                  const char *key_file, bool key_inline);
 
 /* Minimum length of the nonce used by the PRNG */
 #define NONCE_SECRET_LEN_MIN 16
@@ -517,8 +519,9 @@ void key2_print(const struct key2 *k,
                 const char *prefix1);
 
 void crypto_read_openvpn_key(const struct key_type *key_type,
-                             struct key_ctx_bi *ctx, const char *key_file, const char *key_inline,
-                             const int key_direction, const char *key_name, const char *opt_name);
+                             struct key_ctx_bi *ctx, const char *key_file,
+                             bool key_inline, const int key_direction,
+                             const char *key_name, const char *opt_name);
 
 /*
  * Inline functions
@@ -536,4 +539,16 @@ key_ctx_bi_defined(const struct key_ctx_bi *key)
     return key->encrypt.cipher || key->encrypt.hmac || key->decrypt.cipher || key->decrypt.hmac;
 }
 
+/**
+ * To be used when printing a string that may contain inline data.
+ *
+ * If "is_inline" is true, return the inline tag.
+ * If "is_inline" is false and "str" is not NULL, return "str".
+ * Return the constant string "[NULL]" otherwise.
+ *
+ * @param str       the original string to return when is_inline is false
+ * @param is_inline true when str contains an inline data of some sort
+ */
+const char *print_key_filename(const char *str, bool is_inline);
+
 #endif /* CRYPTO_H */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b3096dc8..3cb73fd4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1108,7 +1108,7 @@ do_genkey(const struct options *options)
 
         tls_crypt_v2_write_client_key_file(options->genkey_filename,
                                            options->genkey_extra_data, options->tls_crypt_v2_file,
-                                           options->tls_crypt_v2_inline);
+                                           options->tls_crypt_v2_file_inline);
         return true;
     }
     else if (options->genkey && options->genkey_type == GENKEY_AUTH_TOKEN)
@@ -2633,7 +2633,8 @@ do_init_tls_wrap_key(struct context *c)
     {
         tls_crypt_init_key(&c->c1.ks.tls_wrap_key,
                            options->ce.tls_crypt_file,
-                           options->ce.tls_crypt_inline, options->tls_server);
+                           options->ce.tls_crypt_file_inline,
+			   options->tls_server);
     }
 
     /* tls-crypt with client-specific keys (--tls-crypt-v2) */
@@ -2643,14 +2644,14 @@ do_init_tls_wrap_key(struct context *c)
         {
             tls_crypt_v2_init_server_key(&c->c1.ks.tls_crypt_v2_server_key,
                                          true, options->ce.tls_crypt_v2_file,
-                                         options->ce.tls_crypt_v2_inline);
+                                         options->ce.tls_crypt_v2_file_inline);
         }
         else
         {
             tls_crypt_v2_init_client_key(&c->c1.ks.tls_wrap_key,
                                          &c->c1.ks.tls_crypt_v2_wkc,
                                          options->ce.tls_crypt_v2_file,
-                                         options->ce.tls_crypt_v2_inline);
+                                         options->ce.tls_crypt_v2_file_inline);
         }
     }
 
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 9d739d57..b4eff3b4 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -611,12 +611,12 @@ make_arg_copy(char **p, struct gc_arena *gc)
 }
 
 const char **
-make_extended_arg_array(char **p, struct gc_arena *gc)
+make_extended_arg_array(char **p, bool is_inline, struct gc_arena *gc)
 {
     const int argc = string_array_len((const char **)p);
-    if (!strcmp(p[0], INLINE_FILE_TAG) && argc == 2)
+    if (is_inline)
     {
-        return make_inline_array(p[1], gc);
+        return make_inline_array(p[0], gc);
     }
     else if (argc == 0)
     {
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 2605c6d2..a3095c1f 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -50,7 +50,8 @@ void save_inetd_socket_descriptor(void);
 
 const char **make_arg_array(const char *first, const char *parms, struct gc_arena *gc);
 
-const char **make_extended_arg_array(char **p, struct gc_arena *gc);
+const char **make_extended_arg_array(char **p, bool is_inline,
+                                     struct gc_arena *gc);
 
 /* prepend a random prefix to hostname */
 const char *hostname_randomize(const char *hostname, struct gc_arena *gc);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a8394c6c..7dd0b729 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2932,10 +2932,10 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
         ce->key_direction = o->key_direction;
 
         ce->tls_crypt_file = o->tls_crypt_file;
-        ce->tls_crypt_inline = o->tls_crypt_inline;
+        ce->tls_crypt_file_inline = o->tls_crypt_file_inline;
 
         ce->tls_crypt_v2_file = o->tls_crypt_v2_file;
-        ce->tls_crypt_v2_inline = o->tls_crypt_v2_inline;
+        ce->tls_crypt_v2_file_inline = o->tls_crypt_v2_file_inline;
     }
 
     /* pre-cache tls-auth/crypt key file if persist-key was specified and keys
@@ -2952,11 +2952,10 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
                     ce->tls_auth_file);
             }
 
-            ce->tls_auth_file = INLINE_FILE_TAG;
-            ce->tls_auth_file_inline = (char *)in.data;
+            ce->tls_auth_file = (char *)in.data;
         }
 
-        if (ce->tls_crypt_file && !ce->tls_crypt_inline)
+        if (ce->tls_crypt_file && !ce->tls_crypt_file_inline)
         {
             struct buffer in = buffer_read_from_file(ce->tls_crypt_file, &o->gc);
             if (!buf_valid(&in))
@@ -2965,8 +2964,7 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
                     ce->tls_crypt_file);
             }
 
-            ce->tls_crypt_file = INLINE_FILE_TAG;
-            ce->tls_crypt_inline = (char *)in.data;
+            ce->tls_crypt_file = (char *)in.data;
         }
     }
 }
@@ -3188,9 +3186,8 @@ options_postprocess_mutate(struct options *o)
 #define CHKACC_FILE (1<<0)       /** Check for a file/directory presence */
 #define CHKACC_DIRPATH (1<<1)    /** Check for directory presence where a file should reside */
 #define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is it writable? */
-#define CHKACC_INLINE (1<<3)     /** File is present if it's an inline file */
-#define CHKACC_ACPTSTDIN (1<<4)  /** If filename is stdin, it's allowed and "exists" */
-#define CHKACC_PRIVATE (1<<5)    /** Warn if this (private) file is group/others accessible */
+#define CHKACC_ACPTSTDIN (1<<3)  /** If filename is stdin, it's allowed and "exists" */
+#define CHKACC_PRIVATE (1<<4)    /** Warn if this (private) file is group/others accessible */
 
 static bool
 check_file_access(const int type, const char *file, const int mode, const char *opt)
@@ -3203,12 +3200,6 @@ check_file_access(const int type, const char *file, const int mode, const char *
         return false;
     }
 
-    /* If this may be an inline file, and the proper inline "filename" is set - no issues */
-    if ((type & CHKACC_INLINE) && streq(file, INLINE_FILE_TAG) )
-    {
-        return false;
-    }
-
     /* If stdin is allowed and the file name is 'stdin', then do no
      * further checks as stdin is always available
      */
@@ -3313,6 +3304,38 @@ check_file_access_chroot(const char *chroot, const int type, const char *file, c
     return ret;
 }
 
+/**
+ * A wrapper for check_file_access_chroot() that returns false immediately if
+ * the file is inline (and therefore there is no access to check)
+ */
+static bool
+check_file_access_chroot_inline(bool is_inline, const char *chroot,
+                                const int type, const char *file,
+                                const int mode, const char *opt)
+{
+    if (is_inline)
+    {
+        return false;
+    }
+
+    return check_file_access_chroot(chroot, type, file, mode, opt);
+}
+
+/**
+ * A wrapper for check_file_access() that returns false immediately if the file
+ * is inline (and therefore there is no access to check)
+ */
+static bool
+check_file_access_inline(bool is_inline, const int type, const char *file,
+                         const int mode, const char *opt)
+{
+    if (is_inline)
+    {
+        return false;
+    }
+
+    return check_file_access(type, file, mode, opt);
+}
 
 /*
  * Verifies that the path in the "command" that comes after certain script options (e.g., --up) is a
@@ -3377,31 +3400,47 @@ options_postprocess_filechecks(struct options *options)
     bool errs = false;
 
     /* ** SSL/TLS/crypto related files ** */
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->dh_file, R_OK, "--dh");
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->ca_file, R_OK, "--ca");
-    errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->ca_path, R_OK, "--capath");
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->cert_file, R_OK, "--cert");
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->extra_certs_file, R_OK,
-                              "--extra-certs");
-#ifdef ENABLE_MANAGEMENT
+    errs |= check_file_access_inline(options->dh_file_inline, CHKACC_FILE,
+                                     options->dh_file, R_OK, "--dh");
+
+    errs |= check_file_access_inline(options->ca_file_inline, CHKACC_FILE,
+                                     options->ca_file, R_OK, "--ca");
+
+    errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE,
+                                     options->ca_path, R_OK, "--capath");
+
+    errs |= check_file_access_inline(options->cert_file_inline, CHKACC_FILE,
+                                         options->cert_file, R_OK, "--cert");
+
+    errs |= check_file_access_inline(options->extra_certs_file, CHKACC_FILE,
+                                     options->extra_certs_file, R_OK,
+                                     "--extra-certs");
+
+#ifdef ENABLE_MANAGMENT
     if (!(options->management_flags & MF_EXTERNAL_KEY))
 #endif
     {
-        errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                                  options->priv_key_file, R_OK, "--key");
+        errs |= check_file_access_inline(options->priv_key_file_inline,
+                                         CHKACC_FILE|CHKACC_PRIVATE,
+                                         options->priv_key_file, R_OK, "--key");
     }
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                              options->pkcs12_file, R_OK, "--pkcs12");
+
+    errs |= check_file_access_inline(options->pkcs12_file_inline,
+                                     CHKACC_FILE|CHKACC_PRIVATE,
+                                     options->pkcs12_file, R_OK, "--pkcs12");
 
     if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
     {
-        errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->crl_file, R_OK|X_OK,
+        errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE,
+                                         options->crl_file, R_OK|X_OK,
                                          "--crl-verify directory");
     }
     else
     {
-        errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE|CHKACC_INLINE,
-                                         options->crl_file, R_OK, "--crl-verify");
+        errs |= check_file_access_chroot_inline(options->crl_file_inline,
+                                                options->chroot_dir,
+                                                CHKACC_FILE, options->crl_file,
+                                                R_OK, "--crl-verify");
     }
 
     ASSERT(options->connection_list);
@@ -3409,19 +3448,24 @@ options_postprocess_filechecks(struct options *options)
     {
         struct connection_entry *ce = options->connection_list->array[i];
 
-        errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                                  ce->tls_auth_file, R_OK, "--tls-auth");
-
-        errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                                  ce->tls_crypt_file, R_OK, "--tls-crypt");
-
-        errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                                  ce->tls_crypt_v2_file, R_OK,
-                                  "--tls-crypt-v2");
-    }
-
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                              options->shared_secret_file, R_OK, "--secret");
+        errs |= check_file_access_inline(ce->tls_auth_file_inline,
+                                         CHKACC_FILE|CHKACC_PRIVATE,
+                                         ce->tls_auth_file, R_OK,
+                                         "--tls-auth");
+        errs |= check_file_access_inline(ce->tls_crypt_file_inline,
+                                         CHKACC_FILE|CHKACC_PRIVATE,
+                                         ce->tls_crypt_file, R_OK,
+                                         "--tls-crypt");
+        errs |= check_file_access_inline(ce->tls_crypt_v2_file_inline,
+					 CHKACC_FILE|CHKACC_PRIVATE,
+					 ce->tls_crypt_v2_file, R_OK,
+					 "--tls-crypt-v2");
+    }
+
+    errs |= check_file_access_inline(options->shared_secret_file_inline,
+                                     CHKACC_FILE|CHKACC_PRIVATE,
+                                     options->shared_secret_file, R_OK,
+                                     "--secret");
 
     errs |= check_file_access(CHKACC_DIRPATH|CHKACC_FILEXSTWR,
                               options->packet_id_file, R_OK|W_OK, "--replay-persist");
@@ -4616,25 +4660,26 @@ read_inline_file(struct in_src *is, const char *close_tag, struct gc_arena *gc)
 static bool
 check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
 {
-    bool ret = false;
+    bool is_inline = false;
+
     if (p[0] && !p[1])
     {
         char *arg = p[0];
         if (arg[0] == '<' && arg[strlen(arg)-1] == '>')
         {
             struct buffer close_tag;
-            arg[strlen(arg)-1] = '\0';
-            p[0] = string_alloc(arg+1, gc);
-            p[1] = string_alloc(INLINE_FILE_TAG, gc);
+
+            arg[strlen(arg) - 1] = '\0';
+            p[0] = string_alloc(arg + 1, gc);
             close_tag = alloc_buf(strlen(p[0]) + 4);
             buf_printf(&close_tag, "</%s>", p[0]);
-            p[2] = read_inline_file(is, BSTR(&close_tag), gc);
-            p[3] = NULL;
+            p[1] = read_inline_file(is, BSTR(&close_tag), gc);
+            p[2] = NULL;
             free_buf(&close_tag);
-            ret = true;
+            is_inline = true;
         }
     }
-    return ret;
+    return is_inline;
 }
 
 static bool
@@ -4647,7 +4692,8 @@ check_inline_file_via_fp(FILE *fp, char *p[], struct gc_arena *gc)
 }
 
 static bool
-check_inline_file_via_buf(struct buffer *multiline, char *p[], struct gc_arena *gc)
+check_inline_file_via_buf(struct buffer *multiline, char *p[],
+                          struct gc_arena *gc)
 {
     struct in_src is;
     is.type = IS_TYPE_BUF;
@@ -4658,6 +4704,7 @@ check_inline_file_via_buf(struct buffer *multiline, char *p[], struct gc_arena *
 static void
 add_option(struct options *options,
            char *p[],
+           bool is_inline,
            const char *file,
            int line,
            const int level,
@@ -4715,9 +4762,13 @@ read_config_file(struct options *options,
                 }
                 if (parse_line(line + offset, p, SIZE(p)-1, file, line_num, msglevel, &options->gc))
                 {
+                    bool is_inline;
+
                     bypass_doubledash(&p[0]);
-                    check_inline_file_via_fp(fp, p, &options->gc);
-                    add_option(options, p, file, line_num, level, msglevel, permission_mask, option_types_found, es);
+                    is_inline = check_inline_file_via_fp(fp, p, &options->gc);
+                    add_option(options, p, is_inline, file, line_num, level,
+                               msglevel, permission_mask, option_types_found,
+                               es);
                 }
             }
             if (fp != stdin)
@@ -4760,9 +4811,12 @@ read_config_string(const char *prefix,
         ++line_num;
         if (parse_line(line, p, SIZE(p)-1, prefix, line_num, msglevel, &options->gc))
         {
+            bool is_inline;
+
             bypass_doubledash(&p[0]);
-            check_inline_file_via_buf(&multiline, p, &options->gc);
-            add_option(options, p, prefix, line_num, 0, msglevel, permission_mask, option_types_found, es);
+            is_inline = check_inline_file_via_buf(&multiline, p, &options->gc);
+            add_option(options, p, is_inline, prefix, line_num, 0, msglevel,
+                       permission_mask, option_types_found, es);
         }
         CLEAR(p);
     }
@@ -4793,7 +4847,8 @@ parse_argv(struct options *options,
         CLEAR(p);
         p[0] = "config";
         p[1] = argv[1];
-        add_option(options, p, NULL, 0, 0, msglevel, permission_mask, option_types_found, es);
+        add_option(options, p, false, NULL, 0, 0, msglevel, permission_mask,
+                   option_types_found, es);
     }
     else
     {
@@ -4827,7 +4882,8 @@ parse_argv(struct options *options,
                     }
                 }
             }
-            add_option(options, p, NULL, 0, 0, msglevel, permission_mask, option_types_found, es);
+            add_option(options, p, false, NULL, 0, 0, msglevel, permission_mask,
+                       option_types_found, es);
             i += j - 1;
         }
     }
@@ -4898,7 +4954,8 @@ apply_push_options(struct options *options,
         }
         if (parse_line(line, p, SIZE(p)-1, file, line_num, msglevel, &options->gc))
         {
-            add_option(options, p, file, line_num, 0, msglevel, permission_mask, option_types_found, es);
+            add_option(options, p, false, file, line_num, 0, msglevel,
+                       permission_mask, option_types_found, es);
         }
     }
     return true;
@@ -4937,7 +4994,13 @@ options_string_import(struct options *options,
 
 #if P2MP
 
-#define VERIFY_PERMISSION(mask) { if (!verify_permission(p[0], file, line, (mask), permission_mask, option_types_found, msglevel, options)) {goto err;}}
+#define VERIFY_PERMISSION(mask) {                                            \
+    if (!verify_permission(p[0], file, line, (mask), permission_mask,        \
+                           option_types_found, msglevel, options, is_inline))\
+    {                                                                        \
+        goto err;                                                            \
+    }                                                                        \
+}
 
 static bool
 verify_permission(const char *name,
@@ -4947,7 +5010,8 @@ verify_permission(const char *name,
                   const unsigned int allowed,
                   unsigned int *found,
                   const int msglevel,
-                  struct options *options)
+                  struct options *options,
+                  bool is_inline)
 {
     if (!(type & allowed))
     {
@@ -4955,6 +5019,13 @@ verify_permission(const char *name,
         return false;
     }
 
+    if (is_inline && !(type & OPT_P_INLINE))
+    {
+        msg(msglevel, "option '%s' is not expected to be inline (%s:%d)", name,
+            file, line);
+        return false;
+    }
+
     if (found)
     {
         *found |= type;
@@ -5061,10 +5132,10 @@ set_user_script(struct options *options,
 #endif
 }
 
-
 static void
 add_option(struct options *options,
            char *p[],
+           bool is_inline,
            const char *file,
            int line,
            const int level,
@@ -5477,15 +5548,16 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "connection") && p[1] && !p[3])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
+        if (is_inline)
         {
             struct options sub;
             struct connection_entry *e;
 
             init_options(&sub, true);
             sub.ce = options->ce;
-            read_config_string("[CONNECTION-OPTIONS]", &sub, p[2], msglevel, OPT_P_CONNECTION, option_types_found, es);
+            read_config_string("[CONNECTION-OPTIONS]", &sub, p[1], msglevel,
+                               OPT_P_CONNECTION, option_types_found, es);
             if (!sub.ce.remote)
             {
                 msg(msglevel, "Each 'connection' block must contain exactly one 'remote' directive");
@@ -6166,17 +6238,10 @@ add_option(struct options *options,
     else if (streq(p[0], "http-proxy-user-pass") && p[1])
     {
         struct http_proxy_options *ho;
-        VERIFY_PERMISSION(OPT_P_GENERAL);
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
         ho = init_http_proxy_options_once(&options->ce.http_proxy_options, &options->gc);
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            ho->auth_file = p[2];
-            ho->inline_creds = true;
-        }
-        else
-        {
-            ho->auth_file = p[1];
-        }
+        ho->auth_file = p[1];
+        ho->inline_creds = is_inline;
     }
     else if (streq(p[0], "http-proxy-retry") || streq(p[0], "socks-proxy-retry"))
     {
@@ -7679,12 +7744,10 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "secret") && p[1] && !p[3])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            options->shared_secret_file_inline = p[2];
-        }
-        else if (p[2])
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
+        options->shared_secret_file = p[1];
+        options->shared_secret_file_inline = is_inline;
+        if (!is_inline && p[2])
         {
             int key_direction;
 
@@ -7698,7 +7761,6 @@ add_option(struct options *options,
                 goto err;
             }
         }
-        options->shared_secret_file = p[1];
     }
     else if (streq(p[0], "genkey") && !p[4])
     {
@@ -7914,14 +7976,11 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->tls_client = true;
     }
-    else if (streq(p[0], "ca") && p[1] && ((streq(p[1], INLINE_FILE_TAG) && p[2]) || !p[2]) && !p[3])
+    else if (streq(p[0], "ca") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
         options->ca_file = p[1];
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            options->ca_file_inline = p[2];
-        }
+        options->ca_file_inline = is_inline;
     }
 #ifndef ENABLE_CRYPTO_MBEDTLS
     else if (streq(p[0], "capath") && p[1] && !p[2])
@@ -7930,32 +7989,23 @@ add_option(struct options *options,
         options->ca_path = p[1];
     }
 #endif /* ENABLE_CRYPTO_MBEDTLS */
-    else if (streq(p[0], "dh") && p[1] && ((streq(p[1], INLINE_FILE_TAG) && p[2]) || !p[2]) && !p[3])
+    else if (streq(p[0], "dh") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
         options->dh_file = p[1];
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            options->dh_file_inline = p[2];
-        }
+        options->dh_file_inline = is_inline;
     }
-    else if (streq(p[0], "cert") && p[1] && ((streq(p[1], INLINE_FILE_TAG) && p[2]) || !p[2]) && !p[3])
+    else if (streq(p[0], "cert") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
         options->cert_file = p[1];
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            options->cert_file_inline = p[2];
-        }
+        options->cert_file_inline = is_inline;
     }
-    else if (streq(p[0], "extra-certs") && p[1] && ((streq(p[1], INLINE_FILE_TAG) && p[2]) || !p[2]) && !p[3])
+    else if (streq(p[0], "extra-certs") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
         options->extra_certs_file = p[1];
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            options->extra_certs_file_inline = p[2];
-        }
+        options->extra_certs_file_inline = is_inline;
     }
     else if (streq(p[0], "verify-hash") && p[1] && !p[3])
     {
@@ -7984,14 +8034,11 @@ add_option(struct options *options,
         options->cryptoapi_cert = p[1];
     }
 #endif
-    else if (streq(p[0], "key") && p[1] && ((streq(p[1], INLINE_FILE_TAG) && p[2]) || !p[2]) && !p[3])
+    else if (streq(p[0], "key") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
         options->priv_key_file = p[1];
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            options->priv_key_file_inline = p[2];
-        }
+        options->priv_key_file_inline = is_inline;
     }
     else if (streq(p[0], "tls-version-min") && p[1] && !p[3])
     {
@@ -8022,14 +8069,11 @@ add_option(struct options *options,
         options->ssl_flags |= (ver << SSLF_TLS_VERSION_MAX_SHIFT);
     }
 #ifndef ENABLE_CRYPTO_MBEDTLS
-    else if (streq(p[0], "pkcs12") && p[1] && ((streq(p[1], INLINE_FILE_TAG) && p[2]) || !p[2]) && !p[3])
+    else if (streq(p[0], "pkcs12") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
         options->pkcs12_file = p[1];
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            options->pkcs12_file_inline = p[2];
-        }
+        options->pkcs12_file_inline = is_inline;
     }
 #endif /* ENABLE_CRYPTO_MBEDTLS */
     else if (streq(p[0], "askpass") && !p[2])
@@ -8091,18 +8135,15 @@ add_option(struct options *options,
         options->cipher_list_tls13 = p[1];
     }
     else if (streq(p[0], "crl-verify") && p[1] && ((p[2] && streq(p[2], "dir"))
-                                                   || (p[2] && streq(p[1], INLINE_FILE_TAG) ) || !p[2]) && !p[3])
+                                                   || !p[2]))
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
         if (p[2] && streq(p[2], "dir"))
         {
             options->ssl_flags |= SSLF_CRL_VERIFY_DIR;
         }
         options->crl_file = p[1];
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            options->crl_file_inline = p[2];
-        }
+        options->crl_file_inline = is_inline;
     }
     else if (streq(p[0], "tls-verify") && p[1])
     {
@@ -8258,15 +8299,14 @@ add_option(struct options *options,
     {
         int key_direction = -1;
 
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION|OPT_P_INLINE);
 
         if (permission_mask & OPT_P_GENERAL)
         {
-            if (streq(p[1], INLINE_FILE_TAG) && p[2])
-            {
-                options->tls_auth_file_inline = p[2];
-            }
-            else if (p[2])
+            options->tls_auth_file = p[1];
+            options->tls_auth_file_inline = is_inline;
+
+            if (!is_inline && p[2])
             {
                 key_direction = ascii2keydirection(msglevel, p[2]);
                 if (key_direction < 0)
@@ -8275,16 +8315,15 @@ add_option(struct options *options,
                 }
                 options->key_direction = key_direction;
             }
-            options->tls_auth_file = p[1];
+
         }
         else if (permission_mask & OPT_P_CONNECTION)
         {
+            options->ce.tls_auth_file = p[1];
+            options->ce.tls_auth_file_inline = is_inline;
             options->ce.key_direction = KEY_DIRECTION_BIDIRECTIONAL;
-            if (streq(p[1], INLINE_FILE_TAG) && p[2])
-            {
-                options->ce.tls_auth_file_inline = p[2];
-            }
-            else if (p[2])
+
+            if (!is_inline && p[2])
             {
                 key_direction = ascii2keydirection(msglevel, p[2]);
                 if (key_direction < 0)
@@ -8293,28 +8332,20 @@ add_option(struct options *options,
                 }
                 options->ce.key_direction = key_direction;
             }
-            options->ce.tls_auth_file = p[1];
         }
     }
     else if (streq(p[0], "tls-crypt") && p[1] && !p[3])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION|OPT_P_INLINE);
         if (permission_mask & OPT_P_GENERAL)
         {
-            if (streq(p[1], INLINE_FILE_TAG) && p[2])
-            {
-                options->tls_crypt_inline = p[2];
-            }
             options->tls_crypt_file = p[1];
+            options->tls_crypt_file_inline = is_inline;
         }
         else if (permission_mask & OPT_P_CONNECTION)
         {
-            if (streq(p[1], INLINE_FILE_TAG) && p[2])
-            {
-                options->ce.tls_crypt_inline = p[2];
-            }
             options->ce.tls_crypt_file = p[1];
-
+            options->ce.tls_crypt_file_inline = is_inline;
         }
     }
     else if (streq(p[0], "tls-crypt-v2") && p[1] && !p[3])
@@ -8324,7 +8355,7 @@ add_option(struct options *options,
         {
             if (streq(p[1], INLINE_FILE_TAG) && p[2])
             {
-                options->tls_crypt_v2_inline = p[2];
+                options->tls_crypt_v2_file_inline = p[2];
             }
             options->tls_crypt_v2_file = p[1];
         }
@@ -8332,7 +8363,7 @@ add_option(struct options *options,
         {
             if (streq(p[1], INLINE_FILE_TAG) && p[2])
             {
-                options->ce.tls_crypt_v2_inline = p[2];
+                options->ce.tls_crypt_v2_file_inline = p[2];
             }
             options->ce.tls_crypt_v2_file = p[1];
         }
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 4c1737e1..96e302bf 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -133,17 +133,17 @@ struct connection_entry
 
     /* Shared secret used for TLS control channel authentication */
     const char *tls_auth_file;
-    const char *tls_auth_file_inline;
+    bool tls_auth_file_inline;
     int key_direction;
 
     /* Shared secret used for TLS control channel authenticated encryption */
     const char *tls_crypt_file;
-    const char *tls_crypt_inline;
+    bool tls_crypt_file_inline;
 
     /* Client-specific secret or server key used for TLS control channel
      * authenticated encryption v2 */
     const char *tls_crypt_v2_file;
-    const char *tls_crypt_v2_inline;
+    bool tls_crypt_v2_file_inline;
 };
 
 struct remote_entry
@@ -480,7 +480,7 @@ struct options
     bool auth_token_call_auth;
     int auth_token_lifetime;
     const char *auth_token_secret_file;
-    const char *auth_token_secret_file_inline;
+    bool auth_token_secret_file_inline;
 
 #if PORT_SHARE
     char *port_share_host;
@@ -505,7 +505,7 @@ struct options
 
     /* Cipher parms */
     const char *shared_secret_file;
-    const char *shared_secret_file_inline;
+    bool shared_secret_file_inline;
     int key_direction;
     const char *ciphername;
     bool ncp_enabled;
@@ -529,12 +529,18 @@ struct options
     bool tls_server;
     bool tls_client;
     const char *ca_file;
+    bool ca_file_inline;
     const char *ca_path;
     const char *dh_file;
+    bool dh_file_inline;
     const char *cert_file;
+    bool cert_file_inline;
     const char *extra_certs_file;
+    bool extra_certs_file_inline;
     const char *priv_key_file;
+    bool priv_key_file_inline;
     const char *pkcs12_file;
+    bool pkcs12_file_inline;
     const char *cipher_list;
     const char *cipher_list_tls13;
     const char *tls_cert_profile;
@@ -544,14 +550,7 @@ struct options
     const char *verify_x509_name;
     const char *tls_export_cert;
     const char *crl_file;
-
-    const char *ca_file_inline;
-    const char *cert_file_inline;
-    const char *extra_certs_file_inline;
-    const char *crl_file_inline;
-    char *priv_key_file_inline;
-    const char *dh_file_inline;
-    const char *pkcs12_file_inline; /* contains the base64 encoding of pkcs12 file */
+    bool crl_file_inline;
 
     int ns_cert_type; /* set to 0, NS_CERT_CHECK_SERVER, or NS_CERT_CHECK_CLIENT */
     unsigned remote_cert_ku[MAX_PARMS];
@@ -600,16 +599,16 @@ struct options
 
     /* Shared secret used for TLS control channel authentication */
     const char *tls_auth_file;
-    const char *tls_auth_file_inline;
+    bool tls_auth_file_inline;
 
     /* Shared secret used for TLS control channel authenticated encryption */
     const char *tls_crypt_file;
-    const char *tls_crypt_inline;
+    bool tls_crypt_file_inline;
 
     /* Client-specific secret or server key used for TLS control channel
      * authenticated encryption v2 */
     const char *tls_crypt_v2_file;
-    const char *tls_crypt_v2_inline;
+    bool tls_crypt_v2_file_inline;
 
     const char *tls_crypt_v2_metadata;
 
@@ -691,6 +690,7 @@ struct options
 #define OPT_P_SOCKFLAGS       (1<<26)
 #define OPT_P_CONNECTION      (1<<27)
 #define OPT_P_PEER_ID         (1<<28)
+#define OPT_P_INLINE          (1<<29)
 
 #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))
 
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index dba9d335..4de1d6b7 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -161,12 +161,13 @@ plugin_option_list_new(struct gc_arena *gc)
 }
 
 bool
-plugin_option_list_add(struct plugin_option_list *list, char **p, struct gc_arena *gc)
+plugin_option_list_add(struct plugin_option_list *list, char **p,
+                       struct gc_arena *gc)
 {
     if (list->n < MAX_PLUGINS)
     {
         struct plugin_option *o = &list->plugins[list->n++];
-        o->argv = make_extended_arg_array(p, gc);
+        o->argv = make_extended_arg_array(p, false, gc);
         if (o->argv[0])
         {
             o->so_pathname = o->argv[0];
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 791d476b..bf4d71bb 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -106,7 +106,8 @@ struct plugin_return
 
 struct plugin_option_list *plugin_option_list_new(struct gc_arena *gc);
 
-bool plugin_option_list_add(struct plugin_option_list *list, char **p, struct gc_arena *gc);
+bool plugin_option_list_add(struct plugin_option_list *list, char **p,
+                            struct gc_arena *gc);
 
 #ifndef ENABLE_SMALL
 void plugin_option_list_print(const struct plugin_option_list *list, int msglevel);
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 39a906d4..ab0cdf6a 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -650,7 +650,7 @@ clone_push_list(struct options *o)
 void
 push_options(struct options *o, char **p, int msglevel, struct gc_arena *gc)
 {
-    const char **argv = make_extended_arg_array(p, gc);
+    const char **argv = make_extended_arg_array(p, false, gc);
     char *opt = print_argv(argv, gc, 0);
     push_option(o, opt, msglevel);
 }
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 070782dd..6cabc44d 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -57,7 +57,8 @@ void clone_push_list(struct options *o);
 
 void push_option(struct options *o, const char *opt, int msglevel);
 
-void push_options(struct options *o, char **p, int msglevel, struct gc_arena *gc);
+void push_options(struct options *o, char **p, int msglevel,
+                  struct gc_arena *gc);
 
 void push_reset(struct options *o);
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 80e0d5ac..88b4cc7d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -558,7 +558,7 @@ tls_version_parse(const char *vstr, const char *extra)
  */
 static void
 tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
-                   const char *crl_file_inline)
+                   bool crl_file_inline)
 {
     /* if something goes wrong with stat(), we'll store 0 as mtime */
     platform_stat_t crl_stat = {0};
@@ -665,7 +665,7 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
     {
         char *cert = management_query_cert(management,
                                            options->management_certificate);
-        tls_ctx_load_cert_file(new_ctx, INLINE_FILE_TAG, cert);
+        tls_ctx_load_cert_file(new_ctx, cert, true);
         free(cert);
     }
 #endif
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 1c244ece..a1770bd4 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -213,11 +213,12 @@ void tls_ctx_check_cert_time(const struct tls_root_ctx *ctx);
  *
  * @param ctx                   TLS context to use
  * @param dh_file               The file name to load the parameters from, or
- *                              "[[INLINE]]" in the case of inline files.
- * @param dh_file_inline        A string containing the parameters
+ *                              a string containing the parameters in the case
+ *                              of inline files.
+ * @param dh_file_inline        True if dh_file is an inline file.
  */
 void tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
-                            const char *dh_file_inline);
+                            bool dh_file_inline);
 
 /**
  * Load Elliptic Curve Parameters, and load them into the library-specific
@@ -235,15 +236,15 @@ void tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
  *
  * @param ctx                   TLS context to use
  * @param pkcs12_file           The file name to load the information from, or
- *                              "[[INLINE]]" in the case of inline files.
- * @param pkcs12_file_inline    A string containing the information
+ *                              a string containing the information in the case
+ *                              of inline files.
+ * @param pkcs12_file_inline    True if pkcs12_file is an inline file.
  *
  * @return                      1 if an error occurred, 0 if parsing was
  *                              successful.
  */
 int tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
-                        const char *pkcs12_file_inline, bool load_ca_file
-                        );
+                        bool pkcs12_file_inline, bool load_ca_file);
 
 /**
  * Use Windows cryptoapi for key and cert, and add to library-specific TLS
@@ -263,25 +264,27 @@ void tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert
  *
  * @param ctx                   TLS context to use
  * @param cert_file             The file name to load the certificate from, or
- *                              "[[INLINE]]" in the case of inline files.
- * @param cert_file_inline      A string containing the certificate
+ *                              a string containing the certificate in the case
+ *                              of inline files.
+ * @param cert_file_inline      True if cert_file is an inline file.
  */
 void tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
-                            const char *cert_file_inline);
+                            bool cert_file_inline);
 
 /**
  * Load private key file into the given TLS context.
  *
  * @param ctx                   TLS context to use
  * @param priv_key_file         The file name to load the private key from, or
- *                              "[[INLINE]]" in the case of inline files.
- * @param priv_key_file_inline  A string containing the private key
+ *                              a string containing the private key in the case
+ *                              of inline files.
+ * @param priv_key_file_inline  True if priv_key_file is an inline file
  *
  * @return                      1 if an error occurred, 0 if parsing was
  *                              successful.
  */
 int tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
-                           const char *priv_key_file_inline);
+                           bool priv_key_file_inline);
 
 #ifdef ENABLE_MANAGEMENT
 
@@ -304,13 +307,13 @@ int tls_ctx_use_management_external_key(struct tls_root_ctx *ctx);
  *
  * @param ctx                   TLS context to use
  * @param ca_file               The file name to load the CAs from, or
- *                              "[[INLINE]]" in the case of inline files.
- * @param ca_file_inline        A string containing the CAs
+ *                              a string containing the CAs in the case of
+ *                              inline files.
+ * @param ca_file_inline        True if ca_file is an inline file
  * @param ca_path               The path to load the CAs from
  */
 void tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
-                     const char *ca_file_inline, const char *ca_path, bool tls_server
-                     );
+                     bool ca_file_inline, const char *ca_path, bool tls_server);
 
 /**
  * Load extra certificate authority certificates from the given file or path.
@@ -320,12 +323,14 @@ void tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
  *
  * @param ctx                           TLS context to use
  * @param extra_certs_file              The file name to load the certs from, or
- *                                      "[[INLINE]]" in the case of inline files.
- * @param extra_certs_file_inline       A string containing the certs
+ *                                      a string containing the certs in the
+ *                                      case of inline files.
+ * @param extra_certs_file_inline       True if extra_certs_file is an inline
+ *                                      file.
  */
-void tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
-                              const char *extra_certs_file_inline
-                              );
+void tls_ctx_load_extra_certs(struct tls_root_ctx *ctx,
+                              const char *extra_certs_file,
+                              bool extra_certs_file_inline);
 
 #ifdef ENABLE_CRYPTO_MBEDTLS
 /**
@@ -368,11 +373,11 @@ void key_state_ssl_free(struct key_state_ssl *ks_ssl);
  *
  * @param ssl_ctx       The TLS context to use when reloading the CRL
  * @param crl_file      The file name to load the CRL from, or
- *                      "[[INLINE]]" in the case of inline files.
- * @param crl_inline    A string containing the CRL
+ *                      an array containing the inline CRL.
+ * @param crl_inline    True if crl_file is an inline CRL.
  */
 void backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx,
-                                const char *crl_file, const char *crl_inline);
+                                const char *crl_file, bool crl_inline);
 
 /**
  * Keying Material Exporters [RFC 5705] allows additional keying material to be
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 998ea3c4..f48990d6 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -269,7 +269,7 @@ struct tls_options
     int verify_x509_type;
     const char *verify_x509_name;
     const char *crl_file;
-    const char *crl_file_inline;
+    bool crl_file_inline;
     int ns_cert_type;
     unsigned remote_cert_ku[MAX_PARMS];
     const char *remote_cert_eku;
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 605c659e..27fe7c57 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -365,13 +365,13 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 
 void
 tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
-                       const char *dh_inline
-                       )
+                       bool dh_inline)
 {
-    if (!strcmp(dh_file, INLINE_FILE_TAG) && dh_inline)
+    if (dh_inline)
     {
         if (!mbed_ok(mbedtls_dhm_parse_dhm(ctx->dhm_ctx,
-                                           (const unsigned char *) dh_inline, strlen(dh_inline)+1)))
+                                           (const unsigned char *) dh_file,
+                                           strlen(dh_file) + 1)))
         {
             msg(M_FATAL, "Cannot read inline DH parameters");
         }
@@ -401,9 +401,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
 
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
-                    const char *pkcs12_file_inline,
-                    bool load_ca_file
-                    )
+                    bool pkcs12_file_inline, bool load_ca_file)
 {
     msg(M_FATAL, "PKCS #12 files not yet supported for mbed TLS.");
     return 0;
@@ -419,8 +417,7 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
 
 void
 tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
-                       const char *cert_inline
-                       )
+                       bool cert_inline)
 {
     ASSERT(NULL != ctx);
 
@@ -429,10 +426,11 @@ tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
         ALLOC_OBJ_CLEAR(ctx->crt_chain, mbedtls_x509_crt);
     }
 
-    if (!strcmp(cert_file, INLINE_FILE_TAG) && cert_inline)
+    if (cert_inline)
     {
         if (!mbed_ok(mbedtls_x509_crt_parse(ctx->crt_chain,
-                                            (const unsigned char *) cert_inline, strlen(cert_inline)+1)))
+                                            (const unsigned char *)cert_file,
+                                            strlen(cert_file) + 1)))
         {
             msg(M_FATAL, "Cannot load inline certificate file");
         }
@@ -448,8 +446,7 @@ tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
 
 int
 tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
-                       const char *priv_key_inline
-                       )
+                       bool priv_key_inline)
 {
     int status;
     ASSERT(NULL != ctx);
@@ -459,19 +456,20 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
         ALLOC_OBJ_CLEAR(ctx->priv_key, mbedtls_pk_context);
     }
 
-    if (!strcmp(priv_key_file, INLINE_FILE_TAG) && priv_key_inline)
+    if (priv_key_inline)
     {
         status = mbedtls_pk_parse_key(ctx->priv_key,
-                                      (const unsigned char *) priv_key_inline, strlen(priv_key_inline)+1,
-                                      NULL, 0);
+                                      (const unsigned char *) priv_key_file,
+                                      strlen(priv_key_file) + 1, NULL, 0);
 
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED == status)
         {
             char passbuf[512] = {0};
             pem_password_callback(passbuf, 512, 0, NULL);
             status = mbedtls_pk_parse_key(ctx->priv_key,
-                                          (const unsigned char *) priv_key_inline,
-                                          strlen(priv_key_inline)+1, (unsigned char *) passbuf,
+                                          (const unsigned char *) priv_key_file,
+                                          strlen(priv_key_file) + 1,
+                                          (unsigned char *) passbuf,
                                           strlen(passbuf));
         }
     }
@@ -493,7 +491,8 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
             management_auth_failure(management, UP_TYPE_PRIVATE_KEY, NULL);
         }
 #endif
-        msg(M_WARN, "Cannot load private key file %s", priv_key_file);
+        msg(M_WARN, "Cannot load private key file %s",
+            print_key_filename(priv_key_file, priv_key_inline));
         return 1;
     }
 
@@ -713,18 +712,18 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
 
 void
 tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
-                const char *ca_inline, const char *ca_path, bool tls_server
-                )
+                bool ca_inline, const char *ca_path, bool tls_server)
 {
     if (ca_path)
     {
         msg(M_FATAL, "ERROR: mbed TLS cannot handle the capath directive");
     }
 
-    if (ca_file && !strcmp(ca_file, INLINE_FILE_TAG) && ca_inline)
+    if (ca_file && ca_inline)
     {
         if (!mbed_ok(mbedtls_x509_crt_parse(ctx->ca_chain,
-                                            (const unsigned char *) ca_inline, strlen(ca_inline)+1)))
+                                            (const unsigned char *) ca_file,
+                                            strlen(ca_file) + 1)))
         {
             msg(M_FATAL, "Cannot load inline CA certificates");
         }
@@ -741,8 +740,7 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
 
 void
 tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
-                         const char *extra_certs_inline
-                         )
+                         bool extra_certs_inline)
 {
     ASSERT(NULL != ctx);
 
@@ -751,11 +749,11 @@ tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
         ALLOC_OBJ_CLEAR(ctx->crt_chain, mbedtls_x509_crt);
     }
 
-    if (!strcmp(extra_certs_file, INLINE_FILE_TAG) && extra_certs_inline)
+    if (extra_certs_inline)
     {
         if (!mbed_ok(mbedtls_x509_crt_parse(ctx->crt_chain,
-                                            (const unsigned char *) extra_certs_inline,
-                                            strlen(extra_certs_inline)+1)))
+                                            (const unsigned char *) extra_certs_file,
+                                            strlen(extra_certs_file) + 1)))
         {
             msg(M_FATAL, "Cannot load inline extra-certs file");
         }
@@ -983,7 +981,7 @@ tls_version_to_major_minor(int tls_ver, int *major, int *minor)
 
 void
 backend_tls_ctx_reload_crl(struct tls_root_ctx *ctx, const char *crl_file,
-                           const char *crl_inline)
+                           bool crl_inline)
 {
     ASSERT(crl_file);
 
@@ -993,10 +991,11 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ctx, const char *crl_file,
     }
     mbedtls_x509_crl_free(ctx->crl);
 
-    if (!strcmp(crl_file, INLINE_FILE_TAG) && crl_inline)
+    if (crl_inline)
     {
         if (!mbed_ok(mbedtls_x509_crl_parse(ctx->crl,
-                                            (const unsigned char *)crl_inline, strlen(crl_inline)+1)))
+                                            (const unsigned char *)crl_file,
+                                            strlen(crl_file) + 1)))
         {
             msg(M_WARN, "CRL: cannot parse inline CRL");
             goto err;
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 555cbbdf..6ebb90b4 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -620,17 +620,16 @@ cleanup:
 
 void
 tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
-                       const char *dh_file_inline
-                       )
+                       bool dh_file_inline)
 {
     DH *dh;
     BIO *bio;
 
     ASSERT(NULL != ctx);
 
-    if (!strcmp(dh_file, INLINE_FILE_TAG) && dh_file_inline)
+    if (dh_file_inline)
     {
-        if (!(bio = BIO_new_mem_buf((char *)dh_file_inline, -1)))
+        if (!(bio = BIO_new_mem_buf((char *)dh_file, -1)))
         {
             crypto_msg(M_FATAL, "Cannot open memory BIO for inline DH parameters");
         }
@@ -649,7 +648,8 @@ tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
 
     if (!dh)
     {
-        crypto_msg(M_FATAL, "Cannot load DH parameters from %s", dh_file);
+        crypto_msg(M_FATAL, "Cannot load DH parameters from %s",
+                   print_key_filename(dh_file, dh_file_inline));
     }
     if (!SSL_CTX_set_tmp_dh(ctx->ctx, dh))
     {
@@ -753,9 +753,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
 
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
-                    const char *pkcs12_file_inline,
-                    bool load_ca_file
-                    )
+                    bool pkcs12_file_inline, bool load_ca_file)
 {
     FILE *fp;
     EVP_PKEY *pkey;
@@ -767,11 +765,11 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
 
     ASSERT(NULL != ctx);
 
-    if (!strcmp(pkcs12_file, INLINE_FILE_TAG) && pkcs12_file_inline)
+    if (pkcs12_file_inline)
     {
         BIO *b64 = BIO_new(BIO_f_base64());
-        BIO *bio = BIO_new_mem_buf((void *) pkcs12_file_inline,
-                                   (int) strlen(pkcs12_file_inline));
+        BIO *bio = BIO_new_mem_buf((void *) pkcs12_file,
+                                   (int) strlen(pkcs12_file));
         ASSERT(b64 && bio);
         BIO_push(b64, bio);
         p12 = d2i_PKCS12_bio(b64, NULL);
@@ -929,20 +927,17 @@ tls_ctx_add_extra_certs(struct tls_root_ctx *ctx, BIO *bio, bool optional)
 
 void
 tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
-                       const char *cert_file_inline)
+                       bool cert_file_inline)
 {
     BIO *in = NULL;
     X509 *x = NULL;
     int ret = 0;
-    bool inline_file = false;
 
     ASSERT(NULL != ctx);
 
-    inline_file = (strcmp(cert_file, INLINE_FILE_TAG) == 0);
-
-    if (inline_file && cert_file_inline)
+    if (cert_file_inline)
     {
-        in = BIO_new_mem_buf((char *)cert_file_inline, -1);
+        in = BIO_new_mem_buf((char *) cert_file, -1);
     }
     else
     {
@@ -973,7 +968,7 @@ tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
 end:
     if (!ret)
     {
-        if (inline_file)
+        if (cert_file_inline)
         {
             crypto_msg(M_FATAL, "Cannot load inline certificate file");
         }
@@ -999,8 +994,7 @@ end:
 
 int
 tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
-                       const char *priv_key_file_inline
-                       )
+                       bool priv_key_file_inline)
 {
     SSL_CTX *ssl_ctx = NULL;
     BIO *in = NULL;
@@ -1011,9 +1005,9 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
 
     ssl_ctx = ctx->ctx;
 
-    if (!strcmp(priv_key_file, INLINE_FILE_TAG) && priv_key_file_inline)
+    if (priv_key_file_inline)
     {
-        in = BIO_new_mem_buf((char *)priv_key_file_inline, -1);
+        in = BIO_new_mem_buf((char *) priv_key_file, -1);
     }
     else
     {
@@ -1036,7 +1030,8 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
             management_auth_failure(management, UP_TYPE_PRIVATE_KEY, NULL);
         }
 #endif
-        crypto_msg(M_WARN, "Cannot load private key file %s", priv_key_file);
+        crypto_msg(M_WARN, "Cannot load private key file %s",
+                   print_key_filename(priv_key_file, priv_key_file_inline));
         goto end;
     }
 
@@ -1061,7 +1056,7 @@ end:
 
 void
 backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
-                           const char *crl_inline)
+                           bool crl_inline)
 {
     BIO *in = NULL;
 
@@ -1088,9 +1083,9 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
 
     X509_STORE_set_flags(store, X509_V_FLAG_CRL_CHECK | X509_V_FLAG_CRL_CHECK_ALL);
 
-    if (!strcmp(crl_file, INLINE_FILE_TAG) && crl_inline)
+    if (crl_inline)
     {
-        in = BIO_new_mem_buf((char *)crl_inline, -1);
+        in = BIO_new_mem_buf((char *) crl_file, -1);
     }
     else
     {
@@ -1099,7 +1094,8 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
 
     if (in == NULL)
     {
-        msg(M_WARN, "CRL: cannot read: %s", crl_file);
+        msg(M_WARN, "CRL: cannot read: %s",
+            print_key_filename(crl_file, crl_inline));
         goto end;
     }
 
@@ -1121,14 +1117,16 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
                 break;
             }
 
-            crypto_msg(M_WARN, "CRL: cannot read CRL from file %s", crl_file);
+            crypto_msg(M_WARN, "CRL: cannot read CRL from file %s",
+		       print_key_filename(crl_file, crl_inline));
             break;
         }
 
         if (!X509_STORE_add_crl(store, crl))
         {
             X509_CRL_free(crl);
-            crypto_msg(M_WARN, "CRL: cannot add %s to store", crl_file);
+            crypto_msg(M_WARN, "CRL: cannot add %s to store",
+		       print_key_filename(crl_file, crl_inline));
             break;
         }
         X509_CRL_free(crl);
@@ -1533,9 +1531,7 @@ sk_x509_name_cmp(const X509_NAME *const *a, const X509_NAME *const *b)
 
 void
 tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
-                const char *ca_file_inline,
-                const char *ca_path, bool tls_server
-                )
+                bool ca_file_inline, const char *ca_path, bool tls_server)
 {
     STACK_OF(X509_INFO) *info_stack = NULL;
     STACK_OF(X509_NAME) *cert_names = NULL;
@@ -1556,9 +1552,9 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
     /* Try to add certificates and CRLs from ca_file */
     if (ca_file)
     {
-        if (!strcmp(ca_file, INLINE_FILE_TAG) && ca_file_inline)
+        if (ca_file_inline)
         {
-            in = BIO_new_mem_buf((char *)ca_file_inline, -1);
+            in = BIO_new_mem_buf((char *)ca_file, -1);
         }
         else
         {
@@ -1630,11 +1626,11 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
                     {
                         crypto_msg(M_WARN,
                                    "Cannot load CA certificate file %s (entry %d did not validate)",
-                                   np(ca_file), added);
+                                   print_key_filename(ca_file, ca_file_inline),
+                                   added);
                     }
                     prev = cnum;
                 }
-
             }
             sk_X509_INFO_pop_free(info_stack, X509_INFO_free);
         }
@@ -1648,7 +1644,7 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
         {
             crypto_msg(M_FATAL,
                        "Cannot load CA certificate file %s (no entries were read)",
-                       np(ca_file));
+                       print_key_filename(ca_file, ca_file_inline));
         }
 
         if (tls_server)
@@ -1658,7 +1654,8 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
             {
                 crypto_msg(M_FATAL, "Cannot load CA certificate file %s (only %d "
                            "of %d entries were valid X509 names)",
-                           np(ca_file), cnum, added);
+                           print_key_filename(ca_file, ca_file_inline), cnum,
+                           added);
             }
         }
 
@@ -1686,13 +1683,12 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
 
 void
 tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
-                         const char *extra_certs_file_inline
-                         )
+                         bool extra_certs_file_inline)
 {
     BIO *in;
-    if (!strcmp(extra_certs_file, INLINE_FILE_TAG) && extra_certs_file_inline)
+    if (extra_certs_file_inline)
     {
-        in = BIO_new_mem_buf((char *)extra_certs_file_inline, -1);
+        in = BIO_new_mem_buf((char *)extra_certs_file, -1);
     }
     else
     {
@@ -1701,7 +1697,10 @@ tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
 
     if (in == NULL)
     {
-        crypto_msg(M_FATAL, "Cannot load extra-certs file: %s", extra_certs_file);
+        crypto_msg(M_FATAL, "Cannot load extra-certs file: %s",
+                   print_key_filename(extra_certs_file,
+                                      extra_certs_file_inline));
+
     }
     else
     {
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index e9f9cc2a..16424215 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -79,7 +79,7 @@ tls_crypt_buf_overhead(void)
 
 void
 tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
-                   const char *key_inline, bool tls_server)
+                   bool key_inline, bool tls_server)
 {
     const int key_direction = tls_server ?
                               KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVERSE;
@@ -295,7 +295,7 @@ tls_crypt_v2_load_client_key(struct key_ctx_bi *key, const struct key2 *key2,
 
 void
 tls_crypt_v2_init_client_key(struct key_ctx_bi *key, struct buffer *wkc_buf,
-                             const char *key_file, const char *key_inline)
+                             const char *key_file, bool key_inline)
 {
     struct buffer client_key = alloc_buf(TLS_CRYPT_V2_CLIENT_KEY_LEN
                                          + TLS_CRYPT_V2_MAX_WKC_LEN);
@@ -320,7 +320,7 @@ tls_crypt_v2_init_client_key(struct key_ctx_bi *key, struct buffer *wkc_buf,
 
 void
 tls_crypt_v2_init_server_key(struct key_ctx *key_ctx, bool encrypt,
-                             const char *key_file, const char *key_inline)
+                             const char *key_file, bool key_inline)
 {
     struct key srv_key;
     struct buffer srv_key_buf;
@@ -638,7 +638,7 @@ void
 tls_crypt_v2_write_client_key_file(const char *filename,
                                    const char *b64_metadata,
                                    const char *server_key_file,
-                                   const char *server_key_inline)
+				   bool server_key_inline)
 {
     struct gc_arena gc = gc_new();
     struct key_ctx server_key = { 0 };
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index 43bf8122..5e065007 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -108,14 +108,14 @@
  * Initialize a key_ctx_bi structure for use with --tls-crypt.
  *
  * @param key           The key context to initialize
- * @param key_file      The file to read the key from (or the inline tag to
- *                      indicate and inline key).
- * @param key_inline    Array containing (zero-terminated) inline key, or NULL
- *                      if not used.
+ * @param key_file      The file to read the key from or the key itself if
+ *                      key_inline is true.
+ * @param key_inline    True if key_file contains an inline key, False
+ *                      otherwise.
  * @param tls_server    Must be set to true is this is a TLS server instance.
  */
 void tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
-                        const char *key_inline, bool tls_server);
+                        bool key_inline, bool tls_server);
 
 /**
  * Returns the maximum overhead (in bytes) added to the destination buffer by
@@ -162,11 +162,14 @@ bool tls_crypt_unwrap(const struct buffer *src, struct buffer *dst,
  * @param key           Key structure to be initialized.  Must be non-NULL.
  * @parem encrypt       If true, initialize the key structure for encryption,
  *                      otherwise for decryption.
- * @param key_file      File path of the key file to load, or INLINE tag.
- * @param key_inline    Inline key file contents (or NULL if not inline).
+ * @param key_file      File path of the key file to load or the key itself if
+ *                      key_inline is true.
+ * @param key_inline    True if key_file contains an inline key, False
+ *                      otherwise.
+
  */
 void tls_crypt_v2_init_server_key(struct key_ctx *key_ctx, bool encrypt,
-                                  const char *key_file, const char *key_inline);
+                                  const char *key_file, bool key_inline);
 
 /**
  * Initialize a tls-crypt-v2 client key.
@@ -176,13 +179,14 @@ void tls_crypt_v2_init_server_key(struct key_ctx *key_ctx, bool encrypt,
  * @param wrapped_key_buf   Returns buffer containing the wrapped key that will
  *                          be sent to the server when connecting.  Caller must
  *                          free this buffer when no longer needed.
- * @param key_file          File path of the key file to load, or INLINE tag.
- * @param key_inline        Inline key file contents (or NULL if not inline).
+ * @param key_file          File path of the key file to load or the key itself
+ *                          if key_inline is true.
+ * @param key_inline        True if key_file contains an inline key, False
+ *                          otherwise.
  */
 void tls_crypt_v2_init_client_key(struct key_ctx_bi *key,
-                                  struct buffer *wrapped_key_buf,
-                                  const char *key_file,
-                                  const char *key_inline);
+				  struct buffer *wrapped_key_buf,
+                                  const char *key_file, bool key_inline);
 
 /**
  * Extract a tls-crypt-v2 client key from a P_CONTROL_HARD_RESET_CLIENT_V3
@@ -210,15 +214,14 @@ void tls_crypt_v2_write_server_key_file(const char *filename);
  *
  * @param filename          Filename of the client key file to create.
  * @param b64_metadata      Base64 metadata to be included in the client key.
- * @param server_key_file   File path of the server key to use for wrapping the
- *                          client key, or INLINE tag.
- * @param server_key_inline Inline server key file contents (or NULL if not
- *                          inline).
+ * @param key_file          File path of the server key to use for wrapping the
+ *                          client key or the key itself if key_inline is true.
+ * @param key_inline        True if key_file contains an inline key, False
+ *                          otherwise.
  */
 void tls_crypt_v2_write_client_key_file(const char *filename,
-                                        const char *b64_metadata,
-                                        const char *key_file,
-                                        const char *key_inline);
+					const char *b64_metadata,
+					const char *key_file, bool key_inline);
 
 /** @} */
 
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index 6b30dfbd..dbde8631 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -341,7 +341,7 @@ auth_token_test_random_keys(void **state)
     ctx->multi.auth_token = strdup(random_token);
 
     free_key_ctx(&ctx->multi.opt.auth_token_key);
-    auth_token_init_secret(&ctx->multi.opt.auth_token_key, INLINE_FILE_TAG, random_key);
+    auth_token_init_secret(&ctx->multi.opt.auth_token_key, random_key, true);
 
     /* Zero the hmac part to ensure we have a newly generated token */
     zerohmac(ctx->multi.auth_token);
@@ -361,12 +361,12 @@ auth_token_test_key_load(void **state)
     struct test_context *ctx = (struct test_context *) *state;
 
     free_key_ctx(&ctx->multi.opt.auth_token_key);
-    auth_token_init_secret(&ctx->multi.opt.auth_token_key, INLINE_FILE_TAG, zeroinline);
+    auth_token_init_secret(&ctx->multi.opt.auth_token_key, zeroinline, true);
     strcpy(ctx->up.password, now0key0);
     assert_true(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session));
 
     free_key_ctx(&ctx->multi.opt.auth_token_key);
-    auth_token_init_secret(&ctx->multi.opt.auth_token_key, INLINE_FILE_TAG, allx01inline);
+    auth_token_init_secret(&ctx->multi.opt.auth_token_key, allx01inline, true);
     assert_false(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session));
 }
 
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 8406d89d..2dc30bfe 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -568,8 +568,7 @@ test_tls_crypt_v2_write_client_key_file(void **state)
     expect_string(__wrap_buffer_read_from_file, filename, filename);
     will_return(__wrap_buffer_read_from_file, test_client_key);
 
-    tls_crypt_v2_write_client_key_file(filename, NULL, INLINE_FILE_TAG,
-                                       test_server_key);
+    tls_crypt_v2_write_client_key_file(filename, NULL, test_server_key, true);
 }
 
 static void
-- 
2.26.2


