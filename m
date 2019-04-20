Date: Sat, 20 Apr 2019 17:09:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190420150941.GN31008@...1296...>
References: <51d6f746-c379-3cba-d204-103d722f1fde@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1Ohz8t0v+ZTQEWKa"
Content-Disposition: inline
In-Reply-To: <51d6f746-c379-3cba-d204-103d722f1fde@...515...>
Subject: Re: [Openvpn-devel] New OpenVPN 2.4.7 installers with tap-windows6
 and other componets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--1Ohz8t0v+ZTQEWKa
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 20, 2019 at 12:16:49PM +0300, Samuli Sepp=E4nen wrote:
> Here are completely untested OpenVPN 2.4.7 installers which I wanted to
> get out for testing a.s.a.p.:
>=20
> <https://build.openvpn.net/downloads/releases/openvpn-install-2.4.7-I604-=
Win7.exe>
> <https://build.openvpn.net/downloads/releases/openvpn-install-2.4.7-I604-=
Win10.exe>
>=20
> As the name implies, there is a different version for Windows 7 (plus
> 8/8.1/Server 2012r2) and for Windows 10 (all versions). This is
> necessary due to code signatures in the tap-windows6 driver.

Shouldn't it be possible to have a normal signed driver also attestation
signed, so "one driver for win7+win10"?

Or have we just never tested this?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--1Ohz8t0v+ZTQEWKa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcuzY1AAoJEB2Cnv7KVigSy8sL/14vUkbFCynE7TgEnnK2upOs
LMSN0Z6oRUl36mhfVdqE810RQGiWcAVcRhft+OIuURReCB6UXiNBIJ6SV4oJtrRf
++QnkK7O2FjLoifqvsdvIL3/xUJYshJDJAFnozPt/hHiMq+vVHcGk/kIwsGBfqJt
M+fIVMppTAb4+0MpBYBOXebcWq7p75j7luUr4G7LzOepT9aBnz/kpRozYQAXaJLr
9F4mZDcKQVtA/f0V0kFt2Ve0lCNrvEAVhBlW+fD/cSeF+mrerDlEQi+vNDHB7iaq
P3bLZ2OGfC/qoWst8fgeFnBsTZrGtVnVfS7L7UyNC2t/Yuzj2h4SveXlCrgKkfO9
m26FLR56c4yMbMGkQBI9i3Zx6+NWu5Hm2D17UGWa0/FWMZNo0gSrrhK2tLLaUeuH
UkXK9OkEqzgkhCgY7qMOHWrX312Y6nppyKpsj8Q51zFKRGdnFepzSE0ozJJuNjxg
+8AKhIY8hNVGRzpK6g5O73yOZehhhbOekc6gBc4pUA==
=9sMM
-----END PGP SIGNATURE-----

--1Ohz8t0v+ZTQEWKa--

