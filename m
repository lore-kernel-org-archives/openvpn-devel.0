MIME-Version: 1.0
References: <20210608152434.1403999-1-arne@...1227...>
In-Reply-To: <20210608152434.1403999-1-arne@...1227...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 9 Jun 2021 15:48:19 +0500
Message-ID: <CAFHpkQEno2fXu2ZNufjQ6AQR4SYY-eExqOw7vZQWhXz8TOYPug@...278...>
Content-Type: multipart/alternative; boundary="000000000000f1082305c453036c"
Subject: Re: [Openvpn-devel] [PATCH] Add github actions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000f1082305c453036c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 8 =D0=B8=D1=8E=D0=BD. 2021 =D0=B3. =D0=B2 20:26, Arne Schwabe=
 <arne@...1227...>:

> dummy0 gives strange errors on the Ubuntu 16 runner on github actions
> because
> dummy already exist, so use a more unique ovpn-dummy0 name instead.
>
> Github actions are a good alternative to travis-ci, which futrure is
> questionable
> at the moment without payment. The github actions also allows building on
> macOS
>

we can remove most configurations from travis, except unique like s390x,
ppc64le, ...



> and Windows (not included in this commit). The  matrix is a bit different
> than Coverity and uses different Ubuntu version with their native OpenSSL
> (1.0.2, 1.1.1)/mbed TLS instead of manually compiling different OpenSSL
> versions on just Ubuntu 20.04.
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  .github/workflows/build.yaml               | 184 +++++++++++++++++++++
>  tests/t_net.sh                             |   2 +-
>  tests/unit_tests/openvpn/test_networking.c |   2 +-
>  3 files changed, 186 insertions(+), 2 deletions(-)
>  create mode 100644 .github/workflows/build.yaml
>
> diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
> new file mode 100644
> index 000000000..7ff379802
> --- /dev/null
> +++ b/.github/workflows/build.yaml
> @@ -0,0 +1,184 @@
> +# The name of our workflow
> +name: Build
> +on: [push, pull_request]
> +
> +jobs:
> +  mingw:
> +    strategy:
> +      matrix:
> +        include:
> +          - target: mingw64
> +            chost: x86_64-w64-mingw32
> +          - target: mingw
> +            chost: i686-w64-mingw32
> +
> +    runs-on: ubuntu-20.04
> +    env:
> +      MAKEFLAGS: -j3
> +      LZO_VERSION: "2.10"
> +      PKCS11_HELPER_VERSION: "1.26"
> +      OPENSSL_VERSION: "1.1.1j"
> +      TAP_WINDOWS_VERSION: "9.23.3"
> +      CHOST: ${{ matrix.chost }}
> +      TARGET: ${{ matrix.target }}
> +    steps:
> +      - name: Install dependencies
> +        run: sudo apt update && sudo apt install -y mingw-w64 libtool
> automake autoconf man2html unzip
> +      - name: Checkout ovpn-dco-win
> +        uses: actions/checkout@...2620...
> +        with:
> +          repository: OpenVPN/ovpn-dco-win
> +          path: ovpn-dco-win
> +      - name: Checkout OpenVPN
> +        uses: actions/checkout@...2620...
> +        with:
> +          path: openvpn
> +
> +      - name: autoconf
> +        run: autoreconf -fvi
> +        working-directory: openvpn
> +
> +      - name: Cache dependencies
> +        id: cache
> +        uses: actions/cache@...2620...
> +        with:
> +          path: '~/mingw/'
> +          key: ${{ matrix.target }}-mingw-${{ env.LZO_VERSION }}-${{
> env.PKCS11_HELPER_VERSION }}-${{ env.TAP_WINDOWS_VERSION }}
> +
> +      # Repeating  if: steps.cache.outputs.cache-hit !=3D 'true'
> +      # on every step for building dependencies is ugly but
> +      # I haven't found a better solution so far.
> +
> +      - name: Download mingw depnendencies
> +        if: steps.cache.outputs.cache-hit !=3D 'true'
> +        run: |
> +          wget -c -P download-cache/ "
> https://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VE=
RSION}.zip
> "
> +          wget -c -P download-cache/ "
> https://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.=
gz
> "
> +          wget -c -P download-cache/ "
> https://github.com/OpenSC/pkcs11-helper/archive/pkcs11-helper-${PKCS11_HE=
LPER_VERSION}.tar.gz
> "
> +          wget -c -P download-cache/ "
> https://www.openssl.org/source/old/1.1.1/openssl-${OPENSSL_VERSION}.tar.gz
> "
> +          tar zxf
> "download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.gz"
> +          tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
> +          tar zxf "download-cache/lzo-${LZO_VERSION}.tar.gz"
> +          unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip
> +
> +      - name: Configure OpenSSL
> +        if: steps.cache.outputs.cache-hit !=3D 'true'
> +        run: ./Configure --cross-compile-prefix=3D${CHOST}- shared ${{
> matrix.target }} no-capieng --prefix=3D"${HOME}/mingw/opt"
> --openssldir=3D"${HOME}/mingw/opt" -static-libgcc
> +        working-directory: "./openssl-1.1.1j"
> +
> +      - name: Build OpenSSL
> +        if: steps.cache.outputs.cache-hit !=3D 'true'
> +        run: make
> +        working-directory: "./openssl-1.1.1j/"
> +
> +      - name: Install OpenSSL
> +        if: steps.cache.outputs.cache-hit !=3D 'true'
> +        run: make install
> +        working-directory: "./openssl-1.1.1j/"
> +
> +      - name: autoreconf pkcs11-helper
> +        if: steps.cache.outputs.cache-hit !=3D 'true'
> +        run: autoreconf -iv
> +        working-directory: "./pkcs11-helper-pkcs11-helper-1.26"
> +
> +      - name: configure pkcs11-helper
> +        if: steps.cache.outputs.cache-hit !=3D 'true'
> +        run: OPENSSL_LIBS=3D"-L${HOME}/mingw/opt/lib -lssl -lcrypto"
> OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include
> PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig ./configure --host=3D${=
CHOST}
> --program-prefix=3D'' --libdir=3D${HOME}/mingw/opt/lib
> --prefix=3D${HOME}/mingw/opt --build=3Dx86_64-pc-linux-gnu
> --disable-crypto-engine-gnutls --disable-crypto-engine-nss
> --disable-crypto-engine-polarssl --disable-crypto-engine-mbedtls
> +        working-directory: "./pkcs11-helper-pkcs11-helper-1.26"
> +
> +      - name: build pkcs11-helper
> +        if: steps.cache.outputs.cache-hit !=3D 'true'
> +        run: make all
> +        working-directory: "./pkcs11-helper-pkcs11-helper-1.26"
> +
> +      - name: install pkcs11-helper
> +        if: steps.cache.outputs.cache-hit !=3D 'true'
> +        run: make install
> +        working-directory: "./pkcs11-helper-pkcs11-helper-1.26"
> +
> +      - name: Configure lzo
> +        if: steps.cache.outputs.cache-hit !=3D 'true'
> +        run: ./configure --host=3D${CHOST} --program-prefix=3D''
> --libdir=3D${HOME}/mingw/opt/lib --prefix=3D${HOME}/mingw/opt
> --build=3Dx86_64-pc-linux-gnu
> +        working-directory: "./lzo-2.10"
> +
> +      - name: build lzo
> +        if: steps.cache.outputs.cache-hit !=3D 'true'
> +        working-directory: "./lzo-2.10"
> +        run: make
> +
> +      - name: install lzo
> +        if: steps.cache.outputs.cache-hit !=3D 'true'
> +        working-directory: "./lzo-2.10"
> +        run: make install
> +
> +      - name: copy tap-windows.h header
> +        if: steps.cache.outputs.cache-hit !=3D 'true'
> +        run: cp ./tap-windows-9.23.3/include/tap-windows.h
> ${HOME}/mingw/opt/include/
> +
> +      - name: configure OpenVPN
> +        run: PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig
> DCO_SOURCEDIR=3D$(realpath ../ovpn-dco-win) LDFLAGS=3D-L$HOME/mingw/opt/l=
ib
> CFLAGS=3D-I$HOME/mingw/opt/include OPENSSL_LIBS=3D"-L${HOME}/opt/lib -lssl
> -lcrypto" OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include PREFIX=3D$HOME/mingw=
/opt
> LZO_CFLAGS=3D-I$HOME/mingw/opt/include LZO_LIBS=3D"-L${HOME}/mingw/opt/lib
> -llzo2" ./configure  --host=3D${CHOST} --disable-lz4 --enable-dco
> +        working-directory: openvpn
> +
> +      - name: build OpenVPN
> +        run: make -j3
> +        working-directory: openvpn
> +
> +  ubuntu:
> +    strategy:
> +      matrix:
> +        os: [ubuntu-16.04, ubuntu-18.04, ubuntu-20.04]
> +        ssllib: [mbedtls, openssl]
> +
> +    runs-on: ${{matrix.os}}
> +    steps:
> +      - name: Install dependencies
> +        run: sudo apt update && sudo apt install -y liblzo2-dev
> libpam0g-dev liblz4-dev linux-libc-dev man2html libcmocka-dev
> python3-docutils libtool automake autoconf libmbedtls-dev
> +      - name: Checkout OpenVPN
> +        uses: actions/checkout@...2620...
> +      - name: autoconf
> +        run: autoreconf -fvi
> +      - name: configure --with-crypto-library=3D${{matrix.ssllib}}
> +        run: ./configure
> +      - name: make all
> +        run: make -j3
> +      - name: make check
> +        run: make check
> +
> +  ubutun20-clang-asan:
> +    strategy:
> +      matrix:
> +        os: [ubuntu-16.04, ubuntu-18.04]
> +        ssllib: [mbedtls, openssl]
> +
> +    runs-on: ubuntu-20.04
> +    steps:
> +      - name: Install dependencies
> +        run: sudo apt update && sudo apt install -y liblzo2-dev
> libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev
> python3-docutils libtool automake autoconf libmbedtls-dev
> +      - name: Checkout OpenVPN
> +        uses: actions/checkout@...2620...
> +      - name: autoconf
> +        run: autoreconf -fvi
> +      - name: configure
> +        run: CFLAGS=3D"-fsanitize=3Daddress -fno-omit-frame-pointer -O2"
> CC=3Dclang ./configure --with-crypto-library=3D${{matrix.ssllib}}
> +      - name: make all
> +        run: make -j3
> +      - name: make check
> +        run: make check
> +
> +
> +  macos:
> +    runs-on: macos-latest
> +    steps:
> +      - name: Checkout OpenVPN
> +        uses: actions/checkout@...2620...
> +      - name: Install dependencies
> +        run: brew install openssl lzo lz4 man2html cmocka libtool
> automake autoconf
> +      - name: autoconf
> +        run: autoreconf -fvi
> +      - name: configure
> +        run: OPENSSL_CFLAGS=3D-I/usr/local/opt/openssl@...2560.../include
> OPENSSL_LIBS=3D"-L/usr/local/opt/openssl@...2560.../lib -lcrypto -lssl" .=
/configure
> +      - name: make all
> +        run: make -j4
> +      - name: make check
> +        run: make check
> +
> diff --git a/tests/t_net.sh b/tests/t_net.sh
> index 246ee07bd..f9dba4040 100755
> --- a/tests/t_net.sh
> +++ b/tests/t_net.sh
> @@ -1,6 +1,6 @@
>  #!/usr/bin/env bash
>
> -IFACE=3D"dummy0"
> +IFACE=3D"ovpn-dummy0"
>  UNIT_TEST=3D"./unit_tests/openvpn/networking_testdriver"
>  MAX_TEST=3D${1:-7}
>
> diff --git a/tests/unit_tests/openvpn/test_networking.c
> b/tests/unit_tests/openvpn/test_networking.c
> index e7c148f0e..9e9744f48 100644
> --- a/tests/unit_tests/openvpn/test_networking.c
> +++ b/tests/unit_tests/openvpn/test_networking.c
> @@ -3,7 +3,7 @@
>  #include "networking.h"
>
>
> -static char *iface =3D "dummy0";
> +static char *iface =3D "ovpn-dummy0";
>
>  static int
>  net__iface_up(bool up)
> --
> 2.32.0
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000f1082305c453036c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=82, 8 =D0=B8=D1=8E=D0=BD. 2=
021 =D0=B3. =D0=B2 20:26, Arne Schwabe &lt;<a href=3D"mailto:arne@...2477...=
.">arne@...1227...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">dummy0 gives strange errors on the Ubuntu 16 runner on github a=
ctions because<br>
dummy already exist, so use a more unique ovpn-dummy0 name instead.<br>
<br>
Github actions are a good alternative to travis-ci, which futrure is questi=
onable<br>
at the moment without payment. The github actions also allows building on m=
acOS<br></blockquote><div><br></div><div>we can remove most configurations =
from travis, except unique like s390x, ppc64le, ...</div><div><br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
and Windows (not included in this commit). The=C2=A0 matrix is a bit differ=
ent<br>
than Coverity and uses different Ubuntu version with their native OpenSSL<b=
r>
(1.0.2, 1.1.1)/mbed TLS instead of manually compiling different OpenSSL<br>
versions on just Ubuntu 20.04.<br>
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0.github/workflows/build.yaml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 184 +++++++++++++++++++++<br>
=C2=A0tests/t_net.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0tests/unit_tests/openvpn/test_networking.c |=C2=A0 =C2=A02 +-<br>
=C2=A03 files changed, 186 insertions(+), 2 deletions(-)<br>
=C2=A0create mode 100644 .github/workflows/build.yaml<br>
<br>
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml<br>
new file mode 100644<br>
index 000000000..7ff379802<br>
--- /dev/null<br>
+++ b/.github/workflows/build.yaml<br>
@@ -0,0 +1,184 @@<br>
+# The name of our workflow<br>
+name: Build<br>
+on: [push, pull_request]<br>
+<br>
+jobs:<br>
+=C2=A0 mingw:<br>
+=C2=A0 =C2=A0 strategy:<br>
+=C2=A0 =C2=A0 =C2=A0 matrix:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 include:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - target: mingw64<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chost: x86_64-w64-mingw32<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - target: mingw<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chost: i686-w64-mingw32<br>
+<br>
+=C2=A0 =C2=A0 runs-on: ubuntu-20.04<br>
+=C2=A0 =C2=A0 env:<br>
+=C2=A0 =C2=A0 =C2=A0 MAKEFLAGS: -j3<br>
+=C2=A0 =C2=A0 =C2=A0 LZO_VERSION: &quot;2.10&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 PKCS11_HELPER_VERSION: &quot;1.26&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 OPENSSL_VERSION: &quot;1.1.1j&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 TAP_WINDOWS_VERSION: &quot;9.23.3&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 CHOST: ${{ matrix.chost }}<br>
+=C2=A0 =C2=A0 =C2=A0 TARGET: ${{ matrix.target }}<br>
+=C2=A0 =C2=A0 steps:<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Install dependencies<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: sudo apt update &amp;&amp; sudo apt insta=
ll -y mingw-w64 libtool automake autoconf man2html unzip<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Checkout ovpn-dco-win<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uses: actions/checkout@...2620...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repository: OpenVPN/ovpn-dco-win<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: ovpn-dco-win<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Checkout OpenVPN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uses: actions/checkout@...2620...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: openvpn<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
+=C2=A0 =C2=A0 =C2=A0 - name: autoconf<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: autoreconf -fvi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: openvpn<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Cache dependencies<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 id: cache<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uses: actions/cache@...2620...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: &#39;~/mingw/&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key: ${{ matrix.target }}-mingw-${{ env=
.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{ env.TAP_WINDOWS_VERSIO=
N }}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 # Repeating=C2=A0 if: steps.cache.outputs.cache-hit !=
=3D &#39;true&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 # on every step for building dependencies is ugly but=
<br>
+=C2=A0 =C2=A0 =C2=A0 # I haven&#39;t found a better solution so far.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
+=C2=A0 =C2=A0 =C2=A0 - name: Download mingw depnendencies<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wget -c -P download-cache/ &quot;<a hre=
f=3D"https://build.openvpn.net/downloads/releases/tap-windows-$%7BTAP_WINDO=
WS_VERSION%7D.zip" rel=3D"noreferrer" target=3D"_blank">https://build.openv=
pn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip</a>&quot;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wget -c -P download-cache/ &quot;<a hre=
f=3D"https://www.oberhumer.com/opensource/lzo/download/lzo-$%7BLZO_VERSION%=
7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">https://www.oberhumer.com/o=
pensource/lzo/download/lzo-${LZO_VERSION}.tar.gz</a>&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wget -c -P download-cache/ &quot;<a hre=
f=3D"https://github.com/OpenSC/pkcs11-helper/archive/pkcs11-helper-$%7BPKCS=
11_HELPER_VERSION%7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">https://g=
ithub.com/OpenSC/pkcs11-helper/archive/pkcs11-helper-${PKCS11_HELPER_VERSIO=
N}.tar.gz</a>&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wget -c -P download-cache/ &quot;<a hre=
f=3D"https://www.openssl.org/source/old/1.1.1/openssl-$%7BOPENSSL_VERSION%7=
D.tar.gz" rel=3D"noreferrer" target=3D"_blank">https://www.openssl.org/sour=
ce/old/1.1.1/openssl-${OPENSSL_VERSION}.tar.gz</a>&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tar zxf &quot;download-cache/pkcs11-hel=
per-${PKCS11_HELPER_VERSION}.tar.gz&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tar zxf &quot;download-cache/openssl-${=
OPENSSL_VERSION}.tar.gz&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tar zxf &quot;download-cache/lzo-${LZO_=
VERSION}.tar.gz&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unzip download-cache/tap-windows-${TAP_=
WINDOWS_VERSION}.zip<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Configure OpenSSL<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ./Configure --cross-compile-prefix=3D${CH=
OST}- shared ${{ matrix.target }} no-capieng --prefix=3D&quot;${HOME}/mingw=
/opt&quot; --openssldir=3D&quot;${HOME}/mingw/opt&quot; -static-libgcc<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./openssl-1.1.1j&quot=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
+=C2=A0 =C2=A0 =C2=A0 - name: Build OpenSSL<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: make<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./openssl-1.1.1j/&quo=
t;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Install OpenSSL<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: make install<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./openssl-1.1.1j/&quo=
t;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
+=C2=A0 =C2=A0 =C2=A0 - name: autoreconf pkcs11-helper<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: autoreconf -iv<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./pkcs11-helper-pkcs1=
1-helper-1.26&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: configure pkcs11-helper<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: OPENSSL_LIBS=3D&quot;-L${HOME}/mingw/opt/=
lib -lssl -lcrypto&quot; OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include PKG_CON=
FIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig ./configure --host=3D${CHOST} --=
program-prefix=3D&#39;&#39; --libdir=3D${HOME}/mingw/opt/lib --prefix=3D${H=
OME}/mingw/opt --build=3Dx86_64-pc-linux-gnu --disable-crypto-engine-gnutls=
 --disable-crypto-engine-nss --disable-crypto-engine-polarssl --disable-cry=
pto-engine-mbedtls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./pkcs11-helper-pkcs1=
1-helper-1.26&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
+=C2=A0 =C2=A0 =C2=A0 - name: build pkcs11-helper<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: make all<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./pkcs11-helper-pkcs1=
1-helper-1.26&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
+=C2=A0 =C2=A0 =C2=A0 - name: install pkcs11-helper<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: make install<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./pkcs11-helper-pkcs1=
1-helper-1.26&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Configure lzo<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ./configure --host=3D${CHOST} --program-p=
refix=3D&#39;&#39; --libdir=3D${HOME}/mingw/opt/lib --prefix=3D${HOME}/ming=
w/opt --build=3Dx86_64-pc-linux-gnu<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./lzo-2.10&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
+=C2=A0 =C2=A0 =C2=A0 - name: build lzo<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./lzo-2.10&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: make<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
+=C2=A0 =C2=A0 =C2=A0 - name: install lzo<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./lzo-2.10&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: make install<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: copy tap-windows.h header<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: cp ./tap-windows-9.23.3/include/tap-windo=
ws.h ${HOME}/mingw/opt/include/<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: configure OpenVPN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/p=
kgconfig DCO_SOURCEDIR=3D$(realpath ../ovpn-dco-win) LDFLAGS=3D-L$HOME/ming=
w/opt/lib CFLAGS=3D-I$HOME/mingw/opt/include OPENSSL_LIBS=3D&quot;-L${HOME}=
/opt/lib -lssl -lcrypto&quot; OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include PR=
EFIX=3D$HOME/mingw/opt LZO_CFLAGS=3D-I$HOME/mingw/opt/include LZO_LIBS=3D&q=
uot;-L${HOME}/mingw/opt/lib -llzo2&quot; ./configure=C2=A0 --host=3D${CHOST=
} --disable-lz4 --enable-dco<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: openvpn<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
+=C2=A0 =C2=A0 =C2=A0 - name: build OpenVPN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: make -j3<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: openvpn<br>
+=C2=A0 <br>
+=C2=A0 ubuntu:<br>
+=C2=A0 =C2=A0 strategy:<br>
+=C2=A0 =C2=A0 =C2=A0 matrix:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os: [ubuntu-16.04, ubuntu-18.04, ubuntu-20.04]=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ssllib: [mbedtls, openssl]<br>
+<br>
+=C2=A0 =C2=A0 runs-on: ${{matrix.os}}<br>
+=C2=A0 =C2=A0 steps:<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Install dependencies<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: sudo apt update &amp;&amp; sudo apt insta=
ll -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html libcmocka=
-dev python3-docutils libtool automake autoconf libmbedtls-dev<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Checkout OpenVPN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uses: actions/checkout@...2620...<br>
+=C2=A0 =C2=A0 =C2=A0 - name: autoconf<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: autoreconf -fvi<br>
+=C2=A0 =C2=A0 =C2=A0 - name: configure --with-crypto-library=3D${{matrix.s=
sllib}}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ./configure<br>
+=C2=A0 =C2=A0 =C2=A0 - name: make all<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: make -j3<br>
+=C2=A0 =C2=A0 =C2=A0 - name: make check<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: make check<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
+=C2=A0 ubutun20-clang-asan:<br>
+=C2=A0 =C2=A0 strategy:<br>
+=C2=A0 =C2=A0 =C2=A0 matrix:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os: [ubuntu-16.04, ubuntu-18.04]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ssllib: [mbedtls, openssl]<br>
+<br>
+=C2=A0 =C2=A0 runs-on: ubuntu-20.04<br>
+=C2=A0 =C2=A0 steps:<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Install dependencies<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: sudo apt update &amp;&amp; sudo apt insta=
ll -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang lib=
cmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Checkout OpenVPN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uses: actions/checkout@...2620...<br>
+=C2=A0 =C2=A0 =C2=A0 - name: autoconf<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: autoreconf -fvi<br>
+=C2=A0 =C2=A0 =C2=A0 - name: configure<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: CFLAGS=3D&quot;-fsanitize=3Daddress -fno-=
omit-frame-pointer -O2&quot; CC=3Dclang ./configure --with-crypto-library=
=3D${{matrix.ssllib}}<br>
+=C2=A0 =C2=A0 =C2=A0 - name: make all<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: make -j3<br>
+=C2=A0 =C2=A0 =C2=A0 - name: make check<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: make check<br>
+<br>
+<br>
+=C2=A0 macos:<br>
+=C2=A0 =C2=A0 runs-on: macos-latest<br>
+=C2=A0 =C2=A0 steps:<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Checkout OpenVPN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uses: actions/checkout@...2620...<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Install dependencies<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: brew install openssl lzo lz4 man2html cmo=
cka libtool automake autoconf<br>
+=C2=A0 =C2=A0 =C2=A0 - name: autoconf<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: autoreconf -fvi<br>
+=C2=A0 =C2=A0 =C2=A0 - name: configure<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: OPENSSL_CFLAGS=3D-I/usr/local/opt/openssl=
@...2560.../include=C2=A0 OPENSSL_LIBS=3D&quot;-L/usr/local/opt/openssl@...493...=
2560.../lib -lcrypto -lssl&quot; ./configure<br>
+=C2=A0 =C2=A0 =C2=A0 - name: make all<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: make -j4<br>
+=C2=A0 =C2=A0 =C2=A0 - name: make check<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: make check<br>
+<br>
diff --git a/tests/t_net.sh b/tests/t_net.sh<br>
index 246ee07bd..f9dba4040 100755<br>
--- a/tests/t_net.sh<br>
+++ b/tests/t_net.sh<br>
@@ -1,6 +1,6 @@<br>
=C2=A0#!/usr/bin/env bash<br>
<br>
-IFACE=3D&quot;dummy0&quot;<br>
+IFACE=3D&quot;ovpn-dummy0&quot;<br>
=C2=A0UNIT_TEST=3D&quot;./unit_tests/openvpn/networking_testdriver&quot;<br>
=C2=A0MAX_TEST=3D${1:-7}<br>
<br>
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/=
openvpn/test_networking.c<br>
index e7c148f0e..9e9744f48 100644<br>
--- a/tests/unit_tests/openvpn/test_networking.c<br>
+++ b/tests/unit_tests/openvpn/test_networking.c<br>
@@ -3,7 +3,7 @@<br>
=C2=A0#include &quot;networking.h&quot;<br>
<br>
<br>
-static char *iface =3D &quot;dummy0&quot;;<br>
+static char *iface =3D &quot;ovpn-dummy0&quot;;<br>
<br>
=C2=A0static int<br>
=C2=A0net__iface_up(bool up)<br>
-- <br>
2.32.0<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--000000000000f1082305c453036c--

