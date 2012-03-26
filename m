Date: Mon, 26 Mar 2012 12:23:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120326102307.GP1359@...1296...>
References: <20120326093629.GN1359@...1296...>
	<20120326095049.GO1359@...1296...>
	<CAOazyz2YYdfVYekhQEZu_sFXwXa7nRx5s3M=M2NhdHegZqt8Bw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GcuyunM1iFaMYZNm"
Content-Disposition: inline
In-Reply-To: <CAOazyz2YYdfVYekhQEZu_sFXwXa7nRx5s3M=M2NhdHegZqt8Bw@...278...>
Subject: Re: [Openvpn-devel] build problems on FreeBSD of latest openvpn git
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--GcuyunM1iFaMYZNm
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

(on-list)

On Mon, Mar 26, 2012 at 12:15:06PM +0200, Alon Bar-Lev wrote:
> >> configure.ac:328: error: possibly undefined macro: AC_LIBTOOL_WIN32_DLL
> >> =A0 =A0 =A0 If this token and others are legitimate, please use m4_pat=
tern_allow.
> >> =A0 =A0 =A0 See the Autoconf documentation.
> >> configure.ac:329: error: possibly undefined macro: AC_LIBTOOL_RC
> >> configure.ac:330: error: possibly undefined macro: AC_PROG_LIBTOOL
> >> autoreconf-2.68: /usr/local/bin/autoconf-2.68 failed with exit status:=
 1
> >
> > OK, David had an idea: this machine did not have libtool installed
> > ("because we didn't need it before").
>=20
> Right.
> Usually you do autoreconf -ivf && ./configure && make dist at
> development machine or central build server and send the tarball to
> build machines, this way you don't need to install the autotools
> components on all build machines.

Yep.  Can we improve the error message here, so people running buildbot
or doing development can see that they are missing libtool?

> > I have now installed libtool 2.2.10, and with that, "autoreconf -vi"
> > does not return an error anymore.
> >
> >
> > "configure" still fails looking for "libdl", though.
>=20
> Yes, this results of strange development procedure, merge first then test=
... :)

Well, we did test, but not on all platforms yet - that's what we have
the buildbot armada for, and they need the merge first :-)

> Can you please send me the config.log?
> I will fix that.

I'll send the config.log off-list.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--GcuyunM1iFaMYZNm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3BDi6kuBuNlUUl1AQLqEwP+O9lia0t+yJTrM5HGvwKDAH4Nm/fGjM5M
xpsol9VgL8dwqahLiVUUujLYuTOG23OL2O1oKmWyq/wJip6IubuNV3qd6rykK/rt
GzRyGzQ9wXN0+N6NQRHcvO/9IuWtKxjX548Vq3SSef0l6HclGsgHwD+mN7zbgUnb
mnu6GStXrcE=
=YhDu
-----END PGP SIGNATURE-----

--GcuyunM1iFaMYZNm--

