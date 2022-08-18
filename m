Date: Thu, 18 Aug 2022 08:10:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv3Xw2voNQk+0WoR@...1296...>
References: <48db419f-0d5d-a9b9-6f55-dffc5d4fbbe5@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xEB3jPu5AYIT5Sh9"
Content-Disposition: inline
In-Reply-To: <48db419f-0d5d-a9b9-6f55-dffc5d4fbbe5@...1227...>
Subject: Re: [Openvpn-devel] wolfSSL unit test failures
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Juliusz Sosinowicz <juliusz@...2525...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--xEB3jPu5AYIT5Sh9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 18, 2022 at 12:40:09AM +0200, Arne Schwabe wrote:
> From 02d4c4d8444188bdf32a054171ea7e20cc7c12ff Mon Sep 17 00:00:00 2001
> From: Arne Schwabe <arne@...1227...>
> Date: Thu, 11 Aug 2022 19:27:12 +0200
> Subject: [PATCH] Add wolfSSL to github actions
>=20
> I just want to see the world burn a little bit

I'm not merging this as of today, because I do not really want to get
an error notification from GH on every build.

As soon as this is fixed in upstream WolfSSL, it's a good addition to
our test suite.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xEB3jPu5AYIT5Sh9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/dfDAAoJEB2Cnv7KVigSXRAL/ipgFxgCGZg/p4rNqrAYDReU
WFttzKRWSUtHCJMVCbBf8CJPcrkLS1Mrey0wU96HahbNB+S0SxCuBBZFilZL7jwp
vRkYggZTc+otzRg5kmjHsazHWPYutowtxeRFgWA+6SkFWe4FicNhydV9oYlnlW2K
FeWjPMTrtpaYMsEI6sIxdAqj5pjstUc+BBMRBK9/et5vI84OxHO+UkYAYQu+rHzc
4WDZMP/fAipuOkaeby457cDtYKxfCj9di+yDF3p1sGmv7LDef4qy8uK5L2xwooIb
N+R5dBqblLpFQP41wYDOda1pD509MLzxsy0cG1NcK7NGcE7kJs839SWKsafz/+mi
oRbKGYnLH54f9+bKkM4ervfNO3kA4Z5Ta3lzBdxt1r8+5RStMOIPK0QMN3Q3ebfi
wls9N/4+FpPnI6sfFnk6YiyTYJYlnflKW0b4TcQqRdLmSs6DMfy0OOK/k70enYwD
3GVPVgzfj2a/xt7jnEq/4r7q9WgKW73Cst89ib2JaA==
=/an2
-----END PGP SIGNATURE-----

--xEB3jPu5AYIT5Sh9--

