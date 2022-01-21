Date: Fri, 21 Jan 2022 18:09:49 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Yero3Th1c4D74EY8@...1296...>
References: <20220119182126.56880-1-openvpn@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QyNfntSJPF2dYEOK"
Content-Disposition: inline
In-Reply-To: <20220119182126.56880-1-openvpn@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v3] crypto: Fix OPENSSL_FIPS enabled
 builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net

--QyNfntSJPF2dYEOK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jan 19, 2022 at 07:21:26PM +0100, David Sommerseth wrote:
> index 5626e2b6..eb0b1254 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -34,6 +34,7 @@
>  #include "error.h"
>  #include "integer.h"
>  #include "platform.h"
> +#include "openssl_compat.h"
>=20=20
>  #include "memdbg.h"

This breaks compilation for mbedtls builds, depending on which version
of OpenSSL happens to be installed on the system (if any).

In this particular case, mbedtls build with a system openssl of 0.9.8,
it blows up with

In file included from crypto.c:37:
openssl_compat.h: In function 'SSL_CTX_get_min_proto_version':
openssl_compat.h:635: error: 'SSL_OP_NO_TLSv1_1' undeclared=20
                (first use in this

(and more of this)

which is unsurprising - it's not supposed to pull in these headers
in the first place.


I wondered about this header, but did not wonder enough to verify
that it indeed must not be included for non-openssl-builds.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--QyNfntSJPF2dYEOK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJh6ujcAAoJEB2Cnv7KVigScGMMAJsdVUTIzcijGrtsg9hLZsWM
uxajsBF6n+I/vlCxnm6mCt8aV8cn/btm2T1J4BG5gFe109oFd7Qg0381TGB0dnJ9
ohfIZvfgRlQYm9khaZYxwVoDMVrO4blvDnF2fKUN/aLYRO2TOVrRQclajKwsS0gX
NYA0RHES1XGxlcJBseWQj34YFGuYUunEl881ehH8Xy9EyYPyuTEPaa0KfNWsJjDb
Mb5TBPF1sZAQfy9l7m5KtQFHhp4txZE9SGOm7Xg3wJUs4td2rpwZMStMCN38zfum
smuCQ9dx1zzWLKwyZ1UvRduyMn6SfTtDlIjVoOcYwiyCHd4CWuu+rH6ctxNxg4n+
lo37itqt6Vp/GtbkIkpJiHB4/LipHQKT0h9ozOQGWJxMozZM7eeLZxEWDPhfCVFB
5wyx8u7UNElEObcoIkivkVHzTMKI5fxdJ0i52/3sRMhIxt/1+J1qA5rpBwOdcb2N
P/xqne1sw1un789bdr9Y28sSAVoBsmwI4Cy6VsReHA==
=Cgg5
-----END PGP SIGNATURE-----

--QyNfntSJPF2dYEOK--

