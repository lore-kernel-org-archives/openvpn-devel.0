References: <1477655821-6711-1-git-send-email-steffan.karger@...1435...>
	<1477660565-7933-1-git-send-email-davids@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e608ca36-c985-9a68-e380-1a70d4349716@...2080...>
Date: Fri, 28 Oct 2016 15:31:37 +0200
MIME-Version: 1.0
In-Reply-To: <1477660565-7933-1-git-send-email-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="t56at8SloA4Ui9G61pQn8xK3HqEKeoeCJ"
Subject: Re: [Openvpn-devel] [PATCH applied] Limit --reneg-bytes to 64MB
 when using small block ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t56at8SloA4Ui9G61pQn8xK3HqEKeoeCJ
Content-Type: multipart/mixed; boundary="xfcaV1ii7gL2unS8icC3w0pPHhQa95Oqq";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <e608ca36-c985-9a68-e380-1a70d4349716@...2080...>
Subject: Re: [Openvpn-devel] [PATCH applied] Limit --reneg-bytes to 64MB when
	using small block ciphers
References: <1477655821-6711-1-git-send-email-steffan.karger@...1435...>
	<1477660565-7933-1-git-send-email-davids@...515...>
In-Reply-To: <1477660565-7933-1-git-send-email-davids@...515...>

--xfcaV1ii7gL2unS8icC3w0pPHhQa95Oqq
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/10/16 15:16, David Sommerseth wrote:
> ACK.
>=20
> Your patch has been applied to the dev/pre-push-hook branch

This was pushed to the master branch.

> commit 752caece99a61e516386f94823e82ddf13fcbcab
> Author: Steffan Karger
> Date:   Fri Oct 28 13:57:01 2016 +0200
>=20
>      Limit --reneg-bytes to 64MB when using small block ciphers
>=20
>      Signed-off-by: Steffan Karger <steffan.karger@...1435...>
>      Acked-by: David Sommerseth <davids@...515...>
>      Message-Id: <1477655821-6711-1-git-send-email-steffan.karger@...1784...=
...>
>      URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg12798.html
>      Signed-off-by: David Sommerseth <davids@...515...>
>=20

--=20
kind regards,

David Sommerseth


--xfcaV1ii7gL2unS8icC3w0pPHhQa95Oqq--

--t56at8SloA4Ui9G61pQn8xK3HqEKeoeCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYE1M6AAoJEIbPlEyWcf3ywqoP/1k8bfrEpaEb2Xvl5sTShxz9
MgXpY4VXsqDf81Pp82VcX3fQkV3bUyOnxJrNc2jl0Ha1CmpfqZERb6bvI5zFa9rS
PuXWjoO9P/FV43JJj6tFbYXJOIUCx3BQZQpzskUxh1uoq/z8aF73tH6Y+dlio91Q
BBK8mCfrknOhmcNkd9+QAOr/tIwFiJIkU6v13OiXL7n04OxFM+UnWxW05BPWWC+W
GtKeEQmSbg+3VUnUbyfopuCzOomMSvec4qSuO5QJSo+O29CofrgcBe5/mN2Y+LjR
GY3P1s8jAOwSDx2UnRKoFXVK0QeCwJdJv6Lv2G3PHTH0wCsg5slMVtwMMroYfmfI
ZhZP5GYHi0fCDWORBnbFhRFlIz7DlrPu1elqXK4+1por9QhtLJ4g9pd5WbywhRgd
U8VCXOWKzrbAHlsFvTzkBoCfJlgJOBzCmei2kmKRQj+8QV4C3mnPjfbC2wNDJgXM
dsYawKV2czsXLExbMUTnqGC/PlcsApTubIKUMq8giRmUyObK6SmWvOd7rggQwgo0
HMXsppt6yCZD28qIKLL2ap66cnUPPxTlDDczwt45SM1P/aHhoyiU6/FSofgQuI+3
1SjFMREutDTwb+M4pA2Qc40bnK2Lx1K/9tbE3SD8ZWEOuhZl7k91Ksci+1nZb/yJ
bKoi8tl7RVPN9irwoH5L
=reQR
-----END PGP SIGNATURE-----

--t56at8SloA4Ui9G61pQn8xK3HqEKeoeCJ--

