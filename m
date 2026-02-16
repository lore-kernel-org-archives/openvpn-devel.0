Date: Mon, 16 Feb 2026 12:39:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <aZMB9CcAfueBjMwx@...1296...>
References: <aZL3VTPFLX8nHGSR@...2994...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y0BDtgoW3tEwv0Ml"
Content-Disposition: inline
In-Reply-To: <aZL3VTPFLX8nHGSR@...2994...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] ntlm: fix discards 'const'
 qualifier from pointer target type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rudi Heitbaum <rudi@...2993...>
Cc: openvpn-devel@lists.sourceforge.net

--Y0BDtgoW3tEwv0Ml
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 16, 2026 at 10:54:13AM +0000, Rudi Heitbaum via Openvpn-devel w=
rote:
> Since glibc-2.43:
>=20
> For ISO C23, the functions bsearch, memchr, strchr, strpbrk, strrchr,
> strstr, wcschr, wcspbrk, wcsrchr, wcsstr and wmemchr that return pointers
> into their input arrays now have definitions as macros that return a
> pointer to a const-qualified type when the input argument is a pointer
> to a const-qualified type.
>=20
> fixes:
>     src/openvpn/ntlm.c: In function 'ntlm_phase_3':
>     src/openvpn/ntlm.c:241:15: warning: assignment discards 'const' quali=
fier from pointer target type [-Wdiscarded-qualifiers]
>       241 |     separator =3D strchr(p->up.username, '\\');
>           |               ^
>=20
> Signed-off-by: Rudi Heitbaum <rudi@...2993...>
>=20
> diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
> index c00d4b9c..38739923 100644
> --- a/src/openvpn/dns.c
> +++ b/src/openvpn/dns.c

Not sure how you managed to send the dns.c patch twice, once with the
"ntlm" header...?

Please resend (with a "-v2" tag) and ensure that we get 1x ntlm.c and
1x dns.c :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Y0BDtgoW3tEwv0Ml
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmmTAfEACgkQHYKe/spW
KBIUfwv/SHvLIgjl91wYhgOE37wxhgmQjsiQLIxiAepmL0/XE3ATM1JF6kP6Z5qZ
5+F1NQI/7ytU1kNqJBL49NjoQq1Tc+fZcPBJpTmYy7+uyR5JuC/f3wQ4+xBlbk1s
iJSxRy2pQxjXGRxsb3Zw0uLI76EqpAGvPmiV4DFwU83PFZkRwFEkiftnMB6nThxh
ArOrp/Rv/wcH57MUgInsDFiPLi9TvlpoO5JCT2Efm2oGrnKnmpSV+u9mkH5NkYgO
9qdEmgDPPD6aoqJjneh9SdNbcqYLyduyQJJrR7tTeEKC0y1+C9GMi3bM/3AKP9Iu
BqHoKe6Wku0aqgn8HrSoBnjX8cyF6L+a8wFtZ7zGhJVFWdmQqyh6mYfOwWDMYfTd
6ANIhzbSYAaKU2VCaM5pwsEhxNFOnL2zu/HB+lBdq+3dvFJiHbGxi0CNCTIeL1lB
8+jYitAU0UxbYaRocSWSL+ZPmPIdcGa174Vpiyg+24TVB5jqpnkYjbSRv8gagrJn
womSPuCp
=T0XH
-----END PGP SIGNATURE-----

--Y0BDtgoW3tEwv0Ml--

