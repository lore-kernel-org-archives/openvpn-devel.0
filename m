Date: Wed, 14 Jul 2021 15:43:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210714134334.GV976@...1296...>
References: <20210714131810.9473-1-david@...2627...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lBS4q6SUC22VAoMG"
Content-Disposition: inline
In-Reply-To: <20210714131810.9473-1-david@...2627...>
Subject: Re: [Openvpn-devel] [PATCH] fix memory leak in add_route_ipv6.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: davkor <david@...2627...>
Cc: openvpn-devel@lists.sourceforge.net

--lBS4q6SUC22VAoMG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

thanks for the patch.  Well spotted :-)

Two things:

 - I see that the code in add_route() is the same...

    struct argv argv =3D argv_new();
...
    if (!(r->flags & RT_DEFINED))
    {
        return;
    }

   so while at it, please send a fix for both places

 - if you want, please set your username in git, so it shows a "real
   name" (right now, we have "davkor <david@...2627...>", which
   might be intentional or not)

gert


On Wed, Jul 14, 2021 at 02:18:10PM +0100, davkor wrote:
> ---
>  src/openvpn/route.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 56fa7717..3b2af8b4 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -1891,6 +1891,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct =
tuntap *tt,
>=20
>      if (!(r6->flags & RT_DEFINED) )
>      {
> +        argv_free(&argv);
>          return;
>      }
>=20
> --
> 2.17.1
>=20
> ADA Logics Ltd is registered in England. No: 11624074.
> Registered office: 266 Banbury Road, Post Box 292,
> OX2 7DL, Oxford, Oxfordshire , United Kingdom
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

--lBS4q6SUC22VAoMG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJg7uoGAAoJEB2Cnv7KVigS27kL/3l1cSYTHASIydALZpNnHdHU
4uI1+HkvnK6hIIuac9WeNiYOCsIk0hLuEtklTfNZcW5xphrHP2XsLBRuXfVy2NWy
FDj3Z0KJKkD94czRAkiIlBQtOg0Vlo/PJ1p9BAmE4LphIGFEs3EHzEr4IhXuuCsn
ZTLKiAV3wKkQKeNcj0fNkVouJaVmhuiL/UuxfrVjn73cR6vM3KI6J/9c+AINe7m8
07qO9l+CdXS6OCwHn32ST3WjHaxGh4h7qIyvZOjZmHMiRPfh6ks028ipowqdtexI
xsGNobiFQZqN6WaNV/i/nvKd+zx20gD+MQRZWn5TdGxC5S3omUhW9mwET3UR4HRh
MevKGzAvuRg8Ji+zM/9sj0yiqysGIrj8Xb8NJ7IVAxwt40SdUVfbwLCHw/Cuz+FB
vKOIrJZhealMSQjauiOPtiGStDI1u4BW+o9HWue2vmpq7tE4WWOHZNYyHuW2oC3i
BCGWmAKKDoQgUstXzIOo+8uqEgoJDSgdHJ3kr5GPxA==
=fnua
-----END PGP SIGNATURE-----

--lBS4q6SUC22VAoMG--

