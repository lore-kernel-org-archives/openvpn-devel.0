Date: Tue, 24 Jan 2017 15:29:56 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20170124152956.50c16ef4@...1799...>
In-Reply-To: <e6deb9e1-bc10-9085-4ebe-31e8e34b8b6b@...2080...>
References: <20161227221539.329-1-list@...1798...>
	<e6deb9e1-bc10-9085-4ebe-31e8e34b8b6b@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/C1r=azAgNSRvcf==4AcFf2f";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH 1/2] use automake tools to install
 systemd files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/C1r=azAgNSRvcf==4AcFf2f
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <openvpn@...2080...> on Fri, 2017/01/20 21:39:
> On 27/12/16 23:15, Christian Hesse wrote:
> > From: Christian Hesse <mail@...1798...>
> >=20
> > If systemd is enabled we install unit files to $libdir/systemd/system
> > (or the path specified by SYSTEMD_UNIT_DIR).
> > The unit files are generated on the fly with matching $sbindir.
> >=20
> > Signed-off-by: Christian Hesse <mail@...1798...>
> > ---
> >  configure.ac                                       | 10 ++++++++
> >  distro/Makefile.am                                 |  4 +---
> >  distro/systemd/.gitignore                          |  1 +
> >  distro/systemd/Makefile.am                         | 27
> > ++++++++++++++++++++++ ...-client@...1685... =3D> openvpn-client@...2237...=
1...}
> > |  2 +- ...-server@...1685... =3D> openvpn-server@...2221...} |  2 +-
> >  6 files changed, 41 insertions(+), 5 deletions(-)
> >  create mode 100644 distro/systemd/.gitignore
> >  create mode 100644 distro/systemd/Makefile.am
> >  rename distro/systemd/{openvpn-client@...1685... =3D>
> > openvpn-client@...2221...} (89%) rename
> > distro/systemd/{openvpn-server@...1685... =3D> openvpn-server@...2238...=
.}
> > (83%)=20=20
>=20
>=20
> Finally had some time to look at this!  Some comments below.
>=20
> [...snip...]
>=20
> > --- /dev/null
> > +++ b/distro/systemd/.gitignore
> > @@ -0,0 +1 @@
> > +*.service
> > \ No newline at end of file=20=20
>=20
> I think it is better to put all of these things into the .gitignore file
> in the project root directory.  I see that this have slipped through a
> few times (./vendor, ./test/unit_tests and sample/sample-keys/) ... but
> as do ignore directories in the "master" .gitignore, I think we should
> have everything there.  It will be easier to know where to look.  And
> rather split things up when that master file gets too long and complicate=
d.

I was not sure where you want this...
Moved it up to the root.

> > diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
> > new file mode 100644
> > index 0000000..53a88c9
> > --- /dev/null
> > +++ b/distro/systemd/Makefile.am
> > @@ -0,0 +1,27 @@
> > +#
> > +#  OpenVPN -- An application to securely tunnel IP networks
> > +#             over a single UDP port, with support for SSL/TLS-based
> > +#             session authentication and key exchange,
> > +#             packet encryption, packet authentication, and
> > +#             packet compression.
> > +#
> > +#  Copyright (C) 2017 OpenVPN Technologies, Inc. <sales@...515...>
> > +#
> > +
> > +%.service: %.service.in Makefile
> > +	$(AM_V_GEN)sed -e 's|\@sbindir\@|$(sbindir)|' \
> > +		$< > $@.tmp && mv $@.tmp $@
> > +
> > +EXTRA_DIST =3D \
> > +	openvpn-client@...2221... \
> > +	openvpn-server@...2221...
> > +
> > +if ENABLE_SYSTEMD
> > +systemdunitdir =3D $(systemdunitdir)=20=20
>=20
> This conflicts with AC_SUBST([systemdunitdir]) in configure.ac.  So this
> line should not be here.

Removed.

> [...snip....]
>=20
> > diff --git a/distro/systemd/openvpn-client@...1685...
> > b/distro/systemd/openvpn-client@...2221... similarity index 89%
> > rename from distro/systemd/openvpn-client@...1685...
> > rename to distro/systemd/openvpn-client@...2221...
> > index 5618af3..d9fd6b0 100644
> > --- a/distro/systemd/openvpn-client@...1685...
> > +++ b/distro/systemd/openvpn-client@...2221...
> > @@ -12,7 +12,7 @@ PrivateTmp=3Dtrue
> >  RuntimeDirectory=3Dopenvpn-client
> >  RuntimeDirectoryMode=3D0710
> >  WorkingDirectory=3D/etc/openvpn/client
> > -ExecStart=3D/usr/sbin/openvpn --suppress-timestamps --nobind --config
> > %i.conf +ExecStart=3D@...2235...@ --suppress-timestamps --nobind --config
> > %i.conf=20=20
>=20
> It should be: ExecStart=3D@...2235...@/openvpn .... otherwise the generated
> files are pointing at a only a directory.

Ups, stupid me... Looks like I broke this with my final patch preparation. =
:-p

I will send updated patches soon.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/C1r=azAgNSRvcf==4AcFf2f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAliHZOQACgkQiUUh18yA
9HYq0Qf8DlPF2bFmedaaGyhRPiaIJumzrocDCpJhgesboJ2Zzwdh35AebIiLWXgR
GIFzJj0a2DRzCkl8hqZRpGzYdJBQKy6RV5leL5M9gVZ6ZajHVT1PbyodoYPqKxHh
Je8JTGI96wPLXZXp8bQgOArTYseJ10tEmYyq1bXksEcP+rhP+nEBYItLPtac4JJN
l2tMFvioJdGmHmoauKOO/EiA8TDJxH2/v1qIBdbfbIZLy3Tiua8NMJYzxsl+gwvC
AdCmFipAMywrWRyPjhcc9aEE3mWRaD+1/taSm5TSuVZgLTjQiOulAni2dLW7Qz0I
AIGhBFQtqq9e6ypV6Atg+j8v9JdOkA==
=Ro+X
-----END PGP SIGNATURE-----

--Sig_/C1r=azAgNSRvcf==4AcFf2f--

