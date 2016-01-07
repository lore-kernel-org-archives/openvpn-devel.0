Date: Thu, 7 Jan 2016 09:44:39 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160107084439.GO24952@...1296...>
References: <1452110639-18262-1-git-send-email-steffan@...1856...>
	<201601070813.u078D2WS044270@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Dwe9UmIHzUfVj5b"
Content-Disposition: inline
In-Reply-To: <201601070813.u078D2WS044270@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: polarssl: optimize
 polar_ok() for non-errors
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

--9Dwe9UmIHzUfVj5b
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jan 07, 2016 at 09:13:02AM +0100, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> commit dd8d32e1e1da90b441fb25e62a8aa0e68428f601
> Author: Steffan Karger
> Date:   Wed Jan 6 21:03:59 2016 +0100
>=20
>      polarssl: optimize polar_ok() for non-errors

Actually, after applying to my tree and running my test suite, preparing
this mail and all, I came to the conclusion that this is not safe, as it
will evaluate "errval" - which usually is a function call that might have
side effects, like "destroying the original polarssl error code" - twice
in case of errors.

So, *not* pusing it, resetting my local tree, and Steffan will send a new
version.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--9Dwe9UmIHzUfVj5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVo4ldqkuBuNlUUl1AQJU0wP/TKz1H2jtK2KMZsT+/Pvtp8q9/6atFayh
uJq3ApaGyoQkzwyNYkbGsL3HjRgbClzbquSJnA8jFE3oIlmx/CPwJU3ZoSD4eh9W
9IK7jSrhOnBVRpXt28andYN+ZGKnHoKKglLs7xZy4VSRvCR6QLsQxt4l0GU76BOE
y0x/CIbrTpE=
=s8br
-----END PGP SIGNATURE-----

--9Dwe9UmIHzUfVj5b--

