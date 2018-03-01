Date: Thu, 1 Mar 2018 10:15:22 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180301091522.GV69387@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7OnDFbl3rdzPmmvv"
Content-Disposition: inline
Subject: [Openvpn-devel] 2.4.5 typo in ChangeLog file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--7OnDFbl3rdzPmmvv
Content-Type: multipart/mixed; boundary="9LzbfKVJ2kwORFXX"
Content-Disposition: inline

--9LzbfKVJ2kwORFXX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

most of the 2.4.5 release is fine and well tested, but one typo managed
to sneak into the "ChangeLog" file - it talks "2.4.4" release, with
the proper timestamp.

As the commit has been tagged and the tag pushed, fixing this will=20
break git repos of people that have already pulled - and the common
wisdom is "DO NOT DO THAT!".  It's not an emergency breakage which=20
might warrant "skip 2.4.5 then, and re-tag everything as 2.4.6".

Thus, I'm just going to apply (+PGP-sign) the following patch to the
release/2.4 tree, so the ChangeLog is factually correct now - even if
it won't change the shipping tarballs.

Sorry.

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--9LzbfKVJ2kwORFXX
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Correct-version-in-ChangeLog-should-be-2.4.5-was-mis.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 161afbebdc2b7e244a136182a676ad55347c9cf5 Mon Sep 17 00:00:00 2001
=46rom: Gert Doering <gert@...1296...>
Date: Thu, 1 Mar 2018 10:11:08 +0100
Subject: [PATCH] Correct version in ChangeLog - should be 2.4.5, was mistyp=
ed
 as 2.4.4

Signed-off-by: Gert Doering <gert@...1296...>
---
 ChangeLog | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ChangeLog b/ChangeLog
index 99772a33..0db3e5b8 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,7 +1,7 @@
 OpenVPN Change Log
 Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
=20
-2018.02.28 -- Version 2.4.4
+2018.02.28 -- Version 2.4.5
 Antonio Quartulli (4):
       reload HTTP proxy credentials when moving to the next connection pro=
file
       Allow learning iroutes with network made up of all 0s (only if netbi=
ts < 8)
--=20
2.16.1


--9LzbfKVJ2kwORFXX--

--7OnDFbl3rdzPmmvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJal8SpAAoJEB2Cnv7KVigScj0L/iE7LefKKNH1orBShQwCV1q/
q4rTCH1A3hdrouVc+GMzgOvgibn71oz4+2WGS+TN4seu/qY7eXo5tNJk+VIiLfwQ
Fgm6rHYFDicqeyE9/fRgC3dNwYSE4GSNoW28oCdio5EjqhWlzGGFd9i8axcTWnLy
hCH5gXmKV0pp6bh+CSCB78CjA3EC3S3rWwwifGtY1dxhETlAWvdCqiLKIGoIhB3M
5ExA5KL5DKj/S8Ge0aDwIIF1C/X4YIFyW7dSz0ESJ6F9evLogVNhSWF5lTUgoV9W
oYcYH8lhtvrjNaDc2dLRYhJ0bTMtyn6Kccpq97UUeLZWz1sXhgYhImHqUSctHwLi
mrioZEAgHBFejBRwfDWVBy5H15ZoadrpCHrYpTqok1pzrf43mtuvTu0BovPuxdPF
KrEUcJ4tHje9r46mTcuDOPRk2WwcDmaX0flfHDFMj+tRTFo5/VbxR9AwJ68nszhl
O41hX7MhXhiG0uFI+XZ00NauUOoZEkF/k78aglE1rA==
=55fF
-----END PGP SIGNATURE-----

--7OnDFbl3rdzPmmvv--

