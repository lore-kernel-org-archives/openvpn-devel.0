References: <20161216155755.29931-1-list@...1798...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0f4adf76-7aa8-99e1-8fa4-e11f4e574909@...2080...>
Date: Fri, 16 Dec 2016 19:14:01 +0100
MIME-Version: 1.0
In-Reply-To: <20161216155755.29931-1-list@...1798...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="rNgKvdxjlJO5711CPX3fxTXqSvlJu6IWe"
Subject: Re: [Openvpn-devel] [PATCH 1/1] do not race on RuntimeDirectory
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rNgKvdxjlJO5711CPX3fxTXqSvlJu6IWe
Content-Type: multipart/mixed; boundary="hDDfvXWK2mulixuibH4BiGCDMBmTo6hD0";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>,
	OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>
Message-ID: <0f4adf76-7aa8-99e1-8fa4-e11f4e574909@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] do not race on RuntimeDirectory
References: <20161216155755.29931-1-list@...1798...>
In-Reply-To: <20161216155755.29931-1-list@...1798...>

--hDDfvXWK2mulixuibH4BiGCDMBmTo6hD0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 16/12/16 16:57, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>=20
> Different unit instances create and destroy the same RuntimeDirectory.
> This leads to running instances where the status file (and possibly
> more runtime data) is no longer accessible.
>=20
> So create a RuntimeDirectory per instance.
>=20
> Signed-off-by: Christian Hesse <mail@...1798...>
> ---
>  distro/systemd/openvpn-client@...1685... | 2 +-
>  distro/systemd/openvpn-server@...1685... | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/op=
envpn-client@...1685...
> index 5618af3..fcb5302 100644
> --- a/distro/systemd/openvpn-client@...1685...
> +++ b/distro/systemd/openvpn-client@...1685...
> @@ -9,7 +9,7 @@ Documentation=3Dhttps://community.openvpn.net/openvpn/wik=
i/HOWTO
>  [Service]
>  Type=3Dnotify
>  PrivateTmp=3Dtrue
> -RuntimeDirectory=3Dopenvpn-client
> +RuntimeDirectory=3Dopenvpn-client@%i

I am quite sure we tested this, without any luck.  We ended up with a
directory named openvpn-client@%i ... well, we used openvpn-client-%i,
but the principle should be the same.

This *might* have been fixed in a newer systemd releases, but as we have
RHEL7 as the oldest release we need to ensure this works properly there too.

For the server side, we used status-%i.log to avoid clashing on the
status log.

debbie10t did plenty of testing with various configurations, so he can
probably fill out more details in the various test cases he used.  We
should probably document those tests in our wiki though.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--hDDfvXWK2mulixuibH4BiGCDMBmTo6hD0--

--rNgKvdxjlJO5711CPX3fxTXqSvlJu6IWe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYVC7pAAoJEIbPlEyWcf3yxD4P/jYu/j/SDm2jZlcboQ8gygVd
4+BhRpImzrWoHqQsXfZ6f/BQTex5U/Y2vY69VUux5FzNHVteCMAVtxwPAMV5oIk+
en1BUpYuJ3MSmuAe5pC0GyC5QC0zK5/1YUsqMcdzghy7PfKnL4Uf0Qr9kPzt7d0t
urjkLEEf5km6gBiHJYuHxhSYJMyt7XF94fV5P5sLF7lpLzbtsgMnrQa+DttRy78A
7pNsMgtwWXTF2m25bdQolro7oTjm2mA1QsJ1f6nx5m7LeUCTWmql5emmM6g+qvvg
WqZsSMiBgO2n7dkVTO9mFIOa9WKcnDIc2LvPE4+5CeG7kMBW30LogVokA8GJfi5s
HW9J45osCaBjigm224rXJelxBLzmrfwRAXZa4EYU+6Lmnf8va/uZmz35x1hom8yn
SQPvnznSaS9AsWqyhEwGzG2p7RFUlaDzJ1txncJCpFwQy5sP3MRpbGGpGgSq+22U
bSJZkNHDPL4wiT+4F8NaqH2qgFdLN/1Q+0+RMjvXBF2CySfLClvrSm0LhYuJJ+o9
co2BzwqJkqAsoHzwGbBinE8BF2dA5Il1xb/U9uOPTugrC7+QQTCUt3mK1zQUqhRk
cEJVBZyYbIFKmfD537NQKXfZs47fQQOz1YbstVMlnL7Fo6ouEq7pXSQvgdC+xeEk
lf7Q4FvGPWX2f5y2xH30
=EcLe
-----END PGP SIGNATURE-----

--rNgKvdxjlJO5711CPX3fxTXqSvlJu6IWe--

