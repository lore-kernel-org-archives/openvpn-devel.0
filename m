Date: Wed, 17 Aug 2022 16:58:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv0CHd2TYMtR9xk3@...1296...>
References: <20220817110319.195-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="h2Bly7rxSUQUpb6I"
Content-Disposition: inline
In-Reply-To: <20220817110319.195-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] dco.h: fix return type when DCO is not
 enabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--h2Bly7rxSUQUpb6I
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 17, 2022 at 01:03:19PM +0200, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
>=20
> The correct return type for those functions is int,
> so adjust return type accordingly for the cases
> when DCO is not defined.

The change is fine, but you only go halfway...

> ---
>  src/openvpn/dco.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
> index 6b5c016a..04556471 100644
> --- a/src/openvpn/dco.h
> +++ b/src/openvpn/dco.h
> @@ -292,7 +292,7 @@ dco_update_keys(dco_context_t *dco, struct tls_multi =
*multi)
>      ASSERT(false);
>  }
>=20=20
> -static inline bool
> +static inline int
>  dco_p2p_add_new_peer(struct context *c)
>  {
>      return true;

Here, you change bool->int, but leave "return true"...

> @@ -310,10 +310,10 @@ dco_remove_peer(struct context *c)
>  {
>  }
>=20=20
> -static inline bool
> +static inline int
>  dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *m=
i)
>  {
> -    return true;
> +    return 0;
>  }

... here, you also change the return to "int".

Can we have this consistently? ;-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--h2Bly7rxSUQUpb6I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/QIdAAoJEB2Cnv7KVigSb7EMAK8y88e5S3ZSs8GGP3iBvQfE
EgpWuaAilSv06RXk3PrfI2LHKPxx2iv7JbS8aQoOTsleqcg8R+WaS7NzltYcNHGV
PzmkzL2IMmmizeTJ93i27+HvBbdlTB+R12vDnro4idtxw/SyT1H9o4fnTtnxWzDO
puilSNpM0jN7w/drytApdlvamtBMucuI2f0xiJbT1TE7G4Ff5cW7AFFm6hooroaD
ekmY5BcfAoCzahjgJxNvKchd6hzkaoay23STpIELCVlDQHERu0uxsZm56p3KXnAZ
ejM1UzTaMrrLCEmEtB8VxDvKG9BPH4XZhnbc0n2tpzNpECY0cKNTKlekwx/QGnfv
Fga9touelH9+/oB3jByslEpieacGgY0OEnLDdZh4wJmkdGkrL6QeFksrkXicaIva
gy00gd2CrQvHckP6KrfQILdd+doVFwe8bOwTX6GLI90IbhQU6rPPg61542TNrTBO
rkzNO3Qsckv0mkCVi0hEL0ZBxFbEqstSKMbQHUPoJA==
=/PYd
-----END PGP SIGNATURE-----

--h2Bly7rxSUQUpb6I--

