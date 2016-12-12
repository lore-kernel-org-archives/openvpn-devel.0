MIME-Version: 1.0
In-Reply-To: <429ef600-ead9-7544-e563-57b1fbf05220@...515...>
References: <CAFHpkQFNRHCCccrSR5ZMCvZj_VC+K=UMR9P4RDhvjCMqGXX1wg@...278...>
	<b79d336b-9d5e-6d7e-a899-06ab10d322d0@...515...>
	<CAFHpkQGsewCStyZ5HHXC9mcwNGN5-_w+BjmmqoHNufd12YZN5w@...278...>
	<e6cfa59d-8424-8cc6-92df-d23e91c3c396@...515...>
	<CAFHpkQGLS1SuebnkZCOJGnMgigqW+zJ7D=qEytUrN9A7uGYHow@...278...>
	<429ef600-ead9-7544-e563-57b1fbf05220@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 12 Dec 2016 11:22:05 +0500
Message-ID: <CAFHpkQERa49dRP1S=g8sybGzCFW47Ytv0T=otOeh+GhGgxMDgw@...278...>
Content-Type: multipart/alternative; boundary=089e0102e3da68bfc70543701fb8
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

--089e0102e3da68bfc70543701fb8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-12-02 11:55 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Il 02/12/2016 05:54, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
>
>> unicode nsis is different from ansi nsis. for example, nsProcess needs
>> different dll.
>>
>
> Ok. More research is needed to see what is involved, then.
>
> and, unicode nsis is not shipped in most common Linux repo (you need to
>> install it separately).
>>
>
> Indeed, that was my impression. So far I've only seen NSIS 2.46 or so in
> the distribution repositories, and the link I provided talked about NSIS
> 3.0b or something.
>
> taking the above into account, I think, I should repack the above
>> packages as "makensis3" instead of "makensis".
>>
>
> You mean creating deb/rpm packages for updated NSIS? I think manually
> installing updated NSIS would be good enough, if repackaging proves to be
> too much of an effort.
>

I investigated Fedora (we use CentOS/Fedora) and Debian world.
as for Fedora, it is far from being ready (I'll take care of that)

as for Debian, there's http://deb.debian.org/debian/pool/main/n/nsis/
so, I installed ubuntu 16.04, added "debian experimental" (the above repo),
and voila, I compiled openvpn installer.

I think we can move to unicode nsis right after 2.4



>
>
>> @mattock, which linux distro do you use for release building ?
>>
>
> Right now Ubuntu 14.04, but I should upgrade to 16.04 soon.
>
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

--089e0102e3da68bfc70543701fb8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-12-02 11:55 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a target=3D"_blank" href=3D"mailto:samuli@...515...">samuli@...515...</a>&g=
t;</span>:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><span class=
=3D"gmail-">Il 02/12/2016 05:54, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD ha scritto:<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote">
unicode nsis is different from ansi nsis. for example, nsProcess needs<br>
different dll.<br>
</blockquote>
<br></span>
Ok. More research is needed to see what is involved, then.<span class=3D"gm=
ail-"><br>
<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote">
and, unicode nsis is not shipped in most common Linux repo (you need to<br>
install it separately).<br>
</blockquote>
<br></span>
Indeed, that was my impression. So far I&#39;ve only seen NSIS 2.46 or so i=
n the distribution repositories, and the link I provided talked about NSIS =
3.0b or something.<span class=3D"gmail-"><br>
<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote">
taking the above into account, I think, I should repack the above<br>
packages as &quot;makensis3&quot; instead of &quot;makensis&quot;.<br>
</blockquote>
<br></span>
You mean creating deb/rpm packages for updated NSIS? I think manually insta=
lling updated NSIS would be good enough, if repackaging proves to be too mu=
ch of an effort.<span class=3D"gmail-"><br></span></blockquote><div><br></d=
iv><div>I investigated Fedora (we use CentOS/Fedora) and Debian world.<br><=
/div><div>as for Fedora, it is far from being ready (I&#39;ll take care of =
that)<br><br></div><div>as for Debian, there&#39;s <a target=3D"_blank" rel=
=3D"noreferrer" href=3D"http://deb.debian.org/debian/pool/main/n/nsis/">htt=
p://deb.debian.org/debian/<wbr>pool/main/n/nsis/</a><br></div><div>so, I in=
stalled ubuntu 16.04, added &quot;debian experimental&quot; (the above repo=
), and voila, I compiled openvpn installer.<br><br></div><div>I think we ca=
n move to unicode nsis right after 2.4<br></div><div><br></div><div>=C2=A0<=
/div><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex" class=3D"gmail_quote"><span class=3D"gmail=
-">
<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote">
<br>
@mattock, which linux distro do you use for release building ?<br>
</blockquote>
<br></span>
Right now Ubuntu 14.04, but I should upgrade to 16.04 soon.<div class=3D"gm=
ail-HOEnZb"><div class=3D"gmail-h5"><br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</div></div></blockquote></div><br></div></div>

--089e0102e3da68bfc70543701fb8--

