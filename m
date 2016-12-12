MIME-Version: 1.0
In-Reply-To: <c53dbb4e-4c72-4c7a-2b2f-f4708322d409@...515...>
References: <CAFHpkQFNRHCCccrSR5ZMCvZj_VC+K=UMR9P4RDhvjCMqGXX1wg@...278...>
	<b79d336b-9d5e-6d7e-a899-06ab10d322d0@...515...>
	<CAFHpkQGsewCStyZ5HHXC9mcwNGN5-_w+BjmmqoHNufd12YZN5w@...278...>
	<e6cfa59d-8424-8cc6-92df-d23e91c3c396@...515...>
	<CAFHpkQGLS1SuebnkZCOJGnMgigqW+zJ7D=qEytUrN9A7uGYHow@...278...>
	<429ef600-ead9-7544-e563-57b1fbf05220@...515...>
	<CAFHpkQERa49dRP1S=g8sybGzCFW47Ytv0T=otOeh+GhGgxMDgw@...278...>
	<c53dbb4e-4c72-4c7a-2b2f-f4708322d409@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 12 Dec 2016 14:45:00 +0500
Message-ID: <CAFHpkQFh=R8Ruv6gNrPK8i+JfV_7c_qdPfMR==0PRN1MpMdtWQ@...278...>
Content-Type: multipart/alternative; boundary=089e0102e3da128704054372f53f
Subject: Re: [Openvpn-devel] combined ndis5 + ndis6 installer ?
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

--089e0102e3da128704054372f53f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-12-12 13:46 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Il 12/12/2016 08:22, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
>
>>
>>
>> 2016-12-02 11:55 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
>> <mailto:samuli@...515...>>:
>>
>>     Il 02/12/2016 05:54, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD ha scritto:
>>
>>         unicode nsis is different from ansi nsis. for example, nsProcess
>>         needs
>>         different dll.
>>
>>
>>     Ok. More research is needed to see what is involved, then.
>>
>>         and, unicode nsis is not shipped in most common Linux repo (you
>>         need to
>>         install it separately).
>>
>>
>>     Indeed, that was my impression. So far I've only seen NSIS 2.46 or
>>     so in the distribution repositories, and the link I provided talked
>>     about NSIS 3.0b or something.
>>
>>         taking the above into account, I think, I should repack the above
>>         packages as "makensis3" instead of "makensis".
>>
>>
>>     You mean creating deb/rpm packages for updated NSIS? I think
>>     manually installing updated NSIS would be good enough, if
>>     repackaging proves to be too much of an effort.
>>
>>
>> I investigated Fedora (we use CentOS/Fedora) and Debian world.
>> as for Fedora, it is far from being ready (I'll take care of that)
>>
>> as for Debian, there's http://deb.debian.org/debian/pool/main/n/nsis/
>> <http://deb.debian.org/debian/pool/main/n/nsis/>
>> so, I installed ubuntu 16.04, added "debian experimental" (the above
>> repo), and voila, I compiled openvpn installer.
>>
>> I think we can move to unicode nsis right after 2.4
>>
>
> Excellent news! Once 2.4.0 is out I can again focus on non-release
> critical things, like updating the build VM.



for future discussion:

a) adopt building guide (on https://openvpn.net) "nsis3 is required...."
b) add "Unicode true" to openvpn.nsi + comment that + provide link to web
page "a)"
c) check every nsis plugin whether it supports unicode
d) release installer
...
z) split installer into several language files + choose language
automatically (I also do not like manual language selection)


>
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

--089e0102e3da128704054372f53f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-12-12 13:46 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">Il 12/12/2016=
 08:22, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD=
 ha scritto:<br>
</span><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><span class=3D"">
<br>
<br>
2016-12-02 11:55 GMT+05:00 Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:samul=
i@...515..." target=3D"_blank">samuli@...515...</a><br></span>
&lt;mailto:<a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...493...=
515...</a>&gt;&gt;:<span class=3D""><br>
<br>
=C2=A0 =C2=A0 Il 02/12/2016 05:54, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD ha scritto:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unicode nsis is different from ansi nsis. for e=
xample, nsProcess<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 needs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 different dll.<br>
<br>
<br>
=C2=A0 =C2=A0 Ok. More research is needed to see what is involved, then.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 and, unicode nsis is not shipped in most common=
 Linux repo (you<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 need to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 install it separately).<br>
<br>
<br>
=C2=A0 =C2=A0 Indeed, that was my impression. So far I&#39;ve only seen NSI=
S 2.46 or<br>
=C2=A0 =C2=A0 so in the distribution repositories, and the link I provided =
talked<br>
=C2=A0 =C2=A0 about NSIS 3.0b or something.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 taking the above into account, I think, I shoul=
d repack the above<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 packages as &quot;makensis3&quot; instead of &q=
uot;makensis&quot;.<br>
<br>
<br>
=C2=A0 =C2=A0 You mean creating deb/rpm packages for updated NSIS? I think<=
br>
=C2=A0 =C2=A0 manually installing updated NSIS would be good enough, if<br>
=C2=A0 =C2=A0 repackaging proves to be too much of an effort.<br>
<br>
<br>
I investigated Fedora (we use CentOS/Fedora) and Debian world.<br>
as for Fedora, it is far from being ready (I&#39;ll take care of that)<br>
<br>
as for Debian, there&#39;s <a href=3D"http://deb.debian.org/debian/pool/mai=
n/n/nsis/" rel=3D"noreferrer" target=3D"_blank">http://deb.debian.org/debia=
n/p<wbr>ool/main/n/nsis/</a><br>
&lt;<a href=3D"http://deb.debian.org/debian/pool/main/n/nsis/" rel=3D"noref=
errer" target=3D"_blank">http://deb.debian.org/debian/<wbr>pool/main/n/nsis=
/</a>&gt;<br>
so, I installed ubuntu 16.04, added &quot;debian experimental&quot; (the ab=
ove<br>
repo), and voila, I compiled openvpn installer.<br>
<br>
I think we can move to unicode nsis right after 2.4<br>
</span></blockquote>
<br>
Excellent news! Once 2.4.0 is out I can again focus on non-release critical=
 things, like updating the build VM.</blockquote><div><br><br></div><div>fo=
r future discussion:<br><br></div><div>a) adopt building guide (on <a href=
=3D"https://openvpn.net">https://openvpn.net</a>) &quot;nsis3 is required..=
..&quot;<br></div><div>b) add &quot;Unicode true&quot; to openvpn.nsi + com=
ment that + provide link to web page &quot;a)&quot;<br></div><div>c) check =
every nsis plugin whether it supports unicode<br></div><div>d) release inst=
aller<br>...<br></div><div>z) split installer into several language files +=
 choose language automatically (I also do not like manual language selectio=
n)<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"H=
OEnZb"><div class=3D"h5"><br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</div></div></blockquote></div><br></div></div>

--089e0102e3da128704054372f53f--

