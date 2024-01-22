From: Gert Doering <gert@...1296...>
Date: Mon, 22 Jan 2024 14:09:09 +0100
Message-ID: <20240122130909.10706-1-gert@...1296...>
In-Reply-To: <gerrit.1705927509000.I378081f391ad755d0a6fd5613de5c2a8bacc389a@...2715...>
References: <gerrit.1705927509000.I378081f391ad755d0a6fd5613de5c2a8bacc389a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix ssl unit tests on OpenSSL 1.0.2
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

From: Arne Schwabe <arne@...1227...>

OpenSSL 1.1.1 will initialise itself using clever linker magic. For
OpenSSL 1.0.2 we need to manually initialise the library. For other
unit tests just doing the OpenSSL_add_all_algorithms is enough but
this unit test needs a more complete initialisation.

Change-Id: I378081f391ad755d0a6fd5613de5c2a8bacc389a
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/503
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index fd2049f..d0c3df7 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -127,13 +127,13 @@
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)
-    OpenSSL_add_all_algorithms();
+    tls_init_lib();
 #endif
 
     int ret = cmocka_run_group_tests_name("crypto tests", tests, NULL, NULL);
 
 #if defined(ENABLE_CRYPTO_OPENSSL)
-    EVP_cleanup();
+    tls_free_lib();
 #endif
 
     return ret;

