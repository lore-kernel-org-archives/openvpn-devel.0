Date: Sun, 7 Aug 2011 20:11:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110807181103.GV8496@...1296...>
References: <1312714757-10317-1-git-send-email-beber@...1472...>
	<430b86c89889b28e473dfed2fc3ae817@...1492...>
	<20110807175142.GS8496@...1296...>
	<20110807175624.GW12223@...1474...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MveNns2vwg5u+Dv2"
Content-Disposition: inline
In-Reply-To: <20110807175624.GW12223@...1474...>
Subject: Re: [Openvpn-devel] Allow to fill Details tab for exe files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Bertrand Jacquin <beber@...1472...>
Cc: openvpn-devel@lists.sourceforge.net

--MveNns2vwg5u+Dv2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Aug 07, 2011 at 07:56:24PM +0200, Bertrand Jacquin wrote:
> > Two questions:
> >=20
> >  - what happens if windres is not found?  will the compilation break?
> >    (I'm not sure whether windres will always be there or not)
>=20
> In the present configure.ac, it's only needed when WIN32 =3D yes, so it's
> windows/mingw only.

Yes.  So mingw always has "windres"?  Otherwise the produced Makefiles
won't work.

> >  - if I read this right, it will only work for the autoconf / mingw bas=
ed
> >    build, but not for the msvc++ / python based build, right?  will it
> >    co-exist, or break the python build?
>=20
> I have to say that I didn't test with msvc++/python as I only use to
> cross compile applications. But if I read well the build process for
> msvc++/python it does not use autotools stuffs.

Indeed.  David / Samuli: how is the python Makefile built?  How does
this build system know which files to compile?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MveNns2vwg5u+Dv2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTj7VN6kuBuNlUUl1AQKJ0AP/VGHK9dli8xllDBzRkBOMlcJpcZjjBYYP
z6OyDwrUlU6DuCmfe7rqS/hpn78JNQ8xi1ee0x372eiffR4lB4fTEkgLjUFdFmX9
1/fAwibLIvL0fDBmCY8ZiScJwNbBGjU6wVWQ/5qM2iJTCbgsaP9rr/OhXAmKfR/S
BwGmPV/WnsQ=
=BalH
-----END PGP SIGNATURE-----

--MveNns2vwg5u+Dv2--

