MIME-Version: 1.0
In-Reply-To: <CAFHpkQFVWH3HEObgUp0qVU7WGvsoiucqnD4bix_uxzB3LR7Bbg@...278...>
References: <20180114140627.25331-1-chipitsine@...277...>
 <cdf688fd-a19f-a045-ecf3-e770031c6516@...1856...>
 <CAFHpkQFVWH3HEObgUp0qVU7WGvsoiucqnD4bix_uxzB3LR7Bbg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 15 Jan 2018 13:07:11 +0500
Message-ID: <CAFHpkQHrfgZez38s1aMWUVbYWbgv-JbYuLXvYv2gGoqkevrALA@...278...>
Content-Type: multipart/alternative; boundary="94eb2c058654f706710562cc19d9"
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

--94eb2c058654f706710562cc19d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've built an installer without "no-multilib" and tested on both x86 and
x64.

2018-01-14 23:33 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>:

>
>
> 2018-01-14 21:05 GMT+05:00 Steffan Karger <steffan@...1856...>:
>
>> Hi,
>>
>> On 14-01-18 15:06, Ilya Shipitsin wrote:
>> > no-multilib is only supported on openssl-1.0.X, do not use it
>> > if OPENSSL_VERSION is 1.1.0
>> >
>> > Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
>> > ---
>> >  .travis/build-deps.sh | 5 +++--
>> >  1 file changed, 3 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
>> > index bc538853..1761932e 100755
>> > --- a/.travis/build-deps.sh
>> > +++ b/.travis/build-deps.sh
>> > @@ -110,8 +110,9 @@ build_openssl_mingw () {
>> >              export TARGET=3Dmingw64
>> >          fi
>> >
>> > -        ./Configure --cross-compile-prefix=3D${CHOST}- shared \
>> > -           ${TARGET} no-multilib no-capieng --prefix=3D"${PREFIX}"
>> --openssldir=3D"${PREFIX}" -static-libgcc
>> > +        ./Configure --cross-compile-prefix=3D${CHOST}- shared ${TARGE=
T}
>> \
>> > +           $([[ ${OPENSSL_VERSION} =3D=3D "1.0."* ]] && echo
>> "no-multilib") \
>> > +           no-capieng --prefix=3D"${PREFIX}" --openssldir=3D"${PREFIX=
}"
>> -static-libgcc
>> >          make install
>> >      )
>> >  }
>> >
>>
>> Do we need no-multilib for 1.0.x builds?  If not, I'd prefer to just get
>> rid of it.
>>
>
> it came from windows installer.
> let me build windows installer without no-multilib and test
>
>
>
>>
>> -Steffan
>>
>> ------------------------------------------------------------
>> ------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>
>

--94eb2c058654f706710562cc19d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;ve built an installer without &quot;no-multilib&quot=
; and tested on both x86 and x64.<br></div><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">2018-01-14 23:33 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=
=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:chipitsine@...277..." target=3D"_blank">chipitsine@...277...</a=
>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><br><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote"><div><div class=3D"h5">=
2018-01-14 21:05 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=3D"=
mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;</sp=
an>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span><br>
On 14-01-18 15:06, Ilya Shipitsin wrote:<br>
&gt; no-multilib is only supported on openssl-1.0.X, do not use it<br>
&gt; if OPENSSL_VERSION is 1.1.0<br>
&gt;<br>
&gt; Signed-off-by: Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...1354...=
.." target=3D"_blank">chipitsine@...277...</a>&gt;<br>
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
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ./Configure --cross-compile-prefix=3D${CH=
OST<wbr>}- shared \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0${TARGET} no-multilib no-cap=
ieng --prefix=3D&quot;${PREFIX}&quot; --openssldir=3D&quot;${PREFIX}&quot; =
-static-libgcc<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ./Configure --cross-compile-prefix=3D${CH=
OST<wbr>}- shared ${TARGET} \<br>
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
rid of it.<br></blockquote><div><br></div></div></div><div>it came from win=
dows installer.</div><div>let me build windows installer without no-multili=
b and test<br></div><span class=3D""><div><br></div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
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
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@...1483...<wbr>e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></span></div><br></div></div>
</blockquote></div><br></div>

--94eb2c058654f706710562cc19d9--

