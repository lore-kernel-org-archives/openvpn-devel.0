MIME-Version: 1.0
In-Reply-To: <e6cfa59d-8424-8cc6-92df-d23e91c3c396@...515...>
References: <CAFHpkQFNRHCCccrSR5ZMCvZj_VC+K=UMR9P4RDhvjCMqGXX1wg@...278...>
	<b79d336b-9d5e-6d7e-a899-06ab10d322d0@...515...>
	<CAFHpkQGsewCStyZ5HHXC9mcwNGN5-_w+BjmmqoHNufd12YZN5w@...278...>
	<e6cfa59d-8424-8cc6-92df-d23e91c3c396@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 2 Dec 2016 08:54:31 +0500
Message-ID: <CAFHpkQGLS1SuebnkZCOJGnMgigqW+zJ7D=qEytUrN9A7uGYHow@...278...>
Content-Type: multipart/alternative; boundary=089e013c656a3e76c50542a4e5ea
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

--089e013c656a3e76c50542a4e5ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-12-01 16:40 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Hi,
>
> Il 30/11/2016 11:58, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
>
>>
>>
>>         (and, yes, I'm going to build multi-language installer, probably
>>         right
>>         after 2.4 release)
>>
>>
>>     This makes sense. Any plans on how you're going to do it?
>>
>>
>>
>> as we do not support windows 2000 anymore, we can easily switch to
>> unicode.
>> there are few questions
>>
>> 1) unicode nsis under linux (we use windows+mingw+nsis unicode, so, I'm
>> not sure about linux)
>>
>>
> Unicode seems to be present in Linux NSIS versions, according to this:
>
> <http://stackoverflow.com/questions/19201702/nsis-unicode-build-for-linux>
>
> The build computers need to be updated to a quite recent NSIS version,
> though.
>


unicode nsis is different from ansi nsis. for example, nsProcess needs
different dll.
and, unicode nsis is not shipped in most common Linux repo (you need to
install it separately).

taking the above into account, I think, I should repack the above packages
as "makensis3" instead of "makensis".

@mattock, which linux distro do you use for release building ?



>
>
> 2) split installer into several language files (as done for openvpn-gui)
>>
>
> We'd also need to detect the language the user is using to select the
> correct one. I personally don't like manual language selector as they add
> one more step to the install process.
>
>
>> 3) test everything
>>
>>
>> it is not difficult, but it is time consuming, I'm afraid we will test
>> it properly before 2.4
>>
>
> The plan is to release 2.5 pretty quickly after 2.4. Also, installer
> changes do not necessarily need to go in sync with OpenVPN releases.
>
>
>>     Another internationalization aspect we could improve is how we store
>>     translations for OpenVPN-GUI. Editing the resource files directly is
>>     clumsy and error-prone, as the files contain lots of "stuff" that is
>>     not meant to be translated. A simple key-value file would be much
>>     easier, although in OpenVPN-GUI's case the hardcoded window sizes
>>     make this more complex.
>>
>>
>> it makes sense to convert openvpn-gui resources into visual studio forma=
t.
>> @selvanair some times ago told something like that.
>>
>
> Hmm, interesting, will need to look into it. Any format that could be
> loaded by a translation memory application is better than what we have no=
w.
> Simple key-value resource files are also easy to convert into other simil=
ar
> formats, if necessary.
>
> as for the rest, separate resources are just fine.
>>
>>
>>
>>     Also I'm not sure how easy it would be to separate the translatable
>>     strings into a separate file. I would guess that the actual .res
>>     files could be generated on the fly from a template and the
>>     key-value file by the build scripts.
>>
>>
>> it looks overcomplicated. some kind of "post build operation" which will
>> identifies missing language resources would be nice however
>>
>
> Yeah, it could be hairy. Let's look into this in depth later.
>
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

--089e013c656a3e76c50542a4e5ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-12-01 16:40 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">Hi,<span class=3D""><br>
<br>
Il 30/11/2016 11:58, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (and, yes, I&#39;m going to build multi-languag=
e installer, probably<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 right<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 after 2.4 release)<br>
<br>
<br>
=C2=A0 =C2=A0 This makes sense. Any plans on how you&#39;re going to do it?=
<br>
<br>
<br>
<br>
as we do not support windows 2000 anymore, we can easily switch to unicode.=
<br>
there are few questions<br>
<br>
1) unicode nsis under linux (we use windows+mingw+nsis unicode, so, I&#39;m=
<br>
not sure about linux)<br>
<br>
</blockquote>
<br></span>
Unicode seems to be present in Linux NSIS versions, according to this:<br>
<br>
&lt;<a href=3D"http://stackoverflow.com/questions/19201702/nsis-unicode-bui=
ld-for-linux" rel=3D"noreferrer" target=3D"_blank">http://stackoverflow.com=
/ques<wbr>tions/19201702/nsis-unicode-<wbr>build-for-linux</a>&gt;<br>
<br>
The build computers need to be updated to a quite recent NSIS version, thou=
gh.<span class=3D""><br></span></blockquote><div><br><br></div><div>unicode=
 nsis is different from ansi nsis. for example, nsProcess needs different d=
ll.<br></div><div>and, unicode nsis is not shipped in most common Linux rep=
o (you need to install it separately).<br><br></div><div>taking the above i=
nto account, I think, I should repack the above packages as &quot;makensis3=
&quot; instead of &quot;makensis&quot;.<br><br></div><div>@mattock, which l=
inux distro do you use for release building ?<br><br></div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><span class=3D"">
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
2) split installer into several language files (as done for openvpn-gui)<br>
</blockquote>
<br></span>
We&#39;d also need to detect the language the user is using to select the c=
orrect one. I personally don&#39;t like manual language selector as they ad=
d one more step to the install process.<span class=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
3) test everything<br>
<br>
<br>
it is not difficult, but it is time consuming, I&#39;m afraid we will test<=
br>
it properly before 2.4<br>
</blockquote>
<br></span>
The plan is to release 2.5 pretty quickly after 2.4. Also, installer change=
s do not necessarily need to go in sync with OpenVPN releases.<span class=
=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
=C2=A0 =C2=A0 Another internationalization aspect we could improve is how w=
e store<br>
=C2=A0 =C2=A0 translations for OpenVPN-GUI. Editing the resource files dire=
ctly is<br>
=C2=A0 =C2=A0 clumsy and error-prone, as the files contain lots of &quot;st=
uff&quot; that is<br>
=C2=A0 =C2=A0 not meant to be translated. A simple key-value file would be =
much<br>
=C2=A0 =C2=A0 easier, although in OpenVPN-GUI&#39;s case the hardcoded wind=
ow sizes<br>
=C2=A0 =C2=A0 make this more complex.<br>
<br>
<br>
it makes sense to convert openvpn-gui resources into visual studio format.<=
br>
@selvanair some times ago told something like that.<br>
</blockquote>
<br></span>
Hmm, interesting, will need to look into it. Any format that could be loade=
d by a translation memory application is better than what we have now. Simp=
le key-value resource files are also easy to convert into other similar for=
mats, if necessary.<span class=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
as for the rest, separate resources are just fine.<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 Also I&#39;m not sure how easy it would be to separate the tr=
anslatable<br>
=C2=A0 =C2=A0 strings into a separate file. I would guess that the actual .=
res<br>
=C2=A0 =C2=A0 files could be generated on the fly from a template and the<b=
r>
=C2=A0 =C2=A0 key-value file by the build scripts.<br>
<br>
<br>
it looks overcomplicated. some kind of &quot;post build operation&quot; whi=
ch will<br>
identifies missing language resources would be nice however<br>
</blockquote>
<br></span>
Yeah, it could be hairy. Let&#39;s look into this in depth later.<div class=
=3D"HOEnZb"><div class=3D"h5"><br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</div></div></blockquote></div><br></div></div>

--089e013c656a3e76c50542a4e5ea--

