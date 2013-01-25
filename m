From: samuli@...515...
Date: Fri, 25 Jan 2013 10:12:18 +0200
Message-Id: <1359101540-976-3-git-send-email-samuli@...515...>
In-Reply-To: <1359101540-976-1-git-send-email-samuli@...515...>
References: <1359101540-976-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/4] Added cross-compilation information
	INSTALL-win32.txt
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
 INSTALL-win32.txt |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/INSTALL-win32.txt b/INSTALL-win32.txt
index 1ef3869..5c92fe5 100644
--- a/INSTALL-win32.txt
+++ b/INSTALL-win32.txt
@@ -46,3 +46,32 @@ the lower-right corner of the screen. Right click on the
 system tray icon, and a menu should appear showing the names
 of your OpenVPN configuration files, and giving you the
 option to connect.
+
+BUILDING OPENVPN FOR WINDOWS
+
+Official OpenVPN Windows releases are cross-compiled on Linux using the=20
+openvpn-build buildsystem:
+
+    https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsy=
stem
+
+First setup the build environment as shown in the above article. Then fetc=
h the=20
+openvpn-build repository:
+
+    git clone https://github.com/OpenVPN/openvpn-build.git
+
+Review the build configuration:
+
+    openvpn-build/generic/build.vars
+    openvpn-build/windows-nsis/build-complete.vars
+
+Build (unsigned):
+
+    cd openvpn-build/windows-nsis
+    ./build-complete
+
+Build (signed):
+
+    cd openvpn-build/windows-nsis
+    ./build-complete --sign --sign-pkcs12=3D<pkcs12-file>\
+    --sign-pkcs12-pass=3D<pkcs12-file-password> \
+    --sign-timestamp=3D"<timestamp-url>"
--=20
1.7.10.4


