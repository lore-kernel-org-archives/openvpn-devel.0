References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1532534933-3858-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ce36e7e1-ed29-c4fa-4e6b-cff22a2f2d83@...2181...>
Date: Thu, 2 Aug 2018 17:10:08 +0800
MIME-Version: 1.0
In-Reply-To: <1532534933-3858-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EGbl4RamXzWSnGxgVjLI1vpZnIQ6hWUPU"
Subject: Re: [Openvpn-devel] [PATCH v3 1/7] Introduce buffer_write_file()
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
--EGbl4RamXzWSnGxgVjLI1vpZnIQ6hWUPU
Content-Type: multipart/mixed; boundary="zOZFtw2sawHrlN2JTZ2oSVjUuxRuVuqfs";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ce36e7e1-ed29-c4fa-4e6b-cff22a2f2d83@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 1/7] Introduce buffer_write_file()
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1532534933-3858-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1532534933-3858-1-git-send-email-steffan.karger@...1435...>

--zOZFtw2sawHrlN2JTZ2oSVjUuxRuVuqfs
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 26/07/18 00:08, Steffan Karger wrote:
> Rewrite buf_write_string_file to buffer_write_file, which is simpler to
> use and can deal with not-null-terminated strings.  Mostly implemented so
> this can be easily reused for tls-crypt-v2 (client) key files.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v3: split change out of "generate client key", reuse in write_key_file()
>=20
>  src/openvpn/buffer.c | 31 ++++++++++++++++++++++++-------
>  src/openvpn/buffer.h |  7 ++-----
>  src/openvpn/crypto.c | 30 +++++-------------------------
>  3 files changed, 31 insertions(+), 37 deletions(-)
>=20
> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
> index 0972139..20e2b9c 100644
> --- a/src/openvpn/buffer.c
> +++ b/src/openvpn/buffer.c
> @@ -343,16 +343,33 @@ convert_to_one_line(struct buffer *buf)
>      }
>  }
>=20=20
> -/* NOTE: requires that string be null terminated */
> -void
> -buf_write_string_file(const struct buffer *buf, const char *filename, in=
t fd)
> +bool
> +buffer_write_file(const char *filename, const struct buffer *buf)

Since you are removing the old comments from both function declaration
and definition, why not adding some little doxygen style doc?


I see you are also changing the way this method works (now it takes only
the filename instead of a fd), but given that we currently use it only
once in our code (for now), I think this change is ok and actually makes
the logic more self-contained (no need for the caller to deal with the
fd at all).

>  {
> -    const int len =3D strlen((char *) BPTR(buf));
> -    const int size =3D write(fd, BPTR(buf), len);
> -    if (size !=3D len)
> +    bool ret =3D false;
> +    int fd =3D platform_open(filename, O_CREAT | O_TRUNC | O_WRONLY,
> +                           S_IRUSR | S_IWUSR);
> +    if (fd =3D=3D -1)
> +    {
> +        msg(M_ERRNO, "Cannot open file '%s' for write", filename);
> +        goto cleanup;
> +    }
> +
> +    const int size =3D write(fd, BPTR(buf), BLEN(buf));
> +    if (size !=3D BLEN(buf))
>      {
> -        msg(M_ERR, "Write error on file '%s'", filename);
> +        msg(M_ERRNO, "Write error on file '%s'", filename);
> +        goto cleanup;
> +    }
> +
> +    ret =3D true;
> +cleanup:
> +    if (close(fd))

nitpikcing: I'd dare to say that in the rest of the code we prefer to
use "func() < 0" as check, to make it more explicit that we are looking
for errors (my personal feeling is that when i see something like your
expression I always need to double check "does this function return
something positive too? what in case of errors?").

On top of that consistency is always good :-)

> +    {
> +        msg(M_ERRNO, "Close error on file %s", filename);
> +        ret =3D false;
>      }
> +    return ret;
>  }
>=20=20
>  /*
> diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
> index 6b6025e..180dd56 100644
> --- a/src/openvpn/buffer.h
> +++ b/src/openvpn/buffer.h
> @@ -469,11 +469,8 @@ const char *skip_leading_whitespace(const char *str);
>=20=20
>  void string_null_terminate(char *str, int len, int capacity);
>=20=20
> -/*
> - * Write string in buf to file descriptor fd.
> - * NOTE: requires that string be null terminated.
> - */
> -void buf_write_string_file(const struct buffer *buf, const char *filenam=
e, int fd);
> +/** Write buffer contents to file */
> +bool buffer_write_file(const char *filename, const struct buffer *buf);
>=20=20
>  /*
>   * write a string to the end of a buffer that was
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 5381ef2..35bd243 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -1427,27 +1427,19 @@ write_key_file(const int nkeys, const char *filen=
ame)
>  {
>      struct gc_arena gc =3D gc_new();
>=20=20
> -    int fd, i;
> -    int nbits =3D 0;
> +    int nbits =3D nkeys * sizeof(struct key) * 8;
>=20=20
>      /* must be large enough to hold full key file */
>      struct buffer out =3D alloc_buf_gc(2048, &gc);
> -    struct buffer nbits_head_text =3D alloc_buf_gc(128, &gc);
>=20=20
>      /* how to format the ascii file representation of key */
>      const int bytes_per_line =3D 16;
>=20=20
> -    /* open key file */
> -    fd =3D platform_open(filename, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR=
 | S_IWUSR);
> -
> -    if (fd =3D=3D -1)
> -    {
> -        msg(M_ERR, "Cannot open shared secret file '%s' for write", file=
name);
> -    }
> -
> +    /* write header */
> +    buf_printf(&out, "#\n# %d bit OpenVPN static key\n#\n", nbits);
>      buf_printf(&out, "%s\n", static_key_head);
>=20=20
> -    for (i =3D 0; i < nkeys; ++i)
> +    for (int i =3D 0; i < nkeys; ++i)
>      {
>          struct key key;
>          char *fmt;
> @@ -1463,9 +1455,6 @@ write_key_file(const int nkeys, const char *filenam=
e)
>                              "\n",
>                              &gc);
>=20=20
> -        /* increment random bits counter */
> -        nbits +=3D sizeof(key) * 8;
> -
>          /* write to holding buffer */
>          buf_printf(&out, "%s\n", fmt);
>=20=20
> @@ -1476,17 +1465,8 @@ write_key_file(const int nkeys, const char *filena=
me)
>=20=20
>      buf_printf(&out, "%s\n", static_key_foot);
>=20=20
> -    /* write number of bits */
> -    buf_printf(&nbits_head_text, "#\n# %d bit OpenVPN static key\n#\n", =
nbits);
> -    buf_write_string_file(&nbits_head_text, filename, fd);
> -
>      /* write key file, now formatted in out, to file */
> -    buf_write_string_file(&out, filename, fd);
> -
> -    if (close(fd))
> -    {
> -        msg(M_ERR, "Close error on shared secret file %s", filename);
> -    }
> +    buffer_write_file(filename, &out);
>=20=20
>      /* zero memory which held file content (memory will be freed by GC) =
*/
>      buf_clear(&out);
>=20

I like this change especially because the writing function now returns a
boolean reporting its success or failure. How about adding some more
checks in the calling chain so that such status can be used?

As of now, if the writing function fails, openvpn will print an error
message, but won't really return "a failure" (as in returning non-zero).
What do you think?


Cheers,

--=20
Antonio Quartulli


--zOZFtw2sawHrlN2JTZ2oSVjUuxRuVuqfs--

--EGbl4RamXzWSnGxgVjLI1vpZnIQ6hWUPU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltiynEACgkQB6U8WA7y
zXTKYQ/9EO6aeri3oYMtPYOItJSGo3yONNA+A7A8QQUmmgGAHbrL+kogvUsGSxJY
P0RBDwizZl6kUdA9vtp5BpVJTB5+5sd0+bXOOqeeYFuhj+RopwyKwW9Zkzx7jSd2
NcIsj0pBNs8yIxdzWTAwYnXpc6Ygsg+HGMYrMQPYdJ21q3Cf6OzCnw+u5JQeR9xL
rjSsdobo6CxgpZNrtqYOmtiv/X90CtHPOnRaIaPhgIz75luGzqzCgCZCVqv+TFXe
i3+tekUDrtFWHuEXWMzvX/WfkMC0ySQa8F6Si6C50eHo77umbuB5OTep2nNqDP+H
xXsrquzc03eSgPA8uOGD65hHpyge6ntSFrD22m2sImELOmrT/AAGh3lFQaAobyfB
60AaUKiXcGzcTkLvna5OnxXZjMwtwYE3/sJTuTDELQbUphtrgRp6MhbTpdXOEITv
a8dpI5oI/IAFApCX5S5DETN3sRnfiiU12gjqe29HWfgQc17fxuTv49I4zxpda11K
XPsb73CW9EqTwkG6q9/dk0CMUypnIB5/ubQxbBB/+WO9V/QeA26FhBTcwmxNHBoJ
mLOyPm2DsaRYodM9enMRn1RJUPGq8SYO5YE3G/g6rsn0IsCe/wVLsBm6OdfsMkif
vN+9qIjxWKTVN5hcaXSJqVo0Ua8gQSa/LuGaR6/F2iJGrAP5TJ0=
=h+ab
-----END PGP SIGNATURE-----

--EGbl4RamXzWSnGxgVjLI1vpZnIQ6hWUPU--

