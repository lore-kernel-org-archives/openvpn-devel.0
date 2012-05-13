Date: Sun, 13 May 2012 15:07:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120513130750.GN1359@...1296...>
References: <20120513090153.GG1359@...1296...>
	<CAOazyz1FB+JU7QRmeMuxMX7-6fAN28VH1-6ApJnOu7eHDq9jUA@...278...>
	<20120513092355.GH1359@...1296...>
	<CAOazyz0=+ZE6+n-KqyzZSJhbweHb236LjwefvV6BtMvfbh37mQ@...278...>
	<20120513093551.GI1359@...1296...>
	<CAOazyz0bEZMBYcKGvKTux=+7XE43=-4Aw02HGVCNHPoO35wAWg@...278...>
	<20120513111240.GK1359@...1296...>
	<CAOazyz1keZzQjqeUoUSQ88UzVn3=BMz1FWRp0KiB+gS6-43HhQ@...278...>
	<20120513121906.GL1359@...1296...>
	<CAOazyz3WetA0vHpm965krjKm=OiFovT1JRi39T9kOY2sf7-khA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RpmpUzIBLeukSLnl"
Content-Disposition: inline
In-Reply-To: <CAOazyz3WetA0vHpm965krjKm=OiFovT1JRi39T9kOY2sf7-khA@...278...>
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
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

--RpmpUzIBLeukSLnl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, May 13, 2012 at 03:24:59PM +0300, Alon Bar-Lev wrote:
> > If we ignore the examples, we really only have "auth-pam" and "down-roo=
t"
> > in the main distribution today, and those are useful in many cases - so
> > I'd go for "always build and install them".
>=20
> And always have pam dependency for this example?

FreeBSD, NetBSD, all Linuxes and Solaris have PAM anyway.

So make this "if pam libraries + headers are detected, install auth-pam,=20
otherwise, not".

> These plugins should be optional I don't see any value in enforcing
> them and their dependencies.

If these plugins are useful for a large number of users, there is no
point in not installing them by default.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RpmpUzIBLeukSLnl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT6+yJqkuBuNlUUl1AQIOOwP/fHGsQcDdWogJp87qgz0l+I5Wb0ui7wcm
yUcV9D1Lahnp1zuzUbN+WCvJjf28+/5VTQa9uor55Wa+RlPFtXDCn0XlRefYCn6b
JSAVovbyB5yPqoShXcbH1jqtv0w2KEEsddsJRtn4qgUDVrFX0GagTr1QUl+rXLL0
ZwBV5FLKGa4=
=FIur
-----END PGP SIGNATURE-----

--RpmpUzIBLeukSLnl--

