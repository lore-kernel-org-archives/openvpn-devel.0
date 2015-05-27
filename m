Message-ID: <5565B65A.1000501@...1114...>
Date: Wed, 27 May 2015 14:19:38 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20150524193011.GK382@...1296...>
In-Reply-To: <20150524193011.GK382@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="8Oip3gnRoiWlsUcOwmFwPODkCgRjWBGsG"
Subject: Re: [Openvpn-devel] rfd: 'serial-tests' automake option
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8Oip3gnRoiWlsUcOwmFwPODkCgRjWBGsG
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 24/05/15 21:30, Gert Doering wrote:
> Hi,
>=20
> somewhere between automake-1.11 and automake-1.14 the default for handling
> "make check" changed from "serial-tests" to "parallel-tests" - which=20
> sounds harmless, but has the interesting side effect of hiding the output
> of all (potentially parallel-run) test scripts until the summary at the
> end, and even then, only printing the summary, not the detail output.
>=20
> I can see that this looks much more pretty (and colours, wooh!), but
> for my day-to-day regression testing and for analyzing buildbot failures,
> this just adds extra steps to figure out what it is doing right now, and
> where and why it failed this time - especially in the buildbot case, the
> difference is "the reason is right in the mail" vs "I need to login to
> the buildbot machine, go to the right build directory (of many), and=20
> grab the log file from there".
>=20
>=20
> Fortunately, there is an automake option for this, which I'd propose to
> enable... (well hidden inside "info automake-1.14" -> "Options")
>=20
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index b7980e0..02fa392 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -9,6 +9,8 @@
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
>=20=20
> +AUTOMAKE_OPTIONS =3D serial-tests
> +
>  MAINTAINERCLEANFILES =3D \
>         $(srcdir)/Makefile.in
>=20=20
>=20
> ... which brings back the old behaviour.
>=20
> I'm not sure whether it can be passed on an "autoreconf -vif" command
> line, and if yes, how, but I presume that really nobody who bothers to
> run "make check" will be bothered by the normal test output - and especia=
lly
> nobody who bothers to set up a t_client.rc test rig in the first place...
>=20
> But I'm open for discussion and alternative suggestions on this.
>=20

This makes a lot of sense to me.  Our project doesn't really benefit in
general of running our tests parallel.

This gets an ACK from me.  I just tested your change locally, and it
seems to work very well.  And from what I can grasp from the automake
documentation [1], this seems safe for us to do.


[1]
<https://www.gnu.org/software/automake/manual/html_node/Serial-Test-Harness=
.html>

--=20
kind regards,

David Sommerseth



--8Oip3gnRoiWlsUcOwmFwPODkCgRjWBGsG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVltlsACgkQDC186MBRfrol1QCfUUzvkbjIYkrwGsn4hymA+2sX
7rwAoLGhEYqe2xVlUye6su4J2kz1t01S
=tiN1
-----END PGP SIGNATURE-----

--8Oip3gnRoiWlsUcOwmFwPODkCgRjWBGsG--

