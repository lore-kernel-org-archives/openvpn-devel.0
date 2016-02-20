MIME-Version: 1.0
In-Reply-To: <CAA1AbxKUVKQsbvd9dLLkRcfvbqd6Cjta6TXLJzL=7aFQr-ZW=g@...278...>
References: <CAP=zTkOduThZFBXdewpYv1RQyi9z0Hzaz6MPuRXSt5HkbMTewQ@...278...>
	<20160219173709.GB24952@...1296...>
	<CAP=zTkPPiPO6EPDM1bjM-cBOZ40ikC5GvbcijkXBcb=GepMZ9w@...278...>
	<20160220081721.GD24952@...1296...>
	<CAA1AbxKUVKQsbvd9dLLkRcfvbqd6Cjta6TXLJzL=7aFQr-ZW=g@...278...>
Date: Sat, 20 Feb 2016 14:42:11 +0530
Message-ID: <CAP=zTkM0VQv4UZ=G8mpGjs+GRKF4YzXzxAHyYDvDqiDgRorU_g@...278...>
From: Shubham Chauhan <shubham13099@...2124...>
Content-Type: multipart/alternative; boundary=001a114020bab31240052c2ffe13
Subject: Re: [Openvpn-devel] Enabling TLS Session Resumption in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--001a114020bab31240052c2ffe13
Content-Type: text/plain; charset=UTF-8

I read that Openvpn is a peer to peer application. The so called client
server roles are only for the TLS negotiations and setting up the TLS
channel.
That's why my main focus was on TLS handshake.
I need that roaming at the server end. The single client multi server (1
server at a time) kind of an implementation.
On Feb 20, 2016 2:33 PM, "Steffan Karger" <steffan@...1856...> wrote:

>
> On 20 Feb 2016 9:19 am, "Gert Doering" <gert@...1296...> wrote:
> > On Sat, Feb 20, 2016 at 11:40:28AM +0530, Shubham Chauhan wrote:
> > > the --float option seems to be interesting!
> > >
> > > Help me understand one scenario.
> > > If I want to transfer a VPN session from one VPN server to another,
> keeping
> > > the same openvpn process running at the client side, then will the
> > > "--float" option help? If not float, then is there any other method?
> >
> > Floating in TLS client/server mode will only cover clients that move
> > to a new IP address (NAT timeout, wifi/3G roaming, ...)
> >
> > Roaming to a new server needs a full TLS handshake.
>
> Not just the TLS handshake, but also the OpenVPN handshake to set up IPs,
> routing, etc.  OpenVPN does not support any of that currently, afaik.
>
> I think the TLS handshake is the least of your worries.  Making roaming
> between servers work at all is the hard part.
>
> -Steffan
>

--001a114020bab31240052c2ffe13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I read that Openvpn is a peer to peer application. The so ca=
lled client server roles are only for the TLS negotiations and setting up t=
he TLS channel. <br>
That&#39;s why my main focus was on TLS handshake. <br>
I need that roaming at the server end. The single client multi server (1 se=
rver at a time) kind of an implementation. </p>
<div class=3D"gmail_quote">On Feb 20, 2016 2:33 PM, &quot;Steffan Karger&qu=
ot; &lt;<a href=3D"mailto:steffan@...1856...">steffan@...1856...</a>&gt; wr=
ote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><p dir=3D"ltr">=
<br>
On 20 Feb 2016 9:19 am, &quot;Gert Doering&quot; &lt;<a href=3D"mailto:gert=
@...1296..." target=3D"_blank">gert@...1296...</a>&gt; wrote:<br>
&gt; On Sat, Feb 20, 2016 at 11:40:28AM +0530, Shubham Chauhan wrote:<br>
&gt; &gt; the --float option seems to be interesting!<br>
&gt; &gt;<br>
&gt; &gt; Help me understand one scenario.<br>
&gt; &gt; If I want to transfer a VPN session from one VPN server to anothe=
r, keeping<br>
&gt; &gt; the same openvpn process running at the client side, then will th=
e<br>
&gt; &gt; &quot;--float&quot; option help? If not float, then is there any =
other method?<br>
&gt;<br>
&gt; Floating in TLS client/server mode will only cover clients that move<b=
r>
&gt; to a new IP address (NAT timeout, wifi/3G roaming, ...)<br>
&gt;<br>
&gt; Roaming to a new server needs a full TLS handshake.</p>
<p dir=3D"ltr">Not just the TLS handshake, but also the OpenVPN handshake t=
o set up IPs, routing, etc.=C2=A0 OpenVPN does not support any of that curr=
ently, afaik.</p>
<p dir=3D"ltr">I think the TLS handshake is the least of your worries.=C2=
=A0 Making roaming between servers work at all is the hard part.</p>
<p dir=3D"ltr">-Steffan</p>
</blockquote></div>

--001a114020bab31240052c2ffe13--

