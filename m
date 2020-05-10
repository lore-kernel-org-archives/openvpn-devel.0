References: <20200508212356.18522-1-a@...2181...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <2020aab0-8312-2bd9-d2c2-20484d062934@...2080...>
Date: Sun, 10 May 2020 15:53:37 +0200
MIME-Version: 1.0
In-Reply-To: <20200508212356.18522-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2PPEFeVrU6KuTjhPbDLMzUjGBUFXaOhCv"
Subject: Re: [Openvpn-devel] [PATCH] get rid of TAG_FILE_INLINE constant
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2PPEFeVrU6KuTjhPbDLMzUjGBUFXaOhCv
Content-Type: multipart/mixed; boundary="TB4BYgnpxBdxItdqHg8vxzGLykrKc50l8";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <2020aab0-8312-2bd9-d2c2-20484d062934@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] get rid of TAG_FILE_INLINE constant
References: <20200508212356.18522-1-a@...2181...>
In-Reply-To: <20200508212356.18522-1-a@...2181...>

--TB4BYgnpxBdxItdqHg8vxzGLykrKc50l8
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 08/05/2020 23:23, Antonio Quartulli wrote:
> Now that the whole inline logic has been converted to using bool flags,
> the TAG_FILE_INLINE constant is not useful anymore.
>=20
> Get rid of the constant as it's now unused and to prevent any future
> developer from mistakenly use it again.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>=20
> to be applied after all other fixes, as they remove the few last usages
> of this constant.
>=20
>=20
>  src/openvpn/common.h | 6 ------
>  src/openvpn/crypto.c | 2 +-
>  2 files changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/src/openvpn/common.h b/src/openvpn/common.h
> index 4e6f4809..623b3e0d 100644
> --- a/src/openvpn/common.h
> +++ b/src/openvpn/common.h
> @@ -88,12 +88,6 @@ typedef unsigned long ptr_type;
>   */
>  #define PUSH_REQUEST_INTERVAL 5
>=20=20
> -/*
> - * A sort of pseudo-filename for data provided inline within
> - * the configuration file.
> - */
> -#define INLINE_FILE_TAG "[[INLINE]]"
> -
>  /*
>   * Script security warning
>   */
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 672aa14a..f1a52d8c 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -1189,7 +1189,7 @@ print_key_filename(const char *str, bool is_inline)
>  {
>      if (is_inline)
>      {
> -        return INLINE_FILE_TAG;
> +        return "[[INLINE]]";
>      }
>=20=20
>      return np(str);
>=20

This looks promising, but is not complete - and breaking compilation:


$ git grep INLINE_FILE_TAG
src/openvpn/tls_crypt.c:        client_filename =3D INLINE_FILE_TAG;

$ make -j5
[...]
make[3]: Entering directory `/home/davids/devel/OpenVPN/openvpn/src/openvpn'
  CC       tls_crypt.o
tls_crypt.c: In function =E2=80=98tls_crypt_v2_write_client_key_file=E2=80=
=99:
tls_crypt.c:706:27: error: =E2=80=98INLINE_FILE_TAG=E2=80=99 undeclared (fi=
rst use in this
function)
         client_filename =3D INLINE_FILE_TAG;
                           ^

I haven't dug into if client_filename really needs to be set to INLINE_FILE=
_TAG.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--TB4BYgnpxBdxItdqHg8vxzGLykrKc50l8--

--2PPEFeVrU6KuTjhPbDLMzUjGBUFXaOhCv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJeuAdhAAoJEIbPlEyWcf3yUAEQAIqhA2E2qylkkmdVgnJs1x/R
Bl9XGDR0GPBNxVHrMolOuFJVuLoM39j36mf3AhbxKisrbSHGc8FFvjSbMjYkGsss
kzcRuDRd485w4ZI8zmZqA72RWMkdqhE0AtoK2LRSaBFAs7qSbtAHxylLSZsWQlsl
YY/gxzDk+mpAb27ClcE9IaGphYr7KN8qbwvwCdyHlvVscNVnq/m4J6FLddDijFx0
pihd9Vyjt7UgrEMel+PWwoM28Nz2Bb/P3iJJRCMVO+/AMSv4Ug962max7HTDvEnk
pJ/qDXaqVj9GpKqRe9H4CTHHXDZcyXqfhF4/TCf0qrZtPYsR9nDffIVD9Dt+ybcU
JbgLJJCc7iVBazAPL0Q6UP41ZldUkr/hSM7JnrOVhBEcNBdC6KsvQMrnY36FZ/O2
giuFWca1t+BSzqkHKisPSUnW2oA2WuCnAoqvt/MZbyG6Trmz+3/ggRsjH1pA2GMK
64rffIuTvQ+aTSZ0ynlfNoC42JyhYtjw7KDANWGguA2VhRDJWumAnwy7FanbQn58
yy4wF3g4vzQeXRPavU4njvnt+sHTrWdszChiFzK/eYsIGX8huiip1JgqOJTONfAv
O2gpXI8qVqaAcgYd02freJnLwb/J8X4dievMGLixkaLPjtlReBEv/k7JcfozXukD
1L4xOa3Xvd8OPR2usyV4
=3Hx/
-----END PGP SIGNATURE-----

--2PPEFeVrU6KuTjhPbDLMzUjGBUFXaOhCv--

