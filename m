From: Adriaan de Jong <dejong@...1435...>
Date: Wed, 14 Nov 2012 10:03:12 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B901323A48384@...1436...>
Content-Language: en-US
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix --show-pkcs11-ids
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

[PATCH] Fix --show-pkcs11-ids (Bug #239)

Broken by 75b49e406430299b187964744f82e50a9035a0d3.

Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
---
 src/openvpn/pkcs11.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c index 645f1f4..3a1=
5ef6 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -887,7 +887,7 @@ show_pkcs11_ids (
 		      (dn =3D pkcs11_certificate_dn (
 				certificate,
 				&gc
-		      ))
+		      )) =3D=3D NULL
 		) {
 			goto cleanup1;
 		}
--
1.7.9.5


