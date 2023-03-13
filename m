Date: Mon, 13 Mar 2023 19:14:50 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZA9oGlHSstJIR+05@...1296...>
References: <20230313134233.60335-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="RAUnW5Xnt9yRbOq7"
Content-Disposition: inline
In-Reply-To: <20230313134233.60335-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix memory leaks in HMAC initial
 packet id and dco open tun
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

--RAUnW5Xnt9yRbOq7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 13, 2023 at 02:42:33PM +0100, Arne Schwabe wrote:
> The open_tun_dco_generic already allocates the actual_name string, this
> shadows the allocation in the FreeBSD/Linux specific methods.
>=20
> The HMAC leaks are just forgotten frees/deinitialisations.
>=20
> Found-By: clang with asan
>=20
> Patch v2: rebase. Include linux bits accidentially forgotten.
>=20
> Change-Id: I3c344af047abe94c0178bde1781eb450f10d157d
> Signed-off-by: Arne Schwabe <arne@...1227...>

NAK, though I'm not sure I really understand why.

The free_buf() call fails on a server instance with --tls-crypt +=20
--tls-crypt-v2, because "buf" is modified by tls_wrap_control() in
this case.

Sprinkled-in msg() calls show that "buf.data" points elsewhere=20
after the call, and then free_buf() fails

2023-03-13 19:13:18 us=3D537725 Initialization Sequence Completed
2023-03-13 19:13:20 us=3D782049 GERT: in tls_reset_standalone, &buf=3D0x7ff=
ca7010ef0, buf.data=3D0x562bd5669370
2023-03-13 19:13:20 us=3D782103 GERT: tls_reset_standalone before tls_wrap_=
control(), &buf=3D0x7ffca7010ef0, buf.data=3D0x562bd5669370
2023-03-13 19:13:20 us=3D782123 GERT: at end of tls_reset_standalone, &buf=
=3D0x7ffca7010ef0, buf.data=3D0x562bd565dcc8
2023-03-13 19:13:20 us=3D782140 GERT: in send_hmac_reset_packet, &buf=3D0x7=
ffca7010f60, buf.data=3D0x562bd565dcc8
free(): invalid pointer
Aborted


The tt->actual changes are fine, and the tls_auth_standalone change=20
also looks good (if complicated to grok).

This code here is fine for "naked" and "tls-auth".

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--RAUnW5Xnt9yRbOq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkD2gaAAoJEB2Cnv7KVigSd/UL/2FXzyO8oqHLdJRqvtil683s
Y+yCyBcnlNcLj45pt03vmptJM3z/5bT0dRejEObMfHUpb4wVJKHR2ftL05D+SZSO
KQ1vfEw9GB31ZIc1pTan+KN9Ny4KRIfM7PePS1xuHmCKkhvSo3GUEWqG/uqC6Wtx
FxrML/rE2xl0zd1HyXpm/iFruvAAOMl6b2V/i9P/DCLMACv1PHIhzPpWsPiX6czK
jE8nmdzItIqhsLAakqtoqLiMlVQSIJuOMgaMnPH5/L2pqHF96RfId7iXBeegDw33
GKZ/Na+ln1+fBU20qyjKVQsXloNpjwV7A5DvqIRhnB7yvFESg8OKcmz1ORCaBsOY
7Vd/Qr/er4r0ghN5gsu7nY/t08yPf2ZvrHU9PlLsfGbpUtrVV+4TePU1QRr1GBCh
zEMesOjc9uy7RZCAFAJXbDHH7ifE4rLdDvxncLaal7M0Yj9e5tjnmrJyi0SU69qQ
G3TAD4cAY1n5iq/sUEpRVHhEjXJwg+EERmdUjYDvCA==
=VdMH
-----END PGP SIGNATURE-----

--RAUnW5Xnt9yRbOq7--

