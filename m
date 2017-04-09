MIME-Version: 1.0
In-Reply-To: <12987e8a-1873-fc96-3b4f-0576939773fb@...1856...>
References: <1490527279-31426-1-git-send-email-chipitsine@...277...>
	<12987e8a-1873-fc96-3b4f-0576939773fb@...1856...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 9 Apr 2017 15:54:23 +0500
Message-ID: <CAFHpkQHyR+fO-PpK-q+vHvWC02sjRiOWkcwOTje7g6wqyZyEYg@...278...>
Content-Type: multipart/alternative; boundary=f403045f55947f5fb4054cb9aea2
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
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--f403045f55947f5fb4054cb9aea2
Content-Type: text/plain; charset=UTF-8

2017-04-09 13:44 GMT+05:00 Steffan Karger <steffan@...1856...>:

> Hi,
>
> On 26-03-17 13:21, Ilya Shipitsin wrote:
> > Inspired by https://www.mail-archive.com/openvpn-devel@...1199...
> sourceforge.net/msg13032.html
> > build options are taken from regular windows installer builds
>
> Feature-ACK.  Adding cross-compile builds for Windows on travis is a
> good plan.
>
> Initial feedback below.
>
> >
> > Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> > ---
> >  .travis.yml           | 30 +++++++++++++++++++++-------
> >  .travis/build-deps.sh | 55 ++++++++++++++++++++++++++++++
> ++++++++++++++++-----
> >  2 files changed, 73 insertions(+), 12 deletions(-)
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index 3c0aa7d..9ab30a2 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -12,6 +12,9 @@ env:
> >    global:
> >      - JOBS=3
> >      - PREFIX="${HOME}/opt"
> > +    - TAP_WINDOWS_VERSION=9.21.2
> > +    - LZO_VERSION=2.10
> > +    - PKCS11_HELPER_VERSION=1.11
> >      - MBEDTLS_VERSION="2.4.0"
> >      - MBEDTLS_CFLAGS="-I${PREFIX}/include"
> >      - MBEDTLS_LIBS="-L${PREFIX}/lib -lmbedtls -lmbedx509 -lmbedcrypto"
> > @@ -50,6 +53,12 @@ matrix:
> >        os: osx
> >        osx_image: xcode7.3
> >        compiler: clang
> > +    - env: SSLLIB="openssl" CHOST=x86_64-w64-mingw32
> > +      os: linux
> > +      compiler: ": Win64 build only"
> > +    - env: SSLLIB="openssl" CHOST=i686-w64-mingw32
> > +      os: linux
> > +      compiler: ": Win32 build only"
> >    exclude:
> >      - compiler: gcc
> >
> > @@ -60,6 +69,7 @@ addons:
> >        - libpam0g-dev
> >        - liblz4-dev
> >        - linux-libc-dev
> > +      - man2html
> >
> >  cache:
> >    ccache: true
> > @@ -72,16 +82,22 @@ before_install:
> >    - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew install lzo; fi
> >
> >  install:
> > +  - if [ ! -z "${CHOST+xxx}" ]; then unset CC; unset CXX; fi
>
> What is the function of this +xxx ?  It seems to me that all you need is
> "if [ ! -z "${CHOST}" ]".
>

> >    - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log
> && exit 1)
> >
> >  script:
> >    - if [ "${TRAVIS_OS_NAME}" = "linux" ]; then export
> LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"; fi
> >    - if [ "${TRAVIS_OS_NAME}" = "osx"   ]; then export
> DYLD_LIBRARY_PATH="${PREFIX}/lib:${DYLD_LIBRARY_PATH}"; fi
> >    - autoreconf -vi
> > -  - ./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG} ||
> (cat config.log && exit 1)
> > -  - make -j$JOBS
> > -  - src/openvpn/openvpn --version || true
> > -  - if [ "${TRAVIS_OS_NAME}" = "linux" ]; then ldd src/openvpn/openvpn;
> fi
> > -  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then otool -L
> src/openvpn/openvpn; fi
> > -  - make check
> > -  - $EXTRA_SCRIPT
> > +  - if [ -z "${CHOST+xxx}" ]; then
> > +      ./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG} ||
> (cat config.log && exit 1);
> > +      make -j$JOBS;
> > +      src/openvpn/openvpn --version || true;
> > +      if [ "${TRAVIS_OS_NAME}" = "linux" ]; then ldd
> src/openvpn/openvpn; fi;
> > +      if [ "${TRAVIS_OS_NAME}" = "osx" ]; then otool -L
> src/openvpn/openvpn; fi;
> > +      make check;
> > +      $EXTRA_SCRIPT;
> > +    else
> > +      TAP_CFLAGS="-I${PWD}/tap-windows-${TAP_WINDOWS_VERSION}/include"
> LZO_CFLAGS="-I${PREFIX}/include" LZO_LIBS="-L${PREFIX}/lib -llzo2"
> PKCS11_HELPER_LIBS="-L${PREFIX}/lib -lpkcs11-helper"
> PKCS11_HELPER_CFLAGS="-I${PREFIX}/include" ./configure --host=${CHOST}
> --build=x86_64-pc-linux-gnu --enable-pkcs11 --disable-plugins || (cat
> config.log && exit 1);
>
> All these _CFLAGS and _LIBS should go into the env: section above.
>

there are 3 "env" sections: global and 2 "mingw".
I'm afraid, defining those variables in global section might have some side
effect, while specifying variables 2 times in both mingw sections also do
not make much sense.



>
> Any reason to --enable-pkcs11 for the windows builds, while that's not
> done for the non-windows builds?
>

regular windows installer is built with pkcs11. that's why I added that
option.
build matrix for non-windows builds was discussed and nobody asked me to
add pkcs11 there.


>
> > +      make -j$JOBS;
> > +    fi
> > diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
> > index 3ffba0b..18f40ec 100755
> > --- a/.travis/build-deps.sh
> > +++ b/.travis/build-deps.sh
> > @@ -31,7 +31,6 @@ download_openssl () {
> >  }
> >
> >  build_openssl_linux () {
> > -    tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
> >      (
> >          cd "openssl-${OPENSSL_VERSION}/"
> >          ./config shared --openssldir="${PREFIX}" -DPURIFY
> > @@ -40,7 +39,6 @@ build_openssl_linux () {
> >  }
> >
> >  build_openssl_osx () {
> > -    tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
> >      (
> >          cd "openssl-${OPENSSL_VERSION}/"
> >          ./Configure darwin64-x86_64-cc shared \
> > @@ -49,9 +47,25 @@ build_openssl_osx () {
> >      )
> >  }
> >
> > +build_openssl_mingw () {
> > +    (
> > +        cd "openssl-${OPENSSL_VERSION}/"
> > +
> > +        if [ "${CHOST}" = "i686-w64-mingw32" ]; then export
> target=mingw; fi
> > +        if [ "${CHOST}" = "x86_64-w64-mingw32" ]; then export
> target=mingw64; fi
> > +
> > +        ./Configure --cross-compile-prefix=${CHOST}- shared \
> > +           $target no-multilib no-capieng --openssldir="${PREFIX}"
> -static-libgcc
>
> Can you try to keep style consistent?  I.e. use all-caps variable names
> (TARGET instead of target) and use quoting ("${TARGET}" instead of
> $target).
>

yes, I can


>
> > +        make install
> > +    )
> > +}
> > +
> >  build_openssl () {
> >      if [ "$(cat ${PREFIX}/.openssl-version)" != "${OPENSSL_VERSION}" ];
> then
> > -        if [ "${TRAVIS_OS_NAME}" = "osx" ]; then
> > +        tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
> > +        if [ ! -z ${CHOST+xxx} ]; then
> > +            build_openssl_mingw
> > +        elif [ "${TRAVIS_OS_NAME}" = "osx" ]; then
> >              build_openssl_osx
> >          elif [ "${TRAVIS_OS_NAME}" = "linux" ]; then
> >              build_openssl_linux
> > @@ -61,7 +75,7 @@ build_openssl () {
> >  }
> >
> >  # Enable ccache
> > -if [ "${TRAVIS_OS_NAME}" != "osx" ]; then
> > +if [ "${TRAVIS_OS_NAME}" != "osx" ] && [ -z "${CHOST+xxx}" ]; then
> >      # ccache not available on osx, see:
> >      # https://github.com/travis-ci/travis-ci/issues/5567
>
> Is ccache not available for mingw?  In that case, please update the
> comment, preferably with a reference to a travis issue so that we can
> enable it if travis adds support later on.
>

I could not get ccache working with mingw, but there's no issue, I'm not
sure it is related to travis either.



>
> >      mkdir -p "${HOME}/bin"
> > @@ -70,7 +84,6 @@ if [ "${TRAVIS_OS_NAME}" != "osx" ]; then
> >  fi
> >
> >  # Download and build crypto lib
> > -mkdir -p download-cache
> >  if [ "${SSLLIB}" = "openssl" ]; then
> >      download_openssl
> >      build_openssl
> > @@ -81,3 +94,35 @@ else
> >      echo "Invalid crypto lib: ${SSLLIB}"
> >      exit 1
> >  fi
> > +
> > +if [ ! -z ${CHOST+xxx} ]; then
> > +      echo "deb http://archive.ubuntu.com/ubuntu xenial main universe"
> | sudo tee -a /etc/apt/sources.list.d/xenial.list
> > +      echo "deb http://archive.ubuntu.com/ubuntu xenial main" | sudo
> tee -a /etc/apt/sources.list.d/xenial.list
> > +      sudo apt-get update
> > +      sudo apt-get -y install dpkg mingw-w64
> > +      if [ ! -f "download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip"
> ]; then
> > +         wget -P download-cache/ http://build.openvpn.net/
> downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip
> > +      fi
>
> This should be in a download_tap_windows() function.
>

can you be more particular on "should be".
it does not mean "must be".
if so, we can leave it, right ?


>
> > +      unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip
> > +
> > +      (
> > +      wget -P download-cache/ http://www.oberhumer.com/
> opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz
> > +      tar zxf download-cache/lzo-${LZO_VERSION}.tar.gz
>
> This should be in a download_lzo() function.
>
> > +      cd lzo-${LZO_VERSION}
> > +
> > +      ./configure --host=${CHOST} --program-prefix='' --enable-shared
> --libdir=${PREFIX}/lib --prefix=${PREFIX} --build=x86_64-pc-linux-gnu
> > +      make
> > +      make install
>
> This should bin in a build_lzo() function.
>
> > +      )
> > +
> > +      (
> > +      wget -P download-cache/ http://downloads.sourceforge.
> net/project/opensc/pkcs11-helper/pkcs11-helper-${PKCS11_
> HELPER_VERSION}.tar.bz2
>
> This should be in a download_pkcs11helper() function.
>
> > +      tar jxf download-cache/pkcs11-helper-$
> {PKCS11_HELPER_VERSION}.tar.bz2
> > +      cd pkcs11-helper-${PKCS11_HELPER_VERSION}
> > +
> > +      ./configure --host=${CHOST} --program-prefix='' --enable-shared
> --libdir=${PREFIX}/lib --prefix=${PREFIX} --build=x86_64-pc-linux-gnu
> --disable-crypto-engine-gnutls --disable-crypto-engine-nss
> > +      make
> > +      make install
>
> This should be in a build_pkcs11helper() function.
>
> > +      )
> > +
> > +fi
> >
>
> -Steffan
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--f403045f55947f5fb4054cb9aea2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-04-09 13:44 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On 26-03-17 13:21, Ilya Shipitsin wrote:<br>
&gt; Inspired by <a href=3D"https://www.mail-archive.com/openvpn-devel@...1514...=
s.sourceforge.net/msg13032.html" rel=3D"noreferrer" target=3D"_blank">https=
://www.mail-archive.com/<wbr>openvpn-devel@...1199...<wbr>sourceforge.net/m=
sg13032.html</a><br>
&gt; build options are taken from regular windows installer builds<br>
<br>
</span>Feature-ACK.=C2=A0 Adding cross-compile builds for Windows on travis=
 is a<br>
good plan.<br>
<br>
Initial feedback below.<br>
<div><div class=3D"h5"><br>
&gt;<br>
&gt; Signed-off-by: Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...1354...=
..">chipitsine@...277...</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 +++++++=
++++++++++++++-------<br>
&gt;=C2=A0 .travis/build-deps.sh | 55 ++++++++++++++++++++++++++++++<wbr>++=
++++++++++++++-----<br>
&gt;=C2=A0 2 files changed, 73 insertions(+), 12 deletions(-)<br>
&gt;<br>
&gt; diff --git a/.travis.yml b/.travis.yml<br>
&gt; index 3c0aa7d..9ab30a2 100644<br>
&gt; --- a/.travis.yml<br>
&gt; +++ b/.travis.yml<br>
&gt; @@ -12,6 +12,9 @@ env:<br>
&gt;=C2=A0 =C2=A0 global:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - JOBS=3D3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - PREFIX=3D&quot;${HOME}/opt&quot;<br>
&gt; +=C2=A0 =C2=A0 - TAP_WINDOWS_VERSION=3D9.21.2<br>
&gt; +=C2=A0 =C2=A0 - LZO_VERSION=3D2.10<br>
&gt; +=C2=A0 =C2=A0 - PKCS11_HELPER_VERSION=3D1.11<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - MBEDTLS_VERSION=3D&quot;2.4.0&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - MBEDTLS_CFLAGS=3D&quot;-I${PREFIX}/<wbr>include&=
quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - MBEDTLS_LIBS=3D&quot;-L${PREFIX}/lib -lmbedtls -=
lmbedx509 -lmbedcrypto&quot;<br>
&gt; @@ -50,6 +53,12 @@ matrix:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 os: osx<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 osx_image: xcode7.3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 compiler: clang<br>
&gt; +=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; CHOST=3Dx86_64-w64-=
mingw32<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 os: linux<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 compiler: &quot;: Win64 build only&quot;<br>
&gt; +=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; CHOST=3Di686-w64-mi=
ngw32<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 os: linux<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 compiler: &quot;: Win32 build only&quot;<br>
&gt;=C2=A0 =C2=A0 exclude:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - compiler: gcc<br>
&gt;<br>
&gt; @@ -60,6 +69,7 @@ addons:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - libpam0g-dev<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - liblz4-dev<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - linux-libc-dev<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 - man2html<br>
&gt;<br>
&gt;=C2=A0 cache:<br>
&gt;=C2=A0 =C2=A0 ccache: true<br>
&gt; @@ -72,16 +82,22 @@ before_install:<br>
&gt;=C2=A0 =C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot; =
]; then brew install lzo; fi<br>
&gt;<br>
&gt;=C2=A0 install:<br>
&gt; +=C2=A0 - if [ ! -z &quot;${CHOST+xxx}&quot; ]; then unset CC; unset C=
XX; fi<br>
<br>
</div></div>What is the function of this +xxx ?=C2=A0 It seems to me that a=
ll you need is<br>
&quot;if [ ! -z &quot;${CHOST}&quot; ]&quot;. <br></blockquote><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 - .travis/build-deps.sh &gt; build-deps.log 2&gt;&amp;1 |=
| (cat build-deps.log &amp;&amp; exit 1)<br>
&gt;<br>
&gt;=C2=A0 script:<br>
&gt;=C2=A0 =C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;linux&quot=
; ]; then export LD_LIBRARY_PATH=3D&quot;${PREFIX}/<wbr>lib:${LD_LIBRARY_PA=
TH}&quot;; fi<br>
&gt;=C2=A0 =C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot;=
=C2=A0 =C2=A0]; then export DYLD_LIBRARY_PATH=3D&quot;${PREFIX}/<wbr>lib:${=
DYLD_LIBRARY_PATH}&quot;; fi<br>
&gt;=C2=A0 =C2=A0 - autoreconf -vi<br>
&gt; -=C2=A0 - ./configure --with-crypto-library=3D&quot;${<wbr>SSLLIB}&quo=
t; ${EXTRA_CONFIG} || (cat config.log &amp;&amp; exit 1)<br>
&gt; -=C2=A0 - make -j$JOBS<br>
&gt; -=C2=A0 - src/openvpn/openvpn --version || true<br>
&gt; -=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;linux&quot; ]; =
then ldd src/openvpn/openvpn; fi<br>
&gt; -=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot; ]; th=
en otool -L src/openvpn/openvpn; fi<br>
&gt; -=C2=A0 - make check<br>
&gt; -=C2=A0 - $EXTRA_SCRIPT<br>
&gt; +=C2=A0 - if [ -z &quot;${CHOST+xxx}&quot; ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 ./configure --with-crypto-library=3D&quot;${<wbr=
>SSLLIB}&quot; ${EXTRA_CONFIG} || (cat config.log &amp;&amp; exit 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 make -j$JOBS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 src/openvpn/openvpn --version || true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;lin=
ux&quot; ]; then ldd src/openvpn/openvpn; fi;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx=
&quot; ]; then otool -L src/openvpn/openvpn; fi;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 make check;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 $EXTRA_SCRIPT;<br>
&gt; +=C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 TAP_CFLAGS=3D&quot;-I${PWD}/tap-<wbr>windows-${T=
AP_WINDOWS_VERSION}<wbr>/include&quot; LZO_CFLAGS=3D&quot;-I${PREFIX}/<wbr>=
include&quot; LZO_LIBS=3D&quot;-L${PREFIX}/lib -llzo2&quot; PKCS11_HELPER_L=
IBS=3D&quot;-L${<wbr>PREFIX}/lib -lpkcs11-helper&quot; PKCS11_HELPER_CFLAGS=
=3D&quot;-I${<wbr>PREFIX}/include&quot; ./configure --host=3D${CHOST} --bui=
ld=3Dx86_64-pc-linux-gnu --enable-pkcs11 --disable-plugins || (cat config.l=
og &amp;&amp; exit 1);<br>
<br>
</span>All these _CFLAGS and _LIBS should go into the env: section above.<b=
r></blockquote><div><br></div><div>there are 3 &quot;env&quot; sections: gl=
obal and 2 &quot;mingw&quot;.<br></div><div>I&#39;m afraid, defining those =
variables in global section might have some side effect, while specifying v=
ariables 2 times in both mingw sections also do not make much sense.<br></d=
iv><div><br>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Any reason to --enable-pkcs11 for the windows builds, while that&#39;s not<=
br>
done for the non-windows builds?<br></blockquote><div><br></div><div>regula=
r windows installer is built with pkcs11. that&#39;s why I added that optio=
n.<br></div><div>build matrix for non-windows builds was discussed and nobo=
dy asked me to add pkcs11 there. <br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
<div><div class=3D"h5"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 make -j$JOBS;<br>
&gt; +=C2=A0 =C2=A0 fi<br>
&gt; diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh<br>
&gt; index 3ffba0b..18f40ec 100755<br>
&gt; --- a/.travis/build-deps.sh<br>
&gt; +++ b/.travis/build-deps.sh<br>
&gt; @@ -31,7 +31,6 @@ download_openssl () {<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 build_openssl_linux () {<br>
&gt; -=C2=A0 =C2=A0 tar zxf &quot;download-cache/openssl-${<wbr>OPENSSL_VER=
SION}.tar.gz&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 (<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd &quot;openssl-${OPENSSL_VERSION}/=
&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ./config shared --openssldir=3D&quot=
;${PREFIX}&quot; -DPURIFY<br>
&gt; @@ -40,7 +39,6 @@ build_openssl_linux () {<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 build_openssl_osx () {<br>
&gt; -=C2=A0 =C2=A0 tar zxf &quot;download-cache/openssl-${<wbr>OPENSSL_VER=
SION}.tar.gz&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 (<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd &quot;openssl-${OPENSSL_VERSION}/=
&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ./Configure darwin64-x86_64-cc share=
d \<br>
&gt; @@ -49,9 +47,25 @@ build_openssl_osx () {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +build_openssl_mingw () {<br>
&gt; +=C2=A0 =C2=A0 (<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cd &quot;openssl-${OPENSSL_VERSION}/&quot=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ &quot;${CHOST}&quot; =3D &quot;i686-=
w64-mingw32&quot; ]; then export target=3Dmingw; fi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ &quot;${CHOST}&quot; =3D &quot;x86_6=
4-w64-mingw32&quot; ]; then export target=3Dmingw64; fi<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ./Configure --cross-compile-prefix=3D${<w=
br>CHOST}- shared \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$target no-multilib no-capie=
ng --openssldir=3D&quot;${PREFIX}&quot; -static-libgcc<br>
<br>
</div></div>Can you try to keep style consistent?=C2=A0 I.e. use all-caps v=
ariable names<br>
(TARGET instead of target) and use quoting (&quot;${TARGET}&quot; instead o=
f $target).<br></blockquote><div><br></div><div>yes, I can<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 make install<br>
&gt; +=C2=A0 =C2=A0 )<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 build_openssl () {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if [ &quot;$(cat ${PREFIX}/.openssl-version)&quot;=
 !=3D &quot;${OPENSSL_VERSION}&quot; ]; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &q=
uot;osx&quot; ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tar zxf &quot;download-cache/openssl-${<w=
br>OPENSSL_VERSION}.tar.gz&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ ! -z ${CHOST+xxx} ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_openssl_mingw<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif [ &quot;${TRAVIS_OS_NAME}&quot; =3D =
&quot;osx&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_openssl_osx<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif [ &quot;${TRAVIS_OS_NAME}&quot;=
 =3D &quot;linux&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_openssl_linux<br>
&gt; @@ -61,7 +75,7 @@ build_openssl () {<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 # Enable ccache<br>
&gt; -if [ &quot;${TRAVIS_OS_NAME}&quot; !=3D &quot;osx&quot; ]; then<br>
&gt; +if [ &quot;${TRAVIS_OS_NAME}&quot; !=3D &quot;osx&quot; ] &amp;&amp; =
[ -z &quot;${CHOST+xxx}&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # ccache not available on osx, see:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # <a href=3D"https://github.com/travis-ci/travis-c=
i/issues/5567" rel=3D"noreferrer" target=3D"_blank">https://github.com/trav=
is-ci/<wbr>travis-ci/issues/5567</a><br>
<br>
</span>Is ccache not available for mingw?=C2=A0 In that case, please update=
 the<br>
comment, preferably with a reference to a travis issue so that we can<br>
enable it if travis adds support later on.<br></blockquote><div><br></div><=
div>I could not get ccache working with mingw, but there&#39;s no issue, I&=
#39;m not sure it is related to travis either.<br><br></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 =C2=A0 mkdir -p &quot;${HOME}/bin&quot;<br>
&gt; @@ -70,7 +84,6 @@ if [ &quot;${TRAVIS_OS_NAME}&quot; !=3D &quot;osx&qu=
ot; ]; then<br>
&gt;=C2=A0 fi<br>
&gt;<br>
&gt;=C2=A0 # Download and build crypto lib<br>
&gt; -mkdir -p download-cache<br>
&gt;=C2=A0 if [ &quot;${SSLLIB}&quot; =3D &quot;openssl&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 download_openssl<br>
&gt;=C2=A0 =C2=A0 =C2=A0 build_openssl<br>
&gt; @@ -81,3 +94,35 @@ else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 echo &quot;Invalid crypto lib: ${SSLLIB}&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 exit 1<br>
&gt;=C2=A0 fi<br>
&gt; +<br>
&gt; +if [ ! -z ${CHOST+xxx} ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 echo &quot;deb <a href=3D"http://archive.ubuntu.=
com/ubuntu" rel=3D"noreferrer" target=3D"_blank">http://archive.ubuntu.com/=
<wbr>ubuntu</a> xenial main universe&quot; | sudo tee -a /etc/apt/sources.l=
ist.d/<wbr>xenial.list<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 echo &quot;deb <a href=3D"http://archive.ubuntu.=
com/ubuntu" rel=3D"noreferrer" target=3D"_blank">http://archive.ubuntu.com/=
<wbr>ubuntu</a> xenial main&quot; | sudo tee -a /etc/apt/sources.list.d/<wb=
r>xenial.list<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 sudo apt-get update<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 sudo apt-get -y install dpkg mingw-w64<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if [ ! -f &quot;download-cache/tap-windows-${<wb=
r>TAP_WINDOWS_VERSION}.zip&quot; ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wget -P download-cache/ <a href=3D"=
http://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSI=
ON}.zip" rel=3D"noreferrer" target=3D"_blank">http://build.openvpn.net/<wbr=
>downloads/releases/tap-<wbr>windows-${TAP_WINDOWS_VERSION}<wbr>.zip</a><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
</span>This should be in a download_tap_windows() function.<br></blockquote=
><div><br></div><div>can you be more particular on &quot;should be&quot;.<b=
r></div><div>it does not mean &quot;must be&quot;.<br></div><div>if so, we =
can leave it, right ?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 unzip download-cache/tap-windows-${<wbr>TAP_WIND=
OWS_VERSION}.zip<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 (<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 wget -P download-cache/ <a href=3D"http://www.ob=
erhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz" rel=3D"noref=
errer" target=3D"_blank">http://www.oberhumer.com/<wbr>opensource/lzo/downl=
oad/lzo-${<wbr>LZO_VERSION}.tar.gz</a><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 tar zxf download-cache/lzo-${LZO_<wbr>VERSION}.t=
ar.gz<br>
<br>
</span>This should be in a download_lzo() function.<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 cd lzo-${LZO_VERSION}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 ./configure --host=3D${CHOST} --program-prefix=
=3D&#39;&#39; --enable-shared --libdir=3D${PREFIX}/lib --prefix=3D${PREFIX}=
 --build=3Dx86_64-pc-linux-gnu<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 make<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 make install<br>
<br>
</span>This should bin in a build_lzo() function.<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 (<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 wget -P download-cache/ <a href=3D"http://downlo=
ads.sourceforge.net/project/opensc/pkcs11-helper/pkcs11-helper-${PKCS11_HEL=
PER_VERSION}.tar.bz2" rel=3D"noreferrer" target=3D"_blank">http://downloads=
.sourceforge.<wbr>net/project/opensc/pkcs11-<wbr>helper/pkcs11-helper-${PKC=
S11_<wbr>HELPER_VERSION}.tar.bz2</a><br>
<br>
</span>This should be in a download_pkcs11helper() function.<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 tar jxf download-cache/pkcs11-helper-$<wbr>{PKCS=
11_HELPER_VERSION}.tar.<wbr>bz2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 cd pkcs11-helper-${PKCS11_HELPER_<wbr>VERSION}<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 ./configure --host=3D${CHOST} --program-prefix=
=3D&#39;&#39; --enable-shared --libdir=3D${PREFIX}/lib --prefix=3D${PREFIX}=
 --build=3Dx86_64-pc-linux-gnu --disable-crypto-engine-gnutls --disable-cry=
pto-engine-nss<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 make<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 make install<br>
<br>
</span>This should be in a build_pkcs11helper() function.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +<br>
&gt; +fi<br>
&gt;<br>
<br>
-Steffan<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></div><br></div></div>

--f403045f55947f5fb4054cb9aea2--

