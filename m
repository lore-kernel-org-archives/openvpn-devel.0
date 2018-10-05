MIME-Version: 1.0
References: <20181005123938.25649-1-steffan@...1856...>
In-Reply-To: <20181005123938.25649-1-steffan@...1856...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 5 Oct 2018 17:49:17 +0500
Message-ID: <CAFHpkQEKOeNJGRccLTRTN0UoszmJtypx8=uR8oNq6aXU_gjc=g@...278...>
Content-Type: multipart/alternative; boundary="000000000000c6e9ef05777ab37b"
Subject: Re: [Openvpn-devel] [PATCH] travis: add OpenSSL 1.1 Windows build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000c6e9ef05777ab37b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

openssl versions were aligned to those used in "openvpn-build" repo, i.e.
the same version were used as in installer creation.
not sure why do we want to have big matrix for cross builds.

but I do not mind, the more tests the better :)

=D0=BF=D1=82, 5 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 17:40, Steffan Karg=
er <steffan@...1856...>:

> So we catch both compilation errors against OpenSSL 1.0 and 1.1 on Window=
s.
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  .travis.yml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 216f0a04..ede2aaa6 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -53,7 +53,10 @@ matrix:
>        os: osx
>        osx_image: xcode7.3
>        compiler: clang
> -    - env: SSLLIB=3D"openssl" CHOST=3Dx86_64-w64-mingw32
> +    - env: SSLLIB=3D"openssl" CHOST=3Dx86_64-w64-mingw32
> OPENSSL_VERSION=3D"1.0.1u"
> +      os: linux
> +      compiler: ": Win64 build only"
> +    - env: SSLLIB=3D"openssl" CHOST=3Dx86_64-w64-mingw32
> OPENSSL_VERSION=3D"1.1.0h"
>        os: linux
>        compiler: ": Win64 build only"
>      - env: SSLLIB=3D"openssl" CHOST=3Di686-w64-mingw32
> --
> 2.17.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000c6e9ef05777ab37b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>openssl versions were aligned to those used in &quot;=
openvpn-build&quot; repo, i.e. the same version were used as in installer c=
reation.</div><div>not sure why do we want to have big matrix for cross bui=
lds.</div><div><br></div><div>but I do not mind, the more tests the better =
:)<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">=D0=BF=D1=
=82, 5 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 17:40, Steffan Karger &lt;<a=
 href=3D"mailto:steffan@...1856...">steffan@...1856...</a>&gt;:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">So we catch both compilation errors against Op=
enSSL 1.0 and 1.1 on Windows.<br>
<br>
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan@...1856..." tar=
get=3D"_blank">steffan@...1856...</a>&gt;<br>
---<br>
=C2=A0.travis.yml | 5 ++++-<br>
=C2=A01 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/.travis.yml b/.travis.yml<br>
index 216f0a04..ede2aaa6 100644<br>
--- a/.travis.yml<br>
+++ b/.travis.yml<br>
@@ -53,7 +53,10 @@ matrix:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: osx<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0osx_image: xcode7.3<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: clang<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; CHOST=3Dx86_64-w64-mingw=
32<br>
+=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; CHOST=3Dx86_64-w64-mingw=
32 OPENSSL_VERSION=3D&quot;1.0.1u&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 os: linux<br>
+=C2=A0 =C2=A0 =C2=A0 compiler: &quot;: Win64 build only&quot;<br>
+=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; CHOST=3Dx86_64-w64-mingw=
32 OPENSSL_VERSION=3D&quot;1.1.0h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: &quot;: Win64 build only&quot;<br>
=C2=A0 =C2=A0 =C2=A0- env: SSLLIB=3D&quot;openssl&quot; CHOST=3Di686-w64-mi=
ngw32<br>
-- <br>
2.17.1<br>
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

--000000000000c6e9ef05777ab37b--

