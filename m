From: Arne Schwabe <arne@...1227...>
Date: Wed,  1 Dec 2021 19:07:19 +0100
Message-Id: <20211201180727.2496903-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/9] Implement optional cipher in
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                           |  4 ++++
 doc/man-sections/protocol-options.rst |  7 +++++++
 src/openvpn/ssl_ncp.c                 | 16 ++++++++++++++--
 tests/unit_tests/openvpn/test_ncp.c   | 11 +++++++++++
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 7cceffcdb..c1a04deed 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -58,6 +58,10 @@ OpenSSL 3.0 support
     (and other deprecated) algorithm by default and the new option ``--providers``
     allows loading the legacy provider to renable these algorithms.
 
+Optional ciphers in ``--data-ciphers``
+    Ciphers in ``--data-ciphers`` can now be prefixes with a ``?`` to mark
+    those as optional and only use them if the SSL library supports them.
+
 Deprecated features
 -------------------
 ``inetd`` has been removed
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index c7aa6b0e3..7095b6f4d 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -204,6 +204,13 @@ configured in a compatible way between both the local and remote side.
   supported by the client will be pushed to clients that support cipher
   negotiation.
 
+  Starting with OpenVPN 2.6 a cipher can be prefixed with a :code:`?` to mark
+  it as optional. This allows including ciphers in the list that may not be
+  available on all platforms.
+  E.g. :code:`AES-256-GCM:AES-128-GCM:?CHACHA20-POLY1305` would only enable
+  Chacha20-Poly1305 if the underlying SSL library (and its configuration)
+  supports it.
+
   Cipher negotiation is enabled in client-server mode only. I.e. if
   ``--mode`` is set to 'server' (server-side, implied by setting
   ``--server`` ), or if ``--pull`` is specified (client-side, implied by
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 022a9dc3b..b0b248aae 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -109,7 +109,18 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
          * (and translate_cipher_name_from_openvpn/
          * translate_cipher_name_to_openvpn) also normalises the cipher name,
          * e.g. replacing AeS-128-gCm with AES-128-GCM
+         *
+         * ciphers that have ? in front of them are considered optional and
+         * OpenVPN will only warn if they are not found (and remove them from
+         * the list)
          */
+
+        bool optional = false;
+        if (token[0] == '?')
+        {
+            token= token + 1;
+            optional = true;
+        }
         const cipher_kt_t *ktc = cipher_kt_get(token);
         if (strcmp(token, "none") == 0)
         {
@@ -121,8 +132,9 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
         }
         if (!ktc && strcmp(token, "none") != 0)
         {
-            msg(M_WARN, "Unsupported cipher in --data-ciphers: %s", token);
-            error_found = true;
+            const char* optstr = optional ? "optional ": "";
+            msg(M_WARN, "Unsupported %scipher in --data-ciphers: %s", optstr, token);
+            error_found = !optional;
         }
         else
         {
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 6fb0c0e51..faf09a36c 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -84,6 +84,17 @@ test_check_ncp_ciphers_list(void **state)
         assert_ptr_equal(mutate_ncp_cipher_list(bf_chacha, &gc), NULL);
     }
 
+    /* Check that optional ciphers work */
+    assert_string_equal(mutate_ncp_cipher_list("AES-256-GCM:?vollbit:AES-128-GCM", &gc),
+                        aes_ciphers);
+
+    /* Check that optional ciphers work */
+    assert_string_equal(mutate_ncp_cipher_list("?AES-256-GCM:?AES-128-GCM", &gc),
+                        aes_ciphers);
+
+    /* All unsupported should still yield an empty list */
+    assert_ptr_equal(mutate_ncp_cipher_list("?kugelfisch:?grasshopper", &gc), NULL);
+
     /* For testing that with OpenSSL 1.1.0+ that also accepts ciphers in
      * a different spelling the normalised cipher output is the same */
     bool have_chacha_mixed_case = cipher_kt_get("ChaCha20-Poly1305");
-- 
2.33.0


