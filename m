From: samuli@...515...
Date: Mon, 30 May 2016 23:03:50 +0300
Message-Id: <1464638630-19744-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Clarify the fact that build instructions
	in README are for release tarballs
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

URL: https://github.com/OpenVPN/openvpn/pull/51
Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 README | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 349e08a..de4036a 100644
--- a/README
+++ b/README
@@ -7,12 +7,14 @@ as published by the Free Software Foundation.
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
+	cd openvpn-<version>
 	./configure
 	make
 	make install
--=20
2.5.5


