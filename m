Date: Thu, 3 Sep 2015 22:35:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150903203538.GE34798@...1296...>
References: <20150830002336.32791c7b.movrax-dev@...2061...>
	<20150830115444.GU34798@...1296...>
	<20150830162534.4ee0c9f2.movrax-dev@...2061...>
	<20150830203749.GW34798@...1296...>
	<20150903221836.04306e51.movrax-dev@...2061...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G2kvLHdEX2DcGdqq"
Content-Disposition: inline
In-Reply-To: <20150903221836.04306e51.movrax-dev@...2061...>
Subject: Re: [Openvpn-devel] [PATCH] Privileges not being dropped if the
 first connection is not successful
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Lukasz K." <movrax-dev@...2061...>
Cc: openvpn-devel@lists.sourceforge.net

--G2kvLHdEX2DcGdqq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 03, 2015 at 10:18:36PM +0200, Lukasz K. wrote:
> With above in mind I decided to introduce this change to the patch.
>=20
> I also included few other "improvements" to make the function appear
> more consistent and more obvious (like "c0->uid_gid_chroot_set =3D true"
> separated and put at the end of the block).
>=20
> At this point I'm leaving it up to you guys, this is just my another
> suggestion, compiled & tested with latest git ([2.3_git
> [git:master/291c227d2ccecaa9+]).

Thanks, and thanks for the explanations - as you could see, I'm not
very well acquainted with that particular section of the code (I'm more
the packet guy...).  We'll try to discuss this at the upcoming IRC
meeting next monday (#openvpn-devel on freenode.net) and then decide
which version we pick :-) - quite obviously it's a bug that needs
fixing.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--G2kvLHdEX2DcGdqq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVeivGakuBuNlUUl1AQIBCQP+LN7i18lyxYc9DtQCrMScqTRgRZkt3/r/
BBJGfM9/W1oYCFhBpBOunzjaNeo0M22yWDokr0wchFtjIhAXNdHkJvJ605VgczCu
lz0pa5ioLSmqKxx3RLiLuWdo9eXFAdi3duhN83YNPLVb0X5CvvX0cB0H1H/HwiK6
Vvf13R0M0MU=
=ZTkG
-----END PGP SIGNATURE-----

--G2kvLHdEX2DcGdqq--

