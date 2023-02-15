From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 15 Feb 2023 16:04:55 +0100
Message-Id: <20230215150455.45052-1-frank@...2641...>
In-Reply-To: <20230207132026.41580-1-frank@...2641...>
References: <20230207132026.41580-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] configure: enable DCO by default on
 FreeBSD/Linux
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

Automatically disabled when
- iproute2 is enabled
- libnl-genl is missing on Linux
- libnv is missing on FreeBSD

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .github/workflows/build.yaml | 13 ++----
 configure.ac                 | 79 ++++++++++++++++++++++++++++--------
 2 files changed, 66 insertions(+), 26 deletions(-)

v2: error out when libnl-genl is missing as discussed with ordex on
    IRC.
v3:
 - improvements to the messages, suggested by Selva
 - further improvements to the default specification, trying to make it clear
 - if enabling iproute2, do not test for libnl-genl
v4: add updates for GHA

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 699964fd..3265725f 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -275,10 +275,12 @@ jobs:
             sslpkg: "libssl1.0-dev"
             ssllib: openssl
             libname: OpenSSL 1.0.2
+            extraconf: "--disable-dco"
           - os: ubuntu-18.04
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
             ssllib: openssl
+            extraconf: "--disable-dco"
           - os: ubuntu-20.04
             sslpkg: "libssl-dev"
             libname: OpenSSL 1.1.1
@@ -312,22 +314,15 @@ jobs:
             libname: OpenSSL 1.1.1
             ssllib: openssl
             extraconf: "--disable-lzo --disable-lz4"
-          - os: ubuntu-20.04
-            sslpkg: "libssl-dev"
-            libname: OpenSSL 1.1.1
-            ssllib: openssl
-            extraconf: "--enable-dco"
-            nlpkg: "libnl-genl-3-dev"
 
     name: "gcc - ${{matrix.os}} - ${{matrix.libname}} ${{matrix.extraconf}}"
     env:
       SSLPKG: "${{matrix.sslpkg}}"
-      NLPKG: "${{matrix.nlpkg}}"
 
     runs-on: ${{matrix.os}}
     steps:
       - name: Install dependencies
-        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${NLPKG}
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG}
       - name: Checkout OpenVPN
         uses: actions/checkout@...2689...
       - name: autoconf
@@ -354,7 +349,7 @@ jobs:
     runs-on: ${{matrix.os}}
     steps:
       - name: Install dependencies
-        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
       - name: Checkout OpenVPN
         uses: actions/checkout@...2689...
       - name: autoconf
diff --git a/configure.ac b/configure.ac
index 66ba6f38..5a9a55d9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -157,14 +157,27 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[dco],
-	[AS_HELP_STRING([--enable-dco], [enable data channel offload support using the ovpn-dco kernel module (always enabled on Windows) @<:@default=no@:>@])],
+	[AS_HELP_STRING([--disable-dco], [enable data channel offload support using the ovpn-dco kernel module (always enabled on Windows) @<:@default=yes@:>@])],
 	,
-	[enable_dco="no"]
+	[
+		case "$host" in
+			*-*-linux*)
+				enable_dco="auto"
+			;;
+			*-*-freebsd*)
+				enable_dco="auto"
+			;;
+			*)
+				# note that this does not disable it for Windows
+				enable_dco="no"
+			;;
+		esac
+	]
 )
 
 AC_ARG_ENABLE(
 	[iproute2],
-	[AS_HELP_STRING([--enable-iproute2], [enable support for iproute2 @<:@default=no@:>@])],
+	[AS_HELP_STRING([--enable-iproute2], [enable support for iproute2 (disables DCO) @<:@default=no@:>@])],
 	,
 	[enable_iproute2="no"]
 )
@@ -549,7 +562,7 @@ AC_CHECK_DECLS(
 	,
 	[[${SOCKET_INCLUDES}]]
 )
-AC_CHECKING([anonymous union support])
+AC_MSG_CHECKING([anonymous union support])
 AC_COMPILE_IFELSE(
 	[AC_LANG_PROGRAM(
 		[[
@@ -784,28 +797,60 @@ PKG_CHECK_MODULES(
 )
 
 
-if test "$enable_dco" = "yes"; then
+if test "$enable_dco" != "no"; then
+	enable_dco_arg="$enable_dco"
+	if test "${enable_iproute2}" = "yes"; then
+		AC_MSG_WARN([iproute2 support cannot be enabled when using DCO])
+		enable_dco="no"
+	fi
+	case "$host" in
+		*-*-linux*)
 dnl
 dnl Include generic netlink library used to talk to ovpn-dco
 dnl
-	case "$host" in
-		*-*-linux*)
 			PKG_CHECK_MODULES([LIBNL_GENL],
 					  [libnl-genl-3.0 >= 3.4.0],
 					  [have_libnl="yes"],
-					  [AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config installed? Must be version 3.4.0 or newer])]
+					  [
+					   AC_MSG_WARN([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config installed? Must be version 3.4.0 or newer for DCO])
+					   enable_dco="no"
+					  ]
 			)
-
-			CFLAGS="${CFLAGS} ${LIBNL_GENL_CFLAGS}"
-			LIBS="${LIBS} ${LIBNL_GENL_LIBS}"
-
-			AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
-			AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
+			if test "$enable_dco" = "no"; then
+				if test "$enable_dco_arg" = "auto"; then
+					AC_MSG_WARN([DCO support disabled])
+				else
+					AC_MSG_ERROR([DCO support can't be enabled])
+				fi
+			else
+				CFLAGS="${CFLAGS} ${LIBNL_GENL_CFLAGS}"
+				LIBS="${LIBS} ${LIBNL_GENL_LIBS}"
+
+				AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
+				AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
+			fi
 			;;
 		*-*-freebsd*)
-			LIBS="${LIBS} -lnv"
-			AC_DEFINE(ENABLE_DCO, 1, [Enable data channel offload for FreeBSD])
-			AC_MSG_NOTICE([Enabled ovpn-dco support for FreeBSD])
+			AC_CHECK_LIB(
+				[nv],
+				[nvlist_create],
+				[
+				 LIBS="${LIBS} -lnv"
+				 AC_DEFINE(ENABLE_DCO, 1, [Enable data channel offload for FreeBSD])
+				 AC_MSG_NOTICE([Enabled ovpn-dco support for FreeBSD])
+				],
+				[
+				 enable_dco="no"
+				 AC_MSG_WARN([Name/Value pair library not found.])
+				]
+			)
+			if test "$enable_dco" = "no"; then
+				if test "$enable_dco_arg" = "auto"; then
+					AC_MSG_WARN([DCO support disabled])
+				else
+					AC_MSG_ERROR([DCO support can't be enabled])
+				fi
+			fi
 			;;
 		*-mingw*)
 			AC_MSG_NOTICE([NOTE: --enable-dco ignored on Windows because it's always enabled])
-- 
2.34.1


