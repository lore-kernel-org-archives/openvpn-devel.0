Date: Thu, 9 Dec 2021 14:40:41 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YbIHWW8+ZWGI0W6s@...1296...>
References: <20211201180727.2496903-1-arne@...1227...>
 <20211207180645.3281514-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mduSSFaAYKsP3yzj"
Content-Disposition: inline
In-Reply-To: <20211207180645.3281514-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 7/9] Remove cipher_kt_t and change
 type to const char* in API
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

--mduSSFaAYKsP3yzj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 07, 2021 at 07:06:45PM +0100, Arne Schwabe wrote:
> Patch v2: rebase on master

v2 includes a new check for AES-256-CTR (diffing v1 and v2 has the=20
"token++" change, plus this extra check), which breaks (at least)
tls_crypt_testdriver when compiled with mbedtls

(./configure --with-crypto-library=3Dmbedtls --enable-small)

OpenVPN 2.6_git [git:vw/master/4b17545838f05e9c] x86_64-pc-linux-gnu [SSL (=
mbed TLS)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on Dec  9 2021
library versions: mbed TLS 2.27.0, LZO 2.10

[ RUN      ] tls_crypt_v2_wrap_unwrap_no_metadata
ERROR: --tls-crypt requires AES-256-CTR support.
Could not run test: Test failed with exception: Segmentation fault(11)Test =
setup failed
[  ERROR   ] tls_crypt_v2_wrap_unwrap_no_metadata
[ RUN      ] tls_crypt_v2_wrap_unwrap_max_metadata
ERROR: --tls-crypt requires AES-256-CTR support.
Could not run test: Test failed with exception: Segmentation fault(11)Test =
setup failed
[  ERROR   ] tls_crypt_v2_wrap_unwrap_max_metadata
[ RUN      ] tls_crypt_v2_wrap_too_long_metadata
ERROR: --tls-crypt requires AES-256-CTR support.
Could not run test: Test failed with exception: Segmentation fault(11)Test =
setup failed
[  ERROR   ] tls_crypt_v2_wrap_too_long_metadata

... and also the self check

Testing tls-crypt-v2 key generation (no metadata)... FAILED
2021-12-09 14:31:01 ERROR: --tls-crypt requires AES-256-CTR support.
2021-12-09 14:31:01 ERROR: --tls-crypt-v2 not supported
2021-12-09 14:31:01 Exiting due to fatal error
Testing tls-crypt-v2 key generation (max length metadata)... FAILED
2021-12-09 14:31:02 ERROR: --tls-crypt requires AES-256-CTR support.
2021-12-09 14:31:02 ERROR: --tls-crypt-v2 not supported
2021-12-09 14:31:02 Exiting due to fatal error
FAIL: t_lpback.sh

The t_client tests fail as well...

2021-12-09 14:33:35 OPTIONS IMPORT: data channel crypto options modified
2021-12-09 14:33:35 Data Channel: using negotiated cipher 'AES-256-GCM'
2021-12-09 14:33:35 cipher_ctx_init:573: CIPHER - Bad input parameters
2021-12-09 14:33:35 mbed TLS cipher set key
2021-12-09 14:33:35 Exiting due to fatal error


TBH, I'm not sure if 7/9 v1 works with mbedtls, haven't tested it - but
still, can't ACK this as it is.


A warning points me to this one...

crypto_mbedtls.c: In function 'cipher_ctx_init':
crypto_mbedtls.c:564:38: warning: passing argument 1 of 'cipher_kt_key_size=
' from incompatible pointer type [-Wincompatible-pointer-types]
  564 |     int key_len =3D cipher_kt_key_size(kt);
      |                                      ^~
      |                                      |
      |                                      const mbedtls_cipher_info_t * =
{aka const struct mbedtls_cipher_info_t *}
crypto_mbedtls.c:440:32: note: expected 'const char *' but argument is of t=
ype 'const mbedtls_cipher_info_t *' {aka 'const struct mbedtls_cipher_info_=
t *'}
  440 | cipher_kt_key_size(const char *ciphername)
      |                    ~~~~~~~~~~~~^~~~~~~~~~

... which smells plausible.  Rebase accident?



Building with OpenSSL 1.1.1 fails the test driver in the same way.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--mduSSFaAYKsP3yzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhsgdZAAoJEB2Cnv7KVigSRJYMAIx+Le1HVe/9tQrYdyHdRLlf
rH0m3etYlAlSzmFg62dvPux8LeyKpgr7tF/FYRM6Cgfm0oCZbqll7fz3gpO5aMTk
vv4V8ULDt4Yy/v6rQH4hLZcTXyc2ZiAJEKWXNL5K5J1UjH9vPulty0WpmEs0kTL3
zIialCHGLYpjuNtRkiwsxgKVdDSGDi7vokdh9O0F+15vJ0a7YYoqjFabrYVa0ESS
BI5fCxaY1QNbkZvO0uOTZjUWcvAxLP4XhPXwnUEGKjeZ8tPfsBXzx54aJkXzqXR4
33mhIR2JZGyxl2hb4nZkwSb2MJl971ewVSP8E6i35oh7c1FnK1OuPFKYY/up7xhm
goOvR9jtIkldm8bNv8+aZBtmcG+UdIkK8Qi642JlpH4NFfMBdf3J6hxoyEOXcOcI
YSuQBAiS9fpXtzoUJFylZI7bCCKetBBT1z1CEhgTXGLh0JjoFEp9hwMMP+NSq04T
b/5CRhghjBUsVbsK+hlHpYz41rgUkb9GGmkCkGTn5w==
=0T4P
-----END PGP SIGNATURE-----

--mduSSFaAYKsP3yzj--

