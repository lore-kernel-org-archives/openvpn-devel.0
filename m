From: Gert Doering <gert@...1296...>
Date: Mon,  2 Mar 2026 19:16:22 +0100
Message-ID: <20260302181627.29008-1-gert@...1296...>
In-Reply-To: <gerrit.1769789455000.Ib0d2b9520e4a77a9f4bf70ce092f76ca73608537@...2715...>
References: <gerrit.1769789455000.Ib0d2b9520e4a77a9f4bf70ce092f76ca73608537@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] ssl_ncp: Fix length check in
 mutate_ncp_cipher_list
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

* Make it more readable by removing a level of negation
* Fix an off-by-one error. It accepted one char fewer than
  allowed.
* Slightly improve the UT.

Change-Id: Ib0d2b9520e4a77a9f4bf70ce092f76ca73608537
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1503
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1503
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 500e09d..fdac6925 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -92,11 +92,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 char *
 mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
 {
@@ -168,7 +163,7 @@
             }
 
             /* Ensure buffer has capacity for cipher name + : + \0 */
-            if (!(buf_forward_capacity(&new_list) > strlen(ovpn_cipher_name) + 2))
+            if (buf_forward_capacity(&new_list) < (int)strlen(ovpn_cipher_name) + 2)
             {
                 msg(M_WARN, "Length of --data-ciphers is over the "
                             "limit of 127 chars");
@@ -207,10 +202,6 @@
     o->ncp_ciphers = ncp_ciphers;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 tls_item_in_cipher_list(const char *item, const char *list)
 {
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 9f569a7..52a41ee 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -123,10 +123,23 @@
     assert_ptr_equal(mutate_ncp_cipher_list("AES-256-GCM:vollbit", &gc), NULL);
     assert_ptr_equal(mutate_ncp_cipher_list("", &gc), NULL);
 
-    assert_ptr_equal(mutate_ncp_cipher_list("ChaCha20-Poly1305:ChaCha20-Poly1305:ChaCha20-Poly1305:"
-                                            "ChaCha20-Poly1305:ChaCha20-Poly1305:ChaCha20-Poly1305:"
-                                            "ChaCha20-Poly1305",
-                                            &gc),
+    const char long_string[MAX_NCP_CIPHERS_LENGTH] =
+        "CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:"
+        "CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:"
+        "CHACHA20-POLY1305";
+    const char longer_string[MAX_NCP_CIPHERS_LENGTH + 1] =
+        "CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:"
+        "CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:"
+        "CHACHA20-POLY1305:";
+    const char longest_string[] =
+        "CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:"
+        "CHACHA20-POLY1305:CHACHA20-POLY1305:CHACHA20-POLY1305:"
+        "CHACHA20-POLY1305:CHACHA20-POLY1305";
+    assert_string_equal(mutate_ncp_cipher_list(long_string, &gc),
+                        long_string);
+    assert_string_equal(mutate_ncp_cipher_list(longer_string, &gc),
+                        long_string);
+    assert_ptr_equal(mutate_ncp_cipher_list(longest_string, &gc),
                      NULL);
 
 #ifdef ENABLE_CRYPTO_OPENSSL

