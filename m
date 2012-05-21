From: Alon Bar-Lev <alon.barlev@...277...>
Date: Mon, 21 May 2012 14:04:14 +0300
Message-Id: <1337598254-32641-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH] build: check minimum polarssl version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Pre 1.1 is unsupported, API was changed.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4592727..5ace128 100644
--- a/configure.ac
+++ b/configure.ac
@@ -743,6 +743,27 @@ if test -z "${POLARSSL_LIBS}"; then
 	)
 fi
 
+if test "${with_crypto_library}" = "polarssl" ; then
+	AC_MSG_CHECKING([polarssl version])
+	old_CFLAGS="${CFLAGS}"
+	CFLAGS="${POLARSSL_CFLAGS} ${CFLAGS}"
+	AC_COMPILE_IFELSE(
+		[AC_LANG_PROGRAM(
+			[[
+#include <polarssl/version.h>
+			]],
+			[[
+#if POLARSSL_VERSION_NUMBER <= 0x01010000
+#error invalid version
+#endif
+			]]
+		)],
+		[AC_MSG_RESULT([ok])],
+		[AC_MSG_ERROR([invalid polarssl version])]
+	)
+	CFLAGS="${old_CFLAGS}"
+fi
+
 AC_ARG_VAR([LZO_CFLAGS], [C compiler flags for lzo])
 AC_ARG_VAR([LZO_LIBS], [linker flags for lzo])
 have_lzo="yes"
-- 
1.7.3.4


