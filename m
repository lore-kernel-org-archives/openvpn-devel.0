Date: Thu, 22 Jun 2017 04:17:53 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170621201753.GA31123@...2287...>
References: <1497872853-1464-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <1497872853-1464-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Move adjust_power_of_2() to integer.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, Jun 19, 2017 at 01:47:33PM +0200, Steffan Karger wrote:
> misc.c it a mess of incoherent functions, and is therefore included by

little typ0 here: s/it/is/

> virtually all our source files.  That makes testing harder than it should
> be.  As a first step of cleaning up misc.c, move adjust_power_of_2() to
> integer.h, which is a more suitable place for a function like this.
>=20
> This allows us to remove the duplicate implementation from test_argv.c.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  src/openvpn/integer.h                | 17 +++++++++++++++++
>  src/openvpn/misc.c                   | 18 ------------------
>  src/openvpn/misc.h                   |  2 --
>  tests/unit_tests/openvpn/test_argv.c | 19 +------------------
>  4 files changed, 18 insertions(+), 38 deletions(-)
>=20
> diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
> index 240781b..882322a 100644
> --- a/src/openvpn/integer.h
> +++ b/src/openvpn/integer.h
> @@ -118,6 +118,23 @@ modulo_add(int x, int y, int mod)
>      return sum;
>  }
>=20=20
> +/*
> + * Return the next largest power of 2
> + * or u if u is a power of 2.
> + */
> +static inline size_t adjust_power_of_2(size_t u)
> +{
> +    size_t ret =3D 1;
> +
> +    while (ret < u)
> +    {
> +        ret <<=3D 1;
> +        ASSERT(ret > 0);
> +    }
> +
> +    return ret;
> +}
> +
>  static inline int
>  index_verify(int index, int size, const char *file, int line)
>  {
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index df108b0..561f80f 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -1641,24 +1641,6 @@ openvpn_sleep(const int n)
>  }
>=20=20
>  /*
> - * Return the next largest power of 2
> - * or u if u is a power of 2.
> - */
> -size_t
> -adjust_power_of_2(size_t u)
> -{
> -    size_t ret =3D 1;
> -
> -    while (ret < u)
> -    {
> -        ret <<=3D 1;
> -        ASSERT(ret > 0);
> -    }
> -
> -    return ret;
> -}
> -
> -/*
>   * Remove security-sensitive strings from control message
>   * so that they will not be output to log file.
>   */
> diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
> index 94573b2..f55186f 100644
> --- a/src/openvpn/misc.h
> +++ b/src/openvpn/misc.h
> @@ -325,8 +325,6 @@ extern const char *iproute_path;
>  #define SSEC_PW_ENV    3 /* allow calling of built-in programs and user-=
defined scripts that may receive a password as an environmental variable */
>  extern int script_security; /* GLOBAL */
>=20=20
> -/* return the next largest power of 2 */
> -size_t adjust_power_of_2(size_t u);
>=20=20
>  #define COMPAT_FLAG_QUERY         0       /** compat_flags operator: Que=
ry for a flag */
>  #define COMPAT_FLAG_SET           (1<<0)  /** compat_flags operator: Set=
 a compat flag */
> diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/open=
vpn/test_argv.c
> index 8c90eb9..c5ebc09 100644
> --- a/tests/unit_tests/openvpn/test_argv.c
> +++ b/tests/unit_tests/openvpn/test_argv.c
> @@ -12,24 +12,7 @@
>=20=20
>  #include "argv.h"
>  #include "buffer.h"
> -
> -/*
> - * This is defined here to prevent #include'ing misc.h
> - * which makes things difficult beyond any recognition
> - */
> -size_t
> -adjust_power_of_2(size_t u)
> -{
> -    size_t ret =3D 1;
> -
> -    while (ret < u)
> -    {
> -        ret <<=3D 1;
> -        assert(ret > 0);
> -    }
> -
> -    return ret;
> -}
> +#include "integer.h"

This duplication was really ugly :-P Thanks for getting rid of it.

However, now that adjust_power_of_2() has been moved to integer.h, shouldn't
this file be included by every .c where the function is used? Or do we have=
 some
other rule about header files inclusion?

Personally I prefer when every .c file directly includes the .h it relies o=
n,
without assuming any indirect inclusion. What's the common habit here?


Cheers,


>=20=20
>  /* Defines for use in the tests and the mock parse_line() */
>  #define PATH1       "/s p a c e"
> --=20
> 2.7.4
>=20

--=20
Antonio Quartulli

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAllK1G4ACgkQ0+HICM1s
oFDQZRAAmiPUpmdqBjj/GuKOtYkBJdqIVWiK/7EoaMXBtcwHS+OEuZ4YQXYJooTJ
+PaCYSfd5HY73LNuuMSxRsHSiuUCtzA0hg4SiMyOttRtylkL5eiMia7ApeINlus8
RT392Bs9zEsWQtuT21d4QhxlvxkwcHjJA/UzbwF2HoRjA/iCsWkaLHneNXPrewL4
KFpTdWJ0dU2FtuBePrPcwhVlKBMZYgDqupH7EVUxMjt6hpqlhJo4Ogi3sh+bNSHR
N2/zGTURLSzP+K8U771MWkvxRqoYsiwZDOkwIxwOFwDZZeQ/26lo89KcNdWZy+eC
mW4053ZSVrRkmwtJA4GCDK7+d9Sullnt0zPI3kWnnfz6u7MeW6t/QWLAlXf1MFxp
GFT3SZVHTlHV7mVbk1HRnPiYdakGyrvZH8CqbO1fSNEwwLmYARepuxA2ixIRKSow
XUvsmMjV+MyvU+1eLwY+a1BGEB4FMbZEb2I45h38llr567Sd7yJw4r1nyGlcRBwU
pkgqSejMvl/H65vxGzOjCAQKfuATN8uUh8B8dU2MsT9oKW3tc/GLwo9jc1Ms/Shh
PoVC/0Oior4hnb0nbzf11tHIHvCxvMjoPLdhTcfy7VWZBSEpV18in7sGEhAGNuSJ
Gs9J+OudkmoKZ7HTLpwaczfM3aRQ6p68YvjYmRiginprcMjqJMc=
=YXPa
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

