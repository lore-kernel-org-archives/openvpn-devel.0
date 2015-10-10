Date: Sat, 10 Oct 2015 12:48:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151010104825.GW22054@...1296...>
References: <etPan.52df80ec.2901d82.13bb7@...1863...>
	<5618CEAC.5070509@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tQHaQFR6K/xpRpl8"
Content-Disposition: inline
In-Reply-To: <5618CEAC.5070509@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Update expiry date in management event
 loop
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--tQHaQFR6K/xpRpl8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Oct 10, 2015 at 10:39:08AM +0200, Arne Schwabe wrote:
> Am 22.01.14 um 09:27 schrieb Thomas Veerman:
> > When there are events from the management console with an interval shor=
ter
> > than 1 second, the event loop never stops as it keeps resetting event_w=
ait.
>=20
> ACK. It is a strange cornercase and the patch does not change behaviour
> otherwise.

Thanks.  Patch has been merged and pushed.  (The formatting of the=20
original mail was a bit funny and upset "git am", so my auto-reply-
genereation failed either...)

commit b51a024a7b26e691e6459964d4d29f15b70089bd
Author: Thomas Veerman <thomas.veerman@...1862...>
Date:   Wed Jan 22 09:27:29 2014 +0100

    Update expiry date in management event loop
=20=20=20=20
    When there are events from the management console with an interval shor=
ter
    than 1 second, the event loop never stops as it keeps resetting event_w=
ait.
=20=20=20=20
    Acked-by: Arne Schwabe <arne@...1227...>
    Message-Id: <etPan.52df80ec.2901d82.13bb7@...1863...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/8253
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tQHaQFR6K/xpRpl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVhjs+KkuBuNlUUl1AQIXzgP+P4KKh+sFkk5n1FH8dSgjDpyFtTKIkBj+
g3kC0UFzmN2uLjxlzDf4WtZUBQxUUw/a1Yt24CK/htsvqrsVgn71p7ouKIIohbXG
2Y9DQCGq14odaN8Qqr2M3FIsCzL4yWwZWkfmtPAQk12YUrwHQY4iKQ2KdsLoh3sX
7sIqkSLf5zE=
=OPVV
-----END PGP SIGNATURE-----

--tQHaQFR6K/xpRpl8--

