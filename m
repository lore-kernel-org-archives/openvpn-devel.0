Reply-To: openvpn-devel@lists.sourceforge.net
References: <1477672963-5724-6-git-send-email-heiko.hund@...1489...>
 <20171112082435.15447-1-heiko.hund@...1489...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <1700099c-a320-ca5d-384d-cdc35f3e4153@...2080...>
Date: Mon, 13 Nov 2017 12:49:27 +0100
MIME-Version: 1.0
In-Reply-To: <20171112082435.15447-1-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cP54RnmJbl0Ku4MIFAU2Vpj8VViuX69Qx"
Subject: Re: [Openvpn-devel] [PATCHv2 5/7] re-implement argv_printf_*()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cP54RnmJbl0Ku4MIFAU2Vpj8VViuX69Qx
Content-Type: multipart/mixed; boundary="Kh5Rmc4PoBqlA18VaJSOrRqp1C7iGd1Rh";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Heiko Hund <heiko.hund@...1489...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <1700099c-a320-ca5d-384d-cdc35f3e4153@...2080...>
Subject: Re: [Openvpn-devel] [PATCHv2 5/7] re-implement argv_printf_*()
References: <1477672963-5724-6-git-send-email-heiko.hund@...1489...>
 <20171112082435.15447-1-heiko.hund@...1489...>
In-Reply-To: <20171112082435.15447-1-heiko.hund@...1489...>

--Kh5Rmc4PoBqlA18VaJSOrRqp1C7iGd1Rh
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hey,

Thanks a lot for putting a renewed effort into this.  I've reviewed
this and compile tested with GCC 4.8.5, 6.3.1 and 7.2.1 - as there
are some warnings appearing; I'll come back to them in a bit.

On 12/11/17 09:24, Heiko Hund wrote:
> The previous implementation had the problem that it was not fully
> compatible with printf() and could only detect % format directives
> following a space character (0x20).
>=20
> It modifies the format string and inserts marks to separate groups
> before passing it to the regular printf in libc. The marks are
> later used to separate the output string into individual command
> line arguments.
>=20
> The choice of 035 as the argument delimiter is based on the

Perhaps we should use the hex notation (0x1D) instead of the octal
notation (035).  The octal notation is just so similar to decimal
notation and the leading 0 is quite a critical difference.

> assumption that no "regular" string passed to argv_printf_*() will
> ever have to contain that byte (and the fact that it actually is
> the ASCII "group separator" control character, which fits its
> purpose).
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/argv.c                   | 253 ++++++++++++++++-------------=
------
>  src/openvpn/argv.h                   |   4 +-
>  src/openvpn/route.c                  |   8 +-
>  src/openvpn/tun.c                    |  24 ++--
>  tests/unit_tests/openvpn/test_argv.c |  58 +++++++-
>  5 files changed, 184 insertions(+), 163 deletions(-)
>=20
> diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
> index 95bdfeac..afe8efff 100644
> --- a/src/openvpn/argv.c
> +++ b/src/openvpn/argv.c

[...snip...]

>=20=20
> -static void
> -argv_printf_arglist(struct argv *a, const char *format, va_list arglist)
> +/*
> + * argv_prep_format - prepare argv format string for further processing
> + *
> + * Individual argument must be separated by space. Ignores leading and t=
railing spaces.
> + * Consecutive spaces count as one. Returns prepared format string, with=
 space replaced
> + * by delim and adds the number of arguments to the count parameter.
> + */

Could we make this comment proper Doxygen?  (As well as adding similar thin=
gs for the other functions as well?)

> +static char *
> +argv_prep_format(const char *format, const char delim, size_t *count, st=
ruct gc_arena *gc)
>  {

[...snip...]

> +
> +        if (!in_token)
>          {
> -            argv_append(a, term);
> +            ++*count;
> +            if (f[0]) /* not after leading spaces */

This comment still confuses me :-/

Would this be a correct understanding?

  /*
   * We don't add any delimiter (group separator)
   * to the resulting format string before something
   * has been added there.  The resulting format
   * string will never start with a delimiter.
   */

> +            {
> +                f[j++] =3D delim;
> +            }
>          }
> +
> +        f[j++] =3D format[i];
> +        in_token =3D true;
>      }
> +
> +    return f;
>  }
>=20=20
> -void
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
> +argv_printf_arglist(struct argv *a, const char *format, va_list arglist)
> +{
> +    struct gc_arena gc =3D gc_new();
> +    const char *delim =3D 035;

argv.c:217:25: warning: initialization makes pointer from integer without a=
 cast [-Wint-conversion]
     const char *delim =3D 035;

argv.c:227:34: warning: passing argument 2 of =E2=80=98argv_prep_format=E2=
=80=99 makes integer from pointer without a cast [-Wint-conversion]
     f =3D argv_prep_format(format, delim, &argc, &gc);
                                  ^~~~~
argv.c:170:1: note: expected =E2=80=98char=E2=80=99 but argument is of type=
 =E2=80=98const char *=E2=80=99
 argv_prep_format(const char *format, const char delim, size_t *count, stru=
ct gc_arena *gc)
 ^~~~~~~~~~~~~~~~
argv.c:251:23: warning: passing argument 2 of =E2=80=98strchr=E2=80=99 make=
s integer from pointer without a cast [-Wint-conversion]
     end =3D strchr(buf, delim);
                       ^~~~~
In file included from /usr/include/sys/un.h:37:0,
                 from syshead.h:88,
                 from argv.c:36:
/usr/include/string.h:232:14: note: expected =E2=80=98int=E2=80=99 but argu=
ment is of type =E2=80=98const char *=E2=80=99
 extern char *strchr (const char *__s, int __c)
              ^~~~~~
argv.c:257:27: warning: passing argument 2 of =E2=80=98strchr=E2=80=99 make=
s integer from pointer without a cast [-Wint-conversion]
         end =3D strchr(buf, delim);
                           ^~~~~
In file included from /usr/include/sys/un.h:37:0,
                 from syshead.h:88,
                 from argv.c:36:
/usr/include/string.h:232:14: note: expected =E2=80=98int=E2=80=99 but argu=
ment is of type =E2=80=98const char *=E2=80=99
 extern char *strchr (const char *__s, int __c)
              ^~~~~~


Shouldn't *delim be just delim?  I'd propose using:

   const char delim =3D 0x1D;  /* ASCII group separator character */

This also kills all the warnings above.


> +    char *f, *buf, *end;
> +    size_t argc, size;
> +    bool res =3D false;
> +    va_list tmplist;
> +    int len;
> +
> +    argv_extend(a, 1); /* ensure trailing NULL */
> +
> +    argc =3D a->argc;
> +    f =3D argv_prep_format(format, delim, &argc, &gc);
> +    if (f =3D=3D NULL)
> +    {
> +        goto out;
> +    }
> +
> +    /* determine minimum buffer size */
> +    va_copy(tmplist, arglist);
> +    len =3D vsnprintf(NULL, 0, f, tmplist);
> +    va_end(tmplist);
> +    if (len < 0)
> +    {
> +        goto out;
> +    }
> +
> +    size =3D adjust_power_of_2(len + 1);
> +    buf =3D gc_malloc(size, false, &gc);
> +    len =3D vsnprintf(buf, size, f, arglist);
> +    if (len < 0 || len >=3D size)
> +    {
> +        goto out;
> +    }
> +
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
> +
> +    if (a->argc !=3D argc)
> +    {
> +        /* Someone snuck in a \035, fail gracefully */

I'd prefer 0x1D here too.

> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 8c71e6ec..02f7299f 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -1614,7 +1614,7 @@ add_route(struct route_ipv4 *r,
>  #elif defined (_WIN32)
>      {
>          DWORD ai =3D TUN_ADAPTER_INDEX_INVALID;
> -        argv_printf(&argv, "%s%sc ADD %s MASK %s %s",
> +        argv_printf(&argv, "%s%s ADD %s MASK %s %s",

[...snip... comment to follow ....]

> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 25831ce3..61d6b9eb 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -1565,7 +1565,7 @@ do_ifconfig(struct tuntap *tt,
>                  char iface[64];
>                  openvpn_snprintf(iface, sizeof(iface), "interface=3D%lu"=
, tt->adapter_index );
>                  argv_printf(&argv,
> -                            "%s%sc interface ipv6 set address %s %s stor=
e=3Dactive",
> +                            "%s%s interface ipv6 set address %s %s store=
=3Dactive",

Even though these changes from %sc to %s are no-brainers; I wonder if we sh=
ould try
to trick our buildbot to test these changes on all platforms we have there =
before
pushing it out.


> diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/open=
vpn/test_argv.c
> index 4a3ba559..a09e92fb 100644
> --- a/tests/unit_tests/openvpn/test_argv.c
> +++ b/tests/unit_tests/openvpn/test_argv.c

[...snip...]
>  static void
> +argv_printf__empty_parameter__argc_correct(void **state)
> +{
> +    struct argv a =3D argv_new();
> +
> +    argv_printf(&a, "%s", "");
> +    assert_int_equal(a.argc, 1);
> +
> +    argv_printf(&a, "%s %s", PATH1, "");
> +    assert_int_equal(a.argc, 2);
> +
> +    argv_printf(&a, "%s %s %s", PATH1, "", PARAM1);
> +    assert_int_equal(a.argc, 3);
> +
> +    argv_printf(&a, "%s %s %s %s", PATH1, "", "", PARAM1);
> +    assert_int_equal(a.argc, 4);
> +
> +    argv_printf(&a, "%s %s", "", PARAM1);
> +    assert_int_equal(a.argc, 2);
> +
> +    argv_free(&a);

This gives another warning:

est_argv.c: In function =E2=80=98argv_printf__empty_parameter__argc_correct=
=E2=80=99:
test_argv.c:117:5: warning: implicit declaration of function =E2=80=98argv_=
free=E2=80=99; did you mean =E2=80=98argv_reset=E2=80=99? [-Wimplicit-funct=
ion-declaration]
     argv_free(&a);
     ^~~~~~~~~
     argv_reset

This stops the build of argv_testdriver.  Changing it to argv_reset() compl=
etes
and runs the unit test.

> +}

[...snip...]

I'm also getting this warning:

test_argv.c:174:1: warning: =E2=80=98argv_insert_head__empty_argv__head_onl=
y=E2=80=99 defined but not used [-Wunused-function]
 argv_insert_head__empty_argv__head_only(void **state)


Otherwise, this patch looks reasonable and good to me.  And it passes 'make=
 check'
when fixing those various warnings mentioned above


--=20
kind regards,

David Sommerseth
OpenVPN, Inc



--Kh5Rmc4PoBqlA18VaJSOrRqp1C7iGd1Rh--

--cP54RnmJbl0Ku4MIFAU2Vpj8VViuX69Qx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaCYbKAAoJEIbPlEyWcf3yNHwQAIPvYq0/eL8C30rsmCY0SuGj
3N/toeexmAF0NU0Lr+sRTblYt/SFNyl9PWIQkl/DhkIuetVKsnrLT8aEkEy5cCdR
wMRg33NwhOnOyQOOewirR14E5tOrOfezm+l2Y0Bhh2XGtOHGc9jyo+9tLd8zL/EA
z0iD6uiPjdC3QwQ9uls6dOiclqv2Ql7aKjJUzTa1eARtyKxhxkVp7QknGqAAndxu
FRbh/MSlwBwkC7qIRuUVuygtG20c+d+B/dVr5uYXDg7NtTLaRk69KRsICHzksi9E
uVcQmdbsBr/ZqlFblUGr9F54YIG0fgoluyNgdcRgOxtp6gjh6CbAcz7AWSbixdxc
WXZ696+1dfDqqfYNljZWn6yhnR5VX7P/4U5cnByhehJO2+VOsRO3xN1qlta27Xkf
zRtvrZMEKbUrABheGjzHN3VJfy1RZXYfYsYqaMyz/8xShGxeOtvg0RA4vWRNWHOZ
4ByVBvlTVKG39I30g9KVQMmTtADrT/uCXFHcJCrporbtwhfYE14LJ7LpeDK3F/sz
fONj9tsPz2HcWm6lQSOjjs/RFP3iZu9sMuHK/uhN46nbOiWPK3LBnkwbcsFt73NF
xtaEsrVoOAPAYqmfR3jmY5hWvSZqjBf7q6uKKDEoKOCloFjB19cPkWV6cFRUapUP
qpuHHWWzFPZaxp5a6VTH
=j9D8
-----END PGP SIGNATURE-----

--cP54RnmJbl0Ku4MIFAU2Vpj8VViuX69Qx--

