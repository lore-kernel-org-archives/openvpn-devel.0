Date: Wed, 12 Apr 2017 20:37:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170412183701.GF93896@...1296...>
References: <20170411173133.18060-1-davids@...515...>
	<20170412062437.GZ93896@...1296...>
	<20170413042356.15732018@...2263...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rR6pEsNFzVJhSSrj"
Content-Disposition: inline
In-Reply-To: <20170413042356.15732018@...2263...>
Subject: Re: [Openvpn-devel] [PATCH] Require minimum OpenSSL 1.0.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steven McDonald <steven@...2262...>
Cc: openvpn-devel@lists.sourceforge.net

--rR6pEsNFzVJhSSrj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 13, 2017 at 04:23:56AM +1000, Steven McDonald wrote:
> For example, OpenBSD does have pkg-config for libssl, but hasn't
> updated it since LibreSSL was forked:
>=20
>   $ pkg-config --modversion libssl
>   1.0.0

I think LibreSSL needs to just die in flames...

Their approach of "we pretend to have OpenSSL's API, but we're not
telling you what is really in there, and our version number is meaningless"
is just needlessly painful.  And we've been hit by this before.

(BoringSSL is not such a big problem since they are changing the API
in incompatible ways, so compilation will fail anyway)


But advocacy aside, since the pkg-config stuff isn't going to really
help us in deciding "this is good enough for us?", it looks like we
need a conftest.c that will just look at the version number #define=20
in <opensslv.h>, and that one can then differenciate against LibreSSL
as well ("if it's LibreSSL, 1.0.0 is good enough, if OpenSSL, 1.0.1").

Needless waste of human lifetime, but solvable.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--rR6pEsNFzVJhSSrj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY7nPNAAoJEB2Cnv7KVigSwdEL/iTU/SgI3qbVyg/8MYXZI+oB
fVarduS/2TKdlHAMZO9Ts7IPOYPyJ6XIqiq6ZpnthVr0zg9ytLOYkkWnxtOl1Prs
FPESJd7eplKKkMN2V6YLU1apcMLDK8t0FuXJA+cOadXCWyD9GI9sAlzv0wONTt0D
CsFYr31pIR7U6tLiRURlfyq1Q0oQ5BWAF9fSBmiz5ST5IJqwaqiXbHyOt0IFr56m
yy8S9O1Vt8QbIZzu9fvMu6vY525pfL19HhjqgFpk/RVfufwWPeMSY/Lqhjubb94F
lfsr49EzEIshnik39AbVhPAbHwis3PKIVbt7oExg4AqPt/ev7+Fg6JAfkmkhQghL
ZVJQNgfaZKmrFZPI5cPlRydTZ3+t27fHman4RPQBGYGvHiA8vIk+UINZmXW9pDLz
GsSUuihwQ6kvIa6pgRYt+qnsViwQePUDnVPfrDhiyy1v2J7aFRcxj/evMK5JwReG
zleY08vEfGgn+wcTn3x8ht+6FOanNVjr3fPbszCc8w==
=DYpm
-----END PGP SIGNATURE-----

--rR6pEsNFzVJhSSrj--

