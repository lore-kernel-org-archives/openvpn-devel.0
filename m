MIME-Version: 1.0
In-Reply-To: <20180104121956.13358-1-chipitsine@...277...>
References: <20180104121956.13358-1-chipitsine@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 4 Jan 2018 18:44:45 +0500
Message-ID: <CAFHpkQGmWboR_6eySqswCH68_U3wFKZKwZY+Rk1BYAGFgRTvLQ@...278...>
Content-Type: multipart/alternative; boundary="94eb2c030a10eaf77a0561f38842"
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: speedup osx build by
 enabling brew cache
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--94eb2c030a10eaf77a0561f38842
Content-Type: text/plain; charset="UTF-8"

wait a bit,

we might need to remove ccache (it became broken after travis-ci upgraded
to clang-5)

https://travis-ci.org/chipitsine/openvpn/jobs/325002858

2018-01-04 17:19 GMT+05:00 Ilya Shipitsin <chipitsine@...277...>:

> 1-2 minutes speedup by using brew cache, also ccache
> is no more disabled for osx build (even it does not
> speedup significantly, it simplifies the overall script)
>
> ---
> this is a "v2" of previously issued "enable ccache for osx and mingw
> builds"
> patch. I decided not to enable ccache for mingw builds as it does not
> speedup them
>
>  .travis.yml           | 5 +++--
>  .travis/build-deps.sh | 7 ++-----
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 1f669b30..34e0ac04 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -82,10 +82,11 @@ cache:
>    directories:
>    - download-cache
>    - ${HOME}/opt
> +  - ${HOME}/Library/Caches/Homebrew
>
>  before_install:
> -  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew update     ; fi
> -  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew install lzo; fi
> +  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew update            ; fi
> +  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew install lzo ccache; fi
>
>  install:
>    - if [ ! -z "${CHOST}" ]; then unset CC; fi
> diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
> index e787abab..e7036b6b 100755
> --- a/.travis/build-deps.sh
> +++ b/.travis/build-deps.sh
> @@ -130,11 +130,8 @@ build_openssl () {
>      fi
>  }
>
> -# Enable ccache
> -if [ "${TRAVIS_OS_NAME}" != "osx" ] && [ -z ${CHOST+x} ]; then
> -    # ccache not available on osx, see:
> -    # https://github.com/travis-ci/travis-ci/issues/5567
> -    # also ccache not enabled for cross builds
> +# Enable ccache except cross builds
> +if [ -z ${CHOST+x} ]; then
>      mkdir -p "${HOME}/bin"
>      ln -s "$(which ccache)" "${HOME}/bin/${CC}"
>      PATH="${HOME}/bin:${PATH}"
> --
> 2.14.3
>
>

--94eb2c030a10eaf77a0561f38842
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>wait a bit,<br><br></div>we might need to remove ccac=
he (it became broken after travis-ci upgraded to clang-5)<br><br><a href=3D=
"https://travis-ci.org/chipitsine/openvpn/jobs/325002858">https://travis-ci=
.org/chipitsine/openvpn/jobs/325002858</a><br></div><div class=3D"gmail_ext=
ra"><br><div class=3D"gmail_quote">2018-01-04 17:19 GMT+05:00 Ilya Shipitsi=
n <span dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_=
blank">chipitsine@...277...</a>&gt;</span>:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">1-2 minutes speedup by using brew cache, also ccache<br>
is no more disabled for osx build (even it does not<br>
speedup significantly, it simplifies the overall script)<br>
<br>
---<br>
this is a &quot;v2&quot; of previously issued &quot;enable ccache for osx a=
nd mingw builds&quot;<br>
patch. I decided not to enable ccache for mingw builds as it does not<br>
speedup them<br>
<br>
=C2=A0.travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 5 +++--<br>
=C2=A0.travis/build-deps.sh | 7 ++-----<br>
=C2=A02 files changed, 5 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/.travis.yml b/.travis.yml<br>
index 1f669b30..34e0ac04 100644<br>
--- a/.travis.yml<br>
+++ b/.travis.yml<br>
@@ -82,10 +82,11 @@ cache:<br>
=C2=A0 =C2=A0directories:<br>
=C2=A0 =C2=A0- download-cache<br>
=C2=A0 =C2=A0- ${HOME}/opt<br>
+=C2=A0 - ${HOME}/Library/Caches/<wbr>Homebrew<br>
<br>
=C2=A0before_install:<br>
-=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot; ]; then br=
ew update=C2=A0 =C2=A0 =C2=A0; fi<br>
-=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot; ]; then br=
ew install lzo; fi<br>
+=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot; ]; then br=
ew update=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ; fi<br>
+=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot; ]; then br=
ew install lzo ccache; fi<br>
<br>
=C2=A0install:<br>
=C2=A0 =C2=A0- if [ ! -z &quot;${CHOST}&quot; ]; then unset CC; fi<br>
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh<br>
index e787abab..e7036b6b 100755<br>
--- a/.travis/build-deps.sh<br>
+++ b/.travis/build-deps.sh<br>
@@ -130,11 +130,8 @@ build_openssl () {<br>
=C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0}<br>
<br>
-# Enable ccache<br>
-if [ &quot;${TRAVIS_OS_NAME}&quot; !=3D &quot;osx&quot; ] &amp;&amp; [ -z =
${CHOST+x} ]; then<br>
-=C2=A0 =C2=A0 # ccache not available on osx, see:<br>
-=C2=A0 =C2=A0 # <a href=3D"https://github.com/travis-ci/travis-ci/issues/5=
567" rel=3D"noreferrer" target=3D"_blank">https://github.com/travis-ci/<wbr=
>travis-ci/issues/5567</a><br>
-=C2=A0 =C2=A0 # also ccache not enabled for cross builds<br>
+# Enable ccache except cross builds<br>
+if [ -z ${CHOST+x} ]; then<br>
=C2=A0 =C2=A0 =C2=A0mkdir -p &quot;${HOME}/bin&quot;<br>
=C2=A0 =C2=A0 =C2=A0ln -s &quot;$(which ccache)&quot; &quot;${HOME}/bin/${C=
C}&quot;<br>
=C2=A0 =C2=A0 =C2=A0PATH=3D&quot;${HOME}/bin:${PATH}&quot;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.14.3<br>
<br>
</font></span></blockquote></div><br></div>

--94eb2c030a10eaf77a0561f38842--

