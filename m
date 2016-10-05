Date: Wed, 5 Oct 2016 14:34:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20161005123444.GS78279@...1296...>
References: <1475613736-1529-1-git-send-email-lstipakov@...277...>
	<842a27b1-8ce3-db91-2c76-71cfc705e1eb@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="waELlFB4HDL0UWTv"
Content-Disposition: inline
In-Reply-To: <842a27b1-8ce3-db91-2c76-71cfc705e1eb@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 2.3] Fix compilation in pedantic mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--waELlFB4HDL0UWTv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 05, 2016 at 02:04:02PM +0200, Steffan Karger wrote:
> I do prefer
>=20
> /* Some text
>  * more text
>  */
>=20
> over
>=20
> /* Some text
>    more text */
>=20
> but am not too religious about that.

I am, and the first version is what we do in (most?) other places, so I'll
change that on the fly.

Also, the patch introduces spurious tab<->whitespace changes "close to
comments" in a few places - will undo those, too.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--waELlFB4HDL0UWTv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV/TzZKkuBuNlUUl1AQJbhwP+LUCjMI8Pw0ARKOtLajxCajxkAIG5j8Rj
uwIDW9RmRQ5w4D6/gUYdGiwxX6HrnW1ZWZ0L6jZb391fVwjCoistGZpcVmKLU7Ag
BGNJJVA5CHFeDEa+WwGIXpC/lXQbLu9pRbreSqXA/Tx303DpNXtIynrufnCScxi2
MkGCUVAso7o=
=tHk5
-----END PGP SIGNATURE-----

--waELlFB4HDL0UWTv--

