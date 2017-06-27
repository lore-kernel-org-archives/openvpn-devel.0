Date: Tue, 27 Jun 2017 21:08:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170627190808.GZ97029@...1296...>
References: <1497897488-15999-1-git-send-email-chipitsine@...277...>
	<201706211957.v5LJv8M1076904@...2054...>
	<fe23e999-4d93-f90a-674e-3bd608497fba@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p/Yi3qgMZoap51CI"
Content-Disposition: inline
In-Reply-To: <fe23e999-4d93-f90a-674e-3bd608497fba@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: travis-ci: added gcc and
 clang openssl-1.1.0 builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--p/Yi3qgMZoap51CI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 21, 2017 at 10:50:00PM +0200, Steffan Karger wrote:
> The following have to be cherry-picked (just tested, works without fuzz):
>=20
> 56e6bd8967d72c4374389dfd5cf32f5e3b86242c
> 81ba70b39b78d7677aabab957421264800028f53
> aeac1139a34321a7f770ca20bfef886a21a89fe9

I have done this, and squashed them into a single commit for simplicity
(but keeping the original URL and Message-IDs).

commit 5852a035b444a41140a7fc7007b7df718a2e6c43 (HEAD -> release/2.4)
Author: Ilya Shipitsin <chipitsine@...277...>
Date:   Sat Feb 25 23:00:04 2017 +0500

    travis-ci: add 3 missing patches from master to release/2.4


"Testing infrastructure only, no code changes"

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--p/Yi3qgMZoap51CI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZUq0XAAoJEB2Cnv7KVigSVlkMAKTS/yj7WfOBu/ZYZu/m/qc1
Ez3saF6LgtUHbHZEQ3T2SwHE/UI+ucdFkRvToFU8S7YN/isqXSybsqm5Y/CschCU
Qx55UjUpsG2fVPopa/IzzspS5pqBKZKBC13iEZ32kpYDBjXIIvzw+Xyall1yKaeX
3+vUbUaJtaUStAV6Uz6OTLE+RYz1mIPQx0WZ7+HYjK+rP6YwgdiUY7sdM+dMGdMH
nrv3a+3rUpnGNINtr0+Q5yiXojYqIhwssFO5Ehmo2bicu/BWrG+moeE9hL6cRns3
5vAJWkACDooEJzbt6evSJWLSMyHGtyORuLRb63mnZZGVD6nAZxYuzZNjXDKWAUUQ
qaecm50ERskgjbUSSFo4cGWA9pP8SjOSd8maT8UFi7UqV4g1qn9LW01wMF2QGWJD
dp4ZzLn4kSdjZKQKXpfGxkzGHelndvXMftSEKtPnpX3AMscGfCXnCli2eVpqwEBt
J3KAirE+Kpvui5adHRMhUK6VR13TxjkqLTlKB7cT0g==
=tWU9
-----END PGP SIGNATURE-----

--p/Yi3qgMZoap51CI--

