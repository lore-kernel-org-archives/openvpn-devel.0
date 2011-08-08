Date: Mon, 8 Aug 2011 10:17:48 +0200
From: Bertrand Jacquin <beber@...1472...>
Message-ID: <20110808081747.GA1470@...1493...>
References: <1312714757-10317-1-git-send-email-beber@...1472...>
	<430b86c89889b28e473dfed2fc3ae817@...1492...>
	<20110807175142.GS8496@...1296...>
	<20110807175624.GW12223@...1474...>
	<20110807181103.GV8496@...1296...>
	<20110807182019.GX12223@...1474...>
	<4E3F99EF.7060608@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <4E3F99EF.7060608@...515...>
Subject: Re: [Openvpn-devel] Allow to fill Details tab for exe files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

D'ar lun 08 a viz Eost 2011 e 10 eur 10, =AB Samuli Sepp=E4nen =BB he deus =
skrivet :
>=20
> > Looking to install-win32/makeopenvpn, it run autotools and configure,
> > this may need some tweak :
> >
> > *inux)
> > + export WINDRES=3Di586-mingw32msvc-windres

I've updated my branch with a fix for that

> > Is there a windres equivalent for msvc ?
> There certainly a way to do the same thing using msvc or Python code
> that runs after the build. Does windres simply convert the resource file
> to another format?

Yes and check the format :

$ file openvpn-res.o=20
openvpn-res.o: ACB archive data

> Or does it also embed it to the executable?

It need to be embed in the executable yes, as a classic object.

> Looks to
> me as if embedding/linking is triggered by the new linker flags
> (openvpn_LDADD), but then again my automake-fu is _very_ limited.

It does. If you add openvpn-res.rc to openvpn_SOURCES it will never be
build as not a classic extension. So it's define as a link dependencies,
and manual conversion is precise. I didn't find a way to use only
automake syntax to build rc file using windres.

Also, the openvpn-res.rc is shared between openvpn.exe and openvpnserv.exe,
they may need to be duplicated, I need some advise from the project
about this.

--=20
Beber
On Lady Voodoo

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4/m6sACgkQibjJUzm7jPSaNACghoDE5HfyNM0RNqzX1g2rD2sF
PasAmQG1+p93XBuO6NvpulhzAM2WcnUl
=06lB
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

