MIME-Version: 1.0
In-Reply-To: <CAKuzo_iEXGcuf1tt9zQh8dh42C5BX=jNoROXc_=CV-sOsBsW1w@...278...>
References: <CAFHpkQFdwy++P48HOOAeEO8fKr8uc6y-en0z73JtoOMO1c4q7Q@...278...>
	<20161116183502.GK28918@...1296...>
	<CAFHpkQEkvbq1AGSYN-kYqfDjMbUXJhe1gysp4g6s1EOQku6JOQ@...278...>
	<20161116184717.GL28918@...1296...>
	<CAFHpkQHaDiP9Wk49ja3p_Oix=1fAtANzpqmPbT6hLZw6FVqLiw@...278...>
	<CAFHpkQHdgDAELAHwkYysyyGf5_sGFO-bkCuSVY=zwPKz1pLOwQ@...278...>
	<20161121194602.GR28918@...1296...>
	<CAFHpkQEFma=G_K3Y4FN+=vVSEQgyUySrR9HxBa6JejhimQxiNg@...278...>
	<CAFHpkQF7GtEXhaHBm-nRmHzcQ-cpsJt=MZM+h_1N4kORHERKeA@...278...>
	<CAKuzo_iEXGcuf1tt9zQh8dh42C5BX=jNoROXc_=CV-sOsBsW1w@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 25 Nov 2016 19:00:57 +0500
Message-ID: <CAFHpkQFdVasrVF6Km_AnVwZL7QhGy1AAJAEeyiX7yt_Cq7R2Nw@...278...>
Content-Type: multipart/alternative; boundary=001a1144232e21c91e0542208d71
Subject: Re: [Openvpn-devel] launch openvpn-gui at windows startup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1144232e21c91e0542208d71
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-11-25 18:56 GMT+05:00 Selva Nair <selva.nair@...277...>:

>
> On Fri, Nov 25, 2016 at 8:21 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
> wrote:
>
>>
>> I need an advice, what to do next
>>
>> 1) do nothing
>>
>
> What about recreating the HKLM\Software\OpenVPN regkey in full at install?
> Was the consensus to leave it as is?
>
>
>> 2) enable openvpn-gui startup in HKLM
>>
>
> This will make the "launch on startup" toggle in the gui settings dialog
> meaningless.
>


not meaningless.
I think, it makes sense if gui will check both HKLM and HKCU.

but it becomes complicated for gui to "uncheck" HKLM setting


>
>
>> 3) add http://nsis.sourceforge.net/UAC_plug-in to installer
>
>
> This will work only if the user has admin rights and s installing using
> UAC. What if an "admin" is installing for another user?
>
> What about a different approach on this: make launch on startup the
> default in the GUI options -- i.e the first time GUI version 11.x is
> started it will set to autostart for the user. In subsequent version
> updates this will not be changed (to respect user's edits.)
>
> Selva
>
>
>

--001a1144232e21c91e0542208d71
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-11-25 18:56 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"=
mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"g=
mail_extra"><br><div class=3D"gmail_quote"><span class=3D"">On Fri, Nov 25,=
 2016 at 8:21 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." =
target=3D"_blank">chipitsine@...277...</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex"><div><div><div><div><br></div>I need an advice, what to=
 do next<br><br></div>1) do nothing<br></div></div></blockquote><div><br></=
div></span><div>What about recreating the HKLM\Software\OpenVPN regkey in f=
ull at install? Was the consensus to leave it as is?<br>=C2=A0<br></div><sp=
an class=3D""><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div><div></div>2) enable open=
vpn-gui startup in HKLM<br></div></blockquote><div><br></div></span><div>Th=
is will make the &quot;launch on startup&quot; toggle in the gui settings d=
ialog meaningless. <br></div></div></div></div></blockquote><div><br><br></=
div><div>not meaningless.<br></div><div>I think, it makes sense if gui will=
 check both HKLM and HKCU.<br><br></div><div>but it becomes complicated for=
 gui to &quot;uncheck&quot; HKLM setting<br></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div cla=
ss=3D"gmail_quote"><div>=C2=A0<br></div><span class=3D""><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div></div>3) add <a href=3D"http://nsis.sourceforge.net/UAC_=
plug-in" target=3D"_blank">http://nsis.sourceforge.net/UA<wbr>C_plug-in</a>=
 to installer</blockquote><div><br></div></span><div>This will work only if=
 the user has admin rights and s installing using UAC. What if an &quot;adm=
in&quot; is installing for another user?<br><br></div><div>What about a dif=
ferent approach on this: make launch on startup the default in the GUI opti=
ons -- i.e the first time GUI version 11.x is started it will set to autost=
art for the user. In subsequent version updates this will not be changed (t=
o respect user&#39;s edits.)<span class=3D"HOEnZb"><font color=3D"#888888">=
<br><br></font></span></div><span class=3D"HOEnZb"><font color=3D"#888888">=
<div>Selva <br></div></font></span></div><br><br></div></div>
</blockquote></div><br></div></div>

--001a1144232e21c91e0542208d71--

