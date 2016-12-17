Date: Sat, 17 Dec 2016 11:05:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161217100520.GR78624@...1296...>
References: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
	<20161216182659.18194-1-jm@...1926...>
	<dfbcd54a-29c2-d8e5-1200-66f217832063@...1435...>
	<44d2e307-1954-de7f-9979-68728de900b3@...1926...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="veZQh2nSsG1B2+Ku"
Content-Disposition: inline
In-Reply-To: <44d2e307-1954-de7f-9979-68728de900b3@...1926...>
Subject: Re: [Openvpn-devel] [PATCH] Build with a few -Werror= flags if the
 compiler supports them
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Julien Muchembled <jm@...1926...>
Cc: openvpn-devel@lists.sourceforge.net

--veZQh2nSsG1B2+Ku
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 16, 2016 at 11:16:08PM +0100, Julien Muchembled wrote:
> BTW, instead of failing on these 3 specific warnings, we could go the opp=
osite way, since -Wall is quite silent. I suggest:
>=20
>   -Wall -Wno-unused -Wno-pointer-sign -Werror -Wno-error=3Dstrict-aliasin=
g -Werror=3Dformat-security

NAK to "-Wall -Werror", unless you've tested that this does not break=20
compilation on any of the supported platforms.

The world is bigger than Linux.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--veZQh2nSsG1B2+Ku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYVQ3gAAoJEB2Cnv7KVigS6EQMAJWRjeLFJfH2g71rUrwxsGkJ
obnY8duPKiuUpkRjOzBkZBwuRYUu8bOX07lTjF9Xq0WXQTJySRFrEaVeIEj/zk1o
Bm+68i7stUbBLIADuqfyqJiU0j1R03BIHC70ZdhBalT9a1iejwv2bJCjy5mJwIr/
t8b7h3U2YPuVmGXZv1yJCw821mq7bIJJByS1N/1n7tfqtYGvsxYfOtIXYZOQIceJ
75a5LWSPtohECRU5phlZNlmpSuIcTJ6mEhuOGPWBBjWV+3sytJdTs8G7VkQHgiNu
v7Y9Zv5pYtSDgnnmJYATW3OnQspYbvTMAn0a1YfG2yzoHWfhc5MDNegqhXtHjVHn
ya0Jaq8k639kBzk9h8/x1k9F+836s7QYjIdwNrIz+sZbim3gF+nPVxCz2rxlDf7j
UfNSrPJsXZh4Ta1hjMR19mfy9LrTD8vXSg5fk2+apgrWwj7z3SYTwl14NhoVdVWr
WKcg5fjIhak3eLN6tpOdYzH3xjnfcZuKhSGzHbYCLg==
=06KW
-----END PGP SIGNATURE-----

--veZQh2nSsG1B2+Ku--

