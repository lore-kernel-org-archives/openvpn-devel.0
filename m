Date: Sun, 13 May 2012 20:10:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120513181038.GP1359@...1296...>
References: <20120513092355.GH1359@...1296...>
	<CAOazyz0=+ZE6+n-KqyzZSJhbweHb236LjwefvV6BtMvfbh37mQ@...278...>
	<20120513093551.GI1359@...1296...>
	<CAOazyz0bEZMBYcKGvKTux=+7XE43=-4Aw02HGVCNHPoO35wAWg@...278...>
	<20120513111240.GK1359@...1296...>
	<CAOazyz1keZzQjqeUoUSQ88UzVn3=BMz1FWRp0KiB+gS6-43HhQ@...278...>
	<20120513121906.GL1359@...1296...>
	<CAOazyz3WetA0vHpm965krjKm=OiFovT1JRi39T9kOY2sf7-khA@...278...>
	<20120513130750.GN1359@...1296...>
	<CAOazyz1hA7EGOhoOtOgNgAcH91Y4crs1TrTzgDbC6_MbgA8reQ@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kzvrekJ+sq1BSJP/"
Content-Disposition: inline
In-Reply-To: <CAOazyz1hA7EGOhoOtOgNgAcH91Y4crs1TrTzgDbC6_MbgA8reQ@...278...>
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

--kzvrekJ+sq1BSJP/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, May 13, 2012 at 04:10:54PM +0300, Alon Bar-Lev wrote:
> >> And always have pam dependency for this example?
> >
> > FreeBSD, NetBSD, all Linuxes and Solaris have PAM anyway.
> >
> > So make this "if pam libraries + headers are detected, install auth-pam,
> > otherwise, not".
>=20
> We already discussed the automatic detection and integrity failure as res=
ult.

Huh?  You're the master of Autoconf, and I'm sure you will be able to
produce a working PAM detection for those platforms that have it.

> >> These plugins should be optional I don't see any value in enforcing
> >> them and their dependencies.
> >
> > If these plugins are useful for a large number of users, there is no
> > point in not installing them by default.
>=20
> They are not.

Unfounded claim.

> Exactly because the are not useful, I am for the split.
> Anyway, if you follow the apache example there is explicit
> enable/disable to each.

And there are some that are enabled by default.  Your point?

> BTW: Packager of what platform are you?

openwrt.  Not that this is of any relevance.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--kzvrekJ+sq1BSJP/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT6/5HqkuBuNlUUl1AQKWDQP/UeVE5E5DgnjIF5TpFYgUi6nUBh6wArDK
svzTUF/ySMeGjTQGPr8ktsyjNtjl1L85wo+icBMAUliuq+jmgHIEzD/idYXNrQ4x
ZT+gUEoVO3EMe2ERfquSPKDMBsaJOhvdicXFgGY7DzuWMWVvbiERXe1aWLbG68/u
6enBbRzvAIc=
=TLI3
-----END PGP SIGNATURE-----

--kzvrekJ+sq1BSJP/--

