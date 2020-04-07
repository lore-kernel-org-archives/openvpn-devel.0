References: <517c16b8-b552-8728-2e73-5f7bcc149953@...1227...>
 <20200407174436.238933-1-wgh@...2548...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <23efbb49-96eb-bb79-faea-34c20291cd66@...1227...>
Date: Wed, 8 Apr 2020 00:38:45 +0200
MIME-Version: 1.0
In-Reply-To: <20200407174436.238933-1-wgh@...2548...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aZwMkzRF0bWq8om8hpjqhd3BIdyOsV9TS"
Subject: Re: [Openvpn-devel] [PATCH v2] OpenSSL: Fix --crl-verify not
 loading multiple CRLs in one file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: wgh@...2548..., openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aZwMkzRF0bWq8om8hpjqhd3BIdyOsV9TS
Content-Type: multipart/mixed; boundary="B4fReekdBErdkUmvLkY79kW1YOoRpv8o1"

--B4fReekdBErdkUmvLkY79kW1YOoRpv8o1
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 07.04.20 um 19:44 schrieb wgh@...2548...:
> From: Maxim Plotnikov <wgh@...2548...>
>=20
> Lack of this led people accepting multiple CAs to use capath,
> which already supports multiple CRLs. But capath mode itself
> is somewhat ugly: you have to create new file/symlink every time
> CRL is updated, and there's no good way to clean them up without
> restarting OpenVPN, since any gap in the sequence would cause it
> to lose sync[1].
>=20


>=20=20
> -    crl =3D PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
> -    if (crl =3D=3D NULL)
> +    int num_crls_loaded =3D 0;
> +    while (true)
>      {
> -        msg(M_WARN, "CRL: cannot read CRL from file %s", crl_file);
> -        goto end;
> -    }
> +        X509_CRL *crl =3D PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
> +        if (crl =3D=3D NULL)
> +        {
> +            /*
> +             * PEM_R_NO_START_LINE can be considered equivalent to EOF.
> +            */

Minor whitespace problem.

> +            bool eof =3D ERR_GET_REASON(ERR_peek_error()) =3D=3D PEM_R_N=
O_START_LINE;
> +            /* but warn if no CRLs have been loaded */
> +            if (num_crls_loaded > 0 && eof) {
> +                /* remove that error from error stack */
> +                (void)ERR_get_error();
> +                break;
> +            }

Minor style problem. { should be on the next line.

Acked-By: Arne Schwabe <arne@...1227...>

I leave it to Gert/David if they want a rev3 or fix the minor
style/whitespace problems on commit.

Arne


--B4fReekdBErdkUmvLkY79kW1YOoRpv8o1--

--aZwMkzRF0bWq8om8hpjqhd3BIdyOsV9TS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6NAPYACgkQFRhsZwKx
RFRf5hAAsUM1wAohIMlJFijmvJ6t7bokyoytohUjKzj+3ndIaWkoRjRAiJhq+ZQU
wJzoZTl3QrZOn7GFyV0Qi7M+pHvecW6nsPWRdfPTh9aEtv4RfeeN7PtJTfKmKS/f
qbNRzHIAe16Hc1Gm1Ect1S1sn0mQl+ci0wLSVmp51gfHTSleNdHTxtkrv5mJ+u5F
yn4x1GXibOBs9iUNSlex3RrT81HtqSIJnTvi5DRaTfOiZN/cR/Q+zMTTb19ZVU2E
KekMzfzL5lcziV3M1Jh4SGBA2ysH7o3u2+rVfV2xQ106fBUyYAbaSR6CGs0qKbbB
Uw5YXDn5/FMqG1RPWSUv4Js03YVzSSy9yJyxJEqYa9DrBUikm38r0R307HsVERT2
9LwjjNOs5gADIzJjUo/ceYjnmpMsmTR8ZPI+wFWpXwRnCTj9EqIXzV+eXGyL8bpm
pn3Ook3Xl7J/XG+vhBaM0HxQWvFM95ad2z1dL9j/bip5PSo84s2rYO/CBqKyjKHw
0E5Jh9Ish/D7NkeVUyysIbx5Kfs5L8UGssLaPj1AMR108ZjzM6v/tLGqC77RpJHo
FRs6WILPdLzaUOBWECM3BYrDNOTJb6iOvA2HMZDJPVjw01cM9m51jsqQfYb5O5nw
WfqqTpJN7rUY0g0SVq73AvULhFxkIiJZmwyl5D3kekPIhOBpbhA=
=430o
-----END PGP SIGNATURE-----

--aZwMkzRF0bWq8om8hpjqhd3BIdyOsV9TS--

