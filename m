References: <20200620172303.15010-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <8ab1d669-b03d-3bdf-96ed-9f414e38bfa5@...1227...>
Date: Sat, 20 Jun 2020 20:35:30 +0200
MIME-Version: 1.0
In-Reply-To: <20200620172303.15010-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jy66C7V6UlweMw6kTuIBS6YsxlhauxTpE"
Subject: Re: [Openvpn-devel] [PATCH] Change timestamps in file-based logging
 to ISO 8601 time format.
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
--jy66C7V6UlweMw6kTuIBS6YsxlhauxTpE
Content-Type: multipart/mixed; boundary="y9pgFLo0DM2vDO3wnU7AJ7SnUCUcbE34Y"

--y9pgFLo0DM2vDO3wnU7AJ7SnUCUcbE34Y
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 20.06.20 um 19:23 schrieb Gert Doering:
> Replace existing ctime() output which is hard to sort and compare
> with ISO 8601 / RFC 3399 "YYYY-MM-DD hh:mm:dd" format for file-based
> logging (stderr or --log file).
>=20
> RFC 3399 5.6 permits use of a space for full-date-full-time separation,
> which is used to enhance readability.
>=20
> Sylog or --machine-readable-timestamps are not affected.

you mean machine-readable-output?

> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/otime.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
> index 759a7fb5..28683459 100644
> --- a/src/openvpn/otime.c
> +++ b/src/openvpn/otime.c
> @@ -127,8 +127,11 @@ time_string(time_t t, int usec, bool show_usec, stru=
ct gc_arena *gc)
>      }
>=20=20
>      t =3D tv.tv_sec;
> -    buf_printf(&out, "%s", ctime(&t));
> -    buf_rmtail(&out, '\n');
> +    struct tm * tm =3D localtime(&t);

should be *tm

> +
> +    buf_printf(&out, "%04d-%02d-%02d %02d:%02d:%02d",
> +                tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
> +                tm->tm_hour, tm->tm_min, tm->tm_sec);
>=20=20
>      if (show_usec && tv.tv_usec)
>      {
>=20


ACKed-By: Arne Schwabe <arne@...1227...>


--y9pgFLo0DM2vDO3wnU7AJ7SnUCUcbE34Y--

--jy66C7V6UlweMw6kTuIBS6YsxlhauxTpE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7uVvMACgkQFRhsZwKx
RFRgWg//dLfTtz95emC/lzKvwsSJUlbXMSLKPY2znXhGIwxXpAgNCBXmNHt2KWVd
BmUpYoD4eUEcOwnJ1894ej4mYzGKbYOCja3dp5dWXT0oP8Hoh9hCZ3BQb4o/U6yO
PQ89NejZ0H6Kiz/42np3CAALm4R3Oq02z+C2LLZxEaDNLV/0a6QLTaSeNkXZ42QT
eJQcQsAzZPfaRnqCA2OYPDFwEPbnxZfJv5X5MI28D13krEOX0MbKxJMe/VL5dmno
r6KNnncEEN9fx/fYBq8CiLttyMzXT6nNz+3bTBttQbl2CQmP5NHlWBmqPF0o3xe5
5SEjcGvOa7G7dw+Vno+cvGbtkpPkJknib388cUeBulJbY3FW4KD3Q9gFe+sxNYuR
1SAX7D1sk8woaIA6qrNoeVj35cfcHiMEqaiCC5q6AO6QQETJ5zqY76IBEd8cv1Il
XEebbutBjys5nboSsCi1HuVN9MgOWDd9fGEtVYecoNURQGQivzHGFSOPkCH5XWpI
5WyzPYTxIFoEcAgpKuk5CKSF8NfumtLkxXNl3IZeVtrTjXlGy2avtjmg2iEK0NjJ
vrUiIH2N21X7+9hNmTKbTUNuujuRxcf+e436s8v60Hl7ovZbgdaU9pgLkZLWOhhp
zLf+RsCeXVPi+yjpPsWWXCrnDydE0dDwPsaH4ctEh/HrAOswBKo=
=b2+E
-----END PGP SIGNATURE-----

--jy66C7V6UlweMw6kTuIBS6YsxlhauxTpE--

