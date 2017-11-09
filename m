References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <20171101220342.14648-1-steffan@...1856...>
 <20171101220342.14648-5-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <2bacffe7-e42b-9a33-b502-924ef38c628a@...2181...>
Date: Thu, 9 Nov 2017 11:25:13 +0800
MIME-Version: 1.0
In-Reply-To: <20171101220342.14648-5-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ThhKBdGUNfm733gL4rnal0jSFHI2mTB1U"
Subject: Re: [Openvpn-devel] [PATCH 4/4 v3] create_temp_file/gen_path:
 prevent memory leak if gc == NULL
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
--ThhKBdGUNfm733gL4rnal0jSFHI2mTB1U
Content-Type: multipart/mixed; boundary="bvUmbHxQVSQxJ0qxpXpJI7p9gktP2nJ32";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <2bacffe7-e42b-9a33-b502-924ef38c628a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 4/4 v3] create_temp_file/gen_path: prevent
 memory leak if gc == NULL
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <20171101220342.14648-1-steffan@...1856...>
 <20171101220342.14648-5-steffan@...1856...>
In-Reply-To: <20171101220342.14648-5-steffan@...1856...>

--bvUmbHxQVSQxJ0qxpXpJI7p9gktP2nJ32
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Steffan,

patch looks good, but I have just one comment below

On 02/11/17 06:03, Steffan Karger wrote:
> If gc =3D=3D NULL, the data allocated in the alloc_gc_buf() call in
> create_temp_file or the string_mod_const call in gen_path would never
> be free'd.
>=20
> These functions are currently never called that way, but let's prevent
> future problems.
>=20
> While touching create_temp_file, also remove the counter variable, which =
is
> never read, simplify the do-while to a while loop, and truncate the prefix
> (if needed) to preserve the random and extension of the created filename.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
> v2:
>  - change create_temp_file to avoid using a struct buffer (simpler)
>  - add gc !=3D NULL check for gen_path (avoid similar memleak pitfall)
> v3:
>  - Check the return value of openvpn_snprintf()
>=20
>  src/openvpn/misc.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>=20
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 25f38003..67011169 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -723,21 +723,26 @@ test_file(const char *filename)
>  const char *
>  create_temp_file(const char *directory, const char *prefix, struct gc_ar=
ena *gc)
>  {
> -    static unsigned int counter;
> -    struct buffer fname =3D alloc_buf_gc(256, gc);
>      int fd;
>      const char *retfname =3D NULL;
>      unsigned int attempts =3D 0;
> +    char fname[256] =3D { 0 };
> +    const char *fname_fmt =3D PACKAGE "_%.*s_%08lx%08lx.tmp";
> +    const int max_prefix_len =3D sizeof(fname) - (sizeof(PACKAGE) + 7 + =
(2 * 8));
>=20=20
> -    do
> +    while (attempts < 6)
>      {
>          ++attempts;
> -        ++counter;
>=20=20
> -        buf_printf(&fname, PACKAGE "_%s_%08lx%08lx.tmp", prefix,
> -                   (unsigned long) get_random(), (unsigned long) get_ran=
dom());
> +        if (!openvpn_snprintf(fname, sizeof(fname), fname_fmt, max_prefi=
x_len,
> +                              prefix, (unsigned long) get_random(),
> +                              (unsigned long) get_random()))
> +        {
> +            msg(M_WARN, "ERROR: temporary filename too long");
> +            return NULL;
> +        }
>=20=20
> -        retfname =3D gen_path(directory, BSTR(&fname), gc);
> +        retfname =3D gen_path(directory, fname, gc);
>          if (!retfname)
>          {
>              msg(M_WARN, "Failed to create temporary filename and path");
> @@ -760,7 +765,6 @@ create_temp_file(const char *directory, const char *p=
refix, struct gc_arena *gc)
>              return NULL;
>          }
>      }
> -    while (attempts < 6);
>=20=20
>      msg(M_WARN, "Failed to create temporary file after %i attempts", att=
empts);
>      return NULL;
> @@ -812,6 +816,12 @@ gen_path(const char *directory, const char *filename=
, struct gc_arena *gc)
>  #else
>      const int CC_PATH_RESERVED =3D CC_SLASH;
>  #endif
> +
> +    if (!gc)
> +    {
> +        return NULL; /* Would leak memory otherwise */

As far as I understood the ratio behind this change, we are basically
saying that passing gc =3D=3D NULL is a real programming error and not a
runtime problem. If so, wouldn't it be better to assert(gc) directly?
I am saying so because we should make this failure louder, so that it
can be recognized in an early test.

Or can we have cases when this function is called with NULL because of a
temporary failure (my understanding is that this should not be possible)?


Cheers,

> +    }
> +
>      const char *safe_filename =3D string_mod_const(filename, CC_PRINT, C=
C_PATH_RESERVED, '_', gc);
>=20=20
>      if (safe_filename
>=20

--=20
Antonio Quartulli


--bvUmbHxQVSQxJ0qxpXpJI7p9gktP2nJ32--

--ThhKBdGUNfm733gL4rnal0jSFHI2mTB1U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAloDypkACgkQB6U8WA7y
zXTNhxAApwXrejz6IUwe/TfS8m14yJppNpSLsDsM9bQfkabLElqQwCTrktzXEJZE
1g5D6+4YU/4s2hwI5mf0JgAJ5fd8iJnvivxxW6W1B9VmDNMnpMWYDnv6ui6jXswy
/IVbNHTq+VkpxnUnVX5ohIMoFICp/cQE0F2W2C1oBVWXOjBbS7nmo8DxwR3gWAfz
NLwL78oa1iLxahzNjtWwray5LAEPl6LhJzsZzOHlo3SVTUH6+wht4i8iAy0iG/p/
rQHwi30dv1z7VzqINgqiW/REgpvjdX0iBsadQExQE7i1z7XuLtwsaBY55c7c3QO/
VH2vp6OUjAYDslwC6jve0ZyTVjtQxmSep5mpvmbCvYF+Jw/2jZaG1rRn0/MAY+UH
YmLtXY0tIgmp3oCC0yOkT3ZPueRJF8qqa8iFsyp9mKJYuybYifoCH5tq4OigJS2j
v7fcKpI9JDog1p7OROiRnDibrmCx6WvHpCk3poG7lWgR0NuEXIbSBjJ1OMRtXoQz
IlhfTiWw9sIYbuXpPOXsYs2+ciI/M1Mke+f9fXJ8/UUvz3VlcHDUy9pbWh0QM9Kh
h4zD2+XbhjREXB5RSnsexKOjRujSUH/qPxuYqdwbzRserSedPbfoGM/PWTrZOYRO
8NgnQIzy7gAHGKFRQbTZYPV/UIxrFEddgq/U6wHQ2Udp6u2LU3o=
=sN4T
-----END PGP SIGNATURE-----

--ThhKBdGUNfm733gL4rnal0jSFHI2mTB1U--

