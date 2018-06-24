References: <20180605081407.6944-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <dcb79cab-df59-0259-8768-bfff92f923fa@...2181...>
Date: Sun, 24 Jun 2018 17:03:15 +0800
MIME-Version: 1.0
In-Reply-To: <20180605081407.6944-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sBJL17YZ4ZrQdp52wS1sMK80mMnoLsPqO"
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] crypto: always reload
 tls-auth/crypt key contexts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sBJL17YZ4ZrQdp52wS1sMK80mMnoLsPqO
Content-Type: multipart/mixed; boundary="FaYJKUk7pKRDCultCPmzr4bk5LWpvzz6Y";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <dcb79cab-df59-0259-8768-bfff92f923fa@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] crypto: always reload
 tls-auth/crypt key contexts
References: <20180605081407.6944-1-a@...2181...>
In-Reply-To: <20180605081407.6944-1-a@...2181...>

--FaYJKUk7pKRDCultCPmzr4bk5LWpvzz6Y
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/06/18 16:14, Antonio Quartulli wrote:
> In preparation to having tls-auth/crypt keys per connection
> block, it is important to ensure that such material is always
> reloaded upon SIGUSR1, no matter if `persist-key` was specified
> or not.
>=20
> This is required because when moving from one remote to the
> other the key may change and thus the key context needs to
> be refreshed.
>=20
> To ensure that the `persist-key` logic will still work
> as expected, the tls-auth/crypt key is pre-loaded so that
> the keyfile is not required at runtime.
>=20
> Trac: #720
> Cc: Steffan Karger <steffan@...1856...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>=20
> v2:
> - introduce this patch
> v3:
> - add key per-loading logic to this patch to avoid temporary features

            ^^^^^ this should be "re-loading", sorry.

>   breakages

Cheers,


--=20
Antonio Quartulli


--FaYJKUk7pKRDCultCPmzr4bk5LWpvzz6Y--

--sBJL17YZ4ZrQdp52wS1sMK80mMnoLsPqO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsvXlQACgkQB6U8WA7y
zXSY9Q//SJOnYsQ5T1wkf/IGCivWh5bcte2hyY2NRxa3g2y3AckjZ/l/1PBMKfhg
2qyvTGBbzyN3OGUIHh0EGq8RyuEa81/B7g6RcEKCMMMkonSfmx6MtLNi0U4JD6iO
QGDklFpur5odBVQmXiwovhSh2kAKnpenIFZhfGk1qXQhNtLA1dawoaMW1u6q8vZg
gYoN1qVG1+DvpIDlXbF8HYwAU9deqEcMb4MZg1dE+dHtmbu182HNzujEIzWD4j7d
DztDus7CuakTzdIluVRu8BjIAlZBS7VwrgOSyf4n2X3vC4loKYa1cjpS3VuiF6ly
qB2x0NGOyWy1biT1sKust/acDZuiqtzFpZvAj3TR6gJBPD42zGVWmCKNGoqjrBdD
AkL6gTjpkMlwFho0Fj4UBP//UqVDnA1do4VQcQ8X2XLtEGuvbMyR0srWVMkiUjgW
szxEWp0MZwTcdl+3gvKk9tRbP8KSNUwLfhROFvTensAmHtaexrAIi0/Mbb4oU/Gk
JDd0JhIi5zBnuiDEQc35KtLyd8xM3k8s9u5qR8pWXmeLIOPKMhgGfyYoA1/E582n
PYSmo+2+DI+nox4m++/sfTbfPnqRJs7LA+uY+Prggn81Km1Awywy6SAJ9oth5n65
BBK9gveb3SNT2Feee9DIkj1T9TtujwkxI+WFuGDyQCSX+jq90sg=
=gf0j
-----END PGP SIGNATURE-----

--sBJL17YZ4ZrQdp52wS1sMK80mMnoLsPqO--

