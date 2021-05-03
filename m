Date: Mon, 3 May 2021 08:07:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210503060713.GS976@...1296...>
References: <20210422152939.2134046-1-arne@...1227...>
 <20210422152939.2134046-2-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tD+52D5dwtL9g9C+"
Content-Disposition: inline
In-Reply-To: <20210422152939.2134046-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/6] Remove --disable-multihome option
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

--tD+52D5dwtL9g9C+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 22, 2021 at 05:29:35PM +0200, Arne Schwabe wrote:
> With this change we always build multihome support if the operating
> system supports it.
>=20
> Patch v2: Remove also from config-msvc.h

> diff --git a/configure.ac b/configure.ac
> index 747325164..aaac65c3d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -121,13 +121,6 @@ AC_ARG_ENABLE(
>  	[enable_fragment=3D"yes"]
>  )
>=20=20
> -AC_ARG_ENABLE(
> -	[multihome],

This is missing the second hunk in configure.ac

test "${enable_multihome}" =3D "yes" && AC_DEFINE([ENABLE_MULTIHOME], [1], =
[Enable multi-homed UDP server capability])

otherwise, ACK.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--tD+52D5dwtL9g9C+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgj5MPAAoJEB2Cnv7KVigSvb0L/3Ru5gRX+5B6khSAZx/7VkEc
mjxu4CgY9Gq+td80qjn68soV/I/Vl3woDDUjPpMranscJYVjMGT+ck9AO7+L+WNp
GuZWC+UpkPYh8WdA54UA0rcVl7ZihPg94OjgnB1RJqXT/I03o4iOuVvizmQob7+N
fy59+rlhBN2VFOkJaQe5eOlwp0U3ICEt4qqi7+cCrb5PlXeMpmE5tjyxVNtzLUsE
PX0lf+H/CW8I8jrTG7e24hKzJsVU1UXJwACtuC3tUF4ccHMSHIwb9MfyuXWGK9FF
TlF0JduXczI+gqxpc5SQl+fymslpVTIeTv3EHbutiaVTGVcLlOkKhOZwdVDs+U3B
xLyhsrsX8WSK4PRinaqGyn7PmtdqTxqlQRBUTXBT+lK+TaC9tcIQeNOnJfr77riS
aDcsJtUTx/3O+gDr2HXKN4T1ccmAMM5TDYc04Alhm6SBY0gac34N1jq0sA158eDA
oDknACpESYi3MEZyO+AzIUQjflxXXuOs3SdNGqiTTg==
=A6fc
-----END PGP SIGNATURE-----

--tD+52D5dwtL9g9C+--

