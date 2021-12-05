Date: Sun, 5 Dec 2021 18:40:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Yaz5gxzcCSAgQhlV@...1296...>
References: <20211201180727.2496903-1-arne@...1227...>
 <20211201180727.2496903-5-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XY7pyDjgpAImlQ3s"
Content-Disposition: inline
In-Reply-To: <20211201180727.2496903-5-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 5/9] Remove key_type->cipher_length field
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

--XY7pyDjgpAImlQ3s
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 01, 2021 at 07:07:23PM +0100, Arne Schwabe wrote:
> This field is only set once to cipher_kt_key_size(kt.cipher) at the same
> time that kt.cipher is set and therefore completely redundant.
[..]
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -744,8 +744,6 @@ init_key_type(struct key_type *kt, const char *cipher=
name,
>              msg(M_FATAL, "Cipher %s not supported", ciphername);
>          }
>=20=20
> -        kt->cipher_length =3D cipher_kt_key_size(kt->cipher);
> -
>          /* check legal cipher mode */
>          aead_cipher =3D cipher_kt_mode_aead(kt->cipher);
>          if (!(cipher_kt_mode_cbc(kt->cipher)
> @@ -811,21 +809,20 @@ init_key_ctx(struct key_ctx *ctx, const struct key =
*key,
[..]
>          const char *ciphername =3D cipher_kt_name(kt->cipher);
>          msg(D_HANDSHAKE, "%s: Cipher '%s' initialized with %d bit key",
>              prefix,
>              ciphername,
> -            kt->cipher_length *8);
> +            cipher_kt_key_size(kt->cipher));

This does not look right.  Shouldn't it be "cipher_kt_key_size() * 8", then?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--XY7pyDjgpAImlQ3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhrPmDAAoJEB2Cnv7KVigStXcL/321LU0an82PEx+oI4En8+PP
kbrtPgr+bY0EYXL/UEv3+2Z8IB+nGgxOYdtdlD4IQGDos2fiPoppIVmOjLySZl28
YmahvQhsM0/FcJgG7/2nVeab2vlvAV4b0oSD42KIZDLbJYjeXRv3DXhe2Cjp1Fq/
C3OPJxkqEDgjJlM9LvQR9wVhQiedihI53QPSZJNN7sRXZ1JEtCDGu5NJxC48eF6B
NA/+ZU49fMToSoL7JhsgHTHQyXZdrV2w9dIGNR1dd6aSerKRfPI/P8h1uzWk/T2u
5OLsFyBjZIj1X6RUsu04qUSBpgLnyt4zu7JGEukwWic78w7udnwqs6y71h5cc5BU
EWlutlQf1947WkkxR5wQ1n/aYFr3aShyZ4mN/tK+lAx/B9JnxmexZ25IjV/B3gND
bESOPMR91kKQc+w+VeQQzWvpLYCqOt5hkzbPtYUy2LSmJ06yTiZhzlm0mo1nXMtl
w5BYX7/5OEenR3qIcoasTeIz4ma2fTtkBX+JefAEPQ==
=Q2OC
-----END PGP SIGNATURE-----

--XY7pyDjgpAImlQ3s--

