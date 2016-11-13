Date: Sun, 13 Nov 2016 16:43:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161113154337.GA6684@...1296...>
References: <1479043047-25883-1-git-send-email-steffan@...1856...>
	<201611131350.uADDohOl005906@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <201611131350.uADDohOl005906@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Don't deference type-punned
 pointers
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

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 13, 2016 at 02:50:43PM +0100, Gert Doering wrote:
> ACK.  Brilliant approach to "make the compiler happy" that is *increasing*
> code readability, not making it worse.
>=20
> Reviewed ("STARE AT CODE!"), client tests on linux and freebsd, server
> tests on linux.
>=20
> Your patch has been applied to the master branch.

This had interesting fallout.  I expected some linux/BSD issues (due
to generally different socket things), but instead the buildbots had
massive issues on all "older" systems - namely, NetBSD 5.1, OpenBSD 4.9,
CentOS 6, FreeBSD 9.3, FreeBSD 7.4.

The core of the issue seems to be this one:

gcc -DHAVE_CONFIG_H -I. -I../../../openvpn/src/openvpn -I../.. -I../../incl=
ude  -I../../../openvpn/include  -I../../../openvpn/src/compat           -g=
 -O2 -std=3Dc99 -MT error.o -MD -MP -MF .deps/error.Tpo -c -o error.o ../..=
/../openvpn/src/openvpn/error.c
In file included from ../../../openvpn/src/openvpn/manage.h:33,
                 from ../../../openvpn/src/openvpn/options.h:40,
                 from ../../../openvpn/src/openvpn/ssl.h:43,
                 from ../../../openvpn/src/openvpn/ps.h:32,
                 from ../../../openvpn/src/openvpn/error.c:43:
../../../openvpn/src/openvpn/mroute.h:99: warning: declaration does not dec=
lare anything
../../../openvpn/src/openvpn/mroute.h:103: error: 'struct mroute_addr' has =
no member named 'v4'
../../../openvpn/src/openvpn/mroute.h:103: error: 'struct mroute_addr' has =
no member named 'v4'
../../../openvpn/src/openvpn/mroute.h:103: error: bit-field '__error_if_neg=
ative' width not an integer constant
../../../openvpn/src/openvpn/mroute.h:106: error: 'struct mroute_addr' has =
no member named 'v6'
../../../openvpn/src/openvpn/mroute.h:106: error: 'struct mroute_addr' has =
no member named 'v6'


which translates to

 - the new union most not by anonymous ("does not declare anything")
 - if I name it, like "a", the warning in line 99 goes away
 - but then, all references need to be added that name
     "addr->a.v4.addr"
   etc.


While I could live with abandoning FreeBSD 7.4, we need to keep supporting
at least FreeBSD 9.3 - so, any ideas how to deal with that?


MinGW builds fail because there is no "in_port_t" declaration, which is
something configure should be able to fix for us.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYKIooAAoJEB2Cnv7KVigSFtAMALWGAj3hg/sgVGV5aXh41ByZ
IItPcqp5WQwkJObseDLbhSXqDVHFNW2/qPlyiTViJ2l5zx2Rglrmuebz7Gmsk/7k
VDfDhrlQb+VLa0E3k/3+aZhyTGWvuBTYIAneOdpl3nofQnJTOUVAzMCg6WvaW55+
bHos7QXs/Pd/t2c0mfHOS688e5+0zWu43RHA0HuxoFNUo9M4k9xkKYUogDpJwLMk
ecICN076Koq7bVTaQrniCoGLdeVy2z6Uap3pMuZCEz1Kl1crMphe/Ie4NYak19n/
DIb8UT73ece6JzcUyBZKf+gSf3NZjioYNSO5kM7LwQJXlNhdNRe/dXlu+VdnYJgY
PlNEJxxtOd8iuBjHOtcjjLkC+gKL8DuVHHcSoZq0QEJMHS1MRBQb16BQDUuPGnj6
3MqSbK7axBrmYrm0w4DCTD8d3JWyMLztcCEI2k1rF/PyTZtwsN0Ex3AEf9kzDQn4
WvZ2vXPArGdwiXRl+U6OLgioJmsWYb11OpOkQaQ86w==
=v6ft
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

