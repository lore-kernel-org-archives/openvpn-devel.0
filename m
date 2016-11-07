MIME-Version: 1.0
In-Reply-To: <d76496aa-07f1-0819-35fc-96c9416858a5@...515...>
References: <915ececd-c052-01b7-6051-74b3bc87b5fb@...515...>
	<CAFHpkQHU-AO88yQBuxpV9yWGYAsaMjkPX6_cramD4fHP5PtSBg@...278...>
	<992ac0c7-1938-1f18-3b85-67d39c114c75@...515...>
	<CAFHpkQFD4W=Mk1VMQXvGtJa2RwjOasDxZ7=ibmE9+d2gEHz-_w@...278...>
	<d76496aa-07f1-0819-35fc-96c9416858a5@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 7 Nov 2016 22:16:53 +0500
Message-ID: <CAFHpkQELZELZC+OJF6BtciQEWkbTJcuCQE66PJr=o-ELm8uCKg@...278...>
Content-Type: multipart/alternative; boundary=001a114b2126af27ab0540b9305d
Subject: Re: [Openvpn-devel] Topics for the upcoming (Monday,
 7th Nov 2016) community meeting
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

--001a114b2126af27ab0540b9305d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

the automatic update functionality is definetily missing for windows part.
I'll try chocolatey for that.

2016-11-07 22:11 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Il 07/11/2016 18:56, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
>
>>
>>
>> 2016-11-07 20:50 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
>> <mailto:samuli@...515...>>:
>>
>>     Il 07/11/2016 15:15, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD ha scritto:
>>
>>         Hello,
>>
>>         I used @mattock's powershell scripts
>>
>>         voila :)
>>
>>         https://jk.testkontur.ru/job/openvpn%20connect%20to%20jk-tes
>> t/3/console
>>         <https://jk.testkontur.ru/job/openvpn%20connect%20to%20jk-te
>> st/3/console>
>>
>>         it is strange for few reasons, but it looks very promising. we c=
an
>>         automate a lot of testing in such way.
>>
>>
>>     Nice! At some point I wanted to implement a Powershell-based
>>     "buildslave" that could run in the background on Windows. Several
>>     people could run that "buildslave" to test latest OpenVPN Windows
>>     build against their respective OpenVPN servers.
>>
>>
>> it is not that hard to run jenkins buildslave, we use it in production.
>>
>> https://jk.testkontur.ru/job/openvpn%20connect%20to%20jk-test/4/console
>>
>>
>> it's getting better :)
>>
>
> Yeah, and I'm definitely _not_ adding Jenkins to _our_ mix right now :).
>
> Windows is special in the sense that we don't build OpenVPN on that
> platform. The cross-compile part is being tested on several levels alread=
y,
> so testing the openvpn.exe executable is the more interesting part.
>
> One way to get the latest cross-compiled Windows installers easily into
> the hands of testers would be to setup our own Chocolatey[1] repository a=
nd
> automatically push latest installers there. The said repository could be
> used by the Windows "buildslave" to automatically fetch the latest
> snapshot, install it, and to run connectivity tests using
> openvpn-windows-test powershell scripts, and to report back any failures.
>
> This would also speed up Windows release process, as the installers would
> not really need much extra testing. And we would not have to have as many
> unused release tags (e.g. 2.4_alpha1) because something got fixed after
> tagging but before release.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
> [1] Essentially "apt-get/yum/dnf for Windows":
>
>     <https://chocolatey.org/>
>
>

--001a114b2126af27ab0540b9305d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>the automatic update functionality is definetily miss=
ing for windows part.<br></div>I&#39;ll try chocolatey for that.<br></div><=
div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-11-07 22:11 G=
MT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a href=3D"mailto:samul=
i@...515..." target=3D"_blank">samuli@...515...</a>&gt;</span>:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><span class=3D"">Il 07/11/2016 18:56, =D0=98=D0=BB=
=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD ha scritto:<br>
</span><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><span class=3D"">
<br>
<br>
2016-11-07 20:50 GMT+05:00 Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:samul=
i@...515..." target=3D"_blank">samuli@...515...</a><br></span>
&lt;mailto:<a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...493...=
515...</a>&gt;&gt;:<span class=3D""><br>
<br>
=C2=A0 =C2=A0 Il 07/11/2016 15:15, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD ha scritto:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Hello,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 I used @mattock&#39;s powershell scripts<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 voila :)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://jk.testkontur.ru/job/openvpn=
%20connect%20to%20jk-test/3/console" rel=3D"noreferrer" target=3D"_blank">h=
ttps://jk.testkontur.ru/job/o<wbr>penvpn%20connect%20to%20jk-tes<wbr>t/3/co=
nsole</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"https://jk.testkontur.ru/job/ope=
nvpn%20connect%20to%20jk-test/3/console" rel=3D"noreferrer" target=3D"_blan=
k">https://jk.testkontur.ru/job/<wbr>openvpn%20connect%20to%20jk-te<wbr>st/=
3/console</a>&gt;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 it is strange for few reasons, but it looks ver=
y promising. we can<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 automate a lot of testing in such way.<br>
<br>
<br>
=C2=A0 =C2=A0 Nice! At some point I wanted to implement a Powershell-based<=
br>
=C2=A0 =C2=A0 &quot;buildslave&quot; that could run in the background on Wi=
ndows. Several<br>
=C2=A0 =C2=A0 people could run that &quot;buildslave&quot; to test latest O=
penVPN Windows<br>
=C2=A0 =C2=A0 build against their respective OpenVPN servers.<br>
<br>
<br>
it is not that hard to run jenkins buildslave, we use it in production.<br>
<br>
<a href=3D"https://jk.testkontur.ru/job/openvpn%20connect%20to%20jk-test/4/=
console" rel=3D"noreferrer" target=3D"_blank">https://jk.testkontur.ru/job/=
o<wbr>penvpn%20connect%20to%20jk-tes<wbr>t/4/console</a><br>
<br>
<br>
it&#39;s getting better :)<br>
</span></blockquote>
<br>
Yeah, and I&#39;m definitely _not_ adding Jenkins to _our_ mix right now :)=
.<br>
<br>
Windows is special in the sense that we don&#39;t build OpenVPN on that pla=
tform. The cross-compile part is being tested on several levels already, so=
 testing the openvpn.exe executable is the more interesting part.<br>
<br>
One way to get the latest cross-compiled Windows installers easily into the=
 hands of testers would be to setup our own Chocolatey[1] repository and au=
tomatically push latest installers there. The said repository could be used=
 by the Windows &quot;buildslave&quot; to automatically fetch the latest sn=
apshot, install it, and to run connectivity tests using openvpn-windows-tes=
t powershell scripts, and to report back any failures.<br>
<br>
This would also speed up Windows release process, as the installers would n=
ot really need much extra testing. And we would not have to have as many un=
used release tags (e.g. 2.4_alpha1) because something got fixed after taggi=
ng but before release.<span class=3D""><br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
<br>
<br></span>
[1] Essentially &quot;apt-get/yum/dnf for Windows&quot;:<br>
<br>
=C2=A0 =C2=A0 &lt;<a href=3D"https://chocolatey.org/" rel=3D"noreferrer" ta=
rget=3D"_blank">https://chocolatey.org/</a>&gt;<br>
<br>
</blockquote></div><br></div>

--001a114b2126af27ab0540b9305d--

