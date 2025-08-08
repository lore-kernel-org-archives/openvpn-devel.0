Message-ID: <307182e4-a8aa-471c-8d80-ad764534143c@...1227...>
Date: Sat, 9 Aug 2025 01:48:41 +0200
MIME-Version: 1.0
References: <CAOh3LPMK7T2gduJXrKaQRDvPZdjCiBJtCqXWiFT0xj4TAaj2LA.ref@...278...>
 <CAOh3LPMK7T2gduJXrKaQRDvPZdjCiBJtCqXWiFT0xj4TAaj2LA@...278...>
 <ad04ec91-f397-4048-b65c-a96a3b48000c@...1227...>
 <CAOh3LPPeoxWRP3MVfR03+Cc=2Qc2tG=CM8mOkA9y31_=LTPL_Q@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAOh3LPPeoxWRP3MVfR03+Cc=2Qc2tG=CM8mOkA9y31_=LTPL_Q@...278...>
Subject: Re: [Openvpn-devel] Bulk mode - Feature request - Patch diff
 [updated]
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
To: Jon Chiappetta <root@...2904...>
Cc: openvpn-devel@lists.sourceforge.net


Am 08.08.2025 um 16:04 schrieb Jon Chiappetta:
> Hi Arne,
>
> You are correct, I didn't do a very good job of explaining the code in 
> my blog post, I usually keep those short with more screen captures 
> because I figure that not many people would actually take the time to 
> read through it there. Also, I didn't really add many comments either 
> but I did try to copy the present style of the code to try and make it 
> match and be more consistent throughout, even if not perfect yet. I'm 
> still testing out the change myself in my own home setup here to see 
> if I run into any bad edge cases along the way.
>
> I can always try to explain the different code parts as I am indeed 
> modifying the core parts of the read and write operations for tun and 
> tcp so it's a big change to make to the code base. Basically this 
> change is important to me in particular because of my setup and 
> requirements in specific. I have WiFi LAN clients which all assume a 
> 1500 byte MTU on their side and I have a router WAN client which 
> enforces a 1500 byte MTU on the internet's side. In the middle of my 
> core network is a VPN box and almost every VPN software will operate 
> in UDP mode with a sub-1500 MTU in the middle of this network 
> pipeline. This is not a good design to have in general as I don't want 
> to waste cycles fragmenting and/or compressing the data into smaller 
> sized UDP packets. With the code change I am presenting, I am able to 
> specify a true 1500 byte VPN MTU interface with the exact matching 
> 1500 byte read calls to the TUN interface itself (the code base had to 
> be modified to allow for this because it was adding onto the 
> payload_size used in the read call which I didn't want as I am 
> operating on exact multiples of 1500 bytes in specific).

OpenVPN already supports arbitrary MTU sizes just fine. The default is 
even MTU 1500. mssfix is also enabled by default to avoid fragmentation, 
which especially for UDP is bad. So I am not sure what you are modifying 
here because what you are describing is already well supported by OpenVPN.


>
> With this change, my network pipeline is a true 1500 byte MTU which 
> matches all the way from the client side to the vpn link to the 
> internet side and to the server side (end to end to end to end). In 
> addition, I also added the ability to batch together multiple 1500 
> byte read calls (specifically 6 x 1500 bytes into 9000 bytes) into one 
> single encrypt sign call and one single TCP write call.

So this needs a different wire format and some extra headers/framing as 
you need to split this jumbo packet again into 1500 bytes packets on the 
receiver.

In order to justify introducing a new framing/packet format, a clear 
benefit should be shown. It would be for example to show what the 
performance benefit here actually is, e.g. by doing a simple test.


do a simple client server OpenVPN connection and run iperf between 
client and server

- without VPN

-  unmodified OpenVPN with --mtu 1500

- unmodified OpenVPN with --mtu 9000

- your approach

That would give an indication what kind of gains we are talking here about.

> This allows the encryption method to operate only once on a much 
> larger payload size as well as allow the linux kernel to efficiently 
> transfer the data with order and delivery guaranteed as fast as 
> possible. The code base had to be modified to allow for all of this as 
> well as it was preventing me from performing this much larger sized 
> ssl sign and encrypt + tcp read and write (the code base assumes you 
> are operating on only 1 tun read call worth of data at a time 
> everywhere).
>
> This is exactly why I prefer using TCP to tunnel encrypted network 
> data as my solution provided can properly set a full sized 1500 byte 
> MTU as well as perform an exact matching read call of 1500 bytes to 
> get the full amount of data from the interface and then bulk it 
> together to efficiently encrypt it and then use the magic of TCP to 
> transfer that data all at once as quickly as possible without any need 
> for fragmentation or compression. I don't think any other VPN product 
> on the market offers that kind of functionality as far as I am aware 
> as most other VPN products use a smaller sized MTU as well as the 
> packet size limitations of UDP. I believe that this could be a 
> distinguishing feature for OpenVPN as well as automatically solve some 
> of the issues that folks run into when inserting a VPN appliance into 
> the middle of their network setups.

In TCP mode can you get away with a lot of thing you are doing. In UDP 
mode, having tunnel inside MTU of 1500 or pushing large fragmented 
IP/UDP packets will be very detrimental to VPN performance.


>
> I've been running this change on my own setup to at least make sure it 
> works and it seems to be running pretty nicely so far. I haven't 
> experienced any fragmentation or performance issues as any sized data 
> that comes off the clients LAN side is fully taken care of now through 
> the VPN side and onto the WAN and server side.

This whole MTU fragment and tun must have 1500 MTU to not see these 
problems is not a thing that I observe and also not a logical conclusion 
for me.

>
> If this is something you are not interested in I can understand that, 
> I can stop posting here and the most I can do is at least submit a 
> pull request in case anyone in the future is indeed interested in such 
> work. It'd be nice to contribute to a good quality open source project 
> that I have used for many many years and something which may help 
> solve other community member's issues with regards to the small sized 
> MTU + UDP problem which does exist in practice and really hampers 
> connections along the way in a network design.

It would be good to understand what you are actually referring to here. 
Small sized MTU + UDP problem is quite vague as there are multiple 
things that can cause probelems with an UDP VPN.

>
> I also don't mind explaining my code parts if you actually want, I 
> just need to take time to write them out and describe what they are 
> doing and why. As you can see, I am trying to achieve a very specific 
> and exact design goal that the code base wasn't originally allowing 
> for, so I had to make some modifications to be able to accomplish it.
>

