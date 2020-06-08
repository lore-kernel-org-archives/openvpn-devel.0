References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-3-James.Bottomley@...2316...>
 <20200607111138.GA50189@...1296...>
 <1591567858.4011.15.camel@...2316...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <fa1ee755-c255-5985-7104-578e62f96e0a@...1227...>
Date: Mon, 8 Jun 2020 12:05:24 +0200
MIME-Version: 1.0
In-Reply-To: <1591567858.4011.15.camel@...2316...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XVdJGSfFBNRxhj0dSELQ2JId9cuplSDEz"
Subject: Re: [Openvpn-devel] [PATCH v6 2/3] crypto_openssl: add
 initialization to pick up local configuration
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2316...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XVdJGSfFBNRxhj0dSELQ2JId9cuplSDEz
Content-Type: multipart/mixed; boundary="6jsyNDijFaabk4jLdcYjQdKeR8nhMJUTZ"

--6jsyNDijFaabk4jLdcYjQdKeR8nhMJUTZ
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>=20
> Sorry about that.  Best guess is it's missing an include for
> openssl/conf.h.  You don't need that today because pretty much every
> other openssl header includes it, but that may not always have been so.
>=20
> Does the below patch fix it?  If it does, it should probably be folded
> into the other patch.  It should be safe because openssl/conf.h has
> existed for every version of openssl you support.


I am also puzzeld by this. On my local machine the OpenSSL 1.0.2 buildis
fine without this extra include.

But I am ACKing this alone on the basis that including the conf.h header
is the corect thing to do (the man page says it should be included)

It fixes the travis build error
(https://travis-ci.org/github/schwabe/openvpn/builds/695947378) but I do
not really understand why OpenSSL behaves different there.

So

Acked-By: Arne Schwabe <arne@...1227...>

>=20
> James
>=20
> ---8>8>8><8<8<8---
> From: James Bottomley <James.Bottomley@...2316...>
> Subject: [PATCH] crypto_openssl: add include for openssl/conf.h
>=20
> Fix build failure on older versions of openssl.
>=20
> Signed-off-by: James Bottomley <James.Bottomley@...2316...>
> ---
>  src/openvpn/crypto_openssl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index fd57edd2..94b6d85b 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -43,6 +43,7 @@
>  #include "crypto_backend.h"
>  #include "openssl_compat.h"
>=20=20
> +#include <openssl/conf.h>
>  #include <openssl/des.h>
>  #include <openssl/err.h>
>  #include <openssl/evp.h>
>=20



--6jsyNDijFaabk4jLdcYjQdKeR8nhMJUTZ--

--XVdJGSfFBNRxhj0dSELQ2JId9cuplSDEz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7eDWUACgkQFRhsZwKx
RFSKvBAAmYNTljmT4UpQPcHtVdLDTgYyoiEsuJVe1NdBFgvVm+SnYMW81t5rGhp2
Dsm47clfeYqrO3eCWFlux/gcPnWMh2AdKEcLVaY/pW4bTceVZH+V5N+vIY7GgN35
q69Pe2hP8ga9miptxOJH3fbsX0uvYk2ZShA4HG9yetAait2EwC2k9qPfVKMAAj1/
DQy1vfYLoKMx6TUN8wWDXB3eB8G4SDOG/pAi86cwGXtdQYS/vANW1sbDKJzwK7kb
yLmr7vlgiRukVCgwfgSn3eJbllponevTdBKtPV5YIeNYwij2u8Bk/lPBhBE7p16C
v9z/yLd42aNFXYFd44LNxVl4tOuZ8GZZcU78o9nKEXF/C4qRzxXIE3T0Mqruml2w
Evl9xyO3YJmX715xU6X7T3REWwix6u9Fgb5WUm4JCrqD4DAf8pWPt2pYSDcpKA32
Ijh9ZQE4R9s9iT6xSVbA+rfHrmc8LI/b50em8IINmCuO/Uge4wtCv96eek6dsfgu
e6FaCYNFIaPmLUusvLFv3WPGhjZYF9fiIm7SEBZrp1u6i/wOT2EhzPjDPSPdzIDt
l2HN1Nq6obLiWpQj7jtqCmRw+KL8wEO8x0X/FqkUDEcjBn88V7JRsPaL5mpOk0G6
1jsbpCbzUPznuLHgl/twUfRXfpMElNqD2wM/lAovrLx14fukdYs=
=W42p
-----END PGP SIGNATURE-----

--XVdJGSfFBNRxhj0dSELQ2JId9cuplSDEz--

