Date: Fri, 6 Nov 2015 22:12:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151106211238.GB24952@...1296...>
References: <1446663578-14471-1-git-send-email-selva.nair@...277...>
	<201511062108.tA6L8x2n034456@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NqNl6FRZtoRUn5bW"
Content-Disposition: inline
In-Reply-To: <201511062108.tA6L8x2n034456@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix termination when
 windows suspends/sleeps
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--NqNl6FRZtoRUn5bW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 06, 2015 at 10:08:59PM +0100, Gert Doering wrote:
> ACK.  Explanation makes sense, logs and testers demonstrate that it indeed
> fixes a significant problem, and the code is sane :-) - thanks.
>=20
> Your patch has been applied to the master and release/2.3 branch.
>=20
> commit ea66a2b5cdb21422139c421b4d3733e1c1c3937e (master)
> commit 0d4ba251879c702b9474e26ff73a4f559d922d4f (release/2.3)

Uh, and because I forgot to mention it - Samuli's buildbot will build a=20
windows snapshot from git master containing this, and it will be part=20
of 2.3.9 when we release this (no timeline yet).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--NqNl6FRZtoRUn5bW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVj0XxqkuBuNlUUl1AQJGCgP+LqB2sohXYXLhAHThrCvcd1mKg8A1QzzU
cLaxuO4AWQUHqrK+rGV48P0mbqgqwrroH2hnCSzVY03zHoR4igtge611dItAyRvb
9kuA7mdjVKcFP3zIBHR69dKal7U1tKcmcwToBVGWxk/SJCvoShIUwZ7gxq77U62A
q95UUFpGbTU=
=pnyJ
-----END PGP SIGNATURE-----

--NqNl6FRZtoRUn5bW--

