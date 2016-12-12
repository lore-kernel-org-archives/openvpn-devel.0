MIME-Version: 1.0
In-Reply-To: <639d4a79-5f8c-50bf-b452-47896208de5d@...515...>
References: <CAFHpkQE7qT8JZM+ZazgJy7PcGMbWawh+HE7OW-=SGNhnnL1pwA@...278...>
	<639d4a79-5f8c-50bf-b452-47896208de5d@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 12 Dec 2016 14:42:02 +0500
Message-ID: <CAFHpkQGze-GuvLnphzZ9B8o_0Nm9VZrtSP2PENfKwuD=6yvwEg@...278...>
Content-Type: multipart/alternative; boundary=001a114b7e0c7fa132054372eaf4
Subject: Re: [Openvpn-devel] openvpn windows feed ?
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

--001a114b7e0c7fa132054372eaf4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-12-12 14:22 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Il 11/12/2016 20:44, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
>
>> Hello,
>>
>> as we release new versions of openvpn installer, there are at least two
>> "channels"
>>
>> a) beta
>> b) stable
>>
>> should we also host some rss/atom feed with the most recent versions of
>> 2 channels ?
>>
>> so, that openvpn-gui could check "for updates"
>> also, there's an exception for WinXP (which I've no idea what to do with=
).
>>
>> it will help users to understand "new version is released, probably I
>> should upgrade".
>>
>
> Notifying the user would probably be ok, and for that we'd need some feed.
> The feed could be much simpler than RSS/Atom, if only machines would read
> it.
>

I considered PAD-files http://nsis.sourceforge.net/Check_online_for_Updates

there're two places for upgrading (or notifiyng user)

a)  installer (in case user run old installer)
b)  openvpn-gui itself


>
> That said, I think Windows application auto-updaters are very distracting,
> and I would prefer to publish new OpenVPN Windows packages in a Chocolatey
> repository:
>
> <https://chocolatey.org/>
>

I missed this one. it might be a better choice than PAD


https://chocolatey.org/packages/openvpn - there's already openvpn. should
we contact current maintainer ?



> Chocolatey, as "apt-get for Windows", would take care of OpenVPN upgrades
> in a clean and non-intrusive fashion. It also removes the need to reinvent
> the wheel in form of an auto-update daemon.
>
> Cholatey is not just a random third-party application for managing
> packages for Windows. It is also pluggable as a provider to a more generic
> Microsoft framework for managing package managers called OneGet. For
> details, look here:
>
> <https://github.com/OneGet/oneget>
> >https://chocolatey.org/faq>
> <http://www.hanselman.com/blog/AptGetForWindowsOneGetAndChoc
> olateyOnWindows10.aspx>
>

> One can use Chocolatey standalone, or use it as a OneGet package provider.
> We could possibly integrate Chocolatey setup with the standalone Windows
> installers as opt-in.
>
> Anyways, after OpenVPN 2.4.0 is out, I will setup a Chocolatey repository
> for OpenVPN snapshot packages and see how it works. That will enable the
> more adventurous Windows users to live on the very edge with minimal manu=
al
> effort. It will also enable us to automate Windows snapshot testing with
> openvpn-windows-test[1].
>
> Samuli
>
> [1] <https://github.com/OpenVPN/openvpn-windows-test>
>
>
>> it is great amount of work, I think we can schedule it after 2.4
>>
>> Cheers,
>> Ilya Shipitsin
>>
>>
>>
>> ------------------------------------------------------------
>> ------------------
>> Developer Access Program for Intel Xeon Phi Processors
>> Access to Intel Xeon Phi processor-based developer platforms.
>> With one year of Intel Parallel Studio XE.
>> Training and support from Colfax.
>> Order your platform today.http://sdm.link/xeonphi
>>
>>
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>>
>

--001a114b7e0c7fa132054372eaf4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-12-12 14:22 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=
=3D"gmail-">Il 11/12/2016 20:44, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD ha scritto:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Hello,<br>
<br>
as we release new versions of openvpn installer, there are at least two<br>
&quot;channels&quot;<br>
<br>
a) beta<br>
b) stable<br>
<br>
should we also host some rss/atom feed with the most recent versions of<br>
2 channels ?<br>
<br>
so, that openvpn-gui could check &quot;for updates&quot;<br>
also, there&#39;s an exception for WinXP (which I&#39;ve no idea what to do=
 with).<br>
<br>
it will help users to understand &quot;new version is released, probably I<=
br>
should upgrade&quot;.<br>
</blockquote>
<br></span>
Notifying the user would probably be ok, and for that we&#39;d need some fe=
ed. The feed could be much simpler than RSS/Atom, if only machines would re=
ad it.<br></blockquote><div><br></div><div>I considered PAD-files <a href=
=3D"http://nsis.sourceforge.net/Check_online_for_Updates">http://nsis.sourc=
eforge.net/Check_online_for_Updates</a><br><br>there&#39;re two places for =
upgrading (or notifiyng user)<br><br></div><div>a)=C2=A0 installer (in case=
 user run old installer)<br></div><div>b)=C2=A0 openvpn-gui itself<br></div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
That said, I think Windows application auto-updaters are very distracting, =
and I would prefer to publish new OpenVPN Windows packages in a Chocolatey =
repository:<br>
<br>
&lt;<a href=3D"https://chocolatey.org/" rel=3D"noreferrer" target=3D"_blank=
">https://chocolatey.org/</a>&gt;<br></blockquote><div><br></div><div>I mis=
sed this one. it might be a better choice than PAD<br></div><div><br><br><a=
 href=3D"https://chocolatey.org/packages/openvpn">https://chocolatey.org/pa=
ckages/openvpn</a> - there&#39;s already openvpn. should we contact current=
 maintainer ?<br><br><br> </div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
Chocolatey, as &quot;apt-get for Windows&quot;, would take care of OpenVPN =
upgrades in a clean and non-intrusive fashion. It also removes the need to =
reinvent the wheel in form of an auto-update daemon.<br>
<br>
Cholatey is not just a random third-party application for managing packages=
 for Windows. It is also pluggable as a provider to a more generic Microsof=
t framework for managing package managers called OneGet. For details, look =
here:<br>
<br>
&lt;<a href=3D"https://github.com/OneGet/oneget" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/OneGet/one<wbr>get</a>&gt;<br>
&gt;<a href=3D"https://chocolatey.org/faq" rel=3D"noreferrer" target=3D"_bl=
ank">https://chocolatey.org/faq</a>&gt;<br>
&lt;<a href=3D"http://www.hanselman.com/blog/AptGetForWindowsOneGetAndChoco=
lateyOnWindows10.aspx" rel=3D"noreferrer" target=3D"_blank">http://www.hans=
elman.com/blog<wbr>/AptGetForWindowsOneGetAndChoc<wbr>olateyOnWindows10.asp=
x</a>&gt;=C2=A0<br></blockquote><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
One can use Chocolatey standalone, or use it as a OneGet package provider. =
We could possibly integrate Chocolatey setup with the standalone Windows in=
stallers as opt-in.<br>
<br>
Anyways, after OpenVPN 2.4.0 is out, I will setup a Chocolatey repository f=
or OpenVPN snapshot packages and see how it works. That will enable the mor=
e adventurous Windows users to live on the very edge with minimal manual ef=
fort. It will also enable us to automate Windows snapshot testing with open=
vpn-windows-test[1].<br>
<br>
Samuli<br>
<br>
[1] &lt;<a href=3D"https://github.com/OpenVPN/openvpn-windows-test" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/OpenVPN/op<wbr>envpn-windo=
ws-test</a>&gt;<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gmail-">
<br>
it is great amount of work, I think we can schedule it after 2.4<br>
<br>
Cheers,<br>
Ilya Shipitsin<br>
<br>
<br>
<br></span>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Developer Access Program for Intel Xeon Phi Processors<br>
Access to Intel Xeon Phi processor-based developer platforms.<br>
With one year of Intel Parallel Studio XE.<br>
Training and support from Colfax.<br>
Order your platform today.<a href=3D"http://sdm.link/xeonphi" rel=3D"norefe=
rrer" target=3D"_blank">http://sdm.link/xeonphi</a><br>
<br>
<br>
<br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@...1483...<wbr>e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br>
</blockquote>
<br>
</blockquote></div><br></div></div>

--001a114b7e0c7fa132054372eaf4--

