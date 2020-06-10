References: <20200528235423.27416-1-arne@...1227...>
 <20200604235338.11728-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <15386e16-879a-9944-a3f4-63700a097041@...2080...>
Date: Wed, 10 Jun 2020 13:49:26 +0200
MIME-Version: 1.0
In-Reply-To: <20200604235338.11728-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="iLiqbkGDkoJdOBvFdYTghm3VN9rw03aXE"
Subject: Re: [Openvpn-devel] [PATCH v2] Add .git-blame-ignore-revs with
 reformat commits
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
--iLiqbkGDkoJdOBvFdYTghm3VN9rw03aXE
Content-Type: multipart/mixed; boundary="vWpjlUFD8ObLNvwCRX8kVHsSkcVXVkZhT";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <15386e16-879a-9944-a3f4-63700a097041@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add .git-blame-ignore-revs with
 reformat commits
References: <20200528235423.27416-1-arne@...1227...>
 <20200604235338.11728-1-arne@...1227...>
In-Reply-To: <20200604235338.11728-1-arne@...1227...>

--vWpjlUFD8ObLNvwCRX8kVHsSkcVXVkZhT
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 05/06/2020 01:53, Arne Schwabe wrote:
> This allows git blame to ignore reformatting changes and instead
> to show the previous commit that changed the line.
>=20
> To avoid manually building the list of commits this commit
> adds a file with a list of reformatting commits. I might have
> missed a few but this should be a good start. To use the file
> use:
>=20
>    git blame --ignore-revs-file=3D.git-blame-ignore-revs file
>=20
> or to automatically always use the file
>=20
>    git config blame.ignoreRevsFile .git-blame-ignore-revs
>=20
> Naming the file .git-blame-ignore-revs is a convention.
>=20
> Some more details in this random blog post:
>=20
> https://www.moxio.com/blog/43/ignoring-bulk-change-commits-with-git-blame
>=20
> Patch V2: Remove merge commit of the great formatting, add small
>           reminder how to use the feature at the top of the file
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  .git-blame-ignore-revs                        | 39 +++++++++++++++++++
>  .../managent-demo/management-demo-server.py   |  0
>  contrib/ovpnkeys.py                           |  0
>  3 files changed, 39 insertions(+)
>  create mode 100644 .git-blame-ignore-revs
>  create mode 100644 contrib/managent-demo/management-demo-server.py
>  create mode 100644 contrib/ovpnkeys.py
>=20
> diff --git a/.git-blame-ignore-revs b/.git-blame-ignore-revs
> new file mode 100644
> index 00000000..6d9b374f
> --- /dev/null
> +++ b/.git-blame-ignore-revs
> @@ -0,0 +1,39 @@
> +# This FILE allows git blame to ignore reformatting changes and instead
> +# shows the previous commit that changed the line.
> +#
> +# To avoid manually building the list of commits this commit
> +# adds a file with a list of reformatting commits. TO use:
> +#
> +#   git blame --ignore-revs-file=3D.git-blame-ignore-revs file
> +#
> +# or to automatically always use the file
> +#
> +#   git config blame.ignoreRevsFile .git-blame-ignore-revs
> +
> +
> +# Uncrustify the tests/unit_tests/ part of our tree.
> +da1574ef7826d73f01e120cbd1ba40ce39a305b7
> +
> +# Another round of uncrustify code cleanup.
> +9cf7b4925a54d93fbea1cadcf3dc0e11f3ce358f
> +
> +# networking_sitnl.c: uncrustify file
> +2c45d268ca65c522fbabb7c4dab5e721296b4623
> +
> +# Uncrustify tapctl and openvpnmsica
> +6280d3d5536174934ee22d3840457d61896e0e3a
> +
> +# tun.c: uncrustify
> +baef44fc8769bbd99f4d699ce9f63180c29a5455
> +
> +# networking_sitnl.c: uncrustify file
> +2c45d268ca65c522fbabb7c4dab5e721296b4623
> +
> +# uncrustify openvpn sources
> +f57431cdc88f22fa4d7962946f0d3187fe058539
> +
> +# More broadly enforce Allman style and braces-around-conditionals
> +4cd4899e8e80efae03c584a760fd107251735723
> +
> +# The Great Reformatting - first phase
> +81d882d5302b8b647202a6893b57dfdc61fd6df2
> diff --git a/contrib/managent-demo/management-demo-server.py b/contrib/ma=
nagent-demo/management-demo-server.py

This looks good.

> new file mode 100644
> index 00000000..e69de29b
> diff --git a/contrib/ovpnkeys.py b/contrib/ovpnkeys.py
> new file mode 100644
> index 00000000..e69de29b
>=20

Why do you keep on adding this file ;-)

I'd say this file could be removed at apply time.

Acked-By: David Somerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--vWpjlUFD8ObLNvwCRX8kVHsSkcVXVkZhT--

--iLiqbkGDkoJdOBvFdYTghm3VN9rw03aXE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJe4MjNAAoJEIbPlEyWcf3yS5UP/jOU/t/vlkYU9Bfk1RtQsEcT
fsCMpic+Xr6z9pYEkE/0O3ebf62vjkCFNDDZrCZHu5JUSRPmXkptBVT0P0lLWZBP
rhwo1CVQP+BFRs7r1mBJe5cnr/PK/NqWpVbrCCTXx1TC3tFr35QYL2HhynM9G1A8
R0kw9kbLkxmfQdHv/gYTkfV9LpxKV3GSZiOGARaU9Cf2uo0LuQzkP3sCsNHQ975Z
si6sYzbt5JwtToT5MqFRytpKQjGNydjI0Px9wKY93piXMj8tEQSk7ZAgSkLZiaDR
J3iaMfJmmoQvBJcO6in+awf1On1DgcodRWb/7mfUJyNWho09OFykdGfN4qggB1rc
rlJdtiu9fn7PA18x7qoUC1YlwQdjvFFf2Wy2knBQu+ewtJ/+l5YoaKWJsW1gkbp6
hPasp0ms+CFJQvkLgRM7NxpcJPlR/p5f7lZQBOgDzNVZvRfBf9QgbMV4Uwq3mHfv
ZyW+MfxeMNy+/zPp0feSKg5BqHWbqCSZCgrA2FwOml7pZv/liHhsLLWeDcOCusuj
EXttr2zIzkmLFwdBAbrlabmiKFu/E5fAO3Dk9yxHd++cXRNuePa9K4kKXqnheJ3Q
VGbegta8G9QscmdLdT4xQNmmrNrqb87ip2rT3lqBFuii6Ylj9i3LB1Zd8BzEFP5K
+uUo+9EIH/85Sb/vkvGW
=WM+R
-----END PGP SIGNATURE-----

--iLiqbkGDkoJdOBvFdYTghm3VN9rw03aXE--

