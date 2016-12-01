From: samuli@...515...
Date: Thu,  1 Dec 2016 16:03:05 +0200
Message-Id: <1480600985-25074-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Mention that OpenVPN 2.4 requires Windows
	Vista or higher
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

Trac: #610

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 INSTALL | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/INSTALL b/INSTALL
index 4c6d21f..9707060 100644
--- a/INSTALL
+++ b/INSTALL
@@ -59,7 +59,8 @@ SUPPORTED PLATFORMS:
   (4) Mac OS X Darwin 10.5+
   (5) FreeBSD 7.4+
   (6) NetBSD 5.0+
-  (7) Windows (WinXP and higher)
+  (7) Windows Vista or later for OpenVPN 2.4
+  (8) Windows XP or later for OpenVPN 2.3
=20
 SUPPORTED PROCESSOR ARCHITECTURES:
    In general, OpenVPN is word size and endian independent, so
--=20
2.1.4


