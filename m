From: Josh Cepek <josh.cepek@...1085...>
Date: Sat, 24 Aug 2013 14:34:34 -0500
Message-ID: <kvb1ud$dbt$1@...1062...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020500000006000605080208"
Subject: [Openvpn-devel] [PATCH] openvpn-build dep cache support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020500000006000605080208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The attached patch allows the openvpn-build system to create and use
cache tarballs for dependencies, preventing them from being built every
time (even when they haven't changed.) My VM build time went from ~12 to
under 2 minutes with this feature.


- --
Josh Cepek
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQGcBAEBAgAGBQJSGQrIAAoJENcx2Xpgb9RjHOEL/jRDeXyguibzmFYP+n+oduA3
ICjpGrUwhnzTtwp/8i01vfo2YVVwgi1eC8qJmcCs4SOJXkq1ExB5KSPuwRrB0s3E
w9Fv6yYcvXbNWKbhJtvqgLFxgHPYzYZ1TJLOGO9H37V4viTYxaqdQsb2e1ZFL53S
fvWXqQThWRwzxRzAQGcCmtt2CyFNJRoI4+Tp3UWezyZxMQlJLqNNb7A7dIiZLXSh
pg8USPoW5knBG0JomwjUKFPGV19OamBwgAA4s60RstK6v0JP+EnaqPh/KpCGMPeZ
Hvz63wdtZoCLQRDD0tY/iYhlJESKf1PMDQwBKGZmM+K9gQCc2tUYONwy8PJeKzUY
saMKsF8me2hEhORzV40i0DdIrLeKscJoP1smJsBS2NYeqkBUcTohTXefo9upei3u
MuOkGK6NwMZPki+VT2O/NVMOwcgMzOuJeRPCsBFSs5zD1ZDzG31bou2YvD7QgBy4
Egw9M/Y+1xWoXtzLoOalfeKUpV0g+ki8wsvhCL6s3A==
=ckGN
-----END PGP SIGNATURE-----

--------------020500000006000605080208
Content-Type: text/x-diff;
 name="dep-cache-build.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dep-cache-build.patch"

From 70aae9ead2c016da95977a744b0a246f7ee2f40e Mon Sep 17 00:00:00 2001
From: Josh Cepek <josh.cepek@...1085...>
Date: Sat, 24 Aug 2013 11:34:48 -0500
Subject: [PATCH] Support a dep cache when using the generic/build script

This feature takes the openssl, lzo, and pkcs11-helper dependency builds
and creates a "depcache" tarball for each dep.

To generate the depcache, set SAVE_DEP_CACHE to a non-empty string.  To
use the depcache, set USE_DEP_CACHE the same way instead. Without
either, the current build-all-deps behavior is maintained.

Signed-off-by: Josh Cepek <josh.cepek@...1085...>
---
 generic/build | 111 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 84 insertions(+), 27 deletions(-)

diff --git a/generic/build b/generic/build
index 4bc6bb1..cf55cbf 100755
--- a/generic/build
+++ b/generic/build
@@ -115,6 +115,10 @@ create_layout() {
 	fi
 	mkdir -p "${IMAGEROOT}" || die "Cannot create '${IMAGEROOT}'"
 	mkdir -p "${BUILDROOT}" || die "Cannot create '${BUILDROOT}'"
+	mkdir -p "${OPENVPN_ROOT}" || die "Cannot create '${OPENVPN_ROOT}'"
+	if [ -n "${USE_DEP_CACHE}${SAVE_DEP_CACHE}" ]; then
+		mkdir -p "${DEPCACHEDIR}" || die "Cannot create '${DEPCACHEDIR}'"
+	fi
 
 	BUILDROOT="$(get_full_path "${BUILDROOT}")"
 	SOURCESROOT="$(get_full_path "${SOURCESROOT}")"
@@ -165,38 +169,82 @@ extract() {
 	done
 }
 
+# Takes a short product name (eg: 'openssl') and extracts the depcache.
+depcache_extract() {
+	local src="${DEPCACHEDIR}/${1}.tar.gz" 
+	[ -f "${src}" ] \
+		|| die "Depcache for '${1}' not found at: '${src}'"
+	tar -xzf "${src}" -C "${OPENVPN_ROOT}" \
+		|| die "Cannot extract depcache '${1}'"
+	[ -z "${2}" ] && echo "Using a depcache tarball for '${1}"
+}
+
+# Takes a short product name (eg: 'openssl') and creates a depcache tarball.
+depcache_save() {
+	local dst="${DEPCACHEDIR}/${1}.tar.gz"
+	(cd "${INSTALL_ROOT}" && tar -czf "${dst}" .) \
+		|| die "Cannot save depcache for '${1}' to: '${dst}'"
+	rm -fr "${INSTALL_ROOT}" \
+		|| die "Cleanup failed for: '${INSTALL_ROOT}'"
+	depcache_extract "${1}" noecho
+}
+
 build_dep() {
-	echo "Build openssl"
-	cd "${BUILDROOT}/openssl"* || die "cd openssl"
-
-	./Configure --prefix="/${TARGET_ROOT}" --cross-compile-prefix=${CHOST:+${CHOST}-} \
-		$(empty_ifelse "${DO_STATIC}" shared no-dso) \
-		$(CHOST="${VIRTUAL_CHOST}" "${SCRIPTROOT}/gentoo.config-0.9.8") \
-		${CFLAGS} ${LDFLAGS} \
-		no-multilib \
-		no-capieng \
-		--openssldir=/etc/ssl \
-		--libdir=/lib \
-		${EXTRA_OPENSSL_CONFIG} \
-		|| die "Configure openssl"
-	[ -n "${BUILD_FOR_WINDOWS}" ] && perl util/mkdef.pl crypto ssl NT update
-	[ -z "${OPENSSL_SKIP_DEPEND}" ] && ${MAKE} depend
-	${MAKE} install INSTALL_PREFIX="${OPENVPN_ROOT}" INSTALLTOP="/" MANDIR="/tmp" \
-		|| die "make openssl"
-	rm -fr "${OPENVPN_ROOT}/tmp"
+	if [ -z "${SAVE_DEP_CACHE}" ]; then
+		INSTALL_ROOT="${OPENVPN_ROOT}"
+	else
+		INSTALL_ROOT="${DEPCACHEDIR}/fakeroot"
+		mkdir -p "${INSTALL_ROOT}" \
+			|| die "Cannot create depcache install root at: ${INSTALL_ROOT}'"
+	fi
 
-	fixup_la
+	if [ -n "${USE_DEP_CACHE}" ]; then
+		depcache_extract openssl
+	else
+		echo "Build openssl"
+		cd "${BUILDROOT}/openssl"* || die "cd openssl"
+
+		./Configure --prefix="/${TARGET_ROOT}" --cross-compile-prefix=${CHOST:+${CHOST}-} \
+			$(empty_ifelse "${DO_STATIC}" shared no-dso) \
+			$(CHOST="${VIRTUAL_CHOST}" "${SCRIPTROOT}/gentoo.config-0.9.8") \
+			${CFLAGS} ${LDFLAGS} \
+			no-multilib \
+			no-capieng \
+			--openssldir=/etc/ssl \
+			--libdir=/lib \
+			${EXTRA_OPENSSL_CONFIG} \
+			|| die "Configure openssl"
+		[ -n "${BUILD_FOR_WINDOWS}" ] && perl util/mkdef.pl crypto ssl NT update
+		[ -z "${OPENSSL_SKIP_DEPEND}" ] && ${MAKE} depend
+		${MAKE} install INSTALL_PREFIX="${INSTALL_ROOT}" INSTALLTOP="/" MANDIR="/tmp" \
+			|| die "make openssl"
+		rm -fr "${INSTALL_ROOT}/tmp"
+		fixup_la
+
+		[ -n "${SAVE_DEP_CACHE}" ] && depcache_save openssl
+	fi
 
-	echo "Build lzo"
-	cd "${BUILDROOT}/lzo"* || die "cd lzo"
-	./configure ${CONFIGOPTS} ${EXTRA_LZO_CONFIG} \
-		$(empty_ifelse "${DO_STATIC}" --enable-shared --disable-shared) \
-		|| die "Configure lzo"
-	${MAKE} ${MAKEOPTS} ${MAKE_AUTOCONF_INSTALL_TARGET} DESTDIR="${OPENVPN_ROOT}" || die "make lzo"
 
-	fixup_la
+	if [ -n "${USE_DEP_CACHE}" ]; then
+		depcache_extract lzo
+	else
+		echo "Build lzo"
+		cd "${BUILDROOT}/lzo"* || die "cd lzo"
+		./configure ${CONFIGOPTS} ${EXTRA_LZO_CONFIG} \
+			$(empty_ifelse "${DO_STATIC}" --enable-shared --disable-shared) \
+			|| die "Configure lzo"
+		${MAKE} ${MAKEOPTS} ${MAKE_AUTOCONF_INSTALL_TARGET} DESTDIR="${INSTALL_ROOT}" \
+			|| die "make lzo"
+
+		fixup_la
+
+		[ -n "${SAVE_DEP_CACHE}" ] && depcache_save lzo
+	fi
 
 	if [ -z "${DO_STATIC}" ]; then
+	  if [ -n "${USE_DEP_CACHE}" ]; then
+		depcache_extract pkcs11-helper
+	  else
 		echo "Build pkcs11-helper"
 		cd "${BUILDROOT}/pkcs11-helper"* || die "cd pkcs11-helper"
 		./configure ${CONFIGOPTS} ${EXTRA_PKCS11_HELPER_CONFIG} \
@@ -205,7 +253,11 @@ build_dep() {
 			OPENSSL_CFLAGS="${OPENSSL_CRYPTO_CFLAGS}" \
 			OPENSSL_LIBS="${OPENSSL_CRYPTO_LIBS}" \
 			|| die "Configure pkcs11-helper"
-		${MAKE} ${MAKEOPTS} ${MAKE_AUTOCONF_INSTALL_TARGET} DESTDIR="${OPENVPN_ROOT}" || die "make pkcs11-helper"
+		${MAKE} ${MAKEOPTS} ${MAKE_AUTOCONF_INSTALL_TARGET} DESTDIR="${INSTALL_ROOT}" \
+			|| die "make pkcs11-helper"
+
+		[ -n "${SAVE_DEP_CACHE}" ] && depcache_save pkcs11-helper
+	  fi
 	fi
 
 	echo "tap-windows"
@@ -332,6 +384,11 @@ IMAGEROOT="${IMAGEROOT:-${SCRIPTROOT}/image}"
 BUILDROOT="${BUILDROOT:-${SCRIPTROOT}/tmp}"
 SOURCESROOT="${SOURCESROOT:-${SCRIPTROOT}/sources}"
 PATCHDIR="${SCRIPTROOT}/patches"
+DEPCACHEDIR="${SCRIPTROOT}/depcache"
+
+# Cannot both use a depcache and save one:
+[ -n "${USE_DEP_CACHE}" ] && [ -n "${SAVE_DEP_CACHE}" ] \
+	&& die "You cannot both use and save a depcache in the same run"
 
 . "${SCRIPTROOT}/build.vars" || die "Cannot source build.vars"
 
-- 
1.8.1.2


--------------020500000006000605080208
Content-Type: application/pgp-signature;
 name="dep-cache-build.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dep-cache-build.patch.sig"

iQGcBAABAgAGBQJSGQrJAAoJENcx2Xpgb9RjlCAL/2g6HM4OWm/+x0or9TD1y6A3tXWKfkr2
8PQbVDK0xyE6TpgnipN5ATc7EWRmo9st365uml6Zh/JOCUxykb0z33ktzoFgQXtXJKMwGXzm
mfzBn4IQLd0784cdbLN0tG60jUoc17+aYn/B9P/3BgWofwVG1hnV1Cxe3boCYaMaN9TBozjz
OnJJPUgKvcvDJLDSRfvfW2iinWl0uPRHityiEpTYGwQ0ka1i2g+tqBPoWoFa+VF09rJsDIts
91ZGb6sLaEhTX17EJe/7DpD4eqab3BTqZR2CaSOonKuQXSGB58tCQiyGmzAteuQft1ClfWRc
7yxcZdhLMb4qRMEYprQyiXBZtzNlSDFV0jsCALfpZnBpcRyEldBNkLCDjyzGPJSU9uKNDPfk
s1aDqs+63i1rqdHm2IPwIqS7vwIfSBf3GgQ3DDKQmJHEXkFADaVIoiwkBk2xBPuS6Mwu/dV+
ScSv7xnyHhBon+iI5ARqQJiU6Z5l3hpLtGdbNN6ccrb46/i1AA==
--------------020500000006000605080208--


