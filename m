From: samuli@...515...
Date: Mon,  4 Jan 2016 20:22:21 +0200
Message-Id: <1451931741-4126-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Update INSTALL-win32.txt for OpenVPN 2.3.10
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

OpenVPN 2.3.10 includes an OpenVPN-GUI which automatically requests elevati=
on of
privileges using UAC. Modified INSTALL-win32.txt to reflect this behavior.

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 INSTALL-win32.txt | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/INSTALL-win32.txt b/INSTALL-win32.txt
index 7c05685..ce08e63 100644
--- a/INSTALL-win32.txt
+++ b/INSTALL-win32.txt
@@ -1,3 +1,4 @@
+
 UPGRADING FROM 2.3-ALPHA1 AND EARLIER
=20
 OpenVPN Windows installer went through major changes in
@@ -23,13 +24,15 @@ your configuration files and certificates, which now go=
 to
 provided you did not install the 32-bit version on 64-bit
 Windows.
=20
-IMPORTANT NOTE FOR WINDOWS VISTA/7 USERS
+IMPORTANT NOTE FOR USERS OF WINDOWS VISTA AND ABOVE
+
+Note that on Windows Vista and above, you will need to run the
+OpenVPN-GUI as a user with administrator privileges, so that
+it can add routes to the routing table. Admin privileges are
+requested automatically in OpenVPN 2.3.10 and later; older
+versions require right-clicking on the OpenVPN-GUI desktop icon
+and selecting "Run as administrator".
=20
-Note that on Windows Vista, you will need to run the OpenVPN
-GUI with administrator privileges, so that it can add routes
-to the routing table that are pulled from the OpenVPN server.
-You can do this by right-clicking on the OpenVPN GUI
-desktop icon, and selecting "Run as administrator".
=20
 GENERAL QUICKSTART FOR WINDOWS
=20
--=20
2.1.0


