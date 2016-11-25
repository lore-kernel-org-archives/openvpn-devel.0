MIME-Version: 1.0
In-Reply-To: <CAFHpkQEFma=G_K3Y4FN+=vVSEQgyUySrR9HxBa6JejhimQxiNg@...278...>
References: <CAFHpkQFdwy++P48HOOAeEO8fKr8uc6y-en0z73JtoOMO1c4q7Q@...278...>
	<20161116183502.GK28918@...1296...>
	<CAFHpkQEkvbq1AGSYN-kYqfDjMbUXJhe1gysp4g6s1EOQku6JOQ@...278...>
	<20161116184717.GL28918@...1296...>
	<CAFHpkQHaDiP9Wk49ja3p_Oix=1fAtANzpqmPbT6hLZw6FVqLiw@...278...>
	<CAFHpkQHdgDAELAHwkYysyyGf5_sGFO-bkCuSVY=zwPKz1pLOwQ@...278...>
	<20161121194602.GR28918@...1296...>
	<CAFHpkQEFma=G_K3Y4FN+=vVSEQgyUySrR9HxBa6JejhimQxiNg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 25 Nov 2016 18:21:24 +0500
Message-ID: <CAFHpkQF7GtEXhaHBm-nRmHzcQ-cpsJt=MZM+h_1N4kORHERKeA@...278...>
Content-Type: multipart/alternative; boundary=001a11466fd6bb55a305421fffd0
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

--001a11466fd6bb55a305421fffd0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

I need an advice, what to do next

1) do nothing
2) enable openvpn-gui startup in HKLM
3) add http://nsis.sourceforge.net/UAC_plug-in to installer

?

2016-11-22 0:51 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD <chipitsine@...277...>:

>
>
> 2016-11-22 0:46 GMT+05:00 Gert Doering <gert@...1296...>:
>
>> Hi,
>>
>> On Tue, Nov 22, 2016 at 12:41:24AM +0500, ???????? ?????????????? wrote:
>> > should we also start openvpn-gui if "launch gui on windows startup" is
>> > selected ?
>>
>> I tend to de-couple this - what about a second checkbox "launch gui now"?
>>
>
> I like the approach of starting services:
>
> https://github.com/OpenVPN/openvpn-build/blob/master/
> windows-nsis/openvpn.nsi#L540
>
> if there's a service, ok, start it, why to ask user ?
>
>
> the same with gui. if user selected to launch it automatically, why wait
> for reboot ?
>
>
>>
>> (With both defaulting to [X] checked)
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

--001a11466fd6bb55a305421fffd0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>hello,<br><br></div>I need an advice, =
what to do next<br><br></div>1) do nothing<br></div>2) enable openvpn-gui s=
tartup in HKLM<br></div>3) add <a href=3D"http://nsis.sourceforge.net/UAC_p=
lug-in">http://nsis.sourceforge.net/UAC_plug-in</a> to installer<br><br>?<b=
r></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-11-2=
2 0:51 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=
=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." tar=
get=3D"_blank">chipitsine@...277...</a>&gt;</span>:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote"><span class=3D"">2016-11-22 0:46 GMT+05:00 Gert Doering <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">ge=
rt@...1296...</a>&gt;</span>:<br><blockquote style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail=
_quote">Hi,<br>
<span class=3D"m_-659334250783719831gmail-"><br>
On Tue, Nov 22, 2016 at 12:41:24AM +0500, ???????? ?????????????? wrote:<br>
&gt; should we also start openvpn-gui if &quot;launch gui on windows startu=
p&quot; is<br>
&gt; selected ?<br>
<br>
</span>I tend to de-couple this - what about a second checkbox &quot;launch=
 gui now&quot;?<br></blockquote><div><br></div></span><div>I like the appro=
ach of starting services:<br><br><a href=3D"https://github.com/OpenVPN/open=
vpn-build/blob/master/windows-nsis/openvpn.nsi#L540" target=3D"_blank">http=
s://github.com/OpenVPN/<wbr>openvpn-build/blob/master/<wbr>windows-nsis/ope=
nvpn.nsi#L540</a><br><br></div><div>if there&#39;s a service, ok, start it,=
 why to ask user ?<br><br><br></div><div>the same with gui. if user selecte=
d to launch it automatically, why wait for reboot ?<br></div><span class=3D=
""><div>=C2=A0</div><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">
<br>
(With both defaulting to [X] checked)<br>
<div class=3D"m_-659334250783719831gmail-HOEnZb"><div class=3D"m_-659334250=
783719831gmail-h5"><br>
gert<br>
<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a rel=3D"n=
oreferrer" href=3D"http://www.muc.de/%7Egert/" target=3D"_blank">www.muc.de=
/~gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297..." target=3D"_=
blank">gert@...2194...<wbr>n.de</a><br>
</div></div></blockquote></span></div><br></div></div>
</blockquote></div><br></div>

--001a11466fd6bb55a305421fffd0--

