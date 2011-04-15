From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Fri, 15 Apr 2011 15:57:15 +0300
Message-Id: <1302872235-22152-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fixed a bug with GUI icon not being deleted
	on upgrade from 2.2-RC or earlier
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

This bug was introduced in commit 110e42d199e735ab1a31388c5678f59d0fa9510c.

Trac-ticket: 120
Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 win/openvpn.nsi |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/win/openvpn.nsi b/win/openvpn.nsi
index bad1ef4..148dafc 100755
--- a/win/openvpn.nsi
+++ b/win/openvpn.nsi
@@ -237,6 +237,13 @@ Section -pre
=20
   Sleep 3000
=20
+  # Fix for Trac ticket 120. Remove after 2.3 has been released.
+  !ifdef USE_GUI
+    SetShellVarContext current
+    Delete "$INSTDIR\bin\${OPENVPN_GUI}"
+    Delete "$DESKTOP\${PRODUCT_NAME} GUI.lnk"
+  !endif
+
 SectionEnd
=20
 Section "${PRODUCT_NAME} User-Space Components" SecOpenVPNUserSpace
--=20
1.6.3.3


