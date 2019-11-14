References: <1573760407-20662-1-git-send-email-selva.nair@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <108f5ba4-240b-5496-f37b-51ff2a6fb2fe@...2080...>
Date: Thu, 14 Nov 2019 22:31:20 +0100
MIME-Version: 1.0
In-Reply-To: <1573760407-20662-1-git-send-email-selva.nair@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1oMOSnVwjtDf9guETjYGUS2I7nrTkNJAD"
Subject: Re: [Openvpn-devel] [PATCH] Fix ACL_CHECK_ADD_COMPILE_FLAGS to work
 with clang
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1oMOSnVwjtDf9guETjYGUS2I7nrTkNJAD
Content-Type: multipart/mixed; boundary="uNyzFkdYFJTodP7YVkxSxMyq572QckKOO";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <108f5ba4-240b-5496-f37b-51ff2a6fb2fe@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Fix ACL_CHECK_ADD_COMPILE_FLAGS to work
 with clang
References: <1573760407-20662-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1573760407-20662-1-git-send-email-selva.nair@...277...>

--uNyzFkdYFJTodP7YVkxSxMyq572QckKOO
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 14/11/2019 20:40, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> Some compilers (e.g., clang) only issue a warning for
> unsupported options unless additional flags such
> as -Werror are used to convert the warning to an error.
>=20
> Add support for extra flags in ACL_CHECK_ADD_COMPILE_FLAGS.
>=20
> Note: a similar approach is used in AX_CHECK_COMPILE_FLAG
> in autoconf archives.

I'm glad I didn't spend more time on thinking about this earlier today, as =
you
have almost the same ideas as I had :)

[...snip...]
>=20=20
> +# Usage: ACL_CHECK_ADD_COMPILE_FLAGS(flag, [extra-flags])
> +# Some compilers require extra flags to trigger an error on
> +# unsupported options. E.g., clang requires -Werror.
>  AC_DEFUN([ACL_CHECK_ADD_COMPILE_FLAGS], [
>      old_cflags=3D"$CFLAGS"
> -    CFLAGS=3D"$1 $CFLAGS"
> -    AC_MSG_CHECKING([whether the compiler acceppts $1])
> -    AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [AC_MSG_RESULT([yes])],
> +    CFLAGS=3D"$2 $1 $CFLAGS"
> +    AC_MSG_CHECKING([whether the compiler accepts $1])
> +    AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [AC_MSG_RESULT([yes])]; CFLAG=
S=3D"$1 $old_cflags",

My idea was just to add -Werror right in the line above, and not extend the
ACL_CHECK_ADD_COMPILE_FLAGS macro with another argument.

But I stopped when I realized that GCC has some quirks as well, as I needed=
 to
ponder about this a bit.

Clang is fairly consistent:

* first with an unknown -Wno-* argument

$ clang-6.0 -o test test.c -Wall -Wno-non-existing-flag
warning: unknown warning option '-Wno-non-existing-flag'; did you mean
      '-Wno-non-virtual-dtor'? [-Wunknown-warning-option]

$ clang-6.0 -o test test.c -Wall -Wno-non-existing-flag  -Werror
error: unknown warning option '-Wno-non-existing-flag'; did you mean
      '-Wno-non-virtual-dtor'? [-Werror,-Wunknown-warning-option]

* then with an unknown -W* argument (without the no- prefix)

$ clang-6.0 -o test test.c -Wall -Wnon-existing-flag
warning: unknown warning option '-Wnon-existing-flag'; did you mean
      '-Wnon-virtual-dtor'? [-Wunknown-warning-option]

$ clang-6.0 -o test test.c -Wall -Wnon-existing-flag  -Werror
error: unknown warning option '-Wnon-existing-flag'; did you mean
      '-Wnon-virtual-dtor'? [-Werror,-Wunknown-warning-option]

This is consistent and I can live with this behavior, using -Werror to bail
out on warnings.

So lets running the same tests with GCC:

* first with an unknown -Wno-* argument

$ gcc -o test test.c -Wall -Wno-non-existing-flag
(no error nor warning)

$ gcc -o test test.c -Wall -Wno-non-existing-flag -Werror
(no error nor warning)

* then with an unknown -W* argument (without the no- prefix)

$ gcc -o test test.c -Wall -Wnon-existing-flag
gcc: error: unrecognized command line option =E2=80=98-Wnon-existing-flag=
=E2=80=99


I think you said it pretty well in your mail:

> Darn compilers and darn -Werror


So your change does improve Clang ... I dunno what we will do with GCC.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--uNyzFkdYFJTodP7YVkxSxMyq572QckKOO--

--1oMOSnVwjtDf9guETjYGUS2I7nrTkNJAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJdzceoAAoJEIbPlEyWcf3yUQ4P/3fASneIQTxdrasx8NGt44T/
w4Nfj0mGn3bg2Iy7nJ0UN4G2o8jKjaRNHueujC0ZNbOanjfK7MNv7pW9mME1rrVr
s84p1coX8KqKB5wU63OUWYyolReYKjgoSQ8Wm+42Z4Rc5l6aQZUMzTP5JfS2rE8/
TgneuAQj2wjksUSwFquX0+wWi/8s04Sb0KcdGBdLNBuUYpOFNXb9WWuQaN/NmLtt
SjfzOmKUX3lhWpIU1to9cXRh9ZazQ/9jYN3x5o1B1tBX4BosFL13d2YdI/8Qi7kB
XwqQb82usVNJQNpf+YjRO95dm5LY/0N00zXpIEZeHeZkeZS6F4c9EdGXXNJbK/Wx
KSHdH2cGPmE1bcYfF6uB71qshq+6Ps6fyOM4mDh3ikDRI/fcR7ii9Pf+nj6mobhr
2zHFtpJ9arnLa/Cvok/nlIqdgV1yLoZ5tZBTAjPVUdX+sMxmpNZhgct8bIhZsLot
SnTb0VDHF6z7LEDcgd5XorMxlXUKkqPZKCY8cIubHs01tAd8dvIyps3Cxp55Njnd
yZ5esrYbjqr9HDd6v0XuPmgcUwAUsGDtMxNrYGAGiNm/7ZZx5vEuIJiAfWkjUZd5
0ZNnglNznTzB097nCEmTL2VjSWl2eFg375ss6PjKhmyOSFZ+Es0da+3e0zp0OIfo
n2JeCHJFO4Et4PVVr7/s
=Y6yK
-----END PGP SIGNATURE-----

--1oMOSnVwjtDf9guETjYGUS2I7nrTkNJAD--

