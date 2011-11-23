Date: Wed, 23 Nov 2011 11:23:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111123102344.GA8496@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VBeXCwbVT6X1cXag"
Content-Disposition: inline
Subject: [Openvpn-devel] extra patches needed for tap driver bugfix
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--VBeXCwbVT6X1cXag
Content-Type: multipart/mixed; boundary="tl7K513ixPcpknIx"
Content-Disposition: inline

--tl7K513ixPcpknIx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

bugfixing the tap driver is nice and well, but I think we MUST bump the
driver version as well, and we SHOULD have a check in tun.c to refuse
operation if the known-buggy version (9.8) is detected.

Patches below.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tl7K513ixPcpknIx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-bump-tap-driver-version-from-9.8-to-9.9.patch"
Content-Transfer-Encoding: quoted-printable

=46rom c8e7ad5ed0a91d8b595e8b1862416f226a86968f Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Wed, 23 Nov 2011 11:07:09 +0100
Subject: [PATCH 1/2] bump tap driver version from 9.8 to 9.9
 (bugfixed tapdrvr.c regarding small IPv4 packets)

---
 version.m4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/version.m4 b/version.m4
index 78e69aa..514ae72 100644
--- a/version.m4
+++ b/version.m4
@@ -3,4 +3,4 @@ define(PRODUCT_VERSION,[2.x-master])
 dnl define the TAP version
 define(PRODUCT_TAP_ID,[tap0901])
 define(PRODUCT_TAP_WIN32_MIN_MAJOR,[9])
-define(PRODUCT_TAP_WIN32_MIN_MINOR,[8])
+define(PRODUCT_TAP_WIN32_MIN_MINOR,[9])
--=20
1.7.3.4


--tl7K513ixPcpknIx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-log-error-message-and-exit-for-win32-tun-mode-tap-dr.patch"
Content-Transfer-Encoding: quoted-printable

=46rom ce6329e86dfd4b4af1371c09abf06795540fa28a Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Wed, 23 Nov 2011 11:11:54 +0100
Subject: [PATCH 2/2] log error message and exit for "win32, tun mode, tap d=
river version 9.8"
 (driver is known-buggy for small IPv4 packets in tun mode)

---
 tun.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/tun.c b/tun.c
index c8ac394..70d9f5a 100644
--- a/tun.c
+++ b/tun.c
@@ -4584,6 +4584,14 @@ open_tun (const char *dev, const char *dev_type, con=
st char *dev_node, struct tu
 	msg( M_INFO, "WARNING:  Tap-Win32 driver version %d.%d does not support I=
Pv6 in TUN mode.  IPv6 will be disabled.  Upgrade to Tap-Win32 9.8 (2.2-bet=
a3 release or later) or use TAP mode to get IPv6", (int) info[0], (int) inf=
o[1] );
 	tt->ipv6 =3D false;
       }
+
+    /* tap driver 9.8 (2.2.0 and 2.2.1 release) is buggy
+     */
+    if ( tt->type =3D=3D DEV_TYPE_TUN &&=20
+	 info[0] =3D=3D 9 && info[1] =3D=3D 8)
+      {
+	msg( M_FATAL, "ERROR:  Tap-Win32 driver version %d.%d is buggy regarding =
small IPv4 packets in TUN mode.  Upgrade to Tap-Win32 9.9 (2.2.2 release or=
 later) or use TAP mode", (int) info[0], (int) info[1] );
+      }
   }
=20
   /* get driver MTU */
--=20
1.7.3.4


--tl7K513ixPcpknIx--

--VBeXCwbVT6X1cXag
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTszJsKkuBuNlUUl1AQLEMQP9HIGvSfaxBqKdwP26qW3mNw7oZ3kYS6Xx
00W8ISp/2GVgPzDmmVwXbcvZ6dK/SnKJyglO2TCXRDimjEhnkY6YdjBNwTdRwA/Z
tDr0iDD9jLjI5GKgMDiMKLAEivKo3le0ZqsxJJIs+JRFkkwaQzmijqh4W9jOiN59
JezDj2p1aug=
=mWRn
-----END PGP SIGNATURE-----

--VBeXCwbVT6X1cXag--

