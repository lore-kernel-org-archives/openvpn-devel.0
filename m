From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 8 Dec 2017 13:07:43 +0100
Message-ID: <1512734870-17133-4-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 03/10] tls-crypt-v2: generate client keys
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

As a first step towards a full tls-crypt-v2 implementation, add
functionality to generate tls-crypt-v2 client keys.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 doc/openvpn.8                        |  51 +++++++
 src/openvpn/buffer.c                 |  63 ++++++++
 src/openvpn/buffer.h                 |   6 +
 src/openvpn/init.c                   |  35 ++++-
 src/openvpn/integer.h                |  10 ++
 src/openvpn/options.c                |  37 +++++
 src/openvpn/options.h                |   9 ++
 src/openvpn/tls_crypt.c              | 284 +++++++++++++++++++++++++++++++++++
 src/openvpn/tls_crypt.h              |  81 +++++++++-
 tests/t_lpback.sh                    |  40 ++++-
 tests/unit_tests/openvpn/Makefile.am |   1 +
 11 files changed, 601 insertions(+), 16 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 2b5cab1..0719087 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5199,6 +5199,57 @@ degrading to the same security as using
 That is, the control channel still benefits from the extra protection against
 active man\-in\-the\-middle\-attacks and DoS attacks, but may no longer offer
 extra privacy and post\-quantum security on top of what TLS itself offers.
+
+For large setups or setups where clients are not trusted, consider using
+.B \-\-tls\-crypt\-v2
+instead.  That uses per\-client unique keys, and thereby improves the bounds to
+\fR'rotate a client key at least once per 8000 years'.
+.\"*********************************************************
+.TP
+.B \-\-tls\-crypt\-v2 keyfile
+
+Use client\-specific tls\-crypt keys.
+
+For clients,
+.B keyfile
+is a client\-specific tls\-crypt key.  Such a key can be generated using the
+.B \-\-tls\-crypt\-v2\-genkey
+option.
+
+For servers,
+.B keyfile
+is used to unwrap client\-specific keys supplied by the client during connection
+setup.  This key must be the same as the key used to generate the
+client\-specific key (see
+.B \-\-tls\-crypt\-v2\-genkey\fR).
+
+On servers, this option can be used together with the
+.B \-\-tls\-auth
+or
+.B \-\-tls\-crypt
+option.  In that case, the server will detect whether the client is using
+client\-specific keys, and automatically select the right mode.
+.\"*********************************************************
+.TP
+.B \-\-tls\-crypt\-v2\-genkey client|server keyfile [metadata]
+
+If the first parameter equals "server", generate a \-\-tls\-crypt\-v2 server
+key and store the key in
+.B keyfile\fR.
+
+
+If the first parameter equals "client", generate a \-\-tls\-crypt\-v2 client
+key, and store the key in
+.B keyfile\fR.
+
+If supplied, include the supplied
+.B metadata
+in the wrapped client key.  This metadata must be supplied in base64\-encoded
+form.  The metadata must be at most 735 bytes long (980 bytes in base64).
+
+.B TODO
+Metadata handling is not yet implemented.  This text will be updated by the
+commit that introduces metadata handling.
 .\"*********************************************************
 .TP
 .B \-\-askpass [file]
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index ecd3b17..09dc2fd 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -315,6 +315,69 @@ convert_to_one_line(struct buffer *buf)
     }
 }
 
+bool
+buffer_write_file(const char *filename, const struct buffer *buf)
+{
+    bool ret = false;
+    int fd = platform_open(filename, O_CREAT | O_TRUNC | O_WRONLY,
+                           S_IRUSR | S_IWUSR);
+    if (fd == -1)
+    {
+        msg(M_ERRNO, "Cannot open file '%s' for write", filename);
+        goto cleanup;
+    }
+
+    const int size = write(fd, BPTR(buf), BLEN(buf));
+    if (size != BLEN(buf))
+    {
+        msg(M_ERRNO, "Write error on file '%s'", filename);
+        goto cleanup;
+    }
+
+    ret = true;
+cleanup:
+    if (close(fd))
+    {
+        msg(M_ERRNO, "Close error on file %s", filename);
+        ret = false;
+    }
+    return ret;
+}
+
+struct buffer
+buffer_read_from_file(const char *filename, struct gc_arena *gc)
+{
+    struct buffer ret = { 0 };
+
+    platform_stat_t file_stat = {0};
+    if (platform_stat(filename, &file_stat) < 0)
+    {
+        return ret;
+    }
+
+    FILE *fp = platform_fopen(filename, "r");
+    if (!fp)
+    {
+        return ret;
+    }
+
+    const size_t size = file_stat.st_size;
+    ret = alloc_buf_gc(size + 1, gc); /* Space for trailing \0 */
+    ssize_t read_size = fread(BPTR(&ret), 1, size, fp);
+    if (read_size < 0)
+    {
+        free_buf(&ret);
+        goto cleanup;
+    }
+    ASSERT(buf_inc_len(&ret, read_size));
+    buf_null_terminate(&ret);
+
+cleanup:
+    fclose(fp);
+    return ret;
+}
+
+
 /* NOTE: requires that string be null terminated */
 void
 buf_write_string_file(const struct buffer *buf, const char *filename, int fd)
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 84ad3ef..d15af07 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -469,6 +469,12 @@ const char *skip_leading_whitespace(const char *str);
 
 void string_null_terminate(char *str, int len, int capacity);
 
+/** Write buffer contents to file */
+bool buffer_write_file(const char *filename, const struct buffer *buf);
+
+/** Read file contents. Returns invalid buffer on error. */
+struct buffer buffer_read_from_file(const char *filename, struct gc_arena *gc);
+
 /*
  * Write string in buf to file descriptor fd.
  * NOTE: requires that string be null terminated.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 30beadb..3e694b9 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1027,6 +1027,11 @@ print_openssl_info(const struct options *options)
 bool
 do_genkey(const struct options *options)
 {
+    /* should we disable paging? */
+    if (options->mlock && (options->genkey || options->tls_crypt_v2_genkey_file))
+    {
+        platform_mlockall(true);
+    }
     if (options->genkey)
     {
         int nbits_written;
@@ -1034,11 +1039,6 @@ do_genkey(const struct options *options)
         notnull(options->shared_secret_file,
                 "shared secret output file (--secret)");
 
-        if (options->mlock)     /* should we disable paging? */
-        {
-            platform_mlockall(true);
-        }
-
         nbits_written = write_key_file(2, options->shared_secret_file);
 
         msg(D_GENKEY | M_NOPREFIX,
@@ -1046,6 +1046,31 @@ do_genkey(const struct options *options)
             options->shared_secret_file);
         return true;
     }
+    if (options->tls_crypt_v2_genkey_type)
+    {
+        if(!strcmp(options->tls_crypt_v2_genkey_type, "server"))
+        {
+            tls_crypt_v2_write_server_key_file(options->tls_crypt_v2_genkey_file);
+            return true;
+        }
+        else if (options->tls_crypt_v2_genkey_type
+                 && !strcmp(options->tls_crypt_v2_genkey_type, "client"))
+        {
+            if (!options->tls_crypt_v2_file)
+            {
+                msg(M_USAGE, "--tls-crypt-v2-gen-client-key requires a server key to be set via --tls-crypt-v2");
+            }
+
+            tls_crypt_v2_write_client_key_file(options->tls_crypt_v2_genkey_file,
+                    options->tls_crypt_v2_metadata, options->tls_crypt_v2_file,
+                    options->tls_crypt_v2_inline);
+            return true;
+        }
+        else
+        {
+            msg(M_USAGE, "--tls-crypt-v2-genkey type should be \"client\" or \"server\"");
+        }
+    }
     return false;
 }
 
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index 9bb00a3..02edc63 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -26,6 +26,16 @@
 
 #include "error.h"
 
+#ifndef htonll
+#define htonll(x) ((1==htonl(1)) ? (x) : \
+                  ((uint64_t)htonl((x) & 0xFFFFFFFF) << 32) | htonl((x) >> 32))
+#endif
+
+#ifndef ntohll
+#define ntohll(x) ((1==ntohl(1)) ? (x) : \
+                  ((uint64_t)ntohl((x) & 0xFFFFFFFF) << 32) | ntohl((x) >> 32))
+#endif
+
 /*
  * min/max functions
  */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7be5f38..aa73fd9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -621,6 +621,13 @@ static const char usage_message[] =
     "                  attacks on the TLS stack and DoS attacks.\n"
     "                  key (required) provides the pre-shared key file.\n"
     "                  see --secret option for more info.\n"
+    "--tls-crypt-v2 key : For clients: use key as a client-specific tls-crypt key.\n"
+    "                  For servers: use key to decrypt client-specific keys.  For\n"
+    "                  key generation (--tls-crypt-v2-genkey): use key to\n"
+    "                  encrypt generated client-specific key.  (See --tls-crypt.)\n"
+    "--tls-crypt-v2-genkey client|server keyfile [base64 metadata]: Generate a\n"
+    "                  fresh tls-crypt-v2 client or server key, and store to\n"
+    "                  keyfile.  If supplied, include metadata in wrapped key.\n"
     "--askpass [file]: Get PEM password from controlling tty before we daemonize.\n"
     "--auth-nocache  : Don't cache --askpass or --auth-user-pass passwords.\n"
     "--crl-verify crl ['dir']: Check peer certificate against a CRL.\n"
@@ -1775,6 +1782,10 @@ show_settings(const struct options *o)
 
     SHOW_STR(tls_auth_file);
     SHOW_STR(tls_crypt_file);
+    SHOW_STR(tls_crypt_v2_file);
+    SHOW_STR(tls_crypt_v2_genkey_type);
+    SHOW_STR(tls_crypt_v2_genkey_file);
+    SHOW_STR(tls_crypt_v2_metadata);
 
 #ifdef ENABLE_PKCS11
     {
@@ -2727,6 +2738,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         MUST_BE_UNDEF(transition_window);
         MUST_BE_UNDEF(tls_auth_file);
         MUST_BE_UNDEF(tls_crypt_file);
+        MUST_BE_UNDEF(tls_crypt_v2_file);
         MUST_BE_UNDEF(single_session);
         MUST_BE_UNDEF(push_peer_info);
         MUST_BE_UNDEF(tls_exit);
@@ -3274,6 +3286,12 @@ options_postprocess_filechecks(struct options *options)
     errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
                               options->tls_crypt_file, R_OK, "--tls-crypt");
     errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
+                              options->tls_crypt_v2_file, R_OK,
+                              "--tls-crypt-v2");
+    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
+                              options->tls_crypt_v2_genkey_file, R_OK,
+                              "--tls-crypt-v2-genkey");
+    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
                               options->shared_secret_file, R_OK, "--secret");
     errs |= check_file_access(CHKACC_DIRPATH|CHKACC_FILEXSTWR,
                               options->packet_id_file, R_OK|W_OK, "--replay-persist");
@@ -8010,6 +8028,25 @@ add_option(struct options *options,
         }
         options->tls_crypt_file = p[1];
     }
+    else if (streq(p[0], "tls-crypt-v2") && p[1] && !p[3])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        if (streq(p[1], INLINE_FILE_TAG) && p[2])
+        {
+            options->tls_crypt_v2_inline = p[2];
+        }
+        options->tls_crypt_v2_file = p[1];
+    }
+    else if (streq(p[0], "tls-crypt-v2-genkey") && p[2] && !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->tls_crypt_v2_genkey_type = p[1];
+        options->tls_crypt_v2_genkey_file = p[2];
+        if (p[3])
+        {
+            options->tls_crypt_v2_metadata = p[3];
+        }
+    }
     else if (streq(p[0], "key-method") && p[1] && !p[2])
     {
         int key_method;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f70760c..7d995c3 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -566,6 +566,15 @@ struct options
     const char *tls_crypt_file;
     const char *tls_crypt_inline;
 
+    /* Client-specific secret or server key used for TLS control channel
+     * authenticated encryption v2 */
+    const char *tls_crypt_v2_file;
+    const char *tls_crypt_v2_inline;
+
+    const char *tls_crypt_v2_genkey_type;
+    const char *tls_crypt_v2_genkey_file;
+    const char *tls_crypt_v2_metadata;
+
     /* Allow only one session */
     bool single_session;
 
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index d9c67c3..fb4ac84 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -29,11 +29,21 @@
 
 #include "syshead.h"
 
+#include "base64.h"
 #include "crypto.h"
+#include "platform.h"
 #include "session_id.h"
 
 #include "tls_crypt.h"
 
+const char *tls_crypt_v2_cli_pem_name = "OpenVPN tls-crypt-v2 client key";
+const char *tls_crypt_v2_srv_pem_name = "OpenVPN tls-crypt-v2 server key";
+
+/** Metadata contains user-specified data */
+static const uint8_t TLS_CRYPT_METADATA_TYPE_USER           = 0x00;
+/** Metadata contains a 64-bit unix timestamp in network byte order */
+static const uint8_t TLS_CRYPT_METADATA_TYPE_TIMESTAMP      = 0x01;
+
 static struct key_type
 tls_crypt_kt(void)
 {
@@ -264,3 +274,277 @@ error_exit:
     gc_free(&gc);
     return false;
 }
+
+static inline bool
+tls_crypt_v2_read_keyfile(struct buffer *key, const char *pem_name,
+                          const char *key_file, const char *key_inline)
+{
+    bool ret = false;
+    struct buffer key_pem = { 0 };
+    struct gc_arena gc = gc_new();
+
+    if (strcmp(key_file, INLINE_FILE_TAG))
+    {
+        key_pem = buffer_read_from_file(key_file, &gc);
+        if (!buf_valid(&key_pem))
+        {
+            msg(M_WARN, "ERROR: failed to read tls-crypt-v2 key file (%s)",
+                key_file);
+            goto cleanup;
+        }
+    }
+    else
+    {
+        buf_set_read(&key_pem, (const void *)key_inline, strlen(key_inline));
+    }
+
+    if (!crypto_pem_decode(pem_name, key, &key_pem))
+    {
+        msg(M_WARN, "ERROR: tls-crypt-v2 pem decode failed");
+        goto cleanup;
+    }
+
+    ret = true;
+cleanup:
+    if (strcmp(key_file, INLINE_FILE_TAG))
+    {
+        buf_clear(&key_pem);
+    }
+    gc_free(&gc);
+    return ret;
+}
+
+static inline void
+tls_crypt_v2_load_client_key(struct key_ctx_bi *key, const struct key2 *key2,
+                             bool tls_server)
+{
+    const int key_direction = tls_server ?
+                              KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVERSE;
+    struct key_type kt = tls_crypt_kt();
+    if (!kt.cipher || !kt.digest)
+    {
+        msg (M_FATAL, "ERROR: --tls-crypt not supported");
+    }
+    init_key_ctx_bi(key, key2, key_direction, &kt,
+                    "Control Channel Encryption");
+}
+
+void
+tls_crypt_v2_init_client_key(struct key_ctx_bi *key, struct buffer *wkc_buf,
+                             const char *key_file, const char *key_inline)
+{
+    struct buffer client_key = alloc_buf(TLS_CRYPT_V2_CLIENT_KEY_LEN
+                                         + TLS_CRYPT_V2_MAX_WKC_LEN);
+
+    if (!tls_crypt_v2_read_keyfile(&client_key, tls_crypt_v2_cli_pem_name,
+                                   key_file, key_inline))
+    {
+        msg(M_FATAL, "ERROR: invalid tls-crypt-v2 client key format");
+    }
+
+    struct key2 key2;
+    if (!buf_read(&client_key, &key2.keys, sizeof(key2.keys)))
+    {
+        msg (M_FATAL, "ERROR: not enough data in tls-crypt-v2 client key");
+    }
+
+    tls_crypt_v2_load_client_key(key, &key2, false);
+    secure_memzero(&key2, sizeof(key2));
+
+    *wkc_buf = client_key;
+}
+
+void
+tls_crypt_v2_init_server_key(struct key_ctx *key_ctx, bool encrypt,
+                             const char *key_file, const char *key_inline)
+{
+    struct key srv_key;
+    struct buffer srv_key_buf;
+
+    buf_set_write(&srv_key_buf, (void *) &srv_key, sizeof(srv_key));
+    if (!tls_crypt_v2_read_keyfile(&srv_key_buf, tls_crypt_v2_srv_pem_name,
+                                   key_file, key_inline))
+    {
+        msg(M_FATAL, "ERROR: invalid tls-crypt-v2 server key format");
+    }
+
+    struct key_type kt = tls_crypt_kt();
+    if (!kt.cipher || !kt.digest)
+    {
+        msg (M_FATAL, "ERROR: --tls-crypt not supported");
+    }
+    init_key_ctx(key_ctx, &srv_key, &kt, encrypt, "tls-crypt-v2 server key");
+    secure_memzero(&srv_key, sizeof(srv_key));
+}
+
+static bool
+tls_crypt_v2_wrap_client_key(struct buffer *wkc,
+                             const struct key2 *src_key,
+                             const struct buffer *src_metadata,
+                             struct key_ctx *server_key, struct gc_arena *gc)
+{
+    cipher_ctx_t *cipher_ctx = server_key->cipher;
+    struct buffer work = alloc_buf_gc(TLS_CRYPT_V2_MAX_WKC_LEN
+                                      + cipher_ctx_block_size(cipher_ctx), gc);
+
+    /* Calculate auth tag and synthetic IV */
+    uint8_t *tag = buf_write_alloc(&work, TLS_CRYPT_TAG_SIZE);
+    if (!tag)
+    {
+        msg (M_WARN, "ERROR: could not write tag");
+        return false;
+    }
+    hmac_ctx_t *hmac_ctx = server_key->hmac;
+    hmac_ctx_reset(hmac_ctx);
+    hmac_ctx_update(hmac_ctx, (void*)src_key->keys, sizeof(src_key->keys));
+    hmac_ctx_update(hmac_ctx, BPTR(src_metadata), BLEN(src_metadata));
+    hmac_ctx_final(hmac_ctx, tag);
+
+    dmsg(D_CRYPTO_DEBUG, "TLS-CRYPT WRAP TAG: %s",
+         format_hex(tag, TLS_CRYPT_TAG_SIZE, 0, gc));
+
+    /* Use the 128 most significant bits of the tag as IV */
+    ASSERT(cipher_ctx_reset(cipher_ctx, tag));
+
+    /* Overflow check (OpenSSL requires an extra block in the dst buffer) */
+    if (buf_forward_capacity(&work) < (sizeof(src_key->keys)
+                                       + BLEN(src_metadata)
+                                       + cipher_ctx_block_size(cipher_ctx)))
+    {
+        msg (M_WARN, "ERROR: could not crypt: insufficient space in dst");
+        return false;
+    }
+
+    /* Encrypt */
+    int outlen = 0;
+    ASSERT(cipher_ctx_update(cipher_ctx, BEND(&work), &outlen,
+                             (void*)src_key->keys, sizeof(src_key->keys)));
+    ASSERT(buf_inc_len(&work, outlen));
+    ASSERT(cipher_ctx_update(cipher_ctx, BEND(&work), &outlen,
+                             BPTR(src_metadata), BLEN(src_metadata)));
+    ASSERT(buf_inc_len(&work, outlen));
+    ASSERT(cipher_ctx_final(cipher_ctx, BEND(&work), &outlen));
+    ASSERT(buf_inc_len(&work, outlen));
+
+    return buf_copy(wkc, &work);
+}
+
+void
+tls_crypt_v2_write_server_key_file(const char *filename)
+{
+    struct gc_arena gc = gc_new();
+    struct key server_key = { 0 };
+    struct buffer server_key_buf = clear_buf();
+    struct buffer server_key_pem = clear_buf();
+
+    if (!rand_bytes((void *)&server_key, sizeof(server_key)))
+    {
+        msg(M_NONFATAL, "ERROR: could not generate random key");
+        goto cleanup;
+    }
+    buf_set_read(&server_key_buf, (void *) &server_key, sizeof(server_key));
+    if (!crypto_pem_encode(tls_crypt_v2_srv_pem_name, &server_key_pem,
+                           &server_key_buf, &gc))
+    {
+        msg(M_WARN, "ERROR: could not PEM-encode client key");
+        goto cleanup;
+    }
+
+    if (!buffer_write_file(filename, &server_key_pem))
+    {
+        msg(M_ERR, "ERROR: could not write server key file");
+        goto cleanup;
+    }
+
+cleanup:
+    secure_memzero(&server_key, sizeof(server_key));
+    buf_clear(&server_key_pem);
+    gc_free(&gc);
+    return;
+}
+
+void
+tls_crypt_v2_write_client_key_file(const char *filename, const char *b64_metadata,
+                                   const char *server_key_file,
+                                   const char *server_key_inline)
+{
+    struct gc_arena gc = gc_new();
+    struct key_ctx server_key = { 0 };
+    struct buffer client_key_pem = { 0 };
+    struct buffer dst = alloc_buf_gc(TLS_CRYPT_V2_CLIENT_KEY_LEN
+                                     + TLS_CRYPT_V2_MAX_WKC_LEN, &gc);
+
+    struct key2 client_key = { 2 };
+    if (!rand_bytes((void*)client_key.keys, sizeof(client_key.keys)))
+    {
+        msg(M_FATAL, "ERROR: could not generate random key");
+        goto cleanup;
+    }
+    ASSERT(buf_write(&dst, client_key.keys, sizeof(client_key.keys)));
+
+    struct buffer metadata = alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &gc);
+    if (b64_metadata)
+    {
+        if (TLS_CRYPT_V2_MAX_B64_METADATA_LEN < strlen(b64_metadata))
+        {
+            msg(M_FATAL,
+                "ERROR: metadata too long (%d bytes, max %u bytes)",
+                (int) strlen(b64_metadata), TLS_CRYPT_V2_MAX_B64_METADATA_LEN);
+        }
+        ASSERT(buf_write(&metadata, &TLS_CRYPT_METADATA_TYPE_USER, 1));
+        int decoded_len = openvpn_base64_decode(b64_metadata, BPTR(&metadata),
+                                                BCAP(&metadata));
+        if (decoded_len < 0)
+        {
+            msg(M_FATAL, "ERROR: failed to base64 decode provided metadata");
+            goto cleanup;
+        }
+        ASSERT(buf_inc_len(&metadata, decoded_len));
+    }
+    else
+    {
+        int64_t timestamp = htonll(now);
+        ASSERT(buf_write(&metadata, &TLS_CRYPT_METADATA_TYPE_TIMESTAMP, 1));
+        ASSERT(buf_write(&metadata, &timestamp, sizeof(timestamp)));
+    }
+
+    tls_crypt_v2_init_server_key(&server_key, true, server_key_file,
+                                 server_key_inline);
+    if (!tls_crypt_v2_wrap_client_key(&dst, &client_key, &metadata, &server_key,
+                                      &gc))
+    {
+        msg (M_FATAL, "ERROR: could not wrap generated client key");
+        goto cleanup;
+    }
+
+    /* PEM-encode Kc || WKc */
+    if (!crypto_pem_encode(tls_crypt_v2_cli_pem_name, &client_key_pem, &dst,
+                           &gc))
+    {
+        msg(M_FATAL, "ERROR: could not PEM-encode client key");
+        goto cleanup;
+    }
+
+    if (!buffer_write_file(filename, &client_key_pem))
+    {
+        msg(M_FATAL, "ERROR: could not write client key file");
+        goto cleanup;
+    }
+
+    /* Sanity check: load client key (as "client") */
+    struct key_ctx_bi test_client_key;
+    struct buffer test_wrapped_client_key;
+    msg (D_GENKEY, "Testing client-side key loading...");
+    tls_crypt_v2_init_client_key(&test_client_key, &test_wrapped_client_key,
+                                 filename, NULL);
+    free_key_ctx_bi(&test_client_key);
+    free_buf(&test_wrapped_client_key);
+
+cleanup:
+    secure_memzero(&client_key, sizeof(client_key));
+    free_key_ctx(&server_key);
+    buf_clear(&client_key_pem);
+    buf_clear(&dst);
+
+    gc_free(&gc);
+}
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index e8080df..f4d3ca7 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -22,15 +22,13 @@
  */
 
 /**
- * @defgroup tls_crypt Control channel encryption (--tls-crypt)
+ * @defgroup tls_crypt Control channel encryption (--tls-crypt, --tls-crypt-v2)
  * @ingroup control_tls
  * @{
  *
- * @par
  * Control channel encryption uses a pre-shared static key (like the --tls-auth
  * key) to encrypt control channel packets.
  *
- * @par
  * Encrypting control channel packets has three main advantages:
  *  - It provides more privacy by hiding the certificate used for the TLS
  *    connection.
@@ -38,11 +36,20 @@
  *  - It provides "poor-man's" post-quantum security, against attackers who
  *    will never know the pre-shared key (i.e. no forward secrecy).
  *
- * @par Specification
+ * --tls-crypt uses a tls-auth-style group key, where all servers and clients
+ * share the same group key.  --tls-crypt-v2 adds support for client-specific
+ * keys, where all servers share the same client-key encryption key, and each
+ * clients receives a unique client key, both in plaintext and in encrypted
+ * form.  When connecting to a server, the client sends the encrypted key to
+ * the server in the first packet (P_CONTROL_HARD_RESET_CLIENT_V3).  The server
+ * then decrypts that key, and both parties can use the same client-specific
+ * key for tls-crypt packets.  See doc/tls-crypt-v2.txt for more details.
+ *
+ * @par On-the-wire tls-crypt packet specification
+ * @parblock
  * Control channel encryption is based on the SIV construction [0], to achieve
  * nonce misuse-resistant authenticated encryption:
  *
- * @par
  * \code{.unparsed}
  * msg      = control channel plaintext
  * header   = opcode (1 byte) || session_id (8 bytes) || packet_id (8 bytes)
@@ -57,18 +64,17 @@
  * output   = Header || Tag || Ciph
  * \endcode
  *
- * @par
  * This boils down to the following on-the-wire packet format:
  *
- * @par
  * \code{.unparsed}
  * - opcode - || - session_id - || - packet_id - || auth_tag || * payload *
  * \endcode
  *
- * @par
  * Where
  * <tt>- XXX -</tt> means authenticated, and
  * <tt>* XXX *</tt> means authenticated and encrypted.
+ *
+ * @endparblock
  */
 
 #ifndef TLSCRYPT_H
@@ -86,6 +92,15 @@
 #define TLS_CRYPT_OFF_TAG (TLS_CRYPT_OFF_PID + TLS_CRYPT_PID_SIZE)
 #define TLS_CRYPT_OFF_CT (TLS_CRYPT_OFF_TAG + TLS_CRYPT_TAG_SIZE)
 
+#define TLS_CRYPT_V2_MAX_WKC_LEN (1024)
+#define TLS_CRYPT_V2_CLIENT_KEY_LEN (2048/8)
+#define TLS_CRYPT_V2_SERVER_KEY_LEN (sizeof(struct key))
+#define TLS_CRYPT_V2_TAG_SIZE (TLS_CRYPT_TAG_SIZE)
+#define TLS_CRYPT_V2_MAX_METADATA_LEN (TLS_CRYPT_V2_MAX_WKC_LEN \
+         - (TLS_CRYPT_V2_CLIENT_KEY_LEN + TLS_CRYPT_V2_TAG_SIZE))
+#define TLS_CRYPT_V2_MAX_B64_METADATA_LEN \
+         ((((TLS_CRYPT_V2_MAX_METADATA_LEN - 1) * 8) + 5) / 6)
+
 /**
  * Initialize a key_ctx_bi structure for use with --tls-crypt.
  *
@@ -138,6 +153,56 @@ bool tls_crypt_wrap(const struct buffer *src, struct buffer *dst,
 bool tls_crypt_unwrap(const struct buffer *src, struct buffer *dst,
                       struct crypto_options *opt);
 
+/**
+ * Initialize a tls-crypt-v2 server key (used to encrypt/decrypt client keys).
+ *
+ * @param key           Key structure to be initialized.  Must be non-NULL.
+ * @parem encrypt       If true, initialize the key structure for encryption,
+ *                      otherwise for decryption.
+ * @param key_file      File path of the key file to load, or INLINE tag.
+ * @param key_inline    Inline key file contents (or NULL if not inline).
+ */
+void tls_crypt_v2_init_server_key(struct key_ctx *key_ctx, bool encrypt,
+                                  const char *key_file, const char *key_inline);
+
+/**
+ * Initialize a tls-crypt-v2 client key.
+ *
+ * @param key               Key structure to be initialized with the client
+ *                          key.
+ * @param wrapped_key_buf   Returns buffer containing the wrapped key that will
+ *                          be sent to the server when connecting.  Caller must
+ *                          free this buffer when no longer neede.
+ * @param key_file          File path of the key file to load, or INLINE tag.
+ * @param key_inline        Inline key file contents (or NULL if not inline).
+ */
+void tls_crypt_v2_init_client_key(struct key_ctx_bi *key,
+                                  struct buffer *wrapped_key_buf,
+                                  const char *key_file,
+                                  const char *key_inline);
+
+/**
+ * Generate a tls-crypt-v2 server key, and write to file.
+ *
+ * @param filename          Filename of the server key file to create.
+ */
+void tls_crypt_v2_write_server_key_file(const char *filename);
+
+/**
+ * Generate a tls-crypt-v2 client key, and write to file.
+ *
+ * @param filename          Filename of the client key file to create.
+ * @param b64_metadata      Base64 metadata to be included in the client key.
+ * @param server_key_file   File path of the server key to use for wrapping the
+ *                          client key, or INLINE tag.
+ * @param server_key_inline Inline server key file contents (or NULL if not
+ *                          inline).
+ */
+void tls_crypt_v2_write_client_key_file(const char *filename,
+                                        const char *b64_metadata,
+                                        const char *key_file,
+                                        const char *key_inline);
+
 /** @} */
 
 #endif /* TLSCRYPT_H */
diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index 2052c62..107e7c1 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -21,8 +21,8 @@
 
 set -eu
 top_builddir="${top_builddir:-..}"
-trap "rm -f key.$$ log.$$ ; trap 0 ; exit 77" 1 2 15
-trap "rm -f key.$$ log.$$ ; exit 1" 0 3
+trap "rm -f key.$$ tc-server-key.$$ tc-client-key.$$ log.$$ ; trap 0 ; exit 77" 1 2 15
+trap "rm -f key.$$ tc-server-key.$$ tc-client-key.$$ log.$$ ; exit 1" 0 3
 
 # Get list of supported ciphers from openvpn --show-ciphers output
 CIPHERS=$(${top_builddir}/src/openvpn/openvpn --show-ciphers | \
@@ -55,6 +55,40 @@ do
     fi
 done
 
-rm key.$$ log.$$
+echo -n "Testing tls-crypt-v2 server key generation..."
+"${top_builddir}/src/openvpn/openvpn" \
+    --tls-crypt-v2-genkey server tc-server-key.$$ >log.$$ 2>&1
+if [ $? != 0 ] ; then
+    echo "FAILED"
+    cat log.$$
+    e=1
+else
+    echo "OK"
+fi
+
+echo -n "Testing tls-crypt-v2 key generation (no metadata)..."
+"${top_builddir}/src/openvpn/openvpn" --tls-crypt-v2 tc-server-key.$$ \
+    --tls-crypt-v2-genkey client tc-client-key.$$ >log.$$ 2>&1
+if [ $? != 0 ] ; then
+    echo "FAILED"
+    cat log.$$
+    e=1
+else
+    echo "OK"
+fi
+
+echo -n "Testing tls-crypt-v2 key generation (max length metadata)..."
+"${top_builddir}/src/openvpn/openvpn" --tls-crypt-v2 tc-server-key.$$ \
+    --tls-crypt-v2-genkey client tc-client-key.$$ \
+    $(head -c735 /dev/zero | base64 -w0) >log.$$ 2>&1
+if [ $? != 0 ] ; then
+    echo "FAILED"
+    cat log.$$
+    e=1
+else
+    echo "OK"
+fi
+
+rm key.$$ tc-server-key.$$ tc-client-key.$$ log.$$
 trap 0
 exit $e
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index d100c21..937393d 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -60,6 +60,7 @@ tls_crypt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 tls_crypt_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
 tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c \
+	$(openvpn_srcdir)/base64.c \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/crypto.c \
 	$(openvpn_srcdir)/crypto_mbedtls.c \
-- 
2.7.4


