Date: Fri, 26 Feb 2016 11:01:14 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160226100114.GS24952@...1296...>
References: <1454876492-6588-1-git-send-email-lstipakov@...277...>
	<201602101018.u1AAI4mK027218@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/wvwr1yJUKb5v2MF"
Content-Disposition: inline
In-Reply-To: <201602101018.u1AAI4mK027218@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Report Windows bitness
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--/wvwr1yJUKb5v2MF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 10, 2016 at 11:18:04AM +0100, Gert Doering wrote:
> ACK.  Looks reasonable, tested with a 32bit binary on 64bit windows, works
> (have not tested all possible combinations due to resource constraints,
> will test as soon as buildbot provides installers)
>=20
> Your patch has been applied to the master branch.
>=20
> I'll apply this to release/2.3 as well as it nicely complements 84eb66bf7=
8b0
> (but want to have this tested on all platforms first)
>=20
> commit 15f78acfae2f99b74a72b5766559f28c2d1d3cac (master)

  commit 6a8e946174509ca50c63842f155ce5c90cfe43e0 (release/2.3)

this has now also been applied to the release/2.3 branch - I've tested it
on a number of different win7 machines (32bit only, 32-on-64, ...) and it=20
seems to do the right thing for all my systems.

Haven't built an XP binary yet, haven't tested on 8/10, but the code
looks like it *should* not cause issues...  (and if the build breaks=20
for XP, Samuli's Windows-Buildbot will tell me RSN)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--/wvwr1yJUKb5v2MF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVtAiaakuBuNlUUl1AQIL+AQAtZVUYyZcRq21D7cns3Mr5fJvD5fQxzgp
vn9I9f9n1npeXIf4Mam3g3jBSXjSyf+KOphMWa6DPf4piAjOz9K/5OzDIBbYChRG
Rl9nJxbMVDXu/kftFExNYGUkyp/8D09x9es9xDaadmZe5+Ns37EjjoVZzCX2E7pi
rNvfNyC8q44=
=67Nk
-----END PGP SIGNATURE-----

--/wvwr1yJUKb5v2MF--

