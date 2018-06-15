References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1512734870-17133-2-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d29d8651-7ed9-9b65-97b2-dcad579d70e2@...2181...>
Date: Fri, 15 Jun 2018 15:03:49 +0800
MIME-Version: 1.0
In-Reply-To: <1512734870-17133-2-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xMsUPapUxaZoDJrp06aPQO9qWzxKwCFcX"
Subject: Re: [Openvpn-devel] [PATCH 01/10] Add crypto_pem_{encode,decode}()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xMsUPapUxaZoDJrp06aPQO9qWzxKwCFcX
Content-Type: multipart/mixed; boundary="k9xDF5erlCgLXzZvqAUnMuYAA4sN9jU4K";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d29d8651-7ed9-9b65-97b2-dcad579d70e2@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 01/10] Add crypto_pem_{encode,decode}()
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1512734870-17133-2-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1512734870-17133-2-git-send-email-steffan.karger@...1435...>

--k9xDF5erlCgLXzZvqAUnMuYAA4sN9jU4K
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Steffan,

On 08/12/17 20:07, Steffan Karger wrote:
> Needed for tls-crypt-v2, but isolated enough to be reviewed as a separate
> patch.
>=20
> The encode API allocates memory, because it fits our typical gc-oriented
> code pattern and the caller does not have to do multiple calls or
> calculations to determine the required destination buffer size.
>=20
> The decode API does not allocate memory, because the required destination
> buffer is always smaller than the input buffer (so is easy to manage by
> the caller) and does not force the caller to use the heap.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  src/openvpn/crypto_backend.h           | 30 +++++++++++
>  src/openvpn/crypto_mbedtls.c           | 74 +++++++++++++++++++++++++++
>  src/openvpn/crypto_openssl.c           | 82 ++++++++++++++++++++++++++++=
++
>  tests/unit_tests/openvpn/Makefile.am   | 16 +++++-
>  tests/unit_tests/openvpn/test_crypto.c | 92 ++++++++++++++++++++++++++++=
++++++
>  5 files changed, 293 insertions(+), 1 deletion(-)
>  create mode 100644 tests/unit_tests/openvpn/test_crypto.c
>=20
> diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
> index 567fd9b..83e14c8 100644
> --- a/src/openvpn/crypto_backend.h
> +++ b/src/openvpn/crypto_backend.h
> @@ -36,6 +36,7 @@
>  #include "crypto_mbedtls.h"
>  #endif
>  #include "basic.h"
> +#include "buffer.h"
>=20=20
>  /* TLS uses a tag of 128 bytes, let's do the same for OpenVPN */
>  #define OPENVPN_AEAD_TAG_LENGTH 16
> @@ -105,6 +106,35 @@ void show_available_digests(void);
>=20=20
>  void show_available_engines(void);
>=20=20
> +/**
> + * Encode binary data as PEM
> + *
> + * @param name      The name to use in the PEM header/footer
> + * @param dst       Destination buffer for PEM-encoded data.  Must be a =
valid
> + *                  pointer to an uninitialized buffer structure.  Iff t=
his
> + *                  function returns true, the buffer will contain memory
> + *                  allocated through the supplied gc.

minor: I see the current style is inconsistent wrt having a '.' at the
end of each doxygen line. Maybe we should decide what to do and stick to
that ;P But does not need to be changed in this patch of course.

> + * @param src       Source buffer
> + * @param gc        The garbage collector to use when allocating memory =
for
> + *                  dst.
> + *
> + * @return true iff PEM encode succeeded.
> + */
> +bool crypto_pem_encode(const char *name, struct buffer *dst,
> +                       const struct buffer *src, struct gc_arena *gc);
> +
> +/**
> + * Decode a PEM buffer to binary data
> + *
> + * @param name      The name expected in the PEM header/footer
> + * @param dst       Destination buffer for decoded data
> + * @param src       Source buffer (PEM data)
> + *
> + * @return true iff PEM decode succeeded.
> + */
> +bool crypto_pem_decode(const char *name, struct buffer *dst,
> +                       const struct buffer *src);
> +
>  /*
>   *
>   * Random number functions, used in cases where we want
> diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
> index 8fa03da..1e86854 100644
> --- a/src/openvpn/crypto_mbedtls.c
> +++ b/src/openvpn/crypto_mbedtls.c
> @@ -44,11 +44,13 @@
>  #include "otime.h"
>  #include "misc.h"
>=20=20
> +#include <mbedtls/base64.h>
>  #include <mbedtls/des.h>
>  #include <mbedtls/error.h>
>  #include <mbedtls/md5.h>
>  #include <mbedtls/cipher.h>
>  #include <mbedtls/havege.h>
> +#include <mbedtls/pem.h>
>=20=20
>  #include <mbedtls/entropy.h>
>=20=20
> @@ -229,6 +231,78 @@ show_available_engines(void)
>             "available\n");
>  }
>=20=20
> +bool
> +crypto_pem_encode(const char *name, struct buffer *dst,
> +                  const struct buffer *src, struct gc_arena *gc)
> +{
> +    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
> +    char header[1000+1] =3D { 0 };
> +    char footer[1000+1] =3D { 0 };
> +
> +    if (!openvpn_snprintf(header, sizeof(header), "-----BEGIN %s-----\n"=
, name))
> +    {
> +        return false;
> +    }
> +    if (!openvpn_snprintf(footer, sizeof(footer), "-----END %s-----\n", =
name))
> +    {
> +        return false;
> +    }
> +
> +    size_t out_len =3D 0;
> +    if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL !=3D
> +            mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src=
),
> +                                     NULL, 0, &out_len))
> +    {
> +        return false;
> +    }
> +
> +    *dst =3D alloc_buf_gc(out_len, gc);
> +    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(src), BLE=
N(src),
> +                                          BPTR(dst), BCAP(dst), &out_len=
))
> +        || !buf_inc_len(dst, out_len))

Isn't in the spec of this function to keep the buffer uninitialized when
returning false?
Not a big deal because the buffer area was allocated via gc so it can't
be leaked.

Don't you think that if buf_inc_len() fails (can this really happen?)
the buffer should better be reset?

> +    {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +bool
> +crypto_pem_decode(const char *name, struct buffer *dst,
> +                  const struct buffer *src)
> +{
> +    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
> +    char header[1000+1] =3D { 0 };
> +    char footer[1000+1] =3D { 0 };
> +
> +    if (*(BLAST(src)) !=3D '\0')
> +    {
> +        msg(M_WARN, "PEM decode error: source buffer not null-terminated=
");
> +        return false;
> +    }
> +    if (!openvpn_snprintf(header, sizeof(header), "-----BEGIN %s-----", =
name))
> +    {
> +        return false;
> +    }
> +    if (!openvpn_snprintf(footer, sizeof(footer), "-----END %s-----", na=
me))
> +    {
> +        return false;
> +    }
> +
> +    size_t use_len =3D 0;
> +    mbedtls_pem_context ctx =3D { 0 };
> +    bool ret =3D mbed_ok(mbedtls_pem_read_buffer(&ctx, header, footer, B=
PTR(src),
> +                                               NULL, 0, &use_len));
> +    if (ret && !buf_write(dst, ctx.buf, ctx.buflen))
> +    {
> +        ret =3D false;
> +        msg(M_WARN, "PEM decode error: destination buffer too small");
> +    }
> +
> +    mbedtls_pem_free(&ctx);
> +    return ret;
> +}
> +
>  /*
>   *
>   * Random number functions, used in cases where we want
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 20a519e..49d3aeb 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -387,6 +387,88 @@ show_available_engines(void)
>  #endif
>  }
>=20=20
> +
> +bool
> +crypto_pem_encode(const char *name, struct buffer *dst,
> +                  const struct buffer *src, struct gc_arena *gc)
> +{
> +    bool ret =3D false;
> +    BIO *bio =3D BIO_new(BIO_s_mem());

can we assume bio is always initialized with non-NULL here?

> +    if (!PEM_write_bio(bio, name, "", BPTR(src), BLEN(src)))
> +    {
> +        ret =3D false;
> +        goto cleanup;
> +    }
> +
> +    BUF_MEM *bptr;
> +    BIO_get_mem_ptr(bio, &bptr);
> +
> +    *dst =3D alloc_buf_gc(bptr->length, gc);
> +    ASSERT(buf_write(dst, bptr->data, bptr->length));

why using an ASSERT() here and none in the mbedtls counterpart?

If there is no special reason I (personally) think that these helper
functions should not use ASSERT() (unless something really bad is
happening).
Or do you think that a failure here indicates a general memory problem?

> +
> +    ret =3D true;
> +cleanup:
> +    if (!BIO_free(bio))
> +    {
> +        ret =3D false;;
> +    }
> +
> +    return ret;
> +}
> +
> +bool
> +crypto_pem_decode(const char *name, struct buffer *dst,
> +                  const struct buffer *src)
> +{
> +    bool ret =3D false;
> +    BIO *bio;
> +
> +    if (!(bio =3D BIO_new_mem_buf((char *)BPTR(src), BLEN(src))))
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
> +    }
> +    memcpy(dst_data, data_read, data_read_len);
> +
> +    ret =3D true;
> +cleanup:
> +    OPENSSL_free(name_read);
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
>  /*
>   *
>   * Random number functions, used in cases where we want
> diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/open=
vpn/Makefile.am
> index 23d758b..d100c21 100644
> --- a/tests/unit_tests/openvpn/Makefile.am
> +++ b/tests/unit_tests/openvpn/Makefile.am
> @@ -6,7 +6,7 @@ if HAVE_LD_WRAP_SUPPORT
>  check_PROGRAMS +=3D argv_testdriver buffer_testdriver
>  endif
>=20=20
> -check_PROGRAMS +=3D packet_id_testdriver tls_crypt_testdriver
> +check_PROGRAMS +=3D crypto_testdriver packet_id_testdriver tls_crypt_tes=
tdriver
>=20=20
>  TESTS =3D $(check_PROGRAMS)
>=20=20
> @@ -29,6 +29,20 @@ buffer_testdriver_SOURCES =3D test_buffer.c mock_msg.c=
 \
>  	$(openvpn_srcdir)/buffer.c \
>  	$(openvpn_srcdir)/platform.c
>=20=20
> +crypto_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
> +	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
> +	$(OPTIONAL_CRYPTO_CFLAGS)
> +crypto_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \
> +	$(OPTIONAL_CRYPTO_LIBS)
> +crypto_testdriver_SOURCES =3D test_crypto.c mock_msg.c \
> +	$(openvpn_srcdir)/buffer.c \
> +	$(openvpn_srcdir)/crypto.c \
> +	$(openvpn_srcdir)/crypto_mbedtls.c \
> +	$(openvpn_srcdir)/crypto_openssl.c \
> +	$(openvpn_srcdir)/otime.c \
> +	$(openvpn_srcdir)/packet_id.c \
> +	$(openvpn_srcdir)/platform.c
> +
>  packet_id_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
>  	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
>  	$(OPTIONAL_CRYPTO_CFLAGS)
> diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/op=
envpn/test_crypto.c
> new file mode 100644
> index 0000000..62d5b3f
> --- /dev/null
> +++ b/tests/unit_tests/openvpn/test_crypto.c
> @@ -0,0 +1,92 @@
> +/*
> + *  OpenVPN -- An application to securely tunnel IP networks
> + *             over a single UDP port, with support for SSL/TLS-based
> + *             session authentication and key exchange,
> + *             packet encryption, packet authentication, and
> + *             packet compression.
> + *
> + *  Copyright (C) 2016-2017 Fox Crypto B.V. <openvpn@...1435...>
> + *

this should be updated, time flies :)

> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License al=
ong
> + *  with this program; if not, write to the Free Software Foundation, In=
c.,
> + *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include "config.h"
> +#elif defined(_MSC_VER)
> +#include "config-msvc.h"
> +#endif
> +
> +#include "syshead.h"
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdarg.h>
> +#include <string.h>
> +#include <setjmp.h>
> +#include <cmocka.h>
> +
> +#include "crypto.h"
> +
> +#include "mock_msg.h"
> +
> +int script_security =3D 0; /* Avoid including misc.c */

I tried commenting it and I don't see any warning. Which include chain
should lead to its declaration?

> +
> +static const char testtext[] =3D "Dummy text to test PEM encoding";
> +
> +/**
> + * Check that packet replays are accepted when CO_IGNORE_PACKET_ID is se=
t. This
> + * is used for the first control channel packet that arrives, because we=
 don't
> + * know the packet ID yet.
> + */

Is the comment above a copy/paste incident? or there is something hidden
in this unit test?

> +static void
> +crypto_pem_encode_decode_loopback(void **state) {
> +    struct gc_arena gc =3D gc_new();
> +    struct buffer src_buf;
> +    buf_set_read(&src_buf, (void *)testtext, sizeof(testtext));
> +
> +    uint8_t dec[sizeof(testtext)];
> +    struct buffer dec_buf;
> +    buf_set_write(&dec_buf, dec, sizeof(dec));
> +
> +    struct buffer pem_buf;
> +
> +    assert_true(crypto_pem_encode("TESTKEYNAME", &pem_buf, &src_buf, &gc=
));
> +
> +    /* Wrong key name */
> +    assert_false(crypto_pem_decode("WRONGNAME", &dec_buf, &pem_buf));
> +
> +    assert_true(crypto_pem_decode("TESTKEYNAME", &dec_buf, &pem_buf));
> +

As a final check, wouldn't it be meaningful to compare the content of
dec_buf with src_buf to ensure that we properly obtained the original
char array?

Another question: do we have any way to verify that pem_buf contains
well-formatted PEM data after pem_encode()?
I am asking because if both encode and decode become no-op (because of
some bug) we won't be able to realize that.

However, I am not sure we have an easy way to check that..maybe you
could use some SSL function that would normally load PEM data?


> +    gc_free(&gc);
> +}
> +
> +int
> +main(void) {
> +    const struct CMUnitTest tests[] =3D {
> +        cmocka_unit_test(crypto_pem_encode_decode_loopback),
> +    };
> +
> +#if defined(ENABLE_CRYPTO_OPENSSL)
> +    OpenSSL_add_all_algorithms();
> +#endif
> +
> +    int ret =3D cmocka_run_group_tests_name("crypto tests", tests, NULL,=
 NULL);
> +
> +#if defined(ENABLE_CRYPTO_OPENSSL)
> +    EVP_cleanup();
> +#endif
> +
> +    return ret;
> +}
>=20


Cheers,

--=20
Antonio Quartulli


--k9xDF5erlCgLXzZvqAUnMuYAA4sN9jU4K--

--xMsUPapUxaZoDJrp06aPQO9qWzxKwCFcX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsjZNYACgkQB6U8WA7y
zXS+pw/+M66lx1wJY/5leOBh/O4m0EDJjvSQB0SQxNG4Q8o4vWk8BxiEZ+Wo7rSK
AaKbr/d/YdBVsDaG5PHzWP0f/X4rW1dOd0bHt4/tafZZwmD89TBbrnfyJXLDKIk0
rCGKr836S0AFUzEAqU1cJWMPC3yza/IUEdYVn4/s2D0UUc0CirMUL/4GkQsxIc9s
5UBoKRlipvprkAHB26JFukB1sRJ9UM9TavkJ/Fo5x5ofCJ3VZsBzLMeJW6n7rZ9o
VRJxMyGYt9zRjQ/ijHbTG2KhZgrdpaj6yBtx9FzfWKFhS6DwPBTk1TzywMAuQwx6
twnwAeILa26MMY2da6ORiRHajyqbuEFuFAC16hpCL93eOw07necH1IEVAlGkPOw7
BGRAoBo/6pOMDWN5D1Mqg0qfOEN2WsdB8AfDFZv4+1EfuYue6xnNeACFoCPLtwvK
ANLMa/D0pdSSAgbyIgzDfc3OiFYbMI7IZUx2OquJ3O2vxDnjylqEJ6nIss5vC85b
n9NDakwcezuUdQiS+FwSguRAC9cZjxfUis6Oirng+JlFzIzt7R7sPPqbXZF4ZhIm
BQCFEN92zif4LbU+yOTS5YgXl1XYvp9PBqR+ss8JyhutsFWoHlpvt8JxBTTBAERh
nfLViwJ489/mn8aXofv4QThCxBogg2wLB+G4eVbnxr12yQwOpAM=
=MZ++
-----END PGP SIGNATURE-----

--xMsUPapUxaZoDJrp06aPQO9qWzxKwCFcX--

