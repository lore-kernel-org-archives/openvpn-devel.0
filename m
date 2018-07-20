References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <20180704175404.22371-1-steffan@...1856...>
 <20180704175404.22371-3-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <8eebd206-6742-712d-2097-ee196bbb025c@...2181...>
Date: Fri, 20 Jul 2018 19:20:35 +0800
MIME-Version: 1.0
In-Reply-To: <20180704175404.22371-3-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="N45HUj1FEhRdcrcXOjSd5Tdsx0yMJ1FKr"
Subject: Re: [Openvpn-devel] [PATCH v2 3/9] Add crypto_pem_{encode, decode}()
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
--N45HUj1FEhRdcrcXOjSd5Tdsx0yMJ1FKr
Content-Type: multipart/mixed; boundary="cUBo8cjYqZb4utZl1sLPsKBtXXyYOuX1z";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <8eebd206-6742-712d-2097-ee196bbb025c@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/9] Add crypto_pem_{encode,decode}()
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <20180704175404.22371-1-steffan@...1856...>
 <20180704175404.22371-3-steffan@...1856...>
In-Reply-To: <20180704175404.22371-3-steffan@...1856...>

--cUBo8cjYqZb4utZl1sLPsKBtXXyYOuX1z
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/07/18 01:53, Steffan Karger wrote:
[CUT]

> +bool
> +crypto_pem_decode(const char *name, struct buffer *dst,
> +                  const struct buffer *src)
> +{
> +    bool ret =3D false;
> +    BIO *bio;
> +
> +    if (!(bio =3D BIO_new_mem_buf((char *)BPTR(src), BLEN(src))))

minor style niptick: I think it's common habit to have the assignment on
one line and the if-condition on the next one, especially when it's
about functions allocating some kind of object. Check your own
crypto_pem_encode() in this patch :-)

For the sake of consistency, I think this should be split in two lines:

BIO *bio =3D BIO_new_mem_buf((char *)BPTR(src), BLEN(src));
if (!bio)

> +    {
> +        crypto_msg(M_FATAL, "Cannot open memory BIO for PEM decode");
> +    }
> +
> +    char *name_read =3D NULL;
> +    char *header_read =3D NULL;
> +    uint8_t *data_read =3D NULL;
> +    long data_read_len =3D 0;
> +    if (!PEM_read_bio(bio, &name_read, &header_read, &data_read,
> +                      &data_read_len))
> +    {
> +        dmsg(D_CRYPT_ERRORS, "%s: PEM decode failed", __func__);
> +        goto cleanup;
> +    }
> +
> +    if (strcmp(name, name_read))
> +    {
> +        dmsg(D_CRYPT_ERRORS,
> +             "%s: unexpected PEM name (got '%s', expected '%s')",
> +             __func__, name_read, name);
> +        goto cleanup;
> +    }
> +
> +    uint8_t *dst_data =3D buf_write_alloc(dst, data_read_len);
> +    if (!dst_data)
> +    {
> +        dmsg(D_CRYPT_ERRORS, "%s: dst too small (%i, needs %li)", __func=
__,
> +             BCAP(dst), data_read_len);
> +        goto cleanup;

Am I wrong or we are leaking dst_data in case of failure? or are we
assuming that this memory is now owned by dst and therefore its owner
(the caller) will take care of this?

> +    }
> +    memcpy(dst_data, data_read, data_read_len);
> +
> +    ret =3D true;
> +cleanup:> +    OPENSSL_free(name_read);
> +    OPENSSL_free(header_read);
> +    OPENSSL_free(data_read);
> +    if (!BIO_free(bio))
> +    {
> +        ret =3D false;;
> +    }
> +
> +    return ret;
> +}
> +

[CUT]

Other than those small remarks the patch looks good.
Therefore:

Acked-by: Antonio Quartulli <antonio@...515...>

This code does not do anything yet, as these functions are not used at
the moment (will be in one of the next patches), but they are tested
thanks to the new unit_test and everything seems to be working as expected.


Cheers,


--=20
Antonio Quartulli


--cUBo8cjYqZb4utZl1sLPsKBtXXyYOuX1z--

--N45HUj1FEhRdcrcXOjSd5Tdsx0yMJ1FKr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltRxYMACgkQB6U8WA7y
zXR6tA//Z9rr/ZZkJjtHVxTUBmbqwuRMXuuyXkTOk7CCyMvgpCFTmojhpxiCtsjQ
deIKQVtvAWPDFXBusd5N7A/ABzEAZuOdJviJe/KH0DeS+fEaUzhAfaogN4iyLC9T
yaQIX+pXoQBO9XN/9YqEU1irI9uH53lbO5zFTeNJgBWyVpQjLPbEtPVZazA02stK
3pWBzwiwbCOO3ceLx3Dt7wrFhPT1Jtr/OEUKkJyFaj2yXNO7PCUn3024cXT+EMtB
1GPyW0FlGDpKhu9QYf/AiZ0jpI3NlPPf+09rrl2cNJnFn45QfIp3qopISPQKjbVu
T5cUccUv43DJkB4ZZrgmytvrPNBQu7ZYmBkZaYFUNTyqkQXI5OzkFWXwTkY0VqQS
UMt1isEemZpeRJEwvHDWeUzDyzug8tYcTOeOhv2FOPnj0HEustwsgKAqoPi0NhL0
7UXOeqkHFaXL3ZeCgYtL+4rt9HIqAU4zhDFz7Y+a7jdxhNZMPS0BFk3aD7/YFCRo
QkR3FkMVV3wwJHmTdoSBmjxmbXS4uliTzInMKNRWuwTkoI83MeH5ewxbUWRodZrp
6q1m02Xat3BTKQ5IFH+dwhofDkD3Ji4xHmNlHkgEbm10yJi/HX1n6kyw7TqIecxZ
pmlt/+I/MoPOK6UCGuiL/7hqP9FlmMZCgbv52t2fzLe0lw3Ulz0=
=1E59
-----END PGP SIGNATURE-----

--N45HUj1FEhRdcrcXOjSd5Tdsx0yMJ1FKr--

