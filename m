Date: Mon, 13 Jul 2020 13:29:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200713112936.GW1431@...1296...>
References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-3-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7b5wnLVo/FaPS9m3"
Content-Disposition: inline
In-Reply-To: <20200711093655.23686-3-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5 03/14] client-connect: Refactor
 multi_client_connect_source_ccd
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

--7b5wnLVo/FaPS9m3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 11, 2020 at 11:36:44AM +0200, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
>=20
> Refactor multi_client_connect_source_ccd(), so that options_server_import=
() (or
> the success path in general) is only entered in one place within the func=
tion.
>=20
> Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>

All server side tests passed

23...
Test sets succeeded: 1 1a 1b 1d 2 2a 2b 2c 2d 3 4 5 6 8 8a 9.
Test sets failed: none.
24...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 4a 5 6 8 8a 9.
Test sets failed: none.
master...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 5 6 7 7a 8 8a 9 =
2f 4b.
Test sets failed: none.

which is NOT a conclusive test in this case, because I do not have=20
clients setup with ccd/DEFAULT here.  So this is more "it does not break
anything else".


I do not like the indentation and wrapping, though:

> +        const char *ccd_client =3D platform_gen_path(mi->context.options=
.client_config_dir,
> +                                                   tls_common_name(mi->c=
ontext.c2.tls_multi,
> +                                                                   false=
),
> +                                                   &gc);

instead, maybe this?

> +        const char *ccd_client =3D=20
> +             platform_gen_path(mi->context.options.client_config_dir,
> +                               tls_common_name(mi->context.c2.tls_multi,
> +                                               false), &gc);

or maybe we want to extract "tls_common_name(..., false)" into a temp
variable here?=20

> +        const char *cn =3D tls_common_name(mi->context.c2.tls_multi, fal=
se);
> +        const char *ccd_client =3D=20
> +             platform_gen_path(mi->context.options.client_config_dir,=20
                                  cn, &gc);


gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--7b5wnLVo/FaPS9m3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDEWfAAoJEB2Cnv7KVigSOw8L/iDSA+0NBwn4h94ufVAyj8Az
Xih08vrk9sDwwWVImYB7+IBXXPjpz8At8z10Z0dkgvV42ExNj+kW5tILS5hK/urp
66UfoIYR0S16eyA5ABhVvszWYjYEDrZKLIQ8IUJvWAeKpRFeJya4LlZcfFGDsJq1
11nB1yCZq4LhIG4hvAcleRwUJwIPxUgXxsB6e6V9IbG6Q6VAuZMELR8mqEwiwjjw
vLoUR7KMsmQw9s9zwtLVUNPsQ6PMuiD+02SfR1nv63q+VGsOcpLZ1gwo0nIqFIaj
o2+JcTFsu83zv7zBX5KCOcUAUHuydtVD68IfC6Hegb4ljhQ/2L5OdG9lx+xOEt8g
k6HAn63l+mcAsJ6lMOzHJjGO8tT95/IisIeRSuVpYLi3fh0Jx+yTttfmmxuHbevA
SgrreesZ5PvoDe/8citU0cFvKB+AwCuQUYMtNvXsydxhg/qHPyfqvNgbYXwcPjOl
/kx+qbjYv0yBMgMirKZKJ1qZrKd/76jC5sfDbkD5Ew==
=tGRu
-----END PGP SIGNATURE-----

--7b5wnLVo/FaPS9m3--

