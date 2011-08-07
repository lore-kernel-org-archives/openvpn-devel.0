Date: Sun, 7 Aug 2011 19:56:24 +0200
From: Bertrand Jacquin <beber@...1472...>
Message-ID: <20110807175624.GW12223@...1474...>
References: <1312714757-10317-1-git-send-email-beber@...1472...>
	<430b86c89889b28e473dfed2fc3ae817@...1492...>
	<20110807175142.GS8496@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A1VS04HCCjrR2aaM"
Content-Disposition: inline
In-Reply-To: <20110807175142.GS8496@...1296...>
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

--A1VS04HCCjrR2aaM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

D'ar sul 07 a viz Eost 2011 e 19 eur 51, =C2=AB Gert Doering =C2=BB he deus=
 skrivet :
> Hi,
>=20
> On Sun, Aug 07, 2011 at 04:13:03PM +0200, Bertrand Jacquin wrote:
> > > [PATCH 1/4] WIN32: Check for windres tool
> > > [PATCH 2/4] Win32: Add OpenVPN RC file to add fill "Details" exe
> > > [PATCH 3/4] Win32: Fill "Details" properties for openvpn.exe
> > > [PATCH 4/4] Win32: Fill "Details" properties for openvpnserv.exe
> >=20
> >  I just can't figure out why my patch are not diffused even when SF MX=
=20
> >  say they have been accepted.
>=20
> Your patches have arrived here just fine.
>=20
> I think the functionality is useful, but don't know enough about windows
> to give this a full technical ACK.

Oh, ok, maybe some huge spool on SF, doono

> Two questions:
>=20
>  - what happens if windres is not found?  will the compilation break?
>    (I'm not sure whether windres will always be there or not)

In the present configure.ac, it's only needed when WIN32 =3D yes, so it's
windows/mingw only.

>  - if I read this right, it will only work for the autoconf / mingw based
>    build, but not for the msvc++ / python based build, right?  will it
>    co-exist, or break the python build?

I have to say that I didn't test with msvc++/python as I only use to
cross compile applications. But if I read well the build process for
msvc++/python it does not use autotools stuffs.

--=20
Beber

--A1VS04HCCjrR2aaM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk4+0cgACgkQibjJUzm7jPRwZgCggm4DLivPwIupYKHGT+mu4lZE
XlYAn0LbbNozYVBlmiI4NDQtqDY/Lc5q
=Wvf/
-----END PGP SIGNATURE-----

--A1VS04HCCjrR2aaM--

