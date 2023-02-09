MIME-Version: 1.0
References: <20230208001819.244694-1-arne@...1227...>
 <20230209163705.466173-1-arne@...1227...>
 <CAKuzo_ghR3UVbbz794+nk0gfeX9tgsO8-OxYf==VPJL=1CUxmw@...278...>
In-Reply-To: <CAKuzo_ghR3UVbbz794+nk0gfeX9tgsO8-OxYf==VPJL=1CUxmw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 9 Feb 2023 17:22:59 -0500
Message-ID: <CAKuzo_jfFPAc-koBy=yqXjTH3jfH_Jh=pr+McyAB64iMnK-CNw@...278...>
Content-Type: multipart/alternative; boundary="000000000000b45ded05f44bd319"
Subject: [Openvpn-devel] Fwd: [PATCH v2 5/5] Add building unit tests with
 mingw to github actions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000b45ded05f44bd319
Content-Type: text/plain; charset="UTF-8"

CC: list was missed..

---------- Forwarded message ---------
From: Selva Nair <selva.nair@...277...>
Date: Thu, Feb 9, 2023 at 2:54 PM
Subject: Re: [Openvpn-devel] [PATCH v2 5/5] Add building unit tests with
mingw to github actions
To: Arne Schwabe <arne@...1227...>


Hi,

Thanks, this is much better with tests grouped together.

Some nitpicks below that could be fixed while merging.

On Thu, Feb 9, 2023 at 11:38 AM Arne Schwabe <arne@...1227...> wrote:

> This runs each test in its own action since order of stderr and stdout
> is seemingly random in github action Windows output and this way at least
> tests outputs are groups gy test
>

"test outputs are grouped by"


>
> Patch v2: use -static-libgcc to avoid comping gcc runtime libraries.
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  .github/workflows/build.yaml | 111 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 109 insertions(+), 2 deletions(-)
>
> diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
> index 5888e91e5..a1026fddb 100644
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
> -DCMAKE_SHARED_LINKER_FLAGS=-static-libgcc
> -DCMAKE_PREFIX_PATH=${HOME}/mingw/opt/lib/pkgconfig/
> -DCMAKE_INCLUDE_PATH=${HOME}/mingw/opt/lib/include
> -DCMAKE_LIBRARY_PATH=${HOME}/mingw/opt/lib
> -DCMAKE_INSTALL_PREFIX=${HOME}/mingw/opt/ ../cmocka-cmocka-${{
> env.CMOCKA_VERSION }}
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
> @@ -154,6 +176,90 @@ jobs:
>        - name: build OpenVPN
>          run: make -j3
>          working-directory: openvpn
> +      - name: build OpenVPN unittests
> +        run: make -j3 check
> +        working-directory: openvpn
> +
> +      # We use multiple upload-artifact here, so it becomes a flat folder
> +      # structure since we need the dlls on the same level as the binaries
> +      - name: Archive cmocka/openssl/lzo dlls
> +        uses: actions/upload-artifact@...2689...
> +        with:
> +          retention-days: 1
> +          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver
> }}-dlls
> +          path: '~/mingw/opt/bin/*.dll'
> +
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
> +      - name: Run argvunit test
>

"argvunit test" --> "argv unit test" etc. here and below ? This gets
printed as the action name in output.

+        run: ./unittests/argv_testdriver.exe
> +
> +      - name: Run auth_tokenunit test

+        run: ./unittests/auth_token_testdriver.exe
> +
> +      - name: Run bufferunit test
> +        run: ./unittests/buffer_testdriver.exe
> +
> +      - name: Run cryptounit test
> +        run: ./unittests/crypto_testdriver.exe
> +
> +      - name: Run miscunit test
> +        run: ./unittests/misc_testdriver.exe
> +
> +      - name: Run ncpunit test
> +        run: ./unittests/ncp_testdriver.exe
> +
> +      - name: Run packet idunit test
> +        run: ./unittests/packet_id_testdriver.exe
> +
> +      - name: Run pktunit test
> +        run: ./unittests/pkt_testdriver.exe
> +
> +      - name: Run providerunit test
> +        run: ./unittests/provider_testdriver.exe
>
>    ubuntu:
>      strategy:
> @@ -450,3 +556,4 @@ jobs:
>          run: make -j3
>        - name: make check
>          run: make check
> +


Acked-by: Selva Nair <selva.nair@...277...>

--000000000000b45ded05f44bd319
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">CC: list was missed..<br><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">---------- Forwarded message ---------<=
br>From: <strong class=3D"gmail_sendername" dir=3D"auto">Selva Nair</strong=
> <span dir=3D"auto">&lt;<a href=3D"mailto:selva.nair@...277...">selva.nair=
@...277...</a>&gt;</span><br>Date: Thu, Feb 9, 2023 at 2:54 PM<br>Subject: =
Re: [Openvpn-devel] [PATCH v2 5/5] Add building unit tests with mingw to gi=
thub actions<br>To: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227...">arn=
e@...1227...</a>&gt;<br></div><br><br><div dir=3D"ltr"><div>Hi,</div><div><=
br></div><div>Thanks, this is much better with tests grouped together.</div=
><div><br></div><div>Some nitpicks below that could be fixed while merging.=
</div><div><br></div><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Feb 9, 2023 at 11:38 AM Arne Schwabe &lt;<a href=3D=
"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">This runs each te=
st in its own action since order of stderr and stdout<br>
is seemingly random in github action Windows output and this way at least<b=
r>
tests outputs are groups gy test<br></blockquote><div><br></div><div>&quot;=
test outputs are grouped by&quot;</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
Patch v2: use -static-libgcc to avoid comping gcc runtime libraries.<br>
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0.github/workflows/build.yaml | 111 ++++++++++++++++++++++++++++++++++=
-<br>
=C2=A01 file changed, 109 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml<br>
index 5888e91e5..a1026fddb 100644<br>
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
STEM_NAME=3DWindows -DCMAKE_SHARED_LINKER_FLAGS=3D-static-libgcc -DCMAKE_PR=
EFIX_PATH=3D${HOME}/mingw/opt/lib/pkgconfig/ -DCMAKE_INCLUDE_PATH=3D${HOME}=
/mingw/opt/lib/include -DCMAKE_LIBRARY_PATH=3D${HOME}/mingw/opt/lib -DCMAKE=
_INSTALL_PREFIX=3D${HOME}/mingw/opt/ ../cmocka-cmocka-${{ env.CMOCKA_VERSIO=
N }}<br>
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
@@ -154,6 +176,90 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: build OpenVPN<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: make -j3<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0working-directory: openvpn<br>
+=C2=A0 =C2=A0 =C2=A0 - name: build OpenVPN unittests<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: make -j3 check<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: openvpn<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 # We use multiple upload-artifact here, so it becomes=
 a flat folder<br>
+=C2=A0 =C2=A0 =C2=A0 # structure since we need the dlls on the same level =
as the binaries<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Archive cmocka/openssl/lzo dlls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uses: actions/upload-artifact@...2689...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retention-days: 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: mingw-unittest-${{matrix.target}}=
-ossl${{ matrix.osslver }}-dlls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: &#39;~/mingw/opt/bin/*.dll&#39;<b=
r>
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
+=C2=A0 =C2=A0 =C2=A0 - name: Run argvunit test<br>
</blockquote><div><br></div><div>&quot;argvunit=C2=A0test&quot; --&gt; &quo=
t;argv unit test&quot; etc. here and below ? This gets printed as the actio=
n name in output.</div><div><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ./unittests/argv_testdriver.=
exe<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Run auth_tokenunit test=C2=A0</blockquote><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ./unittests/auth_token_testdriver.exe<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Run bufferunit test<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ./unittests/buffer_testdriver.exe<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Run cryptounit test<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ./unittests/crypto_testdriver.exe<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Run miscunit test<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ./unittests/misc_testdriver.exe<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Run ncpunit test<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ./unittests/ncp_testdriver.exe<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Run packet idunit test<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ./unittests/packet_id_testdriver.exe<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Run pktunit test<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ./unittests/pkt_testdriver.exe<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Run providerunit test<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ./unittests/provider_testdriver.exe<br>
<br>
=C2=A0 =C2=A0ubuntu:<br>
=C2=A0 =C2=A0 =C2=A0strategy:<br>
@@ -450,3 +556,4 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: make -j3<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: make check<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: make check<br>
+</blockquote><div><br></div>Acked-by: Selva Nair &lt;<a href=3D"mailto:sel=
va.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;<br></div>=
</div></div>
</div></div>

--000000000000b45ded05f44bd319--

