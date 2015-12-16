Date: Wed, 16 Dec 2015 09:24:52 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151216082452.GY24952@...1296...>
References: <1450123758-31641-1-git-send-email-steffan@...1856...>
	<566F5B01.8020109@...2080...>
	<20151215075312.GN24952@...1296...>
	<5670890D.7050501@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MoPktrqoj7trLhXW"
Content-Disposition: inline
In-Reply-To: <5670890D.7050501@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Warn user if their certificate has
 expired
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

--MoPktrqoj7trLhXW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 15, 2015 at 10:41:33PM +0100, Jan Just Keijser wrote:
> is loaded, but - as Steffan pointed out - this would mean that multiple=20
> places need a function call to check this:
> - when loading an x509 file
> - when loading a pkcs12 file
> - when loading an inline blob
> - when loading something from pkcs11
> - when loading something via cryptostore
> - when loading something using the management interface

... which means "truly a lot of places", and we'll end up maintaining that
code for quite a long time...

[..]
> I'm inclined to alter the patch to check it at all items listed above -=20
> what do you guys think?
> Having to wait for openssl 1.0.2 (which even my fedora 22 box does not=20
> yet have) seems a bit like "so close, yet so far ..."

OTOH, 0.9.8 and 1.0.0 will be discontinued end of this year, so we should
see vendor upgrades.

Or, as Steffan remarked, just use PolarSSL - which is its own can of worms,
but at least, this functionality is there nicely.  If you have 1.3, that is,
so in the 2.3 release train, it won't work before 2.3.10 (argh on all
crypto libraries...)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MoPktrqoj7trLhXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVnEf1KkuBuNlUUl1AQL+MAP/c7rSnFRxWRDRd5UwESWQcdNarcLGqfWz
JdX2ImDgBWvOEQm2rCkh/58xWZjw6Mtdaaq1aY5UYmm7Mf6gt3jOBEg5whJwCnBq
cbjMK0t66qkD/WmU+BNSgr5m0Gh18Hd+/mA6+g96x7naEvgfHXfwm26IXVsQRiV3
an8q2TdYXB8=
=GHDL
-----END PGP SIGNATURE-----

--MoPktrqoj7trLhXW--

