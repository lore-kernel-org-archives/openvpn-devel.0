Date: Mon, 16 Jul 2012 22:20:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120716202025.GO22125@...1296...>
References: <CAEsd45Rh9zu=FC_Qdt4KiUfGayMqRzshF4OpxsHcszVH+8vBHw@...278...>
	<CAOazyz1+Px-wFYd3DVdm-1Sxponr0xsp2w4m8Mum+HTDyMtovg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R9b51G30WkD62Ue3"
Content-Disposition: inline
In-Reply-To: <CAOazyz1+Px-wFYd3DVdm-1Sxponr0xsp2w4m8Mum+HTDyMtovg@...278...>
Subject: Re: [Openvpn-devel] New build system questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--R9b51G30WkD62Ue3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 16, 2012 at 07:45:03PM +0300, Alon Bar-Lev wrote:
> > (3) I want to build "compat" as a static library. How can I do that?
> >
> > I've tried adding the following arguments after "./configure":
> >
> > --enable-static --disable-shared
[..]
>=20
> You don't need the above... just add LDFLAGS=3D"-static", I guess.

Should libcompat.* ever be built dynamically?  I just checked on Linux
and FreeBSD, and our configure/make only builds libcompat.a (hidden
in src/libcompat/.libs/).

To make sure I'm not getting misunderstood: I think a static library is
the right way to go here, so I'm surprised about the question from
Jonathan.

> > *** Warning: Linking the shared library libcompat.la against the

... OTOH, libcompat.la is not really a shared library here, just a=20
ld config file pointing to the static libcompat.a, so maybe this is
just a warning that can be safely ignored.

gert=20

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--R9b51G30WkD62Ue3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUAR3iKkuBuNlUUl1AQJIwgQAkf+1mJ/w6HW17TeZwmUklPFwybT7LPk3
2LZcb89Kr7N67rhN0fsOraFpyw9mj39HS/2HRjjeQFcMs9vllKaNoz0JnTbFPrzK
ky3JFDldb3/XhcwdfkDXU8uZi9QvF263ckNHqk7hQQWF7mQFoPdw6oV8QGqiLB1e
FjEuv5suuCo=
=hw4P
-----END PGP SIGNATURE-----

--R9b51G30WkD62Ue3--

