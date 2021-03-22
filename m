From: Gert Doering <gert@...1296...>
Date: Mon, 22 Mar 2021 09:43:31 +0100
Message-Id: <20210322084331.94770-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add LZ4 prerequisite building.
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

commit 24596b258aa3a removed the bundled compat-lz4 from OpenVPN, thus
breaking windows/nsis builds with default config ("--enable-lz4").

Add download URLs and build invocation.  Since LZ4 has no "configure"
script, we pass the appropriate CC=/LD=/WINDRES= statement to "make".

Only static library is installed, since static linking is easier here
than to extend NSIS to bundle lz4.dll (+ whatever else is needed).

Tested with and without depcache.

32 and 64 bit binaries have been built, though only 64 bit binary was
tested (on Win10).

Signed-off-by: Gert Doering <gert@...1296...>
---
 generic/build      | 33 ++++++++++++++++++++++++++++++++-
 generic/build.vars |  2 ++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/generic/build b/generic/build
index cf2c7c6..fb12d62 100755
--- a/generic/build
+++ b/generic/build
@@ -61,6 +61,10 @@ download1() {
 	local url="$1"
 	local prefix="$(basename "${url}" | sed 's/-[0-9].*//g')"
 
+	# LZ4 download is just "v1.9.3.tar.gz", so check for exact file exist
+	if [ -f "${SOURCESROOT}/${prefix}" ] ; then
+		return
+	fi
 	if ! [ -n "$(ls "${SOURCESROOT}/${prefix}-"[0-9]* 2> /dev/null)" ]; then
 		geturl ${url} || die "Cannot download ${url}"
 	fi
@@ -69,6 +73,7 @@ download1() {
 download() {
 	for url in \
 		${LZO_URL} \
+		${LZ4_URL} \
 		${OPENSSL_URL} \
 		${PKCS11_HELPER_URL} \
 		${TAP_WINDOWS_URL} \
@@ -78,7 +83,7 @@ download() {
 		download1 "${url}"
 	done
 
-	if [ "$(ls "${SOURCESROOT}" | wc -l | sed 's/[ \t]//g')" != 6 ]; then
+	if [ "$(ls "${SOURCESROOT}" | wc -l | sed 's/[ \t]//g')" != 7 ]; then
 		die "sources is unclean."
 	fi
 }
@@ -226,6 +231,30 @@ build_dep() {
 		[ -n "${SAVE_DEP_CACHE}" ] && depcache_save lzo
 	fi
 
+	if [ -n "${USE_DEP_CACHE}" ]; then
+		depcache_extract lz4
+	else
+		echo "Build lz4"
+		cd "${BUILDROOT}/lz4"* || die "cd lz4"
+		echo ./configure ${CONFIGOPTS} ${EXTRA_LZ4_CONFIG} \
+			$(empty_ifelse "${DO_STATIC}" --enable-shared --disable-shared) \
+			|| die "Configure lz4"
+		# lz4 does not have a configure, so pass CC/LD instead
+		# ... and we only want the static library
+		${MAKE} ${MAKEOPTS} CC=${CHOST}-gcc LD=${CHOST}-gcc \
+			WINDRES=${CHOST}-windres TARGET_OS=MINGW32 \
+			BUILD_STATIC=yes BUILD_SHARED=no \
+			PREFIX=/ DESTDIR="${INSTALL_ROOT}" V=1 \
+			|| die "make lz4"
+		${MAKE} ${MAKEOPTS} CC=${CHOST}-gcc LD=${CHOST}-gcc \
+			WINDRES=${CHOST}-windres TARGET_OS=MINGW32 \
+			BUILD_STATIC=yes BUILD_SHARED=no \
+			PREFIX=/ DESTDIR="${INSTALL_ROOT}" V=1 install \
+			|| die "make lz4"
+
+		[ -n "${SAVE_DEP_CACHE}" ] && depcache_save lz4
+	fi
+
 	if [ -z "${DO_STATIC}" ]; then
 	  if [ -n "${USE_DEP_CACHE}" ]; then
 		depcache_extract pkcs11-helper
@@ -387,6 +416,8 @@ export OPENSSL_CFLAGS="-I${OPENVPN_ROOT}/include"
 export OPENSSL_LIBS="-L${OPENVPN_ROOT}/lib -lssl -lcrypto"
 export LZO_CFLAGS="-I${OPENVPN_ROOT}/include"
 export LZO_LIBS="-L${OPENVPN_ROOT}/lib -llzo2"
+export LZ4_CFLAGS="-I${OPENVPN_ROOT}/include"
+export LZ4_LIBS="-L${OPENVPN_ROOT}/lib -llz4"
 export PKCS11_HELPER_CFLAGS="-I${OPENVPN_ROOT}/include"
 export PKCS11_HELPER_LIBS="-L${OPENVPN_ROOT}/lib -lpkcs11-helper"
 export TAP_CFLAGS="-I${OPENVPN_ROOT}/include"
diff --git a/generic/build.vars b/generic/build.vars
index 28f2075..e10b3b4 100644
--- a/generic/build.vars
+++ b/generic/build.vars
@@ -4,6 +4,7 @@ BUILD_VERSION="001"
 OPENSSL_VERSION="${OPENSSL_VERSION:-1.1.1f}"
 PKCS11_HELPER_VERSION="${PKCS11_HELPER_VERSION:-1.22}"
 LZO_VERSION="${LZO_VERSION:-2.10}"
+LZ4_VERSION="${LZ4_VERSION:-1.9.3}"
 TAP_WINDOWS_VERSION="${TAP_WINDOWS_VERSION:-9.24.2}"
 OPENVPN_VERSION="${OPENVPN_VERSION:-2.4.9}"
 OPENVPN_GUI_VERSION="${OPENVPN_GUI_VERSION:-11}"
@@ -12,6 +13,7 @@ OPENSSL_URL="${OPENSSL_URL:-https://www.openssl.org/source/openssl-${OPENSSL_VER
 PKCS11_HELPER_URL="${PKCS11_HELPER_URL:-https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${PKCS11_HELPER_VERSION}/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2}"
 TAP_WINDOWS_URL="${TAP_WINDOWS_URL:-http://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip}"
 LZO_URL="${LZO_URL:-http://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz}"
+LZ4_URL="${LZ4_URL:-https://github.com/lz4/lz4/archive/refs/tags/v${LZ4_VERSION}.tar.gz}"
 OPENVPN_URL="${OPENVPN_URL:-http://build.openvpn.net/downloads/snapshots/openvpn-${OPENVPN_VERSION}.tar.gz}"
 OPENVPN_GUI_URL="${OPENVPN_GUI_URL:-http://build.openvpn.net/downloads/releases/openvpn-gui-${OPENVPN_GUI_VERSION}.tar.gz}"
 
-- 
2.17.1


