References: <CAL3L06F7YvNHSFxWXrMFZf_8fSjmCH-RkMn1GXmLu7cW-G1=nw@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <d2d272dc-c058-deb1-eb3b-e850d833e326@...1227...>
Date: Thu, 1 Oct 2020 14:23:00 +0200
MIME-Version: 1.0
In-Reply-To: <CAL3L06F7YvNHSFxWXrMFZf_8fSjmCH-RkMn1GXmLu7cW-G1=nw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R0vQzsuC0RDD9fJv4F5fYbWLQNB26TdjM"
Subject: Re: [Openvpn-devel] [PATCH 1/1] Exit management interface loop
 early on receiving 'remote MOD' message.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Daniel Kaldor <daniel@...2518...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R0vQzsuC0RDD9fJv4F5fYbWLQNB26TdjM
Content-Type: multipart/mixed; boundary="jAlNgB2cIo2f4JmDfzpXznQmbbYmrUvd4"

--jAlNgB2cIo2f4JmDfzpXznQmbbYmrUvd4
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 03.07.19 um 16:50 schrieb Daniel Kaldor:
> OpenVPN using management interface and running with
> 'management-query-remote' in the config will wait for a 'remote MOD'
> or 'remote ACCEPT' message before continuing with connection.
>=20
> Logs indicate that this stage of the connection process currently
> takes ~1s to complete.
> This seems to be because the management interface polling loop is
> being run once unnecessarily after receiving 'remote MOD' message, and
> is only exiting after 1s timeout is reached on final polling loop.
>=20
> This change exits the polling loop early, immediately after receiving
> 'remote MOD' message and removes 1s delay in connection.
>=20
>=20
> ---
>  src/openvpn/manage.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index 2d86dad..7343e8b 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -3348,7 +3348,13 @@ management_event_loop_n_seconds(struct
> management *man, int sec)
>          /* run command processing event loop */
>          do
>          {
> -            man_standalone_event_loop(man, &signal_received, expire);
> +            int status =3D -1;
> +
> +            status =3D man_standalone_event_loop(man, &signal_received, =
expire);
> +            if (status > 0)
> +            {
> +                return;
> +            }
>              if (!signal_received)
>              {
>                  man_check_for_signals(&signal_received);


I have no doubt that the patch fixes your particular problem but it
modifies the management loop to exit early for all commands and this
feels it could cause trouble for other commands. Did you test anything
other your use case?

Arne


--jAlNgB2cIo2f4JmDfzpXznQmbbYmrUvd4--

--R0vQzsuC0RDD9fJv4F5fYbWLQNB26TdjM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl91yiQACgkQFRhsZwKx
RFQXsg//QqTpP9vUKQs//rbdd6ZqRmO2TGYXBqxZ89A4R0gwtlhnQLbET5DlZDnb
X9KwL6oPe0duLR5c1UpJ8GXGvCm71yXJD3Sp2T0ka1t6XpSTEFiSVpLmdiwLiNDB
lslbrd6N0mbq7pD5RltD0Pvp3Lpfabk/Td1208t8UTsAmauzFzxF5tlK64ZchO/q
sDti5Af/w+Oyr7HNN3ohNCXs6bUnb1KtnAGlNhP9In98r3Xcehu1WJLaGuv7ZLws
dbKnsiUfMlXTvfUxBLKrD0XVW2h42yMBirRrqZbWe07WeGkAY1DJkHFn3umIfknf
xinBNm8qwdiLcDl8v2MzAmGeeuR+bWC6cdy2KJ3wQ9h9ucGEQXqHVpR5+65FvGnf
dvmPN2FltICsfaBXQPvCeiA9XLXJmJEDTpQElnEN9rVdUM4TqXIasIpbDRG82g9M
fDIx2ZhABmDiCDVlq2QdWzLFbNLcpUBDhfOhaZ8iW/mUq0OIRLpiTfrMdCpknYL3
5hyLS1NkpO9Lv5jJGi302zTeaAxxRffRX0ffIwxOwxY7HPPjg75uNC8i8A3TTnS1
NaNNMZFC8oy88lPTdcR8tv/HOBC7oJQbE86gf3irRFof+Cf7it+C6NjFZS/27Sfb
WjOXJjBhz3UHnn92nnShtGzVt2bVS3ogOJ3YbK6PYNxV56x5OWw=
=yFOo
-----END PGP SIGNATURE-----

--R0vQzsuC0RDD9fJv4F5fYbWLQNB26TdjM--

