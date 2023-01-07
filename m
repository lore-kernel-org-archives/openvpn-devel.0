MIME-Version: 1.0
References: <20230105022718.1641751-1-selva.nair@...277...>
 <CAGyAFMVpquzshk7k9TfBTwTFKRNxBVkunn79TnBd2gpaoZSQwQ@...278...>
 <Y7iCSAacZKc++0bW@...1296...>
 <CAKuzo_ik_xukXb9q+PNd_7wC6X4YPv+J9i2+wTX4488XvepStA@...278...>
 <Y7maAC4v1yUpbeYV@...1296...>
In-Reply-To: <Y7maAC4v1yUpbeYV@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 7 Jan 2023 12:13:07 -0500
Message-ID: <CAKuzo_jYmqVLjYB-+ZEV==HB-EbcWWqBt1RmnrbMc2g=feASJw@...278...>
Content-Type: multipart/alternative; boundary="000000000000ce240705f1afa632"
Subject: Re: [Openvpn-devel] [PATCH 1/3] Use IPAPI for setting ipv6 routes
 when iservice not available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000ce240705f1afa632
Content-Type: text/plain; charset="UTF-8"

On Sat, Jan 7, 2023 at 11:12 AM Gert Doering <gert@...1296...> wrote:

>
>
> > Though I vaguely understand why we set the address with /128 and then set
> > the route for the vpn subnet with fe80::8 as the gateway for
> tap-windows6,
> > wonder why we do this for dco as well.
>
> Let me recap why we do this for tap-windows - for windows, this is always
> an Ethernet adapter, so it wants to always do neighbour discovery (ND),
> IPv6's equivalent of ARP for all "on this interface" addresses.
>
> For "--dev tun" setups, OpenVPN does not want to deal with "Ethernet
> things",
> so the TAP driver replies to ARP requests for "special addresses" - for
> net30, OpenVPN ioctl()'s the "peer" address (which is also the gateway
> address) into the TAP driver, and only this address is replied to -
> admittedly, I do not know how "topology subnet" works wrt virtual ARP,
> need to read up on this again.
>
> For IPv6, I decided that having to deal with ND is easier if I could just
> look at a magic number, namely fe80::8, in the tap driver code - so, we
> use /128 for the ifconfig bit ("no network here, everything is behind the
> gateway") and point all routing to "on this interface, fe80::8" - so for
> whatever IPv6 destination, windows will only do ND for fe80::8, and the
> TAP driver will reply to it, without any further help (ioctl()) from
> OpenVPN.
>

Thanks for the explanation. I had a vague idea that this is done for ND.


>
>
> This said, I have no idea why we do it that way for wintun and DCO -
> most likely because it avoids having to add even more windows-driver-
> specific special case handling in places where we are nicely generic
> today.
>

I guess it works because nexthop is ignored[*] for tun adapters and we
could have just set an onlink route omitting the gateway parameter.

Selva

[*] Any bogus gateway seems to work, but still, "netsh int ipv6 show
neighbours"
lists any such gateway set for dco as initially "Probe" and then
"Unreachable",
so not totally ignored?

--000000000000ce240705f1afa632
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jan 7, 2023 at 11:12 AM Gert =
Doering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1711...=
96...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><br>
<br>
&gt; Though I vaguely understand why we set the address with /128 and then =
set<br>
&gt; the route for the vpn subnet with fe80::8 as the gateway for tap-windo=
ws6,<br>
&gt; wonder why we do this for dco as well.<br>
<br>
Let me recap why we do this for tap-windows - for windows, this is always<b=
r>
an Ethernet adapter, so it wants to always do neighbour discovery (ND),<br>
IPv6&#39;s equivalent of ARP for all &quot;on this interface&quot; addresse=
s.<br>
<br>
For &quot;--dev tun&quot; setups, OpenVPN does not want to deal with &quot;=
Ethernet things&quot;,<br>
so the TAP driver replies to ARP requests for &quot;special addresses&quot;=
 - for<br>
net30, OpenVPN ioctl()&#39;s the &quot;peer&quot; address (which is also th=
e gateway<br>
address) into the TAP driver, and only this address is replied to - <br>
admittedly, I do not know how &quot;topology subnet&quot; works wrt virtual=
 ARP,<br>
need to read up on this again.<br>
<br>
For IPv6, I decided that having to deal with ND is easier if I could just<b=
r>
look at a magic number, namely fe80::8, in the tap driver code - so, we<br>
use /128 for the ifconfig bit (&quot;no network here, everything is behind =
the<br>
gateway&quot;) and point all routing to &quot;on this interface, fe80::8&qu=
ot; - so for<br>
whatever IPv6 destination, windows will only do ND for fe80::8, and the<br>
TAP driver will reply to it, without any further help (ioctl()) from <br>
OpenVPN.<br></blockquote><div><br></div><div>Thanks for the explanation. I =
had a vague idea that this is done for ND.</div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
<br>
This said, I have no idea why we do it that way for wintun and DCO - <br>
most likely because it avoids having to add even more windows-driver-<br>
specific special case handling in places where we are nicely generic<br>
today.<br></blockquote><div><br></div><div>I guess it works because nexthop=
 is ignored[*] for tun adapters and we</div><div>could have just set an onl=
ink route omitting the gateway parameter.</div><div><br></div><div>Selva</d=
iv><div><br></div><div>[*] Any bogus gateway seems to work, but still, &quo=
t;netsh int ipv6 show neighbours&quot;</div><div>lists any such gateway set=
 for dco as initially &quot;Probe&quot; and then &quot;Unreachable&quot;,</=
div><div>so not totally ignored?</div></div></div>

--000000000000ce240705f1afa632--

