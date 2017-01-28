MIME-Version: 1.0
In-Reply-To: <1485590815-19226-1-git-send-email-chipitsine@...277...>
References: <1485590815-19226-1-git-send-email-chipitsine@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 28 Jan 2017 13:07:22 +0500
Message-ID: <CAFHpkQG7Qk7y6Lt7CTU15b_3bBOkZX8NcjuQyoMH+dDWm_kU8g@...278...>
Content-Type: multipart/alternative; boundary=f403045f1c027ad12805472312e2
Subject: Re: [Openvpn-devel] [PATCH] Resolve several travis-ci issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--f403045f1c027ad12805472312e2
Content-Type: text/plain; charset=UTF-8

this one is final v2 patch

2017-01-28 13:06 GMT+05:00 Ilya Shipitsin <chipitsine@...277...>:

> MBEDTLS_VERSION, OPENSSL_VERSION were defined twice - in both
>  .travis.yml  and .travis/build-deps.sh files, the last one
> defined OPENSSL_VERSION via nonexistent OPENSSL_VERION
> variable, which lead us to use openssl-1.0.1 instead of
> openssl-1.0.2, I removed variable definition from build-deps.sh
>
> "cache: [ apt: true ]" is not a travis supported option, it was
> introduced by mistake, I removed it
>
> LD_LIBRARY_PATH was defined for the entire test run, it includes
> custom openssl build, which was picked by "wget", so "wget"
> could not verify SSL cert at https://www.openssl.org sometimes.
> We do not want wget to pick our custom LD_LIBRARY_PATH, so I moved
> that variable to "script" section
>
> LD_LIBRARY_PATH was defined for both linux and osx environments,
> for the second DYLD_LIBRARY_PATH must be defined instead
>
> v2: Upgrade openssl, mbedtls to the most recent versions
> ---
>  .travis.yml           | 8 ++++----
>  .travis/build-deps.sh | 2 --
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 369db97..9741d6d 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -12,13 +12,12 @@ env:
>    global:
>      - JOBS=3
>      - PREFIX="${HOME}/opt"
> -    - MBEDTLS_VERSION="2.2.1"
> +    - MBEDTLS_VERSION="2.4.0"
>      - MBEDTLS_CFLAGS="-I${PREFIX}/include"
>      - MBEDTLS_LIBS="-L${PREFIX}/lib -lmbedtls -lmbedx509 -lmbedcrypto"
> -    - OPENSSL_VERSION="1.0.1t"
> +    - OPENSSL_VERSION="1.0.2k"
>      - OPENSSL_CFLAGS="-I${PREFIX}/include"
>      - OPENSSL_LIBS="-L${PREFIX}/lib -lssl -lcrypto"
> -    - LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"
>
>  matrix:
>    include:
> @@ -63,7 +62,6 @@ addons:
>        - linux-libc-dev
>
>  cache:
> -  apt: true
>    ccache: true
>    directories:
>    - download-cache
> @@ -77,6 +75,8 @@ install:
>    - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log &&
> exit 1)
>
>  script:
> +  - if [ "${TRAVIS_OS_NAME}" = "linux" ]; then export
> LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"; fi
> +  - if [ "${TRAVIS_OS_NAME}" = "osx"   ]; then export
> DYLD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"; fi
>    - autoreconf -vi
>    - ./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG} ||
> (cat config.log && exit 1)
>    - make -j$JOBS
> diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
> index bda54ee..3ffba0b 100755
> --- a/.travis/build-deps.sh
> +++ b/.travis/build-deps.sh
> @@ -2,8 +2,6 @@
>  set -eux
>
>  # Set defaults
> -MBEDTLS_VERSION="${MBEDTLS_VERSION:-2.2.1}"
> -OPENSSL_VERSION="${OPENSSL_VERION:-1.0.2h}"
>  PREFIX="${PREFIX:-${HOME}/opt}"
>
>  download_mbedtls () {
> --
> 2.5.5
>
>

--f403045f1c027ad12805472312e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">this one is final v2 patch<br></div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">2017-01-28 13:06 GMT+05:00 Ilya Shipits=
in <span dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." target=3D"=
_blank">chipitsine@...277...</a>&gt;</span>:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><span class=3D"">MBEDTLS_VERSION, OPENSSL_VERSION were defined twice - =
in both<br>
=C2=A0.travis.yml=C2=A0 and .travis/build-deps.sh files, the last one<br>
defined OPENSSL_VERSION via nonexistent OPENSSL_VERION<br>
variable, which lead us to use openssl-1.0.1 instead of<br>
openssl-1.0.2, I removed variable definition from build-deps.sh<br>
<br>
&quot;cache: [ apt: true ]&quot; is not a travis supported option, it was<b=
r>
introduced by mistake, I removed it<br>
<br>
LD_LIBRARY_PATH was defined for the entire test run, it includes<br>
custom openssl build, which was picked by &quot;wget&quot;, so &quot;wget&q=
uot;<br>
could not verify SSL cert at <a href=3D"https://www.openssl.org" rel=3D"nor=
eferrer" target=3D"_blank">https://www.openssl.org</a> sometimes.<br>
We do not want wget to pick our custom LD_LIBRARY_PATH, so I moved<br>
that variable to &quot;script&quot; section<br>
<br>
LD_LIBRARY_PATH was defined for both linux and osx environments,<br>
for the second DYLD_LIBRARY_PATH must be defined instead<br>
<br>
v2: Upgrade openssl, mbedtls to the most recent versions<br>
---<br>
</span>=C2=A0.travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 8 ++++--=
--<br>
=C2=A0.travis/build-deps.sh | 2 --<br>
=C2=A02 files changed, 4 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/.travis.yml b/.travis.yml<br>
index 369db97..9741d6d 100644<br>
<span class=3D"">--- a/.travis.yml<br>
+++ b/.travis.yml<br>
@@ -12,13 +12,12 @@ env:<br>
=C2=A0 =C2=A0global:<br>
=C2=A0 =C2=A0 =C2=A0- JOBS=3D3<br>
=C2=A0 =C2=A0 =C2=A0- PREFIX=3D&quot;${HOME}/opt&quot;<br>
-=C2=A0 =C2=A0 - MBEDTLS_VERSION=3D&quot;2.2.1&quot;<br>
+=C2=A0 =C2=A0 - MBEDTLS_VERSION=3D&quot;2.4.0&quot;<br>
=C2=A0 =C2=A0 =C2=A0- MBEDTLS_CFLAGS=3D&quot;-I${PREFIX}/<wbr>include&quot;=
<br>
=C2=A0 =C2=A0 =C2=A0- MBEDTLS_LIBS=3D&quot;-L${PREFIX}/lib -lmbedtls -lmbed=
x509 -lmbedcrypto&quot;<br>
-=C2=A0 =C2=A0 - OPENSSL_VERSION=3D&quot;1.0.1t&quot;<br>
+=C2=A0 =C2=A0 - OPENSSL_VERSION=3D&quot;1.0.2k&quot;<br>
=C2=A0 =C2=A0 =C2=A0- OPENSSL_CFLAGS=3D&quot;-I${PREFIX}/<wbr>include&quot;=
<br>
=C2=A0 =C2=A0 =C2=A0- OPENSSL_LIBS=3D&quot;-L${PREFIX}/lib -lssl -lcrypto&q=
uot;<br>
-=C2=A0 =C2=A0 - LD_LIBRARY_PATH=3D&quot;${PREFIX}/<wbr>lib:${LD_LIBRARY_PA=
TH}&quot;<br>
<br>
=C2=A0matrix:<br>
=C2=A0 =C2=A0include:<br>
@@ -63,7 +62,6 @@ addons:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0- linux-libc-dev<br>
<br>
=C2=A0cache:<br>
-=C2=A0 apt: true<br>
=C2=A0 =C2=A0ccache: true<br>
=C2=A0 =C2=A0directories:<br>
=C2=A0 =C2=A0- download-cache<br>
</span>@@ -77,6 +75,8 @@ install:<br>
<span class=3D"">=C2=A0 =C2=A0- .travis/build-deps.sh &gt; build-deps.log 2=
&gt;&amp;1 || (cat build-deps.log &amp;&amp; exit 1)<br>
<br>
=C2=A0script:<br>
</span>+=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;linux&quot; ]=
; then export LD_LIBRARY_PATH=3D&quot;${PREFIX}/<wbr>lib:${LD_LIBRARY_PATH}=
&quot;; fi<br>
+=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot;=C2=A0 =C2=
=A0]; then export DYLD_LIBRARY_PATH=3D&quot;${PREFIX}/<wbr>lib:${LD_LIBRARY=
_PATH}&quot;; fi<br>
<div class=3D"HOEnZb"><div class=3D"h5">=C2=A0 =C2=A0- autoreconf -vi<br>
=C2=A0 =C2=A0- ./configure --with-crypto-library=3D&quot;${<wbr>SSLLIB}&quo=
t; ${EXTRA_CONFIG} || (cat config.log &amp;&amp; exit 1)<br>
=C2=A0 =C2=A0- make -j$JOBS<br>
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh<br>
index bda54ee..3ffba0b 100755<br>
--- a/.travis/build-deps.sh<br>
+++ b/.travis/build-deps.sh<br>
@@ -2,8 +2,6 @@<br>
=C2=A0set -eux<br>
<br>
=C2=A0# Set defaults<br>
-MBEDTLS_VERSION=3D&quot;${MBEDTLS_<wbr>VERSION:-2.2.1}&quot;<br>
-OPENSSL_VERSION=3D&quot;${OPENSSL_<wbr>VERION:-1.0.2h}&quot;<br>
=C2=A0PREFIX=3D&quot;${PREFIX:-${HOME}/opt}<wbr>&quot;<br>
<br>
=C2=A0download_mbedtls () {<br>
--<br>
2.5.5<br>
<br>
</div></div></blockquote></div><br></div>

--f403045f1c027ad12805472312e2--

