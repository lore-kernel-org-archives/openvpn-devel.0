MIME-Version: 1.0
In-Reply-To: <20141024054814.GX396@...1296...>
References: <CAAA5faEk-YSopL-9L=cWzpcfwk96r+utbWEWuO_=L0=jjvYzRg@...278...>
	<20141023192811.GU396@...1296...>
	<CAAA5faFxpQnb7pNd1tSZisVfkGdD4d0xzLBwzwt5acstNfRe0w@...278...>
	<20141023211259.GV396@...1296...>
	<CAAA5faFzhCkqxe4j24C25b8JaLSgj2HeD5s2i31Em-UQOPURAg@...278...>
	<20141024054814.GX396@...1296...>
Date: Fri, 24 Oct 2014 01:04:17 -0600
Message-ID: <CAAA5faFEzEUdfixd5bhTY_9wg49VxCO+ZRWHMtoqJ07g6ouDmA@...278...>
From: Reinoud Koornstra <reinoudkoornstra@...277...>
Content-Type: multipart/alternative; boundary=001a11379cc216a6f9050625ca5f
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

--001a11379cc216a6f9050625ca5f
Content-Type: text/plain; charset=UTF-8

Ok, Thanks.
I understood the term mode wrong.
So the main mode can be p2p or server to denote the openvpn protocol inside
tcp or udp(stateless) session. Initially I thought the term mode is used to
denote server, client or udp.
Hi,

On Thu, Oct 23, 2014 at 03:42:54PM -0600, Reinoud Koornstra wrote:
> Ok, clear, to TCP cannot be used in point to point mode (p2p) then,
because
> in case of tcp we must have a client and a server?

Please READ what I write, so I don't have to repeat it.

TCP imposes an imbalance between the peers (one has to be the listening
and one has to be the connecting instance), but the OpenVPN protocol
*inside*
the TCP session will still be "point to point mode (p2p)"

> Inside the tun or tap interface, can we specify the protocol and port
> number used for any communications inside the tun/tcp interface or do we
> allow any protocol/port for communication inside the tun/tap device?
> Thanks,

tun/tap is just a network interface, so do with it what you want - setup
ip addresses and routing, set up firewalling, set up policy routing, etc. -
OpenVPN won't care, and just transport packets entering the tun/tap
interface to the other side, and deliver to the remote tun/tap interface.

gert
--
USENET is *not* the non-clickable part of WWW!
                                                           //
www.muc.de/~gert/
Gert Doering - Munich, Germany
gert@...1296...
fax: +49-89-35655025
gert@...1297...

--001a11379cc216a6f9050625ca5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Ok, Thanks.<br>
I understood the term mode wrong.<br>
So the main mode can be p2p or server to denote the openvpn protocol inside=
 tcp or udp(stateless) session. Initially I thought the term mode is used t=
o denote server, client or udp.</p>
<div class=3D"gmail_quot&lt;blockquote class=3D" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On Thu, Oct 23, 2014 at 03:42:54PM -0600, Reinoud Koornstra wrote:<br>
&gt; Ok, clear, to TCP cannot be used in point to point mode (p2p) then, be=
cause<br>
&gt; in case of tcp we must have a client and a server?<br>
<br>
Please READ what I write, so I don&#39;t have to repeat it.<br>
<br>
TCP imposes an imbalance between the peers (one has to be the listening<br>
and one has to be the connecting instance), but the OpenVPN protocol *insid=
e*<br>
the TCP session will still be &quot;point to point mode (p2p)&quot;<br>
<br>
&gt; Inside the tun or tap interface, can we specify the protocol and port<=
br>
&gt; number used for any communications inside the tun/tcp interface or do =
we<br>
&gt; allow any protocol/port for communication inside the tun/tap device?<b=
r>
&gt; Thanks,<br>
<br>
tun/tap is just a network interface, so do with it what you want - setup<br>
ip addresses and routing, set up firewalling, set up policy routing, etc. -=
<br>
OpenVPN won&#39;t care, and just transport packets entering the tun/tap<br>
interface to the other side, and deliver to the remote tun/tap interface.<b=
r>
<br>
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
</div>

--001a11379cc216a6f9050625ca5f--

