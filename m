Date: Mon, 11 Nov 2019 08:23:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191111072328.GR40538@...1296...>
References: <20191110133525.6069-1-a@...2181...>
 <20191110133525.6069-3-a@...2181...>
 <CAKuzo_ha8xxM+bw=Lrq01dnCNhNDqzS1EQGaptjUrdDq5pqcLg@...278...>
 <20191110170338.GP40538@...1296...>
 <CAKuzo_h+qTFQvUeiCM1TewW1b1XC7OvOESbEo+CtJWmMAUgvqA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sFpaGyYnmHGeDLGB"
Content-Disposition: inline
In-Reply-To: <CAKuzo_h+qTFQvUeiCM1TewW1b1XC7OvOESbEo+CtJWmMAUgvqA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] travis: compile with -Werror on
 Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sFpaGyYnmHGeDLGB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 10, 2019 at 05:03:26PM -0500, Selva Nair wrote:
> > the
> > > temptation to add -Werror in general and to Windows cross-build in
> > > particular.
> >
> > Yeah, we're not intending to.
>=20
> But the patch does affect cross-compilation for Windows on linux.

That seems to have been an oversight in how to feed Travis what we want -=20
I saw an update yesterday evening.

> Unless restricted to a very small cross-section (say gcc x.y + linux) this
> is going to cause a lot of grief. Note that every check run by configure
> that succeeds with warnings will become mysterious error at build time.
> There may be other unexpected failures too. -Werror is never fit for
> production in my view. There is a reason why warnings are warnings.

"gcc $current + linux" was the plan, and only do it in Travis, not do
it in configure for general consumption.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--sFpaGyYnmHGeDLGB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdyQxwAAoJEB2Cnv7KVigSx6ML/1w0faaHTUrnt6Cy82F2+Lxz
2op+utg/WKKsvvVgouPbkxawk8sQpetrEiWWhpU+TFIXpRAKAyYnmQgYgoHBVGbq
O+SifsFwILmhLr1fLWRVDYIiAZiYembwhlch0jIjk+NLpxTHEk9iTdVt3tTNxX2L
1msTLj6F6BIPGXdfyjRX+WDCA9vwfloKNehALcrWKjj7xEql6axn8CnaknqaFV2P
3C+EsYVpK3n8XJ6u36uf38/crlY2WBNdj08lhfmlDi8G1PDmHaBh/d0/SxSZfhJM
JuoEWQrjCaSgydj2653/kOIN7OsH9WRoFylAjz8lYqYfhCIlAd5M3GKz/HsuG/xN
Yq8nRzkb4d7EmPw6Wy9gC7PxJXL99BwckoFl075Q5/nVSYdHH6CMAXbPyflGwssU
OWrQGBFv4RPBoqCUKcwdijLEDoeJjOp80PuVeucfX+6JP85XfdtcSqYVoG3Ozh2P
AC43zUP6g7xieNX7we+Up/0ikgcj/VbptMe0DcMgFg==
=LAKC
-----END PGP SIGNATURE-----

--sFpaGyYnmHGeDLGB--

