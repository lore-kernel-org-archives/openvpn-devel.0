From: Arne Schwabe <arne@...1227...>
Date: Sun, 17 Nov 2019 19:12:43 +0100
Message-Id: <20191117181243.28919-4-arne@...1227...>
In-Reply-To: <20191117181243.28919-1-arne@...1227...>
References: <20191117181243.28919-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 4/4] Normalise ncp-ciphers option and
 restrict it to 127 bytes
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

In scenarios of mbed TLS vs OpenSSL we already normalise the ciphers
that are send via the wire protocol via OCC to not have a mismatch
warning between server and client. This is done by
translate_cipher_name_from_openvpn. The same applies also to the
ncp-ciphers list. Specifying non normalised names in ncp-ciphers will
cause negotation not to succeed if ciphers are not in the same form.
Therefore we will normalise the ciphers in options_postmutate.

The alternative and a lot less user friendly alternative would be to
bail if on of the ciphers in ncp-ciphers is not in its normalised form.

Also restrict the ncp-ciphers list to 127. This is somewhat arbitrary
but should prevent too large IV_CIPHER messages and problems sending
those. The server will accept also large IV_CIPHER values from clients.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/openvpn.8                       |  3 ++
 src/openvpn/options.c               | 14 +++++---
 src/openvpn/ssl_ncp.c               | 55 +++++++++++++++++++++++++----
 src/openvpn/ssl_ncp.h               | 19 ++++++++--
 tests/unit_tests/openvpn/test_ncp.c | 40 ++++++++++++++-------
 5 files changed, 104 insertions(+), 27 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 4f0df786..a71b1c14 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4400,6 +4400,9 @@ AES\-256\-GCM:AES\-256\-CBC" set can either specify "\-\-cipher BF\-CBC" or
 
 Note, for using NCP with a OpenVPN 2.4 peer this list must include
 the AES\-256\-GCM and AES\-128\-GCM ciphers.
+
+This list is restricted to be 127 chars long after conversion to OpenVPN
+ciphers.
 .\"*********************************************************
 .TP
 .B \-\-ncp\-disable
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9be5a826..fd069c75 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2500,11 +2500,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
     }
 #endif /* P2MP_SERVER */
 
-    if (options->ncp_enabled && !tls_check_ncp_cipher_list(options->ncp_ciphers))
-    {
-        msg(M_USAGE, "NCP cipher list contains unsupported ciphers.");
-    }
-
     if (options->keysize)
     {
         msg(M_WARN, "WARNING: --keysize is DEPRECATED and will be removed in OpenVPN 2.6");
@@ -3079,6 +3074,15 @@ options_postprocess_mutate(struct options *o)
 
     options_postprocess_mutate_invariant(o);
 
+    if (o->ncp_enabled)
+    {
+        o->ncp_ciphers = mutate_ncp_cipher_list(o->ncp_ciphers, &o->gc);
+        if (o->ncp_ciphers == NULL)
+        {
+            msg(M_USAGE, "NCP cipher list contains unsupported ciphers or is too long.");
+        }
+    }
+
     if (o->remote_list && !o->connection_list)
     {
         /*
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 029ac1d5..ee3c2cb7 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -91,27 +91,68 @@ tls_peer_supports_ncp(const char *peer_info)
     }
 }
 
-bool
-tls_check_ncp_cipher_list(const char *list)
+char *
+mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
 {
-    bool unsupported_cipher_found = false;
+    bool error_found = false;
 
-    ASSERT(list);
+    struct buffer new_list  = alloc_buf(MAX_NCP_CIPHERS_LENGTH);
 
     char *const tmp_ciphers = string_alloc(list, NULL);
     const char *token = strtok(tmp_ciphers, ":");
     while (token)
     {
-        if (!cipher_kt_get(translate_cipher_name_from_openvpn(token)))
+        /* translate_cipher_name_from_openvpn also normalises the cipher name,
+         * e.g. replacing AeS-128-gCm with AES-128-GCM
+         */
+        const char *cipher_name = translate_cipher_name_from_openvpn(token);
+        const cipher_kt_t *ktc = cipher_kt_get(cipher_name);
+        if (!ktc)
         {
             msg(M_WARN, "Unsupported cipher in --ncp-ciphers: %s", token);
-            unsupported_cipher_found = true;
+            error_found = true;
+        }
+        else
+        {
+            const char *ovpn_cipher_name =
+                translate_cipher_name_to_openvpn(cipher_kt_name(ktc));
+
+            if (buf_len(&new_list)> 0)
+            {
+                /* The next if condition ensure there is always space for
+                 * a :
+                 */
+                buf_puts(&new_list, ":");
+            }
+
+            /* Ensure buffer has capacity for cipher name + : + \0 */
+            if (!(buf_forward_capacity(&new_list) >
+                  strlen(ovpn_cipher_name) + 2))
+            {
+                msg(M_WARN, "Length of --ncp-ciphers is over the"
+                    "limit of 127 chars");
+                error_found = true;
+            }
+            else
+            {
+                buf_puts(&new_list, ovpn_cipher_name);
+            }
         }
         token = strtok(NULL, ":");
     }
+
+
+
+    char *ret = NULL;
+    if (!error_found && buf_len(&new_list) > 0)
+    {
+        buf_null_terminate(&new_list);
+        ret = string_alloc(buf_str(&new_list), gc);
+    }
     free(tmp_ciphers);
+    free_buf(&new_list);
 
-    return 0 < strlen(list) && !unsupported_cipher_found;
+    return ret;
 }
 
 bool
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index 82d008d8..62822e89 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -87,10 +87,17 @@ tls_peer_ncp_list(const char *peer_info);
  * Check whether the ciphers in the supplied list are supported.
  *
  * @param list          Colon-separated list of ciphers
+ * @parms gc            gc_arena to allocate the returned string
  *
- * @returns true iff all ciphers in list are supported.
+ * @returns             colon separated string of normalised (via
+ *                      translate_cipher_name_from_openvpn) and
+ *                      zero terminated string iff all ciphers
+ *                      in list are supported and the total length
+ *                      is short than MAX_NCP_CIPHERS_LENGTH. NULL
+ *                      otherwise.
  */
-bool tls_check_ncp_cipher_list(const char *list);
+char *
+mutate_ncp_cipher_list(const char *list, struct gc_arena *gc);
 
 /**
  * Return true iff item is present in the colon-separated zero-terminated
@@ -98,4 +105,12 @@ bool tls_check_ncp_cipher_list(const char *list);
  */
 bool tls_item_in_cipher_list(const char *item, const char *list);
 
+/**
+ * The maximum length of a ncp-cipher string that is accepted.
+ *
+ * Since this list needs to be pushed as IV_CIPHERS, we are conservative
+ * about its length.
+ */
+#define MAX_NCP_CIPHERS_LENGTH 127
+
 #endif /* ifndef OPENVPN_SSL_NCP_H */
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index e71f4825..7684eed4 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -47,10 +47,24 @@ const char *aes_ciphers = "AES-256-GCM:AES-128-GCM";
 static void
 test_check_ncp_ciphers_list(void **state)
 {
-    assert_true(tls_check_ncp_cipher_list(aes_ciphers));
-    assert_true(tls_check_ncp_cipher_list(bf_chacha));
-    assert_false(tls_check_ncp_cipher_list("vollbit"));
-    assert_false(tls_check_ncp_cipher_list("AES-256-GCM:vollbit"));
+    struct gc_arena gc = gc_new();
+
+    assert_string_equal(mutate_ncp_cipher_list(aes_ciphers, &gc), aes_ciphers);
+
+    assert_string_equal(mutate_ncp_cipher_list(bf_chacha, &gc), bf_chacha);
+
+    assert_string_equal(mutate_ncp_cipher_list("BF-cbc:ChaCha20-Poly1305", &gc),
+                        bf_chacha);
+
+
+    assert_ptr_equal(mutate_ncp_cipher_list("vollbit", &gc), NULL);
+    assert_ptr_equal(mutate_ncp_cipher_list("AES-256-GCM:vollbit", &gc), NULL);
+    assert_ptr_equal(mutate_ncp_cipher_list("", &gc), NULL);
+
+    assert_ptr_equal(mutate_ncp_cipher_list(
+                         "ChaCha20-Poly1305:ChaCha20-Poly1305:ChaCha20-Poly1305:"
+                         "ChaCha20-Poly1305:ChaCha20-Poly1305:ChaCha20-Poly1305:"
+                         "ChaCha20-Poly1305", &gc), NULL);
 }
 
 static void
@@ -64,7 +78,7 @@ test_extract_client_ciphers(void **state)
     assert_string_equal(aes_ciphers,peer_list);
     assert_true(tls_peer_supports_ncp(client_peer_info));
     free(peer_list);
-                
+
     client_peer_info = "foo=bar\nIV_foo=y\nIV_NCP=2\nIV_CIPHERS=BF-CBC";
     peer_list = tls_peer_ncp_list(client_peer_info);
     assert_string_equal("BF-CBC", peer_list);
@@ -101,8 +115,8 @@ test_poor_man(void **state)
     struct gc_arena gc = gc_new();
     char *best_cipher;
 
-    const char *serverlist="CHACHA20_POLY1305:AES-128-GCM";
-    
+    const char *serverlist = "CHACHA20_POLY1305:AES-128-GCM";
+
     best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
                                       "IV_YOLO=NO\nIV_BAR=7",
                                       "BF-CBC", &gc);
@@ -131,8 +145,8 @@ test_ncp_best(void **state)
     struct gc_arena gc = gc_new();
     char *best_cipher;
 
-    const char *serverlist="CHACHA20_POLY1305:AES-128-GCM:AES-256-GCM";
-    
+    const char *serverlist = "CHACHA20_POLY1305:AES-128-GCM:AES-256-GCM";
+
     best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
                                       "IV_YOLO=NO\nIV_NCP=2\nIV_BAR=7",
                                       "BF-CBC", &gc);
@@ -150,7 +164,7 @@ test_ncp_best(void **state)
     best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
                                       "IV_CIPHERS=AES-128-GCM",
                                       "AES-256-CBC", &gc);
-    
+
 
     assert_string_equal(best_cipher, "AES-128-GCM");
 
@@ -167,16 +181,16 @@ test_ncp_best(void **state)
 
 
 
-
 const struct CMUnitTest ncp_tests[] = {
     cmocka_unit_test(test_check_ncp_ciphers_list),
-    cmocka_unit_test(test_extract_client_ciphers),    
+    cmocka_unit_test(test_extract_client_ciphers),
     cmocka_unit_test(test_poor_man),
     cmocka_unit_test(test_ncp_best)
 };
 
 
-int main(void)
+int
+main(void)
 {
     return cmocka_run_group_tests(ncp_tests, NULL, NULL);
 }
-- 
2.22.0


