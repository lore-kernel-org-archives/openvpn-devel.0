Reply-To: openvpn-devel@lists.sourceforge.net
References: <1477672963-5724-8-git-send-email-heiko.hund@...1489...>
 <20171112083403.15922-1-heiko.hund@...1489...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <987ebe39-3845-7b96-c884-a202464027cf@...2080...>
Date: Mon, 13 Nov 2017 13:42:26 +0100
MIME-Version: 1.0
In-Reply-To: <20171112083403.15922-1-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kCwJmrQLAa3T7apBMB63hB0t5GhvrauWM"
Subject: Re: [Openvpn-devel] [PATCHv2 7/7] Add gc_arena to struct argv to
 save allocations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kCwJmrQLAa3T7apBMB63hB0t5GhvrauWM
Content-Type: multipart/mixed; boundary="Q7OeW48CQ0lBHoPp7k0fwdV34dwTggV2d";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net
Message-ID: <987ebe39-3845-7b96-c884-a202464027cf@...2080...>
Subject: Re: [Openvpn-devel] [PATCHv2 7/7] Add gc_arena to struct argv to save
 allocations
References: <1477672963-5724-8-git-send-email-heiko.hund@...1489...>
 <20171112083403.15922-1-heiko.hund@...1489...>
In-Reply-To: <20171112083403.15922-1-heiko.hund@...1489...>

--Q7OeW48CQ0lBHoPp7k0fwdV34dwTggV2d
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 12/11/17 09:34, Heiko Hund wrote:
> With the private gc_arena we do not have to allocate the strings
> found during parsing again, since we know the arena they are
> allocated in is valid as long as the argv vector is.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/argv.c                   | 44 ++++++++++++++++--------------=
------
>  src/openvpn/argv.h                   |  1 +
>  tests/unit_tests/openvpn/test_argv.c | 23 +++++++++++++++++++
>  3 files changed, 43 insertions(+), 25 deletions(-)
>=20
> diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
> index 419b1dc6..51dd1b22 100644
> --- a/src/openvpn/argv.c
> +++ b/src/openvpn/argv.c
> @@ -46,12 +46,11 @@ argv_extend(struct argv *a, const size_t newcap)
>      {
>          char **newargv;
>          size_t i;
> -        ALLOC_ARRAY_CLEAR(newargv, char *, newcap);
> +        ALLOC_ARRAY_CLEAR_GC(newargv, char *, newcap, &a->gc);

Ahh!  Here it is :)  Disregard my comment about this in PATCH v2 6/7 :)


>          for (i =3D 0; i < a->argc; ++i)
>          {
>              newargv[i] =3D a->argv[i];
>          }
> -        free(a->argv);
>          a->argv =3D newargv;
>          a->capacity =3D newcap;
>      }
> @@ -63,6 +62,7 @@ argv_init(struct argv *a)
>      a->capacity =3D 0;
>      a->argc =3D 0;
>      a->argv =3D NULL;
> +    a->gc =3D gc_new();
>      argv_extend(a, 8);
>  }
>=20=20
> @@ -77,24 +77,21 @@ argv_new(void)
>  void
>  argv_free(struct argv *a)
>  {
> -    size_t i;
> -    for (i =3D 0; i < a->argc; ++i)
> -    {
> -        free(a->argv[i]);
> -    }
> -    free(a->argv);
> +    gc_free(&a->gc);
>  }
>=20=20
>  static void
>  argv_reset(struct argv *a)
>  {
> -    size_t i;
> -    for (i =3D 0; i < a->argc; ++i)
> +    if (a->argc)
>      {
> -        free(a->argv[i]);
> -        a->argv[i] =3D NULL;
> +        size_t i;
> +        for (i =3D 0; i < a->argc; ++i)
> +        {
> +            a->argv[i] =3D NULL;
> +        }
> +        a->argc =3D 0;
>      }
> -    a->argc =3D 0;
>  }
>=20=20
>  static void
> @@ -106,7 +103,7 @@ argv_grow(struct argv *a, const size_t add)
>  }
>=20=20
>  static void
> -argv_append(struct argv *a, char *str)  /* str must have been malloced o=
r be NULL */
> +argv_append(struct argv *a, char *str)  /* str must have been gc_malloce=
d or be NULL */
>  {
>      argv_grow(a, 1);
>      a->argv[a->argc++] =3D str;
> @@ -127,7 +124,7 @@ argv_clone(const struct argv *a, const size_t headroo=
m)
>      {
>          for (i =3D 0; i < a->argc; ++i)
>          {
> -            argv_append(&r, string_alloc(a->argv[i], NULL));
> +            argv_append(&r, string_alloc(a->argv[i], &r.gc));
>          }
>      }
>      return r;
> @@ -138,7 +135,7 @@ argv_insert_head(const struct argv *a, const char *he=
ad)
>  {
>      struct argv r;
>      r =3D argv_clone(a, 1);
> -    r.argv[0] =3D string_alloc(head, NULL);
> +    r.argv[0] =3D string_alloc(head, &r.gc);
>      return r;
>  }
>=20=20
> @@ -243,7 +240,7 @@ argv_printf_arglist(struct argv *a, const char *forma=
t, va_list arglist)
>      }
>=20=20
>      size =3D adjust_power_of_2(len + 1);
> -    buf =3D gc_malloc(size, false, &gc);
> +    buf =3D gc_malloc(size, false, &a->gc);
>      len =3D vsnprintf(buf, size, f, arglist);
>      if (len < 0 || len >=3D size)
>      {
> @@ -255,11 +252,11 @@ argv_printf_arglist(struct argv *a, const char *for=
mat, va_list arglist)
>      while (end)
>      {
>          *end =3D '\0';
> -        argv_append(a, string_alloc(buf, NULL));
> +        argv_append(a, buf);
>          buf =3D end + 1;
>          end =3D strchr(buf, delim);
>      }
> -    argv_append(a, string_alloc(buf, NULL));
> +    argv_append(a, buf);
>=20=20
>      if (a->argc !=3D argc)
>      {
> @@ -303,23 +300,20 @@ argv_parse_cmd(struct argv *a, const char *s)
>  {
>      int nparms;
>      char *parms[MAX_PARMS + 1];
> -    struct gc_arena gc =3D gc_new();
>=20=20
>      argv_reset(a);
>=20=20
> -    nparms =3D parse_line(s, parms, MAX_PARMS, "SCRIPT-ARGV", 0, D_ARGV_=
PARSE_CMD, &gc);
> +    nparms =3D parse_line(s, parms, MAX_PARMS, "SCRIPT-ARGV", 0, D_ARGV_=
PARSE_CMD, &a->gc);
>      if (nparms)
>      {
>          int i;
>          for (i =3D 0; i < nparms; ++i)
>          {
> -            argv_append(a, string_alloc(parms[i], NULL));
> +            argv_append(a, parms[i]);
>          }
>      }
>      else
>      {
> -        argv_append(a, string_alloc(s, NULL));
> +        argv_append(a, string_alloc(s, &a->gc));
>      }
> -
> -    gc_free(&gc);
>  }
> diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
> index 2a1945e3..a1aa7ebb 100644
> --- a/src/openvpn/argv.h
> +++ b/src/openvpn/argv.h
> @@ -33,6 +33,7 @@
>  #include "buffer.h"
>=20=20
>  struct argv {
> +    struct gc_arena gc;
>      size_t capacity;
>      size_t argc;
>      char **argv;
> diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/open=
vpn/test_argv.c
> index e15e2fe5..5bfef8af 100644
> --- a/tests/unit_tests/openvpn/test_argv.c
> +++ b/tests/unit_tests/openvpn/test_argv.c
> @@ -118,6 +118,28 @@ argv_printf__empty_parameter__argc_correct(void **st=
ate)
>  }
>=20=20
>  static void
> +argv_printf__long_args__data_correct(void **state)
> +{
> +    int i;
> +    struct argv a =3D argv_new();
> +    const char *args[] =3D {
> +        "good_tools_have_good_names_even_though_it_might_impair_typing",
> +        "--long-opt=3Dlooooooooooooooooooooooooooooooooooooooooooooooooo=
ng",
> +        "--long-cat=3Dlooooooooooooooooooooooooooooooooooooooooooooooooo=
ooonger",
> +        "file_with_very_descriptive_filename_that_leaves_no_questions_op=
en.jpg.exe"
> +    };
> +
> +    argv_printf(&a, "%s %s %s %s", args[0], args[1], args[2], args[3]);
> +    assert_int_equal(a.argc, 4);
> +    for (i =3D 0; i < a.argc; i++)
> +    {
> +        assert_string_equal(a.argv[i], args[i]);
> +    }
> +
> +    argv_free(&a);
> +}
> +
> +static void
>  argv_parse_cmd__command_string__argc_correct(void **state)
>  {
>      struct argv a =3D argv_new();
> @@ -233,6 +255,7 @@ main(void)
>          cmocka_unit_test(argv_printf__group_sep_in_arg__fail_no_ouput),
>          cmocka_unit_test(argv_printf__combined_path_with_spaces__argc_co=
rrect),
>          cmocka_unit_test(argv_printf__empty_parameter__argc_correct),
> +        cmocka_unit_test(argv_printf__long_args__data_correct),
>          cmocka_unit_test(argv_parse_cmd__command_string__argc_correct),
>          cmocka_unit_test(argv_parse_cmd__command_and_extra_options__argc=
_correct),
>          cmocka_unit_test(argv_printf_cat__used_twice__argc_correct),
>=20

Only glared at these changes.  They make sense and the Acked-By is not
far away at all!  Just want to run some build tests with the other final
patches in place first.


--=20
kind regards,

David Sommerseth
OpenVPN, Inc



--Q7OeW48CQ0lBHoPp7k0fwdV34dwTggV2d--

--kCwJmrQLAa3T7apBMB63hB0t5GhvrauWM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaCZMzAAoJEIbPlEyWcf3ygQMP/1tIlyKbULSNkTpFur2G5qda
Gh1fSjAP1Fd9sr4Qw6AS0C3N7y+o/8LokEJIf2tHzShPe7yqhC3mD6wkZvYNvsD3
GuOdByKkierTG6MpFDjcGB4lcOr/hbJi9SoWU/cg2faZSd8mXnhvc7D3YUofS11s
S/0RQT9X3Ki2vufP1JxmPq6XleTSY5DaK8Uz+RUA4VXGlZlZR2ikNxdFZwy3Qq3u
bXTEPLPyNRmAlH6Fg04mzWoTbu+hZLvWPKYPZl6OOGjuv2v8shT7vSxH1RyKi9gy
lWZjvy5T4A/6w69iBsM7lGP7Dd9wPmW0fSOYrKv9JOWzBlRn73OfxAQCNsVGVuhD
Irj9BHkXDIwmqwdEn69z8MpaRN5a+J91dqOh/Oa13aJhIFM2sz6y+dsjkt1GeWHF
Cn4+mcZqDTEiEjQVf/eetJJ6dltI+xOS8caUGsYrZWq18kI2vG8W6lmmyZ0UqIIb
vyeTRvPVGxM1aCyQWcZDSzjLrVonZOBMUAGiVtQ2R6H1nbRal+2rW8XkSFykAfIC
SKT01YM0Q5PgjrAfpJvQFiwehZViEtUwqBR5Bsw6hjezCt2q/UDyQ7sPJa6/iU+N
Q/30NyuoWGFYC/bCARzrc4hAAirDDYSjV24cMg/BdqNSS1eYT7fOBDTF/cfHNiPI
0e7wOL4lLiijZiNUyVk2
=162u
-----END PGP SIGNATURE-----

--kCwJmrQLAa3T7apBMB63hB0t5GhvrauWM--

