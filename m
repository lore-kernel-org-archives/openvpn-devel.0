MIME-Version: 1.0
In-Reply-To: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 29 Dec 2017 15:11:15 +0500
Message-ID: <CAFHpkQG56wpZzN2KD3BYmcSDFFLi8Jpq0e-ZN-=9yJH4VWybiQ@...278...>
Content-Type: multipart/alternative; boundary="94eb2c05a3b0587e97056177da30"
Subject: Re: [Openvpn-devel] [PATCH] travis: use clang's -fsanitize=address
 to catch more bugs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--94eb2c05a3b0587e97056177da30
Content-Type: text/plain; charset="UTF-8"

thank for the patch.

not directly related to the patch itself, but openvpn is shipped with
several memory debugging options

--with-mem-check=TYPE   build with debug memory checking


should we get rid of them (in favour of sanitizers) ? or, maybe add to
tests instead ?

2017-12-29 14:47 GMT+05:00 Steffan Karger <steffan.karger@...1435...>:

> The clang address sanitizer is able to catch quite a number of
> memory-related bugs, such add memory leaks and buffer under/overruns.
> So, enable the address sanitizer for one openssl and one mbedtls build.
>
> This would have caught the buffer list unittest memory leak that
> <1512724338-22197-1-git-send-email-steffan@...1856...> wants to fix.
>
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  .travis.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 1f669b3..99cd5e2 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -33,7 +33,7 @@ matrix:
>      - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0f"
>        os: linux
>        compiler: gcc
> -    - env: SSLLIB="openssl"
> +    - env: SSLLIB="openssl" CFLAGS="-fsanitize=address"
>        os: linux
>        compiler: clang
>      - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0f"
> @@ -42,7 +42,7 @@ matrix:
>      - env: SSLLIB="mbedtls"
>        os: linux
>        compiler: gcc
> -    - env: SSLLIB="mbedtls"
> +    - env: SSLLIB="mbedtls" CFLAGS="-fsanitize=address"
>        os: linux
>        compiler: clang
>      - env: SSLLIB="openssl"
> --
> 2.7.4
>
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--94eb2c05a3b0587e97056177da30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>thank for the patch.<br><br></div>not directly r=
elated to the patch itself, but openvpn is shipped with several memory debu=
gging options<br><br>--with-mem-check=3DTYPE=C2=A0=C2=A0 build with debug m=
emory checking<br><br><br></div>should we get rid of them (in favour of san=
itizers) ? or, maybe add to tests instead ?<br></div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">2017-12-29 14:47 GMT+05:00 Steffan Karg=
er <span dir=3D"ltr">&lt;<a href=3D"mailto:steffan.karger@...1435..." targe=
t=3D"_blank">steffan.karger@...1435...</a>&gt;</span>:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">The clang address sanitizer is able to catch quite a number o=
f<br>
memory-related bugs, such add memory leaks and buffer under/overruns.<br>
So, enable the address sanitizer for one openssl and one mbedtls build.<br>
<br>
This would have caught the buffer list unittest memory leak that<br>
&lt;<a href=3D"mailto:1512724338-22197-1-git-send-email-steffan@...1856..."=
>1512724338-22197-1-git-send-<wbr>email-steffan@...1856...</a>&gt; wants to=
 fix.<br>
<br>
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan.karger@...2191...=
..">steffan.karger@...1435...</a>&gt;<br>
---<br>
=C2=A0.travis.yml | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/.travis.yml b/.travis.yml<br>
index 1f669b3..99cd5e2 100644<br>
--- a/.travis.yml<br>
+++ b/.travis.yml<br>
@@ -33,7 +33,7 @@ matrix:<br>
=C2=A0 =C2=A0 =C2=A0- env: SSLLIB=3D&quot;openssl&quot; OPENSSL_VERSION=3D&=
quot;1.1.0f&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: gcc<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot;<br>
+=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; CFLAGS=3D&quot;-fsanitiz=
e=3Daddress&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: clang<br>
=C2=A0 =C2=A0 =C2=A0- env: SSLLIB=3D&quot;openssl&quot; OPENSSL_VERSION=3D&=
quot;1.1.0f&quot;<br>
@@ -42,7 +42,7 @@ matrix:<br>
=C2=A0 =C2=A0 =C2=A0- env: SSLLIB=3D&quot;mbedtls&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: gcc<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;mbedtls&quot;<br>
+=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;mbedtls&quot; CFLAGS=3D&quot;-fsanitiz=
e=3Daddress&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: clang<br>
=C2=A0 =C2=A0 =C2=A0- env: SSLLIB=3D&quot;openssl&quot;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.7.4<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</font></span></blockquote></div><br></div>

--94eb2c05a3b0587e97056177da30--

