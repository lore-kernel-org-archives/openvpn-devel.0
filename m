References: <20180104193710.23778-1-chipitsine@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9cb3e4fc-a681-484a-2712-8483835901d5@...2181...>
Date: Fri, 5 Jan 2018 06:23:17 +0800
MIME-Version: 1.0
In-Reply-To: <20180104193710.23778-1-chipitsine@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="506CcSBw5gnuTNgPOP9EZBXhnPl3b6ai3"
Subject: Re: [Openvpn-devel] [PATCH v3] travis-ci: add brew cache,
 remove ccache
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ilya Shipitsin <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--506CcSBw5gnuTNgPOP9EZBXhnPl3b6ai3
Content-Type: multipart/mixed; boundary="QnkbXQQ2mlyWfDbqnsOik2SO5mZDGfiee";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Ilya Shipitsin <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <9cb3e4fc-a681-484a-2712-8483835901d5@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3] travis-ci: add brew cache, remove
 ccache
References: <20180104193710.23778-1-chipitsine@...277...>
In-Reply-To: <20180104193710.23778-1-chipitsine@...277...>

--QnkbXQQ2mlyWfDbqnsOik2SO5mZDGfiee
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 05/01/18 03:37, Ilya Shipitsin wrote:
> 1-2 minutes speedup osx builds by using brew cache.
> Also, ccache was removed for a while (builds fail
> after travis-ci upgraded clang to version 5.0.0)
> ---
> v2: this is a "v2" of previously issued "enable ccache for osx and mingw =
builds"
> patch. I decided not to enable ccache for mingw builds as it does not
> speedup them
>=20
> v3: removed ccache at all, because it fails on clang-5.0.0

Does this patch make "[PATCH] travis-ci: speedup osx build by enabling
brew cache=E2=80=8B" obsolete?


Regards,


--=20
Antonio Quartulli


--QnkbXQQ2mlyWfDbqnsOik2SO5mZDGfiee--

--506CcSBw5gnuTNgPOP9EZBXhnPl3b6ai3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlpOqVUACgkQB6U8WA7y
zXReag/+Leuty3SaWyBfvU2dJVUI/ibHPAmlMlCTHmD1ebc8DAbbI468cWpxBPDi
ra8qNbgMeBHFqUtX7I+4qvWronmX8AADm5OzqJi5N1F++YTorQBPj+SBRqSXBiXa
ztxk9RjDBPExBxnxdalXzR3aLbGv/vvdeZFe04e2kX9Fp6zjsBz0JLhFVSeBsSkL
Fb9/zdkpuuLPFdUgK5ZvyvkZ86PeWleU+MMka9o8pXaX6EP5u3RgCC15kGO80qi2
h+wn/s8PMKxsg6eUpJe6a4i6h1kBZVttcTnpTQ+JkCKDFvT0eR3P4iU+pwwTiALp
DOHDgzl03Erb5gf1iBYR2XCobu4eMYaZ7b/vFmLp6WhBPD2BvUvHStjua49tpfoF
VXYFKyVc7tiUwyogG0KJyOpvuBdqlWf2BY5MK+7Ahvwr0jfip+guX9ArfKXHmY/k
ugjJrKCu0jp9TbAoTdWXfYEJeLl7pTfk6yS70dzXgpi6b6mFnU+7tdJi/NY/OOnS
5iIQH5iZQoICC0uvUBvdpmuAxTKM4LpjyJeVHggVce70klc3XT/sFRZT08FyzD52
dkzYnX1hEzXbdr3/DzDpLwlHhWTcIK/ut5eTMkJN2qaOccH2Jce7jGYV9EcK5nls
bGuanDNOuI8W81KwFNscb1Id3Vclkrm8XvEHGQnuGgWo1wJqPXw=
=lUCX
-----END PGP SIGNATURE-----

--506CcSBw5gnuTNgPOP9EZBXhnPl3b6ai3--

