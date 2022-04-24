MIME-Version: 1.0
References: <20220424192510.75385-1-becm@...68...>
In-Reply-To: <20220424192510.75385-1-becm@...68...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 25 Apr 2022 00:41:21 +0500
Message-ID: <CAFHpkQFLyEdJwK+ewKAQst1KViTNuPf+EUjLvXX1=17xFj4rTg@...278...>
Content-Type: multipart/alternative; boundary="00000000000093de0705dd6ba5ec"
Subject: Re: [Openvpn-devel] [PATCH] fix GitHub workflow working directories
 in MinGW builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marc Becker <becm@...68...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000093de0705dd6ba5ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I recall that link "
https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz" becomes
broken as soon as new version is released.
that is the way how openssl warns you to update.

"old" links are immutable.

=D0=BF=D0=BD, 25 =D0=B0=D0=BF=D1=80. 2022 =D0=B3. =D0=B2 00:27, Marc Becker=
 <becm@...68...>:

> replace hardcoded directory names with env variable version info
> bump pkcs11-helper version to 1.29.0
> bump OpenSSL version to 1.1.1n
> add OpenSSL version to cache key
> use release file for pkcs11-helper archive
> use OpenSSL URL endpoint with all/current versions
>
> Signed-off-by: Marc Becker <becm@...68...>
> ---
>  .github/workflows/build.yaml | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
> index fa99e12b..34a9d9b9 100644
> --- a/.github/workflows/build.yaml
> +++ b/.github/workflows/build.yaml
> @@ -19,8 +19,8 @@ jobs:
>      env:
>        MAKEFLAGS: -j3
>        LZO_VERSION: "2.10"
> -      PKCS11_HELPER_VERSION: "1.26"
> -      OPENSSL_VERSION: "1.1.1j"
> +      PKCS11_HELPER_VERSION: "1.29.0"
> +      OPENSSL_VERSION: "1.1.1n"
>        TAP_WINDOWS_VERSION: "9.23.3"
>        CHOST: ${{ matrix.chost }}
>        TARGET: ${{ matrix.target }}
> @@ -46,20 +46,20 @@ jobs:
>          uses: actions/cache@...2620...
>          with:
>            path: '~/mingw/'
> -          key: ${{ matrix.target }}-mingw-${{ env.LZO_VERSION }}-${{
> env.PKCS11_HELPER_VERSION }}-${{ env.TAP_WINDOWS_VERSION }}
> +          key: ${{ matrix.target }}-mingw-${{ env.OPENSSL_VERSION }}-${{
> env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{
> env.TAP_WINDOWS_VERSION }}
>
>        # Repeating  if: steps.cache.outputs.cache-hit !=3D 'true'
>        # on every step for building dependencies is ugly but
>        # I haven't found a better solution so far.
>
> -      - name: Download mingw depnendencies
> +      - name: Download mingw dependencies
>          if: steps.cache.outputs.cache-hit !=3D 'true'
>          run: |
>            wget -c -P download-cache/ "
> https://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VE=
RSION}.zip
> "
>            wget -c -P download-cache/ "
> https://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.=
gz
> "
> -          wget -c -P download-cache/ "
> https://github.com/OpenSC/pkcs11-helper/archive/pkcs11-helper-${PKCS11_HE=
LPER_VERSION}.tar.gz
> "
> -          wget -c -P download-cache/ "
> https://www.openssl.org/source/old/1.1.1/openssl-${OPENSSL_VERSION}.tar.gz
> "
> -          tar zxf
> "download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.gz"
> +          wget -c -P download-cache/ "
> https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-$=
{PKCS11_HELPER_VERSION}/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2
> "
> +          wget -c -P download-cache/ "
> https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"
> +          tar jxf
> "download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2"
>            tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
>            tar zxf "download-cache/lzo-${LZO_VERSION}.tar.gz"
>            unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip
> @@ -67,56 +67,56 @@ jobs:
>        - name: Configure OpenSSL
>          if: steps.cache.outputs.cache-hit !=3D 'true'
>          run: ./Configure --cross-compile-prefix=3D${CHOST}- shared ${{
> matrix.target }} no-capieng --prefix=3D"${HOME}/mingw/opt"
> --openssldir=3D"${HOME}/mingw/opt" -static-libgcc
> -        working-directory: "./openssl-1.1.1j"
> +        working-directory: "./openssl-${{ env.OPENSSL_VERSION }}"
>
>        - name: Build OpenSSL
>          if: steps.cache.outputs.cache-hit !=3D 'true'
>          run: make
> -        working-directory: "./openssl-1.1.1j/"
> +        working-directory: "./openssl-${{ env.OPENSSL_VERSION }}"
>
>        - name: Install OpenSSL
>          if: steps.cache.outputs.cache-hit !=3D 'true'
>          run: make install
> -        working-directory: "./openssl-1.1.1j/"
> +        working-directory: "./openssl-${{ env.OPENSSL_VERSION }}"
>
>        - name: autoreconf pkcs11-helper
>          if: steps.cache.outputs.cache-hit !=3D 'true'
>          run: autoreconf -iv
> -        working-directory: "./pkcs11-helper-pkcs11-helper-1.26"
> +        working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION
> }}"
>
>        - name: configure pkcs11-helper
>          if: steps.cache.outputs.cache-hit !=3D 'true'
>          run: OPENSSL_LIBS=3D"-L${HOME}/mingw/opt/lib -lssl -lcrypto"
> OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include
> PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig ./configure --host=3D${=
CHOST}
> --program-prefix=3D'' --libdir=3D${HOME}/mingw/opt/lib
> --prefix=3D${HOME}/mingw/opt --build=3Dx86_64-pc-linux-gnu
> --disable-crypto-engine-gnutls --disable-crypto-engine-nss
> --disable-crypto-engine-polarssl --disable-crypto-engine-mbedtls
> -        working-directory: "./pkcs11-helper-pkcs11-helper-1.26"
> +        working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION
> }}"
>
>        - name: build pkcs11-helper
>          if: steps.cache.outputs.cache-hit !=3D 'true'
>          run: make all
> -        working-directory: "./pkcs11-helper-pkcs11-helper-1.26"
> +        working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION
> }}"
>
>        - name: install pkcs11-helper
>          if: steps.cache.outputs.cache-hit !=3D 'true'
>          run: make install
> -        working-directory: "./pkcs11-helper-pkcs11-helper-1.26"
> +        working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION
> }}"
>
>        - name: Configure lzo
>          if: steps.cache.outputs.cache-hit !=3D 'true'
>          run: ./configure --host=3D${CHOST} --program-prefix=3D''
> --libdir=3D${HOME}/mingw/opt/lib --prefix=3D${HOME}/mingw/opt
> --build=3Dx86_64-pc-linux-gnu
> -        working-directory: "./lzo-2.10"
> +        working-directory: "./lzo-${{ env.LZO_VERSION }}"
>
>        - name: build lzo
>          if: steps.cache.outputs.cache-hit !=3D 'true'
> -        working-directory: "./lzo-2.10"
> +        working-directory: "./lzo-${{ env.LZO_VERSION }}"
>          run: make
>
>        - name: install lzo
>          if: steps.cache.outputs.cache-hit !=3D 'true'
> -        working-directory: "./lzo-2.10"
> +        working-directory: "./lzo-${{ env.LZO_VERSION }}"
>          run: make install
>
>        - name: copy tap-windows.h header
>          if: steps.cache.outputs.cache-hit !=3D 'true'
> -        run: cp ./tap-windows-9.23.3/include/tap-windows.h
> ${HOME}/mingw/opt/include/
> +        run: cp
> ./tap-windows-${TAP_WINDOWS_VERSION}/include/tap-windows.h
> ${HOME}/mingw/opt/include/
>
>        - name: configure OpenVPN
>          run: PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig
> DCO_SOURCEDIR=3D$(realpath ../ovpn-dco-win) LDFLAGS=3D-L$HOME/mingw/opt/l=
ib
> CFLAGS=3D-I$HOME/mingw/opt/include OPENSSL_LIBS=3D"-L${HOME}/opt/lib -lssl
> -lcrypto" OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include PREFIX=3D$HOME/mingw=
/opt
> LZO_CFLAGS=3D-I$HOME/mingw/opt/include LZO_LIBS=3D"-L${HOME}/mingw/opt/lib
> -llzo2" ./configure  --host=3D${CHOST} --disable-lz4 --enable-dco
> --
> 2.30.2
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--00000000000093de0705dd6ba5ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I recall that link &quot;<a href=3D"https://www.opens=
sl.org/source/openssl-${OPENSSL_VERSION}.tar.gz">https://www.openssl.org/so=
urce/openssl-${OPENSSL_VERSION}.tar.gz</a>&quot; becomes broken as soon as =
new version is released.</div><div>that is the way how openssl warns you to=
 update.</div><div><br></div><div>&quot;old&quot; links are immutable.<br><=
/div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">=D0=BF=D0=BD, 25 =D0=B0=D0=BF=D1=80. 2022 =D0=B3. =D0=B2 00:27, Marc B=
ecker &lt;<a href=3D"mailto:becm@...68...">becm@...68...</a>&gt;:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">replace hardcoded directo=
ry names with env variable version info<br>
bump pkcs11-helper version to 1.29.0<br>
bump OpenSSL version to 1.1.1n<br>
add OpenSSL version to cache key<br>
use release file for pkcs11-helper archive<br>
use OpenSSL URL endpoint with all/current versions<br>
<br>
Signed-off-by: Marc Becker &lt;<a href=3D"mailto:becm@...68..." target=3D"_=
blank">becm@...68...</a>&gt;<br>
---<br>
=C2=A0.github/workflows/build.yaml | 36 ++++++++++++++++++-----------------=
-<br>
=C2=A01 file changed, 18 insertions(+), 18 deletions(-)<br>
<br>
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml<br>
index fa99e12b..34a9d9b9 100644<br>
--- a/.github/workflows/build.yaml<br>
+++ b/.github/workflows/build.yaml<br>
@@ -19,8 +19,8 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0env:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0MAKEFLAGS: -j3<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0LZO_VERSION: &quot;2.10&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 PKCS11_HELPER_VERSION: &quot;1.26&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 OPENSSL_VERSION: &quot;1.1.1j&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 PKCS11_HELPER_VERSION: &quot;1.29.0&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 OPENSSL_VERSION: &quot;1.1.1n&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0TAP_WINDOWS_VERSION: &quot;9.23.3&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0CHOST: ${{ matrix.chost }}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET: ${{ matrix.target }}<br>
@@ -46,20 +46,20 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uses: actions/cache@...2620...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path: &#39;~/mingw/&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key: ${{ matrix.target }}-mingw-${{ env=
.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{ env.TAP_WINDOWS_VERSIO=
N }}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key: ${{ matrix.target }}-mingw-${{ env=
.OPENSSL_VERSION }}-${{ env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}=
-${{ env.TAP_WINDOWS_VERSION }}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0# Repeating=C2=A0 if: steps.cache.outputs.cache-=
hit !=3D &#39;true&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0# on every step for building dependencies is ugl=
y but<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0# I haven&#39;t found a better solution so far.<=
br>
<br>
-=C2=A0 =C2=A0 =C2=A0 - name: Download mingw depnendencies<br>
+=C2=A0 =C2=A0 =C2=A0 - name: Download mingw dependencies<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wget -c -P download-cache/ &quot;<=
a href=3D"https://build.openvpn.net/downloads/releases/tap-windows-$%7BTAP_=
WINDOWS_VERSION%7D.zip" rel=3D"noreferrer" target=3D"_blank">https://build.=
openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip</a>&q=
uot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wget -c -P download-cache/ &quot;<=
a href=3D"https://www.oberhumer.com/opensource/lzo/download/lzo-$%7BLZO_VER=
SION%7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">https://www.oberhumer.=
com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz</a>&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wget -c -P download-cache/ &quot;<a hre=
f=3D"https://github.com/OpenSC/pkcs11-helper/archive/pkcs11-helper-$%7BPKCS=
11_HELPER_VERSION%7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">https://g=
ithub.com/OpenSC/pkcs11-helper/archive/pkcs11-helper-${PKCS11_HELPER_VERSIO=
N}.tar.gz</a>&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wget -c -P download-cache/ &quot;<a hre=
f=3D"https://www.openssl.org/source/old/1.1.1/openssl-$%7BOPENSSL_VERSION%7=
D.tar.gz" rel=3D"noreferrer" target=3D"_blank">https://www.openssl.org/sour=
ce/old/1.1.1/openssl-${OPENSSL_VERSION}.tar.gz</a>&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tar zxf &quot;download-cache/pkcs11-hel=
per-${PKCS11_HELPER_VERSION}.tar.gz&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wget -c -P download-cache/ &quot;<a hre=
f=3D"https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helpe=
r-$%7BPKCS11_HELPER_VERSION%7D/pkcs11-helper-$%7BPKCS11_HELPER_VERSION%7D.t=
ar.bz2" rel=3D"noreferrer" target=3D"_blank">https://github.com/OpenSC/pkcs=
11-helper/releases/download/pkcs11-helper-${PKCS11_HELPER_VERSION}/pkcs11-h=
elper-${PKCS11_HELPER_VERSION}.tar.bz2</a>&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wget -c -P download-cache/ &quot;<a hre=
f=3D"https://www.openssl.org/source/openssl-$%7BOPENSSL_VERSION%7D.tar.gz" =
rel=3D"noreferrer" target=3D"_blank">https://www.openssl.org/source/openssl=
-${OPENSSL_VERSION}.tar.gz</a>&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tar jxf &quot;download-cache/pkcs11-hel=
per-${PKCS11_HELPER_VERSION}.tar.bz2&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tar zxf &quot;download-cache/opens=
sl-${OPENSSL_VERSION}.tar.gz&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tar zxf &quot;download-cache/lzo-$=
{LZO_VERSION}.tar.gz&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unzip download-cache/tap-windows-$=
{TAP_WINDOWS_VERSION}.zip<br>
@@ -67,56 +67,56 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: Configure OpenSSL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: ./Configure --cross-compile-prefix=
=3D${CHOST}- shared ${{ matrix.target }} no-capieng --prefix=3D&quot;${HOME=
}/mingw/opt&quot; --openssldir=3D&quot;${HOME}/mingw/opt&quot; -static-libg=
cc<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./openssl-1.1.1j&quot=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./openssl-${{ env.OPE=
NSSL_VERSION }}&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: Build OpenSSL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: make<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./openssl-1.1.1j/&quo=
t;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./openssl-${{ env.OPE=
NSSL_VERSION }}&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: Install OpenSSL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: make install<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./openssl-1.1.1j/&quo=
t;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./openssl-${{ env.OPE=
NSSL_VERSION }}&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: autoreconf pkcs11-helper<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: autoreconf -iv<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./pkcs11-helper-pkcs1=
1-helper-1.26&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./pkcs11-helper-${{ e=
nv.PKCS11_HELPER_VERSION }}&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: configure pkcs11-helper<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: OPENSSL_LIBS=3D&quot;-L${HOME}/mingw=
/opt/lib -lssl -lcrypto&quot; OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include PK=
G_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig ./configure --host=3D${CHOS=
T} --program-prefix=3D&#39;&#39; --libdir=3D${HOME}/mingw/opt/lib --prefix=
=3D${HOME}/mingw/opt --build=3Dx86_64-pc-linux-gnu --disable-crypto-engine-=
gnutls --disable-crypto-engine-nss --disable-crypto-engine-polarssl --disab=
le-crypto-engine-mbedtls<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./pkcs11-helper-pkcs1=
1-helper-1.26&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./pkcs11-helper-${{ e=
nv.PKCS11_HELPER_VERSION }}&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: build pkcs11-helper<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: make all<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./pkcs11-helper-pkcs1=
1-helper-1.26&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./pkcs11-helper-${{ e=
nv.PKCS11_HELPER_VERSION }}&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: install pkcs11-helper<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: make install<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./pkcs11-helper-pkcs1=
1-helper-1.26&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./pkcs11-helper-${{ e=
nv.PKCS11_HELPER_VERSION }}&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: Configure lzo<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: ./configure --host=3D${CHOST} --prog=
ram-prefix=3D&#39;&#39; --libdir=3D${HOME}/mingw/opt/lib --prefix=3D${HOME}=
/mingw/opt --build=3Dx86_64-pc-linux-gnu<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./lzo-2.10&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./lzo-${{ env.LZO_VER=
SION }}&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: build lzo<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./lzo-2.10&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./lzo-${{ env.LZO_VER=
SION }}&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: make<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: install lzo<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./lzo-2.10&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 working-directory: &quot;./lzo-${{ env.LZO_VER=
SION }}&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: make install<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: copy tap-windows.h header<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: cp ./tap-windows-9.23.3/include/tap-windo=
ws.h ${HOME}/mingw/opt/include/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run: cp ./tap-windows-${TAP_WINDOWS_VERSION}/i=
nclude/tap-windows.h ${HOME}/mingw/opt/include/<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- name: configure OpenVPN<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run: PKG_CONFIG_PATH=3D${HOME}/mingw/opt/=
lib/pkgconfig DCO_SOURCEDIR=3D$(realpath ../ovpn-dco-win) LDFLAGS=3D-L$HOME=
/mingw/opt/lib CFLAGS=3D-I$HOME/mingw/opt/include OPENSSL_LIBS=3D&quot;-L${=
HOME}/opt/lib -lssl -lcrypto&quot; OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/inclu=
de PREFIX=3D$HOME/mingw/opt LZO_CFLAGS=3D-I$HOME/mingw/opt/include LZO_LIBS=
=3D&quot;-L${HOME}/mingw/opt/lib -llzo2&quot; ./configure=C2=A0 --host=3D${=
CHOST} --disable-lz4 --enable-dco<br>
--<br>
2.30.2<br>
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

--00000000000093de0705dd6ba5ec--

