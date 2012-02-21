From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 21 Feb 2012 03:22:27 +0200
Message-Id: <1329787361-26096-22-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 21/35] build: autoconf: remove
	OPENVPN_ADD_LIBS useless macro
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


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac         |   26 ++++++++++----------------
 m4/ax_openvpn_lib.m4 |    4 ----
 2 files changed, 10 insertions(+), 20 deletions(-)
 delete mode 100644 m4/ax_openvpn_lib.m4

diff --git a/configure.ac b/configure.ac
index 3dcc23c..2dae0f3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -339,13 +339,7 @@ case "$host" in
 		AC_DEFINE([TARGET_WIN32], [1], [Are we running WIN32?])
 		CPPFLAGS="${CPPFLAGS} -DWIN32_LEAN_AND_MEAN -D_POSIX -DWINVER=0x0501"
 		WIN32=yes
-		OPENVPN_ADD_LIBS(-lgdi32)
-		OPENVPN_ADD_LIBS(-lws2_32)
-		OPENVPN_ADD_LIBS(-lwininet)
-		OPENVPN_ADD_LIBS(-lcrypt32)
-		OPENVPN_ADD_LIBS(-liphlpapi)
-		OPENVPN_ADD_LIBS(-lwinmm)
-		OPENVPN_ADD_LIBS(-lshell32)
+		LIBS="${LIBS} -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lshell32"
 		;;
 	*-*-dragonfly*)
 		AC_DEFINE([TARGET_DRAGONFLY], [1], [Are we running on DragonFlyBSD?])
@@ -626,7 +620,7 @@ case "${with_mem_check}" in
 				[dmalloc],
 				[malloc],
 				[
-					OPENVPN_ADD_LIBS(-ldmalloc)
+					LIBS="${LIBS} -ldmalloc"
 					AC_DEFINE(
 						[DMALLOC],
 						[1],
@@ -668,7 +662,7 @@ if test "${WIN32}" != "yes" -a "${enable_plugins}" = "yes"; then
 				[dl],
 				[dlopen],
 				[
-					OPENVPN_ADD_LIBS(-ldl)
+					LIBS="${LIBS} -ldl"
 					AC_DEFINE(USE_LIBDL, 1, [Use libdl for dynamic library loading])
 				],
 				[AC_MSG_RESULT([libdl library not found.])]
@@ -707,7 +701,7 @@ if test "${enable_lzo}" = "yes" && test "${enable_lzo_stub}" = "no"; then
 	if test $havelzolib = 1 ; then break ; fi
 	AC_CHECK_LIB($i, lzo1x_1_15_compress,
           [
-	    OPENVPN_ADD_LIBS(-l$i)
+	    LIBS="${LIBS} -l$i"
 	    AC_DEFINE(USE_LZO, 1, [Use LZO compression library])
 	    AC_DEFINE_UNQUOTED(LZO_VERSION_NUM, "$LZO_H", [LZO version number])
 	    havelzolib=1
@@ -738,7 +732,7 @@ if test "${enable_pkcs11}" = "yes"; then
 	[AC_CHECK_LIB(pkcs11-helper, pkcs11h_initialize,
 	    [
 		   AC_DEFINE(USE_PKCS11, 1, [Enable PKCS11 capability])
-		   OPENVPN_ADD_LIBS(-lpkcs11-helper)
+		   LIBS="${LIBS} -lpkcs11-helper"
 	    ],
 	    [AC_MSG_RESULT([pkcs11-helper library not found.])]
 	)],
@@ -759,7 +753,7 @@ if test "${enable_crypto}" = "yes"; then
           AC_CHECK_LIB($lib, EVP_CIPHER_CTX_init,
                 [
             		cryptofound=1
-            		OPENVPN_ADD_LIBS(-l$lib)
+			LIBS="${LIBS} -l$lib"
     	        ]
           )
        done
@@ -793,7 +787,7 @@ if test "${enable_crypto}" = "yes"; then
         AC_CHECK_HEADER(polarssl/aes.h,
             [AC_CHECK_LIB(polarssl, aes_crypt_cbc,
                 [
-                    OPENVPN_ADD_LIBS(-lpolarssl)
+		    LIBS="${LIBS} -lpolarssl"
                     AC_DEFINE(USE_CRYPTO, 1, [Use crypto library])
                     AC_DEFINE(USE_POLARSSL, 1, [Use PolarSSL library])
                 ],
@@ -817,7 +811,7 @@ if test "${enable_crypto}" = "yes"; then
 	     AC_CHECK_LIB($lib, SSL_CTX_new,
 		   [
 			   sslfound=1
-			   OPENVPN_ADD_LIBS(-l$lib)
+			   LIBS="${LIBS} -l$lib"
 		   ]
 	     )
          done
@@ -831,7 +825,7 @@ if test "${enable_crypto}" = "yes"; then
          AC_CHECK_HEADER(polarssl/ssl.h,
               [AC_CHECK_LIB(polarssl, ssl_init,
               [
-                  OPENVPN_ADD_LIBS(-lpolarssl)
+		  LIBS="${LIBS} -lpolarssl"
                   AC_DEFINE(USE_SSL, 1, [Use SSL library])
                   AC_DEFINE(USE_POLARSSL, 1, [Use PolarSSL library])
               ],
@@ -853,7 +847,7 @@ if test "${enable_selinux}" = "yes"; then
 			[selinux],
 			[setcon],
 			[
-				OPENVPN_ADD_LIBS(-lselinux)
+				LIBS="${LIBS} -lselinux"
 				AC_DEFINE(HAVE_SETCON, 1, [SELinux support])
 			],
 			[AC_MSG_RESULT([SELinux library not found.])]
diff --git a/m4/ax_openvpn_lib.m4 b/m4/ax_openvpn_lib.m4
deleted file mode 100644
index bcfe1ab..0000000
--- a/m4/ax_openvpn_lib.m4
+++ /dev/null
@@ -1,4 +0,0 @@
-dnl OPENVPN_ADD_LIBS(LIB)
-AC_DEFUN([OPENVPN_ADD_LIBS], [
-  LIBS="$1 $LIBS"
-])
-- 
1.7.3.4


