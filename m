MIME-Version: 1.0
In-Reply-To: <20160813095824.GR78279@...1296...>
References: <1451908945-12244-1-git-send-email-lstipakov@...277...>
	<1451911424-12970-1-git-send-email-lstipakov@...277...>
	<b80eb9b2-1ce0-1f9d-7b76-a877087e10fe@...2080...>
	<20160813095824.GR78279@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 13 Aug 2016 21:50:00 +0300
Message-ID: <CAGyAFMXaMwL+Dnqb1Y0ocap4WwUYKkeCppcVSTWAfb+nr7mxfA@...278...>
Content-Type: multipart/alternative; boundary=001a114d3c845c73c40539f8777a
Subject: Re: [Openvpn-devel] [PATCH v2] Drop recursively routed packets
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

--001a114d3c845c73c40539f8777a
Content-Type: text/plain; charset=UTF-8

Hi,

I could probably add that patch has been in our production for a while
(several months), OS X / Win, works as expected.

-Lev

2016-08-13 12:58 GMT+03:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Fri, Aug 12, 2016 at 08:24:35PM +0200, David Sommerseth wrote:
> > On 04/01/16 13:43, Lev Stipakov wrote:
> > > v2: better method naming
> > >
> > > On certain OSes (Windows, OS X) when network adapter is disabled
> > > (ethernet cable pulled off, Wi-Fi hardware switch disabled),
> > > operating system starts to use tun as an external interface.
> > > Outgoing packets are routed to tun, UDP encapsulated, given to
> > > routing table and sent to.. tun.
> >
> > Can this happen on Linux or *BSD?  Could this recursive routing
> > actually happen at all?
>
> Of course :-) - the moment you lose your external interface, for
> example, because you unplug the network cable and network manager
> deconfigures ip address plus all routes via that interface...
>
> What is left is "routes into the tunnel", so you send the tunneled
> packets into the tunnel again.  Without that patch, this leads to
> "openvpn eats 100% cpu, your VPN is down, and until ping-timeout
> fires, it won't recover and the user has no idea why it is broken".
>
> Very typical problem with routing and tunnels :-)
>
> >
> > > + +      /* skip ipv4 packets for ipv6 tun */ +      if
> > > (tun_sa.addr.sa.sa_family != AF_INET) +        return;
> >
> > [...snip...]
> >
> > > + +      /* skip ipv6 packets for ipv4 tun */ +      if
> > > (tun_sa.addr.sa.sa_family != AF_INET6) +      return;
> >
> > How likely is it that these two checks will hit?  Do we truly need
> > them?
>
> It's quite likely for IPv6 packets to be transported over an IPv4
> tunnel, and vice versa, and will be even *more* likely for the next
> 10 years to come.
>
> So comparing "inside IPv6 address" to "outside IPv4 address" needs
> to be avoided (at best, the code might misfire, at worst, you might
> overrun comparing an IPv6 address to something that has not allocated
> enough bytes) - maybe it can be written more efficient, but in the end
> you always have the "is it the same protocol inside and outside?"
> check, before you go on comparing addresses.
>
> Right now, the code is nicely readable by using the is_ipv4() macro
> etc., but sacrificing this by having a check very early on that
> is the unrolled form of the macro, and basically does
>
>   if ( outside_address_family != inside_address_family ) { return; }
>
> would indeed be more efficient for the mixed-family case.
>
> OTOH, you need another comparison then for "is it IPv4?  is it IPv6?",
> so the overall amount of code for the same-family case might be even
> higher.
>
> OTOH again, is_ipv4() boils down to an amazing amount of code...  so
> moving *that* from proto.c to proto.h and make it an inline function
> (and hope that the compiler will be smart enough to keep track of all
> the then-duplicate checks for is_ipv4() vs. is_ipv6() and just optimize
> it properly) might produce more efficient *and* more readable code :-)
> (and since it's only called in two places ever, the extra code size
> due to inlining isn't big)
>
>
> > I'm basically concerned of the potential cost an extra check
> > adds.  As the link speed increases, such checks will have an impact
> > later on if now.  If truly needed, is it worth looking into providing
> > some branch prediction hints to the compiler?  (unlikely/likely hints)
>
> For the "protocol variants", you can't, because it depends on what
> users do with their tunnels.  Today, they might be predominantly
> IPv4-over-IPv4, while my personal sessions are mostly IPv6-over-IPv4
> already...
>
> > > if (c->c2.buf.len > 0) { +      drop_if_recursive_routing (c,
> > > &c->c2.buf);
> >
> > If this is truly only an issue on Windows and OSX, can we consider to
> > #ifdef the drop_if_recursive_routing() call?
>
> It can happen on all platforms where "inside" and "outside" routing
> (wrt openvpn) happens in the same routing context / namespace / ... and
> "some external entity" can modify the "outside" routing table without
> OpenVPN knowing.  In other words: on all platforms we support today.
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025                        gert@...1816...
> muenchen.de
>



-- 
-Lev

--001a114d3c845c73c40539f8777a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I could probably add that patch has=
 been in our production for a while (several months), OS X / Win, works as =
expected.</div><div><br></div><div>-Lev=C2=A0</div></div><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">2016-08-13 12:58 GMT+03:00 Gert Doe=
ring <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_bl=
ank">gert@...1296...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<=
br>
<span class=3D""><br>
On Fri, Aug 12, 2016 at 08:24:35PM +0200, David Sommerseth wrote:<br>
&gt; On 04/01/16 13:43, Lev Stipakov wrote:<br>
&gt; &gt; v2: better method naming<br>
&gt; &gt;<br>
&gt; &gt; On certain OSes (Windows, OS X) when network adapter is disabled<=
br>
&gt; &gt; (ethernet cable pulled off, Wi-Fi hardware switch disabled),<br>
&gt; &gt; operating system starts to use tun as an external interface.<br>
&gt; &gt; Outgoing packets are routed to tun, UDP encapsulated, given to<br>
&gt; &gt; routing table and sent to.. tun.<br>
&gt;<br>
&gt; Can this happen on Linux or *BSD?=C2=A0 Could this recursive routing<b=
r>
&gt; actually happen at all?<br>
<br>
</span>Of course :-) - the moment you lose your external interface, for<br>
example, because you unplug the network cable and network manager<br>
deconfigures ip address plus all routes via that interface...<br>
<br>
What is left is &quot;routes into the tunnel&quot;, so you send the tunnele=
d<br>
packets into the tunnel again.=C2=A0 Without that patch, this leads to<br>
&quot;openvpn eats 100% cpu, your VPN is down, and until ping-timeout<br>
fires, it won&#39;t recover and the user has no idea why it is broken&quot;=
.<br>
<br>
Very typical problem with routing and tunnels :-)<br>
<span class=3D""><br>
&gt;<br>
&gt; &gt; + +=C2=A0 =C2=A0 =C2=A0 /* skip ipv4 packets for ipv6 tun */ +=C2=
=A0 =C2=A0 =C2=A0 if<br>
&gt; &gt; (tun_sa.addr.sa.sa_family !=3D AF_INET) +=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return;<br>
&gt;<br>
&gt; [...snip...]<br>
&gt;<br>
&gt; &gt; + +=C2=A0 =C2=A0 =C2=A0 /* skip ipv6 packets for ipv4 tun */ +=C2=
=A0 =C2=A0 =C2=A0 if<br>
&gt; &gt; (tun_sa.addr.sa.sa_family !=3D AF_INET6) +=C2=A0 =C2=A0 =C2=A0 re=
turn;<br>
&gt;<br>
&gt; How likely is it that these two checks will hit?=C2=A0 Do we truly nee=
d<br>
&gt; them?<br>
<br>
</span>It&#39;s quite likely for IPv6 packets to be transported over an IPv=
4<br>
tunnel, and vice versa, and will be even *more* likely for the next<br>
10 years to come.<br>
<br>
So comparing &quot;inside IPv6 address&quot; to &quot;outside IPv4 address&=
quot; needs<br>
to be avoided (at best, the code might misfire, at worst, you might<br>
overrun comparing an IPv6 address to something that has not allocated<br>
enough bytes) - maybe it can be written more efficient, but in the end<br>
you always have the &quot;is it the same protocol inside and outside?&quot;=
<br>
check, before you go on comparing addresses.<br>
<br>
Right now, the code is nicely readable by using the is_ipv4() macro<br>
etc., but sacrificing this by having a check very early on that<br>
is the unrolled form of the macro, and basically does<br>
<br>
=C2=A0 if ( outside_address_family !=3D inside_address_family ) { return; }=
<br>
<br>
would indeed be more efficient for the mixed-family case.<br>
<br>
OTOH, you need another comparison then for &quot;is it IPv4?=C2=A0 is it IP=
v6?&quot;,<br>
so the overall amount of code for the same-family case might be even<br>
higher.<br>
<br>
OTOH again, is_ipv4() boils down to an amazing amount of code...=C2=A0 so<b=
r>
moving *that* from proto.c to proto.h and make it an inline function<br>
(and hope that the compiler will be smart enough to keep track of all<br>
the then-duplicate checks for is_ipv4() vs. is_ipv6() and just optimize<br>
it properly) might produce more efficient *and* more readable code :-)<br>
(and since it&#39;s only called in two places ever, the extra code size<br>
due to inlining isn&#39;t big)<br>
<span class=3D""><br>
<br>
&gt; I&#39;m basically concerned of the potential cost an extra check<br>
&gt; adds.=C2=A0 As the link speed increases, such checks will have an impa=
ct<br>
&gt; later on if now.=C2=A0 If truly needed, is it worth looking into provi=
ding<br>
&gt; some branch prediction hints to the compiler?=C2=A0 (unlikely/likely h=
ints)<br>
<br>
</span>For the &quot;protocol variants&quot;, you can&#39;t, because it dep=
ends on what<br>
users do with their tunnels.=C2=A0 Today, they might be predominantly<br>
IPv4-over-IPv4, while my personal sessions are mostly IPv6-over-IPv4<br>
already...<br>
<span class=3D""><br>
&gt; &gt; if (c-&gt;c2.buf.len &gt; 0) { +=C2=A0 =C2=A0 =C2=A0 drop_if_recu=
rsive_routing (c,<br>
&gt; &gt; &amp;c-&gt;c2.buf);<br>
&gt;<br>
&gt; If this is truly only an issue on Windows and OSX, can we consider to<=
br>
&gt; #ifdef the drop_if_recursive_routing() call?<br>
<br>
</span>It can happen on all platforms where &quot;inside&quot; and &quot;ou=
tside&quot; routing<br>
(wrt openvpn) happens in the same routing context / namespace / ... and<br>
&quot;some external entity&quot; can modify the &quot;outside&quot; routing=
 table without<br>
OpenVPN knowing.=C2=A0 In other words: on all platforms we support today.<b=
r>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
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
=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...1816...<wbr>mu=
enchen.de</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature">-Lev</div>
</div>

--001a114d3c845c73c40539f8777a--

