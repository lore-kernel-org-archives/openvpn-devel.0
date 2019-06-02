From: Steffan Karger <steffan@...1856...>
Date: Sun,  2 Jun 2019 12:18:31 +0200
Message-Id: <20190602101831.21216-1-steffan@...1856...>
In-Reply-To: <20190116185517.GA61190@...1296...>
References: <20190116185517.GA61190@...1296...>
Subject: [Openvpn-devel] [PATCH] configure.ac: add lzo CFLAGS/LIBS to the
 test flags
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

This fixes "make check" builds on systems with lzo on a non-standard
location.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 59673e049..56598217f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1353,8 +1353,13 @@ AC_SUBST([sampledir])
 AC_SUBST([systemdunitdir])
 AC_SUBST([tmpfilesdir])
 
-TEST_LDFLAGS="${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} -lcmocka -L\$(top_builddir)/vendor/dist/lib -Wl,-rpath,\$(top_builddir)/vendor/dist/lib"
-TEST_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} -I\$(top_srcdir)/include -I\$(top_builddir)/vendor/dist/include"
+TEST_LDFLAGS="${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS}"
+TEST_LDFLAGS="${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS}"
+TEST_LDFLAGS="${TEST_LDFLAGS} -lcmocka -L\$(top_builddir)/vendor/dist/lib"
+TEST_LDFLAGS="${TEST_LDFLAGS} -Wl,-rpath,\$(top_builddir)/vendor/dist/lib"
+TEST_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS}"
+TEST_CFLAGS="${TEST_CFLAGS} ${OPTIONAL_LZO_CFLAGS}"
+TEST_CFLAGS="${TEST_CFLAGS} -I\$(top_srcdir)/include -I\$(top_builddir)/vendor/dist/include"
 
 AC_SUBST([TEST_LDFLAGS])
 AC_SUBST([TEST_CFLAGS])
-- 
2.17.1


