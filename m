From: Antonio Quartulli <a@...2181...>
Date: Tue, 27 Dec 2016 19:24:36 +0800
Message-Id: <20161227112436.5045-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v2] convert *_inline attributes to bool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
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

Cc: Steffan Karger <steffan@...1856...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

Based on master + [PATCH v3] reformatting: fix style in crypto*.{c, h}

Changes from v1:
- remove the INLINE_TAG from the options parsing logic at all. Now a
  boolean variable is passed around.
- add print_if_inline() helper function (to misc.c/h) to make sure we
  never print the inline data, but only the INLINE tag. Such function
  checks also for NULL pointers;
- make sure print_if_inline() is always used when printing possibly
  inline data;
- remove the INLINE_TAG from the options parsing logic at all. Now a
  boolean variable is passed around.
- fix alignment error in comment;
- remove CHKACC_INLINE from check_file_access() logic: this function
  is now not invoked at all in case of inline data.



 src/openvpn/crypto.c      |  25 +++---
 src/openvpn/crypto.h      |   5 +-
 src/openvpn/misc.c        |  17 +++-
 src/openvpn/misc.h        |  15 +++-
 src/openvpn/options.c     | 221 ++++++++++++++++++++++++----------------------
 src/openvpn/options.h     |  20 ++---
 src/openvpn/plugin.c      |   6 +-
 src/openvpn/plugin.h      |   3 +-
 src/openvpn/push.c        |   5 +-
 src/openvpn/push.h        |   3 +-
 src/openvpn/ssl.c         |   6 +-
 src/openvpn/ssl_backend.h |  64 ++++++++------
 src/openvpn/ssl_common.h  |   2 +-
 src/openvpn/ssl_mbedtls.c |  63 +++++++------
 src/openvpn/ssl_openssl.c |  92 ++++++++++---------
 src/openvpn/tls_crypt.c   |   2 +-
 src/openvpn/tls_crypt.h   |   9 +-
 17 files changed, 297 insertions(+), 261 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 63f8806..3e710aa 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -36,6 +36,7 @@
 #include "crypto.h"
 #include "error.h"
 #include "integer.h"
+#include "misc.h"
 #include "platform.h"
 
 #include "memdbg.h"
@@ -1184,27 +1185,26 @@ test_crypto(struct crypto_options *co, struct frame *frame)
 
 void
 crypto_read_openvpn_key(const struct key_type *key_type, struct key_ctx_bi *ctx,
-                        const char *key_file, const char *key_inline,
+                        const char *key_file, bool key_inline,
                         const int key_direction, const char *key_name,
                         const char *opt_name)
 {
     struct key2 key2;
     struct key_direction_state kds;
     char log_prefix[128] = { 0 };
+    unsigned int flags = RKF_MUST_SUCCEED;
 
     if (key_inline)
     {
-        read_key_file(&key2, key_inline, RKF_MUST_SUCCEED | RKF_INLINE);
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
+            print_if_inline(key_file, key_inline));
     }
 
     /* check for and fix highly unlikely key problems */
@@ -1244,7 +1244,6 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
     struct buffer in;
     int fd, size;
     uint8_t hex_byte[3] = {0, 0, 0};
-    const char *error_filename = file;
 
     /* parse info */
     const unsigned char *cp;
@@ -1283,7 +1282,6 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
         /* 'file' is a string containing ascii representation of key */
         size = strlen(file) + 1;
         buf_set_read(&in, (const uint8_t *)file, size);
-        error_filename = INLINE_FILE_TAG;
     }
     else
     {
@@ -1391,7 +1389,8 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
                 {
                     msg(M_FATAL,
                         isprint(c) ? printable_char_fmt : unprintable_char_fmt,
-                        c, line_num, error_filename, count, onekeylen, keylen);
+                        c, line_num, print_if_inline(file, flags & RKF_INLINE),
+                        count, onekeylen, keylen);
                 }
             }
             ++line_index;
@@ -1413,14 +1412,16 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
         {
             msg(M_FATAL,
                 "Insufficient key material or header text not found in file '%s' (%d/%d/%d bytes found/min/max)",
-                error_filename, count, onekeylen, keylen);
+                print_if_inline(file, flags & RKF_INLINE), count, onekeylen,
+                keylen);
         }
 
         if (state != PARSE_FINISHED)
         {
             msg(M_FATAL,
                 "Footer text not found in file '%s' (%d/%d/%d bytes found/min/max)",
-                error_filename, count, onekeylen, keylen);
+                print_if_inline(file, flags & RKF_INLINE), count, onekeylen,
+                keylen);
         }
     }
 
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index afd0aa6..c1bf614 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -497,9 +497,8 @@ void key2_print(const struct key2 *k,
 
 void crypto_read_openvpn_key(const struct key_type *key_type,
                              struct key_ctx_bi *ctx, const char *key_file,
-                             const char *key_inline,
-                             const int key_direction, const char *key_name,
-                             const char *opt_name);
+                             bool key_inline, const int key_direction,
+                             const char *key_name, const char *opt_name);
 
 /*
  * Inline functions
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 87f03be..7658900 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1645,12 +1645,12 @@ make_arg_copy(char **p, struct gc_arena *gc)
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
@@ -1788,6 +1788,17 @@ compat_flag(unsigned int flag)
 
 }
 
+const char *
+print_if_inline(const char *str, bool is_inline)
+{
+    if (is_inline)
+    {
+        return INLINE_FILE_TAG;
+    }
+
+    return np(str);
+}
+
 #if P2MP_SERVER
 
 /* helper to parse peer_info received from multi client, validate
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 16be621..9cb42e4 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -173,7 +173,8 @@ const char **make_env_array(const struct env_set *es,
 
 const char **make_arg_array(const char *first, const char *parms, struct gc_arena *gc);
 
-const char **make_extended_arg_array(char **p, struct gc_arena *gc);
+const char **make_extended_arg_array(char **p, bool is_inline,
+                                     struct gc_arena *gc);
 
 /* an analogue to the random() function, but use OpenSSL functions if available */
 #ifdef ENABLE_CRYPTO
@@ -348,4 +349,16 @@ void output_peer_info_env(struct env_set *es, const char *peer_info);
 
 #endif /* P2MP_SERVER */
 
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
+const char *print_if_inline(const char *str, bool is_inline);
+
 #endif /* ifndef MISC_H */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bfedb6a..249619b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3055,9 +3055,8 @@ options_postprocess_mutate(struct options *o)
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
@@ -3070,12 +3069,6 @@ check_file_access(const int type, const char *file, const int mode, const char *
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
@@ -3246,39 +3239,71 @@ options_postprocess_filechecks(struct options *options)
 
 #ifdef ENABLE_CRYPTO
     /* ** SSL/TLS/crypto related files ** */
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->dh_file, R_OK, "--dh");
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->ca_file, R_OK, "--ca");
-    errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->ca_path, R_OK, "--capath");
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->cert_file, R_OK, "--cert");
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->extra_certs_file, R_OK,
-                              "--extra-certs");
+    if (!options->dh_file_inline)
+    {
+        errs |= check_file_access(CHKACC_FILE, options->dh_file, R_OK, "--dh");
+    }
+    if (!options->ca_file_inline)
+    {
+        errs |= check_file_access(CHKACC_FILE, options->ca_file, R_OK, "--ca");
+    }
+    errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE,
+                                     options->ca_path, R_OK, "--capath");
+    if (!options->cert_file_inline)
+    {
+        errs |= check_file_access(CHKACC_FILE, options->cert_file, R_OK, "--cert");
+    }
+    if (!options->extra_certs_file)
+    {
+        errs |= check_file_access(CHKACC_FILE, options->extra_certs_file, R_OK,
+                                  "--extra-certs");
+    }
 #ifdef MANAGMENT_EXTERNAL_KEY
     if (!(options->management_flags & MF_EXTERNAL_KEY))
 #endif
     {
-        errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                                  options->priv_key_file, R_OK, "--key");
+        if (!options->priv_key_file_inline)
+        {
+            errs |= check_file_access(CHKACC_FILE|CHKACC_PRIVATE,
+                                      options->priv_key_file, R_OK, "--key");
+        }
+    }
+    if (!options->pkcs12_file_inline)
+    {
+        errs |= check_file_access(CHKACC_FILE|CHKACC_PRIVATE,
+                                  options->pkcs12_file, R_OK, "--pkcs12");
     }
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                              options->pkcs12_file, R_OK, "--pkcs12");
 
     if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
     {
-        errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->crl_file, R_OK|X_OK,
+        errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE,
+                                         options->crl_file, R_OK|X_OK,
                                          "--crl-verify directory");
     }
-    else
+    else if (!options->crl_file_inline)
+    {
+        errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE,
+                                         options->crl_file, R_OK,
+                                         "--crl-verify");
+    }
+
+    if (!options->tls_auth_file_inline)
+    {
+        errs |= check_file_access(CHKACC_FILE|CHKACC_PRIVATE,
+                                  options->tls_auth_file, R_OK, "--tls-auth");
+    }
+    if (!options->tls_crypt_inline)
+    {
+        errs |= check_file_access(CHKACC_FILE|CHKACC_PRIVATE,
+                                  options->tls_crypt_file, R_OK, "--tls-crypt");
+    }
+    if (!options->shared_secret_file_inline)
     {
-        errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE|CHKACC_INLINE,
-                                         options->crl_file, R_OK, "--crl-verify");
+        errs |= check_file_access(CHKACC_FILE|CHKACC_PRIVATE,
+                                  options->shared_secret_file, R_OK,
+                                  "--secret");
     }
 
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                              options->tls_auth_file, R_OK, "--tls-auth");
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                              options->tls_crypt_file, R_OK, "--tls-crypt");
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                              options->shared_secret_file, R_OK, "--secret");
     errs |= check_file_access(CHKACC_DIRPATH|CHKACC_FILEXSTWR,
                               options->packet_id_file, R_OK|W_OK, "--replay-persist");
 
@@ -4459,22 +4484,25 @@ read_inline_file(struct in_src *is, const char *close_tag, struct gc_arena *gc)
 }
 
 static bool
-check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
+check_inline_file(struct in_src *is, char *p[], bool *is_inline,
+                  struct gc_arena *gc)
 {
     bool ret = false;
+
+    *is_inline = false;
     if (p[0] && !p[1])
     {
         char *arg = p[0];
         if (arg[0] == '<' && arg[strlen(arg)-1] == '>')
         {
             struct buffer close_tag;
+            *is_inline = true;
             arg[strlen(arg)-1] = '\0';
             p[0] = string_alloc(arg+1, gc);
-            p[1] = string_alloc(INLINE_FILE_TAG, gc);
             close_tag = alloc_buf(strlen(p[0]) + 4);
             buf_printf(&close_tag, "</%s>", p[0]);
-            p[2] = read_inline_file(is, BSTR(&close_tag), gc);
-            p[3] = NULL;
+            p[1] = read_inline_file(is, BSTR(&close_tag), gc);
+            p[2] = NULL;
             free_buf(&close_tag);
             ret = true;
         }
@@ -4483,26 +4511,29 @@ check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
 }
 
 static bool
-check_inline_file_via_fp(FILE *fp, char *p[], struct gc_arena *gc)
+check_inline_file_via_fp(FILE *fp, char *p[], bool *is_inline,
+                         struct gc_arena *gc)
 {
     struct in_src is;
     is.type = IS_TYPE_FP;
     is.u.fp = fp;
-    return check_inline_file(&is, p, gc);
+    return check_inline_file(&is, p, is_inline, gc);
 }
 
 static bool
-check_inline_file_via_buf(struct buffer *multiline, char *p[], struct gc_arena *gc)
+check_inline_file_via_buf(struct buffer *multiline, char *p[], bool *is_inline,
+                          struct gc_arena *gc)
 {
     struct in_src is;
     is.type = IS_TYPE_BUF;
     is.u.multiline = multiline;
-    return check_inline_file(&is, p, gc);
+    return check_inline_file(&is, p, is_inline, gc);
 }
 
 static void
 add_option(struct options *options,
            char *p[],
+           bool is_inline,
            const char *file,
            int line,
            const int level,
@@ -4523,6 +4554,7 @@ read_config_file(struct options *options,
                  struct env_set *es)
 {
     const int max_recursive_levels = 10;
+    bool is_inline;
     FILE *fp;
     int line_num;
     char line[OPTION_LINE_SIZE+1];
@@ -4561,8 +4593,10 @@ read_config_file(struct options *options,
                 if (parse_line(line + offset, p, SIZE(p), file, line_num, msglevel, &options->gc))
                 {
                     bypass_doubledash(&p[0]);
-                    check_inline_file_via_fp(fp, p, &options->gc);
-                    add_option(options, p, file, line_num, level, msglevel, permission_mask, option_types_found, es);
+                    check_inline_file_via_fp(fp, p, &is_inline, &options->gc);
+                    add_option(options, p, is_inline, file, line_num, level,
+                               msglevel, permission_mask, option_types_found,
+                               es);
                 }
             }
             if (fp != stdin)
@@ -4595,6 +4629,7 @@ read_config_string(const char *prefix,
     char line[OPTION_LINE_SIZE];
     struct buffer multiline;
     int line_num = 0;
+    bool is_inline;
 
     buf_set_read(&multiline, (uint8_t *)config, strlen(config));
 
@@ -4606,8 +4641,9 @@ read_config_string(const char *prefix,
         if (parse_line(line, p, SIZE(p), prefix, line_num, msglevel, &options->gc))
         {
             bypass_doubledash(&p[0]);
-            check_inline_file_via_buf(&multiline, p, &options->gc);
-            add_option(options, p, prefix, line_num, 0, msglevel, permission_mask, option_types_found, es);
+            check_inline_file_via_buf(&multiline, p, &is_inline, &options->gc);
+            add_option(options, p, is_inline, prefix, line_num, 0, msglevel,
+                       permission_mask, option_types_found, es);
         }
         CLEAR(p);
     }
@@ -4638,7 +4674,8 @@ parse_argv(struct options *options,
         CLEAR(p);
         p[0] = "config";
         p[1] = argv[1];
-        add_option(options, p, NULL, 0, 0, msglevel, permission_mask, option_types_found, es);
+        add_option(options, p, false, NULL, 0, 0, msglevel, permission_mask,
+                   option_types_found, es);
     }
     else
     {
@@ -4672,7 +4709,8 @@ parse_argv(struct options *options,
                     }
                 }
             }
-            add_option(options, p, NULL, 0, 0, msglevel, permission_mask, option_types_found, es);
+            add_option(options, p, false, NULL, 0, 0, msglevel, permission_mask,
+                       option_types_found, es);
             i += j - 1;
         }
     }
@@ -4743,7 +4781,8 @@ apply_push_options(struct options *options,
         }
         if (parse_line(line, p, SIZE(p), file, line_num, msglevel, &options->gc))
         {
-            add_option(options, p, file, line_num, 0, msglevel, permission_mask, option_types_found, es);
+            add_option(options, p, false, file, line_num, 0, msglevel,
+                       permission_mask, option_types_found, es);
         }
     }
     return true;
@@ -4908,6 +4947,7 @@ set_user_script(struct options *options,
 static void
 add_option(struct options *options,
            char *p[],
+           bool is_inline,
            const char *file,
            int line,
            const int level,
@@ -5154,7 +5194,8 @@ add_option(struct options *options,
         {
             options->plugin_list = plugin_option_list_new(&options->gc);
         }
-        if (!plugin_option_list_add(options->plugin_list, &p[1], &options->gc))
+        if (!plugin_option_list_add(options->plugin_list, &p[1], is_inline,
+                                    &options->gc))
         {
             msg(msglevel, "plugin add failed: %s", p[1]);
             goto err;
@@ -5286,14 +5327,15 @@ add_option(struct options *options,
     else if (streq(p[0], "connection") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
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
@@ -5968,15 +6010,8 @@ add_option(struct options *options,
         struct http_proxy_options *ho;
         VERIFY_PERMISSION(OPT_P_GENERAL);
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
@@ -6496,7 +6531,7 @@ add_option(struct options *options,
     else if (streq(p[0], "push") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_PUSH);
-        push_options(options, &p[1], msglevel, &options->gc);
+        push_options(options, &p[1], is_inline, msglevel, &options->gc);
     }
     else if (streq(p[0], "push-reset") && !p[1])
     {
@@ -7436,11 +7471,9 @@ add_option(struct options *options,
     else if (streq(p[0], "secret") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            options->shared_secret_file_inline = p[2];
-        }
-        else if (p[2])
+        options->shared_secret_file = p[1];
+        options->shared_secret_file_inline = is_inline;
+        if (!is_inline && p[2])
         {
             int key_direction;
 
@@ -7454,7 +7487,6 @@ add_option(struct options *options,
                 goto err;
             }
         }
-        options->shared_secret_file = p[1];
     }
     else if (streq(p[0], "genkey") && !p[1])
     {
@@ -7633,14 +7665,11 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->tls_client = true;
     }
-    else if (streq(p[0], "ca") && p[1] && ((streq(p[1], INLINE_FILE_TAG) && p[2]) || !p[2]) && !p[3])
+    else if (streq(p[0], "ca") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->ca_file = p[1];
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            options->ca_file_inline = p[2];
-        }
+        options->ca_file_inline = is_inline;
     }
 #ifndef ENABLE_CRYPTO_MBEDTLS
     else if (streq(p[0], "capath") && p[1] && !p[2])
@@ -7649,32 +7678,23 @@ add_option(struct options *options,
         options->ca_path = p[1];
     }
 #endif /* ENABLE_CRYPTO_MBEDTLS */
-    else if (streq(p[0], "dh") && p[1] && ((streq(p[1], INLINE_FILE_TAG) && p[2]) || !p[2]) && !p[3])
+    else if (streq(p[0], "dh") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
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
         VERIFY_PERMISSION(OPT_P_GENERAL);
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
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->extra_certs_file = p[1];
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            options->extra_certs_file_inline = p[2];
-        }
+        options->extra_certs_file_inline = is_inline;
     }
     else if (streq(p[0], "verify-hash") && p[1] && !p[2])
     {
@@ -7688,14 +7708,11 @@ add_option(struct options *options,
         options->cryptoapi_cert = p[1];
     }
 #endif
-    else if (streq(p[0], "key") && p[1] && ((streq(p[1], INLINE_FILE_TAG) && p[2]) || !p[2]) && !p[3])
+    else if (streq(p[0], "key") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->priv_key_file = p[1];
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            options->priv_key_file_inline = p[2];
-        }
+        options->priv_key_file_inline = is_inline;
     }
     else if (streq(p[0], "tls-version-min") && p[1] && !p[3])
     {
@@ -7726,14 +7743,11 @@ add_option(struct options *options,
         options->ssl_flags |= (ver << SSLF_TLS_VERSION_MAX_SHIFT);
     }
 #ifndef ENABLE_CRYPTO_MBEDTLS
-    else if (streq(p[0], "pkcs12") && p[1] && ((streq(p[1], INLINE_FILE_TAG) && p[2]) || !p[2]) && !p[3])
+    else if (streq(p[0], "pkcs12") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->pkcs12_file = p[1];
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            options->pkcs12_file_inline = p[2];
-        }
+        options->pkcs12_file_inline = is_inline;
     }
 #endif /* ENABLE_CRYPTO_MBEDTLS */
     else if (streq(p[0], "askpass") && !p[2])
@@ -7787,7 +7801,7 @@ add_option(struct options *options,
         options->cipher_list = p[1];
     }
     else if (streq(p[0], "crl-verify") && p[1] && ((p[2] && streq(p[2], "dir"))
-                                                   || (p[2] && streq(p[1], INLINE_FILE_TAG) ) || !p[2]) && !p[3])
+                                                   || !p[2]))
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         if (p[2] && streq(p[2], "dir"))
@@ -7795,10 +7809,7 @@ add_option(struct options *options,
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
@@ -7971,11 +7982,9 @@ add_option(struct options *options,
     else if (streq(p[0], "tls-auth") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            options->tls_auth_file_inline = p[2];
-        }
-        else if (p[2])
+        options->tls_auth_file = p[1];
+        options->tls_auth_file_inline = is_inline;
+        if (!is_inline && p[2])
         {
             int key_direction;
 
@@ -7989,16 +7998,12 @@ add_option(struct options *options,
                 goto err;
             }
         }
-        options->tls_auth_file = p[1];
     }
     else if (streq(p[0], "tls-crypt") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
-        {
-            options->tls_crypt_inline = p[2];
-        }
         options->tls_crypt_file = p[1];
+        options->tls_crypt_inline = is_inline;
     }
     else if (streq(p[0], "key-method") && p[1] && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b3ab029..00b0cb7 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -468,7 +468,7 @@ struct options
 #ifdef ENABLE_CRYPTO
     /* Cipher parms */
     const char *shared_secret_file;
-    const char *shared_secret_file_inline;
+    bool shared_secret_file_inline;
     int key_direction;
     const char *ciphername;
     bool ncp_enabled;
@@ -507,13 +507,13 @@ struct options
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
@@ -560,11 +560,11 @@ struct options
 
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
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 17eb2d8..d3e4188 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -160,13 +160,13 @@ plugin_option_list_new(struct gc_arena *gc)
     return ret;
 }
 
-bool
-plugin_option_list_add(struct plugin_option_list *list, char **p, struct gc_arena *gc)
+bool plugin_option_list_add(struct plugin_option_list *list, char **p,
+                            bool is_inline, struct gc_arena *gc)
 {
     if (list->n < MAX_PLUGINS)
     {
         struct plugin_option *o = &list->plugins[list->n++];
-        o->argv = make_extended_arg_array(p, gc);
+        o->argv = make_extended_arg_array(p, is_inline, gc);
         if (o->argv[0])
         {
             o->so_pathname = o->argv[0];
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 4ded529..86a64ed 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -107,7 +107,8 @@ struct plugin_return
 
 struct plugin_option_list *plugin_option_list_new(struct gc_arena *gc);
 
-bool plugin_option_list_add(struct plugin_option_list *list, char **p, struct gc_arena *gc);
+bool plugin_option_list_add(struct plugin_option_list *list, char **p,
+                            bool is_inline, struct gc_arena *gc);
 
 #ifndef ENABLE_SMALL
 void plugin_option_list_print(const struct plugin_option_list *list, int msglevel);
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index f515475..a1f1090 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -564,9 +564,10 @@ clone_push_list(struct options *o)
 }
 
 void
-push_options(struct options *o, char **p, int msglevel, struct gc_arena *gc)
+push_options(struct options *o, char **p, bool is_inline, int msglevel,
+             struct gc_arena *gc)
 {
-    const char **argv = make_extended_arg_array(p, gc);
+    const char **argv = make_extended_arg_array(p, is_inline, gc);
     char *opt = print_argv(argv, gc, 0);
     push_option(o, opt, msglevel);
 }
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 86900c8..89807de 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -58,7 +58,8 @@ void clone_push_list(struct options *o);
 
 void push_option(struct options *o, const char *opt, int msglevel);
 
-void push_options(struct options *o, char **p, int msglevel, struct gc_arena *gc);
+void push_options(struct options *o, char **p, bool is_inline, int msglevel,
+                  struct gc_arena *gc);
 
 void push_reset(struct options *o);
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index cff4052..4fab645 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -542,7 +542,7 @@ tls_version_parse(const char *vstr, const char *extra)
  */
 static void
 tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
-                   const char *crl_file_inline)
+                   bool crl_file_inline)
 {
     /* if something goes wrong with stat(), we'll store 0 as mtime */
     platform_stat_t crl_stat = {0};
@@ -645,8 +645,8 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
         {
             char *external_certificate = management_query_cert(management,
                                                                options->management_certificate);
-            tls_ctx_use_external_private_key(new_ctx, INLINE_FILE_TAG,
-                                             external_certificate);
+            tls_ctx_use_external_private_key(new_ctx, external_certificate,
+                                             true);
             free(external_certificate);
         }
     }
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 206400f..ef9887b 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -192,11 +192,12 @@ void tls_ctx_check_cert_time(const struct tls_root_ctx *ctx);
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
@@ -214,15 +215,15 @@ void tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
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
@@ -242,26 +243,27 @@ void tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert
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
-                           const char *priv_key_file_inline
-                           );
+                           bool priv_key_file_inline);
 
 #ifdef MANAGMENT_EXTERNAL_KEY
 
@@ -271,14 +273,16 @@ int tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
  *
  * @param ctx                   TLS context to use
  * @param cert_file             The file name to load the certificate from, or
- *                              "[[INLINE]]" in the case of inline files.
- * @param cert_file_inline      A string containing the certificate
+ *                              a string containing the certificate in the case
+ *                              of inline files.
+ * @param cert_file_inline      True if cert_file is an inline file.
  *
  * @return                      1 if an error occurred, 0 if parsing was
  *                              successful.
  */
 int tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
-                                     const char *cert_file, const char *cert_file_inline);
+                                     const char *cert_file,
+                                     bool cert_file_inline);
 
 #endif
 
@@ -290,13 +294,13 @@ int tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
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
@@ -306,12 +310,14 @@ void tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
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
@@ -354,11 +360,11 @@ void key_state_ssl_free(struct key_state_ssl *ks_ssl);
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
index 9a16d77..75b129f 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -266,7 +266,7 @@ struct tls_options
     int verify_x509_type;
     const char *verify_x509_name;
     const char *crl_file;
-    const char *crl_file_inline;
+    bool crl_file_inline;
     int ns_cert_type;
     unsigned remote_cert_ku[MAX_PARMS];
     const char *remote_cert_eku;
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 5c84e30..f5ff18b 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -270,13 +270,13 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 
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
@@ -306,9 +306,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
 
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
-                    const char *pkcs12_file_inline,
-                    bool load_ca_file
-                    )
+                    bool pkcs12_file_inline, bool load_ca_file)
 {
     msg(M_FATAL, "PKCS #12 files not yet supported for mbed TLS.");
     return 0;
@@ -324,8 +322,7 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
 
 void
 tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
-                       const char *cert_inline
-                       )
+                       bool cert_inline)
 {
     ASSERT(NULL != ctx);
 
@@ -334,10 +331,11 @@ tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
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
@@ -353,8 +351,7 @@ tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
 
 int
 tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
-                       const char *priv_key_inline
-                       )
+                       bool priv_key_inline)
 {
     int status;
     ASSERT(NULL != ctx);
@@ -364,19 +361,20 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
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
@@ -398,7 +396,8 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
             management_auth_failure(management, UP_TYPE_PRIVATE_KEY, NULL);
         }
 #endif
-        msg(M_WARN, "Cannot load private key file %s", priv_key_file);
+        msg(M_WARN, "Cannot load private key file %s",
+            print_if_inline(priv_key_file, priv_key_inline));
         return 1;
     }
 
@@ -571,7 +570,7 @@ external_key_len(void *vctx)
 
 int
 tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
-                                 const char *cert_file, const char *cert_file_inline)
+                                 const char *cert_file, bool cert_file_inline)
 {
     ASSERT(NULL != ctx);
 
@@ -598,18 +597,18 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
 
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
@@ -626,8 +625,7 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
 
 void
 tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
-                         const char *extra_certs_inline
-                         )
+                         bool extra_certs_inline)
 {
     ASSERT(NULL != ctx);
 
@@ -636,11 +634,11 @@ tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
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
@@ -862,7 +860,7 @@ tls_version_to_major_minor(int tls_ver, int *major, int *minor) {
 
 void
 backend_tls_ctx_reload_crl(struct tls_root_ctx *ctx, const char *crl_file,
-                           const char *crl_inline)
+                           bool crl_inline)
 {
     ASSERT(crl_file);
 
@@ -872,10 +870,11 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ctx, const char *crl_file,
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
index eae1e22..365b9fd 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -432,17 +432,16 @@ cleanup:
 
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
@@ -461,7 +460,8 @@ tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
 
     if (!dh)
     {
-        crypto_msg(M_FATAL, "Cannot load DH parameters from %s", dh_file);
+        crypto_msg(M_FATAL, "Cannot load DH parameters from %s",
+                   print_if_inline(dh_file, dh_file_inline));
     }
     if (!SSL_CTX_set_tmp_dh(ctx->ctx, dh))
     {
@@ -556,9 +556,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
 
 int
 tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
-                    const char *pkcs12_file_inline,
-                    bool load_ca_file
-                    )
+                    bool pkcs12_file_inline, bool load_ca_file)
 {
     FILE *fp;
     EVP_PKEY *pkey;
@@ -570,11 +568,11 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
 
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
@@ -719,14 +717,12 @@ tls_ctx_add_extra_certs(struct tls_root_ctx *ctx, BIO *bio)
 
 /* Like tls_ctx_load_cert, but returns a copy of the certificate in **X509 */
 static void
-tls_ctx_load_cert_file_and_copy(struct tls_root_ctx *ctx,
-                                const char *cert_file, const char *cert_file_inline, X509 **x509
-                                )
+tls_ctx_load_cert_file_and_copy(struct tls_root_ctx *ctx, const char *cert_file,
+                                bool cert_file_inline, X509 **x509)
 {
     BIO *in = NULL;
     X509 *x = NULL;
     int ret = 0;
-    bool inline_file = false;
 
     ASSERT(NULL != ctx);
     if (NULL != x509)
@@ -734,11 +730,9 @@ tls_ctx_load_cert_file_and_copy(struct tls_root_ctx *ctx,
         ASSERT(NULL == *x509);
     }
 
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
@@ -768,7 +762,7 @@ tls_ctx_load_cert_file_and_copy(struct tls_root_ctx *ctx,
 end:
     if (!ret)
     {
-        if (inline_file)
+        if (cert_file_inline)
         {
             crypto_msg(M_FATAL, "Cannot load inline certificate file");
         }
@@ -794,7 +788,7 @@ end:
 
 void
 tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
-                       const char *cert_file_inline)
+                       bool cert_file_inline)
 {
     tls_ctx_load_cert_file_and_copy(ctx, cert_file, cert_file_inline, NULL);
 }
@@ -807,8 +801,7 @@ tls_ctx_free_cert_file(X509 *x509)
 
 int
 tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
-                       const char *priv_key_file_inline
-                       )
+                       bool priv_key_file_inline)
 {
     SSL_CTX *ssl_ctx = NULL;
     BIO *in = NULL;
@@ -819,9 +812,9 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
 
     ssl_ctx = ctx->ctx;
 
-    if (!strcmp(priv_key_file, INLINE_FILE_TAG) && priv_key_file_inline)
+    if (priv_key_file_inline)
     {
-        in = BIO_new_mem_buf((char *)priv_key_file_inline, -1);
+        in = BIO_new_mem_buf((char *) priv_key_file, -1);
     }
     else
     {
@@ -849,7 +842,8 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
             management_auth_failure(management, UP_TYPE_PRIVATE_KEY, NULL);
         }
 #endif
-        crypto_msg(M_WARN, "Cannot load private key file %s", priv_key_file);
+        crypto_msg(M_WARN, "Cannot load private key file %s",
+                   print_if_inline(priv_key_file, priv_key_file_inline));
         goto end;
     }
 
@@ -874,7 +868,7 @@ end:
 
 void
 backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
-                           const char *crl_inline)
+                           bool crl_inline)
 {
     X509_CRL *crl = NULL;
     BIO *in = NULL;
@@ -902,9 +896,9 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
 
     X509_STORE_set_flags(store, X509_V_FLAG_CRL_CHECK | X509_V_FLAG_CRL_CHECK_ALL);
 
-    if (!strcmp(crl_file, INLINE_FILE_TAG) && crl_inline)
+    if (crl_inline)
     {
-        in = BIO_new_mem_buf((char *)crl_inline, -1);
+        in = BIO_new_mem_buf((char *) crl_file, -1);
     }
     else
     {
@@ -913,20 +907,23 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
 
     if (in == NULL)
     {
-        msg(M_WARN, "CRL: cannot read: %s", crl_file);
+        msg(M_WARN, "CRL: cannot read: %s",
+            print_if_inline(crl_file, crl_inline));
         goto end;
     }
 
     crl = PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
     if (crl == NULL)
     {
-        msg(M_WARN, "CRL: cannot read CRL from file %s", crl_file);
+        msg(M_WARN, "CRL: cannot read CRL from file %s",
+            print_if_inline(crl_file, crl_inline));
         goto end;
     }
 
     if (!X509_STORE_add_crl(store, crl))
     {
-        msg(M_WARN, "CRL: cannot add %s to store", crl_file);
+        msg(M_WARN, "CRL: cannot add %s to store",
+            print_if_inline(crl_file, crl_inline));
         goto end;
     }
 
@@ -1027,7 +1024,7 @@ done:
 
 int
 tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
-                                 const char *cert_file, const char *cert_file_inline)
+                                 const char *cert_file, bool cert_file_inline)
 {
     RSA *rsa = NULL;
     RSA *pub_rsa;
@@ -1112,9 +1109,7 @@ sk_x509_name_cmp(const X509_NAME *const *a, const X509_NAME *const *b)
 
 void
 tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
-                const char *ca_file_inline,
-                const char *ca_path, bool tls_server
-                )
+                bool ca_file_inline, const char *ca_path, bool tls_server)
 {
     STACK_OF(X509_INFO) *info_stack = NULL;
     STACK_OF(X509_NAME) *cert_names = NULL;
@@ -1135,9 +1130,9 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
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
@@ -1209,11 +1204,12 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
                     {
                         crypto_msg(M_WARN,
                                    "Cannot load CA certificate file %s (entry %d did not validate)",
-                                   np(ca_file), added);
+
+			                       print_if_inline(ca_file, ca_file_inline),
+                                   added);
                     }
                     prev = cnum;
                 }
-
             }
             sk_X509_INFO_pop_free(info_stack, X509_INFO_free);
         }
@@ -1227,7 +1223,7 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
         {
             crypto_msg(M_FATAL,
                        "Cannot load CA certificate file %s (no entries were read)",
-                       np(ca_file));
+                       print_if_inline(ca_file, ca_file_inline));
         }
 
         if (tls_server)
@@ -1237,7 +1233,8 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
             {
                 crypto_msg(M_FATAL, "Cannot load CA certificate file %s (only %d "
                            "of %d entries were valid X509 names)",
-                           np(ca_file), cnum, added);
+                           print_if_inline(ca_file, ca_file_inline), cnum,
+                           added);
             }
         }
 
@@ -1265,13 +1262,12 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
 
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
@@ -1280,7 +1276,9 @@ tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
 
     if (in == NULL)
     {
-        crypto_msg(M_FATAL, "Cannot load extra-certs file: %s", extra_certs_file);
+        crypto_msg(M_FATAL, "Cannot load extra-certs file: %s",
+                   print_if_inline(extra_certs_file, extra_certs_file_inline));
+
     }
     else
     {
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index c227b09..383c8ca 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -44,7 +44,7 @@ tls_crypt_buf_overhead(void)
 
 void
 tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
-                   const char *key_inline, bool tls_server) {
+                   bool key_inline, bool tls_server) {
     const int key_direction = tls_server ?
                               KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVERSE;
 
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index 47f75d0..801127b 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -92,13 +92,14 @@
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
2.11.0


