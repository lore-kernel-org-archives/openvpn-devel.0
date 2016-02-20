MIME-Version: 1.0
In-Reply-To: <CAA1AbxKUVKQsbvd9dLLkRcfvbqd6Cjta6TXLJzL=7aFQr-ZW=g@...278...>
References: <CAP=zTkOduThZFBXdewpYv1RQyi9z0Hzaz6MPuRXSt5HkbMTewQ@...278...>
	<20160219173709.GB24952@...1296...>
	<CAP=zTkPPiPO6EPDM1bjM-cBOZ40ikC5GvbcijkXBcb=GepMZ9w@...278...>
	<20160220081721.GD24952@...1296...>
	<CAA1AbxKUVKQsbvd9dLLkRcfvbqd6Cjta6TXLJzL=7aFQr-ZW=g@...278...>
Date: Sat, 20 Feb 2016 10:08:54 +0100
Message-ID: <CAA1AbxJ1RX4JQyB4ndm1i1-EaKWWZqbM_7hTiU_7iNAAqLofUw@...278...>
From: Steffan Karger <steffan@...1856...>
Content-Type: multipart/alternative; boundary=001a11409402f8fc94052c2ff256
Subject: Re: [Openvpn-devel] Enabling TLS Session Resumption in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a11409402f8fc94052c2ff256
Content-Type: text/plain; charset=UTF-8

On 20 Feb 2016 10:03 am, "Steffan Karger" <steffan@...1856...> wrote:
> On 20 Feb 2016 9:19 am, "Gert Doering" <gert@...1296...> wrote:
> > On Sat, Feb 20, 2016 at 11:40:28AM +0530, Shubham Chauhan wrote:
> > > the --float option seems to be interesting!
> > >
> > > Help me understand one scenario.
> > > If I want to transfer a VPN session from one VPN server to another,
keeping
> > > the same openvpn process running at the client side, then will the
> > > "--float" option help? If not float, then is there any other method?
> >
> > Floating in TLS client/server mode will only cover clients that move
> > to a new IP address (NAT timeout, wifi/3G roaming, ...)
> >
> > Roaming to a new server needs a full TLS handshake.
>
> Not just the TLS handshake, but also the OpenVPN handshake to set up IPs,
routing, etc.  OpenVPN does not support any of that currently, afaik.

Sorry, this wording is a bit confusing.  Written on the phone and hit send
too quickly.

OpenVPN does not support any roaming between servers *while keeping state*.

-Steffan

--001a11409402f8fc94052c2ff256
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On 20 Feb 2016 10:03 am, &quot;Steffan Karger&quot; &lt;<a href=3D"mailto:s=
teffan@...1856...">steffan@...1856...</a>&gt; wrote:<br>
&gt; On 20 Feb 2016 9:19 am, &quot;Gert Doering&quot; &lt;<a href=3D"mailto=
:gert@...1296...">gert@...1296...</a>&gt; wrote:<br>
&gt; &gt; On Sat, Feb 20, 2016 at 11:40:28AM +0530, Shubham Chauhan wrote:<=
br>
&gt; &gt; &gt; the --float option seems to be interesting!<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Help me understand one scenario.<br>
&gt; &gt; &gt; If I want to transfer a VPN session from one VPN server to a=
nother, keeping<br>
&gt; &gt; &gt; the same openvpn process running at the client side, then wi=
ll the<br>
&gt; &gt; &gt; &quot;--float&quot; option help? If not float, then is there=
 any other method?<br>
&gt; &gt;<br>
&gt; &gt; Floating in TLS client/server mode will only cover clients that m=
ove<br>
&gt; &gt; to a new IP address (NAT timeout, wifi/3G roaming, ...)<br>
&gt; &gt;<br>
&gt; &gt; Roaming to a new server needs a full TLS handshake.<br>
&gt;<br>
&gt; Not just the TLS handshake, but also the OpenVPN handshake to set up I=
Ps, routing, etc.=C2=A0 OpenVPN does not support any of that currently, afa=
ik.</p>
<p dir=3D"ltr">Sorry, this wording is a bit confusing.=C2=A0 Written on the=
 phone and hit send too quickly. </p>
<p dir=3D"ltr">OpenVPN does not support any roaming between servers *while =
keeping state*. </p>
<p dir=3D"ltr">-Steffan</p>

--001a11409402f8fc94052c2ff256--

