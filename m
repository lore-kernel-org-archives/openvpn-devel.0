From: samuli@...515...
Date: Wed, 22 Jun 2016 20:06:04 +0300
Message-Id: <1466615164-15527-3-git-send-email-samuli@...515...>
In-Reply-To: <1466615164-15527-1-git-send-email-samuli@...515...>
References: <1466615164-15527-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] Clarify which Windows versions require
	which TUN/TAP driver
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
 INSTALL | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/INSTALL b/INSTALL
index 42f78d8..334d0e6 100644
--- a/INSTALL
+++ b/INSTALL
@@ -298,13 +298,13 @@ TUN/TAP Driver Configuration:
=20
     http://www.whiteboard.ne.jp/~admin2/tuntap/
=20
-* Windows XP/2003/Vista/7:
+* Windows
=20
   OpenVPN on Windows needs a TUN/TAP kernel driver to work. OpenVPN instal=
lers
   include this driver, so installing it separately is not usually required.
-  The driver source code is available here:
-
-    https://github.com/OpenVPN/tap-windows
+  Windows XP/2003 must use the NDIS 5 (tap-windows) driver, whereas more r=
ecent
+  Windows versions should (Vista to 8.1) or must (Windows 10) use the NDIS=
 6
+  driver (tap-windows6) instead.
=20
 *************************************************************************
=20
--=20
2.1.4


