Date: Mon, 29 Aug 2016 21:28:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160829192838.GP78279@...1296...>
References: <57C482E0.6080308@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R253y6Ojx11zD2IK"
Content-Disposition: inline
In-Reply-To: <57C482E0.6080308@...1147...>
Subject: Re: [Openvpn-devel] Time to change the default cipher?
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

--R253y6Ojx11zD2IK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 29, 2016 at 08:45:52PM +0200, Jan Just Keijser wrote:
> uhoh:  https://sweet32.info/
>=20
> shall we change the default cipher in the master tree to AES-256 (if not=
=20
> done so already) ?

If a master client talks to a master server, they will negotiate AES-256
automatically, so it's not strictly needed to change the default.

I would advise against changing the default, though - it would break
people's config if talking to older servers and not having an explicit
"cipher blowfish" in their config.

OTOH, what we could do is: indeed *change+ the default, and add a big fat
warning ("you have not specified a --cipher directive.  The default has
been changed from 2.3 to 2.4, so please ensure your config matches the
other end" or something like that)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--R253y6Ojx11zD2IK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV8SM5qkuBuNlUUl1AQKu5gQAvI5Fl9JsUDxaeFyK5oHXStUhLpYFymI1
F4JM1oRnLeJj1BuDM4Ql7IIwzJgeZigVVYps/fKt+DNKthj1eLy7NzoXujwQmsLH
W8m008Q8XZ0KTiH7L5I3CKh0BTiZXdaOtaHrL9+WiDIKKCvWfJN6e9H24I7GKQE/
yDmh3HR83vg=
=1aB8
-----END PGP SIGNATURE-----

--R253y6Ojx11zD2IK--

