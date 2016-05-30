From: samuli@...515...
Date: Mon, 30 May 2016 22:40:36 +0300
Message-Id: <1464637236-17636-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Clarify the fact that build instructions in
	README are for release tarballs
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
Cc: =?UTF-8?q?Samuli=20Sepp=C3=A4nen?= <samuli.seppanen@...277...>

From: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>

URL: https://github.com/OpenVPN/openvpn/pull/51
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
---
 README | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 81424d1..09da268 100644
--- a/README
+++ b/README
@@ -7,12 +7,13 @@ as published by the Free Software Foundation.
=20
 *************************************************************************
=20
-For the latest version of OpenVPN, go to:
+To get the latest release of OpenVPN, go to:
=20
 	http://openvpn.net/
=20
 To Build and Install,
=20
+	tar -zxf openvpn-<version>.tar.gz
 	./configure
 	make
 	make install
--=20
2.5.5


