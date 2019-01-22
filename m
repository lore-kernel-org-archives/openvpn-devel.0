From: Arne Schwabe <arne@...1227...>
Date: Tue, 22 Jan 2019 16:03:33 +0100
Message-Id: <20190122150333.1061-6-arne@...1227...>
In-Reply-To: <20190122150333.1061-1-arne@...1227...>
References: <20190122150333.1061-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 6/6] Implement unit tests for
 auth-gen-token
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
Cc: Arne Schwabe <arne@...515...>

From: Arne Schwabe <arne@...515...>

Patch V2: adapt unit tests to other V2 patches
---
 tests/unit_tests/openvpn/Makefile.am       |  18 +-
 tests/unit_tests/openvpn/test_auth_token.c | 375 +++++++++++++++++++++
 2 files changed, 392 insertions(+), 1 deletion(-)
 create mode 100644 tests/unit_tests/openvpn/test_auth_token.c

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 4f137b2b..d3e6e87b 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -6,7 +6,7 @@ if HAVE_LD_WRAP_SUPPORT
 check_PROGRAMS += argv_testdriver buffer_testdriver
 endif
 
-check_PROGRAMS += crypto_testdriver packet_id_testdriver
+check_PROGRAMS += crypto_testdriver packet_id_testdriver auth_token_testdriver
 if HAVE_LD_WRAP_SUPPORT
 check_PROGRAMS += tls_crypt_testdriver
 endif
@@ -72,3 +72,19 @@ tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c \
 	$(openvpn_srcdir)/packet_id.c \
 	$(openvpn_srcdir)/platform.c \
 	$(openvpn_srcdir)/run_command.c
+
+auth_token_testdriver_CFLAGS  = @TEST_CFLAGS@ \
+	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
+	$(OPTIONAL_CRYPTO_CFLAGS)
+auth_token_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
+	$(OPTIONAL_CRYPTO_LIBS)
+
+auth_token_testdriver_SOURCES = test_auth_token.c mock_msg.c \
+	$(openvpn_srcdir)/buffer.c \
+	$(openvpn_srcdir)/crypto.c \
+	$(openvpn_srcdir)/crypto_mbedtls.c \
+	$(openvpn_srcdir)/crypto_openssl.c \
+	$(openvpn_srcdir)/otime.c \
+	$(openvpn_srcdir)/packet_id.c \
+	$(openvpn_srcdir)/platform.c \
+	$(openvpn_srcdir)/base64.c
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
new file mode 100644
index 00000000..a3591b4a
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -0,0 +1,375 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2016-2018 Fox Crypto B.V. <openvpn@...1435...>
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
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "auth_token.c"
+
+#include "mock_msg.h"
+
+struct test_context {
+    struct tls_multi multi;
+    struct key_type kt;
+    struct user_pass up;
+    struct tls_session session;
+};
+
+static const char *now0key0 = "SESS_ID_AT_0123456789abcdefAAAAAAAAAAAAAAAAAAAAAE5JsQJOVfo8jnI3RL3tBaR5NkE4yPfcylFUHmHSc5Bu";
+
+static const char *zeroinline = "-----BEGIN OpenVPN auth-token server key-----\n"
+                                "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\n"
+                                "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\n"
+                                "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=\n"
+                                "-----END OpenVPN auth-token server key-----";
+
+static const char *allx01inline = "-----BEGIN OpenVPN auth-token server key-----\n"
+                                  "AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\n"
+                                  "AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB\n"
+                                  "AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE=\n"
+                                  "-----END OpenVPN auth-token server key-----";
+
+static const char *random_key = "-----BEGIN OpenVPN auth-token server key-----\n"
+                                "+mmmf7IQ5cymtMVjKYTWk8IOcYanRlpQmV9Tb3EjkHYxueBVDg3yqRgzeBlVGzNLD//rAPiOVhau\n"
+                                "3NDBjNOQB8951bfs7Cc2mYfay92Bh2gRJ5XEM/DMfzCWN+7uU6NWoTTHr4FuojnIQtjtqVAj/JS9\n"
+                                "w+dTSp/vYHl+c7uHd19uVRu/qLqV85+rm4tUGIjO7FfYuwyPqwmhuIsi3hs9QkSimh888FmBpoKY\n"
+                                "/tbKVTJZmSERKti9KEwtV2eVAR0znN5KW7lCB3mHVAhN7bUpcoDjfCzYIFARxwswTFu9gFkwqUMY\n"
+                                "I1KUOgIsVNs4llACioeXplYekWETR+YkJwDc/A==\n"
+                                "-----END OpenVPN auth-token server key-----";
+
+static const char *random_token = "SESS_ID_AT_ThhRItzOKNKrh3dfAAAAAFwzHpwAAAAAXDMenDdrq0RoH3dkA1f7O3wO+7kZcx2DusVZrRmFlWQM9HOb";
+
+
+static int
+setup(void **state)
+{
+    struct test_context *ctx = calloc(1, sizeof(*ctx));
+    *state = ctx;
+
+    struct key key = { 0 };
+
+    ctx->kt = auth_token_kt();
+    if (!ctx->kt.digest)
+    {
+        return 0;
+    }
+    ctx->multi.opt.auth_token_generate = true;
+    ctx->multi.opt.auth_token_lifetime = 3000;
+
+    ctx->session.opt = calloc(1, sizeof(struct tls_options));
+    ctx->session.opt->renegotiate_seconds = 120;
+    ctx->session.opt->auth_token_lifetime = 3000;
+
+    strcpy(ctx->up.username, "test user name");
+    strcpy(ctx->up.password, "ignored");
+
+    init_key_ctx(&ctx->multi.opt.auth_token_key, &key, &ctx->kt, false, "TEST");
+
+    now = 0;
+    return 0;
+}
+
+static int
+teardown(void **state)
+{
+    struct test_context *ctx = (struct test_context *) *state;
+
+    free_key_ctx(&ctx->multi.opt.auth_token_key);
+    wipe_auth_token(&ctx->multi);
+
+    free(ctx->session.opt);
+    free(ctx);
+
+    return 0;
+}
+
+static void
+auth_token_basic_test(void **state)
+{
+    struct test_context *ctx = (struct test_context *) *state;
+
+    generate_auth_token(&ctx->up, &ctx->multi);
+    strcpy(ctx->up.password, ctx->multi.auth_token);
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), AUTH_TOKEN_HMAC_OK);
+}
+
+static void
+auth_token_fail_invalid_key(void **state)
+{
+    struct test_context *ctx = (struct test_context *) *state;
+
+    generate_auth_token(&ctx->up, &ctx->multi);
+    strcpy(ctx->up.password, ctx->multi.auth_token);
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), AUTH_TOKEN_HMAC_OK);
+
+    /* Change auth-token key */
+    struct key key;
+    memset(&key, '1', sizeof(key));
+    free_key_ctx(&ctx->multi.opt.auth_token_key);
+    init_key_ctx(&ctx->multi.opt.auth_token_key, &key, &ctx->kt, false, "TEST");
+
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), 0);
+
+    /* Load original test key again */
+    memset(&key, 0, sizeof(key));
+    free_key_ctx(&ctx->multi.opt.auth_token_key);
+    init_key_ctx(&ctx->multi.opt.auth_token_key, &key, &ctx->kt, false, "TEST");
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), AUTH_TOKEN_HMAC_OK);
+
+}
+
+static void
+auth_token_test_timeout(void **state)
+{
+    struct test_context *ctx = (struct test_context *) *state;
+
+    now = 100000;
+    generate_auth_token(&ctx->up, &ctx->multi);
+    strcpy(ctx->up.password, ctx->multi.auth_token);
+
+    /* No time has passed */
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), AUTH_TOKEN_HMAC_OK);
+
+    /* Token before validity, should be rejected */
+    now = 100000 - 100;
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED);
+
+    /* Token still in validity, should be accepted */
+    now = 100000 + 2*ctx->session.opt->renegotiate_seconds - 20;
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), AUTH_TOKEN_HMAC_OK);
+
+    /* Token past validity, should be rejected */
+    now = 100000 + 2*ctx->session.opt->renegotiate_seconds + 20;
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED);
+
+    /* Check if the mode for a client that never updates its token works */
+    ctx->multi.auth_token_initial = strdup(ctx->up.password);
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session),  AUTH_TOKEN_HMAC_OK);
+
+    /* But not when we reached our timeout */
+    now = 100000 + ctx->session.opt->auth_token_lifetime + 1;
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED);
+
+    free(ctx->multi.auth_token_initial);
+    ctx->multi.auth_token_initial = NULL;
+
+    /* regenerate the token util it hits the expiry */
+    now = 100000;
+    while (now < 100000 + ctx->session.opt->auth_token_lifetime + 1)
+    {
+        assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), AUTH_TOKEN_HMAC_OK);
+        generate_auth_token(&ctx->up, &ctx->multi);
+        strcpy(ctx->up.password, ctx->multi.auth_token);
+        now += ctx->session.opt->renegotiate_seconds;
+    }
+
+
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED);
+    ctx->multi.opt.auth_token_lifetime = 0;
+
+    /* Non expiring token should be fine */
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), AUTH_TOKEN_HMAC_OK);
+}
+
+static void
+zerohmac(char *token)
+{
+    char *hmacstart = token + AUTH_TOKEN_SESSION_ID_LEN
+                      + strlen(SESSION_ID_PREFIX) + 2*sizeof(uint64_t);
+    memset(hmacstart, 0x8d, strlen(hmacstart));
+}
+
+static void
+auth_token_test_known_keys(void **state)
+{
+    struct test_context *ctx = (struct test_context *) *state;
+
+    now = 0;
+    /* Preload the session id so the same session id is used here */
+    ctx->multi.auth_token = strdup(now0key0);
+
+    /* Zero the hmac part to ensure we have a newly generated token */
+    zerohmac(ctx->multi.auth_token);
+
+    generate_auth_token(&ctx->up, &ctx->multi);
+
+    assert_string_equal(now0key0, ctx->multi.auth_token);
+
+    strcpy(ctx->up.password, ctx->multi.auth_token);
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), AUTH_TOKEN_HMAC_OK);
+}
+
+static const char *lastsesion_statevalue;
+void
+setenv_str(struct env_set *es, const char *name, const char *value)
+{
+    if (streq(name, "session_state"))
+    {
+        lastsesion_statevalue = value;
+    }
+}
+
+static void
+auth_token_test_empty_user(void **state)
+{
+    struct test_context *ctx = (struct test_context *) *state;
+
+    CLEAR(ctx->up.username);
+    now = 0;
+
+    generate_auth_token(&ctx->up, &ctx->multi);
+    strcpy(ctx->up.password, ctx->multi.auth_token);
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), AUTH_TOKEN_HMAC_OK);
+
+    now = 100000;
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED);
+    strcpy(ctx->up.username, "test user name");
+
+    now = 0;
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_VALID_EMPTYUSER);
+
+    now = 100000;
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED|AUTH_TOKEN_VALID_EMPTYUSER);
+
+    zerohmac(ctx->up.password);
+    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session), 0);
+}
+
+static void
+auth_token_test_env(void **state)
+{
+    struct test_context *ctx = (struct test_context *) *state;
+
+    ctx->multi.auth_token_state_flags = 0;
+    ctx->multi.auth_token = NULL;
+    add_session_token_env(&ctx->session, &ctx->multi, &ctx->up);
+    assert_string_equal(lastsesion_statevalue, "Initial");
+
+    ctx->multi.auth_token_state_flags = 0;
+    strcpy(ctx->up.password, now0key0);
+    add_session_token_env(&ctx->session, &ctx->multi, &ctx->up);
+    assert_string_equal(lastsesion_statevalue, "Invalid");
+
+    ctx->multi.auth_token_state_flags = AUTH_TOKEN_HMAC_OK;
+    add_session_token_env(&ctx->session, &ctx->multi, &ctx->up);
+    assert_string_equal(lastsesion_statevalue, "Authenticated");
+
+    ctx->multi.auth_token_state_flags = AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED;
+    add_session_token_env(&ctx->session, &ctx->multi, &ctx->up);
+    assert_string_equal(lastsesion_statevalue, "Expired");
+
+    ctx->multi.auth_token_state_flags = AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_VALID_EMPTYUSER;
+    add_session_token_env(&ctx->session, &ctx->multi, &ctx->up);
+    assert_string_equal(lastsesion_statevalue, "AuthenticatedEmptyUser");
+
+    ctx->multi.auth_token_state_flags = AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED|AUTH_TOKEN_VALID_EMPTYUSER;
+    add_session_token_env(&ctx->session, &ctx->multi, &ctx->up);
+    assert_string_equal(lastsesion_statevalue, "ExpiredEmptyUser");
+}
+
+static void
+auth_token_test_random_keys(void **state)
+{
+    struct test_context *ctx = (struct test_context *) *state;
+
+    now = 0x5c331e9c;
+    /* Preload the session id so the same session id is used here */
+    ctx->multi.auth_token = strdup(random_token);
+
+    free_key_ctx(&ctx->multi.opt.auth_token_key);
+    auth_token_init_secret(&ctx->multi.opt.auth_token_key, INLINE_FILE_TAG, random_key);
+
+    /* Zero the hmac part to ensure we have a newly generated token */
+    zerohmac(ctx->multi.auth_token);
+
+    generate_auth_token(&ctx->up, &ctx->multi);
+
+    assert_string_equal(random_token, ctx->multi.auth_token);
+
+    strcpy(ctx->up.password, ctx->multi.auth_token);
+    assert_true(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session));
+}
+
+
+static void
+auth_token_test_key_load(void **state)
+{
+    struct test_context *ctx = (struct test_context *) *state;
+
+    free_key_ctx(&ctx->multi.opt.auth_token_key);
+    auth_token_init_secret(&ctx->multi.opt.auth_token_key, INLINE_FILE_TAG, zeroinline);
+    strcpy(ctx->up.password, now0key0);
+    assert_true(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session));
+
+    free_key_ctx(&ctx->multi.opt.auth_token_key);
+    auth_token_init_secret(&ctx->multi.opt.auth_token_key, INLINE_FILE_TAG, allx01inline);
+    assert_false(verify_auth_token(&ctx->up, &ctx->multi, &ctx->session));
+}
+
+int
+main(void)
+{
+    const struct CMUnitTest tests[] = {
+        cmocka_unit_test_setup_teardown(auth_token_basic_test, setup, teardown),
+        cmocka_unit_test_setup_teardown(auth_token_fail_invalid_key, setup, teardown),
+        cmocka_unit_test_setup_teardown(auth_token_test_known_keys, setup, teardown),
+        cmocka_unit_test_setup_teardown(auth_token_test_empty_user, setup, teardown),
+        cmocka_unit_test_setup_teardown(auth_token_test_env, setup, teardown),
+        cmocka_unit_test_setup_teardown(auth_token_test_random_keys, setup, teardown),
+        cmocka_unit_test_setup_teardown(auth_token_test_key_load, setup, teardown),
+        cmocka_unit_test_setup_teardown(auth_token_test_timeout, setup, teardown),
+    };
+
+#if defined(ENABLE_CRYPTO_OPENSSL)
+    OpenSSL_add_all_algorithms();
+#endif
+
+    int ret = cmocka_run_group_tests_name("auth-token tests", tests, NULL, NULL);
+
+    return ret;
+}
+
+/* Dummy functions that do nothing to mock the functionality */
+void
+send_push_reply_auth_token(struct tls_multi *multi)
+{
+}
+
+void
+auth_set_client_reason(struct tls_multi *multi, const char *reason)
+{
+
+}
-- 
2.20.1


