From: Antonio Quartulli <a@...2181...>
Date: Sun,  7 Oct 2018 23:04:13 +0800
Message-Id: <20181007150413.1455-1-a@...2181...>
In-Reply-To: <20171202152144.22426-1-a@...2181...>
References: <20171202152144.22426-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8] convert *_inline attributes to bool
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


 src/openvpn/crypto.c      |  39 +++--
 src/openvpn/crypto.h      |  17 ++-
 src/openvpn/misc.c        |   6 +-
 src/openvpn/misc.h        |   3 +-
 src/openvpn/options.c     | 300 +++++++++++++++++++++-----------------
 src/openvpn/options.h     |  25 ++--
 src/openvpn/plugin.c      |   5 +-
 src/openvpn/plugin.h      |   3 +-
 src/openvpn/push.c        |   2 +-
 src/openvpn/push.h        |   3 +-
 src/openvpn/ssl.c         |   4 +-
 src/openvpn/ssl_backend.h |  55 +++----
 src/openvpn/ssl_common.h  |   2 +-
 src/openvpn/ssl_mbedtls.c |  61 ++++----
 src/openvpn/ssl_openssl.c |  85 ++++++-----
 src/openvpn/tls_crypt.c   |   2 +-
 src/openvpn/tls_crypt.h   |   9 +-
 17 files changed, 344 insertions(+), 277 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index c8d95f3b..dc5b8f1b 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1174,25 +1174,25 @@ test_crypto(struct crypto_options *co, struct frame *frame)
 
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
@@ -1226,7 +1226,6 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
     struct buffer in;
     int size;
     uint8_t hex_byte[3] = {0, 0, 0};
-    const char *error_filename = file;
 
     /* parse info */
     const unsigned char *cp;
@@ -1264,7 +1263,6 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
     {
         size = strlen(file) + 1;
         buf_set_read(&in, (const uint8_t *)file, size);
-        error_filename = INLINE_FILE_TAG;
     }
     else /* 'file' is a filename which refers to a file containing the ascii key */
     {
@@ -1358,7 +1356,9 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
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
@@ -1379,13 +1379,15 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
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
 
@@ -1815,3 +1817,14 @@ translate_cipher_name_to_openvpn(const char *cipher_name)
 
     return pair->openvpn_name;
 }
+
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
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index f4b3dca3..bf54bb03 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -487,8 +487,9 @@ void key2_print(const struct key2 *k,
                 const char *prefix1);
 
 void crypto_read_openvpn_key(const struct key_type *key_type,
-                             struct key_ctx_bi *ctx, const char *key_file, const char *key_inline,
-                             const int key_direction, const char *key_name, const char *opt_name);
+                             struct key_ctx_bi *ctx, const char *key_file,
+                             bool key_inline, const int key_direction,
+                             const char *key_name, const char *opt_name);
 
 /*
  * Inline functions
@@ -519,4 +520,16 @@ key_ctx_bi_defined(const struct key_ctx_bi *key)
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
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 71fa2135..a1067662 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -624,12 +624,12 @@ make_arg_copy(char **p, struct gc_arena *gc)
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
index 9d4601f0..ff6d6827 100644
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
index 61fa9833..8ad3a67c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3115,9 +3115,8 @@ options_postprocess_mutate(struct options *o)
 #define CHKACC_FILE (1<<0)       /** Check for a file/directory precense */
 #define CHKACC_DIRPATH (1<<1)    /** Check for directory precense where a file should reside */
 #define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is it writable? */
-#define CHKACC_INLINE (1<<3)     /** File is present if it's an inline file */
-#define CHKACC_ACPTSTDIN (1<<4)  /** If filename is stdin, it's allowed and "exists" */
-#define CHKACC_PRIVATE (1<<5)    /** Warn if this (private) file is group/others accessible */
+#define CHKACC_ACPTSTDIN (1<<3)  /** If filename is stdin, it's allowed and "exists" */
+#define CHKACC_PRIVATE (1<<4)    /** Warn if this (private) file is group/others accessible */
 
 static bool
 check_file_access(const int type, const char *file, const int mode, const char *opt)
@@ -3130,12 +3129,6 @@ check_file_access(const int type, const char *file, const int mode, const char *
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
@@ -3240,6 +3233,38 @@ check_file_access_chroot(const char *chroot, const int type, const char *file, c
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
@@ -3304,31 +3329,47 @@ options_postprocess_filechecks(struct options *options)
     bool errs = false;
 
     /* ** SSL/TLS/crypto related files ** */
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->dh_file, R_OK, "--dh");
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->ca_file, R_OK, "--ca");
-    errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->ca_path, R_OK, "--capath");
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->cert_file, R_OK, "--cert");
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->extra_certs_file, R_OK,
-                              "--extra-certs");
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
 #ifdef MANAGMENT_EXTERNAL_KEY
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
@@ -3336,16 +3377,20 @@ options_postprocess_filechecks(struct options *options)
     {
         struct connection_entry *ce = options->connection_list->array[i];
 
-        errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                                  ce->tls_auth_file, R_OK, "--tls-auth");
-
-        errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                                  ce->tls_crypt_file, R_OK, "--tls-crypt");
-
+        errs |= check_file_access_inline(ce->tls_auth_file_inline,
+                                         CHKACC_FILE|CHKACC_PRIVATE,
+                                         ce->tls_auth_file, R_OK,
+                                         "--tls-auth");
+        errs |= check_file_access_inline(ce->tls_crypt_inline,
+                                         CHKACC_FILE|CHKACC_PRIVATE,
+                                         ce->tls_crypt_file, R_OK,
+                                         "--tls-crypt");
     }
 
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                              options->shared_secret_file, R_OK, "--secret");
+    errs |= check_file_access_inline(options->shared_secret_file_inline,
+                                     CHKACC_FILE|CHKACC_PRIVATE,
+                                     options->shared_secret_file, R_OK,
+                                     "--secret");
 
     errs |= check_file_access(CHKACC_DIRPATH|CHKACC_FILEXSTWR,
                               options->packet_id_file, R_OK|W_OK, "--replay-persist");
@@ -4507,25 +4552,26 @@ read_inline_file(struct in_src *is, const char *close_tag, struct gc_arena *gc)
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
@@ -4538,7 +4584,8 @@ check_inline_file_via_fp(FILE *fp, char *p[], struct gc_arena *gc)
 }
 
 static bool
-check_inline_file_via_buf(struct buffer *multiline, char *p[], struct gc_arena *gc)
+check_inline_file_via_buf(struct buffer *multiline, char *p[],
+                          struct gc_arena *gc)
 {
     struct in_src is;
     is.type = IS_TYPE_BUF;
@@ -4549,6 +4596,7 @@ check_inline_file_via_buf(struct buffer *multiline, char *p[], struct gc_arena *
 static void
 add_option(struct options *options,
            char *p[],
+           bool is_inline,
            const char *file,
            int line,
            const int level,
@@ -4606,9 +4654,13 @@ read_config_file(struct options *options,
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
@@ -4651,9 +4703,12 @@ read_config_string(const char *prefix,
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
@@ -4684,7 +4739,8 @@ parse_argv(struct options *options,
         CLEAR(p);
         p[0] = "config";
         p[1] = argv[1];
-        add_option(options, p, NULL, 0, 0, msglevel, permission_mask, option_types_found, es);
+        add_option(options, p, false, NULL, 0, 0, msglevel, permission_mask,
+                   option_types_found, es);
     }
     else
     {
@@ -4718,7 +4774,8 @@ parse_argv(struct options *options,
                     }
                 }
             }
-            add_option(options, p, NULL, 0, 0, msglevel, permission_mask, option_types_found, es);
+            add_option(options, p, false, NULL, 0, 0, msglevel, permission_mask,
+                       option_types_found, es);
             i += j - 1;
         }
     }
@@ -4789,7 +4846,8 @@ apply_push_options(struct options *options,
         }
         if (parse_line(line, p, SIZE(p)-1, file, line_num, msglevel, &options->gc))
         {
-            add_option(options, p, file, line_num, 0, msglevel, permission_mask, option_types_found, es);
+            add_option(options, p, false, file, line_num, 0, msglevel,
+                       permission_mask, option_types_found, es);
         }
     }
     return true;
@@ -4828,7 +4886,13 @@ options_string_import(struct options *options,
 
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
@@ -4838,7 +4902,8 @@ verify_permission(const char *name,
                   const unsigned int allowed,
                   unsigned int *found,
                   const int msglevel,
-                  struct options *options)
+                  struct options *options,
+                  bool is_inline)
 {
     if (!(type & allowed))
     {
@@ -4846,6 +4911,13 @@ verify_permission(const char *name,
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
@@ -4952,10 +5024,10 @@ set_user_script(struct options *options,
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
@@ -5335,15 +5407,16 @@ add_option(struct options *options,
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
@@ -6024,17 +6097,10 @@ add_option(struct options *options,
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
@@ -7497,12 +7563,10 @@ add_option(struct options *options,
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
 
@@ -7516,7 +7580,6 @@ add_option(struct options *options,
                 goto err;
             }
         }
-        options->shared_secret_file = p[1];
     }
     else if (streq(p[0], "genkey") && !p[1])
     {
@@ -7695,14 +7758,11 @@ add_option(struct options *options,
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
@@ -7711,32 +7771,23 @@ add_option(struct options *options,
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
@@ -7765,14 +7816,11 @@ add_option(struct options *options,
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
@@ -7803,14 +7851,11 @@ add_option(struct options *options,
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
@@ -7867,18 +7912,15 @@ add_option(struct options *options,
         options->tls_cert_profile = p[1];
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
@@ -8059,15 +8101,14 @@ add_option(struct options *options,
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
@@ -8076,16 +8117,15 @@ add_option(struct options *options,
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
@@ -8094,28 +8134,20 @@ add_option(struct options *options,
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
+            options->tls_crypt_inline = is_inline;
         }
         else if (permission_mask & OPT_P_CONNECTION)
         {
-            if (streq(p[1], INLINE_FILE_TAG) && p[2])
-            {
-                options->ce.tls_crypt_inline = p[2];
-            }
             options->ce.tls_crypt_file = p[1];
-
+            options->ce.tls_crypt_inline = is_inline;
         }
     }
     else if (streq(p[0], "key-method") && p[1] && !p[2])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index acbd1087..e1ec34e8 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -133,12 +133,12 @@ struct connection_entry
 
     /* Shared secret used for TLS control channel authentication */
     const char *tls_auth_file;
-    const char *tls_auth_file_inline;
+    bool tls_auth_file_inline;
     int key_direction;
 
     /* Shared secret used for TLS control channel authenticated encryption */
     const char *tls_crypt_file;
-    const char *tls_crypt_inline;
+    bool tls_crypt_inline;
 };
 
 struct remote_entry
@@ -476,7 +476,7 @@ struct options
 
     /* Cipher parms */
     const char *shared_secret_file;
-    const char *shared_secret_file_inline;
+    bool shared_secret_file_inline;
     int key_direction;
     const char *ciphername;
     bool ncp_enabled;
@@ -515,13 +515,13 @@ struct options
     const char *tls_export_cert;
     const char *crl_file;
 
-    const char *ca_file_inline;
-    const char *cert_file_inline;
-    const char *extra_certs_file_inline;
-    const char *crl_file_inline;
-    char *priv_key_file_inline;
-    const char *dh_file_inline;
-    const char *pkcs12_file_inline; /* contains the base64 encoding of pkcs12 file */
+    bool ca_file_inline;
+    bool cert_file_inline;
+    bool extra_certs_file_inline;
+    bool crl_file_inline;
+    bool priv_key_file_inline;
+    bool dh_file_inline;
+    bool pkcs12_file_inline;
 
     int ns_cert_type; /* set to 0, NS_CERT_CHECK_SERVER, or NS_CERT_CHECK_CLIENT */
     unsigned remote_cert_ku[MAX_PARMS];
@@ -570,11 +570,11 @@ struct options
 
     /* Shared secret used for TLS control channel authentication */
     const char *tls_auth_file;
-    const char *tls_auth_file_inline;
+    bool tls_auth_file_inline;
 
     /* Shared secret used for TLS control channel authenticated encryption */
     const char *tls_crypt_file;
-    const char *tls_crypt_inline;
+    bool tls_crypt_inline;
 
     /* Allow only one session */
     bool single_session;
@@ -647,6 +647,7 @@ struct options
 #define OPT_P_SOCKFLAGS       (1<<26)
 #define OPT_P_CONNECTION      (1<<27)
 #define OPT_P_PEER_ID         (1<<28)
+#define OPT_P_INLINE          (1<<29)
 
 #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))
 
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 4d17c821..c5a61db6 100644
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
index a7ec4dd6..6cf37565 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -569,7 +569,7 @@ clone_push_list(struct options *o)
 void
 push_options(struct options *o, char **p, int msglevel, struct gc_arena *gc)
 {
-    const char **argv = make_extended_arg_array(p, gc);
+    const char **argv = make_extended_arg_array(p, false, gc);
     char *opt = print_argv(argv, gc, 0);
     push_option(o, opt, msglevel);
 }
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 5f6181e7..bf313297 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -57,7 +57,8 @@ void clone_push_list(struct options *o);
 
 void push_option(struct options *o, const char *opt, int msglevel);
 
-void push_options(struct options *o, char **p, int msglevel, struct gc_arena *gc);
+void push_options(struct options *o, char **p, int msglevel,
+                  struct gc_arena *gc);
 
 void push_reset(struct options *o);
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4257c33d..6b0f26d0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -555,7 +555,7 @@ tls_version_parse(const char *vstr, const char *extra)
  */
 static void
 tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
-                   const char *crl_file_inline)
+                   bool crl_file_inline)
 {
     /* if something goes wrong with stat(), we'll store 0 as mtime */
     platform_stat_t crl_stat = {0};
@@ -661,7 +661,7 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
     {
         char *cert = management_query_cert(management,
                                            options->management_certificate);
-        tls_ctx_load_cert_file(new_ctx, INLINE_FILE_TAG, cert);
+        tls_ctx_load_cert_file(new_ctx, cert, true);
         free(cert);
     }
 #endif
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 5023c02a..86d41f9d 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -202,11 +202,12 @@ void tls_ctx_check_cert_time(const struct tls_root_ctx *ctx);
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
@@ -224,15 +225,15 @@ void tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
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
@@ -252,25 +253,27 @@ void tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert
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
 
 #ifdef MANAGMENT_EXTERNAL_KEY
 
@@ -293,13 +296,13 @@ int tls_ctx_use_management_external_key(struct tls_root_ctx *ctx);
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
@@ -309,12 +312,14 @@ void tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
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
@@ -357,11 +362,11 @@ void key_state_ssl_free(struct key_state_ssl *ks_ssl);
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
index 08ef6ffa..e5883c1a 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -263,7 +263,7 @@ struct tls_options
     int verify_x509_type;
     const char *verify_x509_name;
     const char *crl_file;
-    const char *crl_file_inline;
+    bool crl_file_inline;
     int ns_cert_type;
     unsigned remote_cert_ku[MAX_PARMS];
     const char *remote_cert_eku;
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index e4850cb6..1e7326d7 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -312,13 +312,13 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 
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
@@ -348,9 +348,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
 
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
-                    const char *pkcs12_file_inline,
-                    bool load_ca_file
-                    )
+                    bool pkcs12_file_inline, bool load_ca_file)
 {
     msg(M_FATAL, "PKCS #12 files not yet supported for mbed TLS.");
     return 0;
@@ -366,8 +364,7 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
 
 void
 tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
-                       const char *cert_inline
-                       )
+                       bool cert_inline)
 {
     ASSERT(NULL != ctx);
 
@@ -376,10 +373,11 @@ tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
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
@@ -395,8 +393,7 @@ tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
 
 int
 tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
-                       const char *priv_key_inline
-                       )
+                       bool priv_key_inline)
 {
     int status;
     ASSERT(NULL != ctx);
@@ -406,19 +403,20 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
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
@@ -440,7 +438,8 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
             management_auth_failure(management, UP_TYPE_PRIVATE_KEY, NULL);
         }
 #endif
-        msg(M_WARN, "Cannot load private key file %s", priv_key_file);
+        msg(M_WARN, "Cannot load private key file %s",
+            print_key_filename(priv_key_file, priv_key_inline));
         return 1;
     }
 
@@ -649,18 +648,18 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
 
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
@@ -677,8 +676,7 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
 
 void
 tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
-                         const char *extra_certs_inline
-                         )
+                         bool extra_certs_inline)
 {
     ASSERT(NULL != ctx);
 
@@ -687,11 +685,11 @@ tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
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
@@ -919,7 +917,7 @@ tls_version_to_major_minor(int tls_ver, int *major, int *minor)
 
 void
 backend_tls_ctx_reload_crl(struct tls_root_ctx *ctx, const char *crl_file,
-                           const char *crl_inline)
+                           bool crl_inline)
 {
     ASSERT(crl_file);
 
@@ -929,10 +927,11 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ctx, const char *crl_file,
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
index 1a66d178..58a89000 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -511,17 +511,16 @@ cleanup:
 
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
@@ -540,7 +539,8 @@ tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
 
     if (!dh)
     {
-        crypto_msg(M_FATAL, "Cannot load DH parameters from %s", dh_file);
+        crypto_msg(M_FATAL, "Cannot load DH parameters from %s",
+                   print_key_filename(dh_file, dh_file_inline));
     }
     if (!SSL_CTX_set_tmp_dh(ctx->ctx, dh))
     {
@@ -638,9 +638,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
 
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
-                    const char *pkcs12_file_inline,
-                    bool load_ca_file
-                    )
+                    bool pkcs12_file_inline, bool load_ca_file)
 {
     FILE *fp;
     EVP_PKEY *pkey;
@@ -652,11 +650,11 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
 
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
@@ -802,20 +800,17 @@ tls_ctx_add_extra_certs(struct tls_root_ctx *ctx, BIO *bio)
 
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
@@ -846,7 +841,7 @@ tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
 end:
     if (!ret)
     {
-        if (inline_file)
+        if (cert_file_inline)
         {
             crypto_msg(M_FATAL, "Cannot load inline certificate file");
         }
@@ -868,8 +863,7 @@ end:
 
 int
 tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
-                       const char *priv_key_file_inline
-                       )
+                       bool priv_key_file_inline)
 {
     SSL_CTX *ssl_ctx = NULL;
     BIO *in = NULL;
@@ -880,9 +874,9 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
 
     ssl_ctx = ctx->ctx;
 
-    if (!strcmp(priv_key_file, INLINE_FILE_TAG) && priv_key_file_inline)
+    if (priv_key_file_inline)
     {
-        in = BIO_new_mem_buf((char *)priv_key_file_inline, -1);
+        in = BIO_new_mem_buf((char *) priv_key_file, -1);
     }
     else
     {
@@ -910,7 +904,8 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
             management_auth_failure(management, UP_TYPE_PRIVATE_KEY, NULL);
         }
 #endif
-        crypto_msg(M_WARN, "Cannot load private key file %s", priv_key_file);
+        crypto_msg(M_WARN, "Cannot load private key file %s",
+                   print_key_filename(priv_key_file, priv_key_file_inline));
         goto end;
     }
 
@@ -935,7 +930,7 @@ end:
 
 void
 backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
-                           const char *crl_inline)
+                           bool crl_inline)
 {
     X509_CRL *crl = NULL;
     BIO *in = NULL;
@@ -963,9 +958,9 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
 
     X509_STORE_set_flags(store, X509_V_FLAG_CRL_CHECK | X509_V_FLAG_CRL_CHECK_ALL);
 
-    if (!strcmp(crl_file, INLINE_FILE_TAG) && crl_inline)
+    if (crl_inline)
     {
-        in = BIO_new_mem_buf((char *)crl_inline, -1);
+        in = BIO_new_mem_buf((char *) crl_file, -1);
     }
     else
     {
@@ -974,20 +969,23 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
 
     if (in == NULL)
     {
-        msg(M_WARN, "CRL: cannot read: %s", crl_file);
+        msg(M_WARN, "CRL: cannot read: %s",
+            print_key_filename(crl_file, crl_inline));
         goto end;
     }
 
     crl = PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
     if (crl == NULL)
     {
-        msg(M_WARN, "CRL: cannot read CRL from file %s", crl_file);
+        msg(M_WARN, "CRL: cannot read CRL from file %s",
+            print_key_filename(crl_file, crl_inline));
         goto end;
     }
 
     if (!X509_STORE_add_crl(store, crl))
     {
-        msg(M_WARN, "CRL: cannot add %s to store", crl_file);
+        msg(M_WARN, "CRL: cannot add %s to store",
+            print_key_filename(crl_file, crl_inline));
         goto end;
     }
 
@@ -1350,9 +1348,7 @@ sk_x509_name_cmp(const X509_NAME *const *a, const X509_NAME *const *b)
 
 void
 tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
-                const char *ca_file_inline,
-                const char *ca_path, bool tls_server
-                )
+                bool ca_file_inline, const char *ca_path, bool tls_server)
 {
     STACK_OF(X509_INFO) *info_stack = NULL;
     STACK_OF(X509_NAME) *cert_names = NULL;
@@ -1373,9 +1369,9 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
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
@@ -1447,11 +1443,11 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
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
@@ -1465,7 +1461,7 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
         {
             crypto_msg(M_FATAL,
                        "Cannot load CA certificate file %s (no entries were read)",
-                       np(ca_file));
+                       print_key_filename(ca_file, ca_file_inline));
         }
 
         if (tls_server)
@@ -1475,7 +1471,8 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
             {
                 crypto_msg(M_FATAL, "Cannot load CA certificate file %s (only %d "
                            "of %d entries were valid X509 names)",
-                           np(ca_file), cnum, added);
+                           print_key_filename(ca_file, ca_file_inline), cnum,
+                           added);
             }
         }
 
@@ -1503,13 +1500,12 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
 
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
@@ -1518,7 +1514,10 @@ tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
 
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
index 36ead84d..ba2e82c3 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -66,7 +66,7 @@ tls_crypt_buf_overhead(void)
 
 void
 tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
-                   const char *key_inline, bool tls_server)
+                   bool key_inline, bool tls_server)
 {
     const int key_direction = tls_server ?
                               KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVERSE;
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index 067758ca..2b0d8f4b 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -91,13 +91,14 @@
  *
  * @param key           The key context to initialize
  * @param key_file      The file to read the key from (or the inline tag to
- *                      indicate and inline key).
- * @param key_inline    Array containing (zero-terminated) inline key, or NULL
- *                      if not used.
+ *                      indicate and inline key) or an array containing
+ *                      (zero-terminated) inline key.
+ * @param key_inline    True if key_file contains an inline key, False
+ *                      otherwise.
  * @param tls_server    Must be set to true is this is a TLS server instance.
  */
 void tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
-                        const char *key_inline, bool tls_server);
+                        bool key_inline, bool tls_server);
 
 /**
  * Returns the maximum overhead (in bytes) added to the destination buffer by
-- 
2.19.1


