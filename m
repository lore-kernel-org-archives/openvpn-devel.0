Date: Fri, 26 Jun 2020 10:44:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200626084427.GU1431@...1296...>
References: <2f575943f32de2328843b3cec3286ca1@...2399...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="k9jeRyGXA6iHXzly"
Content-Disposition: inline
In-Reply-To: <2f575943f32de2328843b3cec3286ca1@...2399...>
Subject: Re: [Openvpn-devel] Darwin tap ipv6 fix
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Scott Shambarger <devel@...2399...>
Cc: openvpn-devel@lists.sourceforge.net

--k9jeRyGXA6iHXzly
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

cleaning up loose ends, and this is one of the things on my plate - sorry
for stalling so long.,

On Tue, May 15, 2018 at 06:01:41PM -0700, Scott Shambarger via Openvpn-deve=
l wrote:
> I???m setting up a tap config on a Darwin client (Tunnelblick on OSX) to =
a=20
> Linux server (Fedora).  The config has the following (only relevant=20
> portions):
>=20
> =3D=3D server
> dev tap0
> server-bridge
> push "redirect-gateway def1 ipv6"
> push "ifconfig-ipv6 {local-ipv6-address} {linklocal-addr}???
> ???etc

I saw something now that I overlooked last time: you have a=20
{linklocal-addr} here, in the "gateway address" position.

This is the reason why it is failing, and also the reason why my test
rigs are not picking up the problem - I never envisioned that someone
would want to use a link-local address here, if you have a GUA around
(so this is a case which has never been tested, and as link-local needs
special handling, the various conditional checks are not picking it
up correctly)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--k9jeRyGXA6iHXzly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe9bVqAAoJEB2Cnv7KVigSDokL/j0SqLJQiTEqt4ovmKvdZPG8
BGCEYdky/WhK8t7bYoap+nGg+KLH/dkpmewVzfkCnbXDD36a1j1x1iGviGDMdvZN
yj6hwulT4iMuTjLDwOG0gmlgnPpTZuBvu9x5rl+QZzQBULEmG08I8K8iuAbtTu/Q
ZPv1vx2Jyuunp9iT+IJgt/izLIACFkGpJXOicrBGSsnKMUtKbjc7umqBdHBLM8Eg
qFe/jgFBqhkPNLGbYv0YNVEhyWqbegEGti2tEtTy1Tk9xqvVNhUnIIbZSBJJL/UL
YRgSkP1ygW75/l/L51dbGQUVA/30+4Yo10BPyE/Gifo8VJf4DonYkz7bzQyual2a
BodpeK0bfJOphr9EtHZoOZnP/WugHnRcaETbxxxvbpMYk9r/X1dvRuffVyRms8YU
xWbp/sFFQF0KSqxFD6ml9p7Cj2KScd1T1eL9AA6vctMmP7vFHQ1bJS0HrEO8tEJf
BjTd/J0M64X8xNCLjO7tnJcv9r1NJRfaaTMjsrMd3Q==
=yqLO
-----END PGP SIGNATURE-----

--k9jeRyGXA6iHXzly--

