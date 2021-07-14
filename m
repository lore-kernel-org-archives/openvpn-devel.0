Date: Wed, 14 Jul 2021 18:22:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210714162226.GW976@...1296...>
References: <20210714134642.12964-1-david@...2627...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jobVe3EmAg0DF5Ew"
Content-Disposition: inline
In-Reply-To: <20210714134642.12964-1-david@...2627...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid leak in add_route.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Korczynski <david@...2627...>
Cc: openvpn-devel@lists.sourceforge.net

--jobVe3EmAg0DF5Ew
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 14, 2021 at 02:46:42PM +0100, David Korczynski wrote:
> Signed-off-by: David Korczynski <david@...2627...>

This is good :-)

> ---
>  src/openvpn/route.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 3b2af8b4..e429e8c0 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -1584,6 +1584,7 @@ add_route(struct route_ipv4 *r,
>=20
>      if (!(r->flags & RT_DEFINED))
>      {
> +        argv_free(&argv);
>          return;
>      }

... as is this.  Can you send a single patch that contains both fixes?

We try to make patch granularity a good compromise - not too many=20
individual patches, so "two one-line fixes for the same problem" would
go into one common patch, not two.

thanks,

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--jobVe3EmAg0DF5Ew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJg7w9BAAoJEB2Cnv7KVigS8woMAI6t6BrfpbaohYrWxE1iapto
CtQxfkFNBNui8947rdIXfZ6ay6g7QpPJtTv3DD3r8eu5oaeIbTksF9EfWGh77ddP
uvDLVGciv8VFf4c09DpfF3xM6k4dDHlKJIddnOU2TXxRInxkRwCMoK0QFGqdpFyl
e9hNP2Ef2AmZ30Yjr3ir3m2TXwpfOtSe1F5EBFYxg9rqQMnAnu+ddrJADO73oeUT
Ej3sZMq8HzjBIHHs9I2xNQDO4ednFqS+xcr+jggCdyh2XpPBD6MGkdyampJnuAZf
w1T6co5lnfR2bATHmABwSqvANKHQgl9W4iy+tFqttVrWVcRnivmDXQAJFw1jjzAD
WUSg9vq6+R3rUOKuZAw+7xw4wTLsNF1AJXmiFYChRiF5dvfEjTZudgCAcWywKHTf
wvSAeiXHrzhjr+CSWxBLjlgryEEt57+w257SxXzSxPYQ8pXloHAeqwT5a4WBn1Fi
BD5PXb2LIPhUVECwQJhXFDaGxJ783ZICKiuA+BK4tw==
=C55o
-----END PGP SIGNATURE-----

--jobVe3EmAg0DF5Ew--

