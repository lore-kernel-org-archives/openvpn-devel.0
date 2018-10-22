From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 22 Oct 2018 13:45:15 +0200
Message-ID: <1540208715-14044-6-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7 7/7] tls-crypt-v2: add script hook to
 verify metadata
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
Cc: Steffan Karger <steffan.karger@...1435...>, Antonio Quartulli <antonio@...515...>

To allow rejecting incoming connections very early in the handshake,
add a --tls-crypt-v2-verify option that allows administators to
run an external command to verify the metadata from the client key.
See doc/tls-crypt-v2.txt for more details.

Because of the extra dependencies, this requires adding a mock
parse_line() to the tls-crypt unit tests.  Also, this turns tls_wrap_free
into a static inline function, so that we don't need to compile in ssl.c
(and all of it's dependencies) with the unit tests.

Signed-off-by: Antonio Quartulli <antonio@...515...>
Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v3: rebase on curent master / v3 patch set
v4: fix memory leak (metadata buffer was not free'd for tls_wrap_tmp)
v5: rebase on v5 patch set, textual fixes in man page
v6: fix memory leak in unit tests, code style fixes
v7: rebase on patch set v7

 Changes.rst                               |  6 +++
 doc/openvpn.8                             | 35 ++++++++++++++--
 src/openvpn/init.c                        |  1 +
 src/openvpn/options.c                     |  7 ++++
 src/openvpn/options.h                     |  2 +
 src/openvpn/ssl.c                         | 34 +++++----------
 src/openvpn/ssl.h                         | 18 ++++++++
 src/openvpn/ssl_common.h                  |  1 +
 src/openvpn/tls_crypt.c                   | 69 ++++++++++++++++++++++++++++++-
 src/openvpn/tls_crypt.h                   |  3 +-
 tests/unit_tests/openvpn/Makefile.am      | 12 ++++--
 tests/unit_tests/openvpn/test_tls_crypt.c | 19 ++++++++-
 12 files changed, 175 insertions(+), 32 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 70ce2e1..a7429b1 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -3,6 +3,12 @@ Overview of changes in 2.5
 
 New features
 ------------
+Client-specific tls-crypt keys (``--tls-crypt-v2``)
+    ``tls-crypt-v2`` adds the ability to supply each client with a unique
+    tls-crypt key.  This allows large organisations and VPN providers to profit
+    from the same DoS and TLS stack protection that small deployments can
+    already achieve using ``tls-auth`` or ``tls-crypt``.
+
 ChaCha20-Poly1305 cipher support
     Added support for using the ChaCha20-Poly1305 cipher in the OpenVPN data
     channel.
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 56a71c9..94b5cc4 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5310,9 +5310,38 @@ If supplied, include the supplied
 in the wrapped client key.  This metadata must be supplied in base64\-encoded
 form.  The metadata must be at most 735 bytes long (980 bytes in base64).
 
-.B TODO
-Metadata handling is not yet implemented.  This text will be updated by the
-commit that introduces metadata handling.
+If no metadata is supplied, OpenVPN will use a 64\-bit unix timestamp
+representing the current time in UTC, encoded in network order, as metadata for
+the generated key.
+
+Servers can use
+.B \-\-tls\-crypt\-v2\-verify
+to specify a metadata verification command.
+.\"*********************************************************
+.TP
+.B \-\-tls\-crypt\-v2\-verify cmd
+
+Run command
+.B cmd
+to verify the metadata of the client\-specific tls\-crypt\-v2 key of a
+connecting client.  This allows server administrators to reject client
+connections, before exposing the TLS stack (including the notoriously dangerous
+X.509 and ASN.1 stacks) to the connecting client.
+
+OpenVPN supplies the following env vars to the command:
+.RS
+.IP \[bu] 2
+script_type is set to "tls\-crypt\-v2\-verify"
+.IP \[bu]
+metadata_type is set to "0" if the metadata was user supplied, or "1" if it's a
+64\-bit unix timestamp representing the key creation time.
+.IP \[bu]
+metadata_file contains the filename of a temporary file that contains the client
+metadata.
+.RE
+
+.IP
+The command can reject the connection by exiting with a non-zero exit code.
 .\"*********************************************************
 .TP
 .B \-\-askpass [file]
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 8a8bb00..882337b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2903,6 +2903,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         if (options->tls_server)
         {
             to.tls_wrap.tls_crypt_v2_server_key = c->c1.ks.tls_crypt_v2_server_key;
+            to.tls_crypt_v2_verify_script = c->options.tls_crypt_v2_verify_script;
         }
     }
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index dfe5e6e..9e30d7d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -629,6 +629,8 @@ static const char usage_message[] =
     "--tls-crypt-v2-genkey client|server keyfile [base64 metadata]: Generate a\n"
     "                  fresh tls-crypt-v2 client or server key, and store to\n"
     "                  keyfile.  If supplied, include metadata in wrapped key.\n"
+    "--tls-crypt-v2-verify cmd : Run command cmd to verify the metadata of the\n"
+    "                  client-supplied tls-crypt-v2 client key\n"
     "--askpass [file]: Get PEM password from controlling tty before we daemonize.\n"
     "--auth-nocache  : Don't cache --askpass or --auth-user-pass passwords.\n"
     "--crl-verify crl ['dir']: Check peer certificate against a CRL.\n"
@@ -8131,6 +8133,11 @@ add_option(struct options *options,
             options->tls_crypt_v2_metadata = p[3];
         }
     }
+    else if (streq(p[0], "tls-crypt-v2-verify") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->tls_crypt_v2_verify_script = p[1];
+    }
     else if (streq(p[0], "key-method") && p[1] && !p[2])
     {
         int key_method;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index bc180ca..575777f 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -591,6 +591,8 @@ struct options
     const char *tls_crypt_v2_genkey_file;
     const char *tls_crypt_v2_metadata;
 
+    const char *tls_crypt_v2_verify_script;
+
     /* Allow only one session */
     bool single_session;
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 86e7877..74b88ce 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1048,23 +1048,6 @@ tls_session_user_pass_enabled(struct tls_session *session)
 /** @addtogroup control_processor
  *  @{ */
 
-/** Free the elements of a tls_wrap_ctx structure */
-static void tls_wrap_free(struct tls_wrap_ctx *tls_wrap)
-{
-    if (packet_id_initialized(&tls_wrap->opt.packet_id))
-    {
-        packet_id_free(&tls_wrap->opt.packet_id);
-    }
-
-    if (tls_wrap->cleanup_key_ctx)
-    {
-        free_key_ctx_bi(&tls_wrap->opt.key_ctx_bi);
-    }
-
-    free_buf(&tls_wrap->tls_crypt_v2_metadata);
-    free_buf(&tls_wrap->work);
-}
-
 /** @name Functions for initialization and cleanup of tls_session structures
  *  @{ */
 
@@ -1534,14 +1517,15 @@ write_control_auth(struct tls_session *session,
 static bool
 read_control_auth(struct buffer *buf,
                   struct tls_wrap_ctx *ctx,
-                  const struct link_socket_actual *from)
+                  const struct link_socket_actual *from,
+                  const struct tls_options *opt)
 {
     struct gc_arena gc = gc_new();
     bool ret = false;
 
     const uint8_t opcode = *(BPTR(buf)) >> P_OPCODE_SHIFT;
     if (opcode == P_CONTROL_HARD_RESET_CLIENT_V3
-        && !tls_crypt_v2_extract_client_key(buf, ctx))
+        && !tls_crypt_v2_extract_client_key(buf, ctx, opt))
     {
         msg (D_TLS_ERRORS,
              "TLS Error: can not extract tls-crypt-v2 client key from %s",
@@ -3622,7 +3606,8 @@ tls_pre_decrypt(struct tls_multi *multi,
                     goto error;
                 }
 
-                if (!read_control_auth(buf, &session->tls_wrap, from))
+                if (!read_control_auth(buf, &session->tls_wrap, from,
+                                       session->opt))
                 {
                     goto error;
                 }
@@ -3675,7 +3660,8 @@ tls_pre_decrypt(struct tls_multi *multi,
                 if (op == P_CONTROL_SOFT_RESET_V1
                     && DECRYPT_KEY_ENABLED(multi, ks))
                 {
-                    if (!read_control_auth(buf, &session->tls_wrap, from))
+                    if (!read_control_auth(buf, &session->tls_wrap, from,
+                                           session->opt))
                     {
                         goto error;
                     }
@@ -3696,7 +3682,8 @@ tls_pre_decrypt(struct tls_multi *multi,
                         do_burst = true;
                     }
 
-                    if (!read_control_auth(buf, &session->tls_wrap, from))
+                    if (!read_control_auth(buf, &session->tls_wrap, from,
+                                           session->opt))
                     {
                         goto error;
                     }
@@ -3898,8 +3885,9 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
             bool status;
 
             /* HMAC test, if --tls-auth was specified */
-            status = read_control_auth(&newbuf, &tls_wrap_tmp, from);
+            status = read_control_auth(&newbuf, &tls_wrap_tmp, from, NULL);
             free_buf(&newbuf);
+            free_buf(&tls_wrap_tmp.tls_crypt_v2_metadata);
             if (tls_wrap_tmp.cleanup_key_ctx)
             {
                 free_key_ctx_bi(&tls_wrap_tmp.opt.key_ctx_bi);
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 023330c..ac6fef7 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -527,6 +527,24 @@ bool tls_item_in_cipher_list(const char *item, const char *list);
  * inline functions
  */
 
+/** Free the elements of a tls_wrap_ctx structure */
+static inline void
+tls_wrap_free(struct tls_wrap_ctx *tls_wrap)
+{
+    if (packet_id_initialized(&tls_wrap->opt.packet_id))
+    {
+        packet_id_free(&tls_wrap->opt.packet_id);
+    }
+
+    if (tls_wrap->cleanup_key_ctx)
+    {
+        free_key_ctx_bi(&tls_wrap->opt.key_ctx_bi);
+    }
+
+    free_buf(&tls_wrap->tls_crypt_v2_metadata);
+    free_buf(&tls_wrap->work);
+}
+
 static inline bool
 tls_initial_packet_received(const struct tls_multi *multi)
 {
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 2b3e8a1..7bf82b3 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -293,6 +293,7 @@ struct tls_options
     bool ncp_enabled;
 
     bool tls_crypt_v2;
+    const char *tls_crypt_v2_verify_script;
 
     /** TLS handshake wrapping state */
     struct tls_wrap_ctx tls_wrap;
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index d830faa..d70d0a6 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -29,9 +29,11 @@
 
 #include "syshead.h"
 
+#include "argv.h"
 #include "base64.h"
 #include "crypto.h"
 #include "platform.h"
+#include "run_command.h"
 #include "session_id.h"
 #include "ssl.h"
 
@@ -544,9 +546,69 @@ error_exit:
     return ret;
 }
 
+static bool
+tls_crypt_v2_verify_metadata(const struct tls_wrap_ctx *ctx,
+                             const struct tls_options *opt)
+{
+    bool ret = false;
+    struct gc_arena gc = gc_new();
+    const char *tmp_file = NULL;
+    struct buffer metadata = ctx->tls_crypt_v2_metadata;
+    int metadata_type = buf_read_u8(&metadata);
+    if (metadata_type < 0)
+    {
+        msg(M_WARN, "ERROR: no metadata type");
+        goto cleanup;
+    }
+
+    tmp_file = platform_create_temp_file(opt->tmp_dir, "tls_crypt_v2_metadata_",
+                                         &gc);
+    if (!tmp_file || !buffer_write_file(tmp_file, &metadata))
+    {
+        msg(M_WARN, "ERROR: could not write metadata to file");
+        goto cleanup;
+    }
+
+    char metadata_type_str[4] = { 0 }; /* Max value: 255 */
+    openvpn_snprintf(metadata_type_str, sizeof(metadata_type_str),
+                     "%i", metadata_type);
+    struct env_set *es = env_set_create(NULL);
+    setenv_str(es, "script_type", "tls-crypt-v2-verify");
+    setenv_str(es, "metadata_type", metadata_type_str);
+    setenv_str(es, "metadata_file", tmp_file);
+
+    struct argv argv = argv_new();
+    argv_parse_cmd(&argv, opt->tls_crypt_v2_verify_script);
+    argv_msg_prefix(D_TLS_DEBUG, &argv, "Executing tls-crypt-v2-verify");
+
+    ret = openvpn_run_script(&argv, es, 0, "--tls-crypt-v2-verify");
+
+    argv_reset(&argv);
+    env_set_destroy(es);
+
+    if (!platform_unlink(tmp_file))
+    {
+        msg(M_WARN, "WARNING: failed to remove temp file '%s", tmp_file);
+    }
+
+    if (ret)
+    {
+        msg(D_HANDSHAKE, "TLS CRYPT V2 VERIFY SCRIPT OK");
+    }
+    else
+    {
+        msg(D_HANDSHAKE, "TLS CRYPT V2 VERIFY SCRIPT ERROR");
+    }
+
+cleanup:
+    gc_free(&gc);
+    return ret;
+}
+
 bool
 tls_crypt_v2_extract_client_key(struct buffer *buf,
-                                struct tls_wrap_ctx *ctx)
+                                struct tls_wrap_ctx *ctx,
+                                const struct tls_options *opt)
 {
     if (!ctx->tls_crypt_v2_server_key.cipher)
     {
@@ -597,6 +659,11 @@ tls_crypt_v2_extract_client_key(struct buffer *buf,
     /* Remove client key from buffer so tls-crypt code can unwrap message */
     ASSERT(buf_inc_len(buf, -(BLEN(&wrapped_client_key))));
 
+    if (opt && opt->tls_crypt_v2_verify_script)
+    {
+        return tls_crypt_v2_verify_metadata(ctx, opt);
+    }
+
     return true;
 }
 
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index edf297a..9b5ea97 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -195,7 +195,8 @@ void tls_crypt_v2_init_client_key(struct key_ctx_bi *key,
  * @returns true if a key was successfully extracted.
  */
 bool tls_crypt_v2_extract_client_key(struct buffer *buf,
-                                     struct tls_wrap_ctx *ctx);
+                                     struct tls_wrap_ctx *ctx,
+                                     const struct tls_options *opt);
 
 /**
  * Generate a tls-crypt-v2 server key, and write to file.
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 22a458a..b4304e3 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -6,7 +6,10 @@ if HAVE_LD_WRAP_SUPPORT
 check_PROGRAMS += argv_testdriver buffer_testdriver
 endif
 
-check_PROGRAMS += crypto_testdriver packet_id_testdriver tls_crypt_testdriver
+check_PROGRAMS += crypto_testdriver packet_id_testdriver
+if HAVE_LD_WRAP_SUPPORT
+check_PROGRAMS += tls_crypt_testdriver
+endif
 
 TESTS = $(check_PROGRAMS)
 
@@ -52,13 +55,16 @@ packet_id_testdriver_SOURCES = test_packet_id.c mock_msg.c \
 
 tls_crypt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
-tls_crypt_testdriver_LDFLAGS = @TEST_LDFLAGS@
+tls_crypt_testdriver_LDFLAGS = @TEST_LDFLAGS@ -Wl,--wrap=parse_line
 tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c \
+	$(openvpn_srcdir)/argv.c \
 	$(openvpn_srcdir)/base64.c \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/crypto.c \
 	$(openvpn_srcdir)/crypto_mbedtls.c \
 	$(openvpn_srcdir)/crypto_openssl.c \
+	$(openvpn_srcdir)/env_set.c \
 	$(openvpn_srcdir)/otime.c \
 	$(openvpn_srcdir)/packet_id.c \
-	$(openvpn_srcdir)/platform.c
+	$(openvpn_srcdir)/platform.c \
+	$(openvpn_srcdir)/run_command.c
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 6cdf4ed..62721e8 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -43,8 +43,24 @@
 
 #define TESTBUF_SIZE            128
 
+/* Defines for use in the tests and the mock parse_line() */
+#define PATH1       "/s p a c e"
+#define PATH2       "/foo bar/baz"
+#define PARAM1      "param1"
+#define PARAM2      "param two"
+
 const char plaintext_short[1];
 
+int
+__wrap_parse_line(const char *line, char **p, const int n, const char *file,
+                  const int line_num, int msglevel, struct gc_arena *gc)
+{
+    p[0] = PATH1 PATH2;
+    p[1] = PARAM1;
+    p[2] = PARAM2;
+    return 3;
+}
+
 struct test_tls_crypt_context {
     struct crypto_options co;
     struct key_type kt;
@@ -351,7 +367,8 @@ tls_crypt_v2_wrap_unwrap_max_metadata(void **state) {
             .mode = TLS_WRAP_CRYPT,
             .tls_crypt_v2_server_key = ctx->server_keys.encrypt,
     };
-    assert_true(tls_crypt_v2_extract_client_key(&ctx->wkc, &wrap_ctx));
+    assert_true(tls_crypt_v2_extract_client_key(&ctx->wkc, &wrap_ctx, NULL));
+    tls_wrap_free(&wrap_ctx);
 }
 
 /**
-- 
2.7.4


