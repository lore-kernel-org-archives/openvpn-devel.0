References: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <033da0f7-ef9f-a55f-7f22-d661fa8ba264@...1227...>
Date: Fri, 4 May 2018 17:33:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
Content-Language: de-DE
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Derek Zimmer <derek@...2095...>, openvpn-devel@lists.sourceforge.net


> My network experience points to something going awry with windowing with
> TCP, but UDP does not apply any sort of windowing (no ACKs = no
> windowing) but the OpenVPN protocol itself does have an ACK system,
> which suggests that OpenVPN may apply its own windowing.

OpenVPN has a data channel and control channel. For the control there is
indeed a very basic tcp like ack and widow system in place. However this
is only used for control message (SSL negioation, pushing option etc.)

The data channel packet has no ACKs. There is also a packet id and
window for them but that is only used for replay attack preventention.

> 
> From my network brain: These 4 factors all point to the same problem
> with regular TCP networks, not enough packets are "allowed" to be in
> flight by the protocol. 

There is no limit of allowed packet in flight. On some connection you
might get out of order packet that are dropped and might need to adjust
replay-window. OpenVPN will log that if it happens.

> This is why performance scales linearly with
> distance/latency. The maximum number of packets in flight gets reached,
> and the client/server then waits to send more or throttles back the rate
> to hit the target number of packets per second based on the latency (how
> this is done depends on how windowing is implemented). This is also why
> making the packets larger increases performance. The OpenVPN protocol
> allows more packets to be in flight indirectly, because a 9000 bit
> packet is broken down into 1500 bit packets by the network protocol
> outside of OpenVPN, so it sees fewer "packets in flight" at the OpenVPN
> level.

This is probably that the send/recv calls are fewer when sending
receiving 9000 byte udp packets from/to the OS rather than anything in
OpenVPN in general.

> I'm also hesitant to blame issues like task-switching as the primary
> cause of the issue because of the behavior being OS agnostic, and 10Gb
> connections being able to move 2.5Gbit/sec.

Then again 10 GBit/s card and drivers have lot more optimisation to make
sending/receiving a large number of packets better, so it might not
related to the connection speed here. You might try to gigabit link with
a 10 GBit/s card to see if you still get 1 Gbit/s?

> This problem only seems to surface with high latency connections, or
> particularly fast networks (over 1Gb),
> 
> Let me know if i'm drawing the wrong conclusions from the evidence here.
> I think we may have a performance opportunity if we hack away at this
> issue and come to a greater understanding of why OpenVPN behaves this
> way in these cases. I'm also willing to do some Wireshark work to see
> how OpenVPN behaves in these edge cases if we think it would be valuable.
> 
> Increasing performance for long-distance VPNs, and being able to
> accommodate users in a fiber-to-the-home world would be a huge benefit
> for all OpenVPN users.

Trying to figure out where performance are is always difficult. One
thing to do with OpenVPN that is helpful is to eliminate encryption
overhead, e.g. using auth none and cipher none. Not for a production
environment but as a baseline.

Arne

