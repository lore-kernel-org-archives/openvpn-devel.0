From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 30 Jun 2023 14:39:08 +0200
Message-Id: <20230630123908.82588-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] test_tls_crypt: Improve mock() usage to be
 more portable
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

Use the casting variants of mock(). Using the mock_ptr_type
fixes an existing bug where test_tls_crypt.c couldn't
build in MinGW 32bit:

test_tls_crypt.c:127:27: error:
cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  127 |     const char *pem_str = (const char *) mock();

Change-Id: I6c03313b8677fa07c07e718b1f85f7efd3c4dea8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 tests/unit_tests/openvpn/test_tls_crypt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 8bed042f..ed7c7948 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -116,7 +116,7 @@ __wrap_buffer_write_file(const char *filename, const struct buffer *buf)
     check_expected(filename);
     check_expected(pem);
 
-    return mock();
+    return mock_type(bool);
 }
 
 struct buffer
@@ -124,7 +124,7 @@ __wrap_buffer_read_from_file(const char *filename, struct gc_arena *gc)
 {
     check_expected(filename);
 
-    const char *pem_str = (const char *) mock();
+    const char *pem_str = mock_ptr_type(const char *);
     struct buffer ret = alloc_buf_gc(strlen(pem_str) + 1, gc);
     buf_write(&ret, pem_str, strlen(pem_str) + 1);
 
-- 
2.34.1


