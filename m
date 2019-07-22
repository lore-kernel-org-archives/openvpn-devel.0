MIME-Version: 1.0
References: <1563442503-11119-1-git-send-email-lstipakov@...277...>
 <CAFHpkQH250X-bd+EOuC9MNn39CqZy=0yCKjHkCEdgOi8QD04iQ@...278...>
 <CAGyAFMXHiAtCDAzVvB59Gto=F7hPS6XCgrtPG4awi71LonLUAQ@...278...>
 <CAFHpkQFuY-KsoiRbXayg+_aLSWv36qjrtAVgnCUarC=KHK6w5A@...278...>
In-Reply-To: <CAFHpkQFuY-KsoiRbXayg+_aLSWv36qjrtAVgnCUarC=KHK6w5A@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 22 Jul 2019 10:14:49 +0300
Message-ID: <CAGyAFMVEi5agnjteq8UORVNhOEWKA3_VzNnjiNGwJoipcMmTVA@...278...>
Content-Type: multipart/alternative; boundary="0000000000005234bd058e3fd507"
Subject: [Openvpn-devel] Fwd:  [PATCH] crypto.c: fix Visual Studio build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>

--0000000000005234bd058e3fd507
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Moving discussion to -devel.

By the way, are you aware that we already perform Visual Studio builds in
appveyor?

https://ci.appveyor.com/project/mattock/openvpn-build/history

Do you think we should have both?

What would be nice to have is to trigger VS build on every commit to
openvpn repo, since openvpn-build is something we run manually.

---------- Forwarded message ---------
L=C3=A4hett=C3=A4j=C3=A4: =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD <chipitsine@...277...>
Date: su 21. hein=C3=A4k. 2019 klo 18.17
Subject: Re: [Openvpn-devel] [PATCH] crypto.c: fix Visual Studio build
To: Lev Stipakov <lstipakov@...277...>




=D1=87=D1=82, 18 =D0=B8=D1=8E=D0=BB. 2019 =D0=B3. =D0=B2 16:26, Lev Stipako=
v <lstipakov@...277...>:

> Hi,
>
> to 18. hein=C3=A4k. 2019 klo 14.15 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD (chipitsine@...277...)
> kirjoitti:
>
>> btw, can you share steps required for Visual Studio builds ?
>>
>
> Just clone
>
> https://github.com/openvpn/openvpn-build
>
> and run
>


I used to think we can run build from 'openvpn/openvpn' repo.
well, openvpn-build is good as well


> c:\Users\lev\Projects\openvpn-build\msvc>set MODE=3DDEPS&& build.bat
> c:\Users\lev\Projects\openvpn-build\msvc>set MODE=3DOPENVPN&& build.bat
>
> It depends on VS2017, maybe it is time to switch to VS2019.
>

travis-ci comes without VS installed. I'll figure out is it legal to
install community edition or not

currently it already caught nasty bug

"rc" was removed by endlocal:
https://github.com/OpenVPN/openvpn-build/pull/152


>
>
>> travis-ci supports windows builds. I would like to add VS to travis-ci
>>
>
> That would be cool.
>
>>
> --
> -Lev
>


--=20
-Lev

--0000000000005234bd058e3fd507
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Moving discussion to -devel.<div><br></div><div>By the way=
, are you aware that we already perform Visual Studio builds in appveyor?</=
div><div><br></div><div><a href=3D"https://ci.appveyor.com/project/mattock/=
openvpn-build/history">https://ci.appveyor.com/project/mattock/openvpn-buil=
d/history</a>=C2=A0</div><div><br></div><div>Do you think we should have bo=
th?</div><div><br></div><div>What would be nice to have is to trigger VS bu=
ild on every commit to openvpn repo, since openvpn-build is something we ru=
n manually.</div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">---------- Forwarded message ---------<br>L=C3=A4hett=C3=A4=
j=C3=A4: <strong class=3D"gmail_sendername" dir=3D"auto">=D0=98=D0=BB=D1=8C=
=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD</strong> <span dir=3D"aut=
o">&lt;<a href=3D"mailto:chipitsine@...277...">chipitsine@...277...</a>&gt;=
</span><br>Date: su 21. hein=C3=A4k. 2019 klo 18.17<br>Subject: Re: [Openvp=
n-devel] [PATCH] crypto.c: fix Visual Studio build<br>To: Lev Stipakov &lt;=
<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt;<br></div=
><br><br><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=87=D1=82, 18 =D0=B8=D1=
=8E=D0=BB. 2019 =D0=B3. =D0=B2 16:26, Lev Stipakov &lt;<a href=3D"mailto:ls=
tipakov@...277..." target=3D"_blank">lstipakov@...277...</a>&gt;:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hi,=
</div><div><br></div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">to 18. hein=C3=A4k. 2019 klo 14.15 =D0=98=D0=BB=D1=8C=D1=8F =D0=
=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD (<a href=3D"mailto:chipitsine@...1664...=
7..." target=3D"_blank">chipitsine@...277...</a>) kirjoitti:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>btw, can=
 you share steps required for Visual Studio builds ?</div></div></blockquot=
e><div><br></div><div>Just clone</div><div><br></div><div><a href=3D"https:=
//github.com/openvpn/openvpn-build" target=3D"_blank">https://github.com/op=
envpn/openvpn-build</a>=C2=A0=C2=A0<br></div><div><br></div><div>and run=C2=
=A0</div></div></div></blockquote><div><br></div><div><br></div><div>I used=
 to think we can run build from &#39;openvpn/openvpn&#39; repo.</div><div>w=
ell, openvpn-build is good as well</div><div><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><=
div><br></div><div>c:\Users\lev\Projects\openvpn-build\msvc&gt;set MODE=3DD=
EPS&amp;&amp; build.bat<br></div><div>c:\Users\lev\Projects\openvpn-build\m=
svc&gt;set MODE=3DOPENVPN&amp;&amp; build.bat<br></div><div><br></div><div>=
It depends on VS2017, maybe it is time to switch to VS2019.</div></div></di=
v></blockquote><div><br></div><div>travis-ci comes without VS installed. I&=
#39;ll figure out is it legal to install community edition or not</div><div=
><br></div><div>currently it already caught nasty bug</div><div><br></div><=
div>&quot;rc&quot; was removed by endlocal: <a href=3D"https://github.com/O=
penVPN/openvpn-build/pull/152" target=3D"_blank">https://github.com/OpenVPN=
/openvpn-build/pull/152</a></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><div>travis-ci supports windows builds. I would like to add VS to travi=
s-ci<br></div></div></blockquote><div><br></div><div>That would be cool.</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D"gmail_qu=
ote"></div></blockquote></div><div><br></div>-- <br><div dir=3D"ltr" class=
=3D"m_1735325662668152614gmail-m_-532235624616307270gmail_signature">-Lev</=
div></div>
</blockquote></div></div>
</div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gma=
il_signature" data-smartmail=3D"gmail_signature">-Lev</div></div></div>

--0000000000005234bd058e3fd507--

