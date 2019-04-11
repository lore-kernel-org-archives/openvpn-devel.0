From: chipitsine@...277...
Date: Thu, 11 Apr 2019 12:45:19 +0500
Message-Id: <20190411074519.9982-2-chipitsine@...277...>
In-Reply-To: <20190411074519.9982-1-chipitsine@...277...>
References: <20190411074519.9982-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/1] configure.ac: fix compile-time error in
 argv_testdriver
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

From: Ilya Shipitsin <chipitsine@...277...>

allow run tests when lzo is installed to non default directory
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index dfb268ca..bcc74c32 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1360,8 +1360,8 @@ AC_SUBST([VENDOR_SRC_ROOT])
 AC_SUBST([VENDOR_BUILD_ROOT])
 AC_SUBST([VENDOR_DIST_ROOT])
 
-TEST_LDFLAGS="${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_LIBS} -lcmocka -L\$(abs_top_builddir)/vendor/dist/lib -Wl,-rpath,\$(abs_top_builddir)/vendor/dist/lib"
-TEST_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_CFLAGS} -I\$(top_srcdir)/include -I\$(abs_top_builddir)/vendor/dist/include"
+TEST_LDFLAGS="${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_LIBS} ${OPTIONAL_LZO_LIBS} -lcmocka -L\$(abs_top_builddir)/vendor/dist/lib -Wl,-rpath,\$(abs_top_builddir)/vendor/dist/lib"
+TEST_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_CFLAGS} ${OPTIONAL_LZO_CFLAGS} -I\$(top_srcdir)/include -I\$(abs_top_builddir)/vendor/dist/include"
 
 AC_SUBST([TEST_LDFLAGS])
 AC_SUBST([TEST_CFLAGS])
-- 
2.20.1


