From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 19 Jun 2023 15:29:33 +0200
Message-Id: <20230619132934.76085-4-frank@...2641...>
In-Reply-To: <20230619132934.76085-1-frank@...2641...>
References: <20230614102115.138724-1-frank@...2641...>
 <20230619132934.76085-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/4] unit_tests: Add missing cert_data.h to
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

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 tests/unit_tests/openvpn/Makefile.am | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index ccd0e37b..dbf658ac 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -162,7 +162,7 @@ cryptoapi_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 cryptoapi_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS) -lcrypt32 -lncrypt
 cryptoapi_testdriver_SOURCES = test_cryptoapi.c mock_msg.c \
-	pkey_test_utils.c \
+	pkey_test_utils.c cert_data.h \
 	$(top_srcdir)/src/openvpn/xkey_helper.c \
 	$(top_srcdir)/src/openvpn/xkey_provider.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -180,7 +180,7 @@ pkcs11_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 pkcs11_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
 pkcs11_testdriver_SOURCES = test_pkcs11.c mock_msg.c \
-	pkey_test_utils.c mock_get_random.c \
+	pkey_test_utils.c cert_data.h mock_get_random.c \
 	$(top_srcdir)/src/openvpn/xkey_helper.c \
 	$(top_srcdir)/src/openvpn/xkey_provider.c \
 	$(top_srcdir)/src/openvpn/argv.c \
-- 
2.34.1


