Date: Sun, 17 Jul 2016 22:21:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160717202135.GV78279@...1296...>
References: <20160716181726.GQ78279@...1296...>
	<1468696381.29435.18578.36594@...2154...>
	<20160716202207.GT78279@...1296...>
	<578A9CED.2090702@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x9NlMAausKqHAFUv"
Content-Disposition: inline
In-Reply-To: <578A9CED.2090702@...277...>
Subject: Re: [Openvpn-devel] net6_gateway feature request
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--x9NlMAausKqHAFUv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 16, 2016 at 09:45:33PM +0100, debbie10t wrote:
> If you *are* the client then you can customise your config & environment
> per site with (eg) --setenv my_route_net6_gateway blah:blah:blah::x

That would imply "someone has to write a script to figure out the
default gateway across all supported platforms" - which is amazingly
complicated...

But you bring up a good point - git master actually exports this information
to scripts, via the "net_gateway_ipv6" environment variable.  So, if
the original poster can use git master, an --up script could install the
necessary /128 routes towards net_gateway_ipv6.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--x9NlMAausKqHAFUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV4vozqkuBuNlUUl1AQLiCgP/Zkd13bljuarZIUgyn++mUQGVMmIc0ABV
XZTi1Il2S3iG8QBFSlEZcXpXYUMZ+NNLam0hTukwGqyLlhUh5XO+MyhOvsuJz7ao
k2HurGkkRqzovVOGFd0MbIYdIArBX3mBRr1H7Q7T8mUdjOGdYXzioRurAUZ8YXwl
uqtN1+vVquk=
=tohC
-----END PGP SIGNATURE-----

--x9NlMAausKqHAFUv--

