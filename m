Date: Fri, 28 Jan 2022 12:15:34 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YfPQVunkBAhZWuXC@...1296...>
References: <20220101162532.2251835-1-arne@...1227...>
 <20220101162532.2251835-3-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SadpAjIKl05LKXC/"
Content-Disposition: inline
In-Reply-To: <20220101162532.2251835-3-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 02/14] Fix mssfix and frame
 calculation in CBC mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--SadpAjIKl05LKXC/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jan 01, 2022 at 05:25:20PM +0100, Arne Schwabe wrote:
> This commit fixes the MSS calculation in CBC mode. This fix has two parts:
>=20
> - Added rounding to a multiple of block size during calculation of overhe=
ad
> - In CBC mode the packet ID is part of the plaintext (or payload) rather
>   than part of the header (like for AEAD), adjust the functions to
>   correctly reflect this.
>=20
> OCC link calculation is not affected since it ignores rounding of CBC
> block size completely.

I've done a bit of whacking of this, and it is still not fully right,
unfortunately.

The short form is=20

  - BF-CBC, LZ4, --mssfix 1000, over IPv4
     v4 TCP -> MSS 923, resulting UDP payload <=3D 1008 bytes
     v6 TCP -> MSS 903, resulting UDP payload <=3D 1008 bytes
 - BF-CBC, LZ4, --mssfix 1000, over IPv6
     v4 TCP -> MSS 923, resulting UDP payload <=3D 1008 bytes
     v6 TCP -> MSS 903, resulting UDP payload <=3D 1008 bytes
     [so this is clearly wrong!]

 - BF-CBC, comp no, --mssfix 1000, over IPv4
     v4 TCP -> MSS 923, resulting UDP payload <=3D 1000 bytes
     [can't test v6 inside in this particular server instance]

so, something is wrong with the rounding and the compression opcode=20
in CBC mode.  With "comp no" the resulting packets are correct (UDP payload
<=3D 1000 bytes), with "comp lz4" - doing the framing, but not doing
actual compression - UDP payload exceeds --mssfix config.


So, not merging this, until we've decided how to proceed (fixup patch,
or new version of this one).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--SadpAjIKl05LKXC/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJh89BWAAoJEB2Cnv7KVigSXaQL/jX6iN7NZBW6fRh57EnUdh77
vCQjxgYIv4YcjAX7tinWuRmUDqbr9eSXLTRXlQ0VuIdlOmL8KpEtGPvdXCOjcL8t
aXL0Emy5+AZwynAcgnd7H2yGNMvjlmbYSk4cvlL8h2rIVyr3c2a0XY+Vin6E2Ktx
kRd+USYP2UTr7NBe0zyMs4ATZHONuEXYIpbkh/2RyVZmtsxxr9bOXUOvvjqzajls
lOhIYpL6HfLBjidm1LtVYquVN2cWb7xVOysv8c5d6fXkLJpvCv5bq7MJbxQ+M6nl
QBVjMiJEX2A34QjeGEELsYcfpx3V7mO1qjBeLBnZMaR/j2hYFVR8chF3Xs2c2AWP
xqw6zbg9rMm6kzwz95JR4rh0B422xN9EusIgF9JaVlrhxQrEQ/wzXgapFm61bXHu
I5xDxB+XgWQqHDdVhYzc0FUSTgMrKy3K5aytzB6kYKJ6lEiW3q9tY7uze+Aouuuh
nm002EuoMFUlfmHg9RhFhl0rW3cDoIUksU3Qeg2BlQ==
=ibAm
-----END PGP SIGNATURE-----

--SadpAjIKl05LKXC/--

