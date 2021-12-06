From: Arne Schwabe <arne@...1227...>
Date: Mon,  6 Dec 2021 01:57:40 +0100
Message-Id: <20211206005740.3072232-1-arne@...1227...>
In-Reply-To: <20211201180727.2496903-1-arne@...1227...>
References: <20211201180727.2496903-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 1/9] Implement optional cipher in
 --data-ciphers prefixed with ?
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

This allows to use the same configuration multiple platforms/ssl libraries
and include optional algorithms that are not available on all platforms

For example "AES-256-GCM:AES-128-GCM:?CHACHA20-POLY1305" can be used to
emulate the default behaviour of OpenVPN 2.6.

Patch v2: fix error_found reset by optional cipher, fix typo in Changes.rst

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_ncp.c               | 8 ++++++--
 tests/unit_tests/openvpn/test_ncp.c | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 2f1df1c52..2561daab2 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -134,7 +134,7 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
         {
             const char* optstr = optional ? "optional ": "";
             msg(M_WARN, "Unsupported %scipher in --data-ciphers: %s", optstr, token);
-            error_found = !optional;
+            error_found = error_found || !optional;
         }
         else
         {
@@ -448,6 +448,10 @@ p2p_ncp_set_options(struct tls_multi *multi, struct tls_session *session)
 
         }
     }
+    if (iv_proto_peer & IV_PROTO_RENOG_DYN_TLSCRYPT)
+    {
+        session->opt->crypto_flags |= CO_USE_DYN_TLSCRYPT_RENOG;
+    }
 #endif
 }
 
@@ -491,4 +495,4 @@ p2p_mode_ncp(struct tls_multi *multi, struct tls_session *session)
         multi->use_peer_id, multi->peer_id, common_cipher);
 
     gc_free(&gc);
-}
\ No newline at end of file
+}
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index faf09a36c..6702133ad 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -95,6 +95,9 @@ test_check_ncp_ciphers_list(void **state)
     /* All unsupported should still yield an empty list */
     assert_ptr_equal(mutate_ncp_cipher_list("?kugelfisch:?grasshopper", &gc), NULL);
 
+    /* If the last is optional, previous invalid ciphers should be ignored */
+    assert_ptr_equal(mutate_ncp_cipher_list("Vollbit:Littlebit:AES-256-CBC:BF-CBC:?nixbit", &gc), NULL);
+
     /* For testing that with OpenSSL 1.1.0+ that also accepts ciphers in
      * a different spelling the normalised cipher output is the same */
     bool have_chacha_mixed_case = cipher_kt_get("ChaCha20-Poly1305");
-- 
2.33.0


