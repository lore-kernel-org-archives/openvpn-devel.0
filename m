MIME-Version: 1.0
In-Reply-To: <cdf688fd-a19f-a045-ecf3-e770031c6516@...1856...>
References: <20180114140627.25331-1-chipitsine@...277...>
 <cdf688fd-a19f-a045-ecf3-e770031c6516@...1856...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 14 Jan 2018 23:33:36 +0500
Message-ID: <CAFHpkQFVWH3HEObgUp0qVU7WGvsoiucqnD4bix_uxzB3LR7Bbg@...278...>
Content-Type: multipart/alternative; boundary="001a1144a2b45e0c160562c0bc68"
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: modify openssl build script
 to support openssl-1.1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--001a1144a2b45e0c160562c0bc68
Content-Type: text/plain; charset="UTF-8"

2018-01-14 21:05 GMT+05:00 Steffan Karger <steffan@...1856...>:

> Hi,
>
> On 14-01-18 15:06, Ilya Shipitsin wrote:
> > no-multilib is only supported on openssl-1.0.X, do not use it
> > if OPENSSL_VERSION is 1.1.0
> >
> > Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> > ---
> >  .travis/build-deps.sh | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
> > index bc538853..1761932e 100755
> > --- a/.travis/build-deps.sh
> > +++ b/.travis/build-deps.sh
> > @@ -110,8 +110,9 @@ build_openssl_mingw () {
> >              export TARGET=mingw64
> >          fi
> >
> > -        ./Configure --cross-compile-prefix=${CHOST}- shared \
> > -           ${TARGET} no-multilib no-capieng --prefix="${PREFIX}"
> --openssldir="${PREFIX}" -static-libgcc
> > +        ./Configure --cross-compile-prefix=${CHOST}- shared ${TARGET} \
> > +           $([[ ${OPENSSL_VERSION} == "1.0."* ]] && echo "no-multilib")
> \
> > +           no-capieng --prefix="${PREFIX}" --openssldir="${PREFIX}"
> -static-libgcc
> >          make install
> >      )
> >  }
> >
>
> Do we need no-multilib for 1.0.x builds?  If not, I'd prefer to just get
> rid of it.
>

it came from windows installer.
let me build windows installer without no-multilib and test



>
> -Steffan
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

--001a1144a2b45e0c160562c0bc68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2018-01-14 21:05 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On 14-01-18 15:06, Ilya Shipitsin wrote:<br>
&gt; no-multilib is only supported on openssl-1.0.X, do not use it<br>
&gt; if OPENSSL_VERSION is 1.1.0<br>
&gt;<br>
&gt; Signed-off-by: Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...1354...=
..">chipitsine@...277...</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .travis/build-deps.sh | 5 +++--<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh<br>
&gt; index bc538853..1761932e 100755<br>
&gt; --- a/.travis/build-deps.sh<br>
&gt; +++ b/.travis/build-deps.sh<br>
&gt; @@ -110,8 +110,9 @@ build_openssl_mingw () {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export TARGET=3Dmingw6=
4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ./Configure --cross-compile-prefix=3D${<w=
br>CHOST}- shared \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0${TARGET} no-multilib no-cap=
ieng --prefix=3D&quot;${PREFIX}&quot; --openssldir=3D&quot;${PREFIX}&quot; =
-static-libgcc<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ./Configure --cross-compile-prefix=3D${<w=
br>CHOST}- shared ${TARGET} \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$([[ ${OPENSSL_VERSION} =3D=
=3D &quot;1.0.&quot;* ]] &amp;&amp; echo &quot;no-multilib&quot;) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0no-capieng --prefix=3D&quot;=
${PREFIX}&quot; --openssldir=3D&quot;${PREFIX}&quot; -static-libgcc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 make install<br>
&gt;=C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 }<br>
&gt;<br>
<br>
</span>Do we need no-multilib for 1.0.x builds?=C2=A0 If not, I&#39;d prefe=
r to just get<br>
rid of it.<br></blockquote><div><br></div><div>it came from windows install=
er.</div><div>let me build windows installer without no-multilib and test<b=
r></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
-Steffan<br>
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
</blockquote></div><br></div></div>

--001a1144a2b45e0c160562c0bc68--

