From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Wed, 23 Mar 2011 13:38:36 +0200
Message-Id: <1300880316-5779-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fixes to Makefile.am
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

Removed reference to config-win32.h, which has been removed. Added
management-notes.txt to dist rules.

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 Makefile.am |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 1c9468c..194e5b9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -60,9 +60,6 @@ SUBDIRS =3D \
 TESTS =3D t_client.sh t_lpback.sh t_cltsrv.sh
 sbin_PROGRAMS =3D openvpn
=20
-dist_noinst_HEADERS =3D \
-	config-win32.h
-
 dist_noinst_SCRIPTS =3D \
 	$(TESTS) \
 	doclean \
@@ -75,7 +72,8 @@ dist_noinst_DATA =3D \
 	COPYRIGHT.GPL \
 	PORTS \
 	INSTALL-win32.txt \
-	service-win32/msvc.mak
+	service-win32/msvc.mak \
+	management/management-notes.txt
=20
 openvpn_SOURCES =3D \
         base64.c base64.h \
--=20
1.6.3.3


