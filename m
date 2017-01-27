MIME-Version: 1.0
References: <1485525193-5808-1-git-send-email-chipitsine@...277...>
In-Reply-To: <1485525193-5808-1-git-send-email-chipitsine@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 27 Jan 2017 14:22:23 +0000
Message-ID: <CAFHpkQHVfvg3crByYsyy9PC35Agy2KjnTnnBdcKhNDxi52OeYA@...278...>
Content-Type: multipart/alternative; boundary=001a1148e7c26532160547143213
Subject: Re: [Openvpn-devel] [PATCH] Resolve several travis-ci issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a1148e7c26532160547143213
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

please, ignore it.
I will send v2 soon

=D0=9F=D1=82, 27 =D1=8F=D0=BD=D0=B2. 2017 =D0=B3. =D0=B2 18:53, Ilya Shipit=
sin <chipitsine@...277...>:

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
> ---
>  .travis.yml           | 3 +--
>  .travis/build-deps.sh | 2 --
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 369db97..f3727fa 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -18,7 +18,6 @@ env:
>      - OPENSSL_VERSION=3D"1.0.1t"
>      - OPENSSL_CFLAGS=3D"-I${PREFIX}/include"
>      - OPENSSL_LIBS=3D"-L${PREFIX}/lib -lssl -lcrypto"
> -    - LD_LIBRARY_PATH=3D"${PREFIX}/lib:${LD_LIBRARY_PATH}"
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
> @@ -77,6 +75,7 @@ install:
>    - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log &&
> exit 1)
>
>  script:
> +  - export LD_LIBRARY_PATH=3D"${PREFIX}/lib:${LD_LIBRARY_PATH}"
>    - autoreconf -vi
>    - ./configure --with-crypto-library=3D"${SSLLIB}" ${EXTRA_CONFIG} || (=
cat
> config.log && exit 1)
>    - make -j$JOBS
> diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
> index bda54ee..3ffba0b 100755
> --- a/.travis/build-deps.sh
> +++ b/.travis/build-deps.sh
> @@ -2,8 +2,6 @@
>  set -eux
>
>  # Set defaults
> -MBEDTLS_VERSION=3D"${MBEDTLS_VERSION:-2.2.1}"
> -OPENSSL_VERSION=3D"${OPENSSL_VERION:-1.0.2h}"
>  PREFIX=3D"${PREFIX:-${HOME}/opt}"
>
>  download_mbedtls () {
> --
> 2.5.5
>
>

--001a1148e7c26532160547143213
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div>please, ignore it.</div><div>I will send v2 soon</div><div><br><div cl=
ass=3D"gmail_quote"><div>=D0=9F=D1=82, 27 =D1=8F=D0=BD=D0=B2. 2017 =D0=B3. =
=D0=B2 18:53, Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...277...">ch=
ipitsine@...277...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">MBEDTLS=
_VERSION, OPENSSL_VERSION were defined twice - in both<br class=3D"gmail_ms=
g">
=C2=A0.travis.yml=C2=A0 and .travis/build-deps.sh files, the last one<br cl=
ass=3D"gmail_msg">
defined OPENSSL_VERSION via nonexistent OPENSSL_VERION<br class=3D"gmail_ms=
g">
variable, which lead us to use openssl-1.0.1 instead of<br class=3D"gmail_m=
sg">
openssl-1.0.2, I removed variable definition from build-deps.sh<br class=3D=
"gmail_msg">
<br class=3D"gmail_msg">
&quot;cache: [ apt: true ]&quot; is not a travis supported option, it was<b=
r class=3D"gmail_msg">
introduced by mistake, I removed it<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
LD_LIBRARY_PATH was defined for the entire test run, it includes<br class=
=3D"gmail_msg">
custom openssl build, which was picked by &quot;wget&quot;, so &quot;wget&q=
uot;<br class=3D"gmail_msg">
could not verify SSL cert at <a href=3D"https://www.openssl.org" rel=3D"nor=
eferrer" class=3D"gmail_msg" target=3D"_blank">https://www.openssl.org</a> =
sometimes.<br class=3D"gmail_msg">
We do not want wget to pick our custom LD_LIBRARY_PATH, so I moved<br class=
=3D"gmail_msg">
that variable to &quot;script&quot; section<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
LD_LIBRARY_PATH was defined for both linux and osx environments,<br class=
=3D"gmail_msg">
for the second DYLD_LIBRARY_PATH must be defined instead<br class=3D"gmail_=
msg">
---<br class=3D"gmail_msg">
=C2=A0.travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 3 +--<br class=
=3D"gmail_msg">
=C2=A0.travis/build-deps.sh | 2 --<br class=3D"gmail_msg">
=C2=A02 files changed, 1 insertion(+), 4 deletions(-)<br class=3D"gmail_msg=
">
<br class=3D"gmail_msg">
diff --git a/.travis.yml b/.travis.yml<br class=3D"gmail_msg">
index 369db97..f3727fa 100644<br class=3D"gmail_msg">
--- a/.travis.yml<br class=3D"gmail_msg">
+++ b/.travis.yml<br class=3D"gmail_msg">
@@ -18,7 +18,6 @@ env:<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0- OPENSSL_VERSION=3D&quot;1.0.1t&quot;<br class=3D"gmai=
l_msg">
=C2=A0 =C2=A0 =C2=A0- OPENSSL_CFLAGS=3D&quot;-I${PREFIX}/include&quot;<br c=
lass=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0- OPENSSL_LIBS=3D&quot;-L${PREFIX}/lib -lssl -lcrypto&q=
uot;<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 - LD_LIBRARY_PATH=3D&quot;${PREFIX}/lib:${LD_LIBRARY_PATH}&q=
uot;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0matrix:<br class=3D"gmail_msg">
=C2=A0 =C2=A0include:<br class=3D"gmail_msg">
@@ -63,7 +62,6 @@ addons:<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0- linux-libc-dev<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0cache:<br class=3D"gmail_msg">
-=C2=A0 apt: true<br class=3D"gmail_msg">
=C2=A0 =C2=A0ccache: true<br class=3D"gmail_msg">
=C2=A0 =C2=A0directories:<br class=3D"gmail_msg">
=C2=A0 =C2=A0- download-cache<br class=3D"gmail_msg">
@@ -77,6 +75,7 @@ install:<br class=3D"gmail_msg">
=C2=A0 =C2=A0- .travis/build-deps.sh &gt; build-deps.log 2&gt;&amp;1 || (ca=
t build-deps.log &amp;&amp; exit 1)<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0script:<br class=3D"gmail_msg">
+=C2=A0 - export LD_LIBRARY_PATH=3D&quot;${PREFIX}/lib:${LD_LIBRARY_PATH}&q=
uot;<br class=3D"gmail_msg">
=C2=A0 =C2=A0- autoreconf -vi<br class=3D"gmail_msg">
=C2=A0 =C2=A0- ./configure --with-crypto-library=3D&quot;${SSLLIB}&quot; ${=
EXTRA_CONFIG} || (cat config.log &amp;&amp; exit 1)<br class=3D"gmail_msg">
=C2=A0 =C2=A0- make -j$JOBS<br class=3D"gmail_msg">
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh<br class=3D"gmai=
l_msg">
index bda54ee..3ffba0b 100755<br class=3D"gmail_msg">
--- a/.travis/build-deps.sh<br class=3D"gmail_msg">
+++ b/.travis/build-deps.sh<br class=3D"gmail_msg">
@@ -2,8 +2,6 @@<br class=3D"gmail_msg">
=C2=A0set -eux<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0# Set defaults<br class=3D"gmail_msg">
-MBEDTLS_VERSION=3D&quot;${MBEDTLS_VERSION:-2.2.1}&quot;<br class=3D"gmail_=
msg">
-OPENSSL_VERSION=3D&quot;${OPENSSL_VERION:-1.0.2h}&quot;<br class=3D"gmail_=
msg">
=C2=A0PREFIX=3D&quot;${PREFIX:-${HOME}/opt}&quot;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0download_mbedtls () {<br class=3D"gmail_msg">
--<br class=3D"gmail_msg">
2.5.5<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
</blockquote></div></div>

--001a1148e7c26532160547143213--

