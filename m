References: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <eaae68e6-e30d-f63b-59c5-64515c8f8bcd@...1147...>
Date: Fri, 4 May 2018 17:45:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
Content-Language: en-US
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Derek Zimmer <derek@...2095...>, openvpn-devel@lists.sourceforge.net

Hi,

see some comments inline

On 04/05/18 16:41, Derek Zimmer wrote:
> Hello everyone,
>
> Derek from OSTIF here. I've been working with OpenVPN for a few years and there's a few curious performance anomalies that 
> i've ran into that add up to a possible performance opportunity. My experience lies closer to networking protocols and 
> cryptography rather than programming, so i'd need some help confirming my suspicions to see if this is an opportunity for us.
>
> I've been having some discussions with Mattock related to performance, specifically the way that OpenVPN performance scales on 
> fast networks.
>
> The interesting symptoms:
> -OpenVPN performance appears to decrease linearly with increases in latency.
I have not seen that , but then again, I have not played with increases in latency either.
> -OpenVPN performance seems consistent regardless of the OS of the client/server.
on Linux-like OSes, yes; Windows and Mac OS don't perform nearly as well.
> -OpenVPN performance seems to adjust/scale with the speed of the client/server, but always seems limited to roughly 25% of the 
> line speed of the fastest device when you scale up to fiber speeds. The interesting part is that 1Gb servers will top out 
> around 220-275Mbit, and 10Gb servers will top out around 2.5Gbit.
that depends. Read up on
   https://community.openvpn.net/openvpn/wiki/Gigabit_Networks_Linux

and you will find that with the right settings and CPUs you can get upto 900 Mbps over a gigabit link using MTU=1500. It all 
boils down to high clockspeed CPUs and using AES-GCM suites.


> -OpenVPN performance increases when you manually increase the size of the packets to oversized (MTU 9000+).
yes, but in practice this does not help you much, unless ALL traffic in your network is run on MTU >= 9000

> -Performance is similar between TCP/UDP barring confounding issues like packet loss.
I've seen this also
>
> What conclusions can we draw from this?
>
My main conclusion has always been that OpenVPN is limited by the number of user-to-kernel space transitions , not by anything else.

> My network experience points to something going awry with windowing with TCP, but UDP does not apply any sort of windowing (no 
> ACKs = no windowing) but the OpenVPN protocol itself does have an ACK system, which suggests that OpenVPN may apply its own 
> windowing.
In interesting thing to test as well, is to set
   sndbuf 0
   rcvbuf 0

this should/will cause the *OS* to do Window scaling, so you can rule out any window scaling issues after that. In my 
experience, setting sndbuf=rcvbuf=0 *sometimes* helps.
>
> From my network brain: These 4 factors all point to the same problem with regular TCP networks, not enough packets are 
> "allowed" to be in flight by the protocol. This is why performance scales linearly with distance/latency. The maximum number 
> of packets in flight gets reached, and the client/server then waits to send more or throttles back the rate to hit the target 
> number of packets per second based on the latency (how this is done depends on how windowing is implemented). This is also why 
> making the packets larger increases performance. The OpenVPN protocol allows more packets to be in flight indirectly, because 
> a 9000 bit packet is broken down into 1500 bit packets by the network protocol outside of OpenVPN, so it sees fewer "packets 
> in flight" at the OpenVPN level.
>
> I'm also hesitant to blame issues like task-switching as the primary cause of the issue because of the behavior being OS 
> agnostic, and 10Gb connections being able to move 2.5Gbit/sec.
>
> This problem only seems to surface with high latency connections, or particularly fast networks (over 1Gb),
>
> Let me know if i'm drawing the wrong conclusions from the evidence here. I think we may have a performance opportunity if we 
> hack away at this issue and come to a greater understanding of why OpenVPN behaves this way in these cases. I'm also willing 
> to do some Wireshark work to see how OpenVPN behaves in these edge cases if we think it would be valuable.
>
> Increasing performance for long-distance VPNs, and being able to accommodate users in a fiber-to-the-home world would be a 
> huge benefit for all OpenVPN users.
>
>

thanks for your research, it's great to see someone else is interested in high-speed VPNs also :)

cheers,

JJK


