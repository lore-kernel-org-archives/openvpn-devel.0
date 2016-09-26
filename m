MIME-Version: 1.0
In-Reply-To: <8a59c1b0-7bf5-47b8-68ed-ce36e4438c55@...515...>
References: <1474109679-4982-1-git-send-email-chipitsine@...277...>
	<CAA1AbxKesOCWi2gD6D9nOYVFB2ZyNzYnQsP-NNjWbzPGdG6SPg@...278...>
	<CAFHpkQHNbXW293tp3ua9fr5SwvuLgZh+nJKMR_yioUUVm0QUkg@...278...>
	<8a59c1b0-7bf5-47b8-68ed-ce36e4438c55@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 26 Sep 2016 13:26:24 +0500
Message-ID: <CAFHpkQHMJ7onodTWaEaeE+Ve4kOpbB3V99YqKpwfmbNJsq0r5Q@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0849e23addf0053d64e2fc
Subject: Re: [Openvpn-devel] [PATCH] enable "--disable-crypto" build
	configuration
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--94eb2c0849e23addf0053d64e2fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-09-26 12:37 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Il 24/09/2016 09:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
>
>> can we merge it ?
>>
>> 2016-09-17 16:17 GMT+05:00 Steffan Karger <steffan@...1856...
>> <mailto:steffan@...1856...>>:
>>
>>     Hi,
>>
>>     On 17 September 2016 at 12:54, Ilya Shipitsin <chipitsine@...277...
>>     <mailto:chipitsine@...277...>> wrote:
>>     > ---
>>     >  .travis.yml | 4 ----
>>     >  1 file changed, 4 deletions(-)
>>     >
>>     > diff --git a/.travis.yml b/.travis.yml
>>     > index 452c48e..369db97 100644
>>     > --- a/.travis.yml
>>     > +++ b/.travis.yml
>>     > @@ -51,10 +51,6 @@ matrix:
>>     >        os: osx
>>     >        osx_image: xcode7.3
>>     >        compiler: clang
>>     > -  allow_failures:
>>     > -    - env: SSLLIB=3D"openssl" EXTRA_CONFIG=3D"--disable-crypto"
>>     > -      os: linux
>>     > -      compiler: clang
>>     >    exclude:
>>     >      - compiler: gcc
>>     >
>>     > --
>>     > 2.5.5
>>
>>     Thanks.  The patch is good, so ACK.
>>
>>     But the commit messages should describe why this change is needed.  =
In
>>     this case:
>>
>>     Previously, 'make test' failed for --disable-crypto builds.  Since
>>     that is not fixed, we should no longer accept --disable-crypto builds
>>     to fail 'make test' on travis.
>>
>>     Could you please include such descriptions in future patches?
>>
>>     -Steffan
>>
>>
>>
>>
>> ------------------------------------------------------------
>> ------------------
>>
>>
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>>
> All the pieces (ACK, fixed commit message) seem to be present. Maybe it
> would be easiest to fix the commit message just before the push:
>

it would be easiest, but it is not required.
as Steffan Karger wrote "Could you please include such descriptions in
future patches?"


>
> ---
>
> Enable "--disable-crypto" build configuration
>
>
> Previously, 'make test' failed for --disable-crypto builds.  Since
> that is not fixed, we should no longer accept --disable-crypto builds
> to fail 'make test' on travis.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

--94eb2c0849e23addf0053d64e2fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-09-26 12:37 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a target=3D"_blank" href=3D"mailto:samuli@...515...">samuli@...515...</a>&g=
t;</span>:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><span class=
=3D"gmail-">Il 24/09/2016 09:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD ha scritto:<br>
</span><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><span class=3D"gma=
il-">
can we merge it ?<br>
<br>
2016-09-17 16:17 GMT+05:00 Steffan Karger &lt;<a target=3D"_blank" href=3D"=
mailto:steffan@...1856...">steffan@...1856...</a><br></span>
&lt;mailto:<a target=3D"_blank" href=3D"mailto:steffan@...1856...">steffan@=
...1856...</a>&gt;&gt;:<span class=3D"gmail-"><br>
<br>
=C2=A0 =C2=A0 Hi,<br>
<br>
=C2=A0 =C2=A0 On 17 September 2016 at 12:54, Ilya Shipitsin &lt;<a target=
=3D"_blank" href=3D"mailto:chipitsine@...277...">chipitsine@...277...</a><b=
r></span><div><div class=3D"gmail-h5">
=C2=A0 =C2=A0 &lt;mailto:<a target=3D"_blank" href=3D"mailto:chipitsine@...493...=
277...">chipitsine@...277...</a>&gt;&gt; wrote:<br>
=C2=A0 =C2=A0 &gt; ---<br>
=C2=A0 =C2=A0 &gt;=C2=A0 .travis.yml | 4 ----<br>
=C2=A0 =C2=A0 &gt;=C2=A0 1 file changed, 4 deletions(-)<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt; diff --git a/.travis.yml b/.travis.yml<br>
=C2=A0 =C2=A0 &gt; index 452c48e..369db97 100644<br>
=C2=A0 =C2=A0 &gt; --- a/.travis.yml<br>
=C2=A0 =C2=A0 &gt; +++ b/.travis.yml<br>
=C2=A0 =C2=A0 &gt; @@ -51,10 +51,6 @@ matrix:<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 os: osx<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 osx_image: xcode7.3<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 compiler: clang<br>
=C2=A0 =C2=A0 &gt; -=C2=A0 allow_failures:<br>
=C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; EXTRA=
_CONFIG=3D&quot;--disable-crypto<wbr>&quot;<br>
=C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 os: linux<br>
=C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 compiler: clang<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 exclude:<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 - compiler: gcc<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt; --<br>
=C2=A0 =C2=A0 &gt; 2.5.5<br>
<br>
=C2=A0 =C2=A0 Thanks.=C2=A0 The patch is good, so ACK.<br>
<br>
=C2=A0 =C2=A0 But the commit messages should describe why this change is ne=
eded.=C2=A0 In<br>
=C2=A0 =C2=A0 this case:<br>
<br>
=C2=A0 =C2=A0 Previously, &#39;make test&#39; failed for --disable-crypto b=
uilds.=C2=A0 Since<br>
=C2=A0 =C2=A0 that is not fixed, we should no longer accept --disable-crypt=
o builds<br>
=C2=A0 =C2=A0 to fail &#39;make test&#39; on travis.<br>
<br>
=C2=A0 =C2=A0 Could you please include such descriptions in future patches?=
<br>
<br>
=C2=A0 =C2=A0 -Steffan<br>
<br>
<br>
<br>
<br></div></div>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
<br>
<br>
<br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a target=3D"_blank" href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Op=
envpn-devel@...1483...<wbr>e.net</a><br>
<a target=3D"_blank" rel=3D"noreferrer" href=3D"https://lists.sourceforge.n=
et/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/<wbr>lists/l=
istinfo/openvpn-devel</a><br>
<br>
</blockquote>
<br>
All the pieces (ACK, fixed commit message) seem to be present. Maybe it wou=
ld be easiest to fix the commit message just before the push:<br></blockquo=
te><div><br></div><div>it would be easiest, but it is not required. <br>as =
Steffan Karger wrote &quot;Could you please include such descriptions in fu=
ture patches?&quot;<br></div><div>=C2=A0</div><blockquote style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" c=
lass=3D"gmail_quote">
<br>
---<br>
<br>
Enable &quot;--disable-crypto&quot; build configuration<div class=3D"gmail-=
HOEnZb"><div class=3D"gmail-h5"><br>
<br>
Previously, &#39;make test&#39; failed for --disable-crypto builds.=C2=A0 S=
ince<br>
that is not fixed, we should no longer accept --disable-crypto builds<br>
to fail &#39;make test&#39; on travis.<br>
<br></div></div><span class=3D"gmail-HOEnZb"><font color=3D"#888888">
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</font></span></blockquote></div><br></div></div>

--94eb2c0849e23addf0053d64e2fc--

