From: selva.nair@...277...
Date: Mon, 12 Aug 2024 19:21:58 -0400
Message-Id: <20240812232158.3776869-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] test_pkcs11.c: set file offset to 0 after
 ftruncate
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

From: Selva Nair <selva.nair@...277...>

Currently key and cert file fd's are reused after ftruncate()
without setting the offset to zero. This causes subsequent
data to be written at some finite offset with the hole in
the file automatically filled by zeros. Fix it by calling
lseek() to set the offset to zero.

The test works nevertheless because p11tool seem to generously
ignore any junk before the "BEGIN" marker.

Change-Id: Ib0fe15a4ba18d89216b0288e6cd6be66ed377bd4
Signed-off-by: Selva Nair <selva.nair@...277...>
---
 tests/unit_tests/openvpn/test_pkcs11.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index 5518fa15..3fe3e460 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -273,6 +273,8 @@ init(void **state)
 
         assert_int_equal(ftruncate(cert_fd, 0), 0);
         assert_int_equal(ftruncate(key_fd, 0), 0);
+        assert_int_equal(lseek(cert_fd, 0, SEEK_SET), 0);
+        assert_int_equal(lseek(key_fd, 0, SEEK_SET), 0);
         num_certs++;
     }
 
-- 
2.34.1


