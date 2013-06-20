Date: Thu, 20 Jun 2013 19:28:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130620172854.GQ20843@...1296...>
References: <1371738121-30540-1-git-send-email-arne@...1227...>
	<1371739123-2747-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AjD4W703GQxY/I8S"
Content-Disposition: inline
In-Reply-To: <1371739123-2747-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [Patch v6] Add support of utun devices under
	Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--AjD4W703GQxY/I8S
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 20, 2013 at 04:38:43PM +0200, Arne Schwabe wrote:
> v6: add commit message change log, replace strstr with strncmp, move #inc=
ludes to the top of the file
>=20

This looks good to me.  It would be great if Jonathan could test this
again to verify that all OSX versions are properly covered (I only have
a limited set to test with), but if that all works, I'm happy to move
it in and ACK it code-wise and feature-wise.

(There's a few more platform cleanups lurking in here, with more sharing
of the read_tun_header()/write_tun_header() functions with other BSDs,
but that's an independent opportunity for improval)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--AjD4W703GQxY/I8S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUcM71qkuBuNlUUl1AQLRngQAjsoAWs3kQeHMFLuDffiCYNQLFSQmvXTj
n5lnBoZ8t38J7fBT2gaUVbcXLp1lYnLdjBLOYG32xld4v+N/vqxusPJglTkUASFd
fB7E/ST9Z5D/yfW7YJMOcMCgTVT8W16lvvdu2ADUclY9eHypkb+r+YcCaOqOMLhq
NshBstnNaB0=
=E5Zr
-----END PGP SIGNATURE-----

--AjD4W703GQxY/I8S--

