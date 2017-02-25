Date: Sat, 25 Feb 2017 10:19:08 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170225091908.GX93896@...1296...>
References: <20170225004014.28638-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KLR62ZwG+3BuLtMl"
Content-Disposition: inline
In-Reply-To: <20170225004014.28638-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Ignore auth-nocache for auth-user-pass
 if auth-token is pushed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--KLR62ZwG+3BuLtMl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 25, 2017 at 08:40:14AM +0800, Antonio Quartulli wrote:
> When the auth-token option is pushed from the server to the client,
> the latter has to ignore the auth-nocache directive (if specified).
>=20
> The password will now be substituted by the unique token, therefore
> it can't be wiped out, otherwise the next renegotiation will fail.

Without looking at the patch itself - is this suitable material for
inclusion in 2.3?  We do have quite a few "slow adopters" - and this
is a very useful feature to mitigate SWEET32 in 2FA environments...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--KLR62ZwG+3BuLtMl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYsUwMAAoJEB2Cnv7KVigSYJAL/18OlgGl+chnhNr/MlcC3JRB
FlD54GCvDovXSoZdjSjDDHphIufgVgi/BdJW1GLFdWJugS43oLEw1YHaiMUwtHmO
aj3D5NgU5iQ93xMWR4GwuK6VEEEUaLk9djGt1wJjs4UsM8MObuKLSwsw8Bb/iGnK
OE5VRBXbnd7ruqC1pieidiZv6SZpUvFw0fA++0bNTweKGFhIs9RTJjnj6VP1yHf3
avtDqc/5msgoOQmU/BG74oza3UG0UDqUmnTmOEdVHmzMr27+zWoQlIEIx4IFdkgT
O/fphhj8IpFG6XZyZEIYqkwuUg11DEhpeBlP2Dc/NxBoLtk0w8thjNTrJFJkd+xD
IxjMwHRbViePaiFW6W2x7/VqPwR5c5UNtJKWJ/ar/xphdlui+YDhmb2mlMSG4Vrh
TTLwzTTsyAp5pE834ZvEa43MBebrjxbj49uIoyV3Ut6psO6qjI0N4E20LAFhA8iE
a8qcFZLIFD95G9kqAg7yvFP/v3O3glYBnaBMSo+7pg==
=NH0L
-----END PGP SIGNATURE-----

--KLR62ZwG+3BuLtMl--

