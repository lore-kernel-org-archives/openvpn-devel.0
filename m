From: samuli@...515...
Date: Fri, 25 Jan 2013 10:12:19 +0200
Message-Id: <1359101540-976-4-git-send-email-samuli@...515...>
In-Reply-To: <1359101540-976-1-git-send-email-samuli@...515...>
References: <1359101540-976-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/4] Updated README
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

Added links to easy-rsa, tap-windows and openvpn-build and fixes some paths

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 README |   35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/README b/README
index 2c5e6f6..3451fb9 100644
--- a/README
+++ b/README
@@ -40,36 +40,33 @@ Other Files & Directories:
 * configure.ac -- script to rebuild our configure
   script and makefile.
=20
-* openvpn.spec -- RPM Spec file
-  To build an OpenVPN binary RPM, use the command:
-
-	rpmbuild -tb [tarball]
-
-  When you install the binary RPM, it will automatically
-  install sample-scripts/openvpn.init (see below)
-
-* sample-scripts/openvpn.init
-
-  A sample init script for OpenVPN.  See the file for
-  comments and additional information.
-
-* sample-scripts/verify-cn
+* sample/sample-scripts/verify-cn
=20
   A sample perl script which can be used with OpenVPN's
   --tls-verify option to provide a customized authentication
   test on embedded X509 certificate fields.
=20
-* sample-keys/
+* sample/sample-keys/
=20
   Sample RSA keys and certificates.  DON'T USE THESE FILES
   FOR ANYTHING OTHER THAN TESTING BECAUSE THEY ARE TOTALLY INSECURE.
=20
-* sample-config-files/
+* sample/sample-config-files/
=20
   A collection of OpenVPN config files and scripts from
   the HOWTO at http://openvpn.net/howto.html
=20
-* easy-rsa/
+*************************************************************************
+
+Note that easy-rsa and tap-windows are now maintained in their own subproj=
ects.=20
+Their source code is available here:
+
+  https://github.com/OpenVPN/easy-rsa
+  https://github.com/OpenVPN/tap-windows
+
+The old cross-compilation environment (domake-win) and the Python-based=20
+buildsystem have been replaced with openvpn-build:
+
+  https://github.com/OpenVPN/openvpn-build
=20
-  A simple guide to RSA key management, scripts included.
-  Also see http://openvpn.net/easyrsa.html
+See the INSTALL file for usage information.
--=20
1.7.10.4


