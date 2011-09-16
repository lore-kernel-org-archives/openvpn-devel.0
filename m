Date: Fri, 16 Sep 2011 20:03:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110916180333.GS8496@...1296...>
References: <1316188397.1563.29.camel@...1503...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a3t0GJfDb/98C7vF"
Content-Disposition: inline
In-Reply-To: <1316188397.1563.29.camel@...1503...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (15th Sep 2011)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--a3t0GJfDb/98C7vF
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 16, 2011 at 05:53:17PM +0200, Samuli Sepp=E4nen wrote:
> Discussed the "tun.c patch breaks compile on FreeBSD" issue:
>=20
> <http://thread.gmane.org/gmane.network.openvpn.devel/4993>
>=20
> Dazo wrote a patch that fixed this issue. The patch was tested by ecrist =
on FreeBSD: he also promised to test it on OSX.

For reference: I have tested the patch on FreeBSD 8.2/Sparc64 today, and
it works for me.  So ACK here.

Part of the patch that David proposed was bringing back dead code that
I already removed before, so the "middle third" of that patch got a NAK
(David knows which bits are good and which not).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--a3t0GJfDb/98C7vF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTnOPdakuBuNlUUl1AQKJqwQAn3NilAR3aY8WqQZ9x6StXmAxttt9w9+g
du41xSp4a+xuUcX1efkbnh12KrambddjgPrqBcCxxbV2nlU9L62YEiXTpUeTINB5
rddjqj2qgSDEPbuYvNbDQgWU0QqJ+M0XcHrv8zYZqhusUIFyrsRrgh3C3XMTukAS
wcAuYSag1UU=
=Ef7v
-----END PGP SIGNATURE-----

--a3t0GJfDb/98C7vF--

