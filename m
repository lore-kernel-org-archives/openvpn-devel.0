Date: Tue, 26 Jun 2012 15:50:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120626135004.GM22125@...1296...>
References: <1340715726-14670-1-git-send-email-alon.barlev@...277...>
	<20120626133532.GK22125@...1296...>
	<CAOazyz1A5mo9hKXi-KXUsoAUeNp1ELtA784xgYOzGT+e7BFu=Q@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <CAOazyz1A5mo9hKXi-KXUsoAUeNp1ELtA784xgYOzGT+e7BFu=Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH] build: plugins: set default to no in
	Windows
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

--xesSdrSSBC0PokLI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 26, 2012 at 04:41:49PM +0300, Alon Bar-Lev wrote:
> This is exactly the reason why *ALL* plugins should be disabled by defaul=
t.
> We are left with only Linux enabled... and distro maintainer can take
> care of that anyway.
> But again... my opinion is not matter, right... sending a new patch.

FreeBSD, NetBSD and OpenSolaris have PAM and build just fine, it's just=20
OpenBSD that does not.

(*My* opinion wasn't taken into account either - I proposed to auto-build
if possible, and if libraries are not found, just don't make a fuzz and
do not build the corresponding plugin, instead of erroring out - but I'm
not feeling strongly about this, so I'll accept what's there, and not
enter a lengthy discussion)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT+m+DKkuBuNlUUl1AQKqhQQAtROKG8BgKHFDI7N1mYNQY/QkPtpW589u
CzsxdCZP07QsDapORCud6dOrvR1RgpCh9/7aLLf4dNmGNB3Eq6X6TJkLuzYLkKAg
of2G4b/DwFrN3WV3dKoW5AqwnBh8NU7R9UwgOw10rWmmMxu4UFajEbBAe++7+3PX
4l8qDFTuDKE=
=mCTP
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--

