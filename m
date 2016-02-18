Date: Thu, 18 Feb 2016 19:08:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160218180846.GW24952@...1296...>
References: <56C5C6F7.1020903@...277...>
	<CAA1AbxJEJyrzJLOXLN2gO6EbA2=QSAbJf3pEr0SUAgVReT5xXA@...278...>
	<56C5EE36.5080906@...277...>
	<20160218170312.GV24952@...1296...>
	<56C5FA72.9040607@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FIix/tDCh13EcQNU"
Content-Disposition: inline
In-Reply-To: <56C5FA72.9040607@...277...>
Subject: Re: [Openvpn-devel] Has openvpn been fuzzed?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jacek Wielemborek <d33tah@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FIix/tDCh13EcQNU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 18, 2016 at 06:08:02PM +0100, Jacek Wielemborek wrote:
> Well the attacker could send a funny packet with a valid checksum,
> encrypted and authenticated, right?=20

Indeed, but that would be someone we trust enough to let him talk to
our network - protects against Joe Random from the Internet crashing
our servers (or burning CPU resources trying to).

But yeah.  Mistakes do happen :-) - so software shouldn't ever crash
on malformed packets.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--FIix/tDCh13EcQNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVsYIrakuBuNlUUl1AQJiCQP9EOg9AiGLZudcizo9lbZrBYnJDOnFIdNA
0dX1t36bI4GRIvRRcv3+DwjmK1n3n145RMKZ6FWKPGIaULbMyakPA9NS5Z97HMgK
d2bjw11TUhlkR78HIhlvwfCWHktqdk+ZKU+Y3Ay0Tn+JnyX933Ud85IJL34uKAXU
T4PlCHHjY5M=
=jRa5
-----END PGP SIGNATURE-----

--FIix/tDCh13EcQNU--

