From: David Sommerseth <davids@...515...>
Date: Sat, 22 Apr 2017 00:07:28 +0200
Message-Id: <20170421220728.31867-1-davids@...515...>
In-Reply-To: <20170413172609.29093-1-davids@...515...>
References: <20170413172609.29093-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH v4] Fix broken ./configure on systems
	without openssl.pc
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

Commit 039a89c331e9b799 changed the OpenSSL check slightly, but that
broke ./configure on systems which do not install the openssl.pc
pkg-config support file.  This is typically an issue on most of the BSD
platforms, where the OpenSSL package from the base repository does not
provide that file.

We should anyway in this case have a better check of OpenSSL version
available.  So in the case pkg-config fails, it will run an additional
test looking for the OpenSSL version number in the opensslv.h header
file and check against that version number.

I did consider to rip out the pkg-config test all together, but decided
to let it stay.  If pkg-config works, it provides much more details to
the ./configure script than just the version number check - such as
include and library paths if those are outside the default system paths.

If the user adds OPENSSL_CFLAGS or OPENSSL_LIBS to the ./configure
script, the pkg-config will not be run.  But this patch ensures that the
OpenSSL version is also checked in this situation.

This patch have been tested on Scientic Linux 7.3 (RHEL clone) and
FreeBSD 10.3-RELEASE-p11.

v4 - Move the CFLAGS/LDFLAGS declarations before the manual
     version test; otherwise we're still testing the system install
     version

v3 - Remove not needed and duplicated OPENSSL_LIBS assignment
   - Fix tab/space issues in modified lines

v2 - Don't use try to simplify the version matching, use the full
     OPENSSL_VERSION_NUMBER
   - Fixed typo (OpneSSL -> OpenSSL)
   - Improve a few comments

Signed-off-by: David Sommerseth <davids@...515...>
---
 configure.ac | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index acea060..2b98375 100644
--- a/configure.ac
+++ b/configure.ac
@@ -860,11 +860,9 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 		PKG_CHECK_MODULES(
 			[OPENSSL],
 			[libcrypto >= 1.0.1, libssl >= 1.0.1],
-	                [have_openssl="yes"],
-			[AC_MSG_ERROR([Minimum supported OpenSSL version is 1.0.1])]
+			[have_openssl="yes"],
+			[] # If this fails, we will do another test next
 		)
-
-		OPENSSL_LIBS=${OPENSSL_LIBS:--lssl -lcrypto}
 	fi
 
 	saved_CFLAGS="${CFLAGS}"
@@ -872,6 +870,28 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 	CFLAGS="${CFLAGS} ${OPENSSL_CFLAGS}"
 	LIBS="${LIBS} ${OPENSSL_LIBS}"
 
+	# If pkgconfig check failed or OPENSSL_CFLAGS/OPENSSL_LIBS env vars
+	# are used, check the version directly in the OpenSSL include file
+	if test "${have_openssl}" != "yes"; then
+	   AC_MSG_CHECKING([additionally if OpenSSL is available and version >= 1.0.1])
+	   AC_COMPILE_IFELSE(
+		[AC_LANG_PROGRAM(
+			[[
+#include <openssl/opensslv.h>
+			]],
+			[[
+/*	     Version encoding: MNNFFPPS - see opensslv.h for details */
+#if OPENSSL_VERSION_NUMBER < 0x10001000L
+#error OpenSSL too old
+#endif
+			]]
+		)],
+		[AC_MSG_RESULT([ok])],
+		[AC_MSG_ERROR([OpenSSL version too old])]
+	   )
+	   OPENSSL_LIBS=${OPENSSL_LIBS:--lssl -lcrypto}
+	fi
+
 	AC_CHECK_FUNCS([SSL_CTX_new EVP_CIPHER_CTX_set_key_length],
 				   ,
 				   [AC_MSG_ERROR([openssl check failed])]
-- 
2.11.0


