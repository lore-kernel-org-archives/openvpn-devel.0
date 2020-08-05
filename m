Date: Wed, 5 Aug 2020 13:45:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200805114523.GA75094@...1296...>
References: <20200729113835.2415-1-arne@...1227...>
 <20200804202010.GV75094@...1296...>
 <b8c90764-96e4-6e6d-2060-ee3d84cb446d@...1227...>
 <20200805064318.GY75094@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QxN5xOWGsmh5a4wb"
Content-Disposition: inline
In-Reply-To: <20200805064318.GY75094@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Rework NCP compability logic and
 drop BF-CBC support by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--QxN5xOWGsmh5a4wb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 05, 2020 at 08:43:18AM +0200, Gert Doering wrote:
> Test run with "cipher bf-cbc" in all server configs next...

For completeness, this works nicely:

start client jobs...
22...
Test sets succeeded: 1 2 3 4 6 8.
Test sets failed: none.
23.small...
Test sets succeeded: 1 2 3 4.
Test sets failed: none.
23...
Test sets succeeded: 1 1a 1b 1d 2 2a 2b 2c 2d 3 4 5 6 8 8a 9.
Test sets failed: none.
24...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 4a 5 6 8 8a 9.
Test sets failed: none.
master...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 5 5a 5b 5c 5d 5v=
1 5v2 5v3 5w1 5w2 5w3 5w4 5x1 5x2 5x3 5x4 6 7 7x 8 8a 9 2f 4b.
Test sets failed: none.


so, if we break someone's existing server setup, the answer is

 "put 'fallback-cipher BF-CBC' into your config!"

(or 'cipher BF-CBC' explicitly, so it's 2.4-compatible)


Not sure how to tackle the "ccd/ push cipher is broken now with 2.4-NCP
clients" part.  I think this is useful functionality, but the current
patch does not allow this "unless the client is already using the to-be-
pushed cipher, or it's one of the two NCP=3D2 AEAD ciphers".  Which makes
it slightly less than useful...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--QxN5xOWGsmh5a4wb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfKpvSAAoJEB2Cnv7KVigSFpsL/ilDs/ReYrL3z3Dba1eUtt3Y
oAaxZAn4IRfJc4JvBEAaigDvC88VW6F4RjFqJlP8ylkxsMjBNoVfGZvv892lMXnI
SamenFAEN+V0TMOW7cidl3AsEXHOJwZiQiS7aFXaUAg2J1o0s/ITKzO1U0lQEUnx
NeUy+yIv9C/JHv6a2qkkUbGBUaEhwp7JFzsMvRs45gGY57CGdY4VfrgnPbDCweBg
YFA5ak8TDMay0T0uQtDdyrb8Xaqj11cAvykm2Zkgf+aT0jPA3/KL/pLMMjwiDXmm
Kg8Y3ajD6/14JtfTU6Rv7Ldkrb6xB7TrlGiRsjXo06pV2fw+k3qUcq+QcuI5W274
5eV3aDjrj4K9S7m2Lco/r+cB3Hykppj6xDCRzoczfziOBV+MjRsYXVzJi2NHoMYP
Ylny/3hevEABBjGuZFkelfJIs5OzObFlaeXwC5HArtDXyg8s/kI7rCFQpjvDEhCJ
AeyF5359MG1MgCckLIjxfGpe91s0JyCiTJx3Fh2q2g==
=QaHS
-----END PGP SIGNATURE-----

--QxN5xOWGsmh5a4wb--

