Date: Thu, 2 Sep 2010 21:26:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100902192624.GN10703@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdEaXsHGJIWX/19R"
Content-Disposition: inline
Subject: [Openvpn-devel] PATCH/PULL: IPv6 check for TAP driver version on
	windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--gdEaXsHGJIWX/19R
Content-Type: multipart/mixed; boundary="JVTRtevMO87SusWP"
Content-Disposition: inline

--JVTRtevMO87SusWP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

as discussed just now on IRC, I have adapted the IPv6 check in tun.c
to the version number used by the 2.2-beta3 tap driver.

David: could you please pull from=20

  git://compile.svr01.mucip.net/openvpn-gert.git  "master"

to feat_ipv6_payload?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--JVTRtevMO87SusWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-2.2-beta3-has-a-signed-TAP-driver-with-the-IPv6-code.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 54a6339bc4875ae5daadbbc561211592ce872044 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Thu, 2 Sep 2010 21:20:30 +0200
Subject: [PATCH] 2.2-beta3 has a signed TAP driver with the IPv6 code, but =
it's not
 version 9.7 as anticipated (that's 2.1.3) but 9.8 - change test to
 require 9.8, and change message to point to 2.2-beta3 and up.

Signed-off-by: Gert Doering <gert@...1296...>
---
 ChangeLog.IPv6 |    5 +++++
 tun.c          |    4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/ChangeLog.IPv6 b/ChangeLog.IPv6
index 4275389..19bbad7 100644
--- a/ChangeLog.IPv6
+++ b/ChangeLog.IPv6
@@ -333,3 +333,8 @@ Sun Aug  8 12:30:44 CEST 2010
   * tun.c: destroy tunX interface at tun_close() on OpenBSD (cleanup)
=20
   * TEST SUCCESS: OpenBSD 4.7: client-tun/net30, v4+v6
+
+Thu Sep  2 21:18:32 CEST 2010
+
+  * tun.c: the TAP binary in 2.2-beta3 has the IPv6 related changes, but
+    the version number is 9.8 now -> check for 9.8, not 9.7
diff --git a/tun.c b/tun.c
index 3e4b37f..30d3be1 100644
--- a/tun.c
+++ b/tun.c
@@ -4319,9 +4319,9 @@ open_tun (const char *dev, const char *dev_type, cons=
t char *dev_node, struct tu
      * *this* version of the driver
      */
     if ( tt->ipv6 && tt->type =3D=3D DEV_TYPE_TUN &&
-         info[0] =3D=3D 9 && info[1] < 7)
+         info[0] =3D=3D 9 && info[1] < 8)
       {
-	msg( M_INFO, "WARNING:  Tap-Win32 driver version %d.%d does not support I=
Pv6 in TUN mode.  IPv6 will be disabled.  Upgrade to Tap-Win32 9.7 or use T=
AP mode to get IPv6", (int) info[0], (int) info[1] );
+	msg( M_INFO, "WARNING:  Tap-Win32 driver version %d.%d does not support I=
Pv6 in TUN mode.  IPv6 will be disabled.  Upgrade to Tap-Win32 9.8 (2.2-bet=
a3 release or later) or use TAP mode to get IPv6", (int) info[0], (int) inf=
o[1] );
 	tt->ipv6 =3D false;
       }
   }
--=20
1.7.0.5


--JVTRtevMO87SusWP--

--gdEaXsHGJIWX/19R
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTH/6YKkuBuNlUUl1AQKwYgP/b2Yszt9VABF5anPMo6Spv5RXmVn6sWxl
AY7jxgqd+sUDsklRUIKUhCBxnehqh6PnO9snk6Ps2wCF1PlJ79f6AyO4HN2ftQw9
8R5drzK+QvhWYsggVh2SzStkmv5gw9kiusYxzrLAHT4X1Ids2RLoOVXu9Pb2HGJU
8pm7rqevxbI=
=2Vxb
-----END PGP SIGNATURE-----

--gdEaXsHGJIWX/19R--

