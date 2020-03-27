References: <20200309135133.GA1431@...1296...>
 <20200312113654.16184-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <536e526e-30c0-c1a1-aff6-1681a9210d7a@...2080...>
Date: Fri, 27 Mar 2020 16:19:35 +0100
MIME-Version: 1.0
In-Reply-To: <20200312113654.16184-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6VAoLyfGtOGCNwkRCuPVF8Pk5WaJsflnX"
Subject: Re: [Openvpn-devel] [PATCH v6 5/5] Normalise ncp-ciphers option and
 restrict it to 127 bytes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6VAoLyfGtOGCNwkRCuPVF8Pk5WaJsflnX
Content-Type: multipart/mixed; boundary="vQqElskgbqfy07XsRpNhB2KITnaJnVM4R";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <536e526e-30c0-c1a1-aff6-1681a9210d7a@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v6 5/5] Normalise ncp-ciphers option and
 restrict it to 127 bytes
References: <20200309135133.GA1431@...1296...>
 <20200312113654.16184-1-arne@...1227...>
In-Reply-To: <20200312113654.16184-1-arne@...1227...>

--vQqElskgbqfy07XsRpNhB2KITnaJnVM4R
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 12/03/2020 12:36, Arne Schwabe wrote:
> In scenarios of mbed TLS vs OpenSSL we already normalise the ciphers
> that are send via the wire protocol via OCC to not have a mismatch
> warning between server and client. This is done by
> translate_cipher_name_from_openvpn. The same applies also to the
> ncp-ciphers list. Specifying non normalised names in ncp-ciphers will
> cause negotation not to succeed if ciphers are not in the same form.
> Therefore we will normalise the ciphers in options_postmutate.
>=20
> The alternative and a lot less user friendly alternative would be to
> bail if on of the ciphers in ncp-ciphers is not in its normalised form.
>=20
> Also restrict the ncp-ciphers list to 127. This is somewhat arbitrary
> but should prevent too large IV_CIPHER messages and problems sending
> those. The server will accept also large IV_CIPHER values from clients.
>=20
> Patch V2: Correct comment about normalising ciphers
> Patch V3: Correct #ifdef statement
> Patch V5: Fix tests with OpenSSL 1.0.2 and libraries missing Chacha
> Patch V6: Fix unit tests for mbed tls, which recognises ChaCha20-Poly1305
>           only when used with all uppercase, fix missing space in message
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/openvpn.8                       |  3 ++
>  src/openvpn/options.c               | 14 ++++---
>  src/openvpn/ssl_ncp.c               | 57 +++++++++++++++++++++++++----
>  src/openvpn/ssl_ncp.h               | 19 +++++++++-
>  tests/unit_tests/openvpn/test_ncp.c | 54 +++++++++++++++++++++++----
>  5 files changed, 125 insertions(+), 22 deletions(-)
>=20

I've only done quick code review and built it on RHEL7 not finding any issu=
es.
 Code looks reasonable, so I don't see any reason to hold this back any mor=
e.

Acked-by: David Sommerseth <davids@...515...>

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--vQqElskgbqfy07XsRpNhB2KITnaJnVM4R--

--6VAoLyfGtOGCNwkRCuPVF8Pk5WaJsflnX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJefhmIAAoJEIbPlEyWcf3ykzYQAKblitrhhCTUv7YHgfqomAla
KrkVelyOmFoKncBnrbXdTxN9uS5uma4lUeflz0bGTBP085ncm7ogKTiOzt9X/kEm
YzmfL+K1BZmby+uzQnXUktli/1k9hOjmF6VXk8o7dFYbRjgCDG/4Ckug1aKKYufC
yyk5wcgpF/8uRnDuzJWHfhVpwpzsmrzWb+665Cmn3jSsEoSI7cQQgG1+rhVsitMx
flkMvA6cwBtorsBNyBzvnIGFyj7wTs2aA/PPfp/wOxbGAJuJJhhaZvh+hOY/RtEH
32DLpqGsMMnDXGVzcTP9HvSpaD61htxYAGNZrepMLv0cmvrZR6MHfjKGa8v1N16Z
5lLopB18tiayWfMuSS3VNJxEO0JZrE1uMw0uAe656pqgQTccdTQoqx8RsVt9pVVg
AMNKMydrSm2+AJq4dUhuSgUDM/naiACmzllLvNw+u3VC8ESr/XeR21tLTRnVx0d0
8DXXTZMeYuqlxAvk4G2Rv8beQS+eW7a0O9lqRnfMg+H9+emYE4E5WYpFxebsNon/
tDzEnJkgxMAW9KD49SIdq9OqBO2AhpoYUFIi0dSOxCBWH+FUeZ0NZNl6cWx5BKJl
h3PjK9xE7Sq2RfhKlECYP/JsPny6DAN4UY9o4dtlY/nOldDNemCBK0a+pEgav00p
0qmkf/aHyTYFnLjy5WW7
=CWno
-----END PGP SIGNATURE-----

--6VAoLyfGtOGCNwkRCuPVF8Pk5WaJsflnX--

