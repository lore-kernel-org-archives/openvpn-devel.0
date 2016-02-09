Date: Tue, 9 Feb 2016 11:46:25 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160209104625.GL24952@...1296...>
References: <20160208213929.GA20623@...2120...>
	<20160209092821.GH24952@...1296...>
	<20160209101533.GJ3102@...2121...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A1aK1rbqyRXOVxPd"
Content-Disposition: inline
In-Reply-To: <20160209101533.GJ3102@...2121...>
Subject: Re: [Openvpn-devel] route / route-ipv6 can not be used in ccd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuel Thibault <samuel.thibault@...1817...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--A1aK1rbqyRXOVxPd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 09, 2016 at 11:15:33AM +0100, Samuel Thibault wrote:
> Gert Doering, on Tue 09 Feb 2016 10:28:21 +0100, wrote:
> > On Mon, Feb 08, 2016 at 10:39:29PM +0100, Samuel Thibault wrote:
> > > Is there a reason for not being allowed to set route / route-ipv6
> > > options in the ccd?
> >=20
> > "Nobody has implemented it yet" - plain and simple...
>=20
> Ok :)

Could you test and report whether --learn-address does the job for you?

I think this would be a useful result to have in the list archives :-)

thanks,

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--A1aK1rbqyRXOVxPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVrnDgKkuBuNlUUl1AQJbkwP/eD+Z6QXJ44JPbAvg36iDtywJRFLkR9Jd
BTwO3YCM/YarHbUa8HuwFeQ9Gqg5D1nLjAVbJCHvgklCnjHdbmCSLm4ETTwTFQDp
853b7fqFw5WNQBfUP8z0L0QXp/FULgbXyfPvLELLX2Oe6Q8ZgslezuiMhhlIVhHb
E1qmypxO6/g=
=psRh
-----END PGP SIGNATURE-----

--A1aK1rbqyRXOVxPd--

