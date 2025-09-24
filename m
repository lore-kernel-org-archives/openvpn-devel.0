From: Gert Doering <gert@...1296...>
Date: Wed, 24 Sep 2025 14:41:48 +0200
Message-ID: <20250924124154.15963-1-gert@...1296...>
In-Reply-To: <gerrit.1758555758000.Iab9e780d9649d7581e5f6aa4b23e72bbed5e145b@...2715...>
References: <gerrit.1758555758000.Iab9e780d9649d7581e5f6aa4b23e72bbed5e145b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Make unit tests -Wconversion clean
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

Only trivial problems left after the other patches
have been merged.

Change-Id: Iab9e780d9649d7581e5f6aa4b23e72bbed5e145b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1205
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1205
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 22e6912..93dfa42 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -674,15 +674,10 @@
     struct crypto_options co;
 };
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static int
 crypto_test_epoch_setup(void **state)
 {
-    int *num_future_keys = (int *)*state;
+    uint16_t *num_future_keys = (uint16_t *)*state;
     struct epoch_test_state *data = calloc(1, sizeof(struct epoch_test_state));
 
     data->gc = gc_new();
@@ -699,10 +694,6 @@
     return 0;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static int
 crypto_test_epoch_teardown(void **state)
 {
@@ -906,9 +897,9 @@
 int
 main(void)
 {
-    int prestate_num13 = 13;
-    int prestate_num16 = 16;
-    int prestate_num32 = 32;
+    uint16_t prestate_num13 = 13;
+    uint16_t prestate_num16 = 16;
+    uint16_t prestate_num32 = 32;
 
     openvpn_unit_test_setup();
     const struct CMUnitTest tests[] = {
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index ed40a7d..8dc9b66 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -133,11 +133,6 @@
     const char *keyfile;
 } global_state;
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static int
 init(void **state)
 {
@@ -152,17 +147,16 @@
     {
         fail_msg("make tmpfile for certificate or key data failed (error = %d)", errno);
     }
-    assert_int_equal(write(certfd, unittest_cert, strlen(unittest_cert)), strlen(unittest_cert));
-    assert_int_equal(write(keyfd, unittest_key, strlen(unittest_key)), strlen(unittest_key));
+    /* Awkward casts required for MinGW with -O0 only */
+    assert_int_equal(write(certfd, unittest_cert, (unsigned int)strlen(unittest_cert)),
+                     strlen(unittest_cert));
+    assert_int_equal(write(keyfd, unittest_key, (unsigned int)strlen(unittest_key)),
+                     strlen(unittest_key));
     close(certfd);
     close(keyfd);
     return 0;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static int
 cleanup(void **state)
 {

