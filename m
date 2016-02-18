Date: Thu, 18 Feb 2016 18:03:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160218170312.GV24952@...1296...>
References: <56C5C6F7.1020903@...277...>
	<CAA1AbxJEJyrzJLOXLN2gO6EbA2=QSAbJf3pEr0SUAgVReT5xXA@...278...>
	<56C5EE36.5080906@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kHKsahEiDmOCqjtw"
Content-Disposition: inline
In-Reply-To: <56C5EE36.5080906@...277...>
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

--kHKsahEiDmOCqjtw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 18, 2016 at 05:15:50PM +0100, Jacek Wielemborek wrote:
> The thing is that in order to fuzz it most efficiently, it would be good
> to modify the server to use stdin/stdout (or dev null) for network I/O
> and terminate after handling a single connection. Also, we would need to
> disable any checksums, compression or encryption.

OpenVPN can be called from inetd, so it can sort of handle "an already
connected socket on stdin/stdout".

"sort of" because the backend refuses most normal options in this case
(it can only handle tap interfaces, and no --ifconfig, because the
assumption is that this only makes sense if you attach to a pre-configured
bridge) - but for fuzzing the network side, this should work.

Of course, if you take out checksumming, encryption and tls-auth, you
take away two layers of hardening against funny packets... - but I'm still
fairly confident that the worst thing our code will do is ASSERT() on
you :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--kHKsahEiDmOCqjtw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVsX5UKkuBuNlUUl1AQJxNQQAkBR/zkA60OddeNtTWh+XIu28h5fU2TWZ
P/c4RtiCEY+mYu091HgAmdCyoyeQ3i6wW3wQbB+qP06iF5mBXzO/hRKqeCSqzkYR
bXj6YGMPC4WIXxGwQ5QCoe1GyquyUOxOopeoCmpJHE5Moq/rOjC54lTdnzIEXHgT
jvO+TD4G3zU=
=hQCR
-----END PGP SIGNATURE-----

--kHKsahEiDmOCqjtw--

