MIME-Version: 1.0
In-Reply-To: <CAFHpkQFdVasrVF6Km_AnVwZL7QhGy1AAJAEeyiX7yt_Cq7R2Nw@...278...>
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
	<CAFHpkQFdVasrVF6Km_AnVwZL7QhGy1AAJAEeyiX7yt_Cq7R2Nw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 25 Nov 2016 09:38:31 -0500
Message-ID: <CAKuzo_h3kza0fftPTOc9vqhy=sSgTuOZXL=qzV3e29yhhpY8mA@...278...>
Content-Type: multipart/alternative; boundary=001a113a3162aacac405422114d6
Subject: Re: [Openvpn-devel] launch openvpn-gui at windows startup
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

--001a113a3162aacac405422114d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 25, 2016 at 9:00 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

>
>>
>>> 2) enable openvpn-gui startup in HKLM
>>>
>>
>> This will make the "launch on startup" toggle in the gui settings dialog
>> meaningless.
>>
>
>
> not meaningless.
> I think, it makes sense if gui will check both HKLM and HKCU.
>
> but it becomes complicated for gui to "uncheck" HKLM setting
>


Even if the GUI cjecks HKLM and HKCU, toggling the option will not work as
the GUI cannot reset HKLM values. We do not want to be requiring admin
rights to run the GUI and that option becomes "readonly" for the user if
startup is set in HKLM.

Selva

--001a113a3162aacac405422114d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Nov 25, 2016 at 9:00 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipits=
ine@...277..." target=3D"_blank">chipitsine@...277...</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><span class=3D""><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quo=
te"><div>=C2=A0<br></div><span><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div></d=
iv>2) enable openvpn-gui startup in HKLM<br></div></blockquote><div><br></d=
iv></span><div>This will make the &quot;launch on startup&quot; toggle in t=
he gui settings dialog meaningless. <br></div></div></div></div></blockquot=
e><div><br><br></div></span><div>not meaningless.<br></div><div>I think, it=
 makes sense if gui will check both HKLM and HKCU.<br><br></div><div>but it=
 becomes complicated for gui to &quot;uncheck&quot; HKLM setting</div></blo=
ckquote></div><br><br></div><div class=3D"gmail_extra">Even if the GUI cjec=
ks HKLM and HKCU, toggling the option will not work as the GUI cannot reset=
 HKLM values. We do not want to be requiring admin rights to run the GUI an=
d that option becomes &quot;readonly&quot; for the user if startup is set i=
n HKLM.<br><br></div><div class=3D"gmail_extra">Selva <br></div></div>

--001a113a3162aacac405422114d6--

