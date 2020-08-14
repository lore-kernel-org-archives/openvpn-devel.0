References: <20200813101301.12720-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <11b0fc14-72cd-4064-a25b-c0b267b59f09@...1227...>
Date: Fri, 14 Aug 2020 12:23:45 +0200
MIME-Version: 1.0
In-Reply-To: <20200813101301.12720-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HPwAXUOw8aT6jPcYotAcXhmKYxdt6UTRK"
Subject: Re: [Openvpn-devel] [PATCH] Fix stack overflow in OpenSolaris
 NEXTADDR()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HPwAXUOw8aT6jPcYotAcXhmKYxdt6UTRK
Content-Type: multipart/mixed; boundary="Qdlp6wiSEOZce6phO3MQsvmC4EWfocAAm"

--Qdlp6wiSEOZce6phO3MQsvmC4EWfocAAm
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 13.08.20 um 12:13 schrieb Gert Doering:
> Commit 5fde831c5807 fixed NEXTADDR() for all *BSDs and MacOS.
>=20
> OpenSolaris has to use a slightly different macro due to lack of
> sockaddr->sa_len - but it has the same problem, first rounding up,
> then memmove()'ing.  Switch order.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 24563ed6..f127a90a 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -3429,7 +3429,7 @@ struct rtmsg {
>  #if defined(TARGET_SOLARIS)
>  #define NEXTADDR(w, u) \
>      if (rtm_addrs & (w)) { \
> -        l =3D ROUNDUP(sizeof(u)); memmove(cp, &(u), l); cp +=3D l; \
> +        l =3D sizeof(u); memmove(cp, &(u), l); cp +=3D ROUNDUP(l); \
>      }
>=20=20
>  #define ADVANCE(x, n) (x +=3D ROUNDUP(sizeof(struct sockaddr_in)))
>=20

Acked-By: Arne Schwabe <arne@...1227...>


--Qdlp6wiSEOZce6phO3MQsvmC4EWfocAAm--

--HPwAXUOw8aT6jPcYotAcXhmKYxdt6UTRK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl82ZjEACgkQFRhsZwKx
RFS6bBAAqQIbdSkG8k749vOXtEO6E+/O9V0y2/5ICxI8MnjM/hVwU4MYVH1fugH7
jExRTo1jYIYa4qO+H9CrnruSyRsxwBPBfsjlmYMYdVsP7MKcCUxRYJf7Qjlm4G7r
E1lw2BwlBhsYCk5FNTqKNkNDn6kviToy4n0oH6iKR3qV2I9YrudO9IHf5HA73g7E
MHtvuaXfZFWbdWRkh252isglgiQ5yNMY17z/Iabj7raQj15yiCXPBsomqbuS/MTV
xfJ5eEItcowWLexub4ts6dIHQev0SV7/ZetB0Fndm7kIBnZ+46DwkClS7YxB0Yc5
/kiyYxWpKXe+Igy4YwpY7je6jd8/TqXruBBZSuL5LKerzXXIqR9tJQqcxCH8d9vj
UCWhYjxO+mtcpUPvPoCnV1X7DuZVtuLf0I0u+dWbb5xg0mKgEeGGyFQn1yQhTfRR
DmenNLsP9iG2EejdxQRZneuYlTDSFvAcrU5SDGQPzMVtO57g4FIDV3N47y2c5rEu
BA0zd76e3JHL6wBv01U3IF7spsYx9aURPcWrhiWE2CL+Kus6NScrj6DLCpowkg3b
8IXk7T2Jl3Oh+kLyP9N5nV9eSQV6hgylP0nzUnVaGFjCWgRmC0MZTG1ek1z1dYz4
qv/gm0WlGJezDYdKghHVzslpikekFjuUCl0u1SQ7ZSE/8Bpp8Ek=
=XA3F
-----END PGP SIGNATURE-----

--HPwAXUOw8aT6jPcYotAcXhmKYxdt6UTRK--

