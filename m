Date: Tue, 24 Jan 2017 15:36:47 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20170124153647.5510c8a5@...1799...>
In-Reply-To: <bfee252f-300d-299c-89e9-197d1cd7b3fc@...2080...>
References: <20161227221539.329-1-list@...1798...>
	<20161227221539.329-2-list@...1798...>
	<bfee252f-300d-299c-89e9-197d1cd7b3fc@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/XjjXLfcSX8ZE0sziS+wgsvW";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH 2/2] do not race on RuntimeDirectory
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Christian Hesse <mail@...1798...>, openvpn-devel@lists.sourceforge.net

--Sig_/XjjXLfcSX8ZE0sziS+wgsvW
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <openvpn@...2080...> on Fri, 2017/01/20 21:55:
> On 27/12/16 23:15, Christian Hesse wrote:
> > From: Christian Hesse <mail@...1798...>
> >=20
> > Different unit instances create and destroy the same RuntimeDirectory.
> > This leads to running instances where the status file (and possibly
> > more runtime data) is no longer accessible.
> >=20
> > So do not handle this in unit files but provide a tmpfiles.d
> > configuration and let systemd-tmpfiles do the work.
> > Nobody will (unintentionally) delete the directories and its content.
> > As /run is volatile we do not have to care about cleanup.
> >=20
> > Signed-off-by: Christian Hesse <mail@...1798...>
> > ---
> >  configure.ac                              | 8 ++++++++
> >  distro/systemd/Makefile.am                | 8 ++++++++
> >  distro/systemd/openvpn-client@...2221... | 2 --
> >  distro/systemd/openvpn-server@...2221... | 2 --
> >  distro/systemd/openvpn.conf               | 2 ++
> >  5 files changed, 18 insertions(+), 4 deletions(-)
> >  create mode 100644 distro/systemd/openvpn.conf
> >=20=20=20
>=20
> [...snip...]
>=20
> > diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
> > index 53a88c9..1a6c974 100644
> > --- a/distro/systemd/Makefile.am
> > +++ b/distro/systemd/Makefile.am
> > @@ -12,7 +12,12 @@
> >  	$(AM_V_GEN)sed -e 's|\@sbindir\@|$(sbindir)|' \
> >  		$< > $@.tmp && mv $@.tmp $@
> >=20=20
> > +install-data-local:
> > +	$(INSTALL) -d -m0710 $(DESTDIR)/run/openvpn-client
> > +	$(INSTALL) -d -m0710 $(DESTDIR)/run/openvpn-server=20=20
>=20
> Hmm ... that doesn't make much sense, does it?
>=20
> $ mount | grep '/run '
> tmpfs on /run type tmpfs (rw,nosuid,nodev,seclabel,mode=3D755)
>=20
> IIRC, upstream systemd recommends /run to be a ramdisk, as it should
> always be clean on freshly rebooted systems.  And it probably saves a
> lot of SSD/flash storage write cycles, for those using that.

Well, the idea is: Files in /usr/lib/tmpfiles.d/ are handled by
systemd-tmpfiles at boot time. We want these directories after installation
(without a reboot) to be present - so just create them. Yes, these reside on
tmpfs, but are created automatically after reboot.

As package managers should run a hook if files in /usr/lib/tmpfiles.d/ chan=
ge
(pacman does now) I am fine with removing this rule.

People installing manually may still stumble on this...

> [...snip...]
>=20
> > @@ -21,6 +26,9 @@ systemdunitdir =3D $(systemdunitdir)
> >  systemdunit_DATA =3D \
> >  	openvpn-client@...1685... \
> >  	openvpn-server@...1685...
> > +tmpfilesdir =3D $(tmpfilesdir)=20=20
>=20
> This conflicts with AC_SUBST([tmpfilesdir])
>=20
> $ autoreconf -vi
> autoreconf: Entering directory `.'
> autoreconf: configure.ac: not using Gettext
> autoreconf: running: aclocal -I m4
> autoreconf: configure.ac: tracing
> autoreconf: running: libtoolize --copy
> autoreconf: running: /usr/bin/autoconf
> autoreconf: running: /usr/bin/autoheader
> autoreconf: running: automake --add-missing --copy --no-force
> distro/systemd/Makefile.am:28: warning: tmpfilesdir was already defined
> in condition TRUE, which includes condition ENABLE_SYSTEMD ...
> configure.ac:1293: ... 'tmpfilesdir' previously defined here
> autoreconf: Leaving directory `.'
> $ rpm -q autoconf
> autoconf-2.69-11.el7.noarch
>=20
> Removing that tmpfilesdir declaration line in Makefile.am resolves this
> issue, and it still works as expected.

Removed.

> [...snip...]
>=20
> > diff --git a/distro/systemd/openvpn.conf b/distro/systemd/openvpn.conf
> > new file mode 100644
> > index 0000000..57f20cd
> > --- /dev/null
> > +++ b/distro/systemd/openvpn.conf
> > @@ -0,0 +1,2 @@
> > +d /run/openvpn-client 0710 root root -
> > +d /run/openvpn-server 0710 root root -
> > \ No newline at end of file=20=20
>=20
> This makes more sense though, as this will tell systemd to create these
> directories with the proper attributes.
>=20
> But I'm not too happy about the filename in our git repository.  The
> destination file may very well be called openvpn.conf, as then it should
> reside in $libdir/tmpfiles.d/ ... but openvpn.conf causes quite a bit of
> ambiguity inside the openvpn source tree, and unaware users might more
> see this as a sample configuration for OpenVPN and be even more confused.
>=20
> I propose ... either rename this file to tmpfiles.d--openvpn.conf or
> move this openvpn.conf inside a tmpfiles.d/ subdirectory inside the
> ./distro/systemd/ directory.
>=20
> Otherwise, this looks very reasonable.

Reworked this... Are we ok renaming the file in automake target
install-data-hook? Could not come up with a better solution.

I will send an updated patch soon.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/XjjXLfcSX8ZE0sziS+wgsvW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAliHZn8ACgkQiUUh18yA
9HZyuAgAkWrpi0nA2SC4YobgaZ1I10OyZHQztpqLPcCXmFlpOd/Sg9Rjwm8mgcVF
vjJM2BQCkKm4GxFhLMyxXfDlyMxyaaFDgpP/6Bxyz8YSNjsDQF2swCc5WUbNswd/
F3BviCJq2N7+4faMXBlUVd5/EamO1EB5c8Hv45JfktNindoAkoYvDE8LI+BLhTEH
mdfuWU2OakPXJVMMyTp7JIr0qtjp6+1SoaqS9/JEe33zt3wlmUZqj3SbDrf1Gzrg
+cF0oeI2uxm7UQWoYHJ5/0uQVMsci0JvLYeBlTYCdvGPHqJOvz2+Cn6ln4u2tsj+
1pvRZv6CWDBdFTptvowQCH+reAduPg==
=kCyQ
-----END PGP SIGNATURE-----

--Sig_/XjjXLfcSX8ZE0sziS+wgsvW--

