From: Gert Doering <gert@...1296...>
Date: Wed,  8 Oct 2025 15:33:31 +0200
Message-ID: <20251008133338.23652-1-gert@...1296...>
In-Reply-To: <gerrit.1759928297000.I59a49696acd665d43b21e5c23f24b86c15989cd6@...2715...>
References: <gerrit.1759928297000.I59a49696acd665d43b21e5c23f24b86c15989cd6@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] test_options_parse: Do not use uintmax_t
 instead of LargestIntegralType
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

At least on OpenBSD it seems that uintmax_t maps
to unsigned long long always, but LargestIntegralType
is unsigned long. So if we have a version of cmocka.h
that defines LargestIntegralType then respect that.

Change-Id: I59a49696acd665d43b21e5c23f24b86c15989cd6
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1256
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1256
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tests/openvpn/test_options_parse.c
index e552dd7..0ae37f5 100644
--- a/tests/unit_tests/openvpn/test_options_parse.c
+++ b/tests/unit_tests/openvpn/test_options_parse.c
@@ -198,14 +198,25 @@
                        &option_types_found, &es);
 }
 
+/* compat with various versions of cmocka.h
+ * Older versions have LargestIntegralType. Newer
+ * versions use uintmax_t. But LargestIntegralType
+ * is not guaranteed to be equal to uintmax_t, so
+ * we can't use that unconditionally. So we only use
+ * it if cmocka.h does not define LargestIntegralType.
+ */
+#ifndef LargestIntegralType
+#define LargestIntegralType uintmax_t
+#endif
+
 union tokens_parameter
 {
-    uintmax_t as_int;
+    LargestIntegralType as_int;
     void *as_pointer;
 };
 
 static int
-check_tokens(const uintmax_t value, const uintmax_t expected)
+check_tokens(const LargestIntegralType value, const LargestIntegralType expected)
 {
     union tokens_parameter temp;
     temp.as_int = value;

