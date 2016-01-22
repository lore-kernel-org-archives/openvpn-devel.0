MIME-Version: 1.0
In-Reply-To: <20160122120535.GZ24952@...1296...>
References: <CAPTYJtutoE8LzyiROqu3Vzar6LVfUjbdNh-q+3tMB6Pa7FQJgw@...278...>
	<CAPTYJttd0dwGui5kcgBmD-ROv+C=X7gpJ1UVFQcs7AoWvm7Czg@...278...>
	<20160122120535.GZ24952@...1296...>
Date: Fri, 22 Jan 2016 20:17:00 +0800
Message-ID: <CAPTYJtsXVyuHOu7N=z0uxQWtUkokD9esjksH0zm9LyAPbNB9hw@...278...>
From: Daniel Sim <daniel.ssq89@...277...>
Content-Type: multipart/alternative; boundary=089e01538c3c45753c0529eb324f
Subject: Re: [Openvpn-devel] Rewrite of OpenVPNServ.exe
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--089e01538c3c45753c0529eb324f
Content-Type: text/plain; charset=UTF-8

Yes you can!

The package can be compiled using Mono once you have the correct libraries
installed:

Building on Linux

This package can be built under Linux.

On Ubuntu 14.04, you need the following packages and their dependencies:

   - mono-xbuild
   - libmono-microsoft-build-tasks-v4.0-4.0-cil
   - libmono-system-serviceprocess4.0-cil
   - libmono-system-management4.0-cil

A simple xbuild /p:Configuration=Release /p:Platform=AnyCPU
OpenVPNService.sln should be sufficient to generate the binaries.

On Fri, Jan 22, 2016 at 8:05 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Fri, Jan 22, 2016 at 07:31:37PM +0800, Daniel Sim wrote:
> > I have rewritten openvpnserv.exe in C# to support auto-restart on
> > termination and to support suspend/resume.
>
> Can you cross-build C# binaries?  If yes, what do you need?
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

--089e01538c3c45753c0529eb324f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8px">Yes you can!</span><div s=
tyle=3D"font-size:12.8px"><br></div><div style=3D"font-size:12.8px">The pac=
kage can be compiled using Mono once you have the correct libraries install=
ed:</div><div style=3D"font-size:12.8px"><br></div><div style=3D"font-size:=
12.8px"><h2 style=3D"margin-top:1em;margin-bottom:16px;line-height:1.225;fo=
nt-size:1.75em;padding-bottom:0.3em;border-bottom-width:1px;border-bottom-s=
tyle:solid;border-bottom-color:rgb(238,238,238);color:rgb(51,51,51);font-fa=
mily:&#39;Helvetica Neue&#39;,Helvetica,&#39;Segoe UI&#39;,Arial,freesans,s=
ans-serif,&#39;Apple Color Emoji&#39;,&#39;Segoe UI Emoji&#39;,&#39;Segoe U=
I Symbol&#39;">Building on Linux</h2><p style=3D"margin-top:0px;margin-bott=
om:16px;color:rgb(51,51,51);font-family:&#39;Helvetica Neue&#39;,Helvetica,=
&#39;Segoe UI&#39;,Arial,freesans,sans-serif,&#39;Apple Color Emoji&#39;,&#=
39;Segoe UI Emoji&#39;,&#39;Segoe UI Symbol&#39;;font-size:16px;line-height=
:25.6px">This package can be built under Linux.</p><p style=3D"margin-top:0=
px;margin-bottom:16px;color:rgb(51,51,51);font-family:&#39;Helvetica Neue&#=
39;,Helvetica,&#39;Segoe UI&#39;,Arial,freesans,sans-serif,&#39;Apple Color=
 Emoji&#39;,&#39;Segoe UI Emoji&#39;,&#39;Segoe UI Symbol&#39;;font-size:16=
px;line-height:25.6px">On Ubuntu 14.04, you need the following packages and=
 their dependencies:</p><ul style=3D"padding:0px 0px 0px 2em;margin-top:0px=
;margin-bottom:16px;color:rgb(51,51,51);font-family:&#39;Helvetica Neue&#39=
;,Helvetica,&#39;Segoe UI&#39;,Arial,freesans,sans-serif,&#39;Apple Color E=
moji&#39;,&#39;Segoe UI Emoji&#39;,&#39;Segoe UI Symbol&#39;;font-size:16px=
;line-height:25.6px"><li style=3D"margin-left:15px"><code style=3D"font-fam=
ily:Consolas,&#39;Liberation Mono&#39;,Menlo,Courier,monospace;font-size:13=
.6px;padding:0.2em 0px;margin:0px;border-radius:3px;background-color:rgba(0=
,0,0,0.0392157)">mono-xbuild</code></li><li style=3D"margin-left:15px"><cod=
e style=3D"font-family:Consolas,&#39;Liberation Mono&#39;,Menlo,Courier,mon=
ospace;font-size:13.6px;padding:0.2em 0px;margin:0px;border-radius:3px;back=
ground-color:rgba(0,0,0,0.0392157)">libmono-microsoft-build-tasks-v4.0-4.0-=
cil</code></li><li style=3D"margin-left:15px"><code style=3D"font-family:Co=
nsolas,&#39;Liberation Mono&#39;,Menlo,Courier,monospace;font-size:13.6px;p=
adding:0.2em 0px;margin:0px;border-radius:3px;background-color:rgba(0,0,0,0=
.0392157)">libmono-system-serviceprocess4.0-cil</code></li><li style=3D"mar=
gin-left:15px"><code style=3D"font-family:Consolas,&#39;Liberation Mono&#39=
;,Menlo,Courier,monospace;font-size:13.6px;padding:0.2em 0px;margin:0px;bor=
der-radius:3px;background-color:rgba(0,0,0,0.0392157)">libmono-system-manag=
ement4.0-cil</code></li></ul><p style=3D"margin-top:0px;color:rgb(51,51,51)=
;font-family:&#39;Helvetica Neue&#39;,Helvetica,&#39;Segoe UI&#39;,Arial,fr=
eesans,sans-serif,&#39;Apple Color Emoji&#39;,&#39;Segoe UI Emoji&#39;,&#39=
;Segoe UI Symbol&#39;;font-size:16px;line-height:25.6px;margin-bottom:0px!i=
mportant">A simple=C2=A0<code style=3D"font-family:Consolas,&#39;Liberation=
 Mono&#39;,Menlo,Courier,monospace;font-size:13.6px;padding:0.2em 0px;margi=
n:0px;border-radius:3px;background-color:rgba(0,0,0,0.0392157)">xbuild /p:C=
onfiguration=3DRelease /p:Platform=3DAnyCPU OpenVPNService.sln</code>=C2=A0=
should be sufficient to generate the binaries.</p></div></div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Jan 22, 2016 at 8:05 P=
M, Gert Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." ta=
rget=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi,<br>
<span class=3D""><br>
On Fri, Jan 22, 2016 at 07:31:37PM +0800, Daniel Sim wrote:<br>
&gt; I have rewritten openvpnserv.exe in C# to support auto-restart on<br>
&gt; termination and to support suspend/resume.<br>
<br>
</span>Can you cross-build C# binaries?=C2=A0 If yes, what do you need?<br>
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
fax: <a href=3D"tel:%2B49-89-35655025" value=3D"+498935655025">+49-89-35655=
025</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...1297...</a><br>
</font></span></blockquote></div><br></div>

--089e01538c3c45753c0529eb324f--

