Date: Sun, 5 Jun 2016 19:24:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160605172402.GT53051@...1296...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="57uLm+RYusAtABnT"
Content-Disposition: inline
In-Reply-To: <CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
 framework
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--57uLm+RYusAtABnT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 04, 2016 at 01:17:25AM -0400, Selva Nair wrote:
> The joy was short-lived. mingw cross-compile from release/2.3 tarball is
> also broken:
>=20
>     error: cannot find input file: `vendor/Makefile.in'
>=20
> Thankfully, cherry-pick 41ab12f06253c fixes it.

I have cherry-picked 41ab12f06253c this for the time being into release/2.3:

commit b76acd72cd8ea295b925e058336440ff819ca8f4
Author: David Sommerseth <dazo@...2145...>
Date:   Fri Jun 3 18:56:20 2016 +0200

    Another fix related to unit test framework

    Signed-off-by: David Sommerseth <dazo@...2145...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <1464976163-6162-1-git-send-email-openvpn@...2080...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/11778
    (cherry picked from commit 41ab12f06253cadc34fc47da865178de3db0bbdc)


> IMO, the unit testing patches shouldn't have been merged into the release
> branch

I have discussed this with David (after the fact, meh) and we couldn't=20
really come to an conclusion on this - but since you and Jens now both
argue that way (and especially Jens as the original author should have
some authority here :-) )  I think we'll revert the four relevant patches
again.  Looks silly, but keeping stuff in a tree where we did not want
it to go in the first place, and then spending time maintaining it there
looks even more silly to me...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--57uLm+RYusAtABnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1RgMakuBuNlUUl1AQKSmwP/REcFuYQZwi/cqOc19qKaTbdlTROyvnp0
mbHkLGfjw9kCGam9rI7GtvWWtLmZrsvH5g5mWJlqS0qayrN/FeFTB8dxe49YgUgv
IHH95K0QxghtKwKB2CcZr+u0NcbQ7mK5h4n6ORh4LXcWwBI4kWBBUOE9MZhR0/E0
wjSb8OF8wIg=
=UX3R
-----END PGP SIGNATURE-----

--57uLm+RYusAtABnT--

