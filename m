From: Gert Doering <gert@...1296...>
Date: Mon,  6 Oct 2025 22:41:09 +0200
Message-ID: <20251006204118.26237-1-gert@...1296...>
In-Reply-To: <gerrit.1754655145000.Ia2f374476c87855bba6c0f9d3e2f28a5fe62a152@...2715...>
References: <gerrit.1754655145000.Ia2f374476c87855bba6c0f9d3e2f28a5fe62a152@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Review CMocka assertion usage
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

Replace some assert_true calls with more specific
assertions. This should improve reporting in case
of problems and also just makes the code nicer.

Change-Id: Ia2f374476c87855bba6c0f9d3e2f28a5fe62a152
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1141
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1141
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index a2a10ea..68e4693 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -286,9 +286,9 @@
     strcpy(ctx->up.password, ctx->multi.auth_token);
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session), AUTH_TOKEN_HMAC_OK);
 
-    assert_int_not_equal(0, memcmp(ctx->multi.auth_token_initial + strlen(SESSION_ID_PREFIX),
-                                   token_sessiona + strlen(SESSION_ID_PREFIX),
-                                   AUTH_TOKEN_SESSION_ID_BASE64_LEN));
+    assert_memory_not_equal(ctx->multi.auth_token_initial + strlen(SESSION_ID_PREFIX),
+                            token_sessiona + strlen(SESSION_ID_PREFIX),
+                            AUTH_TOKEN_SESSION_ID_BASE64_LEN);
 
     /* The first token is valid but should trigger the invalid response since
      * the session id is not the same */
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index 0eacbab..ec71bc3 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -82,9 +82,9 @@
 
     now = 5010;
     assert_true(packet_id_write(&data->pis, &data->test_buf, false, false));
-    assert_true(data->pis.id == 1);
-    assert_true(data->test_buf_data.buf_id == htonl(1));
-    assert_true(data->test_buf_data.buf_time == 0);
+    assert_int_equal(data->pis.id, 1);
+    assert_int_equal(data->test_buf_data.buf_id, htonl(1));
+    assert_int_equal(data->test_buf_data.buf_time, 0);
 }
 
 static void
@@ -96,8 +96,8 @@
     assert_true(packet_id_write(&data->pis, &data->test_buf, true, false));
     assert_int_equal(data->pis.id, 1);
     assert_int_equal(data->pis.time, now);
-    assert_true(data->test_buf_data.buf_id == htonl(1));
-    assert_true(data->test_buf_data.buf_time == htonl((uint32_t)now));
+    assert_int_equal(data->test_buf_data.buf_id, htonl(1));
+    assert_int_equal(data->test_buf_data.buf_time, htonl((uint32_t)now));
 }
 
 static void
@@ -108,9 +108,9 @@
     data->test_buf.offset = sizeof(packet_id_type);
     now = 5010;
     assert_true(packet_id_write(&data->pis, &data->test_buf, false, true));
-    assert_true(data->pis.id == 1);
-    assert_true(data->test_buf_data.buf_id == htonl(1));
-    assert_true(data->test_buf_data.buf_time == 0);
+    assert_int_equal(data->pis.id, 1);
+    assert_int_equal(data->test_buf_data.buf_id, htonl(1));
+    assert_int_equal(data->test_buf_data.buf_time, 0);
 }
 
 static void
@@ -123,8 +123,8 @@
     assert_true(packet_id_write(&data->pis, &data->test_buf, true, true));
     assert_int_equal(data->pis.id, 1);
     assert_int_equal(data->pis.time, now);
-    assert_true(data->test_buf_data.buf_id == htonl(1));
-    assert_true(data->test_buf_data.buf_time == htonl((uint32_t)now));
+    assert_int_equal(data->test_buf_data.buf_id, htonl(1));
+    assert_int_equal(data->test_buf_data.buf_time, htonl((uint32_t)now));
 }
 
 static void
@@ -156,8 +156,8 @@
 
     assert_int_equal(data->pis.id, 1);
     assert_int_equal(data->pis.time, now);
-    assert_true(data->test_buf_data.buf_id == htonl(1));
-    assert_true(data->test_buf_data.buf_time == htonl((uint32_t)now));
+    assert_int_equal(data->test_buf_data.buf_id, htonl(1));
+    assert_int_equal(data->test_buf_data.buf_time, htonl((uint32_t)now));
 }
 
 static void
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index 463b394..48adb96 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -287,9 +287,9 @@
     for (size_t i = 0; i < _countof(pubkeys); i++)
     {
         pubkey = load_pubkey(pubkeys[i]);
-        assert_true(pubkey != NULL);
+        assert_non_null(pubkey);
         EVP_PKEY *privkey = xkey_load_management_key(NULL, pubkey);
-        assert_true(privkey != NULL);
+        assert_non_null(privkey);
 
         management->settings.flags = MF_EXTERNAL_KEY | MF_EXTERNAL_KEY_PSSPAD;
 
@@ -384,11 +384,11 @@
     for (size_t i = 0; i < _countof(pubkeys); i++)
     {
         pubkey = load_pubkey(pubkeys[i]);
-        assert_true(pubkey != NULL);
+        assert_non_null(pubkey);
 
         EVP_PKEY *privkey =
             xkey_load_generic_key(NULL, (void *)dummy, pubkey, xkey_sign, xkey_free);
-        assert_true(privkey != NULL);
+        assert_non_null(privkey);
 
         xkey_sign_called = 0;
         xkey_free_called = 0;
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 950ce26..6fe64b2 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -487,9 +487,8 @@
     assert_true(tls_crypt_v2_unwrap_client_key(&unwrapped_client_key2, &unwrap_metadata,
                                                wrapped_client_key, &ctx->server_keys.decrypt));
 
-    assert_true(0
-                == memcmp(ctx->client_key2.keys, unwrapped_client_key2.keys,
-                          sizeof(ctx->client_key2.keys)));
+    assert_memory_equal(ctx->client_key2.keys, unwrapped_client_key2.keys,
+                        sizeof(ctx->client_key2.keys));
 }
 
 /**
@@ -511,9 +510,8 @@
     assert_true(tls_crypt_v2_unwrap_client_key(&unwrapped_client_key2, &unwrap_metadata, ctx->wkc,
                                                &ctx->server_keys.decrypt));
 
-    assert_true(0
-                == memcmp(ctx->client_key2.keys, unwrapped_client_key2.keys,
-                          sizeof(ctx->client_key2.keys)));
+    assert_memory_equal(ctx->client_key2.keys, unwrapped_client_key2.keys,
+                        sizeof(ctx->client_key2.keys));
     assert_true(buf_equal(&ctx->metadata, &unwrap_metadata));
 
     struct tls_wrap_ctx wrap_ctx = {
@@ -563,8 +561,8 @@
                                                 ctx->wkc, &ctx->server_keys.decrypt));
 
     const struct key2 zero = { 0 };
-    assert_true(0 == memcmp(&unwrapped_client_key2, &zero, sizeof(zero)));
-    assert_true(0 == BLEN(&ctx->unwrapped_metadata));
+    assert_memory_equal(&unwrapped_client_key2, &zero, sizeof(zero));
+    assert_int_equal(0, BLEN(&ctx->unwrapped_metadata));
 }
 
 /**
@@ -587,8 +585,8 @@
                                                 ctx->wkc, &ctx->server_keys.decrypt));
 
     const struct key2 zero = { 0 };
-    assert_true(0 == memcmp(&unwrapped_client_key2, &zero, sizeof(zero)));
-    assert_true(0 == BLEN(&ctx->unwrapped_metadata));
+    assert_memory_equal(&unwrapped_client_key2, &zero, sizeof(zero));
+    assert_int_equal(0, BLEN(&ctx->unwrapped_metadata));
 }
 
 static void

