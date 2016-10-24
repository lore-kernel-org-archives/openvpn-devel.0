From: samuli@...515...
Date: Mon, 24 Oct 2016 14:19:38 +0300
Message-Id: <1477307978-3707-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove INSTALL-win32.txt that is now hosted
	in openvpn-build
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

URL: https://github.com/OpenVPN/openvpn-build/pull/35
URL: https://github.com/OpenVPN/openvpn-build/pull/38
Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 INSTALL-win32.txt | 77 ---------------------------------------------------=
----
 1 file changed, 77 deletions(-)
 delete mode 100644 INSTALL-win32.txt

diff --git a/INSTALL-win32.txt b/INSTALL-win32.txt
deleted file mode 100644
index 7c05685..0000000
--- a/INSTALL-win32.txt
+++ /dev/null
@@ -1,77 +0,0 @@
-UPGRADING FROM 2.3-ALPHA1 AND EARLIER
-
-OpenVPN Windows installer went through major changes in
-2.3-alpha2. To avoid any unexpected behavior, it is strongly
-suggested to upgrade as follows.
-
-First backup configuration files and certificates from your
-current installation; by default they're in
-
-    C:\Program Files\OpenVPN\config (32-bit Windows)
-    C:\Program Files (x86)\OpenVPN\config (64-bit Windows)
-
-After this, stop the openvpn-gui or the openvpn service
-wrapper, if either of them is running and uninstall OpenVPN.
-Finally, remove the OpenVPN install directory entirely (e.g.
-using Windows Explorer as administrator).
-
-Finally, install the new version of OpenVPN and copy over
-your configuration files and certificates, which now go to
-
-    C:\Program Files\OpenVPN\config
-
-provided you did not install the 32-bit version on 64-bit
-Windows.
-
-IMPORTANT NOTE FOR WINDOWS VISTA/7 USERS
-
-Note that on Windows Vista, you will need to run the OpenVPN
-GUI with administrator privileges, so that it can add routes
-to the routing table that are pulled from the OpenVPN server.
-You can do this by right-clicking on the OpenVPN GUI
-desktop icon, and selecting "Run as administrator".
-
-GENERAL QUICKSTART FOR WINDOWS
-
-The OpenVPN Client requires a configuration file
-and key/certificate files. You should obtain
-these and save them to OpenVPN's configuration
-directory, usually C:\Program Files\OpenVPN\config.
-
-You can run OpenVPN as a Windows system service or by using
-the client GUI. To use the OpenVPN GUI, double click on the
-desktop icon or start menu icon. The OpenVPN GUI is a
-system-tray applet, so an icon for the GUI will appear in
-the lower-right corner of the screen. Right click on the
-system tray icon, and a menu should appear showing the names
-of your OpenVPN configuration files, and giving you the
-option to connect.
-
-BUILDING OPENVPN FOR WINDOWS
-
-Official OpenVPN Windows releases are cross-compiled on Linux using the
-openvpn-build buildsystem:
-
-    https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsy=
stem
-
-First setup the build environment as shown in the above article. Then fetc=
h the
-openvpn-build repository:
-
-    git clone https://github.com/OpenVPN/openvpn-build.git
-
-Review the build configuration:
-
-    openvpn-build/generic/build.vars
-    openvpn-build/windows-nsis/build-complete.vars
-
-Build (unsigned):
-
-    cd openvpn-build/windows-nsis
-    ./build-complete
-
-Build (signed):
-
-    cd openvpn-build/windows-nsis
-    ./build-complete --sign --sign-pkcs12=3D<pkcs12-file>\
-    --sign-pkcs12-pass=3D<pkcs12-file-password> \
-    --sign-timestamp=3D"<timestamp-url>"
--=20
2.1.4


