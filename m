References: <20210319153129.8734-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <06853ecb-8504-1177-fac4-838032f059df@...2080...>
Date: Sat, 20 Mar 2021 14:15:09 +0100
MIME-Version: 1.0
In-Reply-To: <20210319153129.8734-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bmHsLwZiYBkrnkTigMTSTQ6Jq9FirMYvy"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Move extract_iv_proto to
 ssl_util.c/h
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
--bmHsLwZiYBkrnkTigMTSTQ6Jq9FirMYvy
Content-Type: multipart/mixed; boundary="i5FvQViFvaMEywnMy622P1WK7tavHpQQZ";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <06853ecb-8504-1177-fac4-838032f059df@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Move extract_iv_proto to ssl_util.c/h
References: <20210319153129.8734-1-arne@...1227...>
In-Reply-To: <20210319153129.8734-1-arne@...1227...>

--i5FvQViFvaMEywnMy622P1WK7tavHpQQZ
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 19/03/2021 16:31, Arne Schwabe wrote:
> This function is used by both NCP and push, so move it to a more proper
> place.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/multi.c    |  1 +
>   src/openvpn/push.c     | 18 +-----------------
>   src/openvpn/push.h     | 10 ----------
>   src/openvpn/ssl_util.c | 16 ++++++++++++++++
>   src/openvpn/ssl_util.h |  8 ++++++++
>   5 files changed, 26 insertions(+), 27 deletions(-)
>=20

Glared at code, compared the move.  All good.  Compile tested on RHEL-8=20
just fine with no warnings.

Acked-By: David Sommerseth <davids@...515...>

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--i5FvQViFvaMEywnMy622P1WK7tavHpQQZ--

--bmHsLwZiYBkrnkTigMTSTQ6Jq9FirMYvy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmBV9V0ACgkQhs+UTJZx
/fJTSQ/9FPFKG25HwbG6KFk+yq1+wGSEeM7JZJgRuUEX383WRs+aLWpU4yI3aIUn
BNaBtQWy+6U8Q1v6XP44dWiC8HerRXZWgLMsVK6p+6OOQ8WUpbhKqXF67pivGlsJ
/Hm+nP895Bm7fzm/pdAZvSZ6iLnukbu6mi3VeRpMdeIFsbliAHIpBGaF3qVQiOoJ
sikF9QhSojx8DhNSi0alpVDo2mfbjgoVVnMFkTZqMPxwuADrcDqXOs7lQw8hGNGP
G23WgVtnIH5jONEZn8U+PBsSje+tiEmnTzAmGl1UZvnKylnwhNUD091CteStqRhz
driaEDEorNP/wmnhwhyWrm/fWH77gx+8J9FGy2OUEba6a6lDnMLR3GuCMOpYaksL
+LcFf32JiAcqGhjf2DLsPjf/Sj4Xxn7GukdRauW7XpPi6CF+0U7E18JgSvPrjz8n
pG8bmzMUWBvT3gxK9hldZIOUFjOjvjdta9Fyxhs76CsMyNAM+YIj9aKZkAQ+qlwt
KhgL9TjmWSsrErqOUYc4q1TywbV5ILRhTtJvUFw5+DPfhFIozj/0lJPBipbhPG+G
DnSbiE3nNdZjMWlFJrgtdMI6BHB6Q7RmCwyAgdt5RXLbokA3gT48crtWwxheVleX
8mLyPI+pD1kpLE5leJLLSyyi/vso+wwZ81tgdYMehqsjvpPebGs=
=uRXY
-----END PGP SIGNATURE-----

--bmHsLwZiYBkrnkTigMTSTQ6Jq9FirMYvy--

