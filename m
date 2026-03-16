From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 16 Mar 2026 13:11:48 +0100
Message-ID: <20260316121148.25189-1-frank@...2641...>
In-Reply-To: <gerrit.1773243451000.I228f6fd9ff18256f09d4348df1fc48853f8e7306@...2715...>
References: <gerrit.1773243451000.I228f6fd9ff18256f09d4348df1fc48853f8e7306@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Remove unnecessary OpenSSL init and
 cleanup commands in unit tests
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
Cc: Arne Schwabe <arne@...1227...>, Arne Schwabe <arne-openvpn@...1227...>

From: Arne Schwabe <arne@...1227...>

After the removal of OpenSSL 1.0.2 support these instructions are
no longer needed and the main OpenVPN program also no longer calls
them in init_ssl_lib or free_ssl_lib.

Also remove them from the unit tests. This also solves a
deprecation warning on EVP_cleanup when compiling with aws-lc

Change-Id: I228f6fd9ff18256f09d4348df1fc48853f8e7306
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1568
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1568
This mail reflects revision 3 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

Note that I fixed the commit message subject line.

        
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index 82c20c1..d28bd8a 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -428,11 +428,5 @@
         cmocka_unit_test_setup_teardown(auth_token_test_session_mismatch, setup, teardown)
     };
 
-#if defined(ENABLE_CRYPTO_OPENSSL)
-    OpenSSL_add_all_algorithms();
-#endif
-
-    int ret = cmocka_run_group_tests_name("auth-token tests", tests, NULL, NULL);
-
-    return ret;
+    return cmocka_run_group_tests_name("auth-token tests", tests, NULL, NULL);
 }
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 1679d88..cb4eaa2 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -963,15 +963,5 @@
         cmocka_unit_test(epoch_test_derive_data_key)
     };
 
-#if defined(ENABLE_CRYPTO_OPENSSL)
-    OpenSSL_add_all_algorithms();
-#endif
-
-    int ret = cmocka_run_group_tests_name("crypto tests", tests, NULL, NULL);
-
-#if defined(ENABLE_CRYPTO_OPENSSL)
-    EVP_cleanup();
-#endif
-
-    return ret;
+    return cmocka_run_group_tests_name("crypto tests", tests, NULL, NULL);
 }
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 52a41ee..29365db 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -407,8 +407,6 @@
 main(void)
 {
     openvpn_unit_test_setup();
-#if defined(ENABLE_CRYPTO_OPENSSL)
-    OpenSSL_add_all_algorithms();
-#endif
+
     return cmocka_run_group_tests(ncp_tests, NULL, NULL);
 }
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index a94732d..cad2ce0 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -765,15 +765,5 @@
         cmocka_unit_test(test_extract_control_message)
     };
 
-#if defined(ENABLE_CRYPTO_OPENSSL)
-    OpenSSL_add_all_algorithms();
-#endif
-
-    int ret = cmocka_run_group_tests_name("pkt tests", tests, NULL, NULL);
-
-#if defined(ENABLE_CRYPTO_OPENSSL)
-    EVP_cleanup();
-#endif
-
-    return ret;
+    return cmocka_run_group_tests_name("pkt tests", tests, NULL, NULL);
 }
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index ed82279..1776d71 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -673,15 +673,5 @@
         cmocka_unit_test(test_tls_crypt_v2_write_client_key_file_metadata),
     };
 
-#if defined(ENABLE_CRYPTO_OPENSSL)
-    OpenSSL_add_all_algorithms();
-#endif
-
-    int ret = cmocka_run_group_tests_name("tls-crypt tests", tests, NULL, NULL);
-
-#if defined(ENABLE_CRYPTO_OPENSSL)
-    EVP_cleanup();
-#endif
-
-    return ret;
+    return cmocka_run_group_tests_name("tls-crypt tests", tests, NULL, NULL);
 }

