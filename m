From: Josh Cepek <josh.cepek@...1085...>
Date: Wed, 23 Oct 2013 17:10:06 -0500
Message-ID: <l49hfl$a3v$1@...1062...>
References: <kvb1ud$dbt$1@...1062...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090402020607070102010603"
In-Reply-To: <kvb1ud$dbt$1@...1062...>
Subject: [Openvpn-devel] [PATCH v2] depcache support for openvpn-build
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
--------------090402020607070102010603
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The original patch supported the generic/build script only, and used a
single depcache. As noted earlier in this thread, this is incompatible
with build-complete that loops through both the 32 & 64-bit Windows
builds as the cache would have stored only the last-built depcache.

The full v2 patch is attached and allows for uniquely named caches,
which build-complete leverages to store each arch's depcache in a
separate dir. Full description in the attached patch.

To use with build-complete, build the initial depcache..
  `./build-complete `--build-depcache`
..and then pass --use-depcache to build-complete on future runs.

- --
Josh Cepek

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQGcBAEBAgAGBQJSaEk9AAoJENcx2Xpgb9Rj7ioL/idvudtJQuBTMf08nj/Bwzfd
M+mqOS2cck9vXVzqkTZtP3MYCPJA1jmtsUoHx3yadZkZne6BmNy1GoDWqnb9lsrK
JjG5Bmo8NfajgCGrey/BqsCbm0h3zNmzhS/FR4fr5hdmZx4m3reMots1YF564dHB
i/+2TNQxm3ekNjmfY7Nic+UiAKDh8ZTHGUbNBx7VEnxHkupi8khtW5qyQdr4FaCI
Aq2EuXO3lFk9nbwdhKWoMlSeuWOrTLz0/2SF2siZxW0CZLpVtJie7BBZG56anHi3
8/UQlI/pjqGJkZ5zcna0XWONK4p2tw/hwAT5AX+84fqyQhafnP5PjR2zZoMjIctM
8xe9UGLRw4EDnGq9qb5qIFBZW7vUZAn1WeYDyMLmBR9f7Xx4wj/1OUZ48DIU4PCM
8O5MZz9OVW9lD97p/NvnLeZ1XHRFSPeOLKvE03X8LDgBSP5kvmQGEsDhMT3MFc8c
KlM+p+UoKbTGO/9rz0gSgiyXik03OFJCPeQOfV68CQ==
=fsLC
-----END PGP SIGNATURE-----

--------------090402020607070102010603
Content-Type: text/x-diff;
 name="depcache-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="depcache-v2.patch"

From 99e5fdf0cf142d656b3734ef36d728018278474a Mon Sep 17 00:00:00 2001
From: Josh Cepek <josh.cepek@...1085...>
Date: Sat, 24 Aug 2013 11:34:48 -0500
Subject: [PATCH] Support a dep cache for both generic/build and build-complete

This feature takes the openssl, lzo, and pkcs11-helper dependency builds
and creates a "depcache" tarball for each dep making it available for
use in future builds without recompiling them.

build-complete has a high-level feature that can build or use a
depcache with further docs in the updated README.

For the generic depcache support, a named depcache can be passed on the
command-line to save or use the depcache for that run.

Advanced use via env-vars is also supported for environments that wish
to use it via the SAVE_DEP_CACHE, USE_DEP_CACHE, and DEPCACHE_SUFFIX;
note that this applies to the generic/build script only.

Signed-off-by: Josh Cepek <josh.cepek@...1085...>
---
 generic/README              |  10 ++++
 generic/build               | 129 ++++++++++++++++++++++++++++++++++----------
 windows-nsis/README         |  25 +++++++++
 windows-nsis/build-complete |  20 ++++++-
 4 files changed, 156 insertions(+), 28 deletions(-)

diff --git a/generic/README b/generic/README
index 61ae9e9..fa53365 100644
--- a/generic/README
+++ b/generic/README
@@ -77,3 +77,13 @@ Environment
 	PKCS11_HELPER_VERSION
 	LZO_VERSION
 	OPENVPN_VERSION
+
+	(depcache specific env-vars shown below.
+	 Note that CLI-options exist; see `./build --help` for details.)
+
+	USE_DEP_CACHE
+	SAVE_DEP_CACHE
+		define these to a nonzero string to enable (only 1 per run).
+	DEPCACHE_SUFFIX
+		an optional suffix to name the depcache. allows for multiple
+		independent depcache dirs to be used on different runs.
diff --git a/generic/build b/generic/build
index 1358db4..a0a86eb 100755
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
@@ -166,38 +170,82 @@ extract() {
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
@@ -206,7 +254,11 @@ build_dep() {
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
@@ -304,9 +356,20 @@ solaris_common() {
 	OPENSSL_SKIP_DEPEND=1 # sun compiler
 }
 
+# helper to stage any depcache use requested on the command-line
+setup_depcache() {
+	# Cannot both use a depcache and save one:
+	[ -n "${USE_DEP_CACHE}" ] && [ -n "${SAVE_DEP_CACHE}" ] \
+		&& die "You cannot both use and save a depcache in the same run"
+
+	# Define the depcache dir, using the supplied suffix when non-empty:
+	DEPCACHEDIR="${SCRIPTROOT}/depcache${DEPCACHE_SUFFIX:+-$DEPCACHE_SUFFIX}"
+}
+
 main() {
 	export CFLAGS="${TARGET_CFLAGS} ${EXTRA_TARGET_CFLAGS}"
 	export LDFLAGS="${TARGET_LDFLAGS} ${EXTRA_TARGET_LDFLAGS}"
+	setup_depcache
 	download
 	create_layout
 	extract
@@ -446,6 +509,14 @@ while [ -n "$1" ]; do
 		--special-build=*)
 			SPECIAL_BUILD="${v}"
 			;;
+		--use-depcache=*)
+			DEPCACHE_SUFFIX="${v}"
+			USE_DEP_CACHE="defined"
+			;;
+		--save-depcache=*)
+			DEPCACHE_SUFFIX="${v}"
+			SAVE_DEP_CACHE="defined"
+			;;
 		--help|*)
 			cat <<__EOF__
 Usage: $0
@@ -462,6 +533,10 @@ Usage: $0
 		linux-64-force31
 		linux-64-force32
 		linux-64-force64
+
+	--use-depcache=SUFFIX
+	--save-depcache=SUFFIX
+		Use or save a depcache tarball dir with the named suffix.
 __EOF__
 			exit 1
 			;;
diff --git a/windows-nsis/README b/windows-nsis/README
index df67704..2dcaa78 100644
--- a/windows-nsis/README
+++ b/windows-nsis/README
@@ -48,3 +48,28 @@ Usage
             --sign-pkcs12=signingkey.p12\
             --sign-pkcs12-pass=yourpassphrase\
             --sign-timestamp="http://timestamp.domain.com"
+
+Depcache feature
+
+    Much of the build time is spent building dependencies,
+    and a depcache feature can re-use deps once they're
+    initially built. This can dramatically cut down on the
+    time required to run builds when only OpenVPN-components
+    were changed.
+    
+    Note that using a depcache blindly unpacks whatever the
+    resulting build was, including that version and any
+    specific configure options.
+
+    To create the initial depcache, first run:
+
+        ./build-complete --build-depcache
+
+    which will create a Windows-specific depcache for both
+    32 & 64 bit builds. Once the depcache is created, future
+    builds can re-use them like this:
+
+        ./build-complete --use-depcache
+
+    These options take no values and the depcache dirs are
+    stored under the ../generic/ dir.
diff --git a/windows-nsis/build-complete b/windows-nsis/build-complete
index 98e4f5f..7a0bf11 100755
--- a/windows-nsis/build-complete
+++ b/windows-nsis/build-complete
@@ -21,8 +21,13 @@ main() {
 			CHOST=${arch}-w64-mingw32 \
 			../generic/build \
 				--special-build="${SPECIAL_BUILD}" \
+				${WIN_USE_DEPCACHE:+--use-depcache=win-$arch} \
+				${WIN_SAVE_DEPCACHE:+--save-depcache=win-$arch} \
 				|| die "build ${arch}"
 
+		# Loop here if building the depcache:
+		[ -n "${DO_ONLY_DEPS}" ] && continue
+
 		ROOT="${TMPDIR}/installer" \
 			./build \
 			--installer-version="${INSTALLER_VERSION}" \
@@ -39,7 +44,11 @@ main() {
 	done
 
 	echo
-	echo "NOTICE: OpenVPN Installers are at '${OUTPUT_DIR}'"
+	if [ -z "${DO_ONLY_DEPS}" ]; then
+		echo "NOTICE: OpenVPN Installers are at '${OUTPUT_DIR}'"
+	else
+		echo "NOTICE: depcache prepared for future use"
+	fi
 	exit 0
 }
 
@@ -75,6 +84,13 @@ while [ -n "$1" ]; do
 		--output-dir=*)
 			OUTPUT_DIR="${v}"
 			;;
+		--use-depcache)
+			WIN_USE_DEPCACHE=1
+			;;
+		--build-depcache)
+			WIN_SAVE_DEPCACHE=1
+			export DO_ONLY_DEPS=1
+			;;
 		--help|*)
 			cat <<__EOF__
 Usage: $0
@@ -85,6 +101,8 @@ Usage: $0
 	--sign-pkcs12-pass=password	PKCS#12 file password
 	--sign-timestamp=url            URL to be used for timestamp
 	--output-dir=output		output directory
+	--use-depcache			use a pre-existing depcache
+	--build-depcache		create depcache only (no program build)
 	--help				this
 __EOF__
 			exit 1
-- 
1.8.1.2


--------------090402020607070102010603
Content-Type: application/pgp-signature;
 name="depcache-v2.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="depcache-v2.patch.sig"

iQGcBAABAgAGBQJSaEWcAAoJENcx2Xpgb9RjC7ML/0zR8prDi0TkuS3OYkRlNkgwzuXgE73s
UfcNTk/kJrXMUOUtx0iljMxdfZzEh+I7Q24kJmupOQYeW1/HJ5sjCqrDI8FGqcX3PbrDzVb1
1XeHytXRgaU7trI/+hy1qjVLGKIxXOQaQ+V5/LxaKVOgBvt9opcqOpuJiMdQuS/cdZ5T4NPu
7Sr+0b7cQagn09+y8qiGnyaN1z0IZLYqYQvYuGf6huughJVwQDoh5mQmCCpwT8bOOdmX/GpE
1Lqs9X7PIELtFLg98Wn0puWMUD2Gh1mfZPdfjg3guFmPyWaNJlv5nIE4gfjj4xvoEoEtpNT3
zSDArVHIr8sRlb+K1Zqx2wks6UypI9m1tLpggqnwri4t+KBmaTIBSQB47FJkR0UkiK3vvbNa
TqsY6rIv5oZpGVKOi6oM5e6WCMEwe6RFkVRPM6qd4X/1Cq924ws9/a/Fkfl38J/AjylpRXjt
/a578Lp0s8EvcBb/dpk1YOgvHTND8HgOZbFw00p3gGmD6w75eQ==
--------------090402020607070102010603--


