From: samuli@...515...
Date: Tue, 26 Jun 2012 12:02:15 +0300
Message-Id: <1340701335-8874-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Added notes about upgrading from 2.3-alpha1
	and earlier to INSTALL-win32.txt
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
 INSTALL-win32.txt |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/INSTALL-win32.txt b/INSTALL-win32.txt
index 5a0f3a9..4afef32 100644
--- a/INSTALL-win32.txt
+++ b/INSTALL-win32.txt
@@ -1,3 +1,27 @@
+UPGRADING FROM 2.3-ALPHA1 AND EARLIER
+
+OpenVPN Windows installer went through major changes in=20
+2.3-alpha2. To avoid any unexpected behavior, it is strongly=20
+suggested to upgrade as follows.
+
+First backup configuration files and certificates from your=20
+current installation; by default they're in
+
+    C:\Program Files\OpenVPN\config (32-bit Windows)
+    C:\Program Files (x86)\OpenVPN\config (64-bit Windows)
+
+After this, stop the openvpn-gui or the openvpn service=20
+wrapper, if either of them is running and uninstall OpenVPN.=20
+Finally, remove the OpenVPN install directory entirely (e.g.=20
+using Windows Explorer as administrator).
+
+Finally, install the new version of OpenVPN and copy over=20
+your configuration files and certificates, which now go to
+
+    C:\Program Files\OpenVPN\config
+
+regardless of whether you're using 32-bit or 64-bit Windows.
+
 IMPORTANT NOTE FOR WINDOWS VISTA/7 USERS
=20
 Note that on Windows Vista, you will need to run the OpenVPN
--=20
1.7.5.4


