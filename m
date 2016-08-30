Date: Tue, 30 Aug 2016 21:49:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160830194955.GX78279@...1296...>
References: <45b848f8-6d95-2a2d-9cd6-667655e24857@...515...>
	<0fa5a591-d0ad-98f1-1320-bd155cb0ca3c@...2080...>
	<1472510288.61594.720.camel@...1866...>
	<792a45a7-118c-34f8-cbec-ae0bff99a748@...515...>
	<1472569937.61594.738.camel@...1866...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v4TiGS8Mqfyo/WGr"
Content-Disposition: inline
In-Reply-To: <1472569937.61594.738.camel@...1866...>
Subject: Re: [Openvpn-devel] Fixing non-standard PKCS#11 serialization
 format using a patched pkcs11-helper?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--v4TiGS8Mqfyo/WGr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 30, 2016 at 04:12:17PM +0100, David Woodhouse wrote:
> I'm accumulating a torture test suite (which I expect OpenVPN to fail) at
> http://git.infradead.org/users/dwmw2/openconnect.git/blob/HEAD:/tests/Mak=
efile.am

Torture test suites are good :-) - Steffan regularily tries to beat our
crypto stuff to pulp, while I'll find new and exciting ways to blow up
our packet/socket handling.  Like, actually testing --inetd :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--v4TiGS8Mqfyo/WGr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV8XjYqkuBuNlUUl1AQL3PAP/bh8c0gOnnJe+2fLy+e/yS29e4z7sj9h6
p3zpMWJCzfvrRiVkW9YPoZrjWTf5gq3qz1atDHjwPKBGBBgOLJo82jiQRpFyYiH+
R9CYW7tsRJBO2bKCbaSkeN+FqqK5xbGtPd7z0Z4ZPn3CbO/aQnNOWGs82Rk+B0KQ
8DLamvrE2uo=
=vnvI
-----END PGP SIGNATURE-----

--v4TiGS8Mqfyo/WGr--

