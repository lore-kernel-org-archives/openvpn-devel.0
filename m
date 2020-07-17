References: <20200717150526.124733-1-matthias.andree@...68...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <4e8ebfb9-ee76-f7e1-0771-8e8bdb605b5f@...2080...>
Date: Fri, 17 Jul 2020 17:36:53 +0200
MIME-Version: 1.0
In-Reply-To: <20200717150526.124733-1-matthias.andree@...68...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0fCmkR3j8EIOcCOAzldJXpuJqncNG3HKc"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Permit make dist* targets without
 py*-docutils
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0fCmkR3j8EIOcCOAzldJXpuJqncNG3HKc
Content-Type: multipart/mixed; boundary="Vws2Y8HuE1PnyIbb8Vc6FZWFom8IbIzhc";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Matthias Andree <matthias.andree@...68...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4e8ebfb9-ee76-f7e1-0771-8e8bdb605b5f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Permit make dist* targets without
 py*-docutils
References: <20200717150526.124733-1-matthias.andree@...68...>
In-Reply-To: <20200717150526.124733-1-matthias.andree@...68...>

--Vws2Y8HuE1PnyIbb8Vc6FZWFom8IbIzhc
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 17/07/2020 17:05, Matthias Andree wrote:
> Signed-off-by: Matthias Andree <matthias.andree@...68...>
> ---
>  doc/Makefile.am | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/Makefile.am b/doc/Makefile.am
> index add92198..80cb2cb8 100644
> --- a/doc/Makefile.am
> +++ b/doc/Makefile.am
> @@ -59,8 +59,9 @@ else
>  endif
>=20
>  if HAVE_PYDOCUTILS
> -dist_noinst_DATA +=3D openvpn.8
> -dist_html_DATA =3D openvpn.8.html
> +nodist_noinst_DATA =3D openvpn.8
> +nodist_html_DATA =3D openvpn.8.html
> +EXTRA_DIST =3D openvpn.8 $(nodist_html_DATA)
>=20
>  # Failsafe - do not delete these files unless we can recreate them
>  CLEANFILES =3D \


Thanks!  This fixes the 'make distdir', which should also fix the 'make che=
ck'
issues Gert found [1].

Acked-By: David Sommerseth <davids@...515...>


[1] Message-Id: 20200717131607.GS1431@...1296...

<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20436.=
html>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--Vws2Y8HuE1PnyIbb8Vc6FZWFom8IbIzhc--

--0fCmkR3j8EIOcCOAzldJXpuJqncNG3HKc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfEcWVAAoJEIbPlEyWcf3y6ucP/2nDGu9Dh1ZGHMGg7rL2C5Ei
zoX3NDV4xyXZ7N7HVBioVtnpiP9WEHiENcOWC5G5A8v9ZTeeoejrbdnKPtwucV+t
EzihKJrL1iaaRbIlHLZhSYDxoJg4faqJ1TTC5tCO10VyBcZ49lno7WQY3M8MuC65
G1vqDxbWXwQqn0ucWJnKgHnEZa9pr1WijfIFhzrtEKttm0o6rUlABTczqo1768Ir
3kEh/uVpNg3t8HsLsIX64vpvHJAc0Gn2F3gKVmJcFYejttmkqiq+MDQpybdwC0Na
GObUdvG4qVtbFPt5i4MqJaK+7sPrKafjCHDKPDrpj6hNp6jwNf/9dsrXCvsQ4mVg
joPqzlkFRQrbdokaCRREcJZ6NUIzYsNgk5eC/5z/rDfZQsZmQfpJKKSVw11uZ2aH
5mchbXq44aJFnT2/HaoZDuqUan/Mc+7UWs956BYa4DOO5adO3Mw9s9RgqU5aI1uH
STxr/tWOYGdHk/fVSgyapsFH/KGl1ib6jU0S7pKcgQHAAH2IfOn8d9rvKI0pEclJ
ghnh0PeKX/pzpNLoFCSlJ2/1J5umI4r2+jEsURwa4SAQvMPES0qbFem5M4Sa+Mc6
VEYnvzeLwTS+cctQ58UezUCQBHssHzhAiWKcarTW942KDZBJCzgcu7/bNloqrXyO
jayebl1ncUm8QxMqEpgo
=36G5
-----END PGP SIGNATURE-----

--0fCmkR3j8EIOcCOAzldJXpuJqncNG3HKc--

