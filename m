Date: Wed, 15 Mar 2017 22:00:47 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170315210046.GW93896@...1296...>
References: <1b2fc2aa-74b0-6a91-aeb0-a45d7a8062cc@...1918...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibQy1PD9BIJOeb75"
Content-Disposition: inline
In-Reply-To: <1b2fc2aa-74b0-6a91-aeb0-a45d7a8062cc@...1918...>
Subject: Re: [Openvpn-devel] [PATCH] Fix Building Using MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>
Cc: openvpn-devel@lists.sourceforge.net

--ibQy1PD9BIJOeb75
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

thanks for your patch.  I'm not exactly happy with it for a number
of reasons, but it's a good way to get started.

Details...

On Tue, Mar 14, 2017 at 09:26:52AM +1100, Eric Thorpe wrote:
[..]
> diff --git a/config-msvc-version.h.in b/config-msvc-version.h.in
> index 4bc89e7..7977cb8 100644
> --- a/config-msvc-version.h.in
> +++ b/config-msvc-version.h.in

I can't comment on these changes, but I assume that's "funny macro handling"
related...  and since it's MSVC only, the risk of breaking anything else
is small.

> diff --git a/config-msvc.h b/config-msvc.h
> index 3e71c85..9b97e71 100644
> --- a/config-msvc.h
> +++ b/config-msvc.h
> @@ -126,6 +126,7 @@ typedef __int64 int64_t;
>   typedef __int32 int32_t;
>   typedef __int16 int16_t;
>   typedef __int8 int8_t;
> +typedef uint16_t in_port_t;

The indenting of that chunk looks a bit weird (extra space at the=20
beginning of the context lines) but that's easily sorted manually.


>   #ifdef HAVE_CONFIG_MSVC_LOCAL_H
>   #include <config-msvc-local.h>
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 5549d70..bed39f3 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -287,7 +287,12 @@ show_available_ciphers()
>=20
>       /* If we ever exceed this, we must be more selective */
>       const size_t cipher_list_len =3D 1000;
> +#ifdef _MSC_VER
> +    //While GCC will allow you to use a const, MSVC won't (at least=20
> with a simple declaration). Use a compile time constant for now
> +    const EVP_CIPHER *cipher_list[1000];
> +#else
>       const EVP_CIPHER *cipher_list[cipher_list_len];
> +#endif
>       size_t num_ciphers =3D 0;

I don't think we should do this.  If we have a length, use it.  If
the compiler is too daft to understand consts, maybe we should go
for "#define CIPHER_LIST_LEN 1000" instead - indeed, more changes,
but no magic numbers.  Or abandon the definition, use [1000], and
sizeof() in the out of bounds check below.

Steffan, your code, what would you say?


Style-wise: please do not use C++ comments, and break long lines.


> --- a/src/openvpn/openvpn.vcxproj
> +++ b/src/openvpn/openvpn.vcxproj
> @@ -99,13 +99,16 @@
>       </Link>
>     </ItemDefinitionGroup>
>     <ItemGroup>
> +    <ClCompile Include=3D"argv.c" />
>       <ClCompile Include=3D"base64.c" />
> +    <ClCompile Include=3D"block_dns.c" />

Yeah.  Oversight when we added new modules - these are easy enough :-)

> diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
> index c64c65f..a974e7e 100644
> --- a/src/openvpn/ssl_openssl.h
> +++ b/src/openvpn/ssl_openssl.h
> @@ -49,7 +49,11 @@
>    */
>   struct tls_root_ctx {
>       SSL_CTX *ctx;
> +#ifdef _MSC_VER
> +    struct timeval crl_last_mtime;
> +#else
>       struct timespec crl_last_mtime;
> +#endif
>       off_t crl_last_size;
>   };


We should not do this.  It's not your fault for finding this, but having
looked at the code to understand why this would be fixing things, I=20
wonder why we're using a "struct timespec" in the first place, or
why we're having a structure "with subseconds" in there when all we use
is the "seconds" bit *because* "windows has no nanoseconds"...

src/openvpn/ssl.c

    /*
     * Store the CRL if this is the first time or if the file was changed s=
ince
     * the last load.
     * Note: Windows does not support tv_nsec.
     */
    if ((ssl_ctx->crl_last_size =3D=3D crl_stat.st_size)
        && (ssl_ctx->crl_last_mtime.tv_sec =3D=3D crl_stat.st_mtime))
...
    ssl_ctx->crl_last_mtime.tv_sec =3D crl_stat.st_mtime;
    ssl_ctx->crl_last_size =3D crl_stat.st_size;


Antonio, this is your code - how shall we handle this?

Today, we only use seconds, so "struct timeval" on all platforms would
be good enough.  Some platforms' "struct stat" actually has a st_mtim
which is a "struct timespec" (and st_mtime is defined as st_mtim.tv_sec),
so if we ever go for subsecond accuracy, timespec is the right thing to
do - OTOH, that will need at least one extra configure test, given
how various OSes <sys/stat.h> weasle around "struct timespec"...

#if (_POSIX_C_SOURCE - 0) >=3D 200809L || (_XOPEN_SOURCE - 0) >=3D 700 || \
    defined(_NETBSD_SOURCE)
        struct    timespec st_atim;     /* time of last access */
        struct    timespec st_mtim;     /* time of last data modification */
        struct    timespec st_ctim;     /* time of last file status change =
*/
        struct    timespec st_birthtim; /* time of creation */
#else
        time_t    st_atime;             /* time of last access */
        long      st_atimensec;         /* nsec of last access */
        time_t    st_mtime;             /* time of last data modification */
        long      st_mtimensec;         /* nsec of last data modification */
...


So, it might be worth considering just dropping the notion of interest
in subseconds, and go for a plain "time_t" for "crl_last_mtime"...
(slightly more code changes, but less portability hassle).

Again, Antonio, your call...


Eric, could you re-send the patch without the crypto_openssl.c and
ssl_openssl.h hunks?  I could merge the rest while Steffan and Antonio
ponder these changes...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ibQy1PD9BIJOeb75
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYyat9AAoJEB2Cnv7KVigSoX0MAK9OaX8g6ghy3FR7HiuqqR+e
7pIiigCNY8N2XIL/a2D+kCiUDmLRZQ+LGCW2IMcQi5vdsP55uPRFyBP/4NlOSOn2
dnylMYRd1/mcH2p8DOmdn4g6nuZazJsb1VC/8ZL9J4kazFUqteT1UZoEGrYSeutK
WBsJMKQc15r74nClFL+9eawtBAgNvnQdXkgiJJA07IoUNg7JPBOcBsBJTSz0ODPS
pt3jHJnxHQABxyEqvTUuQEOYtgGE9dpepECAfYw652hWZ7JWYJbuuul6gIhufyd3
4iGfZw54zZOrToKy1yZNxY/NPhLrkkooPLcVMWjvNxa7p5o5j/J2u7BznaIDARch
l696HQx3c5jfv9Ap/7nu0ORq5iYF93aSm++c5zpulpRYqEkal1/56y7CgHaSmF0+
ftsRFDRZqyudwOZyHNL3eDwpWLXqeD92xPfPGmL1dD/NhCB5DthEJgfWrRUztHRH
avWY55mbhhl4JjSS2mZc5sxT+bMdOYhbN5y55qWw0Q==
=/mTq
-----END PGP SIGNATURE-----

--ibQy1PD9BIJOeb75--

