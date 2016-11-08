Date: Tue, 8 Nov 2016 14:49:34 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161108134934.GC28918@...1296...>
References: <1478609729-25222-1-git-send-email-samuli@...515...>
	<1478609729-25222-3-git-send-email-samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uxwbQ5uNL5ssFhxJ"
Content-Disposition: inline
In-Reply-To: <1478609729-25222-3-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] Prevent generation of duplicate
 EXPECT_IFCONFIG entries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net

--uxwbQ5uNL5ssFhxJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 08, 2016 at 02:55:27PM +0200, samuli@...515... wrote:
> +grep EXPECT_IFCONFIG4_$TESTNUM $RC > /dev/null 2>&1

NAK.  This will grep for stuff like "EXPECT_IFCONFIG4_1", and if the
RC file has

EXPECT_IFCONFIG4_1a=3D10.194.1.54

the grep will be successful, and "EXPECT_IFCONFIG4_1" will never be added.

So this needs to be something like

=20=20
grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC > /dev/null 2>&1
                             ^^
and

grep EXPECT_IFCONFIG6_$TESTNUM=3D $RC > /dev/null 2>&1

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--uxwbQ5uNL5ssFhxJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWCHX7akuBuNlUUl1AQKn7gQAxspPNsostHzcck30zB11zd2St8RxPpr4
GwZ0EOE0aIyPePWLmopmv9hD1K4YLomuk3es+WvUbIWJzXW/xzwlbaD4i7H667j3
g258FMpoeTfFMHrXeIYVtmaDBMAXNR0R0dUIF/WN74Acv9e5BowlBJu/nsWhElyZ
L8aK65Q1qYo=
=1FRh
-----END PGP SIGNATURE-----

--uxwbQ5uNL5ssFhxJ--

