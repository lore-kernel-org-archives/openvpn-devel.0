Date: Thu, 3 Mar 2016 18:56:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160303175615.GH24952@...1296...>
References: <56D8628D.5070902@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zdTTObKWN0YszqeC"
Content-Disposition: inline
In-Reply-To: <56D8628D.5070902@...1147...>
Subject: Re: [Openvpn-devel] manpage oddity
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--zdTTObKWN0YszqeC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 03, 2016 at 05:13:01PM +0100, Jan Just Keijser wrote:
> and a few others. However, the actual name of these env vars is local_N,=
=20
> local_port_N  etc. I've checked the code and that has been the case=20
> since v2.1
>=20
> Two questions:
> - why are we adding the number? per connection there will be only one=20
> local IP and only one local port

If it was there at v2.1 - "you tell us, you're the only one that has been
around back then" :-)

(Most likely it's just using the same function for "stick a number to it
and build an environment string containing an IP address" that is used
for route_1, route_2, ...)

> - should we update the man page to reflect this?

Actually, I'd go for "update the manpage, and keep the number" - Heiko
is working on multi-listen, so we could end up with multiple local
IPs and ports one day, and then it makes sense to have them numbered
local_1, local_2, etc.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--zdTTObKWN0YszqeC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVth6vqkuBuNlUUl1AQIFMgP7BAByniIA2tAPVcn86RS2yOUXK3bnwZil
XSglncVBRQ907yH4JTqkhpJOtwjTf7lNeUbhacV60iA2XUqbSCgBtG7o9OavdO3b
6nsPlZkVy2lMJPfB4PMwjGx6h+XZIgrAdR2Z6HyO+PXP6Fz5F1tHBtFCVk3NiXSz
0+TJvbLMaVw=
=2HHt
-----END PGP SIGNATURE-----

--zdTTObKWN0YszqeC--

