Date: Sun, 1 Apr 2012 14:22:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120401122233.GD1359@...1296...>
References: <1333282357-2882-1-git-send-email-alon.barlev@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azIKtn7V5gBmWzzR"
Content-Disposition: inline
In-Reply-To: <1333282357-2882-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] cleanup: avoid using ~0 - windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--azIKtn7V5gBmWzzR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 01, 2012 at 03:12:37PM +0300, Alon Bar-Lev wrote:
> Use the following constants:
> - METRIC_NOT_USED
> - TUN_ADAPTER_INDEX_INVALID
>=20
> Modified: Use MAXDWORD for route loop.

ACK.  Taking into account my comments to 1/4 and "4/4 first cut".

ACK for the same reasons explained there.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--azIKtn7V5gBmWzzR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3hIiakuBuNlUUl1AQIDfAP9FE6JiKB4IzO/hRjEaU9UmMCHm5/wEk0H
7xfw02wUQ2MQ+lM+l/EM3Ji8mtRV6wH5/LJXs89FrXcWDrwCsGtzlx6DQJMxZYSz
pG1VMuJp9eTimr0WP2txVoJ8GxonXMgJuzTpUsm9iEYf38Xvuc5ALpdKXYfZZdA+
eEnxUjTj3Ro=
=30b0
-----END PGP SIGNATURE-----

--azIKtn7V5gBmWzzR--

