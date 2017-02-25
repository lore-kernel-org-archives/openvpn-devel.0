MIME-Version: 1.0
In-Reply-To: <1487874133-28780-1-git-send-email-chipitsine@...277...>
References: <1487874133-28780-1-git-send-email-chipitsine@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 25 Feb 2017 14:37:50 +0500
Message-ID: <CAFHpkQFgDC6mKe=VhR+Nh-xfD8imT+1V5pD_RWooqz8Sk1j5Jg@...278...>
Content-Type: multipart/alternative; boundary=f403045f165296e89e0549579916
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: add "make distcheck" to test
	scenario
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--f403045f165296e89e0549579916
Content-Type: text/plain; charset=UTF-8

ack ? nack ?

2017-02-23 23:22 GMT+05:00 Ilya Shipitsin <chipitsine@...277...>:

> in rare cases openvpn is built from tarball, it happens during "installer
> build"
> process. "make distcheck" helps to prevent problems during such builds.
>
> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> ---
>  .travis.yml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index a68374a..6ebfa39 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -79,6 +79,7 @@ script:
>    - if [ "${TRAVIS_OS_NAME}" = "osx"   ]; then export
> DYLD_LIBRARY_PATH="${PREFIX}/lib:${DYLD_LIBRARY_PATH}"; fi
>    - autoreconf -vi
>    - ./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG} ||
> (cat config.log && exit 1)
> +  - make distcheck > build.log 2>&1 || (cat build.log && exit 1)
>    - make -j$JOBS
>    - src/openvpn/openvpn --version || true
>    - if [ "${TRAVIS_OS_NAME}" = "linux" ]; then ldd src/openvpn/openvpn; fi
> --
> 2.5.5
>
>

--f403045f165296e89e0549579916
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ack ? nack ?<br></div><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote">2017-02-23 23:22 GMT+05:00 Ilya Shipitsin <span dir=
=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_blank">chip=
itsine@...277...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">in rare =
cases openvpn is built from tarball, it happens during &quot;installer buil=
d&quot;<br>
process. &quot;make distcheck&quot; helps to prevent problems during such b=
uilds.<br>
<br>
Signed-off-by: Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...277...">c=
hipitsine@...277...</a>&gt;<br>
---<br>
=C2=A0.travis.yml | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/.travis.yml b/.travis.yml<br>
index a68374a..6ebfa39 100644<br>
--- a/.travis.yml<br>
+++ b/.travis.yml<br>
@@ -79,6 +79,7 @@ script:<br>
=C2=A0 =C2=A0- if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot;=C2=A0=
 =C2=A0]; then export DYLD_LIBRARY_PATH=3D&quot;${PREFIX}/<wbr>lib:${DYLD_L=
IBRARY_PATH}&quot;; fi<br>
=C2=A0 =C2=A0- autoreconf -vi<br>
=C2=A0 =C2=A0- ./configure --with-crypto-library=3D&quot;${<wbr>SSLLIB}&quo=
t; ${EXTRA_CONFIG} || (cat config.log &amp;&amp; exit 1)<br>
+=C2=A0 - make distcheck &gt; build.log 2&gt;&amp;1 || (cat build.log &amp;=
&amp; exit 1)<br>
=C2=A0 =C2=A0- make -j$JOBS<br>
=C2=A0 =C2=A0- src/openvpn/openvpn --version || true<br>
=C2=A0 =C2=A0- if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;linux&quot; ]; =
then ldd src/openvpn/openvpn; fi<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.5.5<br>
<br>
</font></span></blockquote></div><br></div>

--f403045f165296e89e0549579916--

