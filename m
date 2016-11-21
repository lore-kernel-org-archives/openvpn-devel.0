MIME-Version: 1.0
In-Reply-To: <CAFHpkQHaDiP9Wk49ja3p_Oix=1fAtANzpqmPbT6hLZw6FVqLiw@...278...>
References: <CAFHpkQFdwy++P48HOOAeEO8fKr8uc6y-en0z73JtoOMO1c4q7Q@...278...>
	<20161116183502.GK28918@...1296...>
	<CAFHpkQEkvbq1AGSYN-kYqfDjMbUXJhe1gysp4g6s1EOQku6JOQ@...278...>
	<20161116184717.GL28918@...1296...>
	<CAFHpkQHaDiP9Wk49ja3p_Oix=1fAtANzpqmPbT6hLZw6FVqLiw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 22 Nov 2016 00:41:24 +0500
Message-ID: <CAFHpkQHdgDAELAHwkYysyyGf5_sGFO-bkCuSVY=zwPKz1pLOwQ@...278...>
Content-Type: multipart/alternative; boundary=089e0102e3da525ad00541d4d738
Subject: Re: [Openvpn-devel] launch openvpn-gui at windows startup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e0102e3da525ad00541d4d738
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

should we also start openvpn-gui if "launch gui on windows startup" is
selected ?

2016-11-22 0:13 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD <chipitsine@...277...>:

>
>
> 2016-11-16 23:47 GMT+05:00 Gert Doering <gert@...1296...>:
>
>> Hi,
>>
>> On Wed, Nov 16, 2016 at 11:39:04PM +0500, ???????? ?????????????? wrote:
>> > > Samuli, Ilya, any idea how hard this is to do?
>> >
>> > it is trivial.
>>
>> Cool :-)
>>
>
> https://github.com/OpenVPN/openvpn-build/pull/50
>
>
> as for many options, I would simplify installer. i.e. we can install
> openvpn-gui always, the same for easy-rsa. it does not make much sense to
> make user choose between those things. But I would make multi language
> installer first :)
>
> I noticed a bug there https://github.com/OpenVPN/openvpn-build/issues/51
> it is not related to my PR, but I'll try to resolve it tomorrow
>
>
>> > I'm going to finish "x86 + x64" installer. The next thing is "check for
>> > .net 4 if openvpnserv2 is checked" and third maybe "start openvpn-gui =
on
>> > windows logon"
>>
>> Very much looking forward to this - thanks!
>>
>> gert
>>
>> --
>> USENET is *not* the non-clickable part of WWW!
>>                                                            //
>> www.muc.de/~gert/ <http://www.muc.de/%7Egert/>
>> Gert Doering - Munich, Germany
>> gert@...1296...
>> fax: +49-89-35655025
>> gert@...1297...
>>
>
>

--089e0102e3da525ad00541d4d738
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">should we also start openvpn-gui if &quot;launch gui on wi=
ndows startup&quot; is selected ?<br></div><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">2016-11-22 0:13 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=
=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:chipitsine@...277..." target=3D"_blank">chipitsine@...277...</a=
>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><br><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote"><span class=3D"">2016-1=
1-16 23:47 GMT+05:00 Gert Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:g=
ert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span>:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<span class=3D"m_-9120236117343826508gmail-"><br>
On Wed, Nov 16, 2016 at 11:39:04PM +0500, ???????? ?????????????? wrote:<br>
&gt; &gt; Samuli, Ilya, any idea how hard this is to do?<br>
&gt;<br>
&gt; it is trivial.<br>
<br>
</span>Cool :-)<br></blockquote></span><div><br><a href=3D"https://github.c=
om/OpenVPN/openvpn-build/pull/50" target=3D"_blank">https://github.com/Open=
VPN/<wbr>openvpn-build/pull/50</a><br><br><br></div><div>as for many option=
s, I would simplify installer. i.e. we can install openvpn-gui always, the =
same for easy-rsa. it does not make much sense to make user choose between =
those things. But I would make multi language installer first :)<br></div><=
div><br></div><div>I noticed a bug there <a href=3D"https://github.com/Open=
VPN/openvpn-build/issues/51" target=3D"_blank">https://github.com/OpenVPN/<=
wbr>openvpn-build/issues/51</a><br></div><div>it is not related to my PR, b=
ut I&#39;ll try to resolve it tomorrow<br><br> </div><span class=3D""><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<span class=3D"m_-9120236117343826508gmail-"><br>
&gt; I&#39;m going to finish &quot;x86 + x64&quot; installer. The next thin=
g is &quot;check for<br>
&gt; .net 4 if openvpnserv2 is checked&quot; and third maybe &quot;start op=
envpn-gui on<br>
&gt; windows logon&quot;<br>
<br>
</span>Very much looking forward to this - thanks!<br>
<div class=3D"m_-9120236117343826508gmail-HOEnZb"><div class=3D"m_-91202361=
17343826508gmail-h5"><br>
gert<br>
<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/%7Egert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de=
/~gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297..." target=3D"_=
blank">gert@...2194...<wbr>n.de</a><br>
</div></div></blockquote></span></div><br></div></div>
</blockquote></div><br></div>

--089e0102e3da525ad00541d4d738--

