References: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
 <eaae68e6-e30d-f63b-59c5-64515c8f8bcd@...1147...>
 <CAJY0qZ+CcwX1J_m2Geed3_JLzXftV_kUA3XBLsnw7JgXpaij1A@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <ac893e46-6951-f8f9-3d45-82ed42e21054@...1147...>
Date: Sat, 5 May 2018 00:32:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAJY0qZ+CcwX1J_m2Geed3_JLzXftV_kUA3XBLsnw7JgXpaij1A@...278...>
Content-Type: multipart/alternative;
 boundary="------------9A3DAD4E6D76EEA3548721A3"
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
To: Derek Zimmer <derek@...2095...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------9A3DAD4E6D76EEA3548721A3
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi Derek,

On 04/05/18 18:02, Derek Zimmer wrote:
> Based on the feedback we've gotten so far. I think we need to get some 
> hard data on the latency scaling to confirm my earlier observations.
>
how do you simulate latency? or do you actually have high latency machines?
try playing with
   --sndbuf 0 --rcvbuf 0 --tcp-queue-limit 10000

esp in TCP mode - that has helped me sometimes over a long distance link

> It is interesting that AES-NI appears to dramatically improve 
> performance, as none of the x86 CPUs mentioned in the gigabit 
> optimization guide should be anywhere near saturation when doing it in 
> software, so the hardware boost is curious as the tunnels are not CPU 
> limited to begin with. ( I am aware that the operations are single 
> threaded for CBC, which made up the majority of my testing. )
>
> I'll come back with some hard numbers in a week or so, and we can 
> analyze what might be going on. If there's a bottleneck somewhere that 
> we might be able to eliminate, we could have some opportunities.
>
> To test:
> Two 10gig servers at various latencies for throughput tests. iperf vs 
> no encryption vs typical tun configuration vs optimized tun 
> configuration. Wireshark with throughput analysis. Also check cpu 
> utilization and hardware acceleration on/off.
>
> Two 10gig servers operating at 1gb, to test for driver / other 
> optimizations explaining the performance differences.
>
> While i'm hammering away at this, are there any other tests with this 
> hardware/network that we might find interesting?
>
Record the specs of both machines carefully, including OS versions and 
OpenSSL versions

also, it'd be interesting to see a more realistic test, e.g. from an 
OpenVPN client to a machine on the LAN/network *behind* the OpenVPN 
server - so the OpenVPN server needs to actually route the traffic.

Also, it'd be interesting to see the effect of virtualization on this, 
and/or any spectre/meltdown patches that are present.
As a final test: test the performance of IPv6 over the link vs IPv4 over 
the link; I've seen a degradation of ~10% but I was expecting something 
of 2% or less.

cheers,

JJK


> On Fri, May 4, 2018 at 10:45 AM, Jan Just Keijser <janjust@...1147... 
> <mailto:janjust@...1147...>> wrote:
>
>     Hi,
>
>     see some comments inline
>
>     On 04/05/18 16:41, Derek Zimmer wrote:
>
>         Hello everyone,
>
>         Derek from OSTIF here. I've been working with OpenVPN for a
>         few years and there's a few curious performance anomalies that
>         i've ran into that add up to a possible performance
>         opportunity. My experience lies closer to networking protocols
>         and cryptography rather than programming, so i'd need some
>         help confirming my suspicions to see if this is an opportunity
>         for us.
>
>         I've been having some discussions with Mattock related to
>         performance, specifically the way that OpenVPN performance
>         scales on fast networks.
>
>         The interesting symptoms:
>         -OpenVPN performance appears to decrease linearly with
>         increases in latency.
>
>     I have not seen that , but then again, I have not played with
>     increases in latency either.
>
>         -OpenVPN performance seems consistent regardless of the OS of
>         the client/server.
>
>     on Linux-like OSes, yes; Windows and Mac OS don't perform nearly
>     as well.
>
>         -OpenVPN performance seems to adjust/scale with the speed of
>         the client/server, but always seems limited to roughly 25% of
>         the line speed of the fastest device when you scale up to
>         fiber speeds. The interesting part is that 1Gb servers will
>         top out around 220-275Mbit, and 10Gb servers will top out
>         around 2.5Gbit.
>
>     that depends. Read up on
>     https://community.openvpn.net/openvpn/wiki/Gigabit_Networks_Linux
>     <https://community.openvpn.net/openvpn/wiki/Gigabit_Networks_Linux>
>
>     and you will find that with the right settings and CPUs you can
>     get upto 900 Mbps over a gigabit link using MTU=1500. It all boils
>     down to high clockspeed CPUs and using AES-GCM suites.
>
>
>         -OpenVPN performance increases when you manually increase the
>         size of the packets to oversized (MTU 9000+).
>
>     yes, but in practice this does not help you much, unless ALL
>     traffic in your network is run on MTU >= 9000
>
>         -Performance is similar between TCP/UDP barring confounding
>         issues like packet loss.
>
>     I've seen this also
>
>
>         What conclusions can we draw from this?
>
>     My main conclusion has always been that OpenVPN is limited by the
>     number of user-to-kernel space transitions , not by anything else.
>
>         My network experience points to something going awry with
>         windowing with TCP, but UDP does not apply any sort of
>         windowing (no ACKs = no windowing) but the OpenVPN protocol
>         itself does have an ACK system, which suggests that OpenVPN
>         may apply its own windowing.
>
>     In interesting thing to test as well, is to set
>       sndbuf 0
>       rcvbuf 0
>
>     this should/will cause the *OS* to do Window scaling, so you can
>     rule out any window scaling issues after that. In my experience,
>     setting sndbuf=rcvbuf=0 *sometimes* helps.
>
>
>         From my network brain: These 4 factors all point to the same
>         problem with regular TCP networks, not enough packets are
>         "allowed" to be in flight by the protocol. This is why
>         performance scales linearly with distance/latency. The maximum
>         number of packets in flight gets reached, and the
>         client/server then waits to send more or throttles back the
>         rate to hit the target number of packets per second based on
>         the latency (how this is done depends on how windowing is
>         implemented). This is also why making the packets larger
>         increases performance. The OpenVPN protocol allows more
>         packets to be in flight indirectly, because a 9000 bit packet
>         is broken down into 1500 bit packets by the network protocol
>         outside of OpenVPN, so it sees fewer "packets in flight" at
>         the OpenVPN level.
>
>         I'm also hesitant to blame issues like task-switching as the
>         primary cause of the issue because of the behavior being OS
>         agnostic, and 10Gb connections being able to move 2.5Gbit/sec.
>
>         This problem only seems to surface with high latency
>         connections, or particularly fast networks (over 1Gb),
>
>         Let me know if i'm drawing the wrong conclusions from the
>         evidence here. I think we may have a performance opportunity
>         if we hack away at this issue and come to a greater
>         understanding of why OpenVPN behaves this way in these cases.
>         I'm also willing to do some Wireshark work to see how OpenVPN
>         behaves in these edge cases if we think it would be valuable.
>
>         Increasing performance for long-distance VPNs, and being able
>         to accommodate users in a fiber-to-the-home world would be a
>         huge benefit for all OpenVPN users.
>
>
>
>     thanks for your research, it's great to see someone else is
>     interested in high-speed VPNs also :)
>
>     cheers,
>
>     JJK
>
>
>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------9A3DAD4E6D76EEA3548721A3
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">Hi Derek,<br>
      <br>
      On 04/05/18 18:02, Derek Zimmer wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CAJY0qZ+CcwX1J_m2Geed3_JLzXftV_kUA3XBLsnw7JgXpaij1A@...278..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div>
          <div>
            <div>
              <div>
                <div>
                  <div>Based on the feedback we've gotten so far. I
                    think we need to get some hard data on the latency
                    scaling to confirm my earlier observations.<br>
                    <br>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    how do you simulate latency? or do you actually have high latency
    machines?<br>
    try playing with<br>
    =A0 --sndbuf 0 --rcvbuf 0 --tcp-queue-limit 10000<br>
    <br>
    esp in TCP mode - that has helped me sometimes over a long distance
    link<br>
    <br>
    <blockquote
cite=3D"mid:CAJY0qZ+CcwX1J_m2Geed3_JLzXftV_kUA3XBLsnw7JgXpaij1A@...278..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div>
          <div>
            <div>
              <div>
                <div>It is interesting that AES-NI appears to
                  dramatically improve performance, as none of the x86
                  CPUs mentioned in the gigabit optimization guide
                  should be anywhere near saturation when doing it in
                  software, so the hardware boost is curious as the
                  tunnels are not CPU limited to begin with. ( I am
                  aware that the operations are single threaded for CBC,
                  which made up the majority of my testing. )<br>
                  <br>
                </div>
                I'll come back with some hard numbers in a week or so,
                and we can analyze what might be going on. If there's a
                bottleneck somewhere that we might be able to eliminate,
                we could have some opportunities.<br>
                <br>
              </div>
              To test:<br>
            </div>
            Two 10gig servers at various latencies for throughput tests.
            iperf vs no encryption vs typical tun configuration vs
            optimized tun configuration. Wireshark with throughput
            analysis. Also check cpu utilization and hardware
            acceleration on/off.<br>
            <br>
          </div>
          Two 10gig servers operating at 1gb, to test for driver / other
          optimizations explaining the performance differences.<br>
          <br>
        </div>
        <div>While i'm hammering away at this, are there any other tests
          with this hardware/network that we might find interesting?<br>
        </div>
        <br>
      </div>
    </blockquote>
    Record the specs of both machines carefully, including OS versions
    and OpenSSL versions<br>
    <br>
    also, it'd be interesting to see a more realistic test, e.g. from an
    OpenVPN client to a machine on the LAN/network *behind* the OpenVPN
    server - so the OpenVPN server needs to actually route the traffic.<br>
    <br>
    Also, it'd be interesting to see the effect of virtualization on
    this, and/or any spectre/meltdown patches that are present.<br>
    As a final test: test the performance of IPv6 over the link vs IPv4
    over the link; I've seen a degradation of ~10% but I was expecting
    something of 2% or less.<br>
    <br>
    cheers,<br>
    <br>
    JJK<br>
    <br>
    <br>
    <blockquote
cite=3D"mid:CAJY0qZ+CcwX1J_m2Geed3_JLzXftV_kUA3XBLsnw7JgXpaij1A@...278..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">On Fri, May 4, 2018 at 10:45 AM, Jan
            Just Keijser <span dir=3D"ltr">&lt;<a moz-do-not-send=3D"true"
                href=3D"mailto:janjust@...1147..." target=3D"_blank">janjus=
t@...1147...</a>&gt;</span>
            wrote:<br>
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
              <br>
              see some comments inline<span class=3D""><br>
                <br>
                On 04/05/18 16:41, Derek Zimmer wrote:<br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
                  .8ex;border-left:1px #ccc solid;padding-left:1ex">
                  Hello everyone,<br>
                  <br>
                  Derek from OSTIF here. I've been working with OpenVPN
                  for a few years and there's a few curious performance
                  anomalies that i've ran into that add up to a possible
                  performance opportunity. My experience lies closer to
                  networking protocols and cryptography rather than
                  programming, so i'd need some help confirming my
                  suspicions to see if this is an opportunity for us.<br>
                  <br>
                  I've been having some discussions with Mattock related
                  to performance, specifically the way that OpenVPN
                  performance scales on fast networks.<br>
                  <br>
                  The interesting symptoms:<br>
                  -OpenVPN performance appears to decrease linearly with
                  increases in latency.<br>
                </blockquote>
              </span>
              I have not seen that , but then again, I have not played
              with increases in latency either.<span class=3D""><br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
                  .8ex;border-left:1px #ccc solid;padding-left:1ex">
                  -OpenVPN performance seems consistent regardless of
                  the OS of the client/server.<br>
                </blockquote>
              </span>
              on Linux-like OSes, yes; Windows and Mac OS don't perform
              nearly as well.<span class=3D""><br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
                  .8ex;border-left:1px #ccc solid;padding-left:1ex">
                  -OpenVPN performance seems to adjust/scale with the
                  speed of the client/server, but always seems limited
                  to roughly 25% of the line speed of the fastest device
                  when you scale up to fiber speeds. The interesting
                  part is that 1Gb servers will top out around
                  220-275Mbit, and 10Gb servers will top out around
                  2.5Gbit.<br>
                </blockquote>
              </span>
              that depends. Read up on<br>
              =A0 <a moz-do-not-send=3D"true"
                href=3D"https://community.openvpn.net/openvpn/wiki/Gigabit_=
Networks_Linux"
                rel=3D"noreferrer" target=3D"_blank">https://community.open=
vpn.net/<wbr>openvpn/wiki/Gigabit_Networks_<wbr>Linux</a><br>
              <br>
              and you will find that with the right settings and CPUs
              you can get upto 900 Mbps over a gigabit link using
              MTU=3D1500. It all boils down to high clockspeed CPUs and
              using AES-GCM suites.<span class=3D""><br>
                <br>
                <br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
                  .8ex;border-left:1px #ccc solid;padding-left:1ex">
                  -OpenVPN performance increases when you manually
                  increase the size of the packets to oversized (MTU
                  9000+).<br>
                </blockquote>
              </span>
              yes, but in practice this does not help you much, unless
              ALL traffic in your network is run on MTU &gt;=3D 9000<span
                class=3D""><br>
                <br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
                  .8ex;border-left:1px #ccc solid;padding-left:1ex">
                  -Performance is similar between TCP/UDP barring
                  confounding issues like packet loss.<br>
                </blockquote>
              </span>
              I've seen this also<span class=3D""><br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
                  .8ex;border-left:1px #ccc solid;padding-left:1ex">
                  <br>
                  What conclusions can we draw from this?<br>
                  <br>
                </blockquote>
              </span>
              My main conclusion has always been that OpenVPN is limited
              by the number of user-to-kernel space transitions , not by
              anything else.<span class=3D""><br>
                <br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
                  .8ex;border-left:1px #ccc solid;padding-left:1ex">
                  My network experience points to something going awry
                  with windowing with TCP, but UDP does not apply any
                  sort of windowing (no ACKs =3D no windowing) but the
                  OpenVPN protocol itself does have an ACK system, which
                  suggests that OpenVPN may apply its own windowing.<br>
                </blockquote>
              </span>
              In interesting thing to test as well, is to set<br>
              =A0 sndbuf 0<br>
              =A0 rcvbuf 0<br>
              <br>
              this should/will cause the *OS* to do Window scaling, so
              you can rule out any window scaling issues after that. In
              my experience, setting sndbuf=3Drcvbuf=3D0 *sometimes* helps.=
<span
                class=3D""><br>
                <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
                  .8ex;border-left:1px #ccc solid;padding-left:1ex">
                  <br>
                  From my network brain: These 4 factors all point to
                  the same problem with regular TCP networks, not enough
                  packets are "allowed" to be in flight by the protocol.
                  This is why performance scales linearly with
                  distance/latency. The maximum number of packets in
                  flight gets reached, and the client/server then waits
                  to send more or throttles back the rate to hit the
                  target number of packets per second based on the
                  latency (how this is done depends on how windowing is
                  implemented). This is also why making the packets
                  larger increases performance. The OpenVPN protocol
                  allows more packets to be in flight indirectly,
                  because a 9000 bit packet is broken down into 1500 bit
                  packets by the network protocol outside of OpenVPN, so
                  it sees fewer "packets in flight" at the OpenVPN
                  level.<br>
                  <br>
                  I'm also hesitant to blame issues like task-switching
                  as the primary cause of the issue because of the
                  behavior being OS agnostic, and 10Gb connections being
                  able to move 2.5Gbit/sec.<br>
                  <br>
                  This problem only seems to surface with high latency
                  connections, or particularly fast networks (over 1Gb),<br>
                  <br>
                  Let me know if i'm drawing the wrong conclusions from
                  the evidence here. I think we may have a performance
                  opportunity if we hack away at this issue and come to
                  a greater understanding of why OpenVPN behaves this
                  way in these cases. I'm also willing to do some
                  Wireshark work to see how OpenVPN behaves in these
                  edge cases if we think it would be valuable.<br>
                  <br>
                  Increasing performance for long-distance VPNs, and
                  being able to accommodate users in a fiber-to-the-home
                  world would be a huge benefit for all OpenVPN users.<br>
                  <br>
                  <br>
                </blockquote>
                <br>
              </span>
              thanks for your research, it's great to see someone else
              is interested in high-speed VPNs also :)<br>
              <br>
              cheers,<br>
              <br>
              JJK<br>
              <br>
            </blockquote>
          </div>
          <br>
        </div>
      </div>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">------------------------------------------------------=
------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! <a class=3D"moz-txt-link-freetext" href=
=3D"http://sdm.link/slashdot">http://sdm.link/slashdot</a></pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
Openvpn-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Openvpn-devel@lists.so=
urceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/li=
sts/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/op=
envpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------9A3DAD4E6D76EEA3548721A3--

