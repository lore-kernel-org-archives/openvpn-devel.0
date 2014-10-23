MIME-Version: 1.0
In-Reply-To: <20141023192811.GU396@...1296...>
References: <CAAA5faEk-YSopL-9L=cWzpcfwk96r+utbWEWuO_=L0=jjvYzRg@...278...>
	<20141023192811.GU396@...1296...>
Date: Thu, 23 Oct 2014 14:04:10 -0600
Message-ID: <CAAA5faFxpQnb7pNd1tSZisVfkGdD4d0xzLBwzwt5acstNfRe0w@...278...>
From: Reinoud Koornstra <reinoudkoornstra@...277...>
Content-Type: multipart/alternative; boundary=001a11c2019a5295ea05061c9128
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

--001a11c2019a5295ea05061c9128
Content-Type: text/plain; charset=UTF-8

In my understanding, there is no client or server in p2p mode. In this case
you're trying to establish a secure connection between two gateways using
openvpn like a tunnel. Is my understanding wrong about this? Besides this,
I still stumble upon the issue of specifying just tcp in the remote
section, options.c doesn't allow you to do it.
Or am I missing a part where it doesn't allow this in MODE-POINT-TO-POINT?
On Oct 23, 2014 1:28 PM, "Gert Doering" <gert@...1296...> wrote:

> Hi,
>
> On Thu, Oct 23, 2014 at 01:24:45PM -0600, Reinoud Koornstra wrote:
> > The idea in my case is to have a point-to-point connection where both
> hosts
> > listen on port 443 tcp instead of port 1194 udp to setup the
> point-to-point
> > connection.
>
> If both listen, who calls out?  In TCP mode, you need to decide who opens
> the tcp session (tcp-client) and who listens (tcp-server).
>
> In UDP mode, the socket is not "connected" so you can just send packets
> when you feel like it, without having to establish a connection first.
>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>

--001a11c2019a5295ea05061c9128
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">In my understanding, there is no client or server in p2p mod=
e. In this case you&#39;re trying to establish a secure connection between =
two gateways using openvpn like a tunnel. Is my understanding wrong about t=
his? Besides this, I still stumble upon the issue of specifying just tcp in=
 the remote section, options.c doesn&#39;t allow you to do it.<br>
Or am I missing a part where it doesn&#39;t allow this in MODE-POINT-TO-POI=
NT? </p>
<div class=3D"gmail_quote">On Oct 23, 2014 1:28 PM, &quot;Gert Doering&quot=
; &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br =
type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On Thu, Oct 23, 2014 at 01:24:45PM -0600, Reinoud Koornstra wrote:<br>
&gt; The idea in my case is to have a point-to-point connection where both =
hosts<br>
&gt; listen on port 443 tcp instead of port 1194 udp to setup the point-to-=
point<br>
&gt; connection.<br>
<br>
If both listen, who calls out?=C2=A0 In TCP mode, you need to decide who op=
ens<br>
the tcp session (tcp-client) and who listens (tcp-server).<br>
<br>
In UDP mode, the socket is not &quot;connected&quot; so you can just send p=
ackets<br>
when you feel like it, without having to establish a connection first.<br>
<br>
gert<br>
<br>
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
</blockquote></div>

--001a11c2019a5295ea05061c9128--

