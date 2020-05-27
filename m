References: <20200519220004.25136-1-arne@...1227...>
 <20200519220004.25136-6-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d94396ae-6ea7-d19b-b9c4-4f1111d8a98e@...2080...>
Date: Wed, 27 May 2020 23:15:08 +0200
MIME-Version: 1.0
In-Reply-To: <20200519220004.25136-6-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ay3VAPzQQ3yBnlDNQyE54Cd60TT1erMUX"
Subject: Re: [Openvpn-devel] [PATCH v3 5/5] Implement forwarding client
 CR_RESPONSE messages to management
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
--Ay3VAPzQQ3yBnlDNQyE54Cd60TT1erMUX
Content-Type: multipart/mixed; boundary="9k1sWQStcomqHlztKyktkeUnyh91UdlGF";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <d94396ae-6ea7-d19b-b9c4-4f1111d8a98e@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v3 5/5] Implement forwarding client
 CR_RESPONSE messages to management
References: <20200519220004.25136-1-arne@...1227...>
 <20200519220004.25136-6-arne@...1227...>
In-Reply-To: <20200519220004.25136-6-arne@...1227...>

--9k1sWQStcomqHlztKyktkeUnyh91UdlGF
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 20/05/2020 00:00, Arne Schwabe wrote:
> When signalling the client that it should do Challenge response
> without reconnecting (IV_SSO=3Dcrtext/INFOPRE=3DCR_TEXT), the server
> needs forward the response via the management console.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/management-notes.txt | 30 +++++++++++++++++++++++++++++-
>  src/openvpn/forward.c    |  4 ++++
>  src/openvpn/manage.c     | 28 +++++++++++++++++++++++++++-
>  src/openvpn/manage.h     |  5 +++++
>  src/openvpn/push.c       | 22 ++++++++++++++++++++++
>  src/openvpn/push.h       |  2 ++
>  6 files changed, 89 insertions(+), 2 deletions(-)
>=20
[...]

Basing this also on prior testing, looking good.  Only done compile testing=
 in
this round.

Acked-By: David Sommerseth <davids@...515...>

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--9k1sWQStcomqHlztKyktkeUnyh91UdlGF--

--Ay3VAPzQQ3yBnlDNQyE54Cd60TT1erMUX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJezthcAAoJEIbPlEyWcf3ykNwP/3uunbG7bsCmreboSAIDUYAO
XKJS2mxWwJLI/YhpC31wLtDVu0PheGhz7rWAZemNX7s5Zsr3SuoaU/yCmYviDLl9
2qnRXN9lXxyHNQkAWC8wOCW2m6ZAXbPQ04FYc+DIweDwJraTfaueS/hlyDlofmPu
1Ov8hAn4UkTVIG2uZAxrriQJpYpZ3VLEb0PVbDU1xMc+tOObVTJ/NhyECR8OXhk6
aQO4vYj7IpbM3P+g2obgFuHvbhWE9+yEIaW2TNNSG2ccNbGN73emY5Ik/6BA64Tg
wkLveKYhBhYjEGYKVcAfIpZCQLS/7NbPX/gixitepyrwnH2qT9vJ7+uHMev16B07
1jQ9qyUWdN57MuzuJP4Zd0QCn/kD7EEbbHdHtocs6fuD/WmoTFZncQY4PN15F76O
tp/aM76I1FdC4dNJ+MGIiBCy0jxfRSuytwojHabVm7JvS/Aa/7059FdNxgbT1yTg
nhkQspt24JyqSMO3pISvENCysjvlH8O2LPFfhOWmwcNpnSqi2S9y6fYYvqopmR8R
hVeDO0gCn2M73qsj170fAC8S3wG8WHgFjxzwVx4mL1wiIChT1l1ye9/DtrOmAVKl
2HYAD05q381diqI438p7zmp8zfk5PnldxReIQPWtx3Tx/pM0IQNFdYfhAHu6H+BB
wWOmkSbFkl5ISrowjHrD
=+Ess
-----END PGP SIGNATURE-----

--Ay3VAPzQQ3yBnlDNQyE54Cd60TT1erMUX--

