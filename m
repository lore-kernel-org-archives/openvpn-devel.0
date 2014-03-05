From: Vladimir Kamarzin <vvk@...1868...>
In-Reply-To: <53163C6D.7050801@...1227...>
References: <1393929449-423915-1-git-send-email-vvk@...1868...>
	<53163C6D.7050801@...1227...>
MIME-Version: 1.0
Message-Id: <283911394015829@...1871...>
Date: Wed, 05 Mar 2014 16:37:09 +0600
Subject: Re: [Openvpn-devel] [PATCH] Extract MAC addresses from ARP packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

05.03.2014, 02:49, "Arne Schwabe" <arne@...1227...>:

> OpenVPN basically just emulates a learning switch. Learning switches
> also don't need these special logic. If your setup does not work with
> OpenVPN then either
>
> a) it won't work with a learning switch either or
> b) OpenVPN learning switch implementation has a bug
>
> I would like to have either a) confirmed or b) fixed than to included a
> band aid.

My setup does work with learning switches (tested before openvpn). So it looks like openvpn behavior not 100% the same.

Example setup contains following:
- S: switch
- A: generic network host, 192.168.0.1/24
- B: special device which provides access to C, 192.168.0.2/24 and MAC 00:00:00:11:11:11
- C: special device that we want access, 192.168.0.3/24, MAC 00:00:00:22:22:22

Plug scheme: (A) and (B) are plugged to (S). (C) is plugged to (B). ARP handling for (B) is performed by (C).

Here is step-by-step scheme how it works:
1. (A) wants to "ping" (C). So it sends ARP request "who has 192.168.0.3 tell 192.168.0.1" with broadcast destination in ethernet frame. Switch forwards this packet to all ports.
2. (B) receives ARP request and generates reply: "192.168.0.3 is at 00:00:00:22:22:22". Although MAC in ethernet header is 00:00:00:11:11:11!
3. Switch (S) see this reply and learns 00:00:00:11:11:11 to it MAC address table. (A) see this reply and add entry to ARP cache: 192.168.0.3 -> 00:00:00:22:22:22
4. (A) sends unicast packet (ICMP echo request) to 192.168.0.3, with ethernet destination address 00:00:00:22:22:22
5. Switch (S) does not know where is 00:00:00:22:22:22, so it sends this packet to all ports
6. (C) receives ICMP echo request and generates ICMP echo reply. Ethernet header now contains 00:00:00:22:22:22.
7. Switch see frame with src 00:00:00:22:22:22 and learns it. All happy, traffic passes.

In openvpn case, it looks like there is no step 5, so probably it is a bug. So I better should fix this instead of doing tricks with ARP.

