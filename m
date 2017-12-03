References: <20171202134541.7688-1-a@...2181...>
 <9a1ad5cc-e12f-b619-1f76-b7f8a077c75d@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e646805f-b20a-d6af-e8ee-84153ab9087f@...2181...>
Date: Sun, 3 Dec 2017 18:05:19 +0800
MIME-Version: 1.0
In-Reply-To: <9a1ad5cc-e12f-b619-1f76-b7f8a077c75d@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Pu56MXNXg3UpC0qHgg8G15xIJjARX46r8"
Subject: Re: [Openvpn-devel] [PATCH 1/7] Remove option to disable crypto
 engine
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
--Pu56MXNXg3UpC0qHgg8G15xIJjARX46r8
Content-Type: multipart/mixed; boundary="tI3ELmmmHBRChfMXxLMUpndAcp1Hum3uH";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <e646805f-b20a-d6af-e8ee-84153ab9087f@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/7] Remove option to disable crypto
 engine
References: <20171202134541.7688-1-a@...2181...>
 <9a1ad5cc-e12f-b619-1f76-b7f8a077c75d@...1856...>
In-Reply-To: <9a1ad5cc-e12f-b619-1f76-b7f8a077c75d@...1856...>

--tI3ELmmmHBRChfMXxLMUpndAcp1Hum3uH
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/12/17 17:39, Steffan Karger wrote:
> Hi,
>=20
> Feature-ACK.
>=20
> As discussed on IRC, let's apply this patch after 2/7 (or merge with
> 2/7) to prevent having a commit in the tree that unconditionally
> disabled crypto.

thanks for the review!

>=20
> On 02-12-17 14:45, Antonio Quartulli wrote:
>> With this patch we remove the possibility to disable the crypto engine
>> (ENABLE_CRYPTO define) at configuration time.
>>
>> [Some unit-test are temporarily disabled and will be enabled again when
>> ENABLE_CRYPTO is completely removed from the codebase]
>>
>> [--disable-crypto has been removed from .travis.yml too]
>>
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
>>  .travis.yml                                        |  2 +-
>>  config-msvc.h                                      |  1 -
>>  configure.ac                                       | 33 ++++++---------=
-------
>>  doc/doxygen/openvpn.doxyfile.in                    |  2 +-
>>  .../keyingmaterialexporter.c                       |  2 --
>>  sample/sample-plugins/log/log_v3.c                 |  2 --
>>  tests/Makefile.am                                  |  4 +--
>>  tests/unit_tests/openvpn/Makefile.am               |  4 +--
>>  8 files changed, 13 insertions(+), 37 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 366e6599..e89cb7d4 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -59,7 +59,7 @@ matrix:
>>      - env: SSLLIB=3D"openssl" CHOST=3Di686-w64-mingw32
>>        os: linux
>>        compiler: ": Win32 build only"
>> -    - env: SSLLIB=3D"openssl" EXTRA_CONFIG=3D"--disable-crypto" EXTRA_S=
CRIPT=3D"make distcheck"
>> +    - env: SSLLIB=3D"openssl" EXTRA_SCRIPT=3D"make distcheck"
>>        os: linux
>>        compiler: clang
>>      - env: SSLLIB=3D"openssl" EXTRA_CONFIG=3D"--disable-lzo"
>> diff --git a/config-msvc.h b/config-msvc.h
>> index 0bb153df..8be9195f 100644
>> --- a/config-msvc.h
>> +++ b/config-msvc.h
>> @@ -4,7 +4,6 @@
>>=20=20
>>  #define ENABLE_DEF_AUTH 1
>>  #define ENABLE_PF 1
>> -#define ENABLE_CRYPTO 1
>>  #define ENABLE_CRYPTO_OPENSSL 1
>>  #define ENABLE_DEBUG 1
>>  #define ENABLE_EUREPHIA 1
>> diff --git a/configure.ac b/configure.ac
>> index acfddb22..faea7d15 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -77,13 +77,6 @@ AC_ARG_ENABLE(comp-stub,
>>  	[enable_comp_stub=3D"no"]
>>  )
>>=20=20
>> -AC_ARG_ENABLE(
>> -	[crypto],
>> -	[AS_HELP_STRING([--disable-crypto], [disable crypto support @<:@defaul=
t=3Dyes@:>@])],
>> -	,
>> -	[enable_crypto=3D"yes"]
>> -)
>> -
>>  AC_ARG_ENABLE(
>>  	[ofb-cfb],
>>  	[AS_HELP_STRING([--disable-ofb-cfb], [disable support for OFB and CFB =
cipher modes @<:@default=3Dyes@:>@])],
>> @@ -843,7 +836,7 @@ PKG_CHECK_MODULES(
>>  	[]
>>  )
>>=20=20
>> -if test "${enable_crypto}" =3D "yes" -a "${with_crypto_library}" =3D "o=
penssl"; then
>> +if test "${with_crypto_library}" =3D "openssl"; then
>>  	AC_ARG_VAR([OPENSSL_CFLAGS], [C compiler flags for OpenSSL])
>>  	AC_ARG_VAR([OPENSSL_LIBS], [linker flags for OpenSSL])
>>=20=20
>> @@ -958,11 +951,10 @@ if test "${enable_crypto}" =3D "yes" -a "${with_cr=
ypto_library}" =3D "openssl"; then
>>  	CFLAGS=3D"${saved_CFLAGS}"
>>  	LIBS=3D"${saved_LIBS}"
>>=20=20
>> -	have_crypto=3D"yes"
>> -	AC_DEFINE([ENABLE_CRYPTO_OPENSSL], [1], [Use OpenSSL library])
>> +	AC_DEFINE([CRYPTO_OPENSSL], [1], [Use OpenSSL library])
>=20
> Why rename this (and ENABLE_CRYPTO_MBEDTLS)?  All our configure feature
> flags currently have this ENABLE_ prefix, and I'd personally prefer to
> keep it for these too.  (Though I don't care enough to NAK.)
>=20

I decided to remove the ENABLE_* bit because it felt to me like those
ENABLE_CRYPTO_$SOMETHING were "subdefines" of ENABLE_CRYPTO.

However, for consistency with the rest I also agree that it would be
better to keep the ENABLE_ prefix.

I'll send v2 of this patch only where I'll reintroduce the prefix.


Thanks!


>>  	CRYPTO_CFLAGS=3D"${OPENSSL_CFLAGS}"
>>  	CRYPTO_LIBS=3D"${OPENSSL_LIBS}"
>> -elif test "${enable_crypto}" =3D "yes" -a "${with_crypto_library}" =3D =
"mbedtls"; then
>> +elif test "${with_crypto_library}" =3D "mbedtls"; then
>>  	AC_ARG_VAR([MBEDTLS_CFLAGS], [C compiler flags for mbedtls])
>>  	AC_ARG_VAR([MBEDTLS_LIBS], [linker flags for mbedtls])
>>=20=20
>> @@ -1041,11 +1033,10 @@ elif test "${enable_crypto}" =3D "yes" -a "${wit=
h_crypto_library}" =3D "mbedtls"; th
>>=20=20
>>  	CFLAGS=3D"${saved_CFLAGS}"
>>  	LIBS=3D"${saved_LIBS}"
>> -	have_crypto=3D"yes"
>> -	AC_DEFINE([ENABLE_CRYPTO_MBEDTLS], [1], [Use mbed TLS library])
>> +	AC_DEFINE([CRYPTO_MBEDTLS], [1], [Use mbed TLS library])
>>  	CRYPTO_CFLAGS=3D"${MBEDTLS_CFLAGS}"
>>  	CRYPTO_LIBS=3D"${MBEDTLS_LIBS}"
>> -elif test "${enable_crypto}" =3D "yes"; then
>> +else
>>  	AC_MSG_ERROR([Invalid crypto library: ${with_crypto_library}])
>>  fi
>>=20=20
>> @@ -1245,14 +1236,10 @@ test "${enable_def_auth}" =3D "yes" && AC_DEFINE=
([ENABLE_DEF_AUTH], [1], [Enable d
>>  test "${enable_pf}" =3D "yes" && AC_DEFINE([ENABLE_PF], [1], [Enable in=
ternal packet filter])
>>  test "${enable_strict_options}" =3D "yes" && AC_DEFINE([ENABLE_STRICT_O=
PTIONS_CHECK], [1], [Enable strict options check between peers])
>>=20=20
>> -if test "${enable_crypto}" =3D "yes"; then
>> -	test "${have_crypto}" !=3D "yes" && AC_MSG_ERROR([${with_crypto_librar=
y} crypto is required but missing])
>> -	test "${enable_crypto_ofb_cfb}" =3D "yes" && AC_DEFINE([ENABLE_OFB_CFB=
_MODE], [1], [Enable OFB and CFB cipher modes])
>> -	test "${have_crypto_aead_modes}" =3D "yes" && AC_DEFINE([HAVE_AEAD_CIP=
HER_MODES], [1], [Use crypto library])
>> -	OPTIONAL_CRYPTO_CFLAGS=3D"${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CFLAGS}"
>> -	OPTIONAL_CRYPTO_LIBS=3D"${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_LIBS}"
>> -	AC_DEFINE([ENABLE_CRYPTO], [1], [Enable crypto library])
>> -fi
>> +test "${enable_crypto_ofb_cfb}" =3D "yes" && AC_DEFINE([ENABLE_OFB_CFB_=
MODE], [1], [Enable OFB and CFB cipher modes])
>> +test "${have_crypto_aead_modes}" =3D "yes" && AC_DEFINE([HAVE_AEAD_CIPH=
ER_MODES], [1], [Use crypto library])
>> +OPTIONAL_CRYPTO_CFLAGS=3D"${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CFLAGS}"
>> +OPTIONAL_CRYPTO_LIBS=3D"${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_LIBS}"
>>=20=20
>>  if test "${enable_plugins}" =3D "yes"; then
>>  	OPTIONAL_DL_LIBS=3D"${DL_LIBS}"
>> @@ -1292,7 +1279,6 @@ fi
>>=20=20
>>  if test "${enable_pkcs11}" =3D "yes"; then
>>  	test "${have_pkcs11_helper}" !=3D "yes" && AC_MSG_ERROR([PKCS11 enable=
d but libpkcs11-helper is missing])
>> -	test "${enable_crypto}" !=3D "yes" && AC_MSG_ERROR([PKCS11 can be enab=
led only if crypto is enabled])
>>  	OPTIONAL_PKCS11_HELPER_CFLAGS=3D"${PKCS11_HELPER_CFLAGS}"
>>  	OPTIONAL_PKCS11_HELPER_LIBS=3D"${PKCS11_HELPER_LIBS}"
>>  	AC_DEFINE([ENABLE_PKCS11], [1], [Enable PKCS11])
>> @@ -1372,7 +1358,6 @@ AM_CONDITIONAL([WIN32], [test "${WIN32}" =3D "yes"=
])
>>  AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" =3D "yes"])
>>  AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pa=
m}" =3D "yes"])
>>  AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_r=
oot}" =3D "yes"])
>> -AM_CONDITIONAL([ENABLE_CRYPTO], [test "${enable_crypto}" =3D "yes"])
>>  AM_CONDITIONAL([HAVE_LD_WRAP_SUPPORT], [test "${have_ld_wrap_support}" =
=3D "yes"])
>>=20=20
>>  sampledir=3D"\$(docdir)/sample"
>> diff --git a/doc/doxygen/openvpn.doxyfile.in b/doc/doxygen/openvpn.doxyf=
ile.in
>> index bb56fff4..d9e9ed08 100644
>> --- a/doc/doxygen/openvpn.doxyfile.in
>> +++ b/doc/doxygen/openvpn.doxyfile.in
>> @@ -235,7 +235,7 @@ EXPAND_ONLY_PREDEF     =3D NO
>>  SEARCH_INCLUDES        =3D YES
>>  INCLUDE_PATH           =3D
>>  INCLUDE_FILE_PATTERNS  =3D
>> -PREDEFINED             =3D _WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP P2M=
P_SERVER ENABLE_CRYPTO ENABLE_CRYPTO_OPENSSL ENABLE_PLUGIN ENABLE_MANAGEMEN=
T ENABLE_OCC HAVE_GETTIMEOFDAY
>> +PREDEFINED             =3D _WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP P2M=
P_SERVER ENABLE_CRYPTO_OPENSSL ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC H=
AVE_GETTIMEOFDAY
>>  EXPAND_AS_DEFINED      =3D
>>  SKIP_FUNCTION_MACROS   =3D YES
>>  #----------------------------------------------------------------------=
-----
>> diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingm=
aterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/key=
ingmaterialexporter.c
>> index c4839077..8ee78c53 100644
>> --- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterial=
exporter.c
>> +++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterial=
exporter.c
>> @@ -27,8 +27,6 @@
>>   * See the README file for build instructions.
>>   */
>>=20=20
>> -#define ENABLE_CRYPTO
>> -
>>  #include <stdio.h>
>>  #include <string.h>
>>  #include <stdlib.h>
>> diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/=
log/log_v3.c
>> index 98d80d95..3ff80290 100644
>> --- a/sample/sample-plugins/log/log_v3.c
>> +++ b/sample/sample-plugins/log/log_v3.c
>> @@ -35,8 +35,6 @@
>>  #include <string.h>
>>  #include <stdlib.h>
>>=20=20
>> -#define ENABLE_CRYPTO
>> -
>>  #include "openvpn-plugin.h"
>>=20=20
>>  /*
>> diff --git a/tests/Makefile.am b/tests/Makefile.am
>> index 0795680c..0b32058b 100644
>> --- a/tests/Makefile.am
>> +++ b/tests/Makefile.am
>> @@ -15,9 +15,7 @@ MAINTAINERCLEANFILES =3D \
>>  SUBDIRS =3D unit_tests
>>=20=20
>>  test_scripts =3D t_client.sh
>> -if ENABLE_CRYPTO
>> -test_scripts +=3D t_lpback.sh t_cltsrv.sh
>> -endif
>> +#test_scripts +=3D t_lpback.sh t_cltsrv.sh
>>=20=20
>>  TESTS_ENVIRONMENT =3D top_srcdir=3D"$(top_srcdir)"
>>  TESTS =3D $(test_scripts)
>> diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/ope=
nvpn/Makefile.am
>> index 7b44f42e..055aa49d 100644
>> --- a/tests/unit_tests/openvpn/Makefile.am
>> +++ b/tests/unit_tests/openvpn/Makefile.am
>> @@ -6,9 +6,7 @@ if HAVE_LD_WRAP_SUPPORT
>>  check_PROGRAMS +=3D argv_testdriver buffer_testdriver
>>  endif
>>=20=20
>> -if ENABLE_CRYPTO
>> -check_PROGRAMS +=3D packet_id_testdriver tls_crypt_testdriver
>> -endif
>> +#check_PROGRAMS +=3D packet_id_testdriver tls_crypt_testdriver
>>=20=20
>>  TESTS =3D $(check_PROGRAMS)
>>=20=20
>>
>=20
> -Steffan
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
Antonio Quartulli


--tI3ELmmmHBRChfMXxLMUpndAcp1Hum3uH--

--Pu56MXNXg3UpC0qHgg8G15xIJjARX46r8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlojzGIACgkQB6U8WA7y
zXQTRRAAh3ZUeGUbPVzqZQIbfIYYALMESZ9rM+lxBOvmDQxPjmdf7WcrtOT1ii3t
Na7gKFBVGc1QI3wwSU2DwXZW/brz9obv50lenliZ3upPrOjDb44tGLYt75sTsMWc
suaqhH5F8ihM5i3KrptdBKbSjouRnfwnuTBmSVo8lo1UyZSJ8krHEaTIN1S32qcH
6u8nDT13fPFqngyYwBHrJMl5xnwfAYAsi/b6696mp5oGpnJy+Yus6vCesjmbozfi
nOy+rzyTnl5Qwxd84PS8ecypEcKGAz0nwSPPNkhFq3mzgRN1TBHWz+AEqvSUeUec
KrBEjOspQSp6RU1Wtn/sLcXBMnLUoDY6D6HOqgNaPySUscbFzJRauacnwTY3DWJG
zgrL5S9gWv+MJgNlIVzdLNqPA0lQ5+tcUT8zt8yuK6zQgsIE51ZdQncjM9lTafc5
9SkkNsPDvQH8SgVU3wskK+4HDBv6F0z2q2Y76gCoB0m2GM+8RB2CJSA0JISTSlyc
lNWNCk1WYye0a57rTL75WFi12Z468TjtVOdalpK7M8m8HKEDe69P8AP4sDT34FKC
cy+uV53ydo+kkDJtIHZKKYQNzLXQmdoRtV0ZiKEFSqjkDzgwIy1j8EI0HvJ8kyzg
GHRixeaXiWcq965Jf19vCoK9s1deDNz+0okJ8XhidW4teBlXPMk=
=JnuH
-----END PGP SIGNATURE-----

--Pu56MXNXg3UpC0qHgg8G15xIJjARX46r8--

