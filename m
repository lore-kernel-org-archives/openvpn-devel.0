Date: Tue, 8 Dec 2015 17:08:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151208160831.GO24952@...1296...>
References: <1448456220-2042-1-git-send-email-heiko.hund@...1489...>
	<201511281341.tASDfilE011918@...2054...>
	<20151128140744.GA12133@...1296...>
	<2162657.pE5i3AfkV7@...2001...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dUCTBDm4d+mXXNar"
Content-Disposition: inline
In-Reply-To: <2162657.pE5i3AfkV7@...2001...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: extend management interface
 command state
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--dUCTBDm4d+mXXNar
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 08, 2015 at 04:48:56PM +0100, Heiko Hund wrote:
> On Saturday 28 November 2015 15:07:44 Gert Doering wrote:
> > can you send a followup patch, or shall I tackle this (having the BSDs =
to
> > test)?  How can I see if this actually works?
>=20
> I can do the fix, but would send it to you for verification first because=
 I=20
> have no BSDs around. OK?

commit 4a82a9ac0bef6db58858a42b4dc500ae9e09682d
Author: Gert Doering <gert@...1296...>
Date:   Sat Nov 28 20:58:37 2015 +0100

    Un-break compilation on *BSD
=20=20=20=20
    Commit 2191c47165 introduced code to handle IP address query on
    multihoming hosts for IP_PKTINFO-supporting OSes, but all the BSDs
    need the "#elsif IP_RECVDSTADDR" variant... add code equivalent
    to what we have in socket.c/print_link_socket_actual_ex()
=20=20=20=20
    Tested on FreeBSD 9.3/sparc64
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: Arne Schwabe <arne@...1227...>
    Message-Id: <1448740717-60914-1-git-send-email-gert@...1296...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/10648

So, "already done" ;-)

(And it uncovered that --multihome is actually broken for IPv6 on some of
the BSDs today, while it works correctly for IPv4... opened trac #634=20
on it)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dUCTBDm4d+mXXNar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVmb+wakuBuNlUUl1AQLEKgQAgMzCN7DTiCpaiI2nEICyl6j+Z7GpnXZU
yuAR2ypfWlwx70rBUnwC3L0xNEHsFB+18YOIcgILr8nTq+S8upmig8z94vYjVUBx
UUd+87np6GQJgqXbW+QqEJ5/xwMuGaN/PsCaSTwO4ds7aL8uj8kgqfOrZiFnXzhJ
1Bi6pnfWEW0=
=8oQO
-----END PGP SIGNATURE-----

--dUCTBDm4d+mXXNar--

