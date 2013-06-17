Date: Mon, 17 Jun 2013 17:36:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130617153623.GS20843@...1296...>
References: <20130617110003.GX4767@...1330...>
	<20130617115112.GQ20843@...1296...>
	<20130617140518.GB3750@...1330...>
	<20130617143644.GA6399@...1330...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T3gMhG0dRUMlbdt/"
Content-Disposition: inline
In-Reply-To: <20130617143644.GA6399@...1330...>
Subject: Re: [Openvpn-devel] Fix for CVE-2013-2061 breaks multihome?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--T3gMhG0dRUMlbdt/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 17, 2013 at 04:36:44PM +0200, Alberto Gonzalez Iniesta wrote:
> Seems like "cmsg_len" went nuts...

Seems your compiler grew too much smarts and optimized that bug to death :-)

> Again, only happens with multihome, if that helps...

That code path is only used for multihome.  Bugfix is here (if it's indeed
*that* problem):

commit 8c431f960357d776cfd0961192214ad1b0942bfb
Author: Gert Doering <gert@...1296...>
Date:   Thu May 30 13:31:24 2013 +0200

    Fix problem with UDP tunneling due to mishandled pktinfo structures.
=20=20=20=20
    In link_socket_write_udp_posix_sendmsg(), pktinfo structures for ipv4 a=
nd
    ipv6 are going out of scope before actually calling sendmsg(), so depen=
ding
    on compiler optimization, garbage is passed to sendmsg() - fix by using
    "union openvpn_pktinfo" and having that in scope all the time.
=20=20=20=20
    Problem reported and patch provided by "danta" in trac#297
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: Gert Doering <gert@...1296...>
    Acked-by: Arne Schwabe <arne@...1227...>
    URL: https://community.openvpn.net/openvpn/ticket/297
    Message-ID: <20130530184427.GP20843@...1296...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7629

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--T3gMhG0dRUMlbdt/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUb8s96kuBuNlUUl1AQLE8gQAoBfKJXNSluyTHwAxX1nhodffd3feApo8
Ki5hyxLeR8QTaFtliobiGFUepQWVvPMMOpSQX7LLqvNUji9/SPzK+7oB2Jpk2kyL
2kqWUvWs72pxY5hu/rq0fZLF5YpE97m8NQ38Lh5A6xRIf8wsOq17fwjBCZssU5dX
gFM1VifB3v8=
=BTPN
-----END PGP SIGNATURE-----

--T3gMhG0dRUMlbdt/--

