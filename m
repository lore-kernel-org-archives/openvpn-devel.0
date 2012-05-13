Date: Sun, 13 May 2012 22:39:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120513203911.GR1359@...1296...>
References: <20120513093551.GI1359@...1296...>
	<CAOazyz0bEZMBYcKGvKTux=+7XE43=-4Aw02HGVCNHPoO35wAWg@...278...>
	<20120513111240.GK1359@...1296...>
	<CAOazyz1keZzQjqeUoUSQ88UzVn3=BMz1FWRp0KiB+gS6-43HhQ@...278...>
	<20120513121906.GL1359@...1296...>
	<CAOazyz3WetA0vHpm965krjKm=OiFovT1JRi39T9kOY2sf7-khA@...278...>
	<20120513130750.GN1359@...1296...>
	<CAOazyz1hA7EGOhoOtOgNgAcH91Y4crs1TrTzgDbC6_MbgA8reQ@...278...>
	<20120513181038.GP1359@...1296...>
	<CAOazyz2NzD76kqdM4v+fPK4uuvCd6E-oh79EpGv5p1K=ZZTucw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZlEdUFxvOsanRnDp"
Content-Disposition: inline
In-Reply-To: <CAOazyz2NzD76kqdM4v+fPK4uuvCd6E-oh79EpGv5p1K=ZZTucw@...278...>
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

--ZlEdUFxvOsanRnDp
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, May 13, 2012 at 09:23:04PM +0300, Alon Bar-Lev wrote:
> > Huh? =A0You're the master of Autoconf, and I'm sure you will be able to
> > produce a working PAM detection for those platforms that have it.
>=20
> Yes, and as such I tell you that automatic detection is something that
> leads to package breakage.
> We already discussed that in the lzo subject.

We're not talking about extra libraries that might or might not be there -
on all systems I named, PAM is part of the basic operating system, as
is "libc" or one of the zillion header files that you're currently testing
for.

> I know you are fundamentally against any change, but I think I proved
> very well that I actually know what I am doing.

Now you are the one who is opposing change.  You asked what we want, and
if the plugins should not be split, how the build system should be adapted.

This is what I answered: if we want to adapt the build system for the
plugins, compile them by default, and install them.  And now you're finding
reasons why this is bad.

Fine, leave it at that - there's quite obviously not much support for the
split, and since you do not want to compile & install by default, nobody
can force you to implement that.


> >> >> These plugins should be optional I don't see any value in enforcing
> >> >> them and their dependencies.
> >> >
> >> > If these plugins are useful for a large number of users, there is no
> >> > point in not installing them by default.
> >>
> >> They are not.
> >
> > Unfounded claim.
>=20
> I know one or two installations, and I am tracking this project more
> than 6 years.
> Come on! most of installations are plain public key without any of
> these plugins.

All our corporate servers *do* use auth-pam.  Which is crucial if you
want to do things like OTP passwords that are handled by PAM - many
vendor solutions provide PAM modules, and it's quite nice to be able
to use those without any extra hoops.

For the record, these servers user FreeBSD with the default port, which
*does* install both plugins, and I find that tremendously useful.

ovsrv1$ pkg_info -W /usr/local/lib/openvpn-auth-pam.so
/usr/local/lib/openvpn-auth-pam.so was installed by package openvpn-devel-2=
01034


> There is no need for these if you configure your server.

How do you know what I need for my servers?  I *do* need them for my
server, and I'm very happy that the FreeBSD port saves me from having
to worry about the plugins manually every time I install a new OpenVPN
version.

> I simply don't understand your attitude... sorry, I simply don't.

My attitude is very simple.  I'm a sysadmin and network admin, do IPv6=20
deployments, and regularily have to fight open source software that comes
with non-useful defaults.

Everything that creates extra work for sysadmins is bad.

Everything that brings in religion and delays software releases for=20
"purity" reasons, while people are waiting for features to be delivered
(and have to live with patched packages, instead of using upstream sources
directly) is bad.

Too-complex software is *bad*.  Stuff that looks nice while in computer
science class, but that will bring in more complex failure modes - because
that will inevitably one day bite an overworked sysadmin, and they do not
like that.


> >> BTW: Packager of what platform are you?
> >
> > openwrt. =A0Not that this is of any relevance.
>=20
> Exactly, so I think I am more experienced distro maintainer,=20

Which OpenVPN package are you maintaining, please remind me again?

(I am also going to win any dick size war, of course, but that's also
non relevant as I'm already married)

> please
> understand that I am taking from first hand experience, and I would
> like to help, plain positive help... I really don't understand why you
> are trying to force your opinion if you have theoretical knowledge.

*cough*

> BTW: openwrt is a good example of a platform that does not need these
> plugins right?

Indeed.  So, yes, you have won.  Don't enable them in the build system.

Remind me again why I am bothering?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ZlEdUFxvOsanRnDp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT7Ab7qkuBuNlUUl1AQLN3AP+P1qh97JrdglAF53Yfw8tUUgPhfCiq2DM
QvRGA1C90tzlgMg3yVLhSIC5kM2TYW2fh84pZIAsAFFH3hYDhFl8dIarrZHyfJKx
Pdc9ITcxRX1kT61vqYcL+jK3wk9FGEF+A4jfjJDTr+31vkxGtoqsubdhJUuN7xxb
fynIZcGWVHs=
=1GgD
-----END PGP SIGNATURE-----

--ZlEdUFxvOsanRnDp--

