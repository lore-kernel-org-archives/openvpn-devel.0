References: <20170824133305.25604-1-a@...2181...>
 <CAFHpkQEJefeuqwbfy638M0AYO4EvcN8tamQQAHfxH-uPDwm=+g@...278...>
 <CAFHpkQHi0==66QDo8zVkktdCS4evKhQBkpkTZLbnt0WPMpXzsQ@...278...>
 <CAFHpkQFfWXACzHXuxXDDHOiZSQRaFro=QJoEcfcSx01Ao-m9iw@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d31c59c4-a512-f335-41fc-e6389915a270@...2181...>
Date: Thu, 24 Aug 2017 22:42:04 +0800
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFfWXACzHXuxXDDHOiZSQRaFro=QJoEcfcSx01Ao-m9iw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FfIhe9xAf2EVaGUw1VuPjnxVmb09e0XBB"
Subject: Re: [Openvpn-devel] [PATCH] bash: substitute legacy `` with modern
 $()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FfIhe9xAf2EVaGUw1VuPjnxVmb09e0XBB
Content-Type: multipart/mixed; boundary="TOcrWhdUaqW0evMUgMf2wlcQl2XUHWP4F";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <d31c59c4-a512-f335-41fc-e6389915a270@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] bash: substitute legacy `` with modern
 $()
References: <20170824133305.25604-1-a@...2181...>
 <CAFHpkQEJefeuqwbfy638M0AYO4EvcN8tamQQAHfxH-uPDwm=+g@...278...>
 <CAFHpkQHi0==66QDo8zVkktdCS4evKhQBkpkTZLbnt0WPMpXzsQ@...278...>
 <CAFHpkQFfWXACzHXuxXDDHOiZSQRaFro=QJoEcfcSx01Ao-m9iw@...278...>
In-Reply-To: <CAFHpkQFfWXACzHXuxXDDHOiZSQRaFro=QJoEcfcSx01Ao-m9iw@...278...>

--TOcrWhdUaqW0evMUgMf2wlcQl2XUHWP4F
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

dev-tools/gen-release-tarballs.sh is only for devs, while
tests/t_cltsrv.sh is for running some tests, but I am not sure sure how
the latter would interact with non-linux systems.

Maybe Gert knows(?)

Cheers,

On 24/08/17 22:37, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> openvpn is also built on many non bash systems. what about them?
>=20
> 24 =D0=B0=D0=B2=D0=B3. 2017 =D0=B3. 18:34 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=
=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Antonio Quartulli" <a@...2297...=
.>
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
>=20
> The backquotes for command substitution in bash are
> considered old-style in favour of the more modern $() [1].
> Substitute them.
>=20
> [1]https://www.gnu.org/software/bash/manual/html_node/Command-Substitutio=
n.
> html#Command-Substitution
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>=20
> note: I did not really know how to test this patch.
>=20
>  dev-tools/gen-release-tarballs.sh | 10 +++++-----
>  tests/t_cltsrv.sh                 |  6 +++---
>  2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/dev-tools/gen-release-tarballs.sh b/dev-tools/gen-release-
> tarballs.sh
> index f9c620e3..550e5cd2 100755
> --- a/dev-tools/gen-release-tarballs.sh
> +++ b/dev-tools/gen-release-tarballs.sh
> @@ -49,7 +49,7 @@ if [ $? -ne 0 ]; then
>  fi
>=20
>  # Extract the git URL
> -giturl=3D"`git remote get-url $arg_remote_name 2>/dev/null`"
> +giturl=3D"$(git remote get-url $arg_remote_name 2>/dev/null)"
>  if [ $? -ne 0 ]; then
>      echo "** ERROR ** Invalid git remote name: $arg_remote_name"
>      exit 2
> @@ -71,7 +71,7 @@ get_filename()
>  {
>      local wildcard=3D"$1"
>=20
> -    res=3D"`find . -maxdepth 1 -type f -name \"$wildcard\" | head -n1 | =
cut
> -d/ -f2-`"
> +    res=3D"$(find . -maxdepth 1 -type f -name \"$wildcard\" | head -n1 |=
 cut
> -d/ -f2-)"
>      if [ $? -ne 0 ]; then
>          echo "-- 'find' failed."
>          exit 5
> @@ -88,7 +88,7 @@ copy_files()
>      local fileext=3D"$1"
>      local dest=3D"$2"
>=20
> -    file=3D"`get_filename openvpn-*.*.*.$fileext`"
> +    file=3D"$(get_filename openvpn-*.*.*.$fileext)"
>      if [ -z "$file" ]; then
>          echo "** ERROR Failed to find source file"
>          exit 5
> @@ -106,7 +106,7 @@ sign_file()
>      local signkey=3D"$1"
>      local srchfile=3D"$2"
>      local signtype=3D"$3"
> -    local file=3D"`get_filename $srchfile`"
> +    local file=3D"$(get_filename $srchfile)"
>=20
>      echo "-- Signing $file ..."
>      case "$signtype" in
> @@ -169,7 +169,7 @@ fi
>  #
>=20
>  # Clone the remote repository
> -workdir=3D"`mktemp -d -p /var/tmp openvpn-build-release-XXXXXX`"
> +workdir=3D"$(mktemp -d -p /var/tmp openvpn-build-release-XXXXXX)"
>  cd $workdir
>  echo "-- Working directory: $workdir"
>  echo "-- git clone $giturl"
> diff --git a/tests/t_cltsrv.sh b/tests/t_cltsrv.sh
> index 752251e4..1ab3db3e 100755
> --- a/tests/t_cltsrv.sh
> +++ b/tests/t_cltsrv.sh
> @@ -25,14 +25,14 @@ top_builddir=3D"${top_builddir:-..}"
>  trap "rm -f log.$$ log.$$.signal ; trap 0 ; exit 77" 1 2 15
>  trap "rm -f log.$$ log.$$.signal ; exit 1" 0 3
>  addopts=3D
> -case `uname -s` in
> +case $(uname -s) in
>      FreeBSD)
>      # FreeBSD jails map the outgoing IP to the jail IP - we need to
>      # allow the real IP unless we want the test to run forever.
> -    if test "`sysctl 2>/dev/null -n security.jail.jailed`" =3D 1 \
> +    if test "$(sysctl 2>/dev/null -n security.jail.jailed)" =3D 1 \
>      || ps -ostate=3D -p $$ | grep -q J; then
>         addopts=3D"--float"
> -       if test "x`ifconfig | grep inet`" =3D x ; then
> +       if test "x$(ifconfig | grep inet)" =3D x ; then
>             echo "###"
>             echo "### To run the test in a FreeBSD jail, you MUST add an =
IP
> alias for the jail's IP."
>             echo "###"
> --
> 2.14.1
>=20
>=20
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
Antonio Quartulli


--TOcrWhdUaqW0evMUgMf2wlcQl2XUHWP4F--

--FfIhe9xAf2EVaGUw1VuPjnxVmb09e0XBB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlme5bwACgkQ0+HICM1s
oFDxhA/+JRvKQvSzBtJL9nPCGOKi0qkNN0hWoR/y1PdRoH27a6Vn6M5t+2Dw9HPI
e2XIuEPOPSycSsa0OKAJCcX1j1mUdBWQNhdIV+TyBXi3ODRlGjonvvR+xPgEU2th
VpeaZcvOj7Pz2iDDvtKlXtHn8WBNQnjrMe8S7DQa9fowJnhVtzGaVdnxk7PbFgKC
XXT6O51GqlLBpDBZtJ3N/wawf2K1AO2ohnRz+SwvYGeCP5Xj0sUVE9tIbCbVJsdh
0llpJx5f+uSYnIwNIS/1Ptc1xTDrFpThomgvyQ1G2PDEEBbjGkUFCtsZEy6miXBe
+XGXTv34ub9+Hyhp3sKvDeNcgk8V8/6tVL0fSuxHwzoyf9CLgko8fA9XzWOoHwgB
xW0VDtN1KJ5ApNr0aeD/tLn0M6bHqwJPgGP90+47erTftpAADa7GzXqihOsFdydJ
69Qm8PU5yabvVP0wKAsO6dDGsqOTFwCVoR0KX/oTUMDIQy9C8a2TRxAzHnX18rwv
q6TZfw1LV9UBVQSguBkvi6+4KB6PBK+2agI46uQytue5ZoKYXydDhYkzfGxvWT9d
zKaQLB4iQLWZs1xxLt7PT18yxnTWIq7SZ9tQr07P04DqkoF5U7WCNW+fXRE8ErsV
FqmgRxQyrrkTfaejdOejgzg5LPvFw7GFWlVFIqUPKUJ8jixEK70=
=Gx0L
-----END PGP SIGNATURE-----

--FfIhe9xAf2EVaGUw1VuPjnxVmb09e0XBB--

