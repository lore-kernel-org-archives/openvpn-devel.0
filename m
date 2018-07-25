From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 25 Jul 2018 18:08:53 +0200
Message-ID: <1532534933-3858-7-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1532534933-3858-1-git-send-email-steffan.karger@...1435...>
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1532534933-3858-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 7/7] tls-crypt-v2: add script hook to
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
parse_line() to the tls-crypt unit tests.

Signed-off-by: Antonio Quartulli <antonio@...515...>
Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v3: rebase on curent master / v3 patch set

 Changes.rst                               | 12 ++++++
 doc/openvpn.8                             | 35 ++++++++++++++--
 src/openvpn/init.c                        |  1 +
 src/openvpn/options.c                     |  7 ++++
 src/openvpn/options.h                     |  2 +
 src/openvpn/ssl.c                         | 16 ++++---
 src/openvpn/ssl_common.h                  |  1 +
 src/openvpn/tls_crypt.c                   | 69 ++++++++++++++++++++++++++++++-
 src/openvpn/tls_crypt.h                   |  3 +-
 tests/unit_tests/openvpn/Makefile.am      | 12 ++++--
 tests/unit_tests/openvpn/test_tls_crypt.c | 18 +++++++-
 11 files changed, 161 insertions(+), 15 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index a6090cf..e77b3d7 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -1,3 +1,15 @@
+Overview of changes in 2.5
+==========================
+
+New features
+------------
+Client-specific tls-crypt keys (``--tls-crypt-v2``)
+    ``tls-crypt-v2`` adds the ability to supply each client with a unique
+    tls-crypt key.  This allows large organisations and VPN providers to profit
+    from the same DoS and TLS stack protection that small deployments can
+    already achieve using ``tls-auth`` or ``tls-crypt``.
+
+
 Overview of changes in 2.4
 ==========================
 
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 597c0c4..cb61a53 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5296,9 +5296,38 @@ If supplied, include the supplied
 in the wrapped client key.  This metadata must be supplied in base64\-encoded
 form.  The metadata must be at most 735 bytes long (980 bytes in base64).
 
-.B TODO
-Metadata handling is not yet implemented.  This text will be updated by the
-commit that introduces metadata handling.
+If no metadata is supplied, OpenVPN will use a 64-bit unix timestamp
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
+to verify the metadata of the client-specific tls-crypt-v2 key of a connecting
+client.  This allows server administrators to reject client connections, before
+exposing the TLS stack (including the notoriously dangerous X.509 and ASN.1
+stacks) to the connecting client.
+
+OpenVPN supplies the following env vars to the command:
+.RS
+.IP \[bu] 2
+script_type is set to "tls-crypt-v2-verify"
+.IP \[bu]
+metadata_type is set to "0" is the metadata was user supplied, or "1" if it's a
+64-bit unix timestamp representing the key creation time.
+.IP \[bu]
+metadata_file contains the filename of a temporary file that contains the client
+metadata.
+.RE
+
+.IP
+The command can reject the connection by exitingwith a non-zero exit code.
 .\"*********************************************************
 .TP
 .B \-\-askpass [file]
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 01667c3..a349d42 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2887,6 +2887,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         if (options->tls_server)
         {
             to.tls_wrap.tls_crypt_v2_server_key = c->c1.ks.tls_crypt_v2_server_key;
+            to.tls_crypt_v2_verify_script = c->options.tls_crypt_v2_verify_script;
         }
     }
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8ce5cf4..bd324fd 100644
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
@@ -8176,6 +8178,11 @@ add_option(struct options *options,
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
index 3d2c770..d5ceb18 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -590,6 +590,8 @@ struct options
     const char *tls_crypt_v2_genkey_file;
     const char *tls_crypt_v2_metadata;
 
+    const char *tls_crypt_v2_verify_script;
+
     /* Allow only one session */
     bool single_session;
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index dcae279..4cf7619 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1541,14 +1541,15 @@ write_control_auth(struct tls_session *session,
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
@@ -3629,7 +3630,8 @@ tls_pre_decrypt(struct tls_multi *multi,
                     goto error;
                 }
 
-                if (!read_control_auth(buf, &session->tls_wrap, from))
+                if (!read_control_auth(buf, &session->tls_wrap, from,
+                                       session->opt))
                 {
                     goto error;
                 }
@@ -3682,7 +3684,8 @@ tls_pre_decrypt(struct tls_multi *multi,
                 if (op == P_CONTROL_SOFT_RESET_V1
                     && DECRYPT_KEY_ENABLED(multi, ks))
                 {
-                    if (!read_control_auth(buf, &session->tls_wrap, from))
+                    if (!read_control_auth(buf, &session->tls_wrap, from,
+                                           session->opt))
                     {
                         goto error;
                     }
@@ -3703,7 +3706,8 @@ tls_pre_decrypt(struct tls_multi *multi,
                         do_burst = true;
                     }
 
-                    if (!read_control_auth(buf, &session->tls_wrap, from))
+                    if (!read_control_auth(buf, &session->tls_wrap, from,
+                                           session->opt))
                     {
                         goto error;
                     }
@@ -3905,7 +3909,7 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
             bool status;
 
             /* HMAC test, if --tls-auth was specified */
-            status = read_control_auth(&newbuf, &tls_wrap_tmp, from);
+            status = read_control_auth(&newbuf, &tls_wrap_tmp, from, NULL);
             free_buf(&newbuf);
             if (tls_wrap_tmp.cleanup_key_ctx)
             {
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index d744881..923cd95 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -293,6 +293,7 @@ struct tls_options
     bool ncp_enabled;
 
     bool tls_crypt_v2;
+    const char *tls_crypt_v2_verify_script;
 
     /** TLS handshake wrapping state */
     struct tls_wrap_ctx tls_wrap;
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 87e4fd4..8c6d739 100644
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
 
@@ -542,9 +544,69 @@ error_exit:
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
@@ -595,6 +657,11 @@ tls_crypt_v2_extract_client_key(struct buffer *buf,
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
index edee590..3dc2661 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -193,7 +193,8 @@ void tls_crypt_v2_init_client_key(struct key_ctx_bi *key,
  * @returns true if a key was successfully extracted.
  */
 bool tls_crypt_v2_extract_client_key(struct buffer *buf,
-                                     struct tls_wrap_ctx *ctx);
+                                     struct tls_wrap_ctx *ctx,
+                                     const struct tls_options *opt);
 
 /**
  * Generate a tls-crypt-v2 server key, and write to file.
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 6e7fa20..e5ffba9 100644
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
 
@@ -59,14 +62,17 @@ packet_id_testdriver_SOURCES = test_packet_id.c mock_msg.c \
 tls_crypt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
 	$(OPTIONAL_CRYPTO_CFLAGS) $(OPTIONAL_PKCS11_HELPER_CFLAGS)
-tls_crypt_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
+tls_crypt_testdriver_LDFLAGS = @TEST_LDFLAGS@ -Wl,--wrap=parse_line \
 	$(OPTIONAL_CRYPTO_LIBS)
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
index 22c7486..897adce 100644
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
@@ -350,7 +366,7 @@ tls_crypt_v2_wrap_unwrap_max_metadata(void **state) {
             .mode = TLS_WRAP_CRYPT,
             .tls_crypt_v2_server_key = ctx->server_keys.encrypt,
     };
-    assert_true(tls_crypt_v2_extract_client_key(&ctx->wkc, &wrap_ctx));
+    assert_true(tls_crypt_v2_extract_client_key(&ctx->wkc, &wrap_ctx, NULL));
 }
 
 /**
-- 
2.7.4


