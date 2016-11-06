MIME-Version: 1.0
In-Reply-To: <CAFHpkQHcvOUPM_w+i+J61_aoJmFeh8FfVSJhTE8qrrxYJbL98w@...278...>
References: <CAFHpkQHcvOUPM_w+i+J61_aoJmFeh8FfVSJhTE8qrrxYJbL98w@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 6 Nov 2016 11:48:27 -0500
Message-ID: <CAKuzo_j7MrpLuAgyqVGBTCOsrKVbeTr_mUrUZb_V+dmEUyeOnQ@...278...>
Content-Type: multipart/alternative; boundary=94eb2c06cdea6281dd0540a4aead
Subject: Re: [Openvpn-devel] why do we check "man2html" for win32 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c06cdea6281dd0540a4aead
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 6, 2016 at 11:28 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> Hello,
>
> https://github.com/OpenVPN/openvpn/blob/master/configure.ac#L1164
>
> but I do not see any reference to it.
> how is it used ?
>

In doc/Makefile.am you will find something like

$MAN2HTML < openvpn.8 > openvpn.8.html

The resulting .html is copied by windows installer to
install_location/OpenVPN/doc/

Selva

--94eb2c06cdea6281dd0540a4aead
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra">On Sun, Nov 6, 2016 at 11:2=
8 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <=
span dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_bla=
nk">chipitsine@...277...</a>&gt;</span> wrote:<br><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div><div><div>Hello=
,<br><br><a href=3D"https://github.com/OpenVPN/openvpn/blob/master/configur=
e.ac#L1164" target=3D"_blank">https://github.com/OpenVPN/<wbr>openvpn/blob/=
master/configure.<wbr>ac#L1164</a><br><br></div>but I do not see any refere=
nce to it.<br></div>how is it used ?<br></div></div></div></blockquote><div=
><br></div><div>In doc/Makefile.am you will find something like <br></div><=
div><br>$MAN2HTML &lt; openvpn.8 &gt; openvpn.8.html<br>=C2=A0<br></div><di=
v>The resulting .html is copied by windows installer to install_location/Op=
enVPN/doc/<br></div><div>=C2=A0<br></div><div>Selva<br></div></div></div></=
div>

--94eb2c06cdea6281dd0540a4aead--

