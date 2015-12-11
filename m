Date: Fri, 11 Dec 2015 21:08:34 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151211200834.GV24952@...1296...>
References: <AF48117BC12D429393E4D93EFBA7E72E@...2089...>
	<20151211193817.GT24952@...1296...>
	<BAEB59A88E964992802EAD23559AB9E4@...2089...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g1+zH1ePNtID5oR6"
Content-Disposition: inline
In-Reply-To: <BAEB59A88E964992802EAD23559AB9E4@...2089...>
Subject: Re: [Openvpn-devel] Opttion "client-nat" not recognised
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t@...277...
Cc: openvpn-devel@lists.sourceforge.net

--g1+zH1ePNtID5oR6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 11, 2015 at 08:06:45PM -0000, debbie10t@...277... wrote:
> > According to the (slightly confusing, admittedly) man page entry,=20
> > the way you are calling the option is not correct, and as such,=20
> > git master will refuse the lines.  "client-nat" has *four* arguments,
> > not *five*.
>=20
> Is it possible to provide some kind of example ?
> For those of us not familiar with C ..

I have no idea what these options *do*, but the code says "four arguments
have to be there" and the git master code says "four arguments have
to be there, and if a fifth is given, it is a syntax error".

So just leave off the last argument - it was silently ignored all along.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--g1+zH1ePNtID5oR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVmstQqkuBuNlUUl1AQJGbAP+LNq8sZn0X5vtuZyJt5omi3qy1xsVbvZc
EYGcZ9rOoBGnpxFEYI9A0FZYFQsh82XduZSoEG2Bj9v+IeOkxR3Why+iirs9MQuL
bHkAWVwmgFRSvAd5bGtEZrA2QWKu2O8vtnHLEeHhHHtsmiAqVgeg2eZ3whX2QIXf
qvS2G3Slwqw=
=ysEU
-----END PGP SIGNATURE-----

--g1+zH1ePNtID5oR6--

