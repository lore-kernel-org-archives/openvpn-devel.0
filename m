From: samuli@...515...
Date: Wed, 23 Jan 2013 12:34:43 +0200
Message-Id: <1358937283-23999-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Updated build variables in openvpn-build to
	match those used in openvpn-2.3.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

From: Samuli Sepp=C3=A4nen <samuli@...515...>

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 generic/build.vars               |   18 +++++++++---------
 windows-nsis/build-complete.vars |    6 +++---
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/generic/build.vars b/generic/build.vars
index df6d2ba..e58697a 100644
--- a/generic/build.vars
+++ b/generic/build.vars
@@ -1,19 +1,19 @@
 # -*- mode: sh; -*-
 BUILD_VERSION=3D"001"
=20
-OPENSSL_VERSION=3D"${OPENSSL_VERSION:-1.0.0e}"
+OPENSSL_VERSION=3D"${OPENSSL_VERSION:-1.0.1c}"
 PKCS11_HELPER_VERSION=3D"${PKCS11_HELPER_VERSION:-1.10}"
 LZO_VERSION=3D"${LZO_VERSION:-2.05}"
-TAP_WINDOWS_VERSION=3D"${TAP_WINDOWS_VERSION:-9.9.0_master}"
-OPENVPN_VERSION=3D"${OPENVPN_VERSION:-2.3_master}"
-OPENVPN_GUI_VERSION=3D"${OPENVPN_GUI_VERSION:-1.0.3}"
+TAP_WINDOWS_VERSION=3D"${TAP_WINDOWS_VERSION:-9.9.2}"
+OPENVPN_VERSION=3D"${OPENVPN_VERSION:-2.3.0}"
+OPENVPN_GUI_VERSION=3D"${OPENVPN_GUI_VERSION:-2}"
=20
 OPENSSL_URL=3D"${OPENSSL_URL:-http://www.openssl.org/source/openssl-${OPEN=
SSL_VERSION}.tar.gz}"
-PKCS11_HELPER_URL=3D"${PKCS11_HELPER_URL:-https://github.com/downloads/alo=
nbl/pkcs11-helper/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2}"
-TAP_WINDOWS_URL=3D"${TAP_WINDOWS_URL:-https://github.com/downloads/OpenVPN=
/tap-windows/tap-windows-${TAP_WINDOWS_VERSION}.zip}"
+PKCS11_HELPER_URL=3D"${PKCS11_HELPER_URL:-http://sourceforge.net/projects/=
opensc/files/pkcs11-helper/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2}"
+TAP_WINDOWS_URL=3D"${TAP_WINDOWS_URL:-http://build.openvpn.net/downloads/r=
eleases/tap-windows-${TAP_WINDOWS_VERSION}.zip}"
 LZO_URL=3D"${LZO_URL:-http://www.oberhumer.com/opensource/lzo/download/lzo=
-${LZO_VERSION}.tar.gz}"
-OPENVPN_URL=3D"${OPENVPN_URL:-https://github.com/downloads/OpenVPN/openvpn=
/openvpn-${OPENVPN_VERSION}.tar.gz}"
-OPENVPN_GUI_URL=3D"${OPENVPN_GUI_URL:-https://github.com/downloads/alonbl/=
openvpn-gui/openvpn-gui-${OPENVPN_GUI_VERSION}.tar.gz}"
+OPENVPN_URL=3D"${OPENVPN_URL:-http://build.openvpn.net/downloads/releases/=
openvpn-${OPENVPN_VERSION}.tar.gz}"
+OPENVPN_GUI_URL=3D"${OPENVPN_GUI_URL:-http://build.openvpn.net/downloads/r=
eleases/openvpn-gui-${OPENVPN_GUI_VERSION}.tar.gz}"
=20
 #CHOST
 #CTARGET
@@ -39,6 +39,6 @@ fi
 #EXTRA_OPENSSL_CONFIG
 #EXTRA_LZO_CONFIG
 #EXTRA_PKCS11_HELPER_CONFIG
-#EXTRA_OPENVPN_CONFIG
+EXTRA_OPENVPN_CONFIG=3D"--enable-password-save --disable-debug"
=20
 TARGET_ROOT=3D"${TARGET_ROOT:-/}"
diff --git a/windows-nsis/build-complete.vars b/windows-nsis/build-complete=
.vars
index 37a3a84..81d74ae 100644
--- a/windows-nsis/build-complete.vars
+++ b/windows-nsis/build-complete.vars
@@ -1,11 +1,11 @@
 # -*- mode: sh; -*-
 INSTALLER_VERSION=3D"000_master"
=20
-EASY_RSA_VERSION=3D"${EASY_RSA_VERSION:-2.1.0_master}"
-TAP_WINDOWS_INSTALLER_VERSION=3D"${TAP_WINDOWS_INSTALLER_VERSION:-9.9.0_ma=
ster}"
+EASY_RSA_VERSION=3D"${EASY_RSA_VERSION:-2.2.0_master}"
+TAP_WINDOWS_VERSION=3D"${TAP_WINDOWS_VERSION:-9.9.2}"
=20
 EASY_RSA_URL=3D"${EASY_RSA_URL:-https://github.com/downloads/OpenVPN/easy-=
rsa/easy-rsa-${EASY_RSA_VERSION}.tar.gz}"
-TAP_WINDOWS_INSTALLER_URL=3D"${TAP_WINDOWS_INSTALLER_URL:-https://github.c=
om/downloads/OpenVPN/tap-windows/tap-windows-${TAP_WINDOWS_INSTALLER_VERSIO=
N}.exe}"
+TAP_WINDOWS_INSTALLER_URL=3D"${TAP_WINDOWS_INSTALLER_URL:-http://build.ope=
nvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.exe}"
=20
 WGET=3D"${WGET:-wget}"
=20
--=20
1.7.10.4


