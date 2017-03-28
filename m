MIME-Version: 1.0
In-Reply-To: <1490527279-31426-1-git-send-email-chipitsine@...277...>
References: <1490527279-31426-1-git-send-email-chipitsine@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 28 Mar 2017 11:50:42 +0500
Message-ID: <CAFHpkQE4bv2VzE-GzZ-hQvfwjMhn-w5BVCFAM_nzOjXzcUz=ow@...278...>
Content-Type: multipart/alternative; boundary=94eb2c03c314f14bbe054bc4e03c
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: add 2 mingw "build only
	configurations"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c03c314f14bbe054bc4e03c
Content-Type: text/plain; charset=UTF-8

I opened https://github.com/OpenVPN/openvpn/pull/85
for discussion

thoughts ?

2017-03-26 16:21 GMT+05:00 Ilya Shipitsin <chipitsine@...277...>:

> Inspired by https://www.mail-archive.com/openvpn-devel@...1199...
> sourceforge.net/msg13032.html
> build options are taken from regular windows installer builds
>
> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> ---
>  .travis.yml           | 30 +++++++++++++++++++++-------
>  .travis/build-deps.sh | 55 ++++++++++++++++++++++++++++++
> ++++++++++++++++-----
>  2 files changed, 73 insertions(+), 12 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 3c0aa7d..9ab30a2 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -12,6 +12,9 @@ env:
>    global:
>      - JOBS=3
>      - PREFIX="${HOME}/opt"
> +    - TAP_WINDOWS_VERSION=9.21.2
> +    - LZO_VERSION=2.10
> +    - PKCS11_HELPER_VERSION=1.11
>      - MBEDTLS_VERSION="2.4.0"
>      - MBEDTLS_CFLAGS="-I${PREFIX}/include"
>      - MBEDTLS_LIBS="-L${PREFIX}/lib -lmbedtls -lmbedx509 -lmbedcrypto"
> @@ -50,6 +53,12 @@ matrix:
>        os: osx
>        osx_image: xcode7.3
>        compiler: clang
> +    - env: SSLLIB="openssl" CHOST=x86_64-w64-mingw32
> +      os: linux
> +      compiler: ": Win64 build only"
> +    - env: SSLLIB="openssl" CHOST=i686-w64-mingw32
> +      os: linux
> +      compiler: ": Win32 build only"
>    exclude:
>      - compiler: gcc
>
> @@ -60,6 +69,7 @@ addons:
>        - libpam0g-dev
>        - liblz4-dev
>        - linux-libc-dev
> +      - man2html
>
>  cache:
>    ccache: true
> @@ -72,16 +82,22 @@ before_install:
>    - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew install lzo; fi
>
>  install:
> +  - if [ ! -z "${CHOST+xxx}" ]; then unset CC; unset CXX; fi
>    - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log &&
> exit 1)
>
>  script:
>    - if [ "${TRAVIS_OS_NAME}" = "linux" ]; then export
> LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"; fi
>    - if [ "${TRAVIS_OS_NAME}" = "osx"   ]; then export
> DYLD_LIBRARY_PATH="${PREFIX}/lib:${DYLD_LIBRARY_PATH}"; fi
>    - autoreconf -vi
> -  - ./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG} ||
> (cat config.log && exit 1)
> -  - make -j$JOBS
> -  - src/openvpn/openvpn --version || true
> -  - if [ "${TRAVIS_OS_NAME}" = "linux" ]; then ldd src/openvpn/openvpn; fi
> -  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then otool -L
> src/openvpn/openvpn; fi
> -  - make check
> -  - $EXTRA_SCRIPT
> +  - if [ -z "${CHOST+xxx}" ]; then
> +      ./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG} ||
> (cat config.log && exit 1);
> +      make -j$JOBS;
> +      src/openvpn/openvpn --version || true;
> +      if [ "${TRAVIS_OS_NAME}" = "linux" ]; then ldd src/openvpn/openvpn;
> fi;
> +      if [ "${TRAVIS_OS_NAME}" = "osx" ]; then otool -L
> src/openvpn/openvpn; fi;
> +      make check;
> +      $EXTRA_SCRIPT;
> +    else
> +      TAP_CFLAGS="-I${PWD}/tap-windows-${TAP_WINDOWS_VERSION}/include"
> LZO_CFLAGS="-I${PREFIX}/include" LZO_LIBS="-L${PREFIX}/lib -llzo2"
> PKCS11_HELPER_LIBS="-L${PREFIX}/lib -lpkcs11-helper"
> PKCS11_HELPER_CFLAGS="-I${PREFIX}/include" ./configure --host=${CHOST}
> --build=x86_64-pc-linux-gnu --enable-pkcs11 --disable-plugins || (cat
> config.log && exit 1);
> +      make -j$JOBS;
> +    fi
> diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
> index 3ffba0b..18f40ec 100755
> --- a/.travis/build-deps.sh
> +++ b/.travis/build-deps.sh
> @@ -31,7 +31,6 @@ download_openssl () {
>  }
>
>  build_openssl_linux () {
> -    tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
>      (
>          cd "openssl-${OPENSSL_VERSION}/"
>          ./config shared --openssldir="${PREFIX}" -DPURIFY
> @@ -40,7 +39,6 @@ build_openssl_linux () {
>  }
>
>  build_openssl_osx () {
> -    tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
>      (
>          cd "openssl-${OPENSSL_VERSION}/"
>          ./Configure darwin64-x86_64-cc shared \
> @@ -49,9 +47,25 @@ build_openssl_osx () {
>      )
>  }
>
> +build_openssl_mingw () {
> +    (
> +        cd "openssl-${OPENSSL_VERSION}/"
> +
> +        if [ "${CHOST}" = "i686-w64-mingw32" ]; then export target=mingw;
> fi
> +        if [ "${CHOST}" = "x86_64-w64-mingw32" ]; then export
> target=mingw64; fi
> +
> +        ./Configure --cross-compile-prefix=${CHOST}- shared \
> +           $target no-multilib no-capieng --openssldir="${PREFIX}"
> -static-libgcc
> +        make install
> +    )
> +}
> +
>  build_openssl () {
>      if [ "$(cat ${PREFIX}/.openssl-version)" != "${OPENSSL_VERSION}" ];
> then
> -        if [ "${TRAVIS_OS_NAME}" = "osx" ]; then
> +        tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
> +        if [ ! -z ${CHOST+xxx} ]; then
> +            build_openssl_mingw
> +        elif [ "${TRAVIS_OS_NAME}" = "osx" ]; then
>              build_openssl_osx
>          elif [ "${TRAVIS_OS_NAME}" = "linux" ]; then
>              build_openssl_linux
> @@ -61,7 +75,7 @@ build_openssl () {
>  }
>
>  # Enable ccache
> -if [ "${TRAVIS_OS_NAME}" != "osx" ]; then
> +if [ "${TRAVIS_OS_NAME}" != "osx" ] && [ -z "${CHOST+xxx}" ]; then
>      # ccache not available on osx, see:
>      # https://github.com/travis-ci/travis-ci/issues/5567
>      mkdir -p "${HOME}/bin"
> @@ -70,7 +84,6 @@ if [ "${TRAVIS_OS_NAME}" != "osx" ]; then
>  fi
>
>  # Download and build crypto lib
> -mkdir -p download-cache
>  if [ "${SSLLIB}" = "openssl" ]; then
>      download_openssl
>      build_openssl
> @@ -81,3 +94,35 @@ else
>      echo "Invalid crypto lib: ${SSLLIB}"
>      exit 1
>  fi
> +
> +if [ ! -z ${CHOST+xxx} ]; then
> +      echo "deb http://archive.ubuntu.com/ubuntu xenial main universe" |
> sudo tee -a /etc/apt/sources.list.d/xenial.list
> +      echo "deb http://archive.ubuntu.com/ubuntu xenial main" | sudo tee
> -a /etc/apt/sources.list.d/xenial.list
> +      sudo apt-get update
> +      sudo apt-get -y install dpkg mingw-w64
> +      if [ ! -f "download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip"
> ]; then
> +         wget -P download-cache/ http://build.openvpn.net/
> downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip
> +      fi
> +      unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip
> +
> +      (
> +      wget -P download-cache/ http://www.oberhumer.com/
> opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz
> +      tar zxf download-cache/lzo-${LZO_VERSION}.tar.gz
> +      cd lzo-${LZO_VERSION}
> +
> +      ./configure --host=${CHOST} --program-prefix='' --enable-shared
> --libdir=${PREFIX}/lib --prefix=${PREFIX} --build=x86_64-pc-linux-gnu
> +      make
> +      make install
> +      )
> +
> +      (
> +      wget -P download-cache/ http://downloads.sourceforge.
> net/project/opensc/pkcs11-helper/pkcs11-helper-${PKCS11_
> HELPER_VERSION}.tar.bz2
> +      tar jxf download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.
> bz2
> +      cd pkcs11-helper-${PKCS11_HELPER_VERSION}
> +
> +      ./configure --host=${CHOST} --program-prefix='' --enable-shared
> --libdir=${PREFIX}/lib --prefix=${PREFIX} --build=x86_64-pc-linux-gnu
> --disable-crypto-engine-gnutls --disable-crypto-engine-nss
> +      make
> +      make install
> +      )
> +
> +fi
> --
> 2.5.5
>
>

--94eb2c03c314f14bbe054bc4e03c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>I opened <a href=3D"https://github.com/OpenVPN/o=
penvpn/pull/85">https://github.com/OpenVPN/openvpn/pull/85</a><br></div>for=
 discussion<br><br></div>thoughts ?<br></div><div class=3D"gmail_extra"><br=
><div class=3D"gmail_quote">2017-03-26 16:21 GMT+05:00 Ilya Shipitsin <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_blank">=
chipitsine@...277...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Insp=
ired by <a href=3D"https://www.mail-archive.com/openvpn-devel@...1535...=
orge.net/msg13032.html" rel=3D"noreferrer" target=3D"_blank">https://www.ma=
il-archive.com/<wbr>openvpn-devel@...1199...<wbr>sourceforge.net/msg13032.h=
tml</a><br>
build options are taken from regular windows installer builds<br>
<br>
Signed-off-by: Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...277...">c=
hipitsine@...277...</a>&gt;<br>
---<br>
=C2=A0.travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 ++++++++++++=
+++++++++-------<br>
=C2=A0.travis/build-deps.sh | 55 ++++++++++++++++++++++++++++++<wbr>+++++++=
+++++++++-----<br>
=C2=A02 files changed, 73 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/.travis.yml b/.travis.yml<br>
index 3c0aa7d..9ab30a2 100644<br>
--- a/.travis.yml<br>
+++ b/.travis.yml<br>
@@ -12,6 +12,9 @@ env:<br>
=C2=A0 =C2=A0global:<br>
=C2=A0 =C2=A0 =C2=A0- JOBS=3D3<br>
=C2=A0 =C2=A0 =C2=A0- PREFIX=3D&quot;${HOME}/opt&quot;<br>
+=C2=A0 =C2=A0 - TAP_WINDOWS_VERSION=3D9.21.2<br>
+=C2=A0 =C2=A0 - LZO_VERSION=3D2.10<br>
+=C2=A0 =C2=A0 - PKCS11_HELPER_VERSION=3D1.11<br>
=C2=A0 =C2=A0 =C2=A0- MBEDTLS_VERSION=3D&quot;2.4.0&quot;<br>
=C2=A0 =C2=A0 =C2=A0- MBEDTLS_CFLAGS=3D&quot;-I${PREFIX}/<wbr>include&quot;=
<br>
=C2=A0 =C2=A0 =C2=A0- MBEDTLS_LIBS=3D&quot;-L${PREFIX}/lib -lmbedtls -lmbed=
x509 -lmbedcrypto&quot;<br>
@@ -50,6 +53,12 @@ matrix:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: osx<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0osx_image: xcode7.3<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: clang<br>
+=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; CHOST=3Dx86_64-w64-mingw=
32<br>
+=C2=A0 =C2=A0 =C2=A0 os: linux<br>
+=C2=A0 =C2=A0 =C2=A0 compiler: &quot;: Win64 build only&quot;<br>
+=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; CHOST=3Di686-w64-mingw32=
<br>
+=C2=A0 =C2=A0 =C2=A0 os: linux<br>
+=C2=A0 =C2=A0 =C2=A0 compiler: &quot;: Win32 build only&quot;<br>
=C2=A0 =C2=A0exclude:<br>
=C2=A0 =C2=A0 =C2=A0- compiler: gcc<br>
<br>
@@ -60,6 +69,7 @@ addons:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- libpam0g-dev<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- liblz4-dev<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- linux-libc-dev<br>
+=C2=A0 =C2=A0 =C2=A0 - man2html<br>
<br>
=C2=A0cache:<br>
=C2=A0 =C2=A0ccache: true<br>
@@ -72,16 +82,22 @@ before_install:<br>
=C2=A0 =C2=A0- if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot; ]; th=
en brew install lzo; fi<br>
<br>
=C2=A0install:<br>
+=C2=A0 - if [ ! -z &quot;${CHOST+xxx}&quot; ]; then unset CC; unset CXX; f=
i<br>
=C2=A0 =C2=A0- .travis/build-deps.sh &gt; build-deps.log 2&gt;&amp;1 || (ca=
t build-deps.log &amp;&amp; exit 1)<br>
<br>
=C2=A0script:<br>
=C2=A0 =C2=A0- if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;linux&quot; ]; =
then export LD_LIBRARY_PATH=3D&quot;${PREFIX}/<wbr>lib:${LD_LIBRARY_PATH}&q=
uot;; fi<br>
=C2=A0 =C2=A0- if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot;=C2=A0=
 =C2=A0]; then export DYLD_LIBRARY_PATH=3D&quot;${PREFIX}/<wbr>lib:${DYLD_L=
IBRARY_PATH}&quot;; fi<br>
=C2=A0 =C2=A0- autoreconf -vi<br>
-=C2=A0 - ./configure --with-crypto-library=3D&quot;${<wbr>SSLLIB}&quot; ${=
EXTRA_CONFIG} || (cat config.log &amp;&amp; exit 1)<br>
-=C2=A0 - make -j$JOBS<br>
-=C2=A0 - src/openvpn/openvpn --version || true<br>
-=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;linux&quot; ]; then =
ldd src/openvpn/openvpn; fi<br>
-=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot; ]; then ot=
ool -L src/openvpn/openvpn; fi<br>
-=C2=A0 - make check<br>
-=C2=A0 - $EXTRA_SCRIPT<br>
+=C2=A0 - if [ -z &quot;${CHOST+xxx}&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 ./configure --with-crypto-library=3D&quot;${<wbr>SSLL=
IB}&quot; ${EXTRA_CONFIG} || (cat config.log &amp;&amp; exit 1);<br>
+=C2=A0 =C2=A0 =C2=A0 make -j$JOBS;<br>
+=C2=A0 =C2=A0 =C2=A0 src/openvpn/openvpn --version || true;<br>
+=C2=A0 =C2=A0 =C2=A0 if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;linux&qu=
ot; ]; then ldd src/openvpn/openvpn; fi;<br>
+=C2=A0 =C2=A0 =C2=A0 if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot=
; ]; then otool -L src/openvpn/openvpn; fi;<br>
+=C2=A0 =C2=A0 =C2=A0 make check;<br>
+=C2=A0 =C2=A0 =C2=A0 $EXTRA_SCRIPT;<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 TAP_CFLAGS=3D&quot;-I${PWD}/tap-<wbr>windows-${TAP_WI=
NDOWS_VERSION}<wbr>/include&quot; LZO_CFLAGS=3D&quot;-I${PREFIX}/<wbr>inclu=
de&quot; LZO_LIBS=3D&quot;-L${PREFIX}/lib -llzo2&quot; PKCS11_HELPER_LIBS=
=3D&quot;-L${<wbr>PREFIX}/lib -lpkcs11-helper&quot; PKCS11_HELPER_CFLAGS=3D=
&quot;-I${<wbr>PREFIX}/include&quot; ./configure --host=3D${CHOST} --build=
=3Dx86_64-pc-linux-gnu --enable-pkcs11 --disable-plugins || (cat config.log=
 &amp;&amp; exit 1);<br>
+=C2=A0 =C2=A0 =C2=A0 make -j$JOBS;<br>
+=C2=A0 =C2=A0 fi<br>
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh<br>
index 3ffba0b..18f40ec 100755<br>
--- a/.travis/build-deps.sh<br>
+++ b/.travis/build-deps.sh<br>
@@ -31,7 +31,6 @@ download_openssl () {<br>
=C2=A0}<br>
<br>
=C2=A0build_openssl_linux () {<br>
-=C2=A0 =C2=A0 tar zxf &quot;download-cache/openssl-${<wbr>OPENSSL_VERSION}=
.tar.gz&quot;<br>
=C2=A0 =C2=A0 =C2=A0(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cd &quot;openssl-${OPENSSL_VERSION}/&quot=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./config shared --openssldir=3D&quot;${PR=
EFIX}&quot; -DPURIFY<br>
@@ -40,7 +39,6 @@ build_openssl_linux () {<br>
=C2=A0}<br>
<br>
=C2=A0build_openssl_osx () {<br>
-=C2=A0 =C2=A0 tar zxf &quot;download-cache/openssl-${<wbr>OPENSSL_VERSION}=
.tar.gz&quot;<br>
=C2=A0 =C2=A0 =C2=A0(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cd &quot;openssl-${OPENSSL_VERSION}/&quot=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./Configure darwin64-x86_64-cc shared \<b=
r>
@@ -49,9 +47,25 @@ build_openssl_osx () {<br>
=C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0}<br>
<br>
+build_openssl_mingw () {<br>
+=C2=A0 =C2=A0 (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cd &quot;openssl-${OPENSSL_VERSION}/&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ &quot;${CHOST}&quot; =3D &quot;i686-w64-m=
ingw32&quot; ]; then export target=3Dmingw; fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ &quot;${CHOST}&quot; =3D &quot;x86_64-w64=
-mingw32&quot; ]; then export target=3Dmingw64; fi<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ./Configure --cross-compile-prefix=3D${<wbr>CH=
OST}- shared \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$target no-multilib no-capieng --=
openssldir=3D&quot;${PREFIX}&quot; -static-libgcc<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 make install<br>
+=C2=A0 =C2=A0 )<br>
+}<br>
+<br>
=C2=A0build_openssl () {<br>
=C2=A0 =C2=A0 =C2=A0if [ &quot;$(cat ${PREFIX}/.openssl-version)&quot; !=3D=
 &quot;${OPENSSL_VERSION}&quot; ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;o=
sx&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tar zxf &quot;download-cache/openssl-${<wbr>OP=
ENSSL_VERSION}.tar.gz&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ ! -z ${CHOST+xxx} ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_openssl_mingw<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot=
;osx&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_openssl_osx<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif [ &quot;${TRAVIS_OS_NAME}&quot; =3D =
&quot;linux&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_openssl_linux<br>
@@ -61,7 +75,7 @@ build_openssl () {<br>
=C2=A0}<br>
<br>
=C2=A0# Enable ccache<br>
-if [ &quot;${TRAVIS_OS_NAME}&quot; !=3D &quot;osx&quot; ]; then<br>
+if [ &quot;${TRAVIS_OS_NAME}&quot; !=3D &quot;osx&quot; ] &amp;&amp; [ -z =
&quot;${CHOST+xxx}&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0# ccache not available on osx, see:<br>
=C2=A0 =C2=A0 =C2=A0# <a href=3D"https://github.com/travis-ci/travis-ci/iss=
ues/5567" rel=3D"noreferrer" target=3D"_blank">https://github.com/travis-ci=
/<wbr>travis-ci/issues/5567</a><br>
=C2=A0 =C2=A0 =C2=A0mkdir -p &quot;${HOME}/bin&quot;<br>
@@ -70,7 +84,6 @@ if [ &quot;${TRAVIS_OS_NAME}&quot; !=3D &quot;osx&quot; ]=
; then<br>
=C2=A0fi<br>
<br>
=C2=A0# Download and build crypto lib<br>
-mkdir -p download-cache<br>
=C2=A0if [ &quot;${SSLLIB}&quot; =3D &quot;openssl&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0download_openssl<br>
=C2=A0 =C2=A0 =C2=A0build_openssl<br>
@@ -81,3 +94,35 @@ else<br>
=C2=A0 =C2=A0 =C2=A0echo &quot;Invalid crypto lib: ${SSLLIB}&quot;<br>
=C2=A0 =C2=A0 =C2=A0exit 1<br>
=C2=A0fi<br>
+<br>
+if [ ! -z ${CHOST+xxx} ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 echo &quot;deb <a href=3D"http://archive.ubuntu.com/u=
buntu" rel=3D"noreferrer" target=3D"_blank">http://archive.ubuntu.com/<wbr>=
ubuntu</a> xenial main universe&quot; | sudo tee -a /etc/apt/sources.list.d=
/<wbr>xenial.list<br>
+=C2=A0 =C2=A0 =C2=A0 echo &quot;deb <a href=3D"http://archive.ubuntu.com/u=
buntu" rel=3D"noreferrer" target=3D"_blank">http://archive.ubuntu.com/<wbr>=
ubuntu</a> xenial main&quot; | sudo tee -a /etc/apt/sources.list.d/<wbr>xen=
ial.list<br>
+=C2=A0 =C2=A0 =C2=A0 sudo apt-get update<br>
+=C2=A0 =C2=A0 =C2=A0 sudo apt-get -y install dpkg mingw-w64<br>
+=C2=A0 =C2=A0 =C2=A0 if [ ! -f &quot;download-cache/tap-windows-${<wbr>TAP=
_WINDOWS_VERSION}.zip&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wget -P download-cache/ <a href=3D"http:=
//build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.z=
ip" rel=3D"noreferrer" target=3D"_blank">http://build.openvpn.net/<wbr>down=
loads/releases/tap-<wbr>windows-${TAP_WINDOWS_VERSION}<wbr>.zip</a><br>
+=C2=A0 =C2=A0 =C2=A0 fi<br>
+=C2=A0 =C2=A0 =C2=A0 unzip download-cache/tap-windows-${<wbr>TAP_WINDOWS_V=
ERSION}.zip<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 (<br>
+=C2=A0 =C2=A0 =C2=A0 wget -P download-cache/ <a href=3D"http://www.oberhum=
er.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz" rel=3D"noreferrer=
" target=3D"_blank">http://www.oberhumer.com/<wbr>opensource/lzo/download/l=
zo-${<wbr>LZO_VERSION}.tar.gz</a><br>
+=C2=A0 =C2=A0 =C2=A0 tar zxf download-cache/lzo-${LZO_<wbr>VERSION}.tar.gz=
<br>
+=C2=A0 =C2=A0 =C2=A0 cd lzo-${LZO_VERSION}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 ./configure --host=3D${CHOST} --program-prefix=3D&#39=
;&#39; --enable-shared --libdir=3D${PREFIX}/lib --prefix=3D${PREFIX} --buil=
d=3Dx86_64-pc-linux-gnu<br>
+=C2=A0 =C2=A0 =C2=A0 make<br>
+=C2=A0 =C2=A0 =C2=A0 make install<br>
+=C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 (<br>
+=C2=A0 =C2=A0 =C2=A0 wget -P download-cache/ <a href=3D"http://downloads.s=
ourceforge.net/project/opensc/pkcs11-helper/pkcs11-helper-${PKCS11_HELPER_V=
ERSION}.tar.bz2" rel=3D"noreferrer" target=3D"_blank">http://downloads.sour=
ceforge.<wbr>net/project/opensc/pkcs11-<wbr>helper/pkcs11-helper-${PKCS11_<=
wbr>HELPER_VERSION}.tar.bz2</a><br>
+=C2=A0 =C2=A0 =C2=A0 tar jxf download-cache/pkcs11-helper-$<wbr>{PKCS11_HE=
LPER_VERSION}.tar.<wbr>bz2<br>
+=C2=A0 =C2=A0 =C2=A0 cd pkcs11-helper-${PKCS11_HELPER_<wbr>VERSION}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 ./configure --host=3D${CHOST} --program-prefix=3D&#39=
;&#39; --enable-shared --libdir=3D${PREFIX}/lib --prefix=3D${PREFIX} --buil=
d=3Dx86_64-pc-linux-gnu --disable-crypto-engine-gnutls --disable-crypto-eng=
ine-nss<br>
+=C2=A0 =C2=A0 =C2=A0 make<br>
+=C2=A0 =C2=A0 =C2=A0 make install<br>
+=C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+fi<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.5.5<br>
<br>
</font></span></blockquote></div><br></div>

--94eb2c03c314f14bbe054bc4e03c--

