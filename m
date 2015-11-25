References: <20151125082651.GT24952@...1296...>
	<1448477781-21564-1-git-send-email-iam@...2070...>
From: ValdikSS <iam@...2070...>
Message-ID: <565605D5.8070406@...2070...>
Date: Wed, 25 Nov 2015 22:02:45 +0300
MIME-Version: 1.0
In-Reply-To: <1448477781-21564-1-git-send-email-iam@...2070...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J8jcqFs1MMXi54NnQL2Gt51C92K9a87bF"
Subject: Re: [Openvpn-devel] [PATCH v5-2.3] Add Windows DNS Leak fix using
 WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, gert@...1296...

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J8jcqFs1MMXi54NnQL2Gt51C92K9a87bF
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

This patch for release/2.3 has vista ifdefs in code and no build system mod=
ifications, so the linking would fail if it is compiled for vista+, so you =
need to
add LIBS=3D'-lfwpuclnt -lrpcrt4' to configure as Gert suggested.



--J8jcqFs1MMXi54NnQL2Gt51C92K9a87bF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWVgXVAAoJEFzXIC7viPdyKl0QALxLFGR9/kSxoJDrryQ8IY8V
q5Hsvl2GsjC1veH489+UdQeAv1dYQXo9gglfEMuMVGoKa+ui8L+wa+LP0RHUtqCn
uwbjLG985M6NHk3S5bSDuv2LDFnXyI0jOnHRGh2P48rAhKolYAD6vYlyxx2VB4HY
JqAjO98Ik6WYwIluV9nKt/b9ScpZ7RDWrBMDop2+xBlcctLcMU/H9tsbgpeMCWtb
cLiM7AAXMxOZcJXWiv8ieTKvaO+HtsGTxDnUd7DoI/lkd6LhrkMBSKcUatqU3I9D
O+UHuoldiqBunDPiez8qQ8I1qcJIe1nDFVGLm2ha1lhT7rudEBaxuNyeZLHBz7Z9
24hEoOU1JumbuDByfSaKCRsDBE3jOtVqOlVGzyf8Vxhen66VjjHHKJk3Z6xu5lU6
fZ5/Ubthq2b+g+A6+r8h54GM4ekS5gc2mtkDVWqmq35QhVG7ru9qnbt4eOMifMLJ
kMcm+6SX8VW/gNBC//R94mDA59pzUIn28YR17aVn7QsoRMeaLVL8zDO6TscBZtZm
85xBpT/4eepUVhw52vECuOuhl68CpXWEr96D8L6WTMIe6IwIxt4UB9tWZO35T3vM
auZVCMtpEH28qp94tJONDMJ0eUegj2j0lFNHMBxPLgJGz5RnKhjX3xJOwADnGTKP
rRX7v7iXU/Ovsc2Rl5Bd
=rbDu
-----END PGP SIGNATURE-----

--J8jcqFs1MMXi54NnQL2Gt51C92K9a87bF--

