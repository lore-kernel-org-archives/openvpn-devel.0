MIME-Version: 1.0
In-Reply-To: <45031966-d411-018a-a1c8-091d2089c484@...515...>
References: <CAFHpkQGN61ikifN6b+ukKuT-xX5o8k2V4WyOJXOx7deQr4VAaQ@...278...>
	<45031966-d411-018a-a1c8-091d2089c484@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 19 Dec 2016 15:01:20 +0500
Message-ID: <CAFHpkQGfYLSeKVYWoyf0qu2FFgVt1Yc=jdGb85qVf1RSWK=1qw@...278...>
Content-Type: multipart/alternative; boundary=047d7bf10b4e645e0205440000f9
Subject: Re: [Openvpn-devel] Google Summer of Code
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

--047d7bf10b4e645e0205440000f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-12-19 14:41 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Hi,
>
> Il 17/12/2016 16:44, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
>
>> Hello,
>>
>> I discussed this earlier with @mattock, however, there are more ideas :)
>>
>> 1) what do you think of participating GSoC in general ?
>>
>
> In general that is probably a good idea. That said, we'd need somebody to
> mentor the student, and that can take quite a lot of time.
>
> OpenVPN itself is probably too much for a student that may have fairly
> limited C programming/networking/cross-platform experience. Our other
> projects might be better candidates for a GSoC student.
>
> 2) there are at least 2 ideas which I wished to be done with GSoC
>>
>> 2a) "import ovpn from URL for network-manager-openvpn" (actually, it is
>> perfect way to deliver config to android/ios/whatever", but linux
>> network-manager is missing that
>>
>
> So one could give an URL to network-manager and it would import the
> configuration? Can network-manager-openvpn import configuration files tod=
ay?
>


it seems, it depends on network-manager version.
on fedora 23 I cannot import files, but on ubuntu I can.

I'll have a deeper look.

from user point of view, it would be nice to import ovpn config from
somewhere. either local file, or url.



>
> I also wonder if this should be a GSoC project for network-manager, not
> OpenVPN...
>

it might be anybody's project.


>
>
>> 2b) "Start before logon" thing for openvpn-gui
>>
>
> Do you mean "Start on logon", as in
>
>   "Automatically run openvpn-gui.exe --connect <config-file> on login"
>

https://github.com/OpenVPN/openvpn-gui/issues/77


>
> Best regards,
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

--047d7bf10b4e645e0205440000f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-12-19 14:41 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a target=3D"_blank" href=3D"mailto:samuli@...515...">samuli@...515...</a>&g=
t;</span>:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">Hi,<span cl=
ass=3D"gmail-"><br>
<br>
Il 17/12/2016 16:44, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote">
Hello,<br>
<br>
I discussed this earlier with @mattock, however, there are more ideas :)<br>
<br>
1) what do you think of participating GSoC in general ?<br>
</blockquote>
<br></span>
In general that is probably a good idea. That said, we&#39;d need somebody =
to mentor the student, and that can take quite a lot of time.<br>
<br>
OpenVPN itself is probably too much for a student that may have fairly limi=
ted C programming/networking/cross-p<wbr>latform experience. Our other proj=
ects might be better candidates for a GSoC student.<span class=3D"gmail-"><=
br>
<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote">
2) there are at least 2 ideas which I wished to be done with GSoC<br>
<br>
2a) &quot;import ovpn from URL for network-manager-openvpn&quot; (actually,=
 it is<br>
perfect way to deliver config to android/ios/whatever&quot;, but linux<br>
network-manager is missing that<br>
</blockquote>
<br></span>
So one could give an URL to network-manager and it would import the configu=
ration? Can network-manager-openvpn import configuration files today?<br></=
blockquote><div><br><br></div><div>it seems, it depends on network-manager =
version.<br></div><div>on fedora 23 I cannot import files, but on ubuntu I =
can.<br><br></div><div>I&#39;ll have a deeper look.<br><br></div><div>from =
user point of view, it would be nice to import ovpn config from somewhere. =
either local file, or url.<br><br></div><div>=C2=A0</div><blockquote style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex" class=3D"gmail_quote">
<br>
I also wonder if this should be a GSoC project for network-manager, not Ope=
nVPN...<span class=3D"gmail-"><br></span></blockquote><div><br></div><div>i=
t might be anybody&#39;s project.<br></div><div>=C2=A0</div><blockquote sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex" class=3D"gmail_quote"><span class=3D"gmail-">
<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote">
<br>
2b) &quot;Start before logon&quot; thing for openvpn-gui<br>
</blockquote>
<br></span>
Do you mean &quot;Start on logon&quot;, as in<br>
<br>
=C2=A0 &quot;Automatically run openvpn-gui.exe --connect &lt;config-file&gt=
; on login&quot;<br></blockquote><div><br><a href=3D"https://github.com/Ope=
nVPN/openvpn-gui/issues/77">https://github.com/OpenVPN/openvpn-gui/issues/7=
7</a><br>=C2=A0</div><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">
<br>
Best regards,<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</font></span></blockquote></div><br></div></div>

--047d7bf10b4e645e0205440000f9--

