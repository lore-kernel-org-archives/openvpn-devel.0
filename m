Date: Mon, 26 Mar 2012 11:50:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120326095049.GO1359@...1296...>
References: <20120326093629.GN1359@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FLFbAWqIDstwcN4K"
Content-Disposition: inline
In-Reply-To: <20120326093629.GN1359@...1296...>
Subject: Re: [Openvpn-devel] build problems on FreeBSD of latest openvpn git
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--FLFbAWqIDstwcN4K
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 26, 2012 at 11:36:30AM +0200, Gert Doering wrote:
> buildbot tried to build openvpn after David's merge yesterday, and failed
> miserably.  To see what happened I tried to reproduce on my FreeBSD 7.4
> build slave, and found this, in a fresh git clone:
>=20
> gert@...1703...:/home/gert$ git clone git://openvpn.git.sourceforge.net/g=
itroot/openvpn/openvpn.git
> ...
> gert@...1703...:/home/gert/openvpn$ autoreconf -vi
> autoreconf-2.68: Entering directory `.'
> autoreconf-2.68: configure.ac: not using Gettext
> autoreconf-2.68: running: aclocal -I m4
> autoreconf-2.68: configure.ac: tracing
> autoreconf-2.68: configure.ac: not using Libtool
> autoreconf-2.68: running: /usr/local/bin/autoconf-2.68
> configure.ac:328: error: possibly undefined macro: AC_LIBTOOL_WIN32_DLL
>       If this token and others are legitimate, please use m4_pattern_allo=
w.
>       See the Autoconf documentation.
> configure.ac:329: error: possibly undefined macro: AC_LIBTOOL_RC
> configure.ac:330: error: possibly undefined macro: AC_PROG_LIBTOOL
> autoreconf-2.68: /usr/local/bin/autoconf-2.68 failed with exit status: 1

OK, David had an idea: this machine did not have libtool installed
("because we didn't need it before").

I have now installed libtool 2.2.10, and with that, "autoreconf -vi"
does not return an error anymore.


"configure" still fails looking for "libdl", though.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--FLFbAWqIDstwcN4K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3A7+akuBuNlUUl1AQKT+QP9H5enIA0oDc3RnL4avAjAbqXIftUVW6BI
akjC9C+M1TEgXDxJdP9ouWLP5Qrxq2gHOQLZXH1iyDxIWu618/AOWRAbJ4UqKmBM
qGSZ6wFba4XMi4fLzKMM+DCk3whp/G+BNxDk+jFdheE4h8Rc6woxsNaH9BYm/J/a
qBuiVo8tEH8=
=Le5y
-----END PGP SIGNATURE-----

--FLFbAWqIDstwcN4K--

