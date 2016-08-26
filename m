Date: Fri, 26 Aug 2016 15:14:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160826131442.GY78279@...1296...>
References: <1472162097-17855-1-git-send-email-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VGoz+il/cCEnkAr0"
Content-Disposition: inline
In-Reply-To: <1472162097-17855-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Fix client connection instant timeout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--VGoz+il/cCEnkAr0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 25, 2016 at 11:54:57PM +0200, David Sommerseth wrote:
> Commit b3e975824ea9ebae8dbea5b451c8d02525c83ffe moved the finalizing of
> TCP/UDP sockets before the UID/GID where dropped.  But this did not
> factor that the timeout code had been revamped [1] in the mean time.
>=20
> This ensures the timout initialization is done before the the socket
> finalizing has been completed.
>=20
> [1] commit f2134b7bea37df15756c599b94f16d4bffafbbd6

This looks reasonable, and fixes the issue for me - in other words,
my tests are happy

Test sets succeded: 1 1a 1b 1c 1d 2 2a 2b 2d 3 4 4a 5 8 9.
Test sets failed: none.


If we keep the other one (Arne had some reservations because the amount
of code in the "now-privileged" part is bigger than "just bind"), then
this is a working fix - so, conditional ACK.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--VGoz+il/cCEnkAr0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV8BAwakuBuNlUUl1AQJanwP/WTeToR4NkXduby1nIEVUAHasHXgwlsZK
IYD1tBVh/+3GWHE4bn6vFXfB2B0ZEq3zD0x9uQmuKBkVTUI0CxgedsiFIlPHTxCv
Iw2k+mCTrJBxlMgwa+2rXn5UtUzv9Wpg+iDNYruVvsIk2w1J4lkh3+sl5/SnAwvf
V3PUCvYR0cw=
=DCHp
-----END PGP SIGNATURE-----

--VGoz+il/cCEnkAr0--

