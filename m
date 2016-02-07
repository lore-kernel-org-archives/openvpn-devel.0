MIME-Version: 1.0
In-Reply-To: <20160207192752.GZ24952@...1296...>
References: <CAKuzo_gC70Sozt1BZyf6NhMgPi-NpDWR5G-_fcXx0GKk1_JVmg@...278...>
	<CAFHpkQFyVUfK_QLgou0559-MdWn1TD51xda9kf9vYtHuhB6seg@...278...>
	<20160207192752.GZ24952@...1296...>
Date: Mon, 8 Feb 2016 01:12:37 +0500
Message-ID: <CAFHpkQEpOn0OBHVjJjQJPazHw8a+OPncDKt5jJVSi6cKpzkeJQ@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=001a114103b6ab783f052b33b41c
Subject: Re: [Openvpn-devel] GUI repo
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

--001a114103b6ab783f052b33b41c
Content-Type: text/plain; charset=UTF-8

there's still "Start OpenVPN directly"

https://github.com/OpenVPN/openvpn-gui/blob/master/openvpn.c#L724

in such case admin rights are still required for routes manipulation.


maybe we should release two installers (or make a checkbox in installer?)

1) regular mode (with highest priv manifest)
2) paranoya mode (without highest priv)


those who really care will choose whatever they want to


2016-02-08 0:27 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Sun, Feb 07, 2016 at 09:00:28PM +0500, ???????? ?????????????? wrote:
> > if you mean interactive service, keep in mind that people sometimes start
> > openvpn as a child of openvpn-gui, not as a service
>
> Interactive Service is running openvpn.exe under control of openvpn-gui,
> and you won't notice anything different - except that it magically works
> even if the user has no permissions to set routes, and the "want admin!"
> flag is not set on the GUI.
>
> And, of course, that bugs in openvpn-gui or openvpn will not lead to a
> privilege breach anymore.
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

--001a114103b6ab783f052b33b41c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>there&#39;s still &quot;<span class=3D"">Start O=
penVPN directly&quot;</span><br><br><a href=3D"https://github.com/OpenVPN/o=
penvpn-gui/blob/master/openvpn.c#L724">https://github.com/OpenVPN/openvpn-g=
ui/blob/master/openvpn.c#L724</a><br><br></div>in such case admin rights ar=
e still required for routes manipulation.<br><br><br></div><div>maybe we sh=
ould release two installers (or make a checkbox in installer?)<br><br></div=
><div>1) regular mode (with highest priv manifest)<br></div><div>2) paranoy=
a mode (without highest priv)<br><br><br></div><div>those who really care w=
ill choose whatever they want to<br></div><div><br></div></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-02-08 0:27 GMT+05:00 G=
ert Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;</span>:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">Hi,<br>
<span class=3D""><br>
On Sun, Feb 07, 2016 at 09:00:28PM +0500, ???????? ?????????????? wrote:<br>
&gt; if you mean interactive service, keep in mind that people sometimes st=
art<br>
&gt; openvpn as a child of openvpn-gui, not as a service<br>
<br>
</span>Interactive Service is running openvpn.exe under control of openvpn-=
gui,<br>
and you won&#39;t notice anything different - except that it magically work=
s<br>
even if the user has no permissions to set routes, and the &quot;want admin=
!&quot;<br>
flag is not set on the GUI.<br>
<br>
And, of course, that bugs in openvpn-gui or openvpn will not lead to a<br>
privilege breach anymore.<br>
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

--001a114103b6ab783f052b33b41c--

