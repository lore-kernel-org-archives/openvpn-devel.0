MIME-Version: 1.0
In-Reply-To: <20160629081109.GU78279@...1296...>
References: <CAFHpkQGrube6hF3+hab3NdNhcifjV15ZSefdUWCcXJPg_CApKw@...278...>
	<20160629081109.GU78279@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 29 Jun 2016 13:57:14 +0500
Message-ID: <CAFHpkQGD10-N=fX6osaMKE4SN+S55A8EN+8byw6aTM9Aosd1Mw@...278...>
Content-Type: multipart/alternative; boundary=047d7b5d4fc2995e88053666f008
Subject: Re: [Openvpn-devel] git master: no more WinXP ?
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

--047d7b5d4fc2995e88053666f008
Content-Type: text/plain; charset=UTF-8

ok, if so, we need to modify installer to detect that.

2016-06-29 13:11 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Wed, Jun 29, 2016 at 01:05:17PM +0500, ???????? ?????????????? wrote:
> > I'm trying to install openvpn git master on WinXP, no luck, it complains
> on
> > missing fwpuclnt.dll
> >
> > there's no such dll in WinXP (and it is not possible to supply dll within
> > installer)
> >
> >
> https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/Makefile.am#L130
> >
> > however, I do not see, where it is called in code.
> > what is it for ?
>
> XP is no longer supported by git master / 2.4
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>

--047d7b5d4fc2995e88053666f008
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ok, if so, we need to modify installer to detect that.<br>=
</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-06-29 =
13:11 GMT+05:00 Gert Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...220...=
..1296..." target=3D"_blank">gert@...1296...</a>&gt;</span>:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Wed, Jun 29, 2016 at 01:05:17PM +0500, ???????? ?????????????? wrote:<br>
&gt; I&#39;m trying to install openvpn git master on WinXP, no luck, it com=
plains on<br>
&gt; missing fwpuclnt.dll<br>
&gt;<br>
&gt; there&#39;s no such dll in WinXP (and it is not possible to supply dll=
 within<br>
&gt; installer)<br>
&gt;<br>
&gt; <a href=3D"https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/=
Makefile.am#L130" rel=3D"noreferrer" target=3D"_blank">https://github.com/O=
penVPN/openvpn/blob/master/src/openvpn/Makefile.am#L130</a><br>
&gt;<br>
&gt; however, I do not see, where it is called in code.<br>
&gt; what is it for ?<br>
<br>
</span>XP is no longer supported by git master / 2.4<br>
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
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...1826...=
7...</a><br>
</font></span></blockquote></div><br></div>

--047d7b5d4fc2995e88053666f008--

