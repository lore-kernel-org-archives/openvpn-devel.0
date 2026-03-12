From: Gert Doering <gert@...1296...>
Date: Thu, 12 Mar 2026 18:31:38 +0100
Message-ID: <20260312173144.15602-1-gert@...1296...>
In-Reply-To: <gerrit.1770379369000.I73dba29719ea685f0427a3c479e7f1f176f09eba@...2715...>
References: <gerrit.1770379369000.I73dba29719ea685f0427a3c479e7f1f176f09eba@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] auth_token: Clean up type handling in
 verify_auth_token and its UT
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

From: Frank Lichtenheld <frank@...2641...>

First of all remove the testing of renegotiation_seconds.
Commit 9a5161704173e31f2510d3f5c29361f76e275d0f made it
irrelevant for verify_auth_token but still left UTs for it.
But AFAICT these UTs only test that renegotiation_seconds
is bigger than auth_token_renewal, so it tests the UT
setup routine...

Also improve the code to require less casts under
-Wsign-compare.

Add a comment that this code is not y38 safe if time_t
is 32bit. Probably nothing we want to do from our side
since in that case everything that uses "now" is borked.
So we trust in the OS here...

Change-Id: I73dba29719ea685f0427a3c479e7f1f176f09eba
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1510
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1510
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index eb2b4d5..d8ca125 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -287,11 +287,6 @@
     return memcmp_constant_time(&hmac_output, hmac, 32) == 0;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 unsigned int
 verify_auth_token(struct user_pass *up, struct tls_multi *multi, struct tls_session *session)
 {
@@ -318,7 +313,7 @@
 
     const uint8_t *sessid = b64decoded;
     const uint8_t *tstamp_initial = sessid + AUTH_TOKEN_SESSION_ID_LEN;
-    const uint8_t *tstamp = tstamp_initial + sizeof(int64_t);
+    const uint8_t *tstamp = tstamp_initial + sizeof(uint64_t);
 
     /* tstamp, tstamp_initial might not be aligned to an uint64, use memcpy
      * to avoid unaligned access */
@@ -348,9 +343,11 @@
     }
 
     /* Accept session tokens only if their timestamp is in the acceptable range
-     * for renegotiations */
-    bool in_renegotiation_time =
-        now >= timestamp && now < timestamp + 2 * session->opt->auth_token_renewal;
+     * for renegotiations.
+     * Cast is required for systems with 32bit time_t, e.g. Windows x86.
+     */
+    const time_t token_reneg_deadline = (time_t)timestamp + 2 * session->opt->auth_token_renewal;
+    bool in_renegotiation_time = now >= (time_t)timestamp && now < token_reneg_deadline;
 
     if (!in_renegotiation_time)
     {
@@ -369,7 +366,8 @@
         ret |= AUTH_TOKEN_EXPIRED;
     }
 
-    if (multi->opt.auth_token_lifetime && now > timestamp_initial + multi->opt.auth_token_lifetime)
+    const time_t token_eol = (time_t)timestamp_initial + multi->opt.auth_token_lifetime;
+    if (multi->opt.auth_token_lifetime && now > token_eol)
     {
         ret |= AUTH_TOKEN_EXPIRED;
     }
@@ -396,10 +394,6 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 wipe_auth_token(struct tls_multi *multi)
 {
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index 82c20c1..30d55f6 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -166,20 +166,19 @@
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session), AUTH_TOKEN_HMAC_OK);
 }
 
-/* Note: only on 32bit Windows builds */
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static void
 auth_token_test_timeout(void **state)
 {
     struct test_context *ctx = (struct test_context *)*state;
 
-    now = 100000;
+    const time_t initial_time = 100000;
+    now = initial_time;
     generate_auth_token(&ctx->up, &ctx->multi);
 
+    const time_t token_renew_window =
+        initial_time + 2 * ctx->session->opt->auth_token_renewal;
+    const time_t token_eol = initial_time + ctx->session->opt->auth_token_lifetime + 1;
+
     strcpy(ctx->up.password, ctx->multi.auth_token);
     free(ctx->multi.auth_token_initial);
     ctx->multi.auth_token_initial = NULL;
@@ -188,26 +187,21 @@
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session), AUTH_TOKEN_HMAC_OK);
 
     /* Token before validity, should be rejected */
-    now = 100000 - 100;
+    now = initial_time - 100;
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
                      AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED);
 
-    /* Token no valid for renegotiate_seconds but still for renewal_time */
-    now = 100000 + 2 * ctx->session->opt->renegotiate_seconds - 20;
-    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
-                     AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED);
-
-
-    now = 100000 + 2 * ctx->session->opt->auth_token_renewal - 20;
+    /* Token still valid for renewal_time */
+    now = token_renew_window - 20;
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session), AUTH_TOKEN_HMAC_OK);
 
     /* Token past validity, should be rejected */
-    now = 100000 + 2 * ctx->session->opt->renegotiate_seconds + 20;
+    now = token_renew_window + 20;
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
                      AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED);
 
-    /* But not when we reached our timeout */
-    now = 100000 + ctx->session->opt->auth_token_lifetime + 1;
+    /* Token past lifetime, should be rejected */
+    now = token_eol;
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
                      AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED);
 
@@ -215,8 +209,8 @@
     ctx->multi.auth_token_initial = NULL;
 
     /* regenerate the token util it hits the expiry */
-    now = 100000;
-    while (now < 100000 + ctx->session->opt->auth_token_lifetime + 1)
+    now = initial_time;
+    while (now < token_eol)
     {
         assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
                          AUTH_TOKEN_HMAC_OK);
@@ -234,10 +228,6 @@
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session), AUTH_TOKEN_HMAC_OK);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 zerohmac(char *token)
 {

