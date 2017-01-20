References: <20161227221539.329-1-list@...1798...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e6deb9e1-bc10-9085-4ebe-31e8e34b8b6b@...2080...>
Date: Fri, 20 Jan 2017 21:39:06 +0100
MIME-Version: 1.0
In-Reply-To: <20161227221539.329-1-list@...1798...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="dhUu4lqwNhT4SlltCK7nlscXMTukTPS9P"
Subject: Re: [Openvpn-devel] [PATCH 1/2] use automake tools to install
 systemd files
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dhUu4lqwNhT4SlltCK7nlscXMTukTPS9P
Content-Type: multipart/mixed; boundary="qgeAfWhcS1KHAdmpIBNCTTeI728W5NrW9";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <e6deb9e1-bc10-9085-4ebe-31e8e34b8b6b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] use automake tools to install systemd
	files
References: <20161227221539.329-1-list@...1798...>
In-Reply-To: <20161227221539.329-1-list@...1798...>

--qgeAfWhcS1KHAdmpIBNCTTeI728W5NrW9
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 27/12/16 23:15, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>=20
> If systemd is enabled we install unit files to $libdir/systemd/system
> (or the path specified by SYSTEMD_UNIT_DIR).
> The unit files are generated on the fly with matching $sbindir.
>=20
> Signed-off-by: Christian Hesse <mail@...1798...>
> ---
>  configure.ac                                       | 10 ++++++++
>  distro/Makefile.am                                 |  4 +---
>  distro/systemd/.gitignore                          |  1 +
>  distro/systemd/Makefile.am                         | 27 ++++++++++++++++=
++++++
>  ...-client@...1685... =3D> openvpn-client@...2221...} |  2 +-
>  ...-server@...1685... =3D> openvpn-server@...2221...} |  2 +-
>  6 files changed, 41 insertions(+), 5 deletions(-)
>  create mode 100644 distro/systemd/.gitignore
>  create mode 100644 distro/systemd/Makefile.am
>  rename distro/systemd/{openvpn-client@...1685... =3D> openvpn-client@...493...=
2221...} (89%)
>  rename distro/systemd/{openvpn-server@...1685... =3D> openvpn-server@...493...=
2221...} (83%)


Finally had some time to look at this!  Some comments below.

[...snip...]

> --- /dev/null
> +++ b/distro/systemd/.gitignore
> @@ -0,0 +1 @@
> +*.service
> \ No newline at end of file

I think it is better to put all of these things into the .gitignore file
in the project root directory.  I see that this have slipped through a
few times (./vendor, ./test/unit_tests and sample/sample-keys/) ... but
as do ignore directories in the "master" .gitignore, I think we should
have everything there.  It will be easier to know where to look.  And
rather split things up when that master file gets too long and complicated.


> diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
> new file mode 100644
> index 0000000..53a88c9
> --- /dev/null
> +++ b/distro/systemd/Makefile.am
> @@ -0,0 +1,27 @@
> +#
> +#  OpenVPN -- An application to securely tunnel IP networks
> +#             over a single UDP port, with support for SSL/TLS-based
> +#             session authentication and key exchange,
> +#             packet encryption, packet authentication, and
> +#             packet compression.
> +#
> +#  Copyright (C) 2017 OpenVPN Technologies, Inc. <sales@...515...>
> +#
> +
> +%.service: %.service.in Makefile
> +	$(AM_V_GEN)sed -e 's|\@sbindir\@|$(sbindir)|' \
> +		$< > $@.tmp && mv $@.tmp $@
> +
> +EXTRA_DIST =3D \
> +	openvpn-client@...2221... \
> +	openvpn-server@...2221...
> +
> +if ENABLE_SYSTEMD
> +systemdunitdir =3D $(systemdunitdir)

This conflicts with AC_SUBST([systemdunitdir]) in configure.ac.  So this
line should not be here.

[...snip....]

> diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/op=
envpn-client@...2221...
> similarity index 89%
> rename from distro/systemd/openvpn-client@...1685...
> rename to distro/systemd/openvpn-client@...2221...
> index 5618af3..d9fd6b0 100644
> --- a/distro/systemd/openvpn-client@...1685...
> +++ b/distro/systemd/openvpn-client@...2221...
> @@ -12,7 +12,7 @@ PrivateTmp=3Dtrue
>  RuntimeDirectory=3Dopenvpn-client
>  RuntimeDirectoryMode=3D0710
>  WorkingDirectory=3D/etc/openvpn/client
> -ExecStart=3D/usr/sbin/openvpn --suppress-timestamps --nobind --config %i=
.conf
> +ExecStart=3D@...2235...@ --suppress-timestamps --nobind --config %i.conf

It should be: ExecStart=3D@...2235...@/openvpn .... otherwise the generated
files are pointing at a only a directory.

[...snip....]

> diff --git a/distro/systemd/openvpn-server@...1685... b/distro/systemd/op=
envpn-server@...2221...
> similarity index 83%
> rename from distro/systemd/openvpn-server@...1685...
> rename to distro/systemd/openvpn-server@...2221...
> index b9b4dba..a270982 100644
> --- a/distro/systemd/openvpn-server@...1685...
> +++ b/distro/systemd/openvpn-server@...2221...
> @@ -12,7 +12,7 @@ PrivateTmp=3Dtrue
>  RuntimeDirectory=3Dopenvpn-server
>  RuntimeDirectoryMode=3D0710
>  WorkingDirectory=3D/etc/openvpn/server
> -ExecStart=3D/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log -=
-status-version 2 --suppress-timestamps --config %i.conf
> +ExecStart=3D@...2235...@ --status %t/openvpn-server/status-%i.log --status-=
version 2 --suppress-timestamps --config %i.conf

Same as above.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--qgeAfWhcS1KHAdmpIBNCTTeI728W5NrW9--

--dhUu4lqwNhT4SlltCK7nlscXMTukTPS9P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYgnVqAAoJEIbPlEyWcf3yGmsP/3Yx6z5u7CW2eRDul68KVhB3
fQR4Q9IHOKOr2H3HXP1XDxCC/dquLl/CMJEjD9YMMQNPtmreyUYL7+suC1KrLlEs
pm58QnjelcsdREPSuhfklXgKKUTcNKu6G8K9WEesmvDUjlsGFbAcL/D5miGa0dMz
DwQmg3F/7s/dHepwUdHZctbQwoqMJ5zrSs0y4TlUjQpk9puamlcmsaqcOnlRkcCs
Y87synwEJYAusyKvdZmiip3lq5733+NhymU8ZvXt3WF1X1BDhuOcPKgyn/VVhNLe
6Asu9EtqTGmM17RB6yV/2Wejw77G3jEUOyUG18q3T6WH/tcDJ2nNcMeGXxWaD2P5
pJ82w790S/7EN5JXYkA98NFFJkS0PZG8/B7GJqJsaUrXbTSzGHSxwGgIeXNIdqXY
U8/fZGNXmE2ZYWpVRaJMXA7lDPSrogIjTQvG1YbLOSZRbutTVEDQ8mM3I1X77o7B
6E+DR7JD3DAPwr56nuF1GZsQMgPjpC0TbJgt1JD8R+cxN9Q3ckVLSsnosjt8X/XZ
tqDVu8f5OIJ1DnO0AzU7Yq//cLxSVHEFud5TiOtoHXyilzHoIjpGpAUQ+qFzj2k7
bnzrblMPrIlzr5vzRGG7J/xBFl4W7cgIjeurQkrMthEjmX2nBsuPbiN7vy0IRDYl
L4Bf589OXuonzB0G0l3Z
=yQ0A
-----END PGP SIGNATURE-----

--dhUu4lqwNhT4SlltCK7nlscXMTukTPS9P--

