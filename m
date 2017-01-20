References: <20161227221539.329-1-list@...1798...>
	<20161227221539.329-2-list@...1798...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <bfee252f-300d-299c-89e9-197d1cd7b3fc@...2080...>
Date: Fri, 20 Jan 2017 21:55:48 +0100
MIME-Version: 1.0
In-Reply-To: <20161227221539.329-2-list@...1798...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="x0h77wkJ03GhciBCb0wiB9J5jruwDXmi5"
Subject: Re: [Openvpn-devel] [PATCH 2/2] do not race on RuntimeDirectory
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x0h77wkJ03GhciBCb0wiB9J5jruwDXmi5
Content-Type: multipart/mixed; boundary="kWI2nbVfoNoKbqGphOOQfHe9tTMTADNXb";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>,
	OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>
Message-ID: <bfee252f-300d-299c-89e9-197d1cd7b3fc@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] do not race on RuntimeDirectory
References: <20161227221539.329-1-list@...1798...>
	<20161227221539.329-2-list@...1798...>
In-Reply-To: <20161227221539.329-2-list@...1798...>

--kWI2nbVfoNoKbqGphOOQfHe9tTMTADNXb
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 27/12/16 23:15, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>=20
> Different unit instances create and destroy the same RuntimeDirectory.
> This leads to running instances where the status file (and possibly
> more runtime data) is no longer accessible.
>=20
> So do not handle this in unit files but provide a tmpfiles.d
> configuration and let systemd-tmpfiles do the work.
> Nobody will (unintentionally) delete the directories and its content.
> As /run is volatile we do not have to care about cleanup.
>=20
> Signed-off-by: Christian Hesse <mail@...1798...>
> ---
>  configure.ac                              | 8 ++++++++
>  distro/systemd/Makefile.am                | 8 ++++++++
>  distro/systemd/openvpn-client@...2221... | 2 --
>  distro/systemd/openvpn-server@...2221... | 2 --
>  distro/systemd/openvpn.conf               | 2 ++
>  5 files changed, 18 insertions(+), 4 deletions(-)
>  create mode 100644 distro/systemd/openvpn.conf
>=20

[...snip...]

> diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
> index 53a88c9..1a6c974 100644
> --- a/distro/systemd/Makefile.am
> +++ b/distro/systemd/Makefile.am
> @@ -12,7 +12,12 @@
>  	$(AM_V_GEN)sed -e 's|\@sbindir\@|$(sbindir)|' \
>  		$< > $@.tmp && mv $@.tmp $@
>=20=20
> +install-data-local:
> +	$(INSTALL) -d -m0710 $(DESTDIR)/run/openvpn-client
> +	$(INSTALL) -d -m0710 $(DESTDIR)/run/openvpn-server

Hmm ... that doesn't make much sense, does it?

$ mount | grep '/run '
tmpfs on /run type tmpfs (rw,nosuid,nodev,seclabel,mode=3D755)

IIRC, upstream systemd recommends /run to be a ramdisk, as it should
always be clean on freshly rebooted systems.  And it probably saves a
lot of SSD/flash storage write cycles, for those using that.

[...snip...]

> @@ -21,6 +26,9 @@ systemdunitdir =3D $(systemdunitdir)
>  systemdunit_DATA =3D \
>  	openvpn-client@...1685... \
>  	openvpn-server@...1685...
> +tmpfilesdir =3D $(tmpfilesdir)

This conflicts with AC_SUBST([tmpfilesdir])

$ autoreconf -vi
autoreconf: Entering directory `.'
autoreconf: configure.ac: not using Gettext
autoreconf: running: aclocal -I m4
autoreconf: configure.ac: tracing
autoreconf: running: libtoolize --copy
autoreconf: running: /usr/bin/autoconf
autoreconf: running: /usr/bin/autoheader
autoreconf: running: automake --add-missing --copy --no-force
distro/systemd/Makefile.am:28: warning: tmpfilesdir was already defined
in condition TRUE, which includes condition ENABLE_SYSTEMD ...
configure.ac:1293: ... 'tmpfilesdir' previously defined here
autoreconf: Leaving directory `.'
$ rpm -q autoconf
autoconf-2.69-11.el7.noarch

Removing that tmpfilesdir declaration line in Makefile.am resolves this
issue, and it still works as expected.

[...snip...]

> diff --git a/distro/systemd/openvpn.conf b/distro/systemd/openvpn.conf
> new file mode 100644
> index 0000000..57f20cd
> --- /dev/null
> +++ b/distro/systemd/openvpn.conf
> @@ -0,0 +1,2 @@
> +d /run/openvpn-client 0710 root root -
> +d /run/openvpn-server 0710 root root -
> \ No newline at end of file

This makes more sense though, as this will tell systemd to create these
directories with the proper attributes.

But I'm not too happy about the filename in our git repository.  The
destination file may very well be called openvpn.conf, as then it should
reside in $libdir/tmpfiles.d/ ... but openvpn.conf causes quite a bit of
ambiguity inside the openvpn source tree, and unaware users might more
see this as a sample configuration for OpenVPN and be even more confused.

I propose ... either rename this file to tmpfiles.d--openvpn.conf or
move this openvpn.conf inside a tmpfiles.d/ subdirectory inside the
./distro/systemd/ directory.


Otherwise, this looks very reasonable.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--kWI2nbVfoNoKbqGphOOQfHe9tTMTADNXb--

--x0h77wkJ03GhciBCb0wiB9J5jruwDXmi5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYgnlUAAoJEIbPlEyWcf3yRXcP+gMri7vh4buWuOw3EMumiC17
WyU1OWds5q1mwOYIMaAwnGNhz5FOrrLwNMFLQ5CxmLFiCbEExIqwv1ylKB0fVa17
2+cz75Ks8pzjCD/wRZudc8ecGwemKeN8VydlhWmpcTD8v1piob7MVKdYLnh0PhOb
W9j2qwUMQNFIgDBUqU/Wk0xPXhs8N4SfMantLcmxlTyhbTe9hGLTZfnZ5ZRxLHMl
rAQ+ckvwIRn5Fj20B9DLyS7a422m2WQQVwjlPp0jm8/3ORKQFb9pTSc+2Pg4kR1r
OeMOLmKTMyk96R+q7HoVI6IwlPF8CQeoAsXPL1pah2dU5gfL+mRVj/RQXVS6RvUz
hh7RJIsDbxk2/oy5PSD5qAeuAWn2C4Jc81SQkM/IoYmJelwAq5cWe2ph/X1dWTjv
UejCPN6gpJIGnWib2XFb7dDpEvs8YuasBrDqgQMiz/II52I1hyxbbe9s2Czh4fU2
jeocU8IPngZUuYFPO5pMaecI2ab87ddzobbl2opDM7pkDasurZN0wWXA6NVRPhxC
ztXqm8q1sCQ+Gx66ov7MJtPEPmP4pjrpnc1orHwHVTK8Y8iGKbo/wTSFbGnh57MR
KgB45izVDRrF2ZkqjeWek4k4Y1LOXGfvO8l21+eWmQoCCrXPflWFe4SSiKE8dGAL
gu1wW3XmZZGqXXkLfObn
=RoRS
-----END PGP SIGNATURE-----

--x0h77wkJ03GhciBCb0wiB9J5jruwDXmi5--

