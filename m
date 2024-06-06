Date: Thu, 6 Jun 2024 14:23:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZmGqRY9vRywrLUHD@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7PafmcUP5dn5wBqD"
Content-Disposition: inline
Subject: [Openvpn-devel] windows client tests needed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--7PafmcUP5dn5wBqD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

we have new code in master that helps with the "TunnelCrack" and
"TunnelVision" attacks, that is, packets intended to go into the
VPN being leaked away by means of a malicious DHCP server (=3D routing
points outside the tunnel, so packets never hit OpenVPN).

We used to have

  block-outside-dns

to prevent Windows from doing DNS lookups "around the VPN" - the main
intent of this was "make sure split DNS works", but a side effect has
also been "avoid DNS leaks".

Heiko has now extended this code to be able to "block everything not
going into the VPN".  To activate this, you need

  redirect-gateway def1 block-local

in your config ("block-local" is the keyword, but without "def1" you
end up with a split-tunnel and "nothing else is allowed", which is rarely
a really good combination).

Repeat: if "redirect-gateway block-local" is active, NO packets leave
via LAN/WiFi/... interfaces, except those sourced by the openvpn.exe
process.  This is important for maximum privacy, especially if you
roam into a network with an untrusted DHCP server.


Now - this code has been merged into "git master", and installers
are here:

   https://github.com/OpenVPN/openvpn-build/actions/runs/9391365526?pr=3D641

(bottom of the page, "Artifacts", .zip files with a .msi inside).


I want to have this in 2.6 as well, as it's sort of important for certain
classes of users (and also VPN providers, offering this as a service) - but
I do not feel it has been tested enough yet.

So: PLEASE test these windows installers, in all 3 variants

 1.  <nothing special in the config>
 2.  block-outside-dns
     (DNS is blocked, everything else not routed into the VPN tunnel - like
     "your local printer" etc - still works)
 3.  redirect-gateway def1 block-local
     (ONLY VPN works)

and report back to us.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--7PafmcUP5dn5wBqD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJmYapFAAoJEB2Cnv7KVigS3jUL+gKQsdiN/Zmd80pmk6Jz0Dr1
dTXCcK0snG+JTgEG9hQu1FrgRts7sBODnfo5vVWhesz9+dZp/fqlGLDnWOgMwtz7
NV7Z5iDd8RSD872ozPSS59xZiYruiL7uC8AoldHA6uUn0lalhHkcCTgaFeFhjxxs
CqJsa6M2jZEq8Waju8BOA5UY8RGt9bAThIpVXDat3jSzWoqI/rLHNiXpL6WUIEJI
gARxRCXbK0GQ3lH0S80XAWTylOGj7Mdu+1VrvTiTcslEFZinwXz7oxLk9lt8Tsau
AdEvTTk3q5yT4tEsuRRlePXtIFH4TpFYBZYmcmWRAtRd/oCT9Nt84phi0gAURvZr
f+14XwQVH9F3YOtDpwSyb1/HBNmwA42HUflCFoSjT5t8jga6+NUgpIu7vtYAjZpi
q44K36Wxdkoa2YIL36QuVDVf6yrueX0lCzuLdhynua/dfGYI7czSFVMtHw1Dw2oz
PEvTHES82HkS4K8r0Trw0nggxeQZqkv7eIbrx855bA==
=EmFJ
-----END PGP SIGNATURE-----

--7PafmcUP5dn5wBqD--

