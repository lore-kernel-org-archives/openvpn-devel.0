Date: Fri, 14 Oct 2016 10:06:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20161014080623.GG28918@...1296...>
References: <1476388771-16492-1-git-send-email-davids@...515...>
	<1476388771-16492-2-git-send-email-davids@...515...>
	<3562f914-bd4c-84f8-46a0-8010d94a2ae1@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <3562f914-bd4c-84f8-46a0-8010d94a2ae1@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] Move memcmp_constant_time() to
 crypto.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--cYtjc4pxslFTELvY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 14, 2016 at 09:54:00AM +0200, Steffan Karger wrote:
> > +/**
> > + * As memcmp(), but constant-time.
> > + * Returns 0 when data is equal, non-zero otherwise.
> > + */
> > +static int
>=20
> I think this should carry an 'inline', now that it's in the header.

Indeed.  Do not put non-inline static functions in headers - they can
end up being compiled into every single compile unit that includes
that particular header (*some* compilers are smart enough to see that
it's static, and not referenced, but they are free to "not care") - and
it's bad code anyway.  Either inline, or non-inline "somewhere" and
just the prototype goes into the header file.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWACR/6kuBuNlUUl1AQKnYwQAsHHGwhQ7XiEerWZgy8jipPuKCRXCHtOO
erVPJfWoEoO54hrq0ZDLjGXemVhc8aw/m51wJlJ6gZmJQuzYiSm1I2yUtO1O6ynZ
bwEKUgUlRcghI8EjA7goT14M3NkFzPQlbkDjXQt1J/3yhMgnkC2jl7jkhT+E48/A
47r5xxT7/qU=
=iZM7
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--

