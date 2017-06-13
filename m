Date: Tue, 13 Jun 2017 21:10:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170613191028.GV97029@...1296...>
References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
	<f910a64e-235f-56ad-52b4-aff5dae46acf@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TSlk8RMAoVV44s7T"
Content-Disposition: inline
In-Reply-To: <f910a64e-235f-56ad-52b4-aff5dae46acf@...277...>
Subject: Re: [Openvpn-devel] W10 Client assigns old AND new IPv6 address to
 TAP with GUI+Service but not with cmd prompt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--TSlk8RMAoVV44s7T
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Tue, Jun 13, 2017 at 07:01:22PM +0100, debbie10t wrote:
> Rather astonishingly .. I can now reliably recreate the problem !!
>=20
> As client:
>     Config-1 assigns 12fc:1918::10:36:101:110/112 to TAP (in tun mode)
>     Config-2 assigns 12fc:1918::10:8:0:110/112 to TAP (in tun mode)
>=20
> Following:
>=20
> 1. Administrator command prompt - execute openvp config-1.ovpn
>     TAP is assigned 12fc:1918::10:36:101:110/112
> 2. Terminate by closing [X] the command prompt
> 3. Using GUI + Interactive-service start config-2.ovpn
>     TAP is assigned 12fc:1918::10:36:101:110/112
>   & TAP is assigned 12fc:1918::10:8:0:110/112
>=20
> Please try for yourself and post results.
>=20
> I can post any further details if required.

I'd like to see openvpn logs with --verb 4 of both cases.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--TSlk8RMAoVV44s7T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZQDijAAoJEB2Cnv7KVigSRaIMAJXvr9iQi4ibEZd0U3Z2Ypms
j0I17wrg+SVdCwRuuocqbxc98SfYAzq9bwRnmLpykdAq3UPjIvPja+yzw72P49pe
VrMZRgJVd6IDCbgHDV6pws+L1JjnbRNNhJLvROELonwg6ax9XWpaCpkEqhWmcbu8
ksQ3cNRUXyGbz4kDnc+E+5cVAXfrUAP1+cP67iVa4QSdbqPqRdYpgLcOQD1syS5b
fPcaU9hvz8dWTHFBGVynomH9jlTfuNTTydWNV0mj3uMnffgCJ5D5cT58mVVy5RSV
g7wdUeCYhx+I/iD1Ek4tbJG5RQXnS7FDdytLPYZLxwFy2Mp6/uSlfFfbFUT8YH0d
tqniZxMkHgYWv5oC7uJyY2Llhkq964X5Tgl2DLx9tDlJsG7P8+3U5rKi9cUODYtg
OriQYiY+nX/9Lqs6NoBeUuc0eZVWCiqhJKoJXCHc7pv5l5Ec1MIwBuBk9LlKK8cK
iMwmjJ/d2ddN3vihe8gDGAbrHPMZ7GXTbU903bYPbw==
=+4xG
-----END PGP SIGNATURE-----

--TSlk8RMAoVV44s7T--

