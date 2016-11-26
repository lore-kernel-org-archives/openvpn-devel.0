MIME-Version: 1.0
In-Reply-To: <20161121174953.GM28918@...1296...>
References: <CAFHpkQEKrJqNB2ZmhAwKGebVb6SB75HpnWcrw_niSaALL_S4mA@...278...>
	<CAA1AbxJZL70qY=ivMvskeUapj0V_+z_LVnM2Zp2LxAJT4t62vA@...278...>
	<CAFHpkQEnATPgCyxsLW6bpC5Qr-Cdh=+4X4MRXxgUD+orKpq+EQ@...278...>
	<20161121174953.GM28918@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 26 Nov 2016 16:32:48 +0500
Message-ID: <CAFHpkQFZD+hYzq_FW075wQt5AopcyCP20BEDzLsTx5Vq6uko3Q@...278...>
Content-Type: multipart/alternative; boundary=089e0102e3da2db26305423299a1
Subject: Re: [Openvpn-devel] https://travis-ci.org/OpenVPN/openvpn/builds
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

--089e0102e3da2db26305423299a1
Content-Type: text/plain; charset=UTF-8

2016-11-21 22:49 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Mon, Nov 21, 2016 at 10:31:45PM +0500, ???????? ?????????????? wrote:
> > this line
> >
> > https://github.com/OpenVPN/openvpn/blob/master/tests/
> unit_tests/openvpn/Makefile.am#L17
> >
> > causes an error
>
> GNU LD manpage says this is a trick to make it link "another function"
> "--wrap parse_line" would make it link __wrap_parse_line() instead -
> most likely because @d12fk provided a stub function that mocks the
> result (or whatever).
>
> Have not looked into this in more detail.
>

http://www.mockator.com/projects/mockator/wiki/Wrap_Functions

"Alas, this feature is *only available with the GNU tool chain on Linux*.
GCC for Mac OS X does not offer the linker flag -wrap. "

should we skip those tests on osx ? or someone will rewrite them ?

>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/ <http://www.muc.de/%7Egert/>
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025                        gert@...1816...
> muenchen.de
>

--089e0102e3da2db26305423299a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-11-21 22:49 GMT+05:00 Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<span class=3D"gmail-"><br>
On Mon, Nov 21, 2016 at 10:31:45PM +0500, ???????? ?????????????? wrote:<br>
&gt; this line<br>
&gt;<br>
&gt; <a href=3D"https://github.com/OpenVPN/openvpn/blob/master/tests/unit_t=
ests/openvpn/Makefile.am#L17" rel=3D"noreferrer" target=3D"_blank">https://=
github.com/OpenVPN/<wbr>openvpn/blob/master/tests/<wbr>unit_tests/openvpn/M=
akefile.<wbr>am#L17</a><br>
&gt;<br>
&gt; causes an error<br>
<br>
</span>GNU LD manpage says this is a trick to make it link &quot;another fu=
nction&quot;<br>
&quot;--wrap parse_line&quot; would make it link __wrap_parse_line() instea=
d -<br>
most likely because @d12fk provided a stub function that mocks the<br>
result (or whatever).<br>
<br>
Have not looked into this in more detail.<br></blockquote><div><br><a href=
=3D"http://www.mockator.com/projects/mockator/wiki/Wrap_Functions">http://w=
ww.mockator.com/projects/mockator/wiki/Wrap_Functions</a><br><br>&quot;Alas=
, this feature is <strong>only available with the GNU tool chain on Linux</=
strong>. GCC for Mac OS X does not offer the linker flag <code>-wrap</code>=
. &quot;<br><br></div><div>should we skip those tests on osx ? or someone w=
ill rewrite them ?<br> </div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
gert<br>
<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/%7Egert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de=
/~gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...2165...=
6...<wbr>muenchen.de</a><br>
</font></span></blockquote></div><br></div></div>

--089e0102e3da2db26305423299a1--

