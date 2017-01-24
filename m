MIME-Version: 1.0
In-Reply-To: <1484035447-11838-1-git-send-email-chipitsine@...277...>
References: <1484035447-11838-1-git-send-email-chipitsine@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 24 Jan 2017 21:49:15 +0500
Message-ID: <CAFHpkQEodBc53dfLAvA7aBXXwY4m+pGzhrM+LCSPh5JJjK2bCw@...278...>
Content-Type: multipart/alternative; boundary=f403045f164e87c57d0546d9e599
Subject: Re: [Openvpn-devel] [PATCH] Resolving several travis-ci issues:
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--f403045f164e87c57d0546d9e599
Content-Type: text/plain; charset=UTF-8

can we apply it ? seems nobody minds

2017-01-10 13:04 GMT+05:00 Ilya Shipitsin <chipitsine@...277...>:

> * moving LD_LIBRARY_PATH as far as possible (otherwise "wget" picks it,
> which is not desirable)
> * split LD_LIBRARY_PATH into LD_LIBRARY_PATH/DYLD_LIBRARY_PATH depending
> on operating system
> * removed MBEDTLS_VERSION, OPENSSL_VERSION (the last depended on
> nonexistent OPENSSL_VERION variable)
> * removed "apt: true" from caching, it never worked actually
>
> this patch should be applied after https://www.mail-archive.com/
> openvpn-devel@lists.sourceforge.net/msg13843.html
> ---
>  .travis.yml           | 4 ++--
>  .travis/build-deps.sh | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 369db97..b8ec1ac 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -18,7 +18,6 @@ env:
>      - OPENSSL_VERSION="1.0.1t"
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

--f403045f164e87c57d0546d9e599
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">can we apply it ? seems nobody minds<br></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">2017-01-10 13:04 GMT+05:00 =
Ilya Shipitsin <span dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277...=
" target=3D"_blank">chipitsine@...277...</a>&gt;</span>:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">* moving LD_LIBRARY_PATH as far as possible (otherwise &quo=
t;wget&quot; picks it, which is not desirable)<br>
* split LD_LIBRARY_PATH into LD_LIBRARY_PATH/DYLD_LIBRARY_<wbr>PATH dependi=
ng on operating system<br>
* removed MBEDTLS_VERSION, OPENSSL_VERSION (the last depended on nonexisten=
t OPENSSL_VERION variable)<br>
* removed &quot;apt: true&quot; from caching, it never worked actually<br>
<br>
this patch should be applied after <a href=3D"https://www.mail-archive.com/=
openvpn-devel@lists.sourceforge.net/msg13843.html" rel=3D"noreferrer" targe=
t=3D"_blank">https://www.mail-archive.com/<wbr>openvpn-devel@...1199...<wbr=
>sourceforge.net/msg13843.html</a><br>
---<br>
=C2=A0.travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++--<br>
=C2=A0.travis/build-deps.sh | 2 --<br>
=C2=A02 files changed, 2 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/.travis.yml b/.travis.yml<br>
index 369db97..b8ec1ac 100644<br>
--- a/.travis.yml<br>
+++ b/.travis.yml<br>
@@ -18,7 +18,6 @@ env:<br>
=C2=A0 =C2=A0 =C2=A0- OPENSSL_VERSION=3D&quot;1.0.1t&quot;<br>
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
@@ -77,6 +75,8 @@ install:<br>
=C2=A0 =C2=A0- .travis/build-deps.sh &gt; build-deps.log 2&gt;&amp;1 || (ca=
t build-deps.log &amp;&amp; exit 1)<br>
<br>
=C2=A0script:<br>
+=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;linux&quot; ]; then =
export LD_LIBRARY_PATH=3D&quot;${PREFIX}/<wbr>lib:${LD_LIBRARY_PATH}&quot;;=
 fi<br>
+=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot;=C2=A0 =C2=
=A0]; then export DYLD_LIBRARY_PATH=3D&quot;${PREFIX}/<wbr>lib:${LD_LIBRARY=
_PATH}&quot;; fi<br>
=C2=A0 =C2=A0- autoreconf -vi<br>
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
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.5.5<br>
<br>
</font></span></blockquote></div><br></div>

--f403045f164e87c57d0546d9e599--

