References: <9b927c56-b850-b019-2385-2e9e199389b0@...2181...>
 <20181009204315.8262-1-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e89bca57-ea33-8fb6-6772-23b3a1e41540@...2181...>
Date: Wed, 10 Oct 2018 17:50:51 +0800
MIME-Version: 1.0
In-Reply-To: <20181009204315.8262-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p95NAH0sqixMSHWLT2XrXIqkbwbzHojd4"
Subject: Re: [Openvpn-devel] [PATCH v3 2/2] List ChaCha20-Poly1305 as stream
 cipher
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p95NAH0sqixMSHWLT2XrXIqkbwbzHojd4
Content-Type: multipart/mixed; boundary="M8VgdlUxDePCdLfkwfLkGUEJDxhYFGvCU";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <e89bca57-ea33-8fb6-6772-23b3a1e41540@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/2] List ChaCha20-Poly1305 as stream
 cipher
References: <9b927c56-b850-b019-2385-2e9e199389b0@...2181...>
 <20181009204315.8262-1-steffan@...1856...>
In-Reply-To: <20181009204315.8262-1-steffan@...1856...>

--M8VgdlUxDePCdLfkwfLkGUEJDxhYFGvCU
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 10/10/18 04:43, Steffan Karger wrote:
> As Antonio pointed out, "8-bit block cipher" is a bit funny. So teach
> print_cipher() to print such cipher as "stream cipher".
>=20
> Because I didn't want to write the same code twice, I decided to merge the
> two print_cipher() implementations into one shared function. That should
> make it easier to keep both backends consistent.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>

Does what it says. Simple and plain. No warning anymore.
And now we have a more meaningful text ;)

Acked-by: Antonio Quartulli <a@...2181...>




--=20
Antonio Quartulli


--M8VgdlUxDePCdLfkwfLkGUEJDxhYFGvCU--

--p95NAH0sqixMSHWLT2XrXIqkbwbzHojd4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlu9y3sACgkQ9FVsWUWD
Dm2lUw/+NM7aM2wXbTgN1nscK3Dwo9RQ/3Ly2i0jgmLo297Sad3B3yPCou1Wuebb
apFqwcy9A6lxsHRStIoHFE98/Z//QzItsRo0pKtvmU7g1V+jv56OVphCDbqohB3V
7HHgJ3Mg2Ib3fsq9RsSshGnt/bvK5jdyTosaAfVccDl/sGlzgShVtp+fIJITixTS
t8UaHLAlDK6QlLz0tY7mZYXMQ2p/pGg3djwFymSBGF9jjPq7cyJOripWkjehtXQJ
tVe/FafFDmSk5svowvhI+lZvPj4EjxTMFTOhxq9ceNFAVqr+bDWvNDFKIrQKY1ex
XACJCbe5fXBz8Vqs3DxAlwAHvaCJ6mKWQdLu9GtNcVwxjV9yoUcCOWylz0y8PdMm
M8tjOmSncZdadp6EK7U1mU5cxy6qytrXZh3QewhnnhR2d7Qpb0chIs7KmMJDM4lU
sZr+mvZncU3p5NG33KElX68NYtH3FKau6ALPAtCHuqMnerMr3mAN/+jEZntoi0Qk
N+fSeoS9egu4WaSlqJSfApwXi5zOjLhH87S7RN/3HfYAsUyGpL50vhIM8Ma9Qyrf
rzdnHDIR6bT9HUtfL6LZlQX6nnZO9OgSz0ISDIikDBuSMO9B0BaaadziUN2uB30/
qkWPRSdqWWJlO/H7Q/seck2J+FQT+k8vxiCzFgUfFLlRYiiixXQ=
=x23O
-----END PGP SIGNATURE-----

--p95NAH0sqixMSHWLT2XrXIqkbwbzHojd4--

