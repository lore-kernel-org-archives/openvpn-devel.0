Date: Sun, 13 May 2012 13:12:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120513111240.GK1359@...1296...>
References: <CAOazyz3QDHLxY51u0Ya9PscD8Q5+VqqrSn6M6=XpVUiFJY_ENw@...278...>
	<4FA8D931.70107@...515...>
	<CAOazyz2N744s+VJekGJNK4sqHCONLCzMtsiJyRTkgrpO4RWHzw@...278...>
	<363B57F6-F3E8-4C7D-A19D-0E08541233BD@...1286...>
	<20120513090153.GG1359@...1296...>
	<CAOazyz1FB+JU7QRmeMuxMX7-6fAN28VH1-6ApJnOu7eHDq9jUA@...278...>
	<20120513092355.GH1359@...1296...>
	<CAOazyz0=+ZE6+n-KqyzZSJhbweHb236LjwefvV6BtMvfbh37mQ@...278...>
	<20120513093551.GI1359@...1296...>
	<CAOazyz0bEZMBYcKGvKTux=+7XE43=-4Aw02HGVCNHPoO35wAWg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ucs4qKRCQ5qF2iRD"
Content-Disposition: inline
In-Reply-To: <CAOazyz0bEZMBYcKGvKTux=+7XE43=-4Aw02HGVCNHPoO35wAWg@...278...>
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--Ucs4qKRCQ5qF2iRD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, May 13, 2012 at 02:00:32PM +0300, Alon Bar-Lev wrote:
> >> Can't we progress?
> >
> > Why is that progress?
> >
> > Change always has drawbacks. =A0If the plus sides outweighs the drawbac=
ks,
> > change is good. =A0Change for change's sake, "just because you can chan=
ge
> > it", is not.
>=20
> Yes, but still from your responses I don't see any drawback... maybe I
> am slow learner...

Drawback to maintainers and sysadmins has already been mentioned by
ecrist and me.  Try being a sysadmin for a few weeks and figure out
which bits of xorg you need to download to install xinit, assuming
you have a system without any X libraries and headers yet (in the xorg
example: splitting off "xinit" might actually make sense, but splitting
the basic infrastructure to build anything into about 50 different
"xyz-library" and "xyz-headers" packages is crazyness).

But the onus is not particularily on me: you have not put forward=20
convincing arguments why splitting off a very small number of files=20
that only make use in the context of OpenVPN into their own repository=20
has any *advantage*.

The handwavy argument "it will attract more users!" can be countered by
similarily handwaving "I, as a user, hate to download multiple packages
to figure out how to start contributing, and so it will scare *away*
users".


As a counterexample, look at Apache.  They have heaps of modules in
the main tarball, and have no issues with frequent release and with
attracting developers.  And still, modules maintained by non-apache
developers can be developed externally, without having to splitt off
all existing modules beforehand.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Ucs4qKRCQ5qF2iRD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT6+XKKkuBuNlUUl1AQJuhQP/cnxwEJY5O2fvSp2/gk9yOpXpVxIDDZG4
HrQIm2k5vV2sKYZunCu5iUimWawuQ2VU94qgyScOyicWb4GjOyDpM3D8WNnmHLFQ
jXSSxL35D7LTwNG9Q7DQvV5CestyK+6pbcmndAcl34aq7GUa64o77CQpj90pRMJh
FjJgBd9f8NM=
=sUVW
-----END PGP SIGNATURE-----

--Ucs4qKRCQ5qF2iRD--

