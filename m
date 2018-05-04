MIME-Version: 1.0
In-Reply-To: <eaae68e6-e30d-f63b-59c5-64515c8f8bcd@...1147...>
References: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
 <eaae68e6-e30d-f63b-59c5-64515c8f8bcd@...1147...>
From: Derek Zimmer <derek@...2095...>
Date: Fri, 4 May 2018 11:02:08 -0500
Message-ID: <CAJY0qZ+CcwX1J_m2Geed3_JLzXftV_kUA3XBLsnw7JgXpaij1A@...278...>
Content-Type: multipart/alternative; boundary="00000000000034f4e5056b63711a"
Subject: Re: [Openvpn-devel] Does the OpenVPN protocol itself handle
 windowing?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000034f4e5056b63711a
Content-Type: text/plain; charset="UTF-8"

Based on the feedback we've gotten so far. I think we need to get some hard
data on the latency scaling to confirm my earlier observations.

It is interesting that AES-NI appears to dramatically improve performance,
as none of the x86 CPUs mentioned in the gigabit optimization guide should
be anywhere near saturation when doing it in software, so the hardware
boost is curious as the tunnels are not CPU limited to begin with. ( I am
aware that the operations are single threaded for CBC, which made up the
majority of my testing. )

I'll come back with some hard numbers in a week or so, and we can analyze
what might be going on. If there's a bottleneck somewhere that we might be
able to eliminate, we could have some opportunities.

To test:
Two 10gig servers at various latencies for throughput tests. iperf vs no
encryption vs typical tun configuration vs optimized tun configuration.
Wireshark with throughput analysis. Also check cpu utilization and hardware
acceleration on/off.

Two 10gig servers operating at 1gb, to test for driver / other
optimizations explaining the performance differences.

While i'm hammering away at this, are there any other tests with this
hardware/network that we might find interesting?

Derek Zimmer
Chief Executive Officer
Open Source Technology Improvement Fund

On Fri, May 4, 2018 at 10:45 AM, Jan Just Keijser <janjust@...1147...> wrote:

> Hi,
>
> see some comments inline
>
> On 04/05/18 16:41, Derek Zimmer wrote:
>
>> Hello everyone,
>>
>> Derek from OSTIF here. I've been working with OpenVPN for a few years and
>> there's a few curious performance anomalies that i've ran into that add up
>> to a possible performance opportunity. My experience lies closer to
>> networking protocols and cryptography rather than programming, so i'd need
>> some help confirming my suspicions to see if this is an opportunity for us.
>>
>> I've been having some discussions with Mattock related to performance,
>> specifically the way that OpenVPN performance scales on fast networks.
>>
>> The interesting symptoms:
>> -OpenVPN performance appears to decrease linearly with increases in
>> latency.
>>
> I have not seen that , but then again, I have not played with increases in
> latency either.
>
>> -OpenVPN performance seems consistent regardless of the OS of the
>> client/server.
>>
> on Linux-like OSes, yes; Windows and Mac OS don't perform nearly as well.
>
>> -OpenVPN performance seems to adjust/scale with the speed of the
>> client/server, but always seems limited to roughly 25% of the line speed of
>> the fastest device when you scale up to fiber speeds. The interesting part
>> is that 1Gb servers will top out around 220-275Mbit, and 10Gb servers will
>> top out around 2.5Gbit.
>>
> that depends. Read up on
>   https://community.openvpn.net/openvpn/wiki/Gigabit_Networks_Linux
>
> and you will find that with the right settings and CPUs you can get upto
> 900 Mbps over a gigabit link using MTU=1500. It all boils down to high
> clockspeed CPUs and using AES-GCM suites.
>
>
> -OpenVPN performance increases when you manually increase the size of the
>> packets to oversized (MTU 9000+).
>>
> yes, but in practice this does not help you much, unless ALL traffic in
> your network is run on MTU >= 9000
>
> -Performance is similar between TCP/UDP barring confounding issues like
>> packet loss.
>>
> I've seen this also
>
>>
>> What conclusions can we draw from this?
>>
>> My main conclusion has always been that OpenVPN is limited by the number
> of user-to-kernel space transitions , not by anything else.
>
> My network experience points to something going awry with windowing with
>> TCP, but UDP does not apply any sort of windowing (no ACKs = no windowing)
>> but the OpenVPN protocol itself does have an ACK system, which suggests
>> that OpenVPN may apply its own windowing.
>>
> In interesting thing to test as well, is to set
>   sndbuf 0
>   rcvbuf 0
>
> this should/will cause the *OS* to do Window scaling, so you can rule out
> any window scaling issues after that. In my experience, setting
> sndbuf=rcvbuf=0 *sometimes* helps.
>
>>
>> From my network brain: These 4 factors all point to the same problem with
>> regular TCP networks, not enough packets are "allowed" to be in flight by
>> the protocol. This is why performance scales linearly with
>> distance/latency. The maximum number of packets in flight gets reached, and
>> the client/server then waits to send more or throttles back the rate to hit
>> the target number of packets per second based on the latency (how this is
>> done depends on how windowing is implemented). This is also why making the
>> packets larger increases performance. The OpenVPN protocol allows more
>> packets to be in flight indirectly, because a 9000 bit packet is broken
>> down into 1500 bit packets by the network protocol outside of OpenVPN, so
>> it sees fewer "packets in flight" at the OpenVPN level.
>>
>> I'm also hesitant to blame issues like task-switching as the primary
>> cause of the issue because of the behavior being OS agnostic, and 10Gb
>> connections being able to move 2.5Gbit/sec.
>>
>> This problem only seems to surface with high latency connections, or
>> particularly fast networks (over 1Gb),
>>
>> Let me know if i'm drawing the wrong conclusions from the evidence here.
>> I think we may have a performance opportunity if we hack away at this issue
>> and come to a greater understanding of why OpenVPN behaves this way in
>> these cases. I'm also willing to do some Wireshark work to see how OpenVPN
>> behaves in these edge cases if we think it would be valuable.
>>
>> Increasing performance for long-distance VPNs, and being able to
>> accommodate users in a fiber-to-the-home world would be a huge benefit for
>> all OpenVPN users.
>>
>>
>>
> thanks for your research, it's great to see someone else is interested in
> high-speed VPNs also :)
>
> cheers,
>
> JJK
>
>

--00000000000034f4e5056b63711a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>Based on the feedback we&#39=
;ve gotten so far. I think we need to get some hard data on the latency sca=
ling to confirm my earlier observations.<br><br></div>It is interesting tha=
t AES-NI appears to dramatically improve performance, as none of the x86 CP=
Us mentioned in the gigabit optimization guide should be anywhere near satu=
ration when doing it in software, so the hardware boost is curious as the t=
unnels are not CPU limited to begin with. ( I am aware that the operations =
are single threaded for CBC, which made up the majority of my testing. )<br=
><br></div>I&#39;ll come back with some hard numbers in a week or so, and w=
e can analyze what might be going on. If there&#39;s a bottleneck somewhere=
 that we might be able to eliminate, we could have some opportunities.<br><=
br></div>To test:<br></div>Two 10gig servers at various latencies for throu=
ghput tests. iperf vs no encryption vs typical tun configuration vs optimiz=
ed tun configuration. Wireshark with throughput analysis. Also check cpu ut=
ilization and hardware acceleration on/off.<br><br></div>Two 10gig servers =
operating at 1gb, to test for driver / other optimizations explaining the p=
erformance differences.<br><br></div><div>While i&#39;m hammering away at t=
his, are there any other tests with this hardware/network that we might fin=
d interesting?<br></div><div class=3D"gmail_extra"><br clear=3D"all"><div><=
div class=3D"gmail_signature" data-smartmail=3D"gmail_signature">Derek Zimm=
er<br>Chief Executive Officer<br>Open Source Technology Improvement Fund</d=
iv></div>
<br><div class=3D"gmail_quote">On Fri, May 4, 2018 at 10:45 AM, Jan Just Ke=
ijser <span dir=3D"ltr">&lt;<a href=3D"mailto:janjust@...1147..." target=3D=
"_blank">janjust@...1147...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">Hi,<br>
<br>
see some comments inline<span class=3D""><br>
<br>
On 04/05/18 16:41, Derek Zimmer wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hello everyone,<br>
<br>
Derek from OSTIF here. I&#39;ve been working with OpenVPN for a few years a=
nd there&#39;s a few curious performance anomalies that i&#39;ve ran into t=
hat add up to a possible performance opportunity. My experience lies closer=
 to networking protocols and cryptography rather than programming, so i&#39=
;d need some help confirming my suspicions to see if this is an opportunity=
 for us.<br>
<br>
I&#39;ve been having some discussions with Mattock related to performance, =
specifically the way that OpenVPN performance scales on fast networks.<br>
<br>
The interesting symptoms:<br>
-OpenVPN performance appears to decrease linearly with increases in latency=
.<br>
</blockquote></span>
I have not seen that , but then again, I have not played with increases in =
latency either.<span class=3D""><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
-OpenVPN performance seems consistent regardless of the OS of the client/se=
rver.<br>
</blockquote></span>
on Linux-like OSes, yes; Windows and Mac OS don&#39;t perform nearly as wel=
l.<span class=3D""><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
-OpenVPN performance seems to adjust/scale with the speed of the client/ser=
ver, but always seems limited to roughly 25% of the line speed of the faste=
st device when you scale up to fiber speeds. The interesting part is that 1=
Gb servers will top out around 220-275Mbit, and 10Gb servers will top out a=
round 2.5Gbit.<br>
</blockquote></span>
that depends. Read up on<br>
=C2=A0 <a href=3D"https://community.openvpn.net/openvpn/wiki/Gigabit_Networ=
ks_Linux" rel=3D"noreferrer" target=3D"_blank">https://community.openvpn.ne=
t/<wbr>openvpn/wiki/Gigabit_Networks_<wbr>Linux</a><br>
<br>
and you will find that with the right settings and CPUs you can get upto 90=
0 Mbps over a gigabit link using MTU=3D1500. It all boils down to high cloc=
kspeed CPUs and using AES-GCM suites.<span class=3D""><br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
-OpenVPN performance increases when you manually increase the size of the p=
ackets to oversized (MTU 9000+).<br>
</blockquote></span>
yes, but in practice this does not help you much, unless ALL traffic in you=
r network is run on MTU &gt;=3D 9000<span class=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
-Performance is similar between TCP/UDP barring confounding issues like pac=
ket loss.<br>
</blockquote></span>
I&#39;ve seen this also<span class=3D""><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
What conclusions can we draw from this?<br>
<br>
</blockquote></span>
My main conclusion has always been that OpenVPN is limited by the number of=
 user-to-kernel space transitions , not by anything else.<span class=3D""><=
br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
My network experience points to something going awry with windowing with TC=
P, but UDP does not apply any sort of windowing (no ACKs =3D no windowing) =
but the OpenVPN protocol itself does have an ACK system, which suggests tha=
t OpenVPN may apply its own windowing.<br>
</blockquote></span>
In interesting thing to test as well, is to set<br>
=C2=A0 sndbuf 0<br>
=C2=A0 rcvbuf 0<br>
<br>
this should/will cause the *OS* to do Window scaling, so you can rule out a=
ny window scaling issues after that. In my experience, setting sndbuf=3Drcv=
buf=3D0 *sometimes* helps.<span class=3D""><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
From my network brain: These 4 factors all point to the same problem with =
regular TCP networks, not enough packets are &quot;allowed&quot; to be in f=
light by the protocol. This is why performance scales linearly with distanc=
e/latency. The maximum number of packets in flight gets reached, and the cl=
ient/server then waits to send more or throttles back the rate to hit the t=
arget number of packets per second based on the latency (how this is done d=
epends on how windowing is implemented). This is also why making the packet=
s larger increases performance. The OpenVPN protocol allows more packets to=
 be in flight indirectly, because a 9000 bit packet is broken down into 150=
0 bit packets by the network protocol outside of OpenVPN, so it sees fewer =
&quot;packets in flight&quot; at the OpenVPN level.<br>
<br>
I&#39;m also hesitant to blame issues like task-switching as the primary ca=
use of the issue because of the behavior being OS agnostic, and 10Gb connec=
tions being able to move 2.5Gbit/sec.<br>
<br>
This problem only seems to surface with high latency connections, or partic=
ularly fast networks (over 1Gb),<br>
<br>
Let me know if i&#39;m drawing the wrong conclusions from the evidence here=
. I think we may have a performance opportunity if we hack away at this iss=
ue and come to a greater understanding of why OpenVPN behaves this way in t=
hese cases. I&#39;m also willing to do some Wireshark work to see how OpenV=
PN behaves in these edge cases if we think it would be valuable.<br>
<br>
Increasing performance for long-distance VPNs, and being able to accommodat=
e users in a fiber-to-the-home world would be a huge benefit for all OpenVP=
N users.<br>
<br>
<br>
</blockquote>
<br></span>
thanks for your research, it&#39;s great to see someone else is interested =
in high-speed VPNs also :)<br>
<br>
cheers,<br>
<br>
JJK<br>
<br>
</blockquote></div><br></div></div>

--00000000000034f4e5056b63711a--

