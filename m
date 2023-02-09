MIME-Version: 1.0
References: <20230208001819.244694-1-arne@...1227...>
 <20230208001819.244694-6-arne@...1227...>
In-Reply-To: <20230208001819.244694-6-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 8 Feb 2023 23:58:23 -0500
Message-ID: <CAKuzo_iKyxKscHJWhSE0-DhWiSEwDuHGQSQd3NMmX6A6NWBjzw@...278...>
Content-Type: multipart/alternative; boundary="000000000000f558b105f43d3bb8"
Subject: Re: [Openvpn-devel] [PATCH 5/5] Add building and running mingw
 unittests to github actions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000f558b105f43d3bb8
Content-Type: text/plain; charset="UTF-8"

Hi,

It's "absolutely splendid" to see cross-compiled tests running in GHA!

Some issues below:

On Tue, Feb 7, 2023 at 7:19 PM Arne Schwabe <arne@...1227...> wrote:

> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  .github/workflows/build.yaml | 110 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 108 insertions(+), 2 deletions(-)
>
> diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
> index 132624547..c71bd2c4d 100644
> --- a/.github/workflows/build.yaml
> +++ b/.github/workflows/build.yaml
> @@ -55,9 +55,10 @@ jobs:
>        PKCS11_HELPER_VERSION: "1.29.0"
>        OPENSSL_VERSION: "${{ matrix.osslver }}"
>        TAP_WINDOWS_VERSION: "9.23.3"
> +      CMOCKA_VERSION: "1.1.5"
>      steps:
>        - name: Install dependencies
> -        run: sudo apt update && sudo apt install -y mingw-w64 libtool
> automake autoconf man2html unzip
> +        run: sudo apt update && sudo apt install -y mingw-w64 libtool
> automake autoconf man2html unzip cmake ninja-build build-essential wget
>        - name: Checkout OpenVPN
>          uses: actions/checkout@...2689...
>          with:
> @@ -72,7 +73,7 @@ jobs:
>          uses: actions/cache@...2689...
>          with:
>            path: '~/mingw/'
> -          key: ${{ matrix.target }}-mingw-${{ matrix.osslver }}-${{
> env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{
> env.TAP_WINDOWS_VERSION }}
> +          key: ${{ matrix.target }}-mingw-${{ matrix.osslver }}-${{
> env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{
> env.TAP_WINDOWS_VERSION }}--${{ env.CMOCKA_VERSION }}
>
>        # Repeating  if: steps.cache.outputs.cache-hit != 'true'
>        # on every step for building dependencies is ugly but
> @@ -84,12 +85,33 @@ jobs:
>            wget -c -P download-cache/ "
> https://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip
> "
>            wget -c -P download-cache/ "
> https://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz
> "
>            wget -c -P download-cache/ "
> https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${PKCS11_HELPER_VERSION}/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2
> "
> +          wget -c -P download-cache/ "
> https://github.com/coreboot/cmocka/archive/refs/tags/cmocka-${CMOCKA_VERSION}.tar.gz
> "
>            tar jxf
> "download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2"
>            wget -c -P download-cache/ "
> https://www.openssl.org/source/old/1.1.1/openssl-${OPENSSL_VERSION}.tar.gz"
> || wget -c -P download-cache/ "
> https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"
>            tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
>            tar zxf "download-cache/lzo-${LZO_VERSION}.tar.gz"
> +          tar zxf "download-cache/cmocka-${CMOCKA_VERSION}.tar.gz"
>            unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip
>
> +      - name: create cmocka build directory
> +        if: steps.cache.outputs.cache-hit != 'true'
> +        run: mkdir cmocka-build
> +
> +      - name: configure cmocka
> +        if: steps.cache.outputs.cache-hit != 'true'
> +        working-directory: "./cmocka-build"
> +        run: cmake -GNinja -DCMAKE_C_COMPILER=${{ matrix.chost }}-gcc
> -DCMAKE_CXX_COMPILER=${{ matrix.chost }}-g++ -DCMAKE_SYSTEM_NAME=Windows
> -DCMAKE_PREFIX_PATH=${HOME}/mingw/opt/lib/pkgconfig/
> -DCMAKE_INCLUDE_PATH=${HOME}/mingw/opt/lib/include
> -DCMAKE_LIBRARY_PATH=${HOME}/mingw/opt/lib
> -DCMAKE_INSTALL_PREFIX=${HOME}/mingw/opt/ ../cmocka-cmocka-${{
> env.CMOCKA_VERSION }}
>

Please add "-DCMAKE_SHARED_LINKER_FLAGS=-static-libgcc" so that cmocka.dll
will only depend on native Windows dlls. We already do this while building
openssl dlls.


> +
> +      - name: build cmocka
> +        if: steps.cache.outputs.cache-hit != 'true'
> +        working-directory: "./cmocka-build"
> +        run: ninja
> +
> +      - name: install cmocka
> +        if: steps.cache.outputs.cache-hit != 'true'
> +        working-directory: "./cmocka-build"
> +        run: ninja install
> +
>        - name: Configure OpenSSL
>          if: steps.cache.outputs.cache-hit != 'true'
>          run: ./Configure --cross-compile-prefix=${{ matrix.chost }}-
> shared ${{ matrix.target }} no-capieng --prefix="${HOME}/mingw/opt"
> --openssldir="${HOME}/mingw/opt" -static-libgcc
> @@ -154,6 +176,89 @@ jobs:
>        - name: build OpenVPN
>          run: make -j3
>          working-directory: openvpn
> +      - name: build OpenVPN unittests
> +        run: make -j3 check
> +        working-directory: openvpn
> +
> +      # We use multiple upload-artifact here, so it becomes a flat folder
> +      # structure since we need the ddls on the same level as the binaries
>

ddls -> dlls

+      - name: Archive cmocka/openssl/lzo ddls
> +        uses: actions/upload-artifact@...2689...
> +        with:
> +          retention-days: 1
> +          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver
> }}-dlls
> +          path: '~/mingw/opt/bin/*.dll'
> +
> +      - name: Archive gcc dlls
> +        uses: actions/upload-artifact@...2689...
> +        with:
> +          retention-days: 1
> +          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver
> }}-dlls
> +          path: /usr/lib/gcc/${{ matrix.chost }}/10-win32/*.dll
>

This section ("Archive gcc dlls") is not required when mocka.dll is built
with -static-libgcc as above. None of our exe's or dlls will have any
dependency on these.


> +
> +      - name: Archive mingw dlls
> +        uses: actions/upload-artifact@...2689...
> +        with:
> +          retention-days: 1
> +          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver
> }}-dlls
> +          path: /usr/${{ matrix.chost }}/lib/*.dll
>

Same with this "Archive mingw dlls" section

I tested these changes here:
https://github.com/selvanair/openvpn/tree/automake-cryptoapi

+
> +      # libtool puts some wrapper binaries in
> openvpn/tests/unit_tests/openvpn/
> +      # and the real binaries in openvpn/tests/unit_tests/openvpn/.libs/
> +      - name: Archive unittest artifacts
> +        uses: actions/upload-artifact@...2689...
> +        with:
> +          retention-days: 1
> +          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver
> }}-tests
> +          path: openvpn/tests/unit_tests/openvpn/.libs/*.exe
> +
> +      # Currently not used by the unit test but might in the future and
> also
> +      # helpful if manually downloading and running openvpn.exe from a
> mingw
> +      # build
> +      - name: Archive openvpn binary
> +        uses: actions/upload-artifact@...2689...
> +        with:
> +          retention-days: 1
> +          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver
> }}-tests
> +          path: openvpn/src/openvpn/.libs/*.exe
> +
> +  mingw-unittest:
> +    needs: [ mingw ]
> +    strategy:
> +      fail-fast: false
> +      matrix:
> +        osslver: [ 1.1.1q, 3.0.5 ]
> +        target: [ mingw64, mingw ]
> +
> +    runs-on: windows-latest
> +    name: "mingw unittests - ${{matrix.target}} - OSSL ${{ matrix.osslver
> }}"
> +    steps:
> +      - name: Retrieve mingw unittest dlls
> +        uses: actions/download-artifact@...2689...
> +        with:
> +          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver
> }}-dlls
> +          path: unittests
> +
> +      - name: Retrieve mingw unittest
> +        uses: actions/download-artifact@...2689...
> +        with:
> +          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver
> }}-tests
> +          path: unittests
> +
> +      - name: List unittests directory
> +        run: "dir unittests"
> +
> +      - name: Run unit tests
> +        run: |
> +          ./unittests/argv_testdriver.exe
> +          ./unittests/auth_token_testdriver.exe
> +          ./unittests/buffer_testdriver.exe
> +          ./unittests/crypto_testdriver.exe
> +          ./unittests/misc_testdriver.exe
> +          ./unittests/ncp_testdriver.exe
> +          ./unittests/packet_id_testdriver.exe
> +          ./unittests/pkt_testdriver.exe
> +          ./unittests/provider_testdriver.exe
>
>    ubuntu:
>      strategy:
> @@ -442,3 +547,4 @@ jobs:
>          run: make -j3
>        - name: make check
>          run: make check
> +
> --


A couple of minor issues with the way test results are reported:

(1) The main name of the test being run is not printed

Normally when run from make check, we will get "PASSED pkt_testdriver" etc
at the end which would be hard to recreate here. But we could add a line
saying "Running pkt_testdriver" at the top. The individual tests within
each exe are printed by cmocka, but unfortunately not all tests are
carefully named to quickly see which group it belongs to.

(2) Messages like "Running 4 tests", "PASSED 4 tests" etc., appear out of
order

Often "PASSED" appears before running tests or in the middle.

Eg.,
[==========] 9 test(s) run.
[ PASSED ] 11 test(s).
[ PASSED ] 7 test(s).
[==========] Running 11 test(s)

Then comes the description of those 11 tests.

Some tasks are running in parallel?

That said, reporting improvements could be done as a follow-up as this is
already quite useful.

Regards,

Selva

--000000000000f558b105f43d3bb8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi,</div><div><br></div>It&#39;s &qu=
ot;absolutely splendid&quot; to see cross-compiled tests running in GHA!</d=
iv><div><br></div>Some issues below:<div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 7, 2023 at 7:19 PM Arne Schw=
abe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...2477...=
.</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0.github/workflows/build.yaml | 110 ++++++++++++++++++++++++++++++++++=
-<br>
=C2=A01 file changed, 108 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml<br>
index 132624547..c71bd2c4d 100644<br>
--- a/.github/workflows/build.yaml<br>
+++ b/.github/workflows/build.yaml<br>
@@ -55,9 +55,10 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0PKCS11_HELPER_VERSION: &quot;1.29.0&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0OPENSSL_VERSION: &quot;${{ matrix.osslver }}&quo=
t;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0TAP_WINDOWS_VERSION: &quot;9.23.3&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 CMOCKA_VERSION: &quot;1.1.5&quot;<br>
=C2=A0 =C2=A0 =C2=A0steps:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: Install dependencies<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: sudo apt update &amp;&amp; sudo apt insta=
ll -y mingw-w64 libtool automake autoconf man2html unzip<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: sudo apt update &amp;&amp; sudo apt insta=
ll -y mingw-w64 libtool automake autoconf man2html unzip cmake ninja-build =
build-essential wget<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: Checkout OpenVPN<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uses: actions/checkout@...2689...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with:<br>
@@ -72,7 +73,7 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uses: actions/cache@...2689...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path: &#39;~/mingw/&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key: ${{ matrix.target }}-mingw-${{ mat=
rix.osslver }}-${{ env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{ =
env.TAP_WINDOWS_VERSION }}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key: ${{ matrix.target }}-mingw-${{ mat=
rix.osslver }}-${{ env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{ =
env.TAP_WINDOWS_VERSION }}--${{ env.CMOCKA_VERSION }}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0# Repeating=C2=A0 if: steps.cache.outputs.cache-=
hit !=3D &#39;true&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0# on every step for building dependencies is ugl=
y but<br>
@@ -84,12 +85,33 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wget -c -P download-cache/ &quot;<=
a href=3D"https://build.openvpn.net/downloads/releases/tap-windows-$%7BTAP_=
WINDOWS_VERSION%7D.zip" rel=3D"noreferrer" target=3D"_blank">https://build.=
openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip</a>&q=
uot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wget -c -P download-cache/ &quot;<=
a href=3D"https://www.oberhumer.com/opensource/lzo/download/lzo-$%7BLZO_VER=
SION%7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">https://www.oberhumer.=
com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz</a>&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wget -c -P download-cache/ &quot;<=
a href=3D"https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-=
helper-$%7BPKCS11_HELPER_VERSION%7D/pkcs11-helper-$%7BPKCS11_HELPER_VERSION=
%7D.tar.bz2" rel=3D"noreferrer" target=3D"_blank">https://github.com/OpenSC=
/pkcs11-helper/releases/download/pkcs11-helper-${PKCS11_HELPER_VERSION}/pkc=
s11-helper-${PKCS11_HELPER_VERSION}.tar.bz2</a>&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wget -c -P download-cache/ &quot;<a hre=
f=3D"https://github.com/coreboot/cmocka/archive/refs/tags/cmocka-$%7BCMOCKA=
_VERSION%7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/coreboot/cmocka/archive/refs/tags/cmocka-${CMOCKA_VERSION}.tar.gz</a>&quot=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tar jxf &quot;download-cache/pkcs1=
1-helper-${PKCS11_HELPER_VERSION}.tar.bz2&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wget -c -P download-cache/ &quot;<=
a href=3D"https://www.openssl.org/source/old/1.1.1/openssl-$%7BOPENSSL_VERS=
ION%7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">https://www.openssl.org=
/source/old/1.1.1/openssl-${OPENSSL_VERSION}.tar.gz</a>&quot; || wget -c -P=
 download-cache/ &quot;<a href=3D"https://www.openssl.org/source/openssl-$%=
7BOPENSSL_VERSION%7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">https://w=
ww.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz</a>&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tar zxf &quot;download-cache/opens=
sl-${OPENSSL_VERSION}.tar.gz&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tar zxf &quot;download-cache/lzo-$=
{LZO_VERSION}.tar.gz&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tar zxf &quot;download-cache/cmocka-${C=
MOCKA_VERSION}.tar.gz&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unzip download-cache/tap-windows-$=
{TAP_WINDOWS_VERSION}.zip<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 - name: create cmocka build directory<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: mkdir cmocka-build<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: configure cmocka<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./cmocka-build&quot;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: cmake -GNinja -DCMAKE_C_COMPILER=3D${{ ma=
trix.chost }}-gcc -DCMAKE_CXX_COMPILER=3D${{ matrix.chost }}-g++ -DCMAKE_SY=
STEM_NAME=3DWindows -DCMAKE_PREFIX_PATH=3D${HOME}/mingw/opt/lib/pkgconfig/ =
-DCMAKE_INCLUDE_PATH=3D${HOME}/mingw/opt/lib/include -DCMAKE_LIBRARY_PATH=
=3D${HOME}/mingw/opt/lib -DCMAKE_INSTALL_PREFIX=3D${HOME}/mingw/opt/ ../cmo=
cka-cmocka-${{ env.CMOCKA_VERSION }}<br></blockquote><div><br></div><div>Pl=
ease add &quot;-DCMAKE_SHARED_LINKER_FLAGS=3D-static-libgcc&quot; so that c=
mocka.dll will only depend on native Windows dlls. We already do this while=
 building openssl dlls.</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: build cmocka<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./cmocka-build&quot;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ninja<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: install cmocka<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./cmocka-build&quot;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ninja install<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: Configure OpenSSL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: ./Configure --cross-compile-prefix=
=3D${{ matrix.chost }}- shared ${{ matrix.target }} no-capieng --prefix=3D&=
quot;${HOME}/mingw/opt&quot; --openssldir=3D&quot;${HOME}/mingw/opt&quot; -=
static-libgcc<br>
@@ -154,6 +176,89 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: build OpenVPN<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: make -j3<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0working-directory: openvpn<br>
+=C2=A0 =C2=A0 =C2=A0 - name: build OpenVPN unittests<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: make -j3 check<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: openvpn<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 # We use multiple upload-artifact here, so it becomes=
 a flat folder<br>
+=C2=A0 =C2=A0 =C2=A0 # structure since we need the ddls on the same level =
as the binaries<br></blockquote><div><br></div><div>ddls -&gt; dlls=C2=A0</=
div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 - name: Archive cmocka/openssl/lzo ddls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uses: actions/upload-artifact@...2689...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retention-days: 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: mingw-unittest-${{matrix.target}}=
-ossl${{ matrix.osslver }}-dlls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: &#39;~/mingw/opt/bin/*.dll&#39;<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Archive gcc dlls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uses: actions/upload-artifact@...2689...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retention-days: 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: mingw-unittest-${{matrix.target}}=
-ossl${{ matrix.osslver }}-dlls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: /usr/lib/gcc/${{ matrix.chost }}/=
10-win32/*.dll<br></blockquote><div><br></div><div>This=C2=A0section=C2=A0(=
&quot;Archive gcc dlls&quot;) is not required when mocka.dll=C2=A0is built =
with -static-libgcc as above. None of our <span>exe&#39;s or</span> <span>d=
lls will</span>=C2=A0have any dependency on these.</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Archive mingw dlls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uses: actions/upload-artifact@...2689...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retention-days: 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: mingw-unittest-${{matrix.target}}=
-ossl${{ matrix.osslver }}-dlls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: /usr/${{ matrix.chost }}/lib/*.dl=
l<br></blockquote><div><br></div><div>Same with this &quot;Archive mingw dl=
ls&quot; section</div><div>=C2=A0</div><div>I tested these changes here:=C2=
=A0<a href=3D"https://github.com/selvanair/openvpn/tree/automake-cryptoapi"=
 target=3D"_blank">https://github.com/selvanair/openvpn/tree/automake-crypt=
oapi</a></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 # libtool puts some wrapper binaries in openvpn/tests=
/unit_tests/openvpn/<br>
+=C2=A0 =C2=A0 =C2=A0 # and the real binaries in openvpn/tests/unit_tests/o=
penvpn/.libs/<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Archive unittest artifacts<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uses: actions/upload-artifact@...2689...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retention-days: 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: mingw-unittest-${{matrix.target}}=
-ossl${{ matrix.osslver }}-tests<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: openvpn/tests/unit_tests/openvpn/=
.libs/*.exe<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 # Currently not used by the unit test but might in th=
e future and also<br>
+=C2=A0 =C2=A0 =C2=A0 # helpful if manually downloading and running openvpn=
.exe from a mingw<br>
+=C2=A0 =C2=A0 =C2=A0 # build<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Archive openvpn binary<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uses: actions/upload-artifact@...2689...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retention-days: 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: mingw-unittest-${{matrix.target}}=
-ossl${{ matrix.osslver }}-tests<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: openvpn/src/openvpn/.libs/*.exe<b=
r>
+<br>
+=C2=A0 mingw-unittest:<br>
+=C2=A0 =C2=A0 needs: [ mingw ]<br>
+=C2=A0 =C2=A0 strategy:<br>
+=C2=A0 =C2=A0 =C2=A0 fail-fast: false<br>
+=C2=A0 =C2=A0 =C2=A0 matrix:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 osslver: [ 1.1.1q, 3.0.5 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 target: [ mingw64, mingw ]<br>
+<br>
+=C2=A0 =C2=A0 runs-on: windows-latest<br>
+=C2=A0 =C2=A0 name: &quot;mingw unittests - ${{matrix.target}} - OSSL ${{ =
matrix.osslver }}&quot;<br>
+=C2=A0 =C2=A0 steps:<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Retrieve mingw unittest dlls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uses: actions/download-artifact@...2689...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: mingw-unittest-${{matrix.target}}=
-ossl${{ matrix.osslver }}-dlls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: unittests<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Retrieve mingw unittest<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uses: actions/download-artifact@...2689...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: mingw-unittest-${{matrix.target}}=
-ossl${{ matrix.osslver }}-tests<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: unittests<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: List unittests directory<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: &quot;dir unittests&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Run unit tests<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ./unittests/argv_testdriver.exe<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ./unittests/auth_token_testdriver.exe<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ./unittests/buffer_testdriver.exe<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ./unittests/crypto_testdriver.exe<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ./unittests/misc_testdriver.exe<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ./unittests/ncp_testdriver.exe<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ./unittests/packet_id_testdriver.exe<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ./unittests/pkt_testdriver.exe<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ./unittests/provider_testdriver.exe<br>
<br>
=C2=A0 =C2=A0ubuntu:<br>
=C2=A0 =C2=A0 =C2=A0strategy:<br>
@@ -442,3 +547,4 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: make -j3<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: make check<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: make check<br>
+<br>
--</blockquote><div><br></div><div>A couple of minor issues with the way te=
st results are reported:</div><div><br></div><div>(1) The main name of the =
test being run is not printed</div><div><br></div><div>Normally=C2=A0when r=
un from make check, we will get &quot;PASSED pkt_testdriver&quot; etc at th=
e end which would be hard to recreate here. But we could add a line saying =
&quot;Running pkt_testdriver&quot; at the=C2=A0top. The individual tests wi=
thin each exe are printed by cmocka, but unfortunately not all tests are ca=
refully named to quickly see which group it belongs to.</div><div><br></div=
><div>(2) Messages like &quot;Running 4 tests&quot;, &quot;PASSED 4 tests&q=
uot; etc., appear out of order</div><div><br></div><div>Often &quot;PASSED&=
quot; appears before running tests or in the middle.</div><div><br></div><d=
iv>Eg.,</div><div><div style=3D"box-sizing:border-box"><div style=3D"box-si=
zing:border-box;line-height:20px;display:flex">[=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D] 9 test(s) run.<br>[ PASSED ] 11 test(s).<br>[ PASSED ] 7 test(s).<br>[=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 11 test(s)<br><br></div><div style=
=3D"box-sizing:border-box;line-height:20px;display:flex">Then comes the des=
cription of those 11 tests.</div><div style=3D"box-sizing:border-box;line-h=
eight:20px;display:flex"><br></div><div style=3D"box-sizing:border-box;line=
-height:20px;display:flex">Some tasks are running in parallel?</div><div st=
yle=3D"box-sizing:border-box;line-height:20px;display:flex"><br></div><div =
style=3D"box-sizing:border-box;line-height:20px;display:flex">That said, re=
porting=C2=A0improvements could be done as a follow-up as this is already q=
uite useful.</div><div style=3D"box-sizing:border-box;line-height:20px;disp=
lay:flex"><br></div><div style=3D"box-sizing:border-box;line-height:20px;di=
splay:flex">Regards,</div></div></div><div><br></div><div>Selva</div></div>=
</div></div>

--000000000000f558b105f43d3bb8--

