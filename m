From: Gert Doering <gert@...1296...>
Date: Thu,  8 Jan 2026 16:42:43 +0100
Message-ID: <20260108154248.21706-1-gert@...1296...>
In-Reply-To: <gerrit.1767875377000.Ibc964c13724316ca96276ba6b7d34dbbfcf52064@...2715...>
References: <gerrit.1767875377000.Ibc964c13724316ca96276ba6b7d34dbbfcf52064@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix building test_tls_crypt with cmocka
 2.0
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

This was missed in commit
6db186e0b1d9783ea96e8a945a47fd23b45e4778 since we
only built with cmocka 2.0 on macOS and that doesn't
build test_tls_crypt.

Now that we build with cmocka 2.0 also on Debian Sid
we noticed the additional issues.

Change-Id: Ibc964c13724316ca96276ba6b7d34dbbfcf52064
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1460
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1460
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 4a80a4c..730841e 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -110,8 +110,8 @@
 __wrap_buffer_write_file(const char *filename, const struct buffer *buf)
 {
     const char *pem = BSTR(buf);
-    check_expected(filename);
-    check_expected(pem);
+    check_expected_ptr(filename);
+    check_expected_ptr(pem);
 
     return mock_type(bool);
 }
@@ -119,7 +119,7 @@
 struct buffer
 __wrap_buffer_read_from_file(const char *filename, struct gc_arena *gc)
 {
-    check_expected(filename);
+    check_expected_ptr(filename);
 
     const char *pem_str = mock_ptr_type(const char *);
     struct buffer ret = alloc_buf_gc(strlen(pem_str) + 1, gc);

