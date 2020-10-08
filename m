From: Arne Schwabe <arne@...1227...>
Date: Thu,  8 Oct 2020 13:59:59 +0200
Message-Id: <20201008115959.21151-1-arne@...1227...>
In-Reply-To: <20200930131317.1299-2-arne@...1227...>
References: <20200930131317.1299-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3] Allow 'none' cipher being specified in
 --data-ciphers
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

Although we want to get rid of none as cipher, we still have not
deprecated it. In order to use it currently you need
--ncp-disable together with --cipher none to use the none cipher
otherwise OpenVPN will spit out an error about an unrecognised
cipher in --data-ciphers.

In our current situation allowing none to be specified in data-ciphers
is the lesser evil.

This commit also fixes that we use '[null-cipher]' instead 'none' when
setting remote_cipher.

Note that negotiating to cipher 'none' can the same the same problems
with frame size calculation as any other non AEAD cipher. If
--cipher none is also specified in the configuration, the workaround
of commit e539c95dc will also apply to cipher none.

Patch V2: Also work correctly if remote_cipher is NULL.
Patch V3: fix unit tests, add note about corner case

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c                   |  8 ++++++++
 src/openvpn/ssl_ncp.c               | 16 +++++++++++++++-
 tests/unit_tests/openvpn/test_ncp.c | 14 ++++++++++++--
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3535fc72..f90c6a85 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2554,6 +2554,14 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
     multi->remote_ciphername =
         options_string_extract_option(options, "cipher", NULL);
 
+    /* In OCC we send '[null-cipher]' instead 'none' */
+    if (multi->remote_ciphername
+        && strcmp(multi->remote_ciphername, "[null-cipher]") == 0)
+    {
+        free(multi->remote_ciphername);
+        multi->remote_ciphername = string_alloc("none", NULL);
+    }
+
     if (tls_session_user_pass_enabled(session))
     {
         /* Perform username/password authentication */
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 55496395..c8229044 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -110,7 +110,15 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
          * e.g. replacing AeS-128-gCm with AES-128-GCM
          */
         const cipher_kt_t *ktc = cipher_kt_get(token);
-        if (!ktc)
+        if (strcmp(token, "none") == 0)
+        {
+            msg(M_WARN, "WARNING: cipher 'none' specified for --data-ciphers. "
+                        "This allows negotiation of NO encryption and "
+                        "tunnelled data WILL then be transmitted in clear text "
+                        "over the network! "
+                        "PLEASE DO RECONSIDER THIS SETTING!");
+        }
+        if (!ktc && strcmp(token, "none")!= 0)
         {
             msg(M_WARN, "Unsupported cipher in --data-ciphers: %s", token);
             error_found = true;
@@ -118,6 +126,12 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
         else
         {
             const char *ovpn_cipher_name = cipher_kt_name(ktc);
+            if (ktc == NULL)
+            {
+                /* NULL resolves to [null-cipher] but we need none for
+                 * data-ciphers */
+                ovpn_cipher_name = "none";
+            }
 
             if (buf_len(&new_list)> 0)
             {
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index a4334c89..4077be5e 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -50,7 +50,9 @@ test_check_ncp_ciphers_list(void **state)
     struct gc_arena gc = gc_new();
     bool have_chacha = cipher_kt_get("CHACHA20-POLY1305");
 
-
+    assert_string_equal(mutate_ncp_cipher_list("none", &gc), "none");
+    assert_string_equal(mutate_ncp_cipher_list("AES-256-GCM:none", &gc),
+                        "AES-256-GCM:none");
 
     assert_string_equal(mutate_ncp_cipher_list(aes_ciphers, &gc), aes_ciphers);
 
@@ -139,7 +141,7 @@ test_poor_man(void **state)
     char *best_cipher;
 
     const char *serverlist = "CHACHA20_POLY1305:AES-128-GCM";
-    const char *serverlistbfcbc = "CHACHA20_POLY1305:AES-128-GCM:BF-CBC";
+    const char *serverlistbfcbc = "CHACHA20_POLY1305:AES-128-GCM:BF-CBC:none";
 
     best_cipher = ncp_get_best_cipher(serverlist,
                                       "IV_YOLO=NO\nIV_BAR=7",
@@ -166,6 +168,14 @@ test_poor_man(void **state)
 
     assert_string_equal(best_cipher, "AES-128-GCM");
 
+    best_cipher = ncp_get_best_cipher(serverlist, NULL,
+                                      "none", &gc);
+    assert_ptr_equal(best_cipher, NULL);
+
+    best_cipher = ncp_get_best_cipher(serverlistbfcbc, NULL,
+                                      "none", &gc);
+    assert_string_equal(best_cipher, "none");
+
     best_cipher = ncp_get_best_cipher(serverlist, NULL,NULL, &gc);
     assert_ptr_equal(best_cipher, NULL);
 
-- 
2.26.2


