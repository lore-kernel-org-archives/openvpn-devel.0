Date: Wed, 25 Dec 2024 17:21:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Z2wxD-t_CZ2uR5K9@...1296...>
References: <7e42399c-3a94-40a2-bcaa-15545c3b761c@...68...>
 <6a00da72-dc11-409e-9d47-4694e1d6f02f@...68...>
 <a986633d-69d7-4bd1-b288-2f0de53b106e@...2181...>
 <b16cab79-188f-41a3-af32-f944a387400f@...68...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XvWdRhhUtZ8AkslF"
Content-Disposition: inline
In-Reply-To: <b16cab79-188f-41a3-af32-f944a387400f@...68...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] port-share: Normalize
 IPv4-mapped IPv6 addresses
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: corubba <corubba@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--XvWdRhhUtZ8AkslF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 16, 2024 at 01:22:38PM +0100, corubba via Openvpn-devel wrote:
> Before passing IPv4-mapped IPv6 addresses to the proxy journal,
> translate them to plain IPv4 addresses. Whether the connection was
> accepted by OpenVPN on a "dual stack" socket is of no importance to the
> proxy receiver.
>=20
> Signed-off-by: Corubba Smith <corubba@...68...>

I'm fine with the idea, but I do not like the implementation with=20
"yet another localized sockaddr manipulation function" - we already
have similar code in socket.c/setenv_sockaddr(), so maybe we need
to make this a more general thing.

print_openvpn_sockaddr() is just a wrapper around print_sockaddr_ex(),
which takes flags.  So we could introduce something like a PS_NO_V4MAPPED
(naming is hard :-) ) which would then do "this" inside print_sockaddr_ex().

It's not fully straightforward, though (it operates on a pointer passed
to it, so we'd need to have a local sockaddr_in for "unmapped v4" then).

Mmmmh, need to think more about this.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--XvWdRhhUtZ8AkslF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnbDEPAAoJEB2Cnv7KVigS9O8L/34aFozRHyQHVbzfcJJSKG40
3x/HFjpsF4q/HVGgF/2SXA9cr1G4D8rUlDno2jjmQ/P0LzsGbPmydoub2qk/OiQr
Bp39MPmKfCX+kL08lFV9DoRe4adwaTngsTDeeyfCXDXJv6ecBCODKWdRs2ITr8XP
dwaQL2Hdn+BZaB1FKjOOr/69IxD863eQ6izbFFdJLRHuOf7W+Cfp4GWtqKfch2Eb
TbZIRfQW1ms55Rdgz9RbsiSi2vta3V+VfOGdzELD9Td5blFXSU2N2kFKsCW4xAcL
Gy6U1G7hPAayoE4DRRYt2X5u0SqP86MAtKs73JKaevEH0bXDQ3OKaaNRXGmXtFo6
QkmJuDk/nhuZ+vV0VOT5mG+VSbX6Eckl4foR3VmF2EDLaJgc7cThHFFQyhw16YHA
h0hICl79RzRs9SHpkIGj1p6/7eN/QdViFA4pcTR0LEnvLcVu8Kvqsqm4FeYrmV+z
ESmQ+6Sl2sfoUjKrtRJIH/z8Pic6cH/NodkIei6/IQ==
=FvUb
-----END PGP SIGNATURE-----

--XvWdRhhUtZ8AkslF--

