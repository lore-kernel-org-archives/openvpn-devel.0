MIME-Version: 1.0
References: <20220824105311.71288-1-arne@...1227...>
In-Reply-To: <20220824105311.71288-1-arne@...1227...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 24 Aug 2022 16:26:10 +0500
Message-ID: <CAFHpkQFi+--ZwcGpr=O+tiy3j1=xU6h0tu=5DYNbqoHj_7i+mA@...278...>
Content-Type: multipart/alternative; boundary="00000000000047a1ef05e6faf3fa"
Subject: Re: [Openvpn-devel] [PATCH] Add OpenSSL 3.0 to mingw build
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

--00000000000047a1ef05e6faf3fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

if this is not too late, can we add --libdir=3Dmingw/opt/lib to keep current
behaviour ?


+      # OpenSSL 3.0.5 installs itself into mingw/opt/lib64 instead of
+      # mingw/opt/lib, so we include both dirs in the following steps
+      # (pkcs11-helper and OpenVPN) so the libraries will be found

=D1=81=D1=80, 24 =D0=B0=D0=B2=D0=B3. 2022 =D0=B3. =D0=B2 15:55, Arne Schwab=
e <arne@...1227...>:

> This also updates the host system to ubuntu 22.04 and remove the
> ovpn-dco-win
> checkout as we now include the required headers in our own repository.
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  .github/workflows/build.yaml | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
> index b0f67a785..f2472fdcf 100644
> --- a/.github/workflows/build.yaml
> +++ b/.github/workflows/build.yaml
> @@ -39,31 +39,25 @@ jobs:
>      strategy:
>        fail-fast: false
>        matrix:
> +        osslver: [1.1.1q, 3.0.5]
> +        target: [mingw64, mingw]
>          include:
>            - target: mingw64
>              chost: x86_64-w64-mingw32
>            - target: mingw
>              chost: i686-w64-mingw32
>
> -    name: "gcc-mingw - ${{matrix.target}}"
> -
> -    runs-on: ubuntu-20.04
> +    name: "gcc-mingw - ${{matrix.target}} - OSSL ${{ matrix.osslver }}"
> +    runs-on: ubuntu-22.04
>      env:
>        MAKEFLAGS: -j3
>        LZO_VERSION: "2.10"
>        PKCS11_HELPER_VERSION: "1.29.0"
> -      OPENSSL_VERSION: "1.1.1n"
> +      OPENSSL_VERSION: "${{ matrix.osslver }}"
>        TAP_WINDOWS_VERSION: "9.23.3"
> -      CHOST: ${{ matrix.chost }}
> -      TARGET: ${{ matrix.target }}
>      steps:
>        - name: Install dependencies
>          run: sudo apt update && sudo apt install -y mingw-w64 libtool
> automake autoconf man2html unzip
> -      - name: Checkout ovpn-dco-win
> -        uses: actions/checkout@...2689...
> -        with:
> -          repository: OpenVPN/ovpn-dco-win
> -          path: ovpn-dco-win
>        - name: Checkout OpenVPN
>          uses: actions/checkout@...2689...
>          with:
> @@ -78,7 +72,7 @@ jobs:
>          uses: actions/cache@...2689...
>          with:
>            path: '~/mingw/'
> -          key: ${{ matrix.target }}-mingw-${{ env.OPENSSL_VERSION }}-${{
> env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{
> env.TAP_WINDOWS_VERSION }}
> +          key: ${{ matrix.target }}-mingw-${{ matrix.osslver }}-${{
> env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{
> env.TAP_WINDOWS_VERSION }}
>
>        # Repeating  if: steps.cache.outputs.cache-hit !=3D 'true'
>        # on every step for building dependencies is ugly but
> @@ -90,15 +84,15 @@ jobs:
>            wget -c -P download-cache/ "
> https://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VE=
RSION}.zip
> "
>            wget -c -P download-cache/ "
> https://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.=
gz
> "
>            wget -c -P download-cache/ "
> https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-$=
{PKCS11_HELPER_VERSION}/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2
> "
> -          wget -c -P download-cache/ "
> https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"
>            tar jxf
> "download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2"
> +          wget -c -P download-cache/ "
> https://www.openssl.org/source/old/1.1.1/openssl-${OPENSSL_VERSION}.tar.g=
z"
> || wget -c -P download-cache/ "
> https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"
>            tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
>            tar zxf "download-cache/lzo-${LZO_VERSION}.tar.gz"
>            unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip
>
>        - name: Configure OpenSSL
>          if: steps.cache.outputs.cache-hit !=3D 'true'
> -        run: ./Configure --cross-compile-prefix=3D${CHOST}- shared ${{
> matrix.target }} no-capieng --prefix=3D"${HOME}/mingw/opt"
> --openssldir=3D"${HOME}/mingw/opt" -static-libgcc
> +        run: ./Configure --cross-compile-prefix=3D${{ matrix.chost }}-
> shared ${{ matrix.target }} no-capieng --prefix=3D"${HOME}/mingw/opt"
> --openssldir=3D"${HOME}/mingw/opt" -static-libgcc
>          working-directory: "./openssl-${{ env.OPENSSL_VERSION }}"
>
>        - name: Build OpenSSL
> @@ -106,6 +100,9 @@ jobs:
>          run: make
>          working-directory: "./openssl-${{ env.OPENSSL_VERSION }}"
>
> +      # OpenSSL 3.0.5 installs itself into mingw/opt/lib64 instead of
> +      # mingw/opt/lib, so we include both dirs in the following steps
> +      # (pkcs11-helper and OpenVPN) so the libraries will be found
>        - name: Install OpenSSL
>          if: steps.cache.outputs.cache-hit !=3D 'true'
>          run: make install
> @@ -118,7 +115,7 @@ jobs:
>
>        - name: configure pkcs11-helper
>          if: steps.cache.outputs.cache-hit !=3D 'true'
> -        run: OPENSSL_LIBS=3D"-L${HOME}/mingw/opt/lib -lssl -lcrypto"
> OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include
> PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig ./configure --host=3D${=
CHOST}
> --program-prefix=3D'' --libdir=3D${HOME}/mingw/opt/lib
> --prefix=3D${HOME}/mingw/opt --build=3Dx86_64-pc-linux-gnu
> --disable-crypto-engine-gnutls --disable-crypto-engine-nss
> --disable-crypto-engine-polarssl --disable-crypto-engine-mbedtls
> +        run: OPENSSL_LIBS=3D"-L${HOME}/mingw/opt/lib
> -L${HOME}/mingw/opt/lib64 -lssl -lcrypto"
> OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include
> PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig ./configure --host=3D${{
> matrix.chost }} --program-prefix=3D'' --libdir=3D${HOME}/mingw/opt/lib
> --prefix=3D${HOME}/mingw/opt --build=3Dx86_64-pc-linux-gnu
> --disable-crypto-engine-gnutls --disable-crypto-engine-nss
> --disable-crypto-engine-polarssl --disable-crypto-engine-mbedtls
>          working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION
> }}"
>
>        - name: build pkcs11-helper
> @@ -133,7 +130,7 @@ jobs:
>
>        - name: Configure lzo
>          if: steps.cache.outputs.cache-hit !=3D 'true'
> -        run: ./configure --host=3D${CHOST} --program-prefix=3D''
> --libdir=3D${HOME}/mingw/opt/lib --prefix=3D${HOME}/mingw/opt
> --build=3Dx86_64-pc-linux-gnu
> +        run: ./configure --host=3D${{ matrix.chost }} --program-prefix=
=3D''
> --libdir=3D${HOME}/mingw/opt/lib --prefix=3D${HOME}/mingw/opt
> --build=3Dx86_64-pc-linux-gnu
>          working-directory: "./lzo-${{ env.LZO_VERSION }}"
>
>        - name: build lzo
> @@ -151,7 +148,7 @@ jobs:
>          run: cp
> ./tap-windows-${TAP_WINDOWS_VERSION}/include/tap-windows.h
> ${HOME}/mingw/opt/include/
>
>        - name: configure OpenVPN
> -        run: PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig
> DCO_SOURCEDIR=3D$(realpath ../ovpn-dco-win) LDFLAGS=3D-L$HOME/mingw/opt/l=
ib
> CFLAGS=3D-I$HOME/mingw/opt/include OPENSSL_LIBS=3D"-L${HOME}/opt/lib -lssl
> -lcrypto" OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include PREFIX=3D$HOME/mingw=
/opt
> LZO_CFLAGS=3D-I$HOME/mingw/opt/include LZO_LIBS=3D"-L${HOME}/mingw/opt/lib
> -llzo2" ./configure  --host=3D${CHOST} --disable-lz4 --enable-dco
> +        run: PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig
> DCO_SOURCEDIR=3D$(realpath ../ovpn-dco-win) LDFLAGS=3D"-L$HOME/mingw/opt/=
lib
> -L$HOME/mingw/opt/lib64" CFLAGS=3D-I$HOME/mingw/opt/include
> OPENSSL_LIBS=3D"-L${HOME}/opt/lib -lssl -lcrypto"
> OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include PREFIX=3D$HOME/mingw/opt
> LZO_CFLAGS=3D-I$HOME/mingw/opt/include LZO_LIBS=3D"-L${HOME}/mingw/opt/lib
> -llzo2" ./configure  --host=3D${{ matrix.chost }} --disable-lz4 --enable-=
dco
>          working-directory: openvpn
>
>        - name: build OpenVPN
> --
> 2.32.1 (Apple Git-133)
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--00000000000047a1ef05e6faf3fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">if this is not too late,=
 can we add --libdir=3Dmingw/opt/lib to keep current behaviour ?<div><br></=
div><div><br></div><div>+=C2=A0 =C2=A0 =C2=A0 # OpenSSL 3.0.5 installs itse=
lf into mingw/opt/lib64 instead of<br>+=C2=A0 =C2=A0 =C2=A0 # mingw/opt/lib=
, so we include both dirs in the following steps<br>+=C2=A0 =C2=A0 =C2=A0 #=
 (pkcs11-helper and OpenVPN) so the libraries will be found<br></div></div>=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">=D1=81=D1=80, 24 =D0=B0=D0=B2=D0=B3. 2022 =D0=B3. =D0=B2 15:55, Arne =
Schwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt;:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">This also updates t=
he host system to ubuntu 22.04 and remove the ovpn-dco-win<br>
checkout as we now include the required headers in our own repository.<br>
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0.github/workflows/build.yaml | 31 ++++++++++++++-----------------<br>
=C2=A01 file changed, 14 insertions(+), 17 deletions(-)<br>
<br>
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml<br>
index b0f67a785..f2472fdcf 100644<br>
--- a/.github/workflows/build.yaml<br>
+++ b/.github/workflows/build.yaml<br>
@@ -39,31 +39,25 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0strategy:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0fail-fast: false<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0matrix:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 osslver: [1.1.1q, 3.0.5]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 target: [mingw64, mingw]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0include:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- target: mingw64<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chost: x86_64-w64-mingw32<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- target: mingw<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chost: i686-w64-mingw32<br>
<br>
-=C2=A0 =C2=A0 name: &quot;gcc-mingw - ${{matrix.target}}&quot;<br>
-<br>
-=C2=A0 =C2=A0 runs-on: ubuntu-20.04<br>
+=C2=A0 =C2=A0 name: &quot;gcc-mingw - ${{matrix.target}} - OSSL ${{ matrix=
.osslver }}&quot;<br>
+=C2=A0 =C2=A0 runs-on: ubuntu-22.04<br>
=C2=A0 =C2=A0 =C2=A0env:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0MAKEFLAGS: -j3<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0LZO_VERSION: &quot;2.10&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0PKCS11_HELPER_VERSION: &quot;1.29.0&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 OPENSSL_VERSION: &quot;1.1.1n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 OPENSSL_VERSION: &quot;${{ matrix.osslver }}&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0TAP_WINDOWS_VERSION: &quot;9.23.3&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 CHOST: ${{ matrix.chost }}<br>
-=C2=A0 =C2=A0 =C2=A0 TARGET: ${{ matrix.target }}<br>
=C2=A0 =C2=A0 =C2=A0steps:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: Install dependencies<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: sudo apt update &amp;&amp; sudo apt =
install -y mingw-w64 libtool automake autoconf man2html unzip<br>
-=C2=A0 =C2=A0 =C2=A0 - name: Checkout ovpn-dco-win<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uses: actions/checkout@...2689...<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 with:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repository: OpenVPN/ovpn-dco-win<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: ovpn-dco-win<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: Checkout OpenVPN<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uses: actions/checkout@...2689...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with:<br>
@@ -78,7 +72,7 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uses: actions/cache@...2689...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path: &#39;~/mingw/&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key: ${{ matrix.target }}-mingw-${{ env=
.OPENSSL_VERSION }}-${{ env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}=
-${{ env.TAP_WINDOWS_VERSION }}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key: ${{ matrix.target }}-mingw-${{ mat=
rix.osslver }}-${{ env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{ =
env.TAP_WINDOWS_VERSION }}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0# Repeating=C2=A0 if: steps.cache.outputs.cache-=
hit !=3D &#39;true&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0# on every step for building dependencies is ugl=
y but<br>
@@ -90,15 +84,15 @@ jobs:<br>
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
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wget -c -P download-cache/ &quot;<a hre=
f=3D"https://www.openssl.org/source/openssl-$%7BOPENSSL_VERSION%7D.tar.gz" =
rel=3D"noreferrer" target=3D"_blank">https://www.openssl.org/source/openssl=
-${OPENSSL_VERSION}.tar.gz</a>&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tar jxf &quot;download-cache/pkcs1=
1-helper-${PKCS11_HELPER_VERSION}.tar.bz2&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wget -c -P download-cache/ &quot;<a hre=
f=3D"https://www.openssl.org/source/old/1.1.1/openssl-$%7BOPENSSL_VERSION%7=
D.tar.gz" rel=3D"noreferrer" target=3D"_blank">https://www.openssl.org/sour=
ce/old/1.1.1/openssl-${OPENSSL_VERSION}.tar.gz</a>&quot; || wget -c -P down=
load-cache/ &quot;<a href=3D"https://www.openssl.org/source/openssl-$%7BOPE=
NSSL_VERSION%7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">https://www.op=
enssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz</a>&quot; <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tar zxf &quot;download-cache/opens=
sl-${OPENSSL_VERSION}.tar.gz&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tar zxf &quot;download-cache/lzo-$=
{LZO_VERSION}.tar.gz&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unzip download-cache/tap-windows-$=
{TAP_WINDOWS_VERSION}.zip<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: Configure OpenSSL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ./Configure --cross-compile-prefix=3D${CH=
OST}- shared ${{ matrix.target }} no-capieng --prefix=3D&quot;${HOME}/mingw=
/opt&quot; --openssldir=3D&quot;${HOME}/mingw/opt&quot; -static-libgcc<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ./Configure --cross-compile-prefix=3D${{ =
matrix.chost }}- shared ${{ matrix.target }} no-capieng --prefix=3D&quot;${=
HOME}/mingw/opt&quot; --openssldir=3D&quot;${HOME}/mingw/opt&quot; -static-=
libgcc<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0working-directory: &quot;./openssl-${{ en=
v.OPENSSL_VERSION }}&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: Build OpenSSL<br>
@@ -106,6 +100,9 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: make<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0working-directory: &quot;./openssl-${{ en=
v.OPENSSL_VERSION }}&quot;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 # OpenSSL 3.0.5 installs itself into mingw/opt/lib64 =
instead of<br>
+=C2=A0 =C2=A0 =C2=A0 # mingw/opt/lib, so we include both dirs in the follo=
wing steps<br>
+=C2=A0 =C2=A0 =C2=A0 # (pkcs11-helper and OpenVPN) so the libraries will b=
e found<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: Install OpenSSL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: make install<br>
@@ -118,7 +115,7 @@ jobs:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: configure pkcs11-helper<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: OPENSSL_LIBS=3D&quot;-L${HOME}/mingw/opt/=
lib -lssl -lcrypto&quot; OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include PKG_CON=
FIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig ./configure --host=3D${CHOST} --=
program-prefix=3D&#39;&#39; --libdir=3D${HOME}/mingw/opt/lib --prefix=3D${H=
OME}/mingw/opt --build=3Dx86_64-pc-linux-gnu --disable-crypto-engine-gnutls=
 --disable-crypto-engine-nss --disable-crypto-engine-polarssl --disable-cry=
pto-engine-mbedtls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: OPENSSL_LIBS=3D&quot;-L${HOME}/mingw/opt/=
lib -L${HOME}/mingw/opt/lib64 -lssl -lcrypto&quot; OPENSSL_CFLAGS=3D-I$HOME=
/mingw/opt/include PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig ./conf=
igure --host=3D${{ matrix.chost }} --program-prefix=3D&#39;&#39; --libdir=
=3D${HOME}/mingw/opt/lib --prefix=3D${HOME}/mingw/opt --build=3Dx86_64-pc-l=
inux-gnu --disable-crypto-engine-gnutls --disable-crypto-engine-nss --disab=
le-crypto-engine-polarssl --disable-crypto-engine-mbedtls<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0working-directory: &quot;./pkcs11-helper-=
${{ env.PKCS11_HELPER_VERSION }}&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: build pkcs11-helper<br>
@@ -133,7 +130,7 @@ jobs:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: Configure lzo<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ./configure --host=3D${CHOST} --program-p=
refix=3D&#39;&#39; --libdir=3D${HOME}/mingw/opt/lib --prefix=3D${HOME}/ming=
w/opt --build=3Dx86_64-pc-linux-gnu<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: ./configure --host=3D${{ matrix.chost }} =
--program-prefix=3D&#39;&#39; --libdir=3D${HOME}/mingw/opt/lib --prefix=3D$=
{HOME}/mingw/opt --build=3Dx86_64-pc-linux-gnu<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0working-directory: &quot;./lzo-${{ env.LZ=
O_VERSION }}&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: build lzo<br>
@@ -151,7 +148,7 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: cp ./tap-windows-${TAP_WINDOWS_VERSI=
ON}/include/tap-windows.h ${HOME}/mingw/opt/include/<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: configure OpenVPN<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/p=
kgconfig DCO_SOURCEDIR=3D$(realpath ../ovpn-dco-win) LDFLAGS=3D-L$HOME/ming=
w/opt/lib CFLAGS=3D-I$HOME/mingw/opt/include OPENSSL_LIBS=3D&quot;-L${HOME}=
/opt/lib -lssl -lcrypto&quot; OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include PR=
EFIX=3D$HOME/mingw/opt LZO_CFLAGS=3D-I$HOME/mingw/opt/include LZO_LIBS=3D&q=
uot;-L${HOME}/mingw/opt/lib -llzo2&quot; ./configure=C2=A0 --host=3D${CHOST=
} --disable-lz4 --enable-dco<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/p=
kgconfig DCO_SOURCEDIR=3D$(realpath ../ovpn-dco-win) LDFLAGS=3D&quot;-L$HOM=
E/mingw/opt/lib -L$HOME/mingw/opt/lib64&quot; CFLAGS=3D-I$HOME/mingw/opt/in=
clude OPENSSL_LIBS=3D&quot;-L${HOME}/opt/lib -lssl -lcrypto&quot; OPENSSL_C=
FLAGS=3D-I$HOME/mingw/opt/include PREFIX=3D$HOME/mingw/opt LZO_CFLAGS=3D-I$=
HOME/mingw/opt/include LZO_LIBS=3D&quot;-L${HOME}/mingw/opt/lib -llzo2&quot=
; ./configure=C2=A0 --host=3D${{ matrix.chost }} --disable-lz4 --enable-dco=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0working-directory: openvpn<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: build OpenVPN<br>
-- <br>
2.32.1 (Apple Git-133)<br>
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
</blockquote></div>

--00000000000047a1ef05e6faf3fa--

