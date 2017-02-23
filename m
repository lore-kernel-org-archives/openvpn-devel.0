References: <20170223084954.58464-1-gert@...1296...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <47aca4d5-dea7-2bc3-22bc-a7c0945f3e13@...1435...>
Date: Thu, 23 Feb 2017 10:09:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170223084954.58464-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JgsAh9X4a9aNtF9i1OQc2m3dc6faJ59Fk"
Subject: Re: [Openvpn-devel] [PATCH] Add openssl_compat.h to openvpn_SOURCES
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--JgsAh9X4a9aNtF9i1OQc2m3dc6faJ59Fk
Content-Type: multipart/mixed; boundary="aUp942PVEU59UhlK9LCo1q6IU2Dk9rgFR";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <47aca4d5-dea7-2bc3-22bc-a7c0945f3e13@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Add openssl_compat.h to openvpn_SOURCES
References: <20170223084954.58464-1-gert@...1296...>
In-Reply-To: <20170223084954.58464-1-gert@...1296...>

--aUp942PVEU59UhlK9LCo1q6IU2Dk9rgFR
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 23-02-17 09:49, Gert Doering wrote:
> Commit b936ddfb63 introduced a new header file but forgot to include
> it in the list of openvpn_SOURCES, so it did not get bundled in the
> generated tarballs.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/Makefile.am | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index 3f978553..fcc22d68 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -81,6 +81,7 @@ openvpn_SOURCES =3D \
>  	multi.c multi.h \
>  	ntlm.c ntlm.h \
>  	occ.c occ.h occ-inline.h \
> +	openssl_compat.h \
>  	pkcs11.c pkcs11.h pkcs11_backend.h \
>  	pkcs11_openssl.c \
>  	pkcs11_mbedtls.c \
>=20

ACK

-Steffan


--aUp942PVEU59UhlK9LCo1q6IU2Dk9rgFR--

--JgsAh9X4a9aNtF9i1OQc2m3dc6faJ59Fk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYrqa8AAoJEEEwndWOY1w5v4MH/jaCBA35rcv9jt6WmG+RNW51
D7RHwmSxBIdQam233zjfXeWWaN8FZHsUjmNUqs0PU9yYfc+vwEMCb+Gv4S1eAJ9D
ETT0tPZ2V6+/3q14pM6CNW60AL4KTc1RoUAlYYhodyxBRQp6ltrqwBJEArQTOBJ6
LgbKcjOJbvysHg18ICBMCCDMy7dGZX/KmwAFMfWkrh4hUfwDnbQrNGAAA4KFsKvF
D7/VHvTywy1FUObBZdA60j52GGO0eoSCS0dozu0NdkJIVWnie4TOIMGEiNHK5IMS
jfkzxNB8tcQTWIRuTJKHR4+bbEzHKpSMctkVgc0kBuuNXxFS2Pc8ff8dRuKkyQk=
=T1+Q
-----END PGP SIGNATURE-----

--JgsAh9X4a9aNtF9i1OQc2m3dc6faJ59Fk--

