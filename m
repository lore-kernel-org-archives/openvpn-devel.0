From: samuli@...515...
Date: Tue,  8 Nov 2016 14:55:28 +0200
Message-Id: <1478609729-25222-4-git-send-email-samuli@...515...>
In-Reply-To: <1478609729-25222-1-git-send-email-samuli@...515...>
References: <1478609729-25222-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/4] Make sure that all relevant files under
	test go to release tarballs
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
 tests/Makefile.am | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 235cd13..e55928b 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -24,4 +24,8 @@ TESTS =3D $(test_scripts)
=20
 dist_noinst_SCRIPTS =3D \
 	$(test_scripts) \
-	t_cltsrv-down.sh
+	t_cltsrv-down.sh \
+	update_t_client_ips.sh
+
+dist_noinst_DATA =3D \
+	t_client.rc-sample
--=20
2.1.4


