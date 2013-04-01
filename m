MIME-Version: 1.0
In-Reply-To: <5159A82C.6050608@...1227...>
References: <1364762609-30320-1-git-send-email-arne@...1227...>
	<20130401111231.GD428@...1296...>
	<CAEsd45RW-ueAjEJS5PkecX=MuxLdBXA3uJceyVL6=wrvE9xoeA@...278...>
	<515999BB.6040201@...1227...>
	<CAEsd45SdeLB1RyVEWjnbMQiSa8ekHciv=KjJFF6QiGn9pYxuvw@...278...>
	<5159A262.9010206@...1227...>
	<CAEsd45S5OqVBC1sMVMJn8BDxp6o0NuNBZJBJ3v=8184=RFJEZA@...278...>
	<5159A82C.6050608@...1227...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 1 Apr 2013 13:03:36 -0400
Message-ID: <CAEsd45RLLHD=RnbBRHA7m_fucnOgXfMFMXq5S_sfZPTZ9gtgNQ@...278...>
Content-Type: multipart/alternative; boundary=047d7b6dccb06c6fa904d94f9c11
Subject: Re: [Openvpn-devel] [PATCH] Add support of utun devices under Mac
	OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--047d7b6dccb06c6fa904d94f9c11
Content-Type: text/plain; charset=UTF-8

Thanks; now that I understand the patch, I support it.

This is the first I've heard of 'utun' -- can you tell me how to load it?

(I assume via "sudo kextload xxx", but what is xxx -- that is, where is the
kext located?)

On Mon, Apr 1, 2013 at 11:30 AM, Arne Schwabe <arne@...1227...> wrote:

> Am 01.04.13 17:18, schrieb Jonathan K. Bullard:
>
>  On Mon, Apr 1, 2013 at 11:06 AM, Arne Schwabe <arne@...1227...> wrote:
>>
>>>
>>>  The "standard" utun.ko driver is sometimes problematic (e.g. VmWare
>>>>>>>> Fusion 5 and tun.ko do not work together).
>>>>>>>>
>>>>>>> If it is the other way around (use tun if it is available and if not,
>>>> try utun) then anybody who has loaded tun will continue to work with
>>>> that tun, and anybody who hasn't loaded tun will get utun if it is
>>>> available. So nothing breaks.
>>>>
>>>> It's hard for a GUI like Tunnelblick that doesn't parse the
>>>> configuration file to detect the situation (no dev-type option) to add
>>>> a "dev-type tun" to force the use of tun.
>>>>
>>>> But if we know that utun works for OpenVPN, then I don't have any
>>>> problem with the patch. But that utun "is sometimes problematic" makes
>>>> me worried that this may not be the case.
>>>>
>>> The short history behind the patch: I was investing why Tunnelblick was
>>> not working on a collegues Macbook and as it turned out that you can have
>>> tun.ko loaded or the VmWare Fusion network driver (at least on his
>>> Macbook). Otherwise you get errors on loading the module. But I remembered
>>> something about the utun stuff, found the example code again and come up
>>> with the patch. The setence from the commit should have been:
>>>
>>> The "standard" tun.ko driver is sometimes problematic (e.g. VmWare
>>> Fusion 5 and tun.ko do not work together).
>>>
>>> The utun driver not be fully compatbile with behaviour of the standard
>>> tun.ko driver but all my tests (IPv6, IPv4) worked so far. For 2.3.x I fine
>>> with try utun first or try tun first behaviour but for -master/2.4 I would
>>> like to have try utun first so more people actually use utun so we get to
>>> know if it is really 100% compatible/working.
>>>
>> Thanks; I get it. So it is the "standard" tun driver that is a
>> problem, and the utun driver fixes that problem. In that case, patch
>> is OK with me.
>>
>> By "the 'standard' tun.ko driver", do you mean "tun.kext" from
>> tuntaposx (http://tuntaposx.sourceforge.**net<http://tuntaposx.sourceforge.net>),
>> which is what
>> Tunnelblick uses, or are you talking about something else?
>>
> Yeah exactly that one.
>
> Arne
>
>

--047d7b6dccb06c6fa904d94f9c11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks; now that I understand the patch, I support it.<br><br><div>This is =
the first I&#39;ve heard of &#39;utun&#39; -- can you tell me how to load i=
t?</div><div><br></div><div>(I assume via &quot;sudo kextload xxx&quot;, bu=
t what is xxx -- that is, where is the kext located?)</div>

<div><br></div><div><div class=3D"gmail_quote">On Mon, Apr 1, 2013 at 11:30=
 AM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=3D"mailto:arne@...1227..." =
target=3D"_blank">arne@...1227...</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">

Am 01.04.13 17:18, schrieb Jonathan K. Bullard:<div><div class=3D"h5"><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Mon, Apr 1, 2013 at 11:06 AM, Arne Schwabe &lt;<a href=3D"mailto:arne@...1186...=
.1227..." target=3D"_blank">arne@...1227...</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
The &quot;standard&quot; utun.ko driver is sometimes problematic (e.g. VmWa=
re Fusion 5 and tun.ko do not work together).<br>
</blockquote></blockquote></blockquote></blockquote>
If it is the other way around (use tun if it is available and if not,<br>
try utun) then anybody who has loaded tun will continue to work with<br>
that tun, and anybody who hasn&#39;t loaded tun will get utun if it is<br>
available. So nothing breaks.<br>
<br>
It&#39;s hard for a GUI like Tunnelblick that doesn&#39;t parse the<br>
configuration file to detect the situation (no dev-type option) to add<br>
a &quot;dev-type tun&quot; to force the use of tun.<br>
<br>
But if we know that utun works for OpenVPN, then I don&#39;t have any<br>
problem with the patch. But that utun &quot;is sometimes problematic&quot; =
makes<br>
me worried that this may not be the case.<br>
</blockquote>
The short history behind the patch: I was investing why Tunnelblick was not=
 working on a collegues Macbook and as it turned out that you can have tun.=
ko loaded or the VmWare Fusion network driver (at least on his Macbook). Ot=
herwise you get errors on loading the module. But I remembered something ab=
out the utun stuff, found the example code again and come up with the patch=
. The setence from the commit should have been:<br>


<br>
The &quot;standard&quot; tun.ko driver is sometimes problematic (e.g. VmWar=
e Fusion 5 and tun.ko do not work together).<br>
<br>
The utun driver not be fully compatbile with behaviour of the standard tun.=
ko driver but all my tests (IPv6, IPv4) worked so far. For 2.3.x I fine wit=
h try utun first or try tun first behaviour but for -master/2.4 I would lik=
e to have try utun first so more people actually use utun so we get to know=
 if it is really 100% compatible/working.<br>


</blockquote>
Thanks; I get it. So it is the &quot;standard&quot; tun driver that is a<br>
problem, and the utun driver fixes that problem. In that case, patch<br>
is OK with me.<br>
<br>
By &quot;the &#39;standard&#39; tun.ko driver&quot;, do you mean &quot;tun.=
kext&quot; from<br>
tuntaposx (<a href=3D"http://tuntaposx.sourceforge.net" target=3D"_blank">h=
ttp://tuntaposx.sourceforge.<u></u>net</a>), which is what<br>
Tunnelblick uses, or are you talking about something else?<br>
</blockquote></div></div>
Yeah exactly that one.<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
Arne<br>
<br>
</font></span></blockquote></div><br></div>

--047d7b6dccb06c6fa904d94f9c11--

