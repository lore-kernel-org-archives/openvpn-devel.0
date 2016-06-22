From: samuli@...515...
Date: Wed, 22 Jun 2016 20:06:02 +0300
Message-Id: <1466615164-15527-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Mention tap-windows6 in INSTALL file
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
 INSTALL | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/INSTALL b/INSTALL
index 2401f7c..42f78d8 100644
--- a/INSTALL
+++ b/INSTALL
@@ -30,10 +30,14 @@ To download easy-rsa go to:
=20
     https://github.com/OpenVPN/easy-rsa
=20
-To download tap-windows driver source code go to:
+To download tap-windows (NDIS 5) driver source code go to:
=20
     https://github.com/OpenVPN/tap-windows
=20
+To download tap-windows (NDIS 6) driver source code go to:
+
+    https://github.com/OpenVPN/tap-windows6
+
 To get the cross-compilation environment go to:
=20
     https://github.com/OpenVPN/openvpn-build
--=20
2.1.4


