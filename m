MIME-Version: 1.0
In-Reply-To: <412be705-14ff-4f00-93cb-9478487400c7@...515...>
References: <CAFHpkQHK_VtPoEbWzno+z5C67tYfo3fZNi5ibLgaPpXE5-o5Ug@...278...>
	<412be705-14ff-4f00-93cb-9478487400c7@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 21 Nov 2016 16:58:16 +0500
Message-ID: <CAFHpkQF=gXiT309bV8AWkw86fDd3fN0-RpHkH8cqsMWaG744eQ@...278...>
Content-Type: multipart/alternative; boundary=001a1144232e0edb780541ce5f91
Subject: Re: [Openvpn-devel] multi language / unicode installer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1144232e0edb780541ce5f91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-11-21 16:51 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Il 21/11/2016 13:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
>
>> Hello,
>>
>> I see different languages in openvpn.nsi, for example
>>
>> https://github.com/OpenVPN/openvpn-build/blob/master/windows
>> -nsis/openvpn.nsi#L97
>>
>>
>> we roll our own installer using nsis-2.50-unicode, and I'm not sure it
>> is available for Linux.
>> but I guess there might be some interest from community to have
>> multilanguage installer (for, example, even for openvpn-nl).
>>
>> can we switch to "unicode" nsis and start translating openvpn.nsi  ?
>>
>
> I think having proper internationalization (i18n) support would be good to
> have. We will just have to ensure that openvpn-build is capable of handli=
ng
> it. As for NSIS version availability: I have not checked what is the late=
st
> NSIS version available for *NIX, but I suspect it is the same as for
> Windows - we're speaking of a single project, not two separate ones, righ=
t?
>

actually, there're 3 nsis

1) nsis-2.46 from nsis.sf.net (I guess it cames on Linux, no unicode
support)
2) http://www.scratchpaper.com/ (nsis unicode)
3) nsis 3.0 from http://nsis.sf.net (which I haven't seen on Linux)

currently, openvpn-build just uses makensis, but it does not check its
version. if we decide to switch to unicode, it should also perform such
check


>
> Samuli
>

--001a1144232e0edb780541ce5f91
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-11-21 16:51 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a target=3D"_blank" href=3D"mailto:samuli@...515...">samuli@...515...</a>&g=
t;</span>:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><span class=
=3D"gmail-">Il 21/11/2016 13:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD ha scritto:<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote">
Hello,<br>
<br>
I see different languages in openvpn.nsi, for example<br>
<br>
<a target=3D"_blank" rel=3D"noreferrer" href=3D"https://github.com/OpenVPN/=
openvpn-build/blob/master/windows-nsis/openvpn.nsi#L97">https://github.com/=
OpenVPN/ope<wbr>nvpn-build/blob/master/windows<wbr>-nsis/openvpn.nsi#L97</a=
><br>
<br>
<br>
we roll our own installer using nsis-2.50-unicode, and I&#39;m not sure it<=
br>
is available for Linux.<br>
but I guess there might be some interest from community to have<br>
multilanguage installer (for, example, even for openvpn-nl).<br>
<br>
can we switch to &quot;unicode&quot; nsis and start translating openvpn.nsi=
=C2=A0 ?<br>
</blockquote>
<br></span>
I think having proper internationalization (i18n) support would be good to =
have. We will just have to ensure that openvpn-build is capable of handling=
 it. As for NSIS version availability: I have not checked what is the lates=
t NSIS version available for *NIX, but I suspect it is the same as for Wind=
ows - we&#39;re speaking of a single project, not two separate ones, right?=
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br></font></span></bl=
ockquote><div><br></div><div>actually, there&#39;re 3 nsis<br><br></div><di=
v>1) nsis-2.46 from <a href=3D"http://nsis.sf.net">nsis.sf.net</a> (I guess=
 it cames on Linux, no unicode support)<br>2) <a href=3D"http://www.scratch=
paper.com/">http://www.scratchpaper.com/</a> (nsis unicode)<br></div><div>3=
) nsis 3.0 from <a href=3D"http://nsis.sf.net">http://nsis.sf.net</a> (whic=
h I haven&#39;t seen on Linux)<br><br></div><div>currently, openvpn-build j=
ust uses makensis, but it does not check its version. if we decide to switc=
h to unicode, it should also perform such check<br></div><div>=C2=A0</div><=
blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex" class=3D"gmail_quote"><span class=3D"gmail-HOEnZ=
b"><font color=3D"#888888">
<br>
Samuli<br>
</font></span></blockquote></div><br></div></div>

--001a1144232e0edb780541ce5f91--

