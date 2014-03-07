Message-ID: <53199C4F.6050006@...1227...>
Date: Fri, 07 Mar 2014 11:15:43 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1394186298-226674-1-git-send-email-vvk@...1868...>
In-Reply-To: <1394186298-226674-1-git-send-email-vvk@...1868...>
Subject: Re: [Openvpn-devel] [PATCH] Flood unicast packet with unknown
 destination to all clients
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Vladimir V. Kamarzin" <vvk@...1868...>, openvpn-devel@lists.sourceforge.net

Am 07.03.14 10:58, schrieb Vladimir V. Kamarzin:
> From: "Vladimir V. Kamarzin" <vvk@...1868...>
>
> When working in TAP mode, openvpn at server side maintains mapping table
> "MAC" -> "client". It needs to know what MAC belongs to what client to
> be able to forward traffic.
>
> How does openvpn maintains it's MAC address table? Openvpn basically
> emulates learning switch behavior, but not in 100% the same way. Openvpn
> analyzes ethernet header of all packets, coming from clients, and
> extracts MAC address from them.
>
> So where is openvpn behavior differs from learning switch ones? Whether
> learning switch sees a packet for broadcast, multicast or unknown
> unicast destination, it sends it to all ports. Openvpn does the same
> thing, except for unicast destinations.
>
> Consider following example setup:
> - S: switch
> - A: generic network host, 192.168.0.1/24
> - B: special device which provides access to C, 192.168.0.2/24 and MAC
>   00:00:00:11:11:11
> - C: special device that we want access, 192.168.0.3/24, MAC
>   00:00:00:22:22:22
>
> Plug scheme: (A) and (B) are plugged to (S). (C) is plugged to (B).
> ARP handling for (B) is performed by (C).
>
> Here is step-by-step scheme how it works:
> 1. (A) wants to "ping" (C). So it sends ARP request "who has
>    192.168.0.3 tell 192.168.0.1" with broadcast destination in ethernet
>    frame. Switch forwards this packet to all ports.
> 2. (B) receives ARP request and generates reply: "192.168.0.3 is at
>    00:00:00:22:22:22". Although MAC in ethernet header is
>    00:00:00:11:11:11!
> 3. Switch (S) see this reply and learns 00:00:00:11:11:11 to it MAC
>    address table. (A) see this reply and add entry to ARP cache:
>    192.168.0.3 -> 00:00:00:22:22:22
> 4. (A) sends unicast packet (ICMP echo request) to 192.168.0.3, with
>    ethernet destination address 00:00:00:22:22:22
> 5. Switch (S) does not know where is 00:00:00:22:22:22, so it sends
>    this packet to all ports
> 6. (C) receives ICMP echo request and generates ICMP echo reply.
>    Ethernet header now contains 00:00:00:22:22:22.
> 7. Switch see frame with src 00:00:00:22:22:22 and learns it. All
>    happy, traffic passes.
>
> In openvpn case, there is no step 5. This patch implements option
> "tap-flood-unknown-unicast", which changes openvpn behavior to
> switch-like. Bandwidth on vpn links is limited & expensive, so it is
> disabled by default.

FEATURE ack from me. The code looks good, but I git am does not apply
the patch cleanly. Is the patch again master?

Arne


