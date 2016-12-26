Date: Mon, 26 Dec 2016 09:05:39 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161226080538.GU78624@...1296...>
References: <1482079255-15159-1-git-send-email-steffan@...1856...>
	<20161218212659.GY78624@...1296...>
	<965a4c27-5e16-59a8-db9c-930f1216f22c@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0i4az6ru2FyWQ2bd"
Content-Disposition: inline
In-Reply-To: <965a4c27-5e16-59a8-db9c-930f1216f22c@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Use SHA256 for the internal digest,
 instead of MD5
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--0i4az6ru2FyWQ2bd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 26, 2016 at 12:20:53AM +0100, Steffan Karger wrote:
> The oldest OpenSSL we support in release/2.4 and master is 0.9.8, and
> has SHA256 support (was introduced in 2004).  Also, the --tls-crypt
> feature already unconditionally requires SHA256 to be available.

Good enough for me.=20=20

Have to look more closely at the actual patch, though :)

As for "build on MacOS", I seem to remember from plaisthos' buildslave
that we cannot currently build on an "unmodified" MacOS anyway, but have
to install a more recent (or more complete?) OpenSSL beforehand - so=20
that particular ship has sailed.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0i4az6ru2FyWQ2bd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYYM9SAAoJEB2Cnv7KVigS1m4L/AyVn+A2d4SHd2cJ1zA6Yc+y
VYX8lzB18iR/nxzupAZiNQLS5XgRSYLMUxHrqaeZEDuQBojy3h1kGNMn7aWj+fHk
ro+sEGnGGBM0kMw8AwZcJfIfxFMxxiyVGvjjnCZowIo7nOkSshCQGQkmn3I0HLRG
blRL75fAFFtAMOs6n75b6y8f5/n3utidOTlN/51DFS2+1M20OJOFzQKeulcW+Nvg
0J0HHdYK0BD1j+lMpPvw2cbuh69xn2ztF9Cu4nITznYWwHN83S/ldygSSeoEeJSI
8HR3IkDZrCues8GTKPkoEM2tSqJlPqHbfg4+i+EblN9SJwjMjQReVYZe0DGkFrJ1
J4FBjlYPdaOqQZZkA1c5GIMNkoinviY6gEH2+Pu9DGPuFyFUbH9XPxnBHv0DfGPw
hmxbT8BNHBeDEc3egjliRLqo/XCRCaprZ16UCkYwDZN44fWzqRHQmCOEdGlkPlhU
2Z0kKsTwlD3jnkRXgQ4j8dDB8Bya4+Ejfrx4P7H61w==
=GfrV
-----END PGP SIGNATURE-----

--0i4az6ru2FyWQ2bd--

