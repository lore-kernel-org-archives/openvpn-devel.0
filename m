Date: Sun, 25 Mar 2012 13:40:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120325114022.GJ1359@...1296...>
References: <1332674822-10508-1-git-send-email-alon.barlev@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OtZJUqNUNrB9XA/T"
Content-Disposition: inline
In-Reply-To: <1332674822-10508-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: flags should not be bool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

--OtZJUqNUNrB9XA/T
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 25, 2012 at 01:27:02PM +0200, Alon Bar-Lev wrote:
> Discussed at [1][2][3].
>=20
> [1] https://bugs.gentoo.org/show_bug.cgi?id=3D297854#c2
> [2] https://297854.bugs.gentoo.org/attachment.cgi?id=3D214304
> [3] http://sourceforge.net/mailarchive/forum.php?thread_name=3D2012032511=
1517.GI1359%40greenie.muc.de&forum_name=3Dopenvpn-devel
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  src/openvpn/socket.c |    6 +++---
>  src/openvpn/socket.h |    6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

ACK!

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--OtZJUqNUNrB9XA/T
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT28EJqkuBuNlUUl1AQKCZgP/ajk2S1epWiJb82HidFsWc1iIICttzKTD
cDayUqRcUaM4suGizKoQagIiRhJBf2WTz1cEQuDqzucfP/KZm1W0Crc+MFqWQeRm
F8mNY39L7MjZhv4csBIfYqxQk3gcKHzL03aaCf5zuawsvKBLOqMhxdwXnwPNMTxC
gOEWqec9LSU=
=RKAB
-----END PGP SIGNATURE-----

--OtZJUqNUNrB9XA/T--

