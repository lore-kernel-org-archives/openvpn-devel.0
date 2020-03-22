MIME-Version: 1.0
References: <20200322123521.17710-1-chipitsine@...277...>
In-Reply-To: <20200322123521.17710-1-chipitsine@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 22 Mar 2020 17:39:51 +0500
Message-ID: <CAFHpkQF+vEm1ZKYQ75etSOcx3M+rxmrwrbwHksVCUrzaVdDo_Q@...278...>
Content-Type: multipart/alternative; boundary="0000000000004b1d4e05a170d1b4"
Subject: Re: [Openvpn-devel] [PATCH v3] travis-ci: add arm64, s390x builds.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000004b1d4e05a170d1b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sorry, I sent it twice.

the last one is good, please ignore previous "v2"

I've managed to resolve "travis_wait" issue. it was non trivial output
redirection  issue.
the rest is just fine.


patch itself is important it re-enables cmocka tests in travis (they are
not running now, after cmocka git submodule was removed)

=D0=B2=D1=81, 22 =D0=BC=D0=B0=D1=80. 2020 =D0=B3. =D0=B2 17:35, <chipitsine=
@...277...>:

> From: Ilya Shipitsin <chipitsine@...277...>
>
> as described on https://docs.travis-ci.com/user/multi-cpu-architectures
> travis-ci
> now supports amd64, ppcle, arm64, s390 architectures. Add arm64 and s390x.
>
> travis-ci images were upgraded to bionic.
>
> "sudo" is deprecated, let us remove it, also "matrix" is deprecated in
> favour of "jobs".
>
> LD_LIBRARY_PATH was replaced by using "rpath" in LDFLAGS, which is more
> elegant way of linking.
>
> also, dependencies were upgraded to the latest versions.
>
> travis_wait was added for long openssl builds.
>
> cmocka was added to linux and osx builds.
> ---
> v3 resolved travis_wait output redirection issue, now it works as
> expected. I had to specify "names" for jobs,
> without names travis puts secure variable as job name
>
> v2 rebased against proper commit
>
>
>  .travis.yml               | 87 +++++++++++++++++++++++++--------------
>  .travis/build-check.sh    | 10 +----
>  .travis/build-deps.sh     | 10 +++--
>  .travis/run-build-deps.sh | 10 -----
>  4 files changed, 62 insertions(+), 55 deletions(-)
>  delete mode 100755 .travis/run-build-deps.sh
>
> diff --git a/.travis.yml b/.travis.yml
> index 40296d87..925d09ea 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -1,5 +1,4 @@
> -sudo: required
> -dist: xenial
> +dist: bionic
>
>  os: linux
>
> @@ -11,86 +10,111 @@ env:
>      - PREFIX=3D"${HOME}/opt"
>      - TAP_WINDOWS_VERSION=3D9.23.3
>      - LZO_VERSION=3D2.10
> -    - PKCS11_HELPER_VERSION=3D1.25.1
> -    - MBEDTLS_VERSION=3D2.16.1
> +    - PKCS11_HELPER_VERSION=3D1.26
> +    - MBEDTLS_VERSION=3D2.16.4
>      - MBEDTLS_CFLAGS=3D"-I${PREFIX}/include"
>      - MBEDTLS_LIBS=3D"-L${PREFIX}/lib -lmbedtls -lmbedx509 -lmbedcrypto"
> -    - OPENSSL_VERSION=3D1.0.2s
> +    - OPENSSL_VERSION=3D1.0.2u
>      - OPENSSL_CFLAGS=3D"-I${PREFIX}/include"
>      - OPENSSL_LIBS=3D"-L${PREFIX}/lib -lssl -lcrypto"
>      # The next declaration is the encrypted COVERITY_SCAN_TOKEN, created
>      #   via the "travis encrypt" command using the project repo's public
> key
>      - secure:
> "l9mSnEW4LJqjxftH5i1NdDaYfGmQB1mPXnSB3DXnsjzkCWZ+yJLfBemfQ0tx/wS7chBYxqUa=
UIMT0hw4zJVp/LANFJo2vfh//ymTS6h0uApRY1ofg9Pp1BFcV1laG6/u8pwSZ2EBy/GhCd3DS43=
6oE8sYBRaFM9FU62L/oeQBfJ7r4ID/0eB1b8bqlbD4paty9MHui2P8EZJwR+KAD84prtfpZOcrS=
MxPh9OUhJxzxUvvVoP4s4+lZ5Kgg1bBQ3yzKGDqe8VOgK2BWCEuezqhMMc8oeKmAe7CUkoz5gsG=
YH++k3I9XzP9Z4xeJKoQnC/82qi4xkJmlaOxdionej9bHIcjfRt7D8j1J0U+wOj4p8VrDy7yHax=
uN2fi0K5MGa/CaXQSrkna8dePniCng+xQ2MY/zxuRX2gA6xPNLUyQLU9LqIug7wj4z84Hk9iWib=
4L20MoPjeEo+vAUNq8FtjOPxMuHNpv4iGGx6kgJm7RXl5vC5hxfK6MprrnYe2U5Mcd8jpzagKBa=
KHL3zV2FxX9k0jRO9Mccz7M2WnaV0MQ6zcngzTN4+s0kCjhfGKd2F2ANT2Gkhj3Me36eNHfuE0d=
BbvYCMh4b3Mgd7b/OuXwQWdJ8PjJ1WHXjSOw5sHw1suaV6cEO2Meyz5j1tOkyOi0M9QF+LFenQ9=
vLH4sBCww8U=3D"
>
> -matrix:
> +jobs:
>    include:
> -    - env:
> +    - name: cl
> +      env:
>        - SSLLIB=3D"openssl"
>        - OPENSSL_VERSION=3D"1.1.1d"
>        - P7Z=3D"c:\Program Files\7-Zip\7z.exe"
>        - CC=3D"cl"
>        os: windows
>        compiler: cl
> -    - env: SSLLIB=3D"openssl" RUN_COVERITY=3D"1"
> +    - name: Coverity scan
> +      env: SSLLIB=3D"openssl" RUN_COVERITY=3D"1"
>        os: linux
>        compiler: gcc
> -    - env: SSLLIB=3D"openssl" OPENSSL_VERSION=3D"1.0.1u"
> +    - name: gcc | openssl-1.0.1u
> +      env: SSLLIB=3D"openssl" OPENSSL_VERSION=3D"1.0.1u"
>        os: linux
>        compiler: gcc
> -    - env: SSLLIB=3D"openssl" OPENSSL_VERSION=3D"1.1.1c"
> +    - name: gcc | openssl-1.1.1d
> +      env: SSLLIB=3D"openssl" OPENSSL_VERSION=3D"1.1.1d"
>        os: linux
> +      arch: amd64
>        compiler: gcc
> -    - env: SSLLIB=3D"openssl" OPENSSL_VERSION=3D"1.1.1c" LABEL=3D"linux-=
ppc64le"
> -      os: linux-ppc64le
> +    - name: gcc | openssl-1.1.1d
> +      env: SSLLIB=3D"openssl" OPENSSL_VERSION=3D"1.1.1d"
> +      os: linux
> +      arch: ppc64le
> +      compiler: gcc
> +    - name: gcc | openssl-1.1.1d
> +      env: SSLLIB=3D"openssl" OPENSSL_VERSION=3D"1.1.1d"
> +      os: linux
> +      arch: arm64
> +      compiler: gcc
> +    - name: gcc | openssl-1.1.1d
> +      env: SSLLIB=3D"openssl" OPENSSL_VERSION=3D"1.1.1d"
> +      os: linux
> +      arch: s390x
>        compiler: gcc
> -    - env: SSLLIB=3D"openssl" EXTRA_CONFIG=3D"--enable-iproute2"
> +    - name: gcc | openssl-1.0.2u | iproute2
> +      env: SSLLIB=3D"openssl" EXTRA_CONFIG=3D"--enable-iproute2"
>        os: linux
>        compiler: gcc
> -    - env: SSLLIB=3D"openssl" CFLAGS=3D"-fsanitize=3Daddress" CC=3Dclang=
-9
> +    - name: clang+asan | openssl-1.0.2u
> +      env: SSLLIB=3D"openssl" CFLAGS=3D"-fsanitize=3Daddress" CC=3Dclang=
-9
>        os: linux
>        compiler: clang
> -    - env: SSLLIB=3D"openssl" OPENSSL_VERSION=3D"1.1.1c" CC=3Dclang-9
> +    - name: clang | openssl-1.1.1d
> +      env: SSLLIB=3D"openssl" OPENSSL_VERSION=3D"1.1.1d" CC=3Dclang-9
>        os: linux
>        compiler: clang
> -    - env: SSLLIB=3D"mbedtls"
> +    - name: gcc | mbedtls
> +      env: SSLLIB=3D"mbedtls"
>        os: linux
>        compiler: gcc
> -    - env: SSLLIB=3D"mbedtls" CFLAGS=3D"-fsanitize=3Daddress" CC=3Dclang=
-9
> +    - name: clang+asan | mbedtls
> +      env: SSLLIB=3D"mbedtls" CFLAGS=3D"-fsanitize=3Daddress" CC=3Dclang=
-9
>        os: linux
>        compiler: clang
> -    - env: SSLLIB=3D"openssl"
> +    - name: clang | openssl-1.0.2u
> +      env: SSLLIB=3D"openssl"
>        os: osx
>        compiler: clang
> -    - env: SSLLIB=3D"mbedtls"
> +    - name: clang | mbedtls
> +      env: SSLLIB=3D"mbedtls"
>        os: osx
>        compiler: clang
> -    - env: SSLLIB=3D"openssl" CHOST=3Dx86_64-w64-mingw32
> OPENSSL_VERSION=3D"1.0.1u"
> +    - name: mingw64 | openssl-1.0.1u
> +      env: SSLLIB=3D"openssl" CHOST=3Dx86_64-w64-mingw32
> OPENSSL_VERSION=3D"1.0.1u"
>        os: linux
>        compiler: ": Win64 build only"
> -    - env: SSLLIB=3D"openssl" CHOST=3Dx86_64-w64-mingw32
> OPENSSL_VERSION=3D"1.1.1c"
> +    - name: mingw64 | openssl-1.1.1d
> +      env: SSLLIB=3D"openssl" CHOST=3Dx86_64-w64-mingw32
> OPENSSL_VERSION=3D"1.1.1d"
>        os: linux
>        compiler: ": Win64 build only"
> -    - env: SSLLIB=3D"openssl" CHOST=3Di686-w64-mingw32
> +    - name: mingw32 | openssl-1.0.2u
> +      env: SSLLIB=3D"openssl" CHOST=3Di686-w64-mingw32
>        os: linux
>        compiler: ": Win32 build only"
> -    - env: SSLLIB=3D"openssl" EXTRA_CONFIG=3D"--disable-lzo"
> EXTRA_SCRIPT=3D"make distcheck" CC=3Dclang-9
> +    - name: clang | openssl-1.0.2u | disable-lzo | distcheck
> +      env: SSLLIB=3D"openssl" EXTRA_CONFIG=3D"--disable-lzo"
> EXTRA_SCRIPT=3D"make distcheck" CC=3Dclang-9
>        os: linux
>        compiler: clang
> -    - env: SSLLIB=3D"openssl" EXTRA_CONFIG=3D"--enable-small" CC=3Dclang=
-9
> +    - name: clang | openssl-1.0.2u | enable-small
> +      env: SSLLIB=3D"openssl" EXTRA_CONFIG=3D"--enable-small" CC=3Dclang=
-9
>        os: linux
>        compiler: clang
>
>  addons:
>    apt:
> -    sources:
> -      - ubuntu-toolchain-r-test
> -      - sourceline: 'deb https://apt.llvm.org/xenial/
> llvm-toolchain-xenial-9 main'
> -        key_url: 'https://apt.llvm.org/llvm-snapshot.gpg.key'
>      update: true
> -    packages: [ liblzo2-dev, libpam0g-dev, liblz4-dev, linux-libc-dev,
> man2html, mingw-w64 ]
> +    packages: [ liblzo2-dev, libpam0g-dev, liblz4-dev, linux-libc-dev,
> man2html, mingw-w64, clang-9, libcmocka-dev ]
>    homebrew:
>      update: true
> -    packages: [ lzo ]
> +    packages: [ lzo, lz4, cmocka ]
>
>  cache:
>    directories:
> @@ -99,9 +123,8 @@ cache:
>    - ${HOME}/Library/Caches/Homebrew
>
>  install:
> -  - if [ "$TRAVIS_OS_NAME" =3D "linux" ] && [ "$TRAVIS_CPU_ARCH" !=3D
> "ppc64le" ]; then sudo apt-get install clang-9; fi
>    - if [ ! -z "${CHOST}" ]; then unset CC; fi
> -  - .travis/run-build-deps.sh
> +  - travis_wait 30 bash -c '.travis/build-deps.sh > build-deps.log 2>&1'
> || (cat build-deps.log && exit 1)
>
>  before_script:
>    - .travis/coverity.sh
> diff --git a/.travis/build-check.sh b/.travis/build-check.sh
> index f794704c..4e1b7243 100755
> --- a/.travis/build-check.sh
> +++ b/.travis/build-check.sh
> @@ -6,14 +6,6 @@ if [ "${TRAVIS_OS_NAME}" =3D "windows" ]; then
>         MSBuild.exe openvpn.sln //p:Platform=3Dx64 && exit 0
>  fi
>
> -if [ "${TRAVIS_OS_NAME}" =3D "linux" ]; then
> -       export LD_LIBRARY_PATH=3D"${PREFIX}/lib:${LD_LIBRARY_PATH:-}"
> -fi
> -
> -if [ "${TRAVIS_OS_NAME}" =3D "osx"   ]; then
> -       export DYLD_LIBRARY_PATH=3D"${PREFIX}/lib:${DYLD_LIBRARY_PATH:-}"
> -fi
> -
>  autoreconf -vi
>
>  if [ -z ${CHOST+x} ]; then
> @@ -21,7 +13,7 @@ if [ -z ${CHOST+x} ]; then
>                 export EXTRA_CONFIG=3D"${EXTRA_CONFIG:-} --enable-werror"
>         fi
>         ./configure --with-crypto-library=3D"${SSLLIB}" ${EXTRA_CONFIG:-}=
 ||
> (cat config.log && exit 1)
> -       make -j$JOBS
> +       make LDFLAGS=3D"-Wl,-rpath,${PREFIX}/lib" -j$JOBS
>         src/openvpn/openvpn --version || true
>         if [ "${TRAVIS_OS_NAME}" =3D "linux" ]; then
>                 ldd src/openvpn/openvpn;
> diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
> index 4c5cb05e..0c8d69b8 100755
> --- a/.travis/build-deps.sh
> +++ b/.travis/build-deps.sh
> @@ -44,17 +44,19 @@ build_lzo () {
>  }
>
>  download_pkcs11_helper () {
> -    if [ ! -f "pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2" ]; then
> +    if [ ! -f "pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.gz" ]; then
>          wget -P download-cache/ \
> -            "
> https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-$=
{PKCS11_HELPER_VERSION}/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2
> "
> +            "
> https://github.com/OpenSC/pkcs11-helper/archive/pkcs11-helper-${PKCS11_HE=
LPER_VERSION}.tar.gz
> "
>      fi
>  }
>
>  build_pkcs11_helper () {
>      if [ "$(cat ${PREFIX}/.pkcs11_helper-version)" !=3D
> "${PKCS11_HELPER_VERSION}" ]; then
> -        tar jxf
> download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2
> +        tar xf
> download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.gz
>          (
> -            cd "pkcs11-helper-${PKCS11_HELPER_VERSION}"
> +            cd "pkcs11-helper-pkcs11-helper-${PKCS11_HELPER_VERSION}"
> +
> +            autoreconf -iv
>
>              ./configure --host=3D${CHOST} --program-prefix=3D''
> --libdir=3D${PREFIX}/lib \
>                   --prefix=3D${PREFIX} --build=3Dx86_64-pc-linux-gnu \
> diff --git a/.travis/run-build-deps.sh b/.travis/run-build-deps.sh
> deleted file mode 100755
> index b8eb41c5..00000000
> --- a/.travis/run-build-deps.sh
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -#!/bin/sh
> -set -eux
> -
> -if [ "${TRAVIS_OS_NAME}" =3D "windows" ]; then
> -    # for windows we need to print output since openssl build
> -    # might take more than 10 minutes, which causes build abort
> -    .travis/build-deps.sh
> -else
> -    .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log &&
> exit 1)
> -fi
> --
> 2.25.1
>
>

--0000000000004b1d4e05a170d1b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>sorry, I sent it twice.</div><div><br></div><div>the =
last one is good, please ignore previous &quot;v2&quot;</div><div><br></div=
><div>I&#39;ve managed to resolve &quot;travis_wait&quot; issue. it was non=
 trivial output redirection=C2=A0 issue.</div><div>the rest is just fine.</=
div><div><br></div><div><br></div><div>patch itself is important it re-enab=
les cmocka tests in travis (they are not running now, after cmocka git subm=
odule was removed)<br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=81, 22 =D0=BC=D0=B0=D1=80. 2020 =D0=
=B3. =D0=B2 17:35, &lt;<a href=3D"mailto:chipitsine@...277...">chipitsine@...220...=
..277...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">From: Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...277..." target=
=3D"_blank">chipitsine@...277...</a>&gt;<br>
<br>
as described on <a href=3D"https://docs.travis-ci.com/user/multi-cpu-archit=
ectures" rel=3D"noreferrer" target=3D"_blank">https://docs.travis-ci.com/us=
er/multi-cpu-architectures</a> travis-ci<br>
now supports amd64, ppcle, arm64, s390 architectures. Add arm64 and s390x.<=
br>
<br>
travis-ci images were upgraded to bionic.<br>
<br>
&quot;sudo&quot; is deprecated, let us remove it, also &quot;matrix&quot; i=
s deprecated in favour of &quot;jobs&quot;.<br>
<br>
LD_LIBRARY_PATH was replaced by using &quot;rpath&quot; in LDFLAGS, which i=
s more elegant way of linking.<br>
<br>
also, dependencies were upgraded to the latest versions.<br>
<br>
travis_wait was added for long openssl builds.<br>
<br>
cmocka was added to linux and osx builds.<br>
---<br>
v3 resolved travis_wait output redirection issue, now it works as expected.=
 I had to specify &quot;names&quot; for jobs,<br>
without names travis puts secure variable as job name<br>
<br>
v2 rebased against proper commit<br>
<br>
<br>
=C2=A0.travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 8=
7 +++++++++++++++++++++++++--------------<br>
=C2=A0.travis/build-check.sh=C2=A0 =C2=A0 | 10 +----<br>
=C2=A0.travis/build-deps.sh=C2=A0 =C2=A0 =C2=A0| 10 +++--<br>
=C2=A0.travis/run-build-deps.sh | 10 -----<br>
=C2=A04 files changed, 62 insertions(+), 55 deletions(-)<br>
=C2=A0delete mode 100755 .travis/run-build-deps.sh<br>
<br>
diff --git a/.travis.yml b/.travis.yml<br>
index 40296d87..925d09ea 100644<br>
--- a/.travis.yml<br>
+++ b/.travis.yml<br>
@@ -1,5 +1,4 @@<br>
-sudo: required<br>
-dist: xenial<br>
+dist: bionic<br>
<br>
=C2=A0os: linux<br>
<br>
@@ -11,86 +10,111 @@ env:<br>
=C2=A0 =C2=A0 =C2=A0- PREFIX=3D&quot;${HOME}/opt&quot;<br>
=C2=A0 =C2=A0 =C2=A0- TAP_WINDOWS_VERSION=3D9.23.3<br>
=C2=A0 =C2=A0 =C2=A0- LZO_VERSION=3D2.10<br>
-=C2=A0 =C2=A0 - PKCS11_HELPER_VERSION=3D1.25.1<br>
-=C2=A0 =C2=A0 - MBEDTLS_VERSION=3D2.16.1<br>
+=C2=A0 =C2=A0 - PKCS11_HELPER_VERSION=3D1.26<br>
+=C2=A0 =C2=A0 - MBEDTLS_VERSION=3D2.16.4<br>
=C2=A0 =C2=A0 =C2=A0- MBEDTLS_CFLAGS=3D&quot;-I${PREFIX}/include&quot;<br>
=C2=A0 =C2=A0 =C2=A0- MBEDTLS_LIBS=3D&quot;-L${PREFIX}/lib -lmbedtls -lmbed=
x509 -lmbedcrypto&quot;<br>
-=C2=A0 =C2=A0 - OPENSSL_VERSION=3D1.0.2s<br>
+=C2=A0 =C2=A0 - OPENSSL_VERSION=3D1.0.2u<br>
=C2=A0 =C2=A0 =C2=A0- OPENSSL_CFLAGS=3D&quot;-I${PREFIX}/include&quot;<br>
=C2=A0 =C2=A0 =C2=A0- OPENSSL_LIBS=3D&quot;-L${PREFIX}/lib -lssl -lcrypto&q=
uot;<br>
=C2=A0 =C2=A0 =C2=A0# The next declaration is the encrypted COVERITY_SCAN_T=
OKEN, created<br>
=C2=A0 =C2=A0 =C2=A0#=C2=A0 =C2=A0via the &quot;travis encrypt&quot; comman=
d using the project repo&#39;s public key<br>
=C2=A0 =C2=A0 =C2=A0- secure: &quot;l9mSnEW4LJqjxftH5i1NdDaYfGmQB1mPXnSB3DX=
nsjzkCWZ+yJLfBemfQ0tx/wS7chBYxqUaUIMT0hw4zJVp/LANFJo2vfh//ymTS6h0uApRY1ofg9=
Pp1BFcV1laG6/u8pwSZ2EBy/GhCd3DS436oE8sYBRaFM9FU62L/oeQBfJ7r4ID/0eB1b8bqlbD4=
paty9MHui2P8EZJwR+KAD84prtfpZOcrSMxPh9OUhJxzxUvvVoP4s4+lZ5Kgg1bBQ3yzKGDqe8V=
OgK2BWCEuezqhMMc8oeKmAe7CUkoz5gsGYH++k3I9XzP9Z4xeJKoQnC/82qi4xkJmlaOxdionej=
9bHIcjfRt7D8j1J0U+wOj4p8VrDy7yHaxuN2fi0K5MGa/CaXQSrkna8dePniCng+xQ2MY/zxuRX=
2gA6xPNLUyQLU9LqIug7wj4z84Hk9iWib4L20MoPjeEo+vAUNq8FtjOPxMuHNpv4iGGx6kgJm7R=
Xl5vC5hxfK6MprrnYe2U5Mcd8jpzagKBaKHL3zV2FxX9k0jRO9Mccz7M2WnaV0MQ6zcngzTN4+s=
0kCjhfGKd2F2ANT2Gkhj3Me36eNHfuE0dBbvYCMh4b3Mgd7b/OuXwQWdJ8PjJ1WHXjSOw5sHw1s=
uaV6cEO2Meyz5j1tOkyOi0M9QF+LFenQ9vLH4sBCww8U=3D&quot;<br>
<br>
-matrix:<br>
+jobs:<br>
=C2=A0 =C2=A0include:<br>
-=C2=A0 =C2=A0 - env:<br>
+=C2=A0 =C2=A0 - name: cl<br>
+=C2=A0 =C2=A0 =C2=A0 env:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- SSLLIB=3D&quot;openssl&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- OPENSSL_VERSION=3D&quot;1.1.1d&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- P7Z=3D&quot;c:\Program Files\7-Zip\7z.exe&quot=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- CC=3D&quot;cl&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: windows<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: cl<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; RUN_COVERITY=3D&quot;1&q=
uot;<br>
+=C2=A0 =C2=A0 - name: Coverity scan<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;openssl&quot; RUN_COVERITY=3D&quo=
t;1&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: gcc<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; OPENSSL_VERSION=3D&quot;=
1.0.1u&quot;<br>
+=C2=A0 =C2=A0 - name: gcc | openssl-1.0.1u<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;openssl&quot; OPENSSL_VERSION=3D&=
quot;1.0.1u&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: gcc<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; OPENSSL_VERSION=3D&quot;=
1.1.1c&quot;<br>
+=C2=A0 =C2=A0 - name: gcc | openssl-1.1.1d<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;openssl&quot; OPENSSL_VERSION=3D&=
quot;1.1.1d&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
+=C2=A0 =C2=A0 =C2=A0 arch: amd64<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: gcc<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; OPENSSL_VERSION=3D&quot;=
1.1.1c&quot; LABEL=3D&quot;linux-ppc64le&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 os: linux-ppc64le<br>
+=C2=A0 =C2=A0 - name: gcc | openssl-1.1.1d<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;openssl&quot; OPENSSL_VERSION=3D&=
quot;1.1.1d&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 os: linux<br>
+=C2=A0 =C2=A0 =C2=A0 arch: ppc64le<br>
+=C2=A0 =C2=A0 =C2=A0 compiler: gcc<br>
+=C2=A0 =C2=A0 - name: gcc | openssl-1.1.1d<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;openssl&quot; OPENSSL_VERSION=3D&=
quot;1.1.1d&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 os: linux<br>
+=C2=A0 =C2=A0 =C2=A0 arch: arm64<br>
+=C2=A0 =C2=A0 =C2=A0 compiler: gcc<br>
+=C2=A0 =C2=A0 - name: gcc | openssl-1.1.1d<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;openssl&quot; OPENSSL_VERSION=3D&=
quot;1.1.1d&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 os: linux<br>
+=C2=A0 =C2=A0 =C2=A0 arch: s390x<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: gcc<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; EXTRA_CONFIG=3D&quot;--e=
nable-iproute2&quot;<br>
+=C2=A0 =C2=A0 - name: gcc | openssl-1.0.2u | iproute2<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;openssl&quot; EXTRA_CONFIG=3D&quo=
t;--enable-iproute2&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: gcc<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; CFLAGS=3D&quot;-fsanitiz=
e=3Daddress&quot; CC=3Dclang-9<br>
+=C2=A0 =C2=A0 - name: clang+asan | openssl-1.0.2u<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;openssl&quot; CFLAGS=3D&quot;-fsa=
nitize=3Daddress&quot; CC=3Dclang-9<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: clang<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; OPENSSL_VERSION=3D&quot;=
1.1.1c&quot; CC=3Dclang-9<br>
+=C2=A0 =C2=A0 - name: clang | openssl-1.1.1d<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;openssl&quot; OPENSSL_VERSION=3D&=
quot;1.1.1d&quot; CC=3Dclang-9<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: clang<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;mbedtls&quot;<br>
+=C2=A0 =C2=A0 - name: gcc | mbedtls<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;mbedtls&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: gcc<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;mbedtls&quot; CFLAGS=3D&quot;-fsanitiz=
e=3Daddress&quot; CC=3Dclang-9<br>
+=C2=A0 =C2=A0 - name: clang+asan | mbedtls<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;mbedtls&quot; CFLAGS=3D&quot;-fsa=
nitize=3Daddress&quot; CC=3Dclang-9<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: clang<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot;<br>
+=C2=A0 =C2=A0 - name: clang | openssl-1.0.2u<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;openssl&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: osx<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: clang<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;mbedtls&quot;<br>
+=C2=A0 =C2=A0 - name: clang | mbedtls<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;mbedtls&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: osx<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: clang<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; CHOST=3Dx86_64-w64-mingw=
32 OPENSSL_VERSION=3D&quot;1.0.1u&quot;<br>
+=C2=A0 =C2=A0 - name: mingw64 | openssl-1.0.1u<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;openssl&quot; CHOST=3Dx86_64-w64-=
mingw32 OPENSSL_VERSION=3D&quot;1.0.1u&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: &quot;: Win64 build only&quot;<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; CHOST=3Dx86_64-w64-mingw=
32 OPENSSL_VERSION=3D&quot;1.1.1c&quot;<br>
+=C2=A0 =C2=A0 - name: mingw64 | openssl-1.1.1d<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;openssl&quot; CHOST=3Dx86_64-w64-=
mingw32 OPENSSL_VERSION=3D&quot;1.1.1d&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: &quot;: Win64 build only&quot;<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; CHOST=3Di686-w64-mingw32=
<br>
+=C2=A0 =C2=A0 - name: mingw32 | openssl-1.0.2u<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;openssl&quot; CHOST=3Di686-w64-mi=
ngw32<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: &quot;: Win32 build only&quot;<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; EXTRA_CONFIG=3D&quot;--d=
isable-lzo&quot; EXTRA_SCRIPT=3D&quot;make distcheck&quot; CC=3Dclang-9<br>
+=C2=A0 =C2=A0 - name: clang | openssl-1.0.2u | disable-lzo | distcheck<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;openssl&quot; EXTRA_CONFIG=3D&quo=
t;--disable-lzo&quot; EXTRA_SCRIPT=3D&quot;make distcheck&quot; CC=3Dclang-=
9<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: clang<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; EXTRA_CONFIG=3D&quot;--e=
nable-small&quot; CC=3Dclang-9<br>
+=C2=A0 =C2=A0 - name: clang | openssl-1.0.2u | enable-small<br>
+=C2=A0 =C2=A0 =C2=A0 env: SSLLIB=3D&quot;openssl&quot; EXTRA_CONFIG=3D&quo=
t;--enable-small&quot; CC=3Dclang-9<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: clang<br>
<br>
=C2=A0addons:<br>
=C2=A0 =C2=A0apt:<br>
-=C2=A0 =C2=A0 sources:<br>
-=C2=A0 =C2=A0 =C2=A0 - ubuntu-toolchain-r-test<br>
-=C2=A0 =C2=A0 =C2=A0 - sourceline: &#39;deb <a href=3D"https://apt.llvm.or=
g/xenial/" rel=3D"noreferrer" target=3D"_blank">https://apt.llvm.org/xenial=
/</a> llvm-toolchain-xenial-9 main&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 key_url: &#39;<a href=3D"https://apt.llvm.org/=
llvm-snapshot.gpg.key" rel=3D"noreferrer" target=3D"_blank">https://apt.llv=
m.org/llvm-snapshot.gpg.key</a>&#39;<br>
=C2=A0 =C2=A0 =C2=A0update: true<br>
-=C2=A0 =C2=A0 packages: [ liblzo2-dev, libpam0g-dev, liblz4-dev, linux-lib=
c-dev, man2html, mingw-w64 ]<br>
+=C2=A0 =C2=A0 packages: [ liblzo2-dev, libpam0g-dev, liblz4-dev, linux-lib=
c-dev, man2html, mingw-w64, clang-9, libcmocka-dev ]<br>
=C2=A0 =C2=A0homebrew:<br>
=C2=A0 =C2=A0 =C2=A0update: true<br>
-=C2=A0 =C2=A0 packages: [ lzo ]<br>
+=C2=A0 =C2=A0 packages: [ lzo, lz4, cmocka ]<br>
<br>
=C2=A0cache:<br>
=C2=A0 =C2=A0directories:<br>
@@ -99,9 +123,8 @@ cache:<br>
=C2=A0 =C2=A0- ${HOME}/Library/Caches/Homebrew<br>
<br>
=C2=A0install:<br>
-=C2=A0 - if [ &quot;$TRAVIS_OS_NAME&quot; =3D &quot;linux&quot; ] &amp;&am=
p; [ &quot;$TRAVIS_CPU_ARCH&quot; !=3D &quot;ppc64le&quot; ]; then sudo apt=
-get install clang-9; fi<br>
=C2=A0 =C2=A0- if [ ! -z &quot;${CHOST}&quot; ]; then unset CC; fi<br>
-=C2=A0 - .travis/run-build-deps.sh<br>
+=C2=A0 - travis_wait 30 bash -c &#39;.travis/build-deps.sh &gt; build-deps=
.log 2&gt;&amp;1&#39; || (cat build-deps.log &amp;&amp; exit 1)<br>
<br>
=C2=A0before_script:<br>
=C2=A0 =C2=A0- .travis/coverity.sh<br>
diff --git a/.travis/build-check.sh b/.travis/build-check.sh<br>
index f794704c..4e1b7243 100755<br>
--- a/.travis/build-check.sh<br>
+++ b/.travis/build-check.sh<br>
@@ -6,14 +6,6 @@ if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;windows&quot;=
 ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MSBuild.exe openvpn.sln //p:Platform=3Dx64 &amp=
;&amp; exit 0<br>
=C2=A0fi<br>
<br>
-if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;linux&quot; ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0export LD_LIBRARY_PATH=3D&quot;${PREFIX}/lib:${=
LD_LIBRARY_PATH:-}&quot;<br>
-fi<br>
-<br>
-if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot;=C2=A0 =C2=A0]; then=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0export DYLD_LIBRARY_PATH=3D&quot;${PREFIX}/lib:=
${DYLD_LIBRARY_PATH:-}&quot;<br>
-fi<br>
-<br>
=C2=A0autoreconf -vi<br>
<br>
=C2=A0if [ -z ${CHOST+x} ]; then<br>
@@ -21,7 +13,7 @@ if [ -z ${CHOST+x} ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export EXTRA_CONFIG=
=3D&quot;${EXTRA_CONFIG:-} --enable-werror&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ./configure --with-crypto-library=3D&quot;${SSL=
LIB}&quot; ${EXTRA_CONFIG:-} || (cat config.log &amp;&amp; exit 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0make -j$JOBS<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0make LDFLAGS=3D&quot;-Wl,-rpath,${PREFIX}/lib&q=
uot; -j$JOBS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 src/openvpn/openvpn --version || true<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;li=
nux&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ldd src/openvpn/ope=
nvpn;<br>
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh<br>
index 4c5cb05e..0c8d69b8 100755<br>
--- a/.travis/build-deps.sh<br>
+++ b/.travis/build-deps.sh<br>
@@ -44,17 +44,19 @@ build_lzo () {<br>
=C2=A0}<br>
<br>
=C2=A0download_pkcs11_helper () {<br>
-=C2=A0 =C2=A0 if [ ! -f &quot;pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.b=
z2&quot; ]; then<br>
+=C2=A0 =C2=A0 if [ ! -f &quot;pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.g=
z&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wget -P download-cache/ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;<a href=3D"https://github.=
com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-$%7BPKCS11_HELPER_=
VERSION%7D/pkcs11-helper-$%7BPKCS11_HELPER_VERSION%7D.tar.bz2" rel=3D"noref=
errer" target=3D"_blank">https://github.com/OpenSC/pkcs11-helper/releases/d=
ownload/pkcs11-helper-${PKCS11_HELPER_VERSION}/pkcs11-helper-${PKCS11_HELPE=
R_VERSION}.tar.bz2</a>&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;<a href=3D"https://github.=
com/OpenSC/pkcs11-helper/archive/pkcs11-helper-$%7BPKCS11_HELPER_VERSION%7D=
.tar.gz" rel=3D"noreferrer" target=3D"_blank">https://github.com/OpenSC/pkc=
s11-helper/archive/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.gz</a>&quot;<=
br>
=C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0}<br>
<br>
=C2=A0build_pkcs11_helper () {<br>
=C2=A0 =C2=A0 =C2=A0if [ &quot;$(cat ${PREFIX}/.pkcs11_helper-version)&quot=
; !=3D &quot;${PKCS11_HELPER_VERSION}&quot; ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tar jxf download-cache/pkcs11-helper-${PKCS11_=
HELPER_VERSION}.tar.bz2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tar xf download-cache/pkcs11-helper-${PKCS11_H=
ELPER_VERSION}.tar.gz<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd &quot;pkcs11-helper-${PKCS11_=
HELPER_VERSION}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd &quot;pkcs11-helper-pkcs11-he=
lper-${PKCS11_HELPER_VERSION}&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 autoreconf -iv<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./configure --host=3D${CHOS=
T} --program-prefix=3D&#39;&#39; --libdir=3D${PREFIX}/lib \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --prefix=3D$=
{PREFIX} --build=3Dx86_64-pc-linux-gnu \<br>
diff --git a/.travis/run-build-deps.sh b/.travis/run-build-deps.sh<br>
deleted file mode 100755<br>
index b8eb41c5..00000000<br>
--- a/.travis/run-build-deps.sh<br>
+++ /dev/null<br>
@@ -1,10 +0,0 @@<br>
-#!/bin/sh<br>
-set -eux<br>
-<br>
-if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;windows&quot; ]; then<br>
-=C2=A0 =C2=A0 # for windows we need to print output since openssl build<br>
-=C2=A0 =C2=A0 # might take more than 10 minutes, which causes build abort<=
br>
-=C2=A0 =C2=A0 .travis/build-deps.sh<br>
-else<br>
-=C2=A0 =C2=A0 .travis/build-deps.sh &gt; build-deps.log 2&gt;&amp;1 || (ca=
t build-deps.log &amp;&amp; exit 1)<br>
-fi<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>

--0000000000004b1d4e05a170d1b4--

