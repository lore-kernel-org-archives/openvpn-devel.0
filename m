MIME-Version: 1.0
In-Reply-To: <20110226104526.GT9835@...1296...>
References: <AANLkTikHd0G_8-JAkXTojetsG7-w5TV3j9fdUwx309A+@mail.gmail.com>
	<20110226104526.GT9835@...1296...>
Date: Sat, 26 Feb 2011 11:19:19 +0000
Message-ID: <AANLkTik-vCrO=yQW7FNiUXyrXfKjNe-3Dq4aGUkHsfT5@...278...>
From: Olivier Van Acker <cyberroadie@...277...>
Content-Type: multipart/alternative; boundary=000e0cd2dcec2e68f2049d2d9e92
Subject: Re: [Openvpn-devel] sctp in openvpn
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

--000e0cd2dcec2e68f2049d2d9e92
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the quick reply,


>
> I would find that a useful thing, but admit that I have only theoretical
> knowledge about SCTP (and have no time to work on it).
>
>
I've been reading up on SCTP and making test apps with it, I'm also in
contact
with Randy Stewart who is the main person behind the spec and Michael
Tuexen
who's done a lot of research on it, both are very helpful.
I won't say I'm an expert but I think I know my way around and I'll be happy
to give it a serious try.



> The code parts in question inside OpenVPN (socket.c) are somewhat
> complicated due to lots of existing options and lots of existing
> operating systems being supported, so this will not be a trivial
> task.
>
>
Would it be a good idea to limit the scope of this project by concentrating
on
one OS first? I was thinking FreeBSD first since that contains the
reference
implementation of SCTP.




> What I'd definitely recommend to do is base your work on JJO's IPv6
> transport patches, because he already changed large parts of socket.c
> - so if you base your work on "plain 2.2", there will be endless conflict=
s.
>
>
Yes, I'll have a closer look at the IPv6 work.



> functionality to listen on multiple sockets in parallel,


This is somethings SCTP has build in.
One SCTP association (connection over one or more nodes) can contain
multiple independent data streams.


Regards,


Olivier






>


> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                           //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>



--=20
=93If you know what you're doing, three layers is enough; if you don't, even
seventeen levels won't help=94. ~ Padlipsky

--000e0cd2dcec2e68f2049d2d9e92
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><div>Hi,</div><div><br></div><div>Thanks for the=
 quick reply,</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><div class=
=3D"im">

<br>
</div>I would find that a useful thing, but admit that I have only theoreti=
cal<br>
knowledge about SCTP (and have no time to work on it).<br>
<br></blockquote><div><br></div><div>I&#39;ve been reading up on SCTP and m=
aking test apps with it, I&#39;m also in contact=A0</div><div>with Randy St=
ewart who is the main person behind the spec and Michael Tuexen=A0</div><di=
v>
who&#39;s done a lot of research on it, both are very helpful.=A0</div><div=
>I won&#39;t say I&#39;m an expert but I think I know my way around and I&#=
39;ll be happy</div><div>to give it a serious try.</div><div><br></div><div>
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex;">
The code parts in question inside OpenVPN (socket.c) are somewhat<br>
complicated due to lots of existing options and lots of existing<br>
operating systems being supported, so this will not be a trivial<br>
task.<br>
<br></blockquote><div><br></div><div>Would it be a good idea to limit the s=
cope of this project by concentrating on=A0</div><div>one OS first? I was t=
hinking FreeBSD first since that contains the reference=A0</div><div>implem=
entation of SCTP.</div>
<div><br></div><div><br></div><div>=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
What I&#39;d definitely recommend to do is base your work on JJO&#39;s IPv6=
<br>
transport patches, because he already changed large parts of socket.c<br>
- so if you base your work on &quot;plain 2.2&quot;, there will be endless =
conflicts.<br>
<br></blockquote><div><br></div><div>Yes, I&#39;ll have a closer look=A0at =
the IPv6 work.=A0</div><div><br></div><div>=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex;">

functionality to listen on multiple sockets in parallel, </blockquote><div>=
<br></div><div>This is somethings SCTP has build in.=A0</div><div>One SCTP =
association (connection over one or more nodes) can contain=A0</div><div>mu=
ltiple independent data streams.=A0</div>
<div><br></div><div><br></div><div>Regards,</div><div><br></div><div><br></=
div><div>Olivier</div><div><br></div><div><br></div><div><br></div><div><br=
></div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex;">
<br>
gert<br>
<font color=3D"#888888"><br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //<a href=3D"http://www.muc.de/=
~gert/" target=3D"_blank">www.muc.de/~gert/</a><br>
Gert Doering - Munich, Germany =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 <a href=3D"mailto:gert@...1296...">gert@...1296...</a><br>
fax: +49-89-35655025 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<a href=
=3D"mailto:gert@...1297...">gert@...1297...</a><br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>=93If you know w=
hat you&#39;re doing, three layers is enough; if you don&#39;t, even sevent=
een levels won&#39;t help=94. ~ Padlipsky<br>

--000e0cd2dcec2e68f2049d2d9e92--

