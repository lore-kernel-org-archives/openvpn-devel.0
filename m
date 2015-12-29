Date: Tue, 29 Dec 2015 14:56:34 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151229135634.GL24952@...1296...>
References: <D361D4D8184C40E2A8E222238EA0BE35@...2089...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WrtKk81rkeSMEfHB"
Content-Disposition: inline
In-Reply-To: <D361D4D8184C40E2A8E222238EA0BE35@...2089...>
Subject: Re: [Openvpn-devel] man openvpn(8): --block-outside-dns
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

--WrtKk81rkeSMEfHB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 29, 2015 at 12:31:35PM -0000, debbie10t@...277... wrote:
> --block-outside-dns is not an openvpn directive ...=20

Uh, what?

> it cannot be used in a config file as such.

By that logic, quite a lot of things that are platform specific would
not be "an openvpn directive" - most other windows specific options will=20
also cause parse errors when used on linux.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--WrtKk81rkeSMEfHB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVoKREakuBuNlUUl1AQJ2NQQArMhFOo7UPsahKz4rFcuYgYKWLceJlKnF
WVSd1DY0sZMvM0V+u+BoE+No/IJNSrFrqMqXtYipWWJZB5BeYeNNNvhK7FNytyW/
retF1cXVniDj/CCccsplxvyEX9cSHJm2DZUm2fegtA8f3hVaZAAlAc2LJyNp6t++
z08ZRnDTY6s=
=EO8G
-----END PGP SIGNATURE-----

--WrtKk81rkeSMEfHB--

