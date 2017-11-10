Date: Fri, 10 Nov 2017 15:45:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171110144526.GS958@...1296...>
References: <20171110110858.11482-1-steffan@...1856...>
 <201711101437.vAAEbuVY085846@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CvOg3jo0sXL5jEc+"
Content-Disposition: inline
In-Reply-To: <201711101437.vAAEbuVY085846@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Simplify and inline
 clear_buf()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--CvOg3jo0sXL5jEc+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Fri, Nov 10, 2017 at 03:37:56PM +0100, Gert Doering wrote:
> ACK.  Makes sense, simplifies things slightly, and passes all tests :)
>=20
> Your patch has been applied to the master branch.
>=20
> (I'm experimenting a bit with the formatting and the patchwork headers,
> so do not wonder why the remainder looks a bit atypical)

So, just for the record:

> Acked-by: Gert Doering <gert@...1296...>

*this* gets picked up nicely, if (and only if!) it's on the start of=20
the line.

(So, please send your ACKs in this format if you want patchwork to=20
see them :-) )

> X-Patchwork-State: Accepted

*this* is totally ignored, no matter whether it's in the body or header.

More investigation needed...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--CvOg3jo0sXL5jEc+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaBbuFAAoJEB2Cnv7KVigSPxkL/iUaGk9sdHInXDaw2ZGphrH1
9pNOpypRtGPvWkhylBx15kgwGZBZhS0rHrn9YJyTLzbq6dDUSQu9Z+e86tF0wzJv
wbo9csR7e1N0rM18WEWWKINZODnptj0AzbugTBp4+ZTn+2hCckErf+AlmzQBcDy8
BlNCN1xPqs2r3DdwDCbhLd8OIjOt+XZTb9gP+B1u3khfVNNjOiUQmvmyqaGLClC6
+tirpL3OC5x6vXhHJEsBhDQcqs8u0HIIesu2q97Uuh11dSDOStRA0i5C1K+WYts0
UtqpsQXx6SJoyWi1pGJeTBrwFL2QlL9GDWeza9ERzZIpOa7Qlt/3KFDxJRJCAnF6
l4XmsKRr8mklstlNUsRMWGMKO1ed0jdox2d9U8821/yYphNtp42o3wTtDY+ab1N+
gRvrmaSUMCqlGOdy4ZaI4ELAzicmIG+sZakH8ZIK0hNfTYiekOUGQOpoDiOj+tia
mPXy+I/DAfno1l47CNFY6qdoYEACA0NkXl6MBgdsAQ==
=gvd0
-----END PGP SIGNATURE-----

--CvOg3jo0sXL5jEc+--

