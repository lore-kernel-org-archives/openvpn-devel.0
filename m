Date: Mon, 24 Oct 2011 15:50:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20111024135009.GE8496@...1296...>
References: <1319454692-28954-1-git-send-email-dejong@...1435...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="64STNUbpu9LeEfX8"
Content-Disposition: inline
In-Reply-To: <1319454692-28954-1-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Removed obsolete des_cblock and
	des_keyschedule
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--64STNUbpu9LeEfX8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 24, 2011 at 01:11:32PM +0200, Adriaan de Jong wrote:
> To allow building on NetBSD.
>=20
> Signed-off-by: Adriaan de Jong <dejong@...1435...>

ACK, but maybe the comment should be a bit more descriptive, like

"allow building on NetBSD which does not install <des_old.h> anymore"

or such.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--64STNUbpu9LeEfX8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTqVtEakuBuNlUUl1AQI4+gP+O2DcijewVri27l3OTsKqViga9MtHEjM3
s2hYPP51pHTu7z+XOtvtDh9YVQBbEVEZysd6Z0I04QUK1YDxaAOuXK2fCB8X38wp
04Mu5I0BghE0pSEzYNFvlDndNHgHxYZOg0tcQME0qa59HJVLZzJKDA3TxutxzzNM
rC/2GB3dCJ4=
=QCl2
-----END PGP SIGNATURE-----

--64STNUbpu9LeEfX8--

