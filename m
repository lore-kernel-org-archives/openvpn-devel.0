Date: Sun, 7 Aug 2011 20:20:19 +0200
From: Bertrand Jacquin <beber@...1472...>
Message-ID: <20110807182019.GX12223@...1474...>
References: <1312714757-10317-1-git-send-email-beber@...1472...>
	<430b86c89889b28e473dfed2fc3ae817@...1492...>
	<20110807175142.GS8496@...1296...>
	<20110807175624.GW12223@...1474...>
	<20110807181103.GV8496@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJFDFiWc3BlD0xT/"
Content-Disposition: inline
In-Reply-To: <20110807181103.GV8496@...1296...>
Subject: Re: [Openvpn-devel] Allow to fill Details tab for exe files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--oJFDFiWc3BlD0xT/
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

D'ar sul 07 a viz Eost 2011 e 20 eur 11, =C2=AB Gert Doering =C2=BB he deus=
 skrivet :
> Hi,
>=20
> On Sun, Aug 07, 2011 at 07:56:24PM +0200, Bertrand Jacquin wrote:
> > > Two questions:
> > >=20
> > >  - what happens if windres is not found?  will the compilation break?
> > >    (I'm not sure whether windres will always be there or not)
> >=20
> > In the present configure.ac, it's only needed when WIN32 =3D yes, so it=
's
> > windows/mingw only.
>=20
> Yes.  So mingw always has "windres"?  Otherwise the produced Makefiles
> won't work.

It always have, it's provided by bintutils

> > >  - if I read this right, it will only work for the autoconf / mingw b=
ased
> > >    build, but not for the msvc++ / python based build, right?  will it
> > >    co-exist, or break the python build?
> >=20
> > I have to say that I didn't test with msvc++/python as I only use to
> > cross compile applications. But if I read well the build process for
> > msvc++/python it does not use autotools stuffs.
>=20
> Indeed.  David / Samuli: how is the python Makefile built?  How does
> this build system know which files to compile?

Looking to install-win32/makeopenvpn, it run autotools and configure,
this may need some tweak :

*inux)
+ export WINDRES=3Di586-mingw32msvc-windres

Is there a windres equivalent for msvc ?

--=20
Beber

--oJFDFiWc3BlD0xT/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk4+12MACgkQibjJUzm7jPT/rwCfdqJKbQnrCpsMnlU8MJbHjJeC
v50AoIQWYdcNPwwzG6H5yaa70cXoAw4j
=UBEW
-----END PGP SIGNATURE-----

--oJFDFiWc3BlD0xT/--

