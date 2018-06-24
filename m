References: <20180622014905.21558-1-rosenp@...277...>
 <20180622021501.23037-1-rosenp@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <20c6c5b6-b426-061b-6409-ffc5fbfb8f07@...2181...>
Date: Sun, 24 Jun 2018 15:13:13 +0800
MIME-Version: 1.0
In-Reply-To: <20180622021501.23037-1-rosenp@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="t6WdOunkfdDbLiArw0Rw6phFtSKOwAFwv"
Subject: Re: [Openvpn-devel] [PATCHv2] openvpn: Add missing OpenSSL includes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rosen Penev <rosenp@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t6WdOunkfdDbLiArw0Rw6phFtSKOwAFwv
Content-Type: multipart/mixed; boundary="hTrw5bnRFlDwlcRiKWx7HIzQFysiZ8Ti8";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Rosen Penev <rosenp@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <20c6c5b6-b426-061b-6409-ffc5fbfb8f07@...2181...>
Subject: Re: [Openvpn-devel] [PATCHv2] openvpn: Add missing OpenSSL includes
References: <20180622014905.21558-1-rosenp@...277...>
 <20180622021501.23037-1-rosenp@...277...>
In-Reply-To: <20180622021501.23037-1-rosenp@...277...>

--hTrw5bnRFlDwlcRiKWx7HIzQFysiZ8Ti8
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

for the next time, please put a space in the subject between "PATCH" and
"v2", so that patchwork can happily distinguish the version from the
subject-prefix.
Actually git can do this for you if you specify the -vX argument (i.e.
-v2) to the "git format-patch" command when creating the patch.

Cheers,

On 22/06/18 10:15, Rosen Penev wrote:
> These get included when deprecated APIs are enabled. This is true on at
> least version 1.0.2 and 1.1.0.
>=20
> Without deprecated APIs, OpenVPN fails to compile.
>=20
> Signed-off-by: Rosen Penev <rosenp@...277...>
> ---
>  src/openvpn/ssl_openssl.c        | 9 +++++++++
>  src/openvpn/ssl_verify_openssl.c | 1 +
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 527a600a..d9aec9bd 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -56,6 +56,15 @@
>  #include <openssl/pkcs12.h>
>  #include <openssl/x509.h>
>  #include <openssl/crypto.h>
> +#ifndef OPENSSL_NO_DH
> +#include <openssl/dh.h>
> +#endif
> +#ifndef OPENSSL_NO_DSA
> +#include <openssl/dsa.h>
> +#endif
> +#ifndef OPENSSL_NO_RSA
> +#include <openssl/rsa.h>
> +#endif
>  #ifndef OPENSSL_NO_EC
>  #include <openssl/ec.h>
>  #endif
> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_op=
enssl.c
> index 9b984751..82460ae7 100644
> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -46,6 +46,7 @@
>=20=20
>  #include <openssl/x509v3.h>
>  #include <openssl/err.h>
> +#include <openssl/bn.h>
>=20=20
>  int
>  verify_callback(int preverify_ok, X509_STORE_CTX *ctx)
>=20

--=20
Antonio Quartulli


--hTrw5bnRFlDwlcRiKWx7HIzQFysiZ8Ti8--

--t6WdOunkfdDbLiArw0Rw6phFtSKOwAFwv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsvRIkACgkQB6U8WA7y
zXR99xAAwdUtuLSAfpSJhPx8lNKcfDArCwh0jx2YmtgEz5pQHQgkXNJrVOzJVpAd
B1D3MonlmSZOxZgVKLBNXLREGBz7ubRzpdF2uQIHuUERelm9FPSyDX/HCaSRM8tH
6ypaVTE41XT+IRoPWHROJii6ETRnvxcSg9aT7acIN+BNErVI9R8hcxvVtREEHkFF
HDA8WUBm8NPUzP9uFCOry0yttwQoQ7PAtRhYyWzkZ98jDhG5rKVytLYClAZ0/FDQ
v2iBAM2G7J85W5vPehiOjNmsJEj4JnvcHNVarq93Gk+ZRsvAgIQIBuF5JR7HEasd
txJn8EVpYzLlecM6XlKowVF6weEyNRQLf4d5JSUI7IP0jaXI6Vonl6XNK054CKEw
QE/laq/MovQUTDL4rIUW28qTT7kHXFJ37Dh9CAGej577Z7D2GRjHP7FzGDbPH+KR
fREWgMUxf32D74yQVsO8toph8B2x6m1jujonFRO7g3VJ8Br2/gXLAu9q9EFPpfDE
eM4dC7TWeeY/EupbuUPhi3YtnUjHZhvf3eJBIMJLfYfogO2a4rIiG7XUj3N4iVFJ
tKaZxRoICaBypao4Gjp5fGs4MxWe0Y20C9ctq/TcMoqHbbNrFalqUKYO0WMp94mF
CvABg2KJJrFAXwXLsxHmlcomf/ZATfLxisJPvToG9SAopT4acGU=
=dQsg
-----END PGP SIGNATURE-----

--t6WdOunkfdDbLiArw0Rw6phFtSKOwAFwv--

