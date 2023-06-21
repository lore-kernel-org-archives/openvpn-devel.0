From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 21 Jun 2023 14:58:42 +0200
Message-Id: <20230621125842.191355-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2.6] unit_tests: Add missing cert_data.h to
 source list for unit tests
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

Document the dependency. Also fixes cert_data.h missing from
distribution.

This is the "backport" of commit
97223cb057a0edfafd28b34427449bb3eda7d0be to release/2.6.

Change-Id: Ib82208bfa12cc8ba5ff08b4c010bf398bc92d249
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 tests/unit_tests/openvpn/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 4391a54e..650126c7 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -156,6 +156,7 @@ cryptoapi_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 cryptoapi_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS) -lcrypt32 -lncrypt
 cryptoapi_testdriver_SOURCES = test_cryptoapi.c mock_msg.c \
+	cert_data.h \
 	$(top_srcdir)/src/openvpn/xkey_helper.c \
 	$(top_srcdir)/src/openvpn/xkey_provider.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
-- 
2.34.1


