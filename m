From: Gert Doering <gert@...1296...>
Date: Tue, 28 Jan 2025 18:58:55 +0100
Message-ID: <20250128175855.12289-1-gert@...1296...>
In-Reply-To: <gerrit.1737979301000.Ieee368e325d7f9c367fd91fee0fd3e281ee0855d@...2715...>
References: <gerrit.1737979301000.Ieee368e325d7f9c367fd91fee0fd3e281ee0855d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Add unit tests for atoi parsing options
 helper
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

Change-Id: Ieee368e325d7f9c367fd91fee0fd3e281ee0855d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/876
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
index a291f8f..b6ec744 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -37,10 +37,16 @@
 
 #include "errlevel.h"
 #include "error.h"
+#include "mock_msg.h"
 
 unsigned int x_debug_level = 0; /* Default to (almost) no debugging output */
+unsigned int print_x_debug_level = 0;
+
 bool fatal_error_triggered = false;
 
+char mock_msg_buf[MOCK_MSG_BUF];
+
+
 void
 mock_set_debug_level(int level)
 {
@@ -48,6 +54,18 @@
 }
 
 int
+mock_get_debug_level(void)
+{
+    return x_debug_level;
+}
+
+void
+mock_set_print_debug_level(int level)
+{
+    print_x_debug_level = level;
+}
+
+int
 get_debug_level(void)
 {
     return x_debug_level;
@@ -62,8 +80,14 @@
         fatal_error_triggered = true;
         printf("FATAL ERROR:");
     }
-    vprintf(format, arglist);
-    printf("\n");
+    CLEAR(mock_msg_buf);
+    vsnprintf(mock_msg_buf, sizeof(mock_msg_buf), format, arglist);
+
+    if ((flags & M_DEBUG_LEVEL) <= print_x_debug_level)
+    {
+        printf("%s", mock_msg_buf);
+        printf("\n");
+    }
 }
 
 void
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn/mock_msg.h
index be5f2e5..bc2ee5d 100644
--- a/tests/unit_tests/openvpn/mock_msg.h
+++ b/tests/unit_tests/openvpn/mock_msg.h
@@ -31,4 +31,18 @@
  */
 void mock_set_debug_level(int level);
 
+#define MOCK_MSG_BUF 2048
+
+extern bool fatal_error_triggered;
+extern char mock_msg_buf[MOCK_MSG_BUF];
+
+void
+mock_set_debug_level(int level);
+
+int
+mock_get_debug_level(void);
+
+void
+mock_set_print_debug_level(int level);
+
 #endif /* MOCK_MSG */
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 563d4ae..56e9d98 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -38,6 +38,7 @@
 #include "options_util.h"
 #include "test_common.h"
 #include "list.h"
+#include "mock_msg.h"
 
 static void
 test_compat_lzo_string(void **state)
@@ -311,13 +312,80 @@
     gc_free(&gc);
 }
 
+static void
+test_atoi_variants(void **state)
+{
+    assert_true(valid_integer("1234", true));
+    assert_true(valid_integer("1234", false));
+    assert_true(valid_integer("0", false));
+    assert_true(valid_integer("0", true));
+    assert_true(valid_integer("-777", false));
+    assert_false(valid_integer("-777", true));
+
+    assert_false(valid_integer("-777foo", false));
+    assert_false(valid_integer("-777foo", true));
+
+    assert_false(valid_integer("foo777", true));
+    assert_false(valid_integer("foo777", false));
+
+    /* 2**31 + 5 , just outside of signed int range */
+    assert_false(valid_integer("2147483653", true));
+    assert_false(valid_integer("2147483653", false));
+    assert_false(valid_integer("-2147483653", true));
+    assert_false(valid_integer("-2147483653", false));
+
+
+    int msglevel = D_LOW;
+    int saved_log_level = mock_get_debug_level();
+    mock_set_debug_level(D_LOW);
+
+    /* check happy path */
+    assert_int_equal(positive_atoi("1234", msglevel), 1234);
+    assert_int_equal(positive_atoi("0", msglevel), 0);
+
+    assert_int_equal(atoi_warn("1234", msglevel), 1234);
+    assert_int_equal(atoi_warn("0", msglevel), 0);
+    assert_int_equal(atoi_warn("-1194", msglevel), -1194);
+
+    CLEAR(mock_msg_buf);
+    assert_int_equal(positive_atoi("-1234", msglevel), 0);
+    assert_string_equal(mock_msg_buf, "Cannot parse argument '-1234' as non-negative integer");
+
+    /* 2**31 + 5 , just outside of signed int range */
+    CLEAR(mock_msg_buf);
+    assert_int_equal(positive_atoi("2147483653", msglevel), 0);
+    assert_string_equal(mock_msg_buf, "Cannot parse argument '2147483653' as non-negative integer");
+
+    CLEAR(mock_msg_buf);
+    assert_int_equal(atoi_warn("2147483653", msglevel), 0);
+    assert_string_equal(mock_msg_buf, "Cannot parse argument '2147483653' as integer");
+
+    CLEAR(mock_msg_buf);
+    assert_int_equal(positive_atoi("foo77", msglevel), 0);
+    assert_string_equal(mock_msg_buf, "Cannot parse argument 'foo77' as non-negative integer");
+
+    CLEAR(mock_msg_buf);
+    assert_int_equal(positive_atoi("77foo", msglevel), 0);
+    assert_string_equal(mock_msg_buf, "Cannot parse argument '77foo' as non-negative integer");
+
+    CLEAR(mock_msg_buf);
+    assert_int_equal(atoi_warn("foo77", msglevel), 0);
+    assert_string_equal(mock_msg_buf, "Cannot parse argument 'foo77' as integer");
+
+    CLEAR(mock_msg_buf);
+    assert_int_equal(atoi_warn("77foo", msglevel), 0);
+    assert_string_equal(mock_msg_buf, "Cannot parse argument '77foo' as integer");
+
+    mock_set_debug_level(saved_log_level);
+}
 
 const struct CMUnitTest misc_tests[] = {
     cmocka_unit_test(test_compat_lzo_string),
     cmocka_unit_test(test_auth_fail_temp_no_flags),
     cmocka_unit_test(test_auth_fail_temp_flags),
     cmocka_unit_test(test_auth_fail_temp_flags_msg),
-    cmocka_unit_test(test_list)
+    cmocka_unit_test(test_list),
+    cmocka_unit_test(test_atoi_variants)
 };
 
 int

