From: Arne Schwabe <arne@...1227...>
Date: Fri, 10 May 2019 14:11:11 +0200
Message-Id: <20190510121114.30468-5-arne@...1227...>
In-Reply-To: <20190510121114.30468-1-arne@...1227...>
References: <20190510121114.30468-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 4/7] Rewrite auth-token-gen to be based
 on HMAC based tokens
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

The previous auth-token implementation had a serious problem, especially when
paired with an unpatched OpenVPN client that keeps trying the auth-token
(commit e61b401a).

The auth-token-gen implementation forgot the auth-token on reconnect, this
lead to reconnect with auth-token never working.

This new implementation implements the auth-token in a stateles variant. By
using HMAC to sign the auth-token the server can verify if a token has been
authenticated and by checking the embedded timestamp in the token it can
also verify that the auth-token is still valid.

Using the new config directive auth-gen-token-secret instead of
extending auth-gen-token (--auth-gen-token [lifetime] [secret-key]) was
chosen to allow inlinening the secret key.

Patch V2: cleaned up code, use refactored read_pem_key_file function
Patch V3: clarify some design decision in the commit message
---
 doc/openvpn.8            |  25 ++++
 src/openvpn/Makefile.am  |   1 +
 src/openvpn/auth_token.c | 261 +++++++++++++++++++++++++++++++++++++++
 src/openvpn/auth_token.h | 116 +++++++++++++++++
 src/openvpn/init.c       |  28 ++++-
 src/openvpn/openvpn.h    |   1 +
 src/openvpn/options.c    |  22 +++-
 src/openvpn/options.h    |   4 +
 src/openvpn/push.c       |  70 +++++++++--
 src/openvpn/push.h       |   8 ++
 src/openvpn/ssl.c        |   7 +-
 src/openvpn/ssl_common.h |  36 +++---
 src/openvpn/ssl_verify.c | 182 ++++++++++++---------------
 13 files changed, 626 insertions(+), 135 deletions(-)
 create mode 100644 src/openvpn/auth_token.c
 create mode 100644 src/openvpn/auth_token.h

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 90a6be91..0ae617a3 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3720,6 +3720,9 @@ the token authentication internally and it will NOT do any
 additional authentications against configured external
 user/password authentication mechanisms.
 
+The tokens implemented by this mechanism include a initial timestamp
+and a renew timestamp and are secured by HMAC.
+
 The
 .B lifetime
 argument defines how long the generated token is valid.  The
@@ -3730,6 +3733,16 @@ This feature is useful for environments which is configured
 to use One Time Passwords (OTP) as part of the user/password
 authentications and that authentication mechanism does not
 implement any auth\-token support.
+.\"*********************************************************
+.TP
+.B \-\-auth\-gen\-token\-secret [file]
+Specifies a file that hold a secret for the HMAC used in
+.B \-\-auth\-gen\-token
+If not present OpenVPN will generate a random secret on startup. This file
+should be used if auth-token should valid after restarting a server or if
+client should be able to roam between multiple OpenVPN server with their
+auth\-token.
+
 .\"*********************************************************
 .TP
 .B \-\-opt\-verify
@@ -5769,6 +5782,17 @@ Servers can use
 .B \-\-tls\-crypt\-v2\-verify
 to specify a metadata verification command.
 .\"*********************************************************
+.TP
+.B \-\-genkey auth\-token [keyfile]
+Generate a new secret that can be used
+with
+.B \-\-auth\-gen\-token\-secret
+
+.B Note:
+this file should be kept secret to the server as anyone
+that access to this file will be to generate auth tokens
+that the OpenVPN server will accept as valid.
+.\"*********************************************************
 .SS TUN/TAP persistent tunnel config mode:
 Available with Linux 2.4.7+.  These options comprise a standalone mode
 of OpenVPN which can be used to create and delete persistent tunnels.
@@ -6980,6 +7004,7 @@ X509_1_C=KG
 OpenVPN allows including files in the main configuration for the
 .B \-\-ca, \-\-cert, \-\-dh, \-\-extra\-certs, \-\-key, \-\-pkcs12, \-\-secret,
 .B \-\-crl\-verify, \-\-http\-proxy\-user\-pass, \-\-tls\-auth,
+.B \-\-auth\-gen\-token\-secret
 .B \-\-tls\-crypt,
 and
 .B \-\-tls\-crypt-v2
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 197e62ba..78f94762 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -39,6 +39,7 @@ sbin_PROGRAMS = openvpn
 
 openvpn_SOURCES = \
 	argv.c argv.h \
+	auth_token.c auth_token.h \
 	base64.c base64.h \
 	basic.h \
 	buffer.c buffer.h \
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
new file mode 100644
index 00000000..dc8d68f6
--- /dev/null
+++ b/src/openvpn/auth_token.c
@@ -0,0 +1,261 @@
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#include "base64.h"
+#include "buffer.h"
+#include "crypto.h"
+#include "openvpn.h"
+#include "ssl_common.h"
+#include "auth_token.h"
+#include "push.h"
+#include "integer.h"
+#include "ssl.h"
+
+const char *auth_token_pem_name = "OpenVPN auth-token server key";
+
+
+/* Size of the data of the token (not b64 encoded and without prefix) */
+#define TOKEN_DATA_LEN (2 * sizeof(int64_t) + 32)
+
+static struct key_type
+auth_token_kt(void)
+{
+    struct key_type kt;
+    /* We do not encrypt our session tokens */
+    kt.cipher = NULL;
+    kt.digest = md_kt_get("SHA256");
+
+    if (!kt.digest)
+    {
+        msg(M_WARN, "ERROR: --tls-crypt requires HMAC-SHA-256 support.");
+        return (struct key_type) { 0 };
+    }
+
+    kt.hmac_length = md_kt_size(kt.digest);
+
+    return kt;
+}
+
+
+void
+auth_token_write_server_key_file(const char *filename)
+{
+    write_pem_key_file(filename, auth_token_pem_name);
+}
+
+void
+auth_token_init_secret(struct key_ctx *key_ctx, const char *key_file,
+                       const char *key_inline)
+{
+    struct key_type kt = auth_token_kt();
+
+    struct buffer server_secret_key = alloc_buf(2048);
+
+    if (!load_pem_file_or_ephemeral_key(&server_secret_key,
+                                        auth_token_pem_name, key_file,
+                                        key_inline))
+    {
+        msg(M_FATAL, "ERROR: Cannot load auth-token secret");
+    }
+
+    struct key key;
+
+    if (!buf_read(&server_secret_key, &key, sizeof(key)))
+    {
+        msg(M_FATAL, "ERROR: not enough data in auth-token secret");
+    }
+    init_key_ctx(key_ctx, &key, &kt, false, "auth-token secret");
+
+    free_buf(&server_secret_key);
+}
+
+void
+generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
+{
+    struct gc_arena gc = gc_new();
+
+    int64_t timestamp = htonll((uint64_t)now);
+    int64_t initial_timestamp = timestamp;
+
+    hmac_ctx_t *ctx = multi->opt.auth_token_key.hmac;
+    ASSERT(hmac_ctx_size(ctx) == 256/8);
+
+    if (multi->auth_token)
+    {
+        /* Just enough space to fit 8 bytes+ 1 extra to decode a non padded
+         * base64 string (multiple of 3 bytes). 9 bytes => 12 bytes base64
+         * bytes
+         */
+        char old_tstamp_decode[9];
+
+        /*
+         * reuse the same session id and timestamp and null terminate it at
+         * for base64 decode it only decodes the session id part of it
+         */
+        char *old_tsamp_initial = multi->auth_token + strlen(SESSION_ID_PREFIX);
+
+        old_tsamp_initial[12] = '\0';
+        ASSERT(openvpn_base64_decode(old_tsamp_initial, old_tstamp_decode, 9) == 9);
+        initial_timestamp = *((uint64_t *)(old_tstamp_decode));
+
+        /* free the auth-token, we will replace it with a new one */
+        free(multi->auth_token);
+    }
+    uint8_t hmac_output[256/8];
+
+    hmac_ctx_reset(ctx);
+    hmac_ctx_update(ctx, (uint8_t *) up->username, (int)strlen(up->username));
+    hmac_ctx_update(ctx, (uint8_t *) &initial_timestamp, sizeof(initial_timestamp));
+    hmac_ctx_update(ctx, (uint8_t *) &timestamp, sizeof(timestamp));
+    hmac_ctx_final(ctx, hmac_output);
+
+    /* Construct the unencoded session token */
+    struct buffer token = alloc_buf_gc(
+        2*sizeof(uint64_t)  + 256/8, &gc);
+
+    ASSERT(buf_write(&token, &initial_timestamp, sizeof(initial_timestamp)));
+    ASSERT(buf_write(&token, &timestamp, sizeof(timestamp)));
+    ASSERT(buf_write(&token, hmac_output, sizeof(hmac_output)));
+
+    char *b64output;
+    openvpn_base64_encode(BPTR(&token), BLEN(&token), &b64output);
+
+    struct buffer session_token = alloc_buf_gc(
+        strlen(SESSION_ID_PREFIX) + strlen(b64output) + 1, &gc);
+
+    ASSERT(buf_write(&session_token, SESSION_ID_PREFIX, strlen(SESSION_ID_PREFIX)));
+    ASSERT(buf_write(&session_token, b64output, (int)strlen(b64output)));
+    ASSERT(buf_write_u8(&session_token, 0));
+
+    free(b64output);
+
+    multi->auth_token = strdup((char *)BPTR(&session_token));
+
+    dmsg(D_SHOW_KEYS, "Generated token for client: %s",
+         multi->auth_token);
+
+    gc_free(&gc);
+}
+
+static bool
+check_hmac_token(hmac_ctx_t *ctx, const uint8_t *b64decoded, const char *username)
+{
+    ASSERT(hmac_ctx_size(ctx) == 256/8);
+
+    uint8_t hmac_output[256/8];
+
+    hmac_ctx_reset(ctx);
+    hmac_ctx_update(ctx, (uint8_t *) username, (int)strlen(username));
+    hmac_ctx_update(ctx, b64decoded, TOKEN_DATA_LEN - 256/8);
+    hmac_ctx_final(ctx, hmac_output);
+
+    const uint8_t *hmac = b64decoded + TOKEN_DATA_LEN - 256/8;
+    return memcmp_constant_time(&hmac_output, hmac, 32) == 0;
+}
+
+unsigned int
+verify_auth_token(struct user_pass *up, struct tls_multi *multi,
+                  struct tls_session *session)
+{
+    /*
+     * Base64 is <= input and input is < USER_PASS_LEN, so using USER_PASS_LEN
+     * is safe here but a bit overkill
+     */
+    uint8_t b64decoded[USER_PASS_LEN];
+    int decoded_len = openvpn_base64_decode(up->password + strlen(SESSION_ID_PREFIX),
+                                            b64decoded, USER_PASS_LEN);
+    /* Ensure that the decoded data is at least the size of the
+     * timestamp + hmac */
+
+    if (decoded_len != TOKEN_DATA_LEN)
+    {
+        msg(M_WARN, "ERROR: --auth-token wrong size (%d!=%d)",
+            decoded_len, (int) TOKEN_DATA_LEN);
+        return 0;
+    }
+
+    unsigned int ret = 0;
+
+
+    const uint8_t *tstamp_initial = b64decoded;
+    const uint8_t *tstamp = tstamp_initial + sizeof(int64_t);
+
+    uint64_t timestamp = ntohll(*((uint64_t *) (tstamp)));
+    uint64_t timestamp_initial = ntohll(*((uint64_t *) (tstamp_initial)));
+
+    hmac_ctx_t *ctx = multi->opt.auth_token_key.hmac;
+    if (check_hmac_token(ctx, b64decoded, up->username))
+    {
+        ret |= AUTH_TOKEN_HMAC_OK;
+    }
+    else
+    {
+        msg(M_WARN, "--auth-token-gen: HMAC on token from client failed (%s)",
+            up->username);
+        return 0;
+    }
+
+    /* Accept session tokens that not expired are in the acceptable range
+     * for renogiations */
+    bool in_renog_time = now >= timestamp
+                         && now < timestamp + 2 * session->opt->renegotiate_seconds;
+
+    /* We could still have a client that does not update
+     * its auth-token, so also allow the initial auth-token */
+    bool initialtoken = multi->auth_token_initial
+                        && memcmp_constant_time(up->password, multi->auth_token_initial,
+                                                strlen(multi->auth_token_initial)) == 0;
+
+    if (!in_renog_time && !initialtoken)
+    {
+        ret |= AUTH_TOKEN_EXPIRED;
+    }
+
+    /* Sanity check the initial timestamp */
+    if (timestamp < timestamp_initial)
+    {
+        msg(M_WARN, "Initial timestamp (%lld) in token from client earlier than "
+            "current timestamp (%lld). Broken/unsynchronised clock?",
+            timestamp_initial, timestamp);
+        ret |= AUTH_TOKEN_EXPIRED;
+    }
+
+    if (multi->opt.auth_token_lifetime
+        && now > timestamp_initial + multi->opt.auth_token_lifetime)
+    {
+        ret |= AUTH_TOKEN_EXPIRED;
+    }
+
+    if (ret & AUTH_TOKEN_EXPIRED)
+    {
+        msg(M_INFO, "--auth-token-gen: auth-token from client expired");
+    }
+
+    return ret;
+}
+
+void
+wipe_auth_token(struct tls_multi *multi)
+{
+    if (multi)
+    {
+        if (multi->auth_token)
+        {
+            secure_memzero(multi->auth_token, strlen(multi->auth_token));
+            free(multi->auth_token);
+        }
+        if (multi->auth_token_initial)
+        {
+            secure_memzero(multi->auth_token_initial,
+                           strlen(multi->auth_token_initial));
+            free(multi->auth_token_initial);
+        }
+        multi->auth_token = NULL;
+        multi->auth_token_initial = NULL;
+    }
+}
diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
new file mode 100644
index 00000000..600ac29f
--- /dev/null
+++ b/src/openvpn/auth_token.h
@@ -0,0 +1,116 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#ifndef AUTH_TOKEN_H
+#define AUTH_TOKEN_H
+
+/**
+ * Generate an auth token based on username and timestamp
+ *
+ * The idea of auth token is to be stateless, so that we can verify use it
+ * even after we have forgotten about it or server has been restarted.
+ *
+ * To achieve this even though we cannot trust the client we use HMAC
+ * to be able to verify the information.
+ *
+ * Format of the auth-token (before base64 encode)
+ *
+ * uint64 timestamp (4 bytes)|uint64 timestamp (4 bytes)|sha256-hmac(32 bytes)
+ *
+ * The first timestamp is the time the token was initially created and is used to
+ * determine the maximum renewable time of the token. We always include this even
+ * if tokens do not expire (this value is not used) to keep the code cleaner.
+ *
+ * The second timestamp is the time the token was renewed/regenerated and is used
+ * to determine if this token has been renewed in the acceptable time range
+ * (2 * renogiation timeout)
+ *
+ * The hmac is calculated over the username contactinated with the
+ * raw auth-token bytes to include authentication of the username in the token
+ *
+ * we prepend the session id with SESS_ID_ before sending it to the client
+ */
+void
+generate_auth_token(const struct user_pass *up, struct tls_multi *multi);
+
+/**
+ * Verifies the auth token to be in the format that generate_auth_token
+ * create and checks if the token is valid.
+ *
+ * Also calls generate_auth_token to update the auth-token to extend
+ * its validity
+ */
+unsigned
+verify_auth_token(struct user_pass *up, struct tls_multi *multi,
+                  struct tls_session *session);
+
+
+
+/**
+ * Loads an HMAC secret from a file or if no file is present generates a
+ * epheremal secret for the run time of the server and stores it into ctx
+ */
+void
+auth_token_init_secret(struct key_ctx *key_ctx, const char *key_file,
+                       const char *key_inline);
+
+
+/**
+ * Generate a auth-token server secret key, and write to file.
+ *
+ * @param filename          Filename of the server key file to create.
+ */
+void auth_token_write_server_key_file(const char *filename);
+
+
+/**
+ * Wipes the authentication token out of the memory, frees and cleans up
+ * related buffers and flags
+ *
+ *  @param multi  Pointer to a multi object holding the auth_token variables
+ */
+void wipe_auth_token(struct tls_multi *multi);
+
+/**
+ * The prefix given to auth tokens start with, this prefix is special
+ * cased to not show up in log files in OpenVPN 2 and 3
+ *
+ * We also prefix this with _AT_ to only act on auth token generated by us.
+ */
+#define SESSION_ID_PREFIX "SESS_ID_AT_"
+
+/**
+ * Return if the password string has the format of a password.
+ *
+ * This fuction will always read as many bytes as SESSION_ID_PREFIX is longer
+ * the caller needs ensure that password memory is at least that long (true for
+ * calling with struct user_pass)
+ * @param password
+ * @return whether the password string starts with the session token prefix
+ */
+static inline bool
+is_auth_token(const char *password)
+{
+    return (memcmp_constant_time(SESSION_ID_PREFIX, password,
+                                 strlen(SESSION_ID_PREFIX)) == 0);
+}
+#endif /* AUTH_TOKEN_H */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9260067f..1732312f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -51,6 +51,7 @@
 #include "ssl_verify.h"
 #include "tls_crypt.h"
 #include "forward.h"
+#include "auth_token.h"
 
 #include "memdbg.h"
 
@@ -1108,6 +1109,11 @@ do_genkey(const struct options *options)
                 options->tls_crypt_v2_inline);
         return true;
     }
+    else if (options->genkey && options->genkey_type == GENKEY_AUTH_TOKEN)
+    {
+        auth_token_write_server_key_file(options->genkey_filename);
+        return true;
+    }
     else
     {
         return false;
@@ -2503,7 +2509,6 @@ init_crypto_pre(struct context *c, const unsigned int flags)
         rand_ctx_enable_prediction_resistance();
     }
 #endif
-
 }
 
 /*
@@ -2627,6 +2632,20 @@ do_init_tls_wrap_key(struct context *c)
 
 }
 
+/*
+ * Initialise the auth-token key context
+ */
+static void
+do_init_auth_token_key(struct context *c)
+{
+    if (!c->options.auth_token_generate)
+        return;
+
+    auth_token_init_secret(&c->c1.ks.auth_token_key,
+                           c->options.auth_token_secret_file,
+                           c->options.auth_token_secret_file_inline);
+}
+
 /*
  * Initialize the persistent component of OpenVPN's TLS mode,
  * which is preserved across SIGUSR1 resets.
@@ -2679,6 +2698,9 @@ do_init_crypto_tls_c1(struct context *c)
         /* initialize tls-auth/crypt/crypt-v2 key */
         do_init_tls_wrap_key(c);
 
+        /* initialise auth-token crypto support */
+        do_init_auth_token_key(c);
+
 #if 0 /* was: #if ENABLE_INLINE_FILES --  Note that enabling this code will break restarts */
         if (options->priv_key_file_inline)
         {
@@ -2851,6 +2873,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.auth_user_pass_file = options->auth_user_pass_file;
     to.auth_token_generate = options->auth_token_generate;
     to.auth_token_lifetime = options->auth_token_lifetime;
+    to.auth_token_key = c->c1.ks.auth_token_key;
 #endif
 
     to.x509_track = options->x509_track;
@@ -4464,6 +4487,9 @@ inherit_context_child(struct context *dest,
     dest->c1.authname = src->c1.authname;
     dest->c1.keysize = src->c1.keysize;
 
+    /* inherit auth-token */
+    dest->c1.ks.auth_token_key = src->c1.ks.auth_token_key;
+
     /* options */
     dest->options = src->options;
     options_detach(&dest->options);
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index d11f61df..30b5aeb4 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -68,6 +68,7 @@ struct key_schedule
     struct key_ctx_bi tls_wrap_key;
     struct key_ctx tls_crypt_v2_server_key;
     struct buffer tls_crypt_v2_wkc;             /**< Wrapped client key */
+    struct key_ctx auth_token_key;
 };
 
 /*
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ced5e987..3dac1e7a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1289,6 +1289,7 @@ show_p2mp_parms(const struct options *o)
     SHOW_BOOL(auth_user_pass_verify_script_via_file);
     SHOW_BOOL(auth_token_generate);
     SHOW_INT(auth_token_lifetime);
+    SHOW_STR(auth_token_secret_file);
 #if PORT_SHARE
     SHOW_STR(port_share_host);
     SHOW_STR(port_share_port);
@@ -2336,7 +2337,11 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         {
             msg(M_USAGE, "--mode server requires --key-method 2");
         }
-
+        if (options->auth_token_generate && !options->renegotiate_seconds)
+        {
+            msg(M_USAGE, "--auth-gen-token needs a non-infinite "
+                "--renegotiate_seconds setting");
+        }
         {
             const bool ccnr = (options->auth_user_pass_verify_script
                                || PLUGIN_OPTION_LIST(options)
@@ -6767,6 +6772,17 @@ add_option(struct options *options,
         options->auth_token_generate = true;
         options->auth_token_lifetime = p[1] ? positive_atoi(p[1]) : 0;
     }
+    else if (streq(p[0], "auth-gen-token-secret") && p[1] && (!p[2]
+                                                              || (p[2] && streq(p[1], INLINE_FILE_TAG))))
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->auth_token_secret_file = p[1];
+
+        if (streq(p[1], INLINE_FILE_TAG) && p[2])
+        {
+            options->auth_token_secret_file_inline = p[2];
+        }
+    }
     else if (streq(p[0], "client-connect") && p[1])
     {
         VERIFY_PERMISSION(OPT_P_SCRIPT);
@@ -7542,6 +7558,10 @@ add_option(struct options *options,
                     options->genkey_extra_data = p[3];
                 }
             }
+            else if (streq(p[1], "auth-token"))
+            {
+                options->genkey_type = GENKEY_AUTH_TOKEN;
+            }
             else
             {
                 msg(msglevel, "unknown --genkey type: %s", p[1]);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d8e7efa4..cad5be81 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -181,6 +181,7 @@ enum genkey_type {
     GENKEY_SECRET,
     GENKEY_TLS_CRYPTV2_CLIENT,
     GENKEY_TLS_CRYPTV2_SERVER,
+    GENKEY_AUTH_TOKEN
 };
 
 /* Command line options */
@@ -469,6 +470,9 @@ struct options
     bool auth_user_pass_verify_script_via_file;
     bool auth_token_generate;
     unsigned int auth_token_lifetime;
+    const char *auth_token_secret_file;
+    const char *auth_token_secret_file_inline;
+
 #if PORT_SHARE
     char *port_share_host;
     char *port_share_port;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 8befc6f5..45ef0c4f 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -324,6 +324,37 @@ send_push_request(struct context *c)
 }
 
 #if P2MP_SERVER
+/**
+ * Prepare push option for auth-token
+ * @param tls_multi     tls multi context of VPN tunnel
+ * @param gc            gc arena for allocating push options
+ * @param push_list     push list to where options are added
+ *
+ * @return true on success, false on failure.
+ */
+void
+prepare_auth_token_push_reply(struct tls_multi *tls_multi, struct gc_arena *gc,
+                              struct push_list *push_list)
+{
+    /*
+     * If server uses --auth-gen-token and we have an auth token
+     * to send to the client
+     */
+    if (tls_multi->auth_token)
+    {
+        push_option_fmt(gc, push_list, M_USAGE,
+                        "auth-token %s",
+                        tls_multi->auth_token);
+        if (!tls_multi->auth_token_initial)
+        {
+            /*
+             * Save the initial auth token for clients that ignore
+             * the updates to the token
+             */
+            tls_multi->auth_token_initial = strdup(tls_multi->auth_token);
+        }
+    }
+}
 
 /**
  * Prepare push options, based on local options and available peer info.
@@ -334,7 +365,7 @@ send_push_request(struct context *c)
  *
  * @return true on success, false on failure.
  */
-static bool
+bool
 prepare_push_reply(struct context *c, struct gc_arena *gc,
                    struct push_list *push_list)
 {
@@ -382,6 +413,11 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
             tls_multi->use_peer_id = true;
         }
     }
+    /*
+     * If server uses --auth-gen-token and we have an auth token
+     * to send to the client
+     */
+    prepare_auth_token_push_reply(tls_multi, gc, push_list);
 
     /* Push cipher if client supports Negotiable Crypto Parameters */
     if (tls_peer_info_ncp_ver(peer_info) >= 2 && o->ncp_enabled)
@@ -412,15 +448,6 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
         tls_poor_mans_ncp(o, tls_multi->remote_ciphername);
     }
 
-    /* If server uses --auth-gen-token and we have an auth token
-     * to send to the client
-     */
-    if (false == tls_multi->auth_token_sent && NULL != tls_multi->auth_token)
-    {
-        push_option_fmt(gc, push_list, M_USAGE,
-                        "auth-token %s", tls_multi->auth_token);
-        tls_multi->auth_token_sent = true;
-    }
     return true;
 }
 
@@ -431,6 +458,7 @@ send_push_options(struct context *c, struct buffer *buf,
 {
     struct push_entry *e = push_list->head;
 
+    e = push_list->head;
     while (e)
     {
         if (e->enable)
@@ -463,7 +491,27 @@ send_push_options(struct context *c, struct buffer *buf,
     return true;
 }
 
-static bool
+void
+send_push_reply_auth_token(struct tls_multi *multi)
+{
+    struct gc_arena gc = gc_new();
+
+
+    struct push_list push_list = {};
+    prepare_auth_token_push_reply(multi, &gc, &push_list);
+
+    /* prepare auth token should always add the auth-token option */
+    struct push_entry *e = push_list.head;
+    ASSERT(e && e->enable);
+
+    /* Construct a mimimal control channel push reply message */
+    struct buffer buf = alloc_buf_gc(PUSH_BUNDLE_SIZE, &gc);
+    buf_printf(&buf, "%s, %s", push_reply_cmd, e->option);
+    send_control_channel_string_dowork(multi, BSTR(&buf), D_PUSH);
+    gc_free(&gc);
+}
+
+bool
 send_push_reply(struct context *c, struct push_list *per_client_push_list)
 {
     struct gc_arena gc = gc_new();
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 5f6181e7..070782dd 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -69,6 +69,14 @@ void send_auth_failed(struct context *c, const char *client_reason);
 
 void send_restart(struct context *c, const char *kill_msg);
 
+/**
+ * Sends a push reply message only containin the auth-token to update
+ * the auth-token on the client
+ *
+ * @param multi  - The tls_multi structure belonging to the instance to push to
+ */
+void send_push_reply_auth_token(struct tls_multi *multi);
+
 #endif
 #endif /* if P2MP */
 #endif /* ifndef PUSH_H */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4c81ae72..69d7be57 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -59,6 +59,7 @@
 #include "ssl.h"
 #include "ssl_verify.h"
 #include "ssl_backend.h"
+#include "auth_token.h"
 
 #include "memdbg.h"
 
@@ -1368,11 +1369,7 @@ tls_multi_free(struct tls_multi *multi, bool clear)
 
     cert_hash_free(multi->locked_cert_hash_set);
 
-    if (multi->auth_token)
-    {
-        secure_memzero(multi->auth_token, AUTH_TOKEN_SIZE);
-        free(multi->auth_token);
-    }
+    wipe_auth_token(multi);
 
     free(multi->remote_ciphername);
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 410b2163..ff8ffacc 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -298,7 +298,6 @@ struct tls_options
     /** TLS handshake wrapping state */
     struct tls_wrap_ctx tls_wrap;
 
-    /* frame parameters for TLS control channel */
     struct frame frame;
 
     /* used for username/password authentication */
@@ -306,10 +305,16 @@ struct tls_options
     bool auth_user_pass_verify_script_via_file;
     const char *tmp_dir;
     const char *auth_user_pass_file;
-    bool auth_token_generate;   /**< Generate auth-tokens on successful user/pass auth,
-                                 *   set via options->auth_token_generate. */
+
+#ifdef P2MP_SERVER
+    bool auth_token_generate;   /**< Generate auth-tokens on successful
+                                 * user/pass auth,seet via
+                                 * options->auth_token_generate. */
     unsigned int auth_token_lifetime;
 
+    struct key_ctx auth_token_key;
+#endif
+
     /* use the client-config-dir as a positive authenticator */
     const char *client_config_dir_exclusive;
 
@@ -368,10 +373,6 @@ struct tls_options
 /** @} name Index of key_state objects within a tls_session structure */
 /** @} addtogroup control_processor */
 
-#define AUTH_TOKEN_SIZE 32      /**< Size of server side generated auth tokens.
-                                 *   32 bytes == 256 bits
-                                 */
-
 /**
  * Security parameter state of a single session within a VPN tunnel.
  * @ingroup control_processor
@@ -539,7 +540,21 @@ struct tls_multi
      * over control channel.
      */
     char *peer_info;
+    char *auth_token;    /**< If server sends a generated auth-token,
+                          *   this is the token to use for future
+                          *   user/pass authentications in this session.
+                          */
+    char *auth_token_initial;
+    /**< The first auth-token we sent to a client, for clients that do
+     * not update their auth-token (older OpenVPN3 core versions)
+     */
+#define  AUTH_TOKEN_HMAC_OK              (1<<0)
+    /**< Auth-token sent from client has valid hmac */
+#define  AUTH_TOKEN_EXPIRED              (1<<1)
+    /**< Auth-token sent from client has expired */
 #endif
+    int auth_token_state_flags;
+    /**< The state of the auth-token sent from the client last time */
 
     /* For P_DATA_V2 */
     uint32_t peer_id;
@@ -547,13 +562,6 @@ struct tls_multi
 
     char *remote_ciphername;    /**< cipher specified in peer's config file */
 
-    char *auth_token;    /**< If server sends a generated auth-token,
-                          *   this is the token to use for future
-                          *   user/pass authentications in this session.
-                          */
-    time_t auth_token_tstamp; /**< timestamp of the generated token */
-    bool auth_token_sent; /**< If server uses --auth-gen-token and
-                           *   token has been sent to client */
     /*
      * Our session objects.
      */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index a7f51751..b392b0ac 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -44,6 +44,8 @@
 #ifdef ENABLE_CRYPTO_OPENSSL
 #include "ssl_verify_openssl.h"
 #endif
+#include "auth_token.h"
+#include "push.h"
 
 /** Maximum length of common name */
 #define TLS_USERNAME_LEN 64
@@ -63,28 +65,6 @@ setenv_untrusted(struct tls_session *session)
     setenv_link_socket_actual(session->opt->es, "untrusted", &session->untrusted_addr, SA_IP_PORT);
 }
 
-
-/**
- *  Wipes the authentication token out of the memory, frees and cleans up related buffers and flags
- *
- *  @param multi  Pointer to a multi object holding the auth_token variables
- */
-static void
-wipe_auth_token(struct tls_multi *multi)
-{
-    if (multi)
-    {
-        if (multi->auth_token)
-        {
-            secure_memzero(multi->auth_token, AUTH_TOKEN_SIZE);
-            free(multi->auth_token);
-        }
-        multi->auth_token = NULL;
-        multi->auth_token_sent = false;
-    }
-}
-
-
 /*
  * Remove authenticated state from all sessions in the given tunnel
  */
@@ -1253,6 +1233,7 @@ verify_user_pass_management(struct tls_session *session, const struct user_pass
 }
 #endif /* ifdef MANAGEMENT_DEF_AUTH */
 
+
 /*
  * Main username/password verification entry point
  */
@@ -1277,86 +1258,67 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
     string_mod_remap_name(up->username);
     string_mod(up->password, CC_PRINT, CC_CRLF, '_');
 
-    /* If server is configured with --auth-gen-token and we have an
-     * authentication token for this client, this authentication
+    /*
+     * If auth token succeeds we skip the auth
+     * methods unless otherwise specified
+     */
+    bool skip_auth = false;
+
+    /*
+     * If server is configured with --auth-gen-token and the client sends
+     * something that looks like an authentication token, this
      * round will be done internally using the token instead of
      * calling any external authentication modules.
      */
-    if (session->opt->auth_token_generate && multi->auth_token_sent
-        && NULL != multi->auth_token)
+    if (session->opt->auth_token_generate && is_auth_token(up->password))
     {
-        unsigned int ssl_flags = session->opt->ssl_flags;
-
-        /* Ensure that the username has not changed */
-        if (!tls_lock_username(multi, up->username))
+        multi->auth_token_state_flags = verify_auth_token(up, multi,session);
+        if (multi->auth_token_state_flags == AUTH_TOKEN_HMAC_OK)
         {
-            /* auth-token cleared in tls_lock_username() on failure */
-            ks->authenticated = false;
-            return;
+            /*
+             * We do not want the EXPIRED flag here so check
+             * for equality with AUTH_TOKEN_HMAC_OK
+             */
+            msg(M_WARN, "TLS: Username/auth-token authentication "
+                "succeeded for username '%s'",
+                up->username);
+            skip_auth = true;
         }
-
-        /* If auth-token lifetime has been enabled,
-         * ensure the token has not expired
-         */
-        if (session->opt->auth_token_lifetime > 0
-            && (multi->auth_token_tstamp + session->opt->auth_token_lifetime) < now)
+        else
         {
-            msg(D_HANDSHAKE, "Auth-token for client expired\n");
             wipe_auth_token(multi);
             ks->authenticated = false;
+            msg(M_WARN, "TLS: Username/auth-token authentication "
+                        "failed for username '%s'", up->username);
             return;
         }
+    }
+    if (!skip_auth)
+    {
 
-        /* The core authentication of the token itself */
-        if (memcmp_constant_time(multi->auth_token, up->password,
-                                 strlen(multi->auth_token)) != 0)
+        /* call plugin(s) and/or script */
+#ifdef MANAGEMENT_DEF_AUTH
+        if (man_def_auth == KMDA_DEF)
         {
-            ks->authenticated = false;
-            tls_deauthenticate(multi);
-
-            msg(D_TLS_ERRORS, "TLS Auth Error: Auth-token verification "
-                "failed for username '%s' %s", up->username,
-                (ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) ? "[CN SET]" : "");
+            man_def_auth = verify_user_pass_management(session, up);
         }
-        else
+#endif
+        if (plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY))
         {
-            ks->authenticated = true;
-
-            if (ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
-            {
-                set_common_name(session, up->username);
-            }
-            msg(D_HANDSHAKE, "TLS: Username/auth-token authentication "
-                "succeeded for username '%s' %s",
-                up->username,
-                (ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) ? "[CN SET]" : "");
+            s1 = verify_user_pass_plugin(session, up);
+        }
+        if (session->opt->auth_user_pass_verify_script)
+        {
+            s2 = verify_user_pass_script(session, up);
         }
-        return;
-    }
-
-    /* call plugin(s) and/or script */
-#ifdef MANAGEMENT_DEF_AUTH
-    if (man_def_auth == KMDA_DEF)
-    {
-        man_def_auth = verify_user_pass_management(session, up);
-    }
-#endif
-    if (plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY))
-    {
-        s1 = verify_user_pass_plugin(session, up);
-    }
-    if (session->opt->auth_user_pass_verify_script)
-    {
-        s2 = verify_user_pass_script(session, up);
-    }
 
-    /* check sizing of username if it will become our common name */
-    if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) && strlen(up->username) > TLS_USERNAME_LEN)
-    {
-        msg(D_TLS_ERRORS, "TLS Auth Error: --username-as-common name specified and username is longer than the maximum permitted Common Name length of %d characters", TLS_USERNAME_LEN);
-        s1 = OPENVPN_PLUGIN_FUNC_ERROR;
+        /* check sizing of username if it will become our common name */
+        if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) && strlen(up->username) > TLS_USERNAME_LEN)
+        {
+            msg(D_TLS_ERRORS, "TLS Auth Error: --username-as-common name specified and username is longer than the maximum permitted Common Name length of %d characters", TLS_USERNAME_LEN);
+            s1 = OPENVPN_PLUGIN_FUNC_ERROR;
+        }
     }
-
     /* auth succeeded? */
     if ((s1 == OPENVPN_PLUGIN_FUNC_SUCCESS
 #ifdef PLUGIN_DEF_AUTH
@@ -1381,35 +1343,49 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
             ks->auth_deferred = true;
         }
 #endif
+        if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME))
+        {
+            set_common_name(session, up->username);
+        }
 
-        if ((session->opt->auth_token_generate) && (NULL == multi->auth_token))
+        if ((session->opt->auth_token_generate))
         {
-            /* Server is configured with --auth-gen-token but no token has yet
-             * been generated for this client.  Generate one and save it.
+            /*
+             * If we accepted a (not expired) token, i.e.
+             * initial auth via token on new connection, we need
+             * to store the auth-token in multi->auth_token, so
+             * the initial timestamp and session id can be extracted from it
              */
-            uint8_t tok[AUTH_TOKEN_SIZE];
-
-            if (!rand_bytes(tok, AUTH_TOKEN_SIZE))
+            if (multi->auth_token && (multi->auth_token_state_flags & AUTH_TOKEN_HMAC_OK)
+                   && !(multi->auth_token_state_flags & AUTH_TOKEN_EXPIRED))
             {
-                msg( M_FATAL, "Failed to get enough randomness for "
-                     "authentication token");
+                multi->auth_token = strdup(up->password);
             }
 
-            /* The token should be longer than the input when
-             * being base64 encoded
+            /*
+             * Server is configured with --auth-gen-token but no token has yet
+             * been generated for this client.  Generate one and save it.
              */
-            ASSERT(openvpn_base64_encode(tok, AUTH_TOKEN_SIZE,
-                                         &multi->auth_token) > AUTH_TOKEN_SIZE);
-            multi->auth_token_tstamp = now;
-            dmsg(D_SHOW_KEYS, "Generated token for client: %s",
-                 multi->auth_token);
+            generate_auth_token(up, multi);
         }
-
-        if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME))
+        /*
+         * Auth token already sent to client, update auth-token on client.
+         * The initial auth-token is sent as part of the push message, for this
+         * update we need to schedule an extra push message.
+         */
+        if (multi->auth_token_initial)
         {
-            set_common_name(session, up->username);
+            /*
+             * We do not explicitly schedule the sending of the
+             * control message here but control message are only
+             * postponed when the control channel  is not yet fully
+             * established and furthermore since this is called in
+             * the middle of authentication, there are other messages
+             * (new data channel keys) that are sent anyway and will
+             * trigger schedueling
+             */
+            send_push_reply_auth_token(multi);
         }
-
 #ifdef ENABLE_DEF_AUTH
         msg(D_HANDSHAKE, "TLS: Username/Password authentication %s for username '%s' %s",
             ks->auth_deferred ? "deferred" : "succeeded",
-- 
2.21.0


