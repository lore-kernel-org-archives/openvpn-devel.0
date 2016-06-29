MIME-Version: 1.0
In-Reply-To: <51c19384-4814-c63e-f515-ea0f3ce8791e@...515...>
References: <CAFHpkQGrube6hF3+hab3NdNhcifjV15ZSefdUWCcXJPg_CApKw@...278...>
	<20160629081109.GU78279@...1296...>
	<CAFHpkQGD10-N=fX6osaMKE4SN+S55A8EN+8byw6aTM9Aosd1Mw@...278...>
	<20160629090025.GV78279@...1296...>
	<51c19384-4814-c63e-f515-ea0f3ce8791e@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 29 Jun 2016 14:16:09 +0500
Message-ID: <CAFHpkQFMs3OsBoV8LP1BZnZpomMFwp6pvw_bx58UrLK20dyF0Q@...278...>
Content-Type: multipart/alternative; boundary=001a11c3af2e4cd6920536673412
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

--001a11c3af2e4cd6920536673412
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I had a look at installers (as we enroll our own installer).
I've got more questions regarding installers

for example, interactive service is installed, but not started. So, user
without admin rights cannot just start it.
it would be better to either start it from installer or add checkbox there
"start service"

2016-06-29 14:11 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

>
> Hi,
>>
>> On Wed, Jun 29, 2016 at 01:57:14PM +0500, ???????? ?????????????? wrote:
>>
>>> ok, if so, we need to modify installer to detect that.
>>>
>>
>> Right, "master" installers should refuse cooperation on XP.
>>
>> Samuli, you're listening? ;-)
>>
>> gert
>>
>>
> Yes. Do we still want to bloat "master" installers with tap-windows?
>
> Afaics that would only be useful _if_ somebody is having problems with
> tap-windows6 and needs to revert to tap-windows. However, in that case we=
'd
> need checkbox, not automatic tap-driver selection based on the OS.
>
> Samuli
>

--001a11c3af2e4cd6920536673412
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>I had a look at installers (as we enroll ou=
r own installer).<br></div>I&#39;ve got more questions regarding installers=
<br><br></div>for example, interactive service is installed, but not starte=
d. So, user without admin rights cannot just start it.<br></div>it would be=
 better to either start it from installer or add checkbox there &quot;start=
 service&quot;<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">2016-06-29 14:11 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&l=
t;<a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a=
>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D""><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi,<br>
<br>
On Wed, Jun 29, 2016 at 01:57:14PM +0500, ???????? ?????????????? wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
ok, if so, we need to modify installer to detect that.<br>
</blockquote>
<br>
Right, &quot;master&quot; installers should refuse cooperation on XP.<br>
<br>
Samuli, you&#39;re listening? ;-)<br>
<br>
gert<br>
<br>
</blockquote>
<br></span>
Yes. Do we still want to bloat &quot;master&quot; installers with tap-windo=
ws?<br>
<br>
Afaics that would only be useful _if_ somebody is having problems with tap-=
windows6 and needs to revert to tap-windows. However, in that case we&#39;d=
 need checkbox, not automatic tap-driver selection based on the OS.<span cl=
ass=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
Samuli<br>
</font></span></blockquote></div><br></div>

--001a11c3af2e4cd6920536673412--

