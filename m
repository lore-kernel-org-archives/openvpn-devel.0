Date: Mon, 13 Dec 2021 20:22:29 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YbeddWFTDmQNHiES@...1296...>
References: <20211213150950.3993881-1-arne@...1227...>
 <202112131745.1BDHjt3H080577@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fXLvtEZZ4WdkEraX"
Content-Disposition: inline
In-Reply-To: <202112131745.1BDHjt3H080577@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Move deprecation of
 SWEET32/64bit block size ciphers to 2.7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--fXLvtEZZ4WdkEraX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 13, 2021 at 06:45:55PM +0100, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> As agreed on IRC.  2.6 will already make BF-CBC inconvenient to use
> (so, hopefully, more people will migrate off it), but let's not make
> it too annoying.
>=20
> Your patch has been applied to the master branch.

... and release/2.5

> commit 7f2d7dbf986fd7233eabb250b35bf7c3112d3e37
  commit 4e5e687fb63bb8cb72862c33775e88dec844c136 (HEAD -> release/2.5)

> Author: Arne Schwabe
> Date:   Mon Dec 13 16:09:50 2021 +0100
>=20
>      Move deprecation of SWEET32/64bit block size ciphers to 2.7
>=20
>      Acked-by: Gert Doering <gert@...1296...>
>      Message-Id: <20211213150950.3993881-1-arne@...1227...>
>      URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg23402.html
>      Signed-off-by: Gert Doering <gert@...1296...>
>=20
>=20
> --
> kind regards,
>=20
> Gert Doering
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fXLvtEZZ4WdkEraX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJht511AAoJEB2Cnv7KVigS584L/3njfY570Q60PYuKfRF6tC8W
VOgDRRFPESxssdtDk/DBcVeVtiLkEUvqm/qCT6IHBW46/t/h30irv+p8dtiRUpXJ
RoctZGbhQaYRxe6V3QjJJr65limgpPO5nmIKz7FL+3+Spoelp1WrJ9NpC7Dh2Oqy
0yQGb01hs15RdvjMYHTWiNKMkczjw5sUZsBaaJMzG8SeesqHNgeCr/MvfDmM9EQO
1DM0JzGP+8keZw5zuZIN1qOE+0JwUCOWbIv2hmMRwhanyHY53Kme4W22fpU6U4ER
kDxc8oZTYBa/2n7ZBzm+IYKoZdQY0c2Pyja3yF5Z5VQcsXMQHOc7azehSbEQ/by3
nbKEkbcplowjaohXHm5+idpXukU7Mk+G59R6NX1tRgZ4ELoJDgVE9/Z/EEP+u6KE
C12tAbg/Kcvx3GqmUHHgPmUzsWiO4MTGjDRSflg15y6P35xdv+bT0GFPjaioYd6v
qk81FR+GuS271+eLzW4ibogvAmSG/55FD8SLNKNa/Q==
=x+tu
-----END PGP SIGNATURE-----

--fXLvtEZZ4WdkEraX--

