Date: Sun, 11 Sep 2016 20:51:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160911185153.GS78279@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7Y0jlJGlNwEFz8Iq"
Content-Disposition: inline
Subject: [Openvpn-devel] help wanted: OpenSolaris building
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--7Y0jlJGlNwEFz8Iq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

as you might know, we try to build everything we commit to git on all
supported platforms (using buildbot).  This works quite well and has
helped us keep things consistently working across all platforms, at least
as far as we have tests for each feature...

One of my problem childs is (Open)Solaris, though.  I have a VM that is
fairly old and has the GNU toolchain on it, but we have no access to
a current system, using the Sun/Oracle C compiler.

So, I'm looking for pointers :-)=20

 - is there an (easy to install and maintain) OpenSource variant of
   "Solaris" still around?

 - is there a developer program at Oracle, where one can get access to
   a current Solaris version plus Oracle C compiler, free of charge
   (a hosted build environment is only partially usable, because we
   run VM tests from buildbot, and those need root access...)

 - ... other ideas?

(I admit I'm lazy, and have not done much research on this - I just hope
someone has the answer already, while I go and finish a new OpenBSD 6.0,
NetBSD 7.0.1 and FreeBSD 10.3 builslave :-) )

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--7Y0jlJGlNwEFz8Iq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV9WnyKkuBuNlUUl1AQJoHAP/XgOB6Jw9MDd8wWvww5IRsJ25cim4NyvX
R3HqS9PepnWrZgzOI3TWq4IkPNU7ZO9oEkWfAiIBtigbcCf0ZKkLWw8jj54Wuk4K
tdb4OS42jc7txNyjsCcu/EGzUY0JSnWcsFkyhySlS79004An3Om8z839Ap1K9dqY
atqlnlOhJno=
=Tyuz
-----END PGP SIGNATURE-----

--7Y0jlJGlNwEFz8Iq--

