From: Jon Kunkee <jkunkee@...2393...>
Date: Thu, 8 Nov 2018 22:50:49 +0000
Message-ID: <DM5PR2101MB1112AC1AD809317A38837300B0C50@...2412...>
References: <20181010192337.6984-1-simon@...2293...>
 <20181016102627.18676-1-simon@...2293...>
 <20181016102627.18676-5-simon@...2293...>
In-Reply-To: <20181016102627.18676-5-simon@...2293...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 5/5] Detect TAP interfaces with
 root-enumerated hardware ID
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Samuli, LGTM.

-----Original Message-----
From: Simon Rozman <simon@...2293...>=20
Sent: Tuesday, October 16, 2018 3:26 AM
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] [PATCH 5/5] Detect TAP interfaces with root-enumer=
ated hardware ID

This patch extends the TAP interface enumerating to detect the TAP
interfaces registered using "root\tap0901" hardware ID. Before, only TAP
interfaces with legacy "tap0901" HWID were detected by openvpn.exe.

The openvpnmsica.dll and tapctl.exe install TAP interfaces using root-
enumerated HWIDs, and were not detected by openvpn.exe.
---
 src/openvpn/tun.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 948fd17d..5fde2ab8 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3524,7 +3524,8 @@ get_tap_reg(struct gc_arena *gc)
=20
                 if (status =3D=3D ERROR_SUCCESS && data_type =3D=3D REG_SZ)
                 {
-                    if (!strcmp(component_id, TAP_WIN_COMPONENT_ID))
+                    if (!strcmp(component_id, TAP_WIN_COMPONENT_ID) ||
+                        !strcmp(component_id, "root\\" TAP_WIN_COMPONENT_I=
D))
                     {
                         struct tap_reg *reg;
                         ALLOC_OBJ_CLEAR_GC(reg, struct tap_reg, gc);
--=20
2.19.0.windows.1



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.so=
urceforge.net%2Flists%2Flistinfo%2Fopenvpn-devel&amp;data=3D02%7C01%7Cjkunk=
ee%40microsoft.com%7C4f51c53f4856475e3cab08d63351eb89%7C72f988bf86f141af91a=
b2d7cd011db47%7C1%7C0%7C636752824282687252&amp;sdata=3DRkqbvXw2zxm00Np2Bb9C=
%2BeQstsTHkOHw25XtTyZYDII%3D&amp;reserved=3D0

