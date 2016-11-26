MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Fri, 25 Nov 2016 23:55:09 -0500
Message-ID: <CAKuzo_ha_dc8401V0bfPtQ7vfE+1sriAcYoOP7y-TB3C-XKwNQ@...278...>
Content-Type: multipart/alternative; boundary=001a114349c23adf7b05422d0c57
Subject: [Openvpn-devel] (no subject)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114349c23adf7b05422d0c57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


On Fri, Nov 25, 2016 at 11:39 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

>
>
> 2016-11-26 0:55 GMT+05:00 Selva Nair <selva.nair@...277...>:
>
>>
>>
>>>
>> I have posted a PR (https://github.com/OpenVPN/openvpn-build/pull/55) us=
ing
>> an active-setup registry entry to do this. It will automatically add the
>> required HKCU entry when the user logs-in. As this happens early in the
>> login process (before startup registry key is evaluated) the GUI will
>> startup even on the first login.
>>
>> Should works also for new users, and the user can change override it
>> using the option in GUI settings menu. Changes to the nsis file is minor
>> too.
>>
>
> good.
>
> except for minor issue with not removing HKCU key on uninstall (however,
> it is not removed without that patch too)
>

Aha, I did not consider that. But that is easily fixed.

During uninstall  instead of removing the active setup key we just have to
set IsInstalled=3D0 and replace StubPath by a command to remove the HKCU reg
entry when user logs in next time after uninstall. The rest will happen
automatically.

I will push a fixup commit.

Selva

--001a114349c23adf7b05422d0c57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br><div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Fri, Nov 25, 2016 at 11:39 PM, =D0=98=D0=BB=D1=8C=D1=8F=
 =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=
=3D"mailto:chipitsine@...277..." target=3D"_blank">chipitsine@...277...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><br><=
div class=3D"gmail_extra"><br><div class=3D"gmail_quote"><span class=3D"">2=
016-11-26 0:55 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"mailto=
:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</span=
>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_e=
xtra"><span></span><br><div class=3D"gmail_quote">
<span><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:s=
olid;padding-left:1ex"><div class=3D"m_-5661616676187722680m_44323443918350=
42275gmail-m_7237335575349074592HOEnZb"><div class=3D"m_-566161667618772268=
0m_4432344391835042275gmail-m_7237335575349074592h5"><br></div></div></bloc=
kquote><div><br></div></span><div>I have posted a PR (<a href=3D"https://gi=
thub.com/OpenVPN/openvpn-build/pull/55" target=3D"_blank">https://github.co=
m/OpenVPN/op<wbr>envpn-build/pull/55</a>)=C2=A0using an active-setup regist=
ry entry to do this. It will automatically add the required HKCU entry when=
 the user logs-in. As this happens early in the login process (before start=
up registry key is evaluated) the GUI will startup even on the first login.=
</div><div><br></div><div>Should works also for new users, and the user can=
 change override it using the option in GUI settings menu. Changes to the n=
sis file is minor too.</div></div></div></div></blockquote><div><br></div><=
/span><div>good.<br><br></div><div>except for minor issue with not removing=
 HKCU key on uninstall (however, it is not removed without that patch too)<=
br></div></div></div></div></blockquote><div>=C2=A0<br></div><div>Aha, I di=
d not consider that. But that is easily fixed. <br><br>During uninstall=C2=
=A0 instead of removing the active setup key we just have to set IsInstalle=
d=3D0 and replace StubPath by a command to remove the HKCU reg entry when u=
ser logs in next time after uninstall. The rest will happen automatically.<=
br><br></div><div>I will push a fixup commit.<br><br></div><div>Selva <br><=
/div></div><br></div></div></div>

--001a114349c23adf7b05422d0c57--

