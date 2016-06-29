MIME-Version: 1.0
In-Reply-To: <224018c8-c3a7-6a7e-0d46-2f44d87b2990@...515...>
References: <CAFHpkQGrube6hF3+hab3NdNhcifjV15ZSefdUWCcXJPg_CApKw@...278...>
	<20160629081109.GU78279@...1296...>
	<CAFHpkQGD10-N=fX6osaMKE4SN+S55A8EN+8byw6aTM9Aosd1Mw@...278...>
	<20160629090025.GV78279@...1296...>
	<51c19384-4814-c63e-f515-ea0f3ce8791e@...515...>
	<CAFHpkQFMs3OsBoV8LP1BZnZpomMFwp6pvw_bx58UrLK20dyF0Q@...278...>
	<224018c8-c3a7-6a7e-0d46-2f44d87b2990@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 29 Jun 2016 15:10:14 +0500
Message-ID: <CAFHpkQEsEj70wZxdXs9fd8W8j3QfuyWBjJAHXvzUGVTPt50_CQ@...278...>
Content-Type: multipart/alternative; boundary=001a11c3af2eb3c39b053667f5f2
Subject: Re: [Openvpn-devel] git master: no more WinXP ?
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

--001a11c3af2eb3c39b053667f5f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

it is almost the same choice like whether to include "run as admin"
manifest or leave it to user.
from security point of view, it makes sense that running anything with
admin privileges might be security issue and user should agree on that.

but I vote for starting interactive service from installer with no question
asked ))

2016-06-29 15:07 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> "Enable and start interactive service during installation" is on my todo.
> I think we can safely enable it, because it will not automatically go out
> starting any VPNs.
>
> Samuli
>
> I had a look at installers (as we enroll our own installer).
>> I've got more questions regarding installers
>>
>> for example, interactive service is installed, but not started. So, user
>> without admin rights cannot just start it.
>> it would be better to either start it from installer or add checkbox
>> there "start service"
>>
>> 2016-06-29 14:11 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
>> <mailto:samuli@...515...>>:
>>
>>
>>         Hi,
>>
>>         On Wed, Jun 29, 2016 at 01:57:14PM +0500, ????????
>>         ?????????????? wrote:
>>
>>             ok, if so, we need to modify installer to detect that.
>>
>>
>>         Right, "master" installers should refuse cooperation on XP.
>>
>>         Samuli, you're listening? ;-)
>>
>>         gert
>>
>>
>>     Yes. Do we still want to bloat "master" installers with tap-windows?
>>
>>     Afaics that would only be useful _if_ somebody is having problems
>>     with tap-windows6 and needs to revert to tap-windows. However, in
>>     that case we'd need checkbox, not automatic tap-driver selection
>>     based on the OS.
>>
>>     Samuli
>>
>>
>>
>
>

--001a11c3af2eb3c39b053667f5f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>it is almost the same choice like whether to inc=
lude &quot;run as admin&quot; manifest or leave it to user.<br></div>from s=
ecurity point of view, it makes sense that running anything with admin priv=
ileges might be security issue and user should agree on that.<br><br></div>=
but I vote for starting interactive service from installer with no question=
 asked ))<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote=
">2016-06-29 15:07 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a =
href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">&quot;Enable and start interacti=
ve service during installation&quot; is on my todo. I think we can safely e=
nable it, because it will not automatically go out starting any VPNs.<br>
<br>
Samuli<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><span class=3D"">
I had a look at installers (as we enroll our own installer).<br>
I&#39;ve got more questions regarding installers<br>
<br>
for example, interactive service is installed, but not started. So, user<br>
without admin rights cannot just start it.<br>
it would be better to either start it from installer or add checkbox<br>
there &quot;start service&quot;<br>
<br>
2016-06-29 14:11 GMT+05:00 Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:samul=
i@...515..." target=3D"_blank">samuli@...515...</a><br></span>
&lt;mailto:<a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...493...=
515...</a>&gt;&gt;:<span class=3D""><br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 On Wed, Jun 29, 2016 at 01:57:14PM +0500, ?????=
???<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ?????????????? wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ok, if so, we need to modify inst=
aller to detect that.<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Right, &quot;master&quot; installers should ref=
use cooperation on XP.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Samuli, you&#39;re listening? ;-)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gert<br>
<br>
<br>
=C2=A0 =C2=A0 Yes. Do we still want to bloat &quot;master&quot; installers =
with tap-windows?<br>
<br>
=C2=A0 =C2=A0 Afaics that would only be useful _if_ somebody is having prob=
lems<br>
=C2=A0 =C2=A0 with tap-windows6 and needs to revert to tap-windows. However=
, in<br>
=C2=A0 =C2=A0 that case we&#39;d need checkbox, not automatic tap-driver se=
lection<br>
=C2=A0 =C2=A0 based on the OS.<br>
<br>
=C2=A0 =C2=A0 Samuli<br>
<br>
<br>
</span></blockquote>
<br>
<br>
</blockquote></div><br></div>

--001a11c3af2eb3c39b053667f5f2--

