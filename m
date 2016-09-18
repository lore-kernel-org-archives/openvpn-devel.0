MIME-Version: 1.0
In-Reply-To: <20160917135806.GU78279@...1296...>
References: <20160917132024.12570-1-gert@...1296...>
	<CAFHpkQFN16Ah4woE5uGh=Hp4vjBCu2cROAN-wAZVivZHtEDoGg@...278...>
	<CAFHpkQHNCis9UVV_P=sTCV2+u2op_yuS8_UApzW2NKRoJHzMiw@...278...>
	<20160917135806.GU78279@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 18 Sep 2016 16:49:38 +0500
Message-ID: <CAFHpkQFogS3ucZmngANRPQ7QcwxkDqcTjY3+js6xKtCSPb-hig@...278...>
Content-Type: multipart/alternative; boundary=001a1136276451f1b8053cc6ca60
Subject: Re: [Openvpn-devel] [PATCH] Fix win32 building with C99 mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1136276451f1b8053cc6ca60
Content-Type: text/plain; charset=UTF-8

we already run openvpn/openvpn-build in travis.
build only is not complicated.

there are minor issues with 14.04 mingw gcc, which is too old for openvpn
master. I'll make patch after I will resolve it.

2016-09-17 18:58 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
> On Sat, Sep 17, 2016 at 06:40:00PM +0500, ???????? ?????????????? wrote:
> > Should we add mingw compiler to travis-ci matrix?
>
> If travis can do mingw builds, that would be good.
>
> But it is complicated.
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025                        gert@...1816...
> muenchen.de
>

--001a1136276451f1b8053cc6ca60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>we already run openvpn/openvpn-build in travis.<=
br></div>build only is not complicated.<br><br></div>there are minor issues=
 with 14.04 mingw gcc, which is too old for openvpn master. I&#39;ll make p=
atch after I will resolve it.<br></div><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote">2016-09-17 18:58 GMT+05:00 Gert Doering <span dir=3D"=
ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1725...=
..</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
On Sat, Sep 17, 2016 at 06:40:00PM +0500, ???????? ?????????????? wrote:<br>
&gt; Should we add mingw compiler to travis-ci matrix?<br>
<br>
If travis can do mingw builds, that would be good.<br>
<br>
But it is complicated.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
gert<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/~gert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de/~=
gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...2165...=
6...<wbr>muenchen.de</a><br>
</font></span></blockquote></div><br></div>

--001a1136276451f1b8053cc6ca60--

