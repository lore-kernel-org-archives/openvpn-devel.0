References: <84a29b8afab02733064c2cf715ae0b8c.squirrel@...2257...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <f27fb070-c84e-2319-2db5-b0cda50fe3c9@...1227...>
Date: Thu, 1 Oct 2020 14:10:28 +0200
MIME-Version: 1.0
In-Reply-To: <84a29b8afab02733064c2cf715ae0b8c.squirrel@...2257...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dwPgmjRRRygYSweeLGOFvQeRDdMzDozAl"
Subject: Re: [Openvpn-devel] Add --up-pre with the same functionality as
 --down-pre
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dwPgmjRRRygYSweeLGOFvQeRDdMzDozAl
Content-Type: multipart/mixed; boundary="rm9wG3sRO003b1eSLV8NcZERkP5XZyTom"

--rm9wG3sRO003b1eSLV8NcZERkP5XZyTom
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 22.11.17 um 17:58 schrieb Simon Matter:
> Hi,
>=20
> In our situation we have the requirement to run scripts before tun/tap is
> opened, not after. While this could be hacked into the init script, the
> proper way seems to add it to openvpn as --up-pre option. That's
> independent from any init scripts / systemd service file and works the
> same way as --down-pre, only for the up status.
>=20
> My initial feature wish, posted 5 years ago, was turned down as won't fix:
> https://community.openvpn.net/openvpn/ticket/284
>=20
> But there are people who wish it and they have good reasons to wish it.
> Just yesterday someone asked again:
> https://community.openvpn.net/openvpn/ticket/284#comment:10
>=20
> Without going into much details

This patch currently misses a commit message anyway but a good commit
should explain why this change is a good one.

> just one thing why --up + --up-pre is
> better than hacking around outside of openvpn: the command called with
> --up also gets additional run time information from openvpn by parameters
> and environmental variables. You don't get all those information when
> calling anything from outside of openvpn before openvpn actually starts.
>=20
> If you feel there are good reasons to still refuse this patch, please let
> me know.

I am just looking at this patch since it is still in the review queue.

- Missing documentation.
- pre-up flag is wrong in terms of scripts. If we add this, it needs to
be a different script because otherwise you will break use cases that
also need the --up script.

Also having down and down-pre but then only not also up/up-pre but a up
with flag breaks the symmetry and is confusing.

Arne


--rm9wG3sRO003b1eSLV8NcZERkP5XZyTom--

--dwPgmjRRRygYSweeLGOFvQeRDdMzDozAl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl91xzQACgkQFRhsZwKx
RFRjphAAizBq0wquU2YjUUvg6RwAsaBu+mouOa3wnkP2GIlAycch3f8p8MJ++HNw
nFJR6B6UnB3E6J6mVVPRFyKk3/zLCwlHWLifUu8UaCEQn/8N5uaPL2RKiCc3l/zj
dnIETv/+D9nKjq/8D5ckhnMG4Yjt1xqalCbF40m1f4o8c7BP/hJDvLjOamTu4MrY
8VyPP7e9Ryvef0RS/iad0/7rYDhX1sUlJ9pyoPMMWtRL8TksAFfWgZULPakf9+Tb
ozyFTkoUx6mlorGkWyU4jk75L7JQvMn5v0UHil+Abr5Hlk1uNHb60Q6bqOwZv9bM
LxuFhdGXbN+/m0wXw7h8NzcwtpQ89X5PWMF2k0TkJitXqHtACrwNu7H5FqRIWc7/
oYaloZcFU4taVMM8j6LpabzRzYD57Np80XFLO8zm+dsV5bzScnIWidI9wLSu05oK
RYw8r+JUkWn/CuTNAXVhBGFUbRTPyBOd7tP2DkSyULBivSvKUMm10qcy6ngPPRXZ
5zClLZUaENjxzBt5LS7BJI0iYMh0M8kJ50qQPd0V5cSg5SCPtHzb4FSk/wbaodSK
p9V7R4OIk5dCdLJ0vjJUu5CCruv/CHS47YpgrJbjKhQTVoTN2AsTWC113drKqcsp
JP/GMkvcODywSnwiYMPnt73SOwO7eaQKaE5twptdqX42YwsZxbY=
=k+5H
-----END PGP SIGNATURE-----

--dwPgmjRRRygYSweeLGOFvQeRDdMzDozAl--

