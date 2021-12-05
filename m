Date: Sun, 5 Dec 2021 18:33:03 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Yaz3zz8acJfit0iJ@...1296...>
References: <20211201180727.2496903-1-arne@...1227...>
 <20211201180727.2496903-3-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3ZqO8FxgdN56OIFb"
Content-Disposition: inline
In-Reply-To: <20211201180727.2496903-3-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 3/9] Remove cipher_ctx_get_cipher_kt and
 replace with direct context calls
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

--3ZqO8FxgdN56OIFb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 01, 2021 at 07:07:21PM +0100, Arne Schwabe wrote:
> We currently have a number of calls that fetch the cipher_kt from a
> cipher_ctx to then do a query on the cipher_kt. Directly fetching the
> desired property from the context is cleaner and helps for using the
> proper APIs with OpenSSL 3.0 and mbed TLS 3.0

Generally speaking this seems reasonable, I just wonder about
two things:

> @@ -68,12 +68,10 @@ openvpn_encrypt_aead(struct buffer *buf, struct buffe=
r work,
>      int outlen =3D 0;
>      const struct key_ctx *ctx =3D &opt->key_ctx_bi.encrypt;
>      uint8_t *mac_out =3D NULL;
> -    const cipher_kt_t *cipher_kt =3D cipher_ctx_get_cipher_kt(ctx->ciphe=
r);
>      const int mac_len =3D OPENVPN_AEAD_TAG_LENGTH;
>=20=20
>      /* IV, packet-ID and implicit IV required for this mode. */
>      ASSERT(ctx->cipher);
> -    ASSERT(cipher_kt_mode_aead(cipher_kt));
>      ASSERT(packet_id_initialized(&opt->packet_id));

This ASSERT goes away now.  It's there to ensure that "yeah, we're
really using an AEAD ciphere here" - which should, of course, never
trigger, but I assume Steffan had some reason to put it here.

> @@ -371,7 +364,6 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffe=
r work,
>      ASSERT(frame);
>      ASSERT(buf->len > 0);
>      ASSERT(ctx->cipher);
> -    ASSERT(cipher_kt_mode_aead(cipher_kt));

Same thing here.

So - can we be "crypto level" secure that this is never needed?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--3ZqO8FxgdN56OIFb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhrPfPAAoJEB2Cnv7KVigS3j8MAKjQ1tzwSR8Lx0/k797nGve8
0U5CR17P7Le642oND0/qSKV2yB+uccmYYpx/SIsBorlLle7JpogG6zLptIREXjVy
Sdy2Al8P1SpnNWZdLXqdjZ1PFud3w/b82JbAxqSFQWYfT/VT4oVOXNRtKtMCh9mY
z1vqhlgo939hFXXxkjlIaadW7fnYRwbgRnUtxYGN6xMktz95b0ADCobTkc9OfuAw
Dl2ZBKlIOqN+hihwTQUEf8ZrQZaxwLdNM6GABwbVE+h1OHhkFCbpoRQ0cT8BWeM5
iokSw57F6av2uMkhNnOlMnfhsCZgUHw/oQrx1IXgiRHlD9uOCVRnhmzF0+FXd9S5
bCEZuY1wnR5x132fa0IwwP2CtubtBVCYyMN5f2Bg/XLTjy4BuMaKr06W/jXPv2Ep
/CfDnuPfw5QUdcKpL+GF9vzCxt+mX4AHtG5DnGPv8n5bNVIqeR543Bfuiczh++Q5
fHo/ipQp1eBRgQQW+eJrPUsawer+qo0BGwBfyPG3wg==
=7uSe
-----END PGP SIGNATURE-----

--3ZqO8FxgdN56OIFb--

