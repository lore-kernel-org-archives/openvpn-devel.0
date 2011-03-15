From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Tue, 15 Mar 2011 16:38:07 +0200
Message-Id: <1300199887-4806-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Updated INSTALL-win32.txt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 INSTALL-win32.txt |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/INSTALL-win32.txt b/INSTALL-win32.txt
index cc79d72..572309a 100644
--- a/INSTALL-win32.txt
+++ b/INSTALL-win32.txt
@@ -1,4 +1,4 @@
-IMPORTANT NOTE FOR VISTA USERS
+IMPORTANT NOTE FOR WINDOWS VISTA/7 USERS
=20
 Note that on Windows Vista, you will need to run the OpenVPN
 GUI with administrator privileges, so that it can add routes
@@ -9,14 +9,15 @@ desktop icon, and selecting "Run as administrator".
 GENERAL QUICKSTART FOR WINDOWS
=20
 The OpenVPN Client requires a configuration file
-and key/certificate files.  You should obtain
-these and save them to \Program Files\OpenVPN\config.
+and key/certificate files. You should obtain
+these and save them to OpenVPN's configuration=20
+directory, usually C:\Program Files\OpenVPN\config.
=20
-To start OpenVPN, first run the OpenVPN GUI by double
-clicking on the desktop icon or start menu icon.
-
-The OpenVPN GUI is a system-tray applet, so an icon for the
-GUI will appear in the lower-right corner of the screen.
-Right click on the system tray icon, and a menu should appear
-showing the names of your OpenVPN configuration files, and
-giving you the option to connect.
+You can run OpenVPN as a Windows system service or by using=20
+the client GUI. To use the OpenVPN GUI, double click on the=20
+desktop icon or start menu icon. The OpenVPN GUI is a=20
+system-tray applet, so an icon for the GUI will appear in=20
+the lower-right corner of the screen. Right click on the=20
+system tray icon, and a menu should appear showing the names=20
+of your OpenVPN configuration files, and giving you the=20
+option to connect.
--=20
1.6.3.3


