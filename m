From: "Doncho N. Gunchev" <mr700@...184...>
Reply-To: mr700@...184...
Subject: Re: [Openvpn-devel] bugfix: SuSE handling in openvpn.spec
References: <41B0734E.3010105@...324...> <200412031618.44206@...187...> <41B07B80.6070102@...324...>
In-Reply-To: <41B07B80.6070102@...324...>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2385248.nLVi3hATgH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412031747.13217@...187...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Dec  3 07:48:04 2004
To: openvpn-devel@lists.sourceforge.net
Cc: Stefan Engel <mail@...324...>

--nextPart2385248.nLVi3hATgH
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

    (ops... I missed openvpn-devel, sorry)

On 2004 12 03 (Friday) 16:43, Stefan Engel wrote:
> Doncho N. Gunchev wrote:
> > On 2004 12 03 (Friday) 16:08, Stefan Engel wrote:
> >=20
> >>Hi,
> >>
> >>there is a minor bug in openvpn.spec (v2.0_beta19). In the %files
> >>section the init script is always taken from /etc/rc.d/init.d instead
> >>of /etc/init.d in case of a SuSE distribution. This results in an
> >>rpm build error on SuSE systems.
...
> >=20
> > =A0 =A0 What gives "rpm --eval '%{_initrddir}'" on SuSE? In RH/FC it gi=
ves
> > "/etc/rc.d/init.d", which I use in my .spec file:
> > --- cut ---
> > # to fix later: '--program-suffix 2' is optional, so use * here
> > %{_initrddir}/*
> > --- cut ---
...
>=20
> Using %{_initrddir} would be fine, if all rpm installation
> would treat it correctly.
>=20
> SuSE 9.2 correctly reports /etc/init.d, but SuSE 9.1 doesn't :-(
>=20
> rpm --eval '%{_initrddir}' results, _initrddir is defined in
> /usr/lib/rpm/i386-linux/macros:
>=20
> SuSE 9.1: /etc/rc.d/init.d
> %_initrddir =A0 =A0 =A0 =A0 =A0 =A0 %{_sysconfdir}/rc.d/init.d
>=20
> SuSE 9.2: /etc/init.d
> %_initrddir =A0 =A0 =A0 =A0 =A0 =A0 %{_sysconfdir}/init.d
>=20
> SuSE 9.1 has no directory /etc/rc.d/init.d. Instead /etc/rc.d is
> a link to /etc/init.d thus resulting in /etc/init.d/init.d. This
> messes up the installation of the init-script.
>=20
> The tests for SuSE in the spec file are correct in
> sections %description, %install, %post and %preun, they are
> only missing in the %files section.
>=20

=A0 =A0 I stilt hink %{_initrddir}/openvpn is the 'right(tm) thing' to use.
Wouldn't it be better to override %_initrddir for SuSE 9.1 (or any SuSE)
instead of branching %files (%define _initrddir %{_sysconfdir}/init.d)?
I wish rpm was much more compatible between distros, but Mandrake's rpm
differs too :(
=A0 =A0 Can someone check these on mandrake? I verified %_initrddir is
fine for FC1, FC2 and FC3 (most likely for RH9 and ASP Linux too).

--=20
Regards,
=A0 Doncho N. Gunchev =A0 =A0Registered Linux User #291323 at counter.li.org
=A0 GPG-Key-ID: 1024D/DA454F79 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0http://pgp.mit.edu
=A0 Key fingerprint =3D 684F 688B C508 C609 0371 =A05E0F A089 CB15 DA45 4F79

--nextPart2385248.nLVi3hATgH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBsIqBoInLFdpFT3kRAj7xAKCqEgZD5zLpxIrYat7UCAB811Ce8wCgzhHN
oG4WDdPIVS6O/024rs31LB4=
=nU4O
-----END PGP SIGNATURE-----

--nextPart2385248.nLVi3hATgH--

