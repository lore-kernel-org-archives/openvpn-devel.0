MIME-Version: 1.0
In-Reply-To: <d4f8578f-149a-0f13-b1d7-8f763b590966@...515...>
References: <CAFHpkQFNHWNWZsw+vN=HUQA_MgMEAX9LMa3FMKfoCpTps2k2AQ@...278...>
	<CAKuzo_isuFn2dC6hZ-bqP2aMF8j_mxgStXctAzC-RayEkBUTbw@...278...>
	<d4f8578f-149a-0f13-b1d7-8f763b590966@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 9 Jun 2016 11:45:29 +0500
Message-ID: <CAFHpkQGzt=jGdBF=Xp59dNnE-1g9TYyjih9P0KxXnUk8Zx-6UQ@...278...>
Content-Type: multipart/alternative; boundary=e89a8f83a48999a83b0534d2c4ea
Subject: Re: [Openvpn-devel] how snapshot installers are built ?
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

--e89a8f83a48999a83b0534d2c4ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-06-09 11:16 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Hi,
>
> Hi,
>>
>>
>>     I see daily builds like
>>
>>
>>
>> http://build.openvpn.net/downloads/snapshots/openvpn-install-master-2016=
0607214911-63b3e000c9-x86_64.exe
>>
>>
>>     I used to think they are built with "build-snapshot":
>>
>> https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/build-=
snapshot
>>
>>     however, when I run it,
>>
>>
>>     ....
>>     tap-windows
>>     Fixup libtool files
>>     Restore libtool files
>>     Fixup libtool files
>>     Build openvpn
>>     ../generic/build: line 284: cd:
>>     /home/ilia/openvpn-build/windows-nsis/tmp/build-i686/openvpn-2.3.11:
>>     No such file or directory
>>     FATAL: cd openvpn
>>     FATAL: build i686 >&2
>>     FATAL: build-complete >&2
>>     [ilia@...23... windows-nsis]$
>>
>>
>>     somehow it tries to find openvpn-2.3.11 instead of master.
>>
>>
>>     how am I supposed to run that script ?
>>
>
> The build-snapshot script is a simple wrapper around build-complete, which
> is why it failed. You basically need to use
>
> OPENVPN_VERSION=3D2.3_git build-snapshot <args>
>


I've managed to build snapshot by hands (I found guide on wiki)
however, I used to think that I either run that script and it builds or it
says me "please specify OPENVPN_VERSION..."


I'll try to make a patch if I would have time


>
> Basically build-snapshot creates a tarball from Git sources and feeds that
> to build-complete for the build.
>
> Samuli had posted a link to
>>  https://github.com/mattock/openvpn-windows-buildtest which, I think,
>> has the necessary scripts to use with openvpn-build for daily snapshot
>> building..
>>
>> Selva
>>
>
> Those scripts are indeed the ones I use to generate the Windows installer
> snapshots.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

--e89a8f83a48999a83b0534d2c4ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-06-09 11:16 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">Hi,<span class=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi,<br>
<br>
<br>
=C2=A0 =C2=A0 I see daily builds like<br>
<br>
<br>
=C2=A0 =C2=A0 <a href=3D"http://build.openvpn.net/downloads/snapshots/openv=
pn-install-master-20160607214911-63b3e000c9-x86_64.exe" rel=3D"noreferrer" =
target=3D"_blank">http://build.openvpn.net/downloads/snapshots/openvpn-inst=
all-master-20160607214911-63b3e000c9-x86_64.exe</a><br>
<br>
<br>
=C2=A0 =C2=A0 I used to think they are built with &quot;build-snapshot&quot=
;:<br>
=C2=A0 =C2=A0 <a href=3D"https://github.com/OpenVPN/openvpn-build/blob/mast=
er/windows-nsis/build-snapshot" rel=3D"noreferrer" target=3D"_blank">https:=
//github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/build-snapshot<=
/a><br>
<br>
=C2=A0 =C2=A0 however, when I run it,<br>
<br>
<br>
=C2=A0 =C2=A0 ....<br>
=C2=A0 =C2=A0 tap-windows<br>
=C2=A0 =C2=A0 Fixup libtool files<br>
=C2=A0 =C2=A0 Restore libtool files<br>
=C2=A0 =C2=A0 Fixup libtool files<br>
=C2=A0 =C2=A0 Build openvpn<br>
=C2=A0 =C2=A0 ../generic/build: line 284: cd:<br>
=C2=A0 =C2=A0 /home/ilia/openvpn-build/windows-nsis/tmp/build-i686/openvpn-=
2.3.11:<br>
=C2=A0 =C2=A0 No such file or directory<br>
=C2=A0 =C2=A0 FATAL: cd openvpn<br>
=C2=A0 =C2=A0 FATAL: build i686 &gt;&amp;2<br>
=C2=A0 =C2=A0 FATAL: build-complete &gt;&amp;2<br>
=C2=A0 =C2=A0 [ilia@...23... windows-nsis]$<br>
<br>
<br>
=C2=A0 =C2=A0 somehow it tries to find openvpn-2.3.11 instead of master.<br>
<br>
<br>
=C2=A0 =C2=A0 how am I supposed to run that script ?<br>
</blockquote>
<br></span>
The build-snapshot script is a simple wrapper around build-complete, which =
is why it failed. You basically need to use<br>
<br>
OPENVPN_VERSION=3D2.3_git build-snapshot &lt;args&gt;<br></blockquote><div>=
<br><br></div><div>I&#39;ve managed to build snapshot by hands (I found gui=
de on wiki)<br></div><div>however, I used to think that I either run that s=
cript and it builds or it says me &quot;please specify OPENVPN_VERSION...&q=
uot;<br><br><br></div><div>I&#39;ll try to make a patch if I would have tim=
e<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Basically build-snapshot creates a tarball from Git sources and feeds that =
to build-complete for the build.<span class=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Samuli had posted a link to<br>
=C2=A0<a href=3D"https://github.com/mattock/openvpn-windows-buildtest" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/mattock/openvpn-window=
s-buildtest</a> which, I think,<br>
has the necessary scripts to use with openvpn-build for daily snapshot<br>
building..<br>
<br>
Selva<br>
</blockquote>
<br></span>
Those scripts are indeed the ones I use to generate the Windows installer s=
napshots.<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</font></span></blockquote></div><br></div></div>

--e89a8f83a48999a83b0534d2c4ea--

