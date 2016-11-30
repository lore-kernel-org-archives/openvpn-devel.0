MIME-Version: 1.0
In-Reply-To: <b79d336b-9d5e-6d7e-a899-06ab10d322d0@...515...>
References: <CAFHpkQFNRHCCccrSR5ZMCvZj_VC+K=UMR9P4RDhvjCMqGXX1wg@...278...>
	<b79d336b-9d5e-6d7e-a899-06ab10d322d0@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 30 Nov 2016 12:58:18 +0300
Message-ID: <CAFHpkQGsewCStyZ5HHXC9mcwNGN5-_w+BjmmqoHNufd12YZN5w@...278...>
Content-Type: multipart/alternative; boundary=089e0102e3da966c5b054281beac
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

--089e0102e3da966c5b054281beac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-11-30 12:36 GMT+03:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Il 30/11/2016 09:53, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
>
>> Hello,
>>
>> as we finished x86 + x64 installer, we can do something else now.
>> @mattock, which installer are you going to build ?
>>
>> it used to be (ndis5, ndis6) x (x86, x64) matrix, what will be future
>> matrix ?
>>
>
> As discussed earlier bloating the (2.4) installers with NDIS5 drivers is
> not worth it. NDIS5 driver is only aimed for Windows XP, and we have
> dropped XP support in OpenVPN 2.4 already. Also, OpenvPN 2.3 will see few=
er
> and fewer fixes as 2.4.x releases stabilize. Eventually 2.3 will go into
> "high severity security fixes only"-mode, like 2.2 did several years ago.
>
> So let's not beat the dead horse (NDIS5) anymore :).
>
>
>> (and, yes, I'm going to build multi-language installer, probably right
>> after 2.4 release)
>>
>
> This makes sense. Any plans on how you're going to do it?
>


as we do not support windows 2000 anymore, we can easily switch to unicode.
there are few questions

1) unicode nsis under linux (we use windows+mingw+nsis unicode, so, I'm not
sure about linux)

2) split installer into several language files (as done for openvpn-gui)

3) test everything


it is not difficult, but it is time consuming, I'm afraid we will test it
properly before 2.4



>
> Another internationalization aspect we could improve is how we store
> translations for OpenVPN-GUI. Editing the resource files directly is clum=
sy
> and error-prone, as the files contain lots of "stuff" that is not meant to
> be translated. A simple key-value file would be much easier, although in
> OpenVPN-GUI's case the hardcoded window sizes make this more complex.
>

it makes sense to convert openvpn-gui resources into visual studio format.
@selvanair some times ago told something like that.

as for the rest, separate resources are just fine.


>
> Also I'm not sure how easy it would be to separate the translatable
> strings into a separate file. I would guess that the actual .res files
> could be generated on the fly from a template and the key-value file by t=
he
> build scripts.
>
>
it looks overcomplicated. some kind of "post build operation" which will
identifies missing language resources would be nice however


> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

--089e0102e3da966c5b054281beac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-11-30 12:36 GMT+03:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">Il 30/11/2016=
 09:53, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD=
 ha scritto:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hello,<br>
<br>
as we finished x86 + x64 installer, we can do something else now.<br>
@mattock, which installer are you going to build ?<br>
<br>
it used to be (ndis5, ndis6) x (x86, x64) matrix, what will be future<br>
matrix ?<br>
</blockquote>
<br></span>
As discussed earlier bloating the (2.4) installers with NDIS5 drivers is no=
t worth it. NDIS5 driver is only aimed for Windows XP, and we have dropped =
XP support in OpenVPN 2.4 already. Also, OpenvPN 2.3 will see fewer and few=
er fixes as 2.4.x releases stabilize. Eventually 2.3 will go into &quot;hig=
h severity security fixes only&quot;-mode, like 2.2 did several years ago.<=
br>
<br>
So let&#39;s not beat the dead horse (NDIS5) anymore :).<span class=3D""><b=
r>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
(and, yes, I&#39;m going to build multi-language installer, probably right<=
br>
after 2.4 release)<br>
</blockquote>
<br></span>
This makes sense. Any plans on how you&#39;re going to do it?<br></blockquo=
te><div><br><br></div><div>as we do not support windows 2000 anymore, we ca=
n easily switch to unicode.<br></div><div>there are few questions<br><br></=
div><div>1) unicode nsis under linux (we use windows+mingw+nsis unicode, so=
, I&#39;m not sure about linux)<br><br></div><div>2) split installer into s=
everal language files (as done for openvpn-gui)<br><br></div><div>3) test e=
verything<br><br><br></div><div>it is not difficult, but it is time consumi=
ng, I&#39;m afraid we will test it properly before 2.4<br></div><div><br>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
<br>
Another internationalization aspect we could improve is how we store transl=
ations for OpenVPN-GUI. Editing the resource files directly is clumsy and e=
rror-prone, as the files contain lots of &quot;stuff&quot; that is not mean=
t to be translated. A simple key-value file would be much easier, although =
in OpenVPN-GUI&#39;s case the hardcoded window sizes make this more complex=
.<br></blockquote><div><br></div><div>it makes sense to convert openvpn-gui=
 resources into visual studio format.<br></div><div>@selvanair some times a=
go told something like that.<br><br></div><div>as for the rest, separate re=
sources are just fine.<br></div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
<br>
Also I&#39;m not sure how easy it would be to separate the translatable str=
ings into a separate file. I would guess that the actual .res files could b=
e generated on the fly from a template and the key-value file by the build =
scripts.<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br></font></span></blockquote><div><br></div><div>it looks overcomplicated=
. some kind of &quot;post build operation&quot; which will identifies missi=
ng language resources would be nice however<br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><span class=3D"HOEnZb"><font color=3D"#888888">
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</font></span></blockquote></div><br></div></div>

--089e0102e3da966c5b054281beac--

