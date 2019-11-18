From: Arne Schwabe <arne@...1227...>
References: <20191117181243.28919-1-arne@...1227...>
 <20191117212318.13428-1-arne@...1227...>
Message-ID: <50f7e1b9-e443-3efe-af8e-1eb5b8d2e082@...1227...>
Date: Mon, 18 Nov 2019 09:45:03 +0100
MIME-Version: 1.0
In-Reply-To: <20191117212318.13428-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WlWpu2eBF9KYICqIRHgD3KY3VBGK4dEFy"
Subject: Re: [Openvpn-devel] [PATCH 5/4] Add ncp files to Visual studio print
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WlWpu2eBF9KYICqIRHgD3KY3VBGK4dEFy
Content-Type: multipart/mixed; boundary="fhhFHP3WYApQUY5vjd29qL6I3ZdmZGVxu"

--fhhFHP3WYApQUY5vjd29qL6I3ZdmZGVxu
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 17.11.19 um 22:23 schrieb Arne Schwabe:
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/openvpn.vcxproj | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
> index 7446d97d..b3d35ba2 100644
> --- a/src/openvpn/openvpn.vcxproj
> +++ b/src/openvpn/openvpn.vcxproj
> @@ -191,6 +191,7 @@
>      <ClCompile Include=3D"socks.c" />
>      <ClCompile Include=3D"ssl.c" />
>      <ClCompile Include=3D"ssl_openssl.c" />
> +    <ClCompile Include=3D"ssl_ncp.c" />
>      <ClCompile Include=3D"ssl_verify.c" />
>      <ClCompile Include=3D"ssl_verify_openssl.c" />
>      <ClCompile Include=3D"status.c" />
> @@ -276,6 +277,7 @@
>      <ClInclude Include=3D"ssl.h" />
>      <ClInclude Include=3D"ssl_backend.h" />
>      <ClInclude Include=3D"ssl_common.h" />
> +    <ClInclude Include=3D"ssl_ncp.h" />
>      <ClInclude Include=3D"ssl_openssl.h" />
>      <ClInclude Include=3D"ssl_verify.h" />
>      <ClInclude Include=3D"ssl_verify_backend.h" />
>=20

Note this patch can be merged into the 4/4 patch. I just did not want to
resend 4/4 for this tiny patch. Should a V2 of 4/4 be needed, I will
include this one into it.

Arne


--fhhFHP3WYApQUY5vjd29qL6I3ZdmZGVxu--

--WlWpu2eBF9KYICqIRHgD3KY3VBGK4dEFy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl3SWg8ACgkQFRhsZwKx
RFSPVQ/9HT8eJ8f3KpxqTxwK5sQdDTe9mE+/2FFKTS8MLBus99Ompz0ZLBG/AaPF
/dzAx/wCE64QP0CNDjOTHaZtBdjjkgCMWI1jZnhiDyS+y3sHYUIoFT/mzFW30PmJ
L41k2VzzSTYVz9Povf8yaMsVb3+Eqs0bM6+GZOnpsEwy4OIxXV47+Mj4ZE+s9AJd
zX5rQyuSy1WvP3OYOj6p5Lugy7RaW6eVzpNZhfc5hrxHsENTkRHBJg8d2c6AUQVy
1wcIpa5zb4hHU5in6eRwEKvzGi2vAYO2ZEkMMe++n0wrfyEG2Q3jBKlojTcnVjfA
xrk9bE15fzlVPIEE35z5bUlooiFZ7Motb7KrwmIaErBRWCfwfe7Dv0qfvQvcsJ0y
Udosrz45xd2Rg3uAnAZ2n/Vr5c1CCyqQGzM3crWOYaK3kYLlNArEPXe7CIU+a/M9
Jwxm6OlocXty7Xyo1rLT4GB4us942uJklK55PgkvHhUiIIwmMxPdz9puNqNJMVOG
738h0XVgv37NnOn5GSjkNlIZ8Pur6gLZWLrloWM6cBCGmTnKFsZmiGnoOAbGBPVM
reZsW/lpfLAhcxgZXRqkR1rUTw9jqv7jE+03YhyAtVVY4IjJjvAvZgyx1pf09pPl
njK36VwiBupjd0mS6c9TAV/eBq402pujHoQgUATSev1N7qxCC+U=
=NMJI
-----END PGP SIGNATURE-----

--WlWpu2eBF9KYICqIRHgD3KY3VBGK4dEFy--

