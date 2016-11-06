MIME-Version: 1.0
In-Reply-To: <CAKuzo_j7MrpLuAgyqVGBTCOsrKVbeTr_mUrUZb_V+dmEUyeOnQ@...278...>
References: <CAFHpkQHcvOUPM_w+i+J61_aoJmFeh8FfVSJhTE8qrrxYJbL98w@...278...>
	<CAKuzo_j7MrpLuAgyqVGBTCOsrKVbeTr_mUrUZb_V+dmEUyeOnQ@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 6 Nov 2016 22:53:30 +0500
Message-ID: <CAFHpkQET2AP3kB=5wOb0SYTMK512Or36HiDrsHVazimNRGJz2g@...278...>
Content-Type: multipart/alternative; boundary=001a114b2126da42c10540a59512
Subject: Re: [Openvpn-devel] why do we check "man2html" for win32 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114b2126da42c10540a59512
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-11-06 21:48 GMT+05:00 Selva Nair <selva.nair@...277...>:

>
> On Sun, Nov 6, 2016 at 11:28 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
> wrote:
>
>> Hello,
>>
>> https://github.com/OpenVPN/openvpn/blob/master/configure.ac#L1164
>>
>> but I do not see any reference to it.
>> how is it used ?
>>
>
> In doc/Makefile.am you will find something like
>
> $MAN2HTML < openvpn.8 > openvpn.8.html
>


I forgot to check in case insensitive manner.
nevermind.

it makes sense now.


>
> The resulting .html is copied by windows installer to
> install_location/OpenVPN/doc/
>
> Selva
>

--001a114b2126da42c10540a59512
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-11-06 21:48 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"=
mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><br><div class=
=3D"gmail_extra"><span class=3D"">On Sun, Nov 6, 2016 at 11:28 AM, =D0=98=
=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"=
ltr">&lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_blank">chipitsi=
ne@...277...</a>&gt;</span> wrote:<br></span><div class=3D"gmail_quote"><sp=
an class=3D""><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div><di=
v><div>Hello,<br><br><a href=3D"https://github.com/OpenVPN/openvpn/blob/mas=
ter/configure.ac#L1164" target=3D"_blank">https://github.com/OpenVPN/ope<wb=
r>nvpn/blob/master/configure.ac#<wbr>L1164</a><br><br></div>but I do not se=
e any reference to it.<br></div>how is it used ?<br></div></div></div></blo=
ckquote><div><br></div></span><div>In doc/Makefile.am you will find somethi=
ng like <br></div><div><br>$MAN2HTML &lt; openvpn.8 &gt; openvpn.8.html<br>=
</div></div></div></div></blockquote><div><br><br></div><div>I forgot to ch=
eck in case insensitive manner.<br></div><div>nevermind.<br><br></div><div>=
it makes sense now.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><d=
iv>=C2=A0<br></div><div>The resulting .html is copied by windows installer =
to install_location/OpenVPN/doc/<span class=3D"HOEnZb"><font color=3D"#8888=
88"><br></font></span></div><span class=3D"HOEnZb"><font color=3D"#888888">=
<div>=C2=A0<br></div><div>Selva<br></div></font></span></div></div></div>
</blockquote></div><br></div></div>

--001a114b2126da42c10540a59512--

