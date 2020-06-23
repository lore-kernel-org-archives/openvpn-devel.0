Date: Tue, 23 Jun 2020 21:26:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200623192627.GA11911@...1296...>
References: <20200622232319.8143-2-James.Bottomley@...2316...>
 <202006230628.05N6Sa3g001325@...2054...>
 <20200623072123.GA2034@...1296...>
 <1592917531.4768.4.camel@...2316...>
 <CAFHpkQF5tz91P_UJxMuNCRDUYodw8QPV8=h8mmkSTHOUH5AdfA@...278...>
 <CAFHpkQH-yGFBJ=-Eaz5XCSaUcD-=S00y=MvPs6Vmr5nE_PcTRg@...278...>
 <1592936237.4768.43.camel@...2316...>
 <CAFHpkQGQgQm2cEA1kw1JpRkf4Ldu4kT=y-YXF-6cLTXbEx_zDQ@...278...>
 <20200623184733.GK1431@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20200623184733.GK1431@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add unit tests for engine
 keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: James Bottomley <James.Bottomley@...2317...>, Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 23, 2020 at 08:47:33PM +0200, Gert Doering wrote:
> On Tue, Jun 23, 2020 at 11:36:49PM +0500, ???????? ?????????????? wrote:
> > Also, I think we should out log.txt in case of failure.
>=20
> Indeed, this would help.

Yep.

The "make distcheck" travis instance is now happy, but the "1.0.2u +=20
enable-small" instance is still unhappy.

James, are you triggering on specific openvpn messages?  "--enable-small"
changes these (trimming some warnings and help texts).  Can you test with
"configure --enable-small", please?

https://travis-ci.org/github/OpenVPN/openvpn/builds/701385033?utm_medium=3D=
notification&utm_source=3Demail


gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe8ldjAAoJEB2Cnv7KVigSv0cL/j7cpeWsCuQGRDOn2zqUTm0e
nx2ukP4W9aYGDmj19tkGqEXc6Icvc2rfgbW196unyIEoDHi+0pp54wHiur3pUHcg
vBD9XNNY5bVdIOSAfnQXt+pgjSba8n1Cs7X5Wvc4PuZKJ/3jcSQmbiDqAcf0fHlN
xzYtM/liaMDRyVYgZRrLzGPCVFKyaQ+n+92dJw5ORVU3l8PoJ3nfkXVmxxBkoAr+
tWw4E5lDVn+7kOzKTbajVDVT0CwvBjUFubCXiKPvuTObjDk6olabexHWTMNUZrIT
doVIw9BxJpzFj+roV0SaNsUKx9HQPp3BJrDeQWl6DAzECXjxA8MK4OAMt+Yu3ZLH
ogdfx8E2tE+m/3dScDYHRkHUrpA7QmVlzs+bbVYh2YcPEm5EENtaEpYOQCXsBexx
iOmMjG6UZ2sYiVFLDnfXqA+lYyfneTuUvkFJ+drZpRo3mW8fs/lX5i8HfEpn1vrF
6dMor7CLTt4hPD1hxzcqXKdZqh+Dehhq5iaCV8WQmg==
=BdH8
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--

