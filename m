References: <1611778909-20630-1-git-send-email-gcox@...1057...>
 <1611778909-20630-2-git-send-email-gcox@...1057...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9694242d-a723-f9a8-1b93-e7061553a733@...2080...>
Date: Sat, 30 Jan 2021 01:05:45 +0100
MIME-Version: 1.0
In-Reply-To: <1611778909-20630-2-git-send-email-gcox@...1057...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fuoHojh8jTEVYXP64hAajpsov7Q37IuW4"
Subject: Re: [Openvpn-devel] [PATCH 2/2] More explicit versioning
 compatibility in sample-plugins/defer/simple.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Greg Cox <gcox@...1057...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fuoHojh8jTEVYXP64hAajpsov7Q37IuW4
Content-Type: multipart/mixed; boundary="Ggq1hO8lpJMifOYF7M1LVxfU7kcBxUKSU";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Greg Cox <gcox@...1057...>, openvpn-devel@lists.sourceforge.net
Message-ID: <9694242d-a723-f9a8-1b93-e7061553a733@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] More explicit versioning
 compatibility in sample-plugins/defer/simple.c
References: <1611778909-20630-1-git-send-email-gcox@...1057...>
 <1611778909-20630-2-git-send-email-gcox@...1057...>
In-Reply-To: <1611778909-20630-2-git-send-email-gcox@...1057...>

--Ggq1hO8lpJMifOYF7M1LVxfU7kcBxUKSU
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 27/01/2021 21:21, Greg Cox wrote:
> While not required, adding openvpn_plugin_min_version_required_v1 helps
> by making an example for others to copy, and helps to explicitly call
> attention to the difference between the API version number and the
> struct version number in v3 calls.
> ---
>   sample/sample-plugins/defer/simple.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
>=20

Yes, this is also reasonable and aligns well with the intension of these=20
version checks.  Thanks a lot!

Acked-By: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--Ggq1hO8lpJMifOYF7M1LVxfU7kcBxUKSU--

--fuoHojh8jTEVYXP64hAajpsov7Q37IuW4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmAUotoACgkQhs+UTJZx
/fIX+xAAguDuYk+K1OjzflQJ0pbmlu7ZFjwF/0aewZYZ/rLUP4leJnpdpGEGc4xz
4JWHsGNsfQlvKCUivUpSn5l/4GrOkF2bhluLXnq1mCa6k/aRdjT19wf6pNX83YdF
162ZiGjx1M2v9/BJptoguItT5ozf1RgB4tL98kwX9E0IVjVD0Teol7Rx+WEcekjM
LhQtecyJAoG4jnsk7Omb9xwrl+SZjSjvv8O1HZhrNXs4kQUT2cRCVfsB/XK2tt3D
3O+beEZpTJ/ak5/5aV1MQAF6grjm52O6THbi21cfqLBsHG8sIa3nbiRQyBvi+ZDv
U8ZxTSxwKZOOVnr487w4tYGDaQ2ndQlyVRxiBmqRg60Bd3BCtTudzrVjAUFiAJwD
ci//xmuaUPVb5OxuVJZjW/kqGp03GCkz7h0baDWiVVecBYcp93Tq+Ew1MEzCjDmt
fNGBehtyOJWhPopDxfZbOcCbz6j8GpdUTeOmhFL/LJP8Btr0Lp8iukDD21+zLu8Q
F50uA8KSfCTzlD3ZwEhChcHmdvAhEYXZ0QJEx6GNqo0FVg2+R2gO3gJIUe/yzwOU
Ekn0cnXbPeB/g7/eF7KeuO3An7sAM4svBgexw+2OmAMKkaK2WQQ4Br4BT/Ll7Blv
3KtTO8lyX/bYjS4fz4sxHptlMrIZ1PwoJXExjaTqi9+xchdpzMw=
=E70I
-----END PGP SIGNATURE-----

--fuoHojh8jTEVYXP64hAajpsov7Q37IuW4--

