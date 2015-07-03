Date: Fri, 3 Jul 2015 13:59:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150703115912.GY382@...1296...>
References: <55966BE0.5090400@...1147...> <55966F4A.7010008@...1114...>
	<559672D0.1030904@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wbuTI+YEd0REWzbC"
Content-Disposition: inline
In-Reply-To: <559672D0.1030904@...1147...>
Subject: Re: [Openvpn-devel] Adding routes on Windows using DHCP
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

--wbuTI+YEd0REWzbC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 03, 2015 at 01:32:32PM +0200, Jan Just Keijser wrote:
> > * What about IPv6?
> > Can you push IPv6 routes the same way?  Will that also work without pri=
vileges?
>
> How are IPv6 addresses handled by OpenVPN / tap-win32 ?=20

Calling "netsh.exe" (both for addresses and routes).

> IPv6 comes with=20
> DHCPv6 which also includes support for pushing routes&gateways. It needs=
=20
> further investigation, however.

DHCPv6 does *not* support routing information.  You need RA for that, and
implementing a full-featured DHCPv6+RA daemon inside OpenVPN is way more
work than just getting the (already existing!) code from Heiko for the
interactive service tested and merged...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--wbuTI+YEd0REWzbC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVZZ5EKkuBuNlUUl1AQII0wQAt2b5hw3TJbij7ssAY4c8LMS1dWKOUUvz
9hZy3j2Wdht5QV7ZYKjPkPc0KS4i4G4uePjPU8Bv+Rc3d3Qiy1+/9zx8ydium+au
ZDoqmSaxgiDBsDh8+4X9aSUGNSlRHjlXzyRmaYSUySreW6MuJG6NcqT6LL8QCRm/
3+5rjpAD2p8=
=9L2B
-----END PGP SIGNATURE-----

--wbuTI+YEd0REWzbC--

