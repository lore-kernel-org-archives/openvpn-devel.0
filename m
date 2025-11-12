Date: Wed, 12 Nov 2025 15:34:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <aRSa9JwiVksvEB6R@...1296...>
References: <CAOh3LPP9XVUU7TGHP51RdBEYSRKW1ih3EV_-FxiNxmiZCCS47g.ref@...278...>
 <CAOh3LPP9XVUU7TGHP51RdBEYSRKW1ih3EV_-FxiNxmiZCCS47g@...278...>
 <aQcXgtGRUKqadBPc@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uIfjEMEkAG8IXP7X"
Content-Disposition: inline
In-Reply-To: <aQcXgtGRUKqadBPc@...1296...>
Subject: Re: [Openvpn-devel] Question for the devs - Found something
 interesting in the OpenVPN source code that I change in my modified
 version...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jon Chiappetta <root@...2904...>
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

--uIfjEMEkAG8IXP7X
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 02, 2025 at 09:34:10AM +0100, Gert Doering wrote:
> > In my modified version I wasn't sure of when this hard reset check
> > condition would be true but to prevent an invalid memory access I chang=
ed
> > my code to be this instead:
> >=20
> > if (i =3D=3D TM_SIZE || is_hard_reset_method2(op))
>=20
> From my understanding of this code, this is the correct fix.
>=20
> Good find!

As a followup to this - it's not the right fix, and my understanding was
not sufficient.

Arne understands the code better and has just moved the possibly-invalid
pointer initialization a few lines down (to be committed in the next few
minutes), after the check on "i" and error-exit.

Thanks for your report!

(There is another one which I'll look into "really soon now" :-) )

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--uIfjEMEkAG8IXP7X
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJpFJr0AAoJEB2Cnv7KVigSmPIL/Ax5cxqM896xpMFQjCL9Q9wc
nLN+zUb1yKFlRUJmOSwHZu0sCivvaNQ3mQXVqU5gjkyjv9Bu4qPySxB3HeF7c5HV
Vw5B+yKwa0RGq1XwDIksWESGo41P9YWgN3pmTI0IqLK/Ri+i3UM336TFttLKRVLa
6WV9j5g3rUwVNEAFGjP7dopmHfcDJ8n3Zyk+RKD3eYn/oQG2X0eFitaEjFvj++xS
LewM5drpLc/OSg+ZN0nuU9o7reZp37sSC+fkqSIJ3MJ/qD1AAgCa2lXX3mt/Zun2
BMlLC6GbJiLBFhZui+2tVt6Z/eMpxm5SVfxNB9RTsLvks6AJXxFDy3BHO4qyY1Md
yxkMfiHtz2jLR1m2qmyTABwnlIgiPrNUYQUrcTSp+z1h5Yqlhk0rkCc6k0zFStsE
bBOJd1LlNrqd2+uTCSqbE1D1iB8RXC+ckmC3+fGLgbSQnPpUtlVFU5iovc6B975z
2nING6720vo74vePzJaX5cgQXcDsx5uxAjA2widj+w==
=qFuo
-----END PGP SIGNATURE-----

--uIfjEMEkAG8IXP7X--

