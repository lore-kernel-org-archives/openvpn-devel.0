References: <20181019155638.9498-1-davids@...515...>
 <20181019155638.9498-2-davids@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <fef5a979-ccff-71c2-61c8-1bd8ead96cbc@...1227...>
Date: Mon, 26 Nov 2018 17:39:40 +0100
MIME-Version: 1.0
In-Reply-To: <20181019155638.9498-2-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0V0w45NWDtMGTkZzgwMqba9dTTBL0D5xt"
Subject: Re: [Openvpn-devel] [PATCH 1/4] re-implement argv_printf_*()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0V0w45NWDtMGTkZzgwMqba9dTTBL0D5xt
Content-Type: multipart/mixed; boundary="MpJyRMkIBSpViqEs45nsDx7fwmDJCcNwJ";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <fef5a979-ccff-71c2-61c8-1bd8ead96cbc@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] re-implement argv_printf_*()
References: <20181019155638.9498-1-davids@...515...>
 <20181019155638.9498-2-davids@...515...>
In-Reply-To: <20181019155638.9498-2-davids@...515...>

--MpJyRMkIBSpViqEs45nsDx7fwmDJCcNwJ
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 19.10.18 um 17:56 schrieb David Sommerseth:
> From: Heiko Hund <heiko.hund@...1489...>
>=20
> The previous implementation had the problem that it was not fully
> compatible with printf() and could only detect % format directives
> following a space character (0x20).
>=20
> It modifies the format string and inserts marks to separate groups
> before passing it to the regular printf in libc. The marks are
> later used to separate the output string into individual command
> line arguments.
>=20
> The choice of 0x1D as the argument delimiter is based on the
> assumption that no "regular" string passed to argv_printf_*() will
> ever have to contain that byte (and the fact that it actually is
> the ASCII "group separator" control character, which fits its
> purpose).
>=20
> This commit has been updated by David Sommerseth based on his feedback
> on the mailing list discussions earlier on.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/argv.c                   | 266 ++++++++++++---------------
>  src/openvpn/argv.h                   |   4 +-
>  src/openvpn/route.c                  |   8 +-
>  src/openvpn/tun.c                    |  24 +--
>  tests/unit_tests/openvpn/test_argv.c |  58 +++++-
>  5 files changed, 192 insertions(+), 168 deletions(-)
>=20
> diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
> index 9100a196..9606f382 100644
> --- a/src/openvpn/argv.c
> +++ b/src/openvpn/argv.c
> @@ -131,64 +131,6 @@ argv_insert_head(const struct argv *a, const char *h=
ead)
>      return r;
>  }
>=20=20
> -static char *
> -argv_term(const char **f)
> -{
> -    const char *p =3D *f;
> -    const char *term =3D NULL;
> -    size_t termlen =3D 0;
> -
> -    if (*p =3D=3D '\0')
> -    {
> -        return NULL;
> -    }
> -
> -    while (true)
> -    {
> -        const int c =3D *p;
> -        if (c =3D=3D '\0')
> -        {
> -            break;
> -        }
> -        if (term)
> -        {
> -            if (!isspace(c))
> -            {
> -                ++termlen;
> -            }
> -            else
> -            {
> -                break;
> -            }
> -        }
> -        else
> -        {
> -            if (!isspace(c))
> -            {
> -                term =3D p;
> -                termlen =3D 1;
> -            }
> -        }
> -        ++p;
> -    }
> -    *f =3D p;
> -
> -    if (term)
> -    {
> -        char *ret;
> -        ASSERT(termlen > 0);
> -        ret =3D malloc(termlen + 1);
> -        check_malloc_return(ret);
> -        memcpy(ret, term, termlen);
> -        ret[termlen] =3D '\0';
> -        return ret;
> -    }
> -    else
> -    {
> -        return NULL;
> -    }
> -}
> -
>  const char *
>  argv_str(const struct argv *a, struct gc_arena *gc, const unsigned int f=
lags)
>  {
> @@ -218,119 +160,151 @@ argv_msg_prefix(const int msglev, const struct ar=
gv *a, const char *prefix)
>      gc_free(&gc);
>  }
>=20=20
> -static void
> +
> +/*
> + * argv_prep_format - prepare argv format string for further processing
> + *
> + * Individual argument must be separated by space. Ignores leading and t=
railing spaces.
> + * Consecutive spaces count as one. Returns prepared format string, with=
 space replaced
> + * by delim and adds the number of arguments to the count parameter.
> + */
> +static char *
> +argv_prep_format(const char *format, const char delim, size_t *count, st=
ruct gc_arena *gc)
> +{

Lines longer than 80 chars (90).

> +    int i, j;
> +    char *f;
All could be made inline with C99

> +    bool in_token =3D false;
> +
> +    if (format =3D=3D NULL)
> +    {
> +        return NULL;
> +    }
> +
> +    f =3D gc_malloc(strlen(format) + 1, true, gc);
> +    for (i =3D 0, j =3D 0; i < strlen(format); i++)
> +    {
int i=3D0, j=3D0;

> +        if (format[i] =3D=3D ' ')
> +        {
> +            in_token =3D false;
> +            continue;
> +        }
> +
> +        if (!in_token)
> +        {
> +            ++*count;

I am entirely sure about our style here but I would prefer brackets
around (*count). And since you use i++ and j++, also should use (*count)++;

> +
> +            /*
> +             * We don't add any delimiter to the resulting
> +             * format string before something has been added there.

This sentence is hard to understand. "before something has been added
there" =3D> if it is empty?

> +             * The resulting format string will never start with a delim=
iter.

Okay. But why? I think this is done to ignore, leading spaces?

> +             */
> +            if (j > 0)
> +            {
> +                f[j++] =3D delim;
> +            }

[...]

> +/*
> + * argv_printf_arglist - create a struct argv from a format string
> + *
> + * Instead of parsing the format string ourselves place delimiters via a=
rgv_prep_format()
> + * before we let libc's printf() do the parsing. Then split the resultin=
g string at the
> + * injected delimiters.
> + */
> +static bool
>  argv_printf_arglist(struct argv *a, const char *format, va_list arglist)
>  {
> -    char *term;
> -    const char *f =3D format;
> +    struct gc_arena gc =3D gc_new();
> +    const char delim =3D 0x1D;  /* ASCII Group Separator (GS) */
> +    char *f, *buf, *end;
> +    size_t argc, size;
> +    bool res =3D false;
> +    va_list tmplist;
> +    int len;

Making some of these inline or move their defintion closer where they
are actually would make the code easier to understand.


>      argv_extend(a, 1); /* ensure trailing NULL */

This depends on the side effect of the allocating nulling things before.
Not sure if that is okay or not.

> -    while ((term =3D argv_term(&f)) !=3D NULL)
> +    argc =3D a->argc;
> +    f =3D argv_prep_format(format, delim, &argc, &gc);
> +    if (f =3D=3D NULL)
>      {
> -        if (term[0] =3D=3D '%')
> -        {
> -            if (!strcmp(term, "%s"))
> -            {
> -                char *s =3D va_arg(arglist, char *);
> -                if (!s)
> -                {
> -                    s =3D "";
> -                }
> -                argv_append(a, string_alloc(s, NULL));
> -            }
> -            else if (!strcmp(term, "%d"))
> -            {
> -                char numstr[64];
> -                openvpn_snprintf(numstr, sizeof(numstr), "%d", va_arg(ar=
glist, int));
> -                argv_append(a, string_alloc(numstr, NULL));
> -            }
> -            else if (!strcmp(term, "%u"))
> -            {
> -                char numstr[64];
> -                openvpn_snprintf(numstr, sizeof(numstr), "%u", va_arg(ar=
glist, unsigned int));
> -                argv_append(a, string_alloc(numstr, NULL));
> -            }
> -            else if (!strcmp(term, "%lu"))
> -            {
> -                char numstr[64];
> -                openvpn_snprintf(numstr, sizeof(numstr), "%lu",
> -                                 va_arg(arglist, unsigned long));
> -                argv_append(a, string_alloc(numstr, NULL));
> -            }
> -            else if (!strcmp(term, "%s/%d"))
> -            {
> -                char numstr[64];
> -                char *s =3D va_arg(arglist, char *);
> -
> -                if (!s)
> -                {
> -                    s =3D "";
> -                }
> +        goto out;
> +    }
>=20=20
> -                openvpn_snprintf(numstr, sizeof(numstr), "%d", va_arg(ar=
glist, int));
> +    /* determine minimum buffer size */
> +    va_copy(tmplist, arglist);
> +    len =3D vsnprintf(NULL, 0, f, tmplist);
> +    va_end(tmplist);
> +    if (len < 0)
> +    {
> +        goto out;
> +    }
>=20=20
> -                {
> -                    const size_t len =3D strlen(s) + strlen(numstr) + 2;
> -                    char *combined =3D (char *) malloc(len);
> -                    check_malloc_return(combined);
> +    size =3D adjust_power_of_2(len + 1);

I am a bit sure why we need to increase the size to the next power of 2
and why len+1 shouldn't be enough

> +    buf =3D gc_malloc(size, false, &gc);
> +    len =3D vsnprintf(buf, size, f, arglist);
> +    if (len < 0 || len >=3D size)
> +    {
> +        goto out;
> +    }


This vnsprintf should need the same space as the previous vsnprintf that
was used to determine len.

>=20=20
> -                    strcpy(combined, s);
> -                    strcat(combined, "/");
> -                    strcat(combined, numstr);
> -                    argv_append(a, combined);
> -                }
> -            }
> -            else if (!strcmp(term, "%s%sc"))
> -            {
> -                char *s1 =3D va_arg(arglist, char *);
> -                char *s2 =3D va_arg(arglist, char *);
> -                char *combined;
> +    /* split the string at the delimiters */
> +    end =3D strchr(buf, delim);
> +    while (end)
> +    {
> +        *end =3D '\0';
> +        argv_append(a, string_alloc(buf, NULL));
> +        buf =3D end + 1;
> +        end =3D strchr(buf, delim);
> +    }
> +    argv_append(a, string_alloc(buf, NULL));
>=20=20
> -                if (!s1)
> -                {
> -                    s1 =3D "";
> -                }
> -                if (!s2)
> -                {
> -                    s2 =3D "";
> -                }
> -                combined =3D (char *) malloc(strlen(s1) + strlen(s2) + 1=
);
> -                check_malloc_return(combined);
> -                strcpy(combined, s1);
> -                strcat(combined, s2);
> -                argv_append(a, combined);
> -            }
> -            else
> -            {
> -                ASSERT(0);
> -            }
> -            free(term);
> -        }
> -        else
> -        {
> -            argv_append(a, term);
> -        }
> +    if (a->argc !=3D argc)
> +    {
> +        /* Someone snuck in a GS (0x1D), fail gracefully */
> +        argv_reset(a);
> +        argv_extend(a, 1); /* ensure trailing NULL */
> +        goto out;
>      }

That is a bit weird way to check that but okay.


> -void
> +
> +
> +bool
>  argv_printf(struct argv *a, const char *format, ...)
>  {
> +    bool res;
>      va_list arglist;
> -    argv_reset(a);
> +
>      va_start(arglist, format);
> -    argv_printf_arglist(a, format, arglist);
> +    argv_reset(a);
> +    res =3D argv_printf_arglist(a, format, arglist);
>      va_end(arglist);
> +    return res;
>  }

The bool definition could be made inline (bool res=3D).




> -void
> +bool
>  argv_printf_cat(struct argv *a, const char *format, ...)
>  {
> +    bool res;
>      va_list arglist;
>      va_start(arglist, format);
> -    argv_printf_arglist(a, format, arglist);
> +    res =3D argv_printf_arglist(a, format, arglist);
>      va_end(arglist);
> +    return res;
>  }

Same here.


Rest looks good.

Arne


--MpJyRMkIBSpViqEs45nsDx7fwmDJCcNwJ--

--0V0w45NWDtMGTkZzgwMqba9dTTBL0D5xt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlv8IcwACgkQFRhsZwKx
RFRDpBAAriFfRCBZ6dsBT6+cUx9Q08jNiYps1s4P6ds7TCqLKsILd0ZAomNYoea/
9qyYYA5pPQ82lvFGK962RNdnPmkSdLB1K/d/igzUCTdxABDfzunk+fqWzkiOiR0R
vcV05Kk4coBcnAfsAEEeJwrix8cq4PsfOnp/Vn+fEOZ27pl0rx3j9G8Ge5545lSn
8Yk5/Aaw0r7OdMJtYCNI8RhsHZZl5FLBCIiiBDR0Wf739/+VC46urrhC/gyzTibe
HFdku6vnnU5p+rNQCwrv1Kau1W1wL28TcP7dFRGYp/wuIlk2LZux6yCgE5ajR8t7
nRMT2vmJfOsogUUDFbqT7jreJBzF7FRqWrAwXO+07jbWkoN68Jo9ccthtJ5ghhMg
WsOo5S2Uodl/S3Q3uGzXmmNofsEpu5jTCnbSytmz2GOIQYBV0UTbrWLr7ggVt8Wi
xEq6iuzU59shmIX81mqskP5RWlLyy5IJ8JoxwWTDpAf+VeUdy3vsGbHRV6fzZApB
U9v1wGe5+z0mTtTbDXLDcPSmbUlg0jQFokCgsB170oEJfgoBUYMyiwUDM0zpx6fY
LS+4sIFmv5iiTgJvyQZyVOza9lJN1UOQksRiQGm/eZHLqH2Mty36fr3jyaAt3MQi
7Ja+IS+rN2JOIjCnAPHilAI+BMHoS5TCh/VhtcSIQOOTxLPCEus=
=kxMs
-----END PGP SIGNATURE-----

--0V0w45NWDtMGTkZzgwMqba9dTTBL0D5xt--

