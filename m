MIME-Version: 1.0
In-Reply-To: <20141023211259.GV396@...1296...>
References: <CAAA5faEk-YSopL-9L=cWzpcfwk96r+utbWEWuO_=L0=jjvYzRg@...278...>
	<20141023192811.GU396@...1296...>
	<CAAA5faFxpQnb7pNd1tSZisVfkGdD4d0xzLBwzwt5acstNfRe0w@...278...>
	<20141023211259.GV396@...1296...>
Date: Thu, 23 Oct 2014 15:42:54 -0600
Message-ID: <CAAA5faFzhCkqxe4j24C25b8JaLSgj2HeD5s2i31Em-UQOPURAg@...278...>
From: Reinoud Koornstra <reinoudkoornstra@...277...>
Content-Type: multipart/alternative; boundary=001a1139c4ec6aa81e05061df296
Subject: Re: [Openvpn-devel] man page and options.c contradict
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

--001a1139c4ec6aa81e05061df296
Content-Type: text/plain; charset=UTF-8

Ok, clear, to TCP cannot be used in point to point mode (p2p) then, because
in case of tcp we must have a client and a server?
Inside the tun or tap interface, can we specify the protocol and port
number used for any communications inside the tun/tcp interface or do we
allow any protocol/port for communication inside the tun/tap device?
Thanks,

Reinoud.


On Thu, Oct 23, 2014 at 3:12 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Thu, Oct 23, 2014 at 02:04:10PM -0600, Reinoud Koornstra wrote:
> > In my understanding, there is no client or server in p2p mode.
>
> True, as far as the OpenVPN protocol is concerned.
>
> False, as far as TCP is concerned, because you MUST have a client and a
> server in TCP - it's not a symmetric protocol (unlike UDP).
>
> So, OpenVPN in peer-to-peer mode will need --tcp-client on one side and
> --tcp-server on the other (it doesn't matter which one is which, as
> as soon as the TCP connection is up, it's "peer to peer" inside)
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

--001a1139c4ec6aa81e05061df296
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ok, clear, to TCP cannot be used in point to point mode (p=
2p) then, because in case of tcp we must have a client and a server?<div>In=
side the tun or tap interface, can we specify the protocol and port number =
used for any communications inside the tun/tcp interface or do we allow any=
 protocol/port for communication inside the tun/tap device?</div><div>Thank=
s,</div><div><br></div><div>Reinoud.</div><div><br></div></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Oct 23, 2014 at 3:1=
2 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..."=
 target=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">Hi,<br>
<span class=3D""><br>
On Thu, Oct 23, 2014 at 02:04:10PM -0600, Reinoud Koornstra wrote:<br>
&gt; In my understanding, there is no client or server in p2p mode.<br>
<br>
</span>True, as far as the OpenVPN protocol is concerned.<br>
<br>
False, as far as TCP is concerned, because you MUST have a client and a<br>
server in TCP - it&#39;s not a symmetric protocol (unlike UDP).<br>
<br>
So, OpenVPN in peer-to-peer mode will need --tcp-client on one side and<br>
--tcp-server on the other (it doesn&#39;t matter which one is which, as<br>
as soon as the TCP connection is up, it&#39;s &quot;peer to peer&quot; insi=
de)<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
gert<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/~gert/" target=3D"_blank">www.muc.de/~gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: <a href=3D"tel:%2B49-89-35655025" value=3D"+498935655025">+49-89-35655=
025</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...1297...</a><br>
</div></div></blockquote></div><br></div>

--001a1139c4ec6aa81e05061df296--

