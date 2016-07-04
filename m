From: samuli@...515...
Date: Mon,  4 Jul 2016 12:29:45 +0300
Message-Id: <1467624585-23515-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Deprecate the automatic part of
	openvpnserv.exe in favor of openvpnserv2.exe
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
 src/openvpnserv/automatic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
index 9b424e9..aa7618f 100644
--- a/src/openvpnserv/automatic.c
+++ b/src/openvpnserv/automatic.c
@@ -49,8 +49,8 @@ static SERVICE_STATUS status;
=20
 openvpn_service_t automatic_service =3D {
   automatic,
-  TEXT(PACKAGE_NAME "Service"),
-  TEXT(PACKAGE_NAME " Service"),
+  TEXT(PACKAGE_NAME "ServiceLegacy"),
+  TEXT(PACKAGE_NAME " Legacy Service"),
   TEXT(SERVICE_DEPENDENCIES),
   SERVICE_DEMAND_START
 };
--=20
2.5.5


