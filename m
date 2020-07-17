References: <20200717170942.227701-1-matthias.andree@...68...>
 <20200717171918.230727-1-matthias.andree@...68...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <36fd1330-3715-e5d4-bed0-8d80c40732c0@...2080...>
Date: Fri, 17 Jul 2020 22:15:21 +0200
MIME-Version: 1.0
In-Reply-To: <20200717171918.230727-1-matthias.andree@...68...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uBerFmJW76yfhaAzsYVC8O2pqOvxrFqtr"
Subject: Re: [Openvpn-devel] [PATCH] Merge Makefile.am's AUTOMAKE_OPTIONS
 into configure.ac's AM_INIT_AUTOMAKE.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uBerFmJW76yfhaAzsYVC8O2pqOvxrFqtr
Content-Type: multipart/mixed; boundary="N3BE6Z30Yq0OoPgSvHeNdEhOe0yZKlOr8";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Matthias Andree <matthias.andree@...68...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <36fd1330-3715-e5d4-bed0-8d80c40732c0@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Merge Makefile.am's AUTOMAKE_OPTIONS into
 configure.ac's AM_INIT_AUTOMAKE.
References: <20200717170942.227701-1-matthias.andree@...68...>
 <20200717171918.230727-1-matthias.andree@...68...>
In-Reply-To: <20200717171918.230727-1-matthias.andree@...68...>

--N3BE6Z30Yq0OoPgSvHeNdEhOe0yZKlOr8
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 17/07/2020 19:19, Matthias Andree wrote:
> Else one location overwrites options from the other.
>=20
> Signed-off-by: Matthias Andree <matthias.andree@...68...>
> ---
>  Makefile.am  | 3 ---
>  configure.ac | 4 +++-
>  2 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/Makefile.am b/Makefile.am
> index 439120e4..d1c10fc5 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -23,9 +23,6 @@
>  #  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  #
>=20
> -# This option prevents autoreconf from overriding our COPYING and
> -# INSTALL targets:
> -AUTOMAKE_OPTIONS =3D foreign 1.9
>  ACLOCAL_AMFLAGS =3D -I m4
>=20
>  MAINTAINERCLEANFILES =3D \
> diff --git a/configure.ac b/configure.ac
> index 45148892..8ed83bc2 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -54,7 +54,9 @@ m4_define([serial_tests], [
>                  awk '{split ($NF,a,"."); if (a[1] =3D=3D 1 && a[2] >=3D =
12) { print "serial-tests" }}'
>      ])
>  ])
> -AM_INIT_AUTOMAKE(foreign serial_tests) dnl NB: Do not [quote] this param=
eter.
> +# This foreign option prevents autoreconf from overriding our COPYING and
> +# INSTALL targets:
> +AM_INIT_AUTOMAKE(foreign serial_tests 1.9) dnl NB: Do not [quote] this p=
arameter.
>  AC_CANONICAL_HOST
>  AC_USE_SYSTEM_EXTENSIONS
>=20

Acked-By: David Sommerseth <davids@...515...>

This works better than the previous attempt, this also passes 'make distche=
ck'.

I see this patch does not have the subdir-objects flag in the automake
options; which seems to be the reason why it failed on my RHEL-7 box last
round.  I'll try to see if I can better understand why.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--N3BE6Z30Yq0OoPgSvHeNdEhOe0yZKlOr8--

--uBerFmJW76yfhaAzsYVC8O2pqOvxrFqtr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfEgbZAAoJEIbPlEyWcf3yPwoQALfwcFcnSuHZvQMEUX8Y4JYZ
siVa9/0BRldAbDReD3fQBPdI4eE2fRm3TuZbom5Z1ITur1vPjhCWvrHXHX98iVwW
MnGk9olv5HdQ/R3iJ40DT02Crs/Kww4igqcLwILU46txE6eBHIcdI9csbilSskTA
a+6E3s/nOKV5d4rA7ueB9Z2KG6vVjUgiYS58RUBaiilG5Yyb3INKu+brGU4TYlRf
ei3dh+qFeO8OVv73jli20l4he3X8ScCIuN1oXr0w7zifSHD2lEQAQpl7CkVt+u6W
szwTZ7Vo+e5H/b/Qxhva3hPrgvMOAA8nozsmVGPn0+fOX9hPNTqVc7Ky1AZKQrLy
TOhztOkMS8VKnbCvcT3Cu4aQZQJSQ+ugzay93kv/CxEbZaUP8Rlxek4btyxXc7Sk
NVyWBb65Ogs+00xfnne1J2b4wm/IIRP18ukyNzwyND0T1+g7wlz9a6tbN+72w12R
zeiDe87MtgQwo/tZO29zKplpxGFZrxsKi5/TaoTMy9PNBY10wK4S+y5MBvRfnniS
XI8zT95CNoSndsOfjGndb0gwZkbLzNjFE3ITtE4G2YQry/m4QLX07dZepZ54cYBB
QdNvY16BYuoCEFpz5mcmviBieHLvfBuhidHODIfw/PniS2R7xImhUoasPIsc0J03
8tejMkekWORSY7MIq3xc
=jFrB
-----END PGP SIGNATURE-----

--uBerFmJW76yfhaAzsYVC8O2pqOvxrFqtr--

