From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Oct 2022 17:41:16 +0200
Message-Id: <20221010154116.1685877-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Ensure only CBC, CFB,
 OFB and AEAD ciphers are considered valid data ciphers
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

Make sure cipher_valid only considered these four operations as valid.
This fixes that somjething like --data-ciphers  AES-256-GCM:AES-128-CCM
will start but later fail when trying to use the CCM cipher.

We say "a supported AEAD" mode in our error since CCM is also an AEAD mode
but one we support like GCM.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_ncp.c               | 8 ++++++++
 tests/unit_tests/openvpn/test_ncp.c | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 013021d6d..14a4e223d 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -136,6 +136,14 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
             msg(M_WARN, "Unsupported %scipher in --data-ciphers: %s", optstr, token);
             error_found = error_found || !optional;
         }
+        else if (!nonecipher && !cipher_kt_mode_aead(token)
+                 && !cipher_kt_mode_cbc(token)
+                 && !cipher_kt_mode_ofb_cfb(token))
+        {
+            msg(M_WARN, "Cipher algorithm '%s' does use CFB, OFB, CBC, or "
+                "a supported AEAD mode", token);
+            error_found = error_found || !optional;
+        }
         else
         {
             const char *ovpn_cipher_name = cipher_kt_name(token);
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 2595d8c4e..bb9a28244 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -98,6 +98,12 @@ test_check_ncp_ciphers_list(void **state)
     /* If the last is optional, previous invalid ciphers should be ignored */
     assert_ptr_equal(mutate_ncp_cipher_list("Vollbit:Littlebit:AES-256-CBC:BF-CBC:?nixbit", &gc), NULL);
 
+    /* We do not support CCM ciphers */
+    assert_ptr_equal(mutate_ncp_cipher_list("AES-256-GCM:AES-128-CCM", &gc), NULL);
+
+    assert_string_equal(mutate_ncp_cipher_list("AES-256-GCM:?AES-128-CCM:AES-128-GCM", &gc),
+                        aes_ciphers);
+
     /* For testing that with OpenSSL 1.1.0+ that also accepts ciphers in
      * a different spelling the normalised cipher output is the same */
     bool have_chacha_mixed_case = cipher_valid("ChaCha20-Poly1305");
-- 
2.37.0 (Apple Git-136)


