Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170824133305.25604-1-a@...2181...>
 <CAFHpkQEJefeuqwbfy638M0AYO4EvcN8tamQQAHfxH-uPDwm=+g@...278...>
 <CAFHpkQHi0==66QDo8zVkktdCS4evKhQBkpkTZLbnt0WPMpXzsQ@...278...>
 <CAFHpkQFfWXACzHXuxXDDHOiZSQRaFro=QJoEcfcSx01Ao-m9iw@...278...>
 <d31c59c4-a512-f335-41fc-e6389915a270@...2181...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <4555eb8e-62db-e24c-c297-d27a63c40942@...2080...>
Date: Thu, 24 Aug 2017 20:06:00 +0200
MIME-Version: 1.0
In-Reply-To: <d31c59c4-a512-f335-41fc-e6389915a270@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hNQde8adKlTbtoQNJIgHKQwC7SwDPNLG6"
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
To: Antonio Quartulli <a@...2181...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0Lg=?= =?UTF-8?B?0YbQuNC9?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hNQde8adKlTbtoQNJIgHKQwC7SwDPNLG6
Content-Type: multipart/mixed; boundary="Orr918fjvPEU2IPB9GT9bMjqBhTbHJD3E";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Antonio Quartulli <a@...2181...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0Lg=?=
 =?UTF-8?B?0YbQuNC9?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <4555eb8e-62db-e24c-c297-d27a63c40942@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] bash: substitute legacy `` with modern
 $()
References: <20170824133305.25604-1-a@...2181...>
 <CAFHpkQEJefeuqwbfy638M0AYO4EvcN8tamQQAHfxH-uPDwm=+g@...278...>
 <CAFHpkQHi0==66QDo8zVkktdCS4evKhQBkpkTZLbnt0WPMpXzsQ@...278...>
 <CAFHpkQFfWXACzHXuxXDDHOiZSQRaFro=QJoEcfcSx01Ao-m9iw@...278...>
 <d31c59c4-a512-f335-41fc-e6389915a270@...2181...>
In-Reply-To: <d31c59c4-a512-f335-41fc-e6389915a270@...2181...>

--Orr918fjvPEU2IPB9GT9bMjqBhTbHJD3E
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 24/08/17 16:42, Antonio Quartulli wrote:
> dev-tools/gen-release-tarballs.sh is only for devs, while
> tests/t_cltsrv.sh is for running some tests, but I am not sure sure how
> the latter would interact with non-linux systems.
>=20
> Maybe Gert knows(?)

Tried running them through ksh or dash?  Those are the most feature
restrictive shells I can think of right now.  Dash is supposed to be the
most POSIX compliant shell, iirc.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



> On 24/08/17 22:37, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>> openvpn is also built on many non bash systems. what about them?
>>
>> 24 =D0=B0=D0=B2=D0=B3. 2017 =D0=B3. 18:34 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=
=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Antonio Quartulli" <a@...2297...=
.>
>> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
>>
>> The backquotes for command substitution in bash are
>> considered old-style in favour of the more modern $() [1].
>> Substitute them.
>>
>> [1]https://www.gnu.org/software/bash/manual/html_node/Command-Substituti=
on.
>> html#Command-Substitution
>>
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
>>
>> note: I did not really know how to test this patch.
>>
>>  dev-tools/gen-release-tarballs.sh | 10 +++++-----
>>  tests/t_cltsrv.sh                 |  6 +++---
>>  2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/dev-tools/gen-release-tarballs.sh b/dev-tools/gen-release-
>> tarballs.sh
>> index f9c620e3..550e5cd2 100755
>> --- a/dev-tools/gen-release-tarballs.sh
>> +++ b/dev-tools/gen-release-tarballs.sh
>> @@ -49,7 +49,7 @@ if [ $? -ne 0 ]; then
>>  fi
>>
>>  # Extract the git URL
>> -giturl=3D"`git remote get-url $arg_remote_name 2>/dev/null`"
>> +giturl=3D"$(git remote get-url $arg_remote_name 2>/dev/null)"
>>  if [ $? -ne 0 ]; then
>>      echo "** ERROR ** Invalid git remote name: $arg_remote_name"
>>      exit 2
>> @@ -71,7 +71,7 @@ get_filename()
>>  {
>>      local wildcard=3D"$1"
>>
>> -    res=3D"`find . -maxdepth 1 -type f -name \"$wildcard\" | head -n1 |=
 cut
>> -d/ -f2-`"
>> +    res=3D"$(find . -maxdepth 1 -type f -name \"$wildcard\" | head -n1 =
| cut
>> -d/ -f2-)"
>>      if [ $? -ne 0 ]; then
>>          echo "-- 'find' failed."
>>          exit 5
>> @@ -88,7 +88,7 @@ copy_files()
>>      local fileext=3D"$1"
>>      local dest=3D"$2"
>>
>> -    file=3D"`get_filename openvpn-*.*.*.$fileext`"
>> +    file=3D"$(get_filename openvpn-*.*.*.$fileext)"
>>      if [ -z "$file" ]; then
>>          echo "** ERROR Failed to find source file"
>>          exit 5
>> @@ -106,7 +106,7 @@ sign_file()
>>      local signkey=3D"$1"
>>      local srchfile=3D"$2"
>>      local signtype=3D"$3"
>> -    local file=3D"`get_filename $srchfile`"
>> +    local file=3D"$(get_filename $srchfile)"
>>
>>      echo "-- Signing $file ..."
>>      case "$signtype" in
>> @@ -169,7 +169,7 @@ fi
>>  #
>>
>>  # Clone the remote repository
>> -workdir=3D"`mktemp -d -p /var/tmp openvpn-build-release-XXXXXX`"
>> +workdir=3D"$(mktemp -d -p /var/tmp openvpn-build-release-XXXXXX)"
>>  cd $workdir
>>  echo "-- Working directory: $workdir"
>>  echo "-- git clone $giturl"
>> diff --git a/tests/t_cltsrv.sh b/tests/t_cltsrv.sh
>> index 752251e4..1ab3db3e 100755
>> --- a/tests/t_cltsrv.sh
>> +++ b/tests/t_cltsrv.sh
>> @@ -25,14 +25,14 @@ top_builddir=3D"${top_builddir:-..}"
>>  trap "rm -f log.$$ log.$$.signal ; trap 0 ; exit 77" 1 2 15
>>  trap "rm -f log.$$ log.$$.signal ; exit 1" 0 3
>>  addopts=3D
>> -case `uname -s` in
>> +case $(uname -s) in
>>      FreeBSD)
>>      # FreeBSD jails map the outgoing IP to the jail IP - we need to
>>      # allow the real IP unless we want the test to run forever.
>> -    if test "`sysctl 2>/dev/null -n security.jail.jailed`" =3D 1 \
>> +    if test "$(sysctl 2>/dev/null -n security.jail.jailed)" =3D 1 \
>>      || ps -ostate=3D -p $$ | grep -q J; then
>>         addopts=3D"--float"
>> -       if test "x`ifconfig | grep inet`" =3D x ; then
>> +       if test "x$(ifconfig | grep inet)" =3D x ; then
>>             echo "###"
>>             echo "### To run the test in a FreeBSD jail, you MUST add an=
 IP
>> alias for the jail's IP."
>>             echo "###"
>> --
>> 2.14.1


--Orr918fjvPEU2IPB9GT9bMjqBhTbHJD3E--

--hNQde8adKlTbtoQNJIgHKQwC7SwDPNLG6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZnxWRAAoJEIbPlEyWcf3yLawQAJcQRMtXrFQNapTAl/GqCDbq
WYOUgCdVnfLnLdc7eGkpYhHDq8tXfduV7PymUi3b43LB82svYHnc9ugu8efmzHf3
cUcdNOhoZEtnfZ54ay2egbtOvG4P/2o7LdtcbI/5p2Z8ZTMmZA9EEOo+jBlrWXOS
R30BfiU2sG3v6FxbJ8/ttqChNSbOGCdLF8bEiHXrDi2Z7fPU4MuN8gsu+e5UNIGj
4PRJ/84qE3zI2/Oygw9lVqaMWTihyCOmorlGonOJAbINP+iXeFsWiErSTvvYnVXy
PckY48mFlyOzxEC6WL7ervRoMH4C/Ut3n1CSox4BhY2O3TqJHA97oqeY+DWyu0J5
eZL2FAMq1MQW5VvihjAIv52itsKLZPQdqWQBkc+dtxjVEFtaUHVL+iY1CWMVNpaX
WdszJeqrAqUIFBwyxX04SYaRH7S8BS6Q9Jh6QcLblyC3jM613nNvo9gNnwgB1TQf
tAxDstdciS4r6Og4wuKJblcOf1f+LNcUPwpVk4+AJwUPTjeRg2EnUfygcv9tzMPF
GBMxHZbOLmQeaIDcS2bIt+JB9n4TmvrDbgjHtMJ5uQYsb4G5ChGrenGm8cVavjWT
L8yy8uIjNHbvvmxb66/onSM9MEgXZr6s5tTN7EKFLWmnSRSjqxxhkM/kZJh1OUKZ
6RyA7fr4Je/l9LrhCuX5
=p6we
-----END PGP SIGNATURE-----

--hNQde8adKlTbtoQNJIgHKQwC7SwDPNLG6--

