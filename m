Message-ID: <fb0a1bdc-fe8a-44e4-be90-d36485304633@...1227...>
Date: Mon, 20 Oct 2025 00:58:39 +0200
MIME-Version: 1.0
References: <CAOh3LPPaxH96ROVS6ktiz+Zv9=Xn5g8CT2CCu-wivM5MpTirSQ.ref@...278...>
 <CAOh3LPPaxH96ROVS6ktiz+Zv9=Xn5g8CT2CCu-wivM5MpTirSQ@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAOh3LPPaxH96ROVS6ktiz+Zv9=Xn5g8CT2CCu-wivM5MpTirSQ@...278...>
Subject: Re: [Openvpn-devel] A small downside observation noticed in
 performing mass bulk parallel data transfers
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
To: Jon Chiappetta <root@...2904...>, openvpn-devel@lists.sourceforge.net


Am 20.10.2025 um 00:16 schrieb Jon Chiappetta via Openvpn-devel:
> Thanks all for the updates on this project work, I've been fine tuning 
> and rebasing my proof-of-concept branches on top of the main source 
> code without too many code conflicts. I've been trying to tune up and 
> work through the little knots in my home network to maximize 
> performance of this network-wide, standard-sized MTU, bulk-reading, 
> multi-threaded, TCP-protocol VPN solution. I think I found an 
> interesting (negative) observation along the way with using this thing.
>
> It turns out that doing massive bulk reads and parallel data transfers 
> can impact the performance of poorly written applications (for 
> example, the Ring app in live view mode). For smarter protocols such 
> as TCP and even QUIC UDP, they can handle mass reordering of packets 
> as I did not incorporate any kind of reordering logic on the 
> client/server sides, I was trying to keep the original code as simple 
> as I could at the time. I found that the Ring app seems to use some 
> (likely) custom-written, non-standard UDP API for live video streams 
> and the bulk parallel data transfers were impacting the quality and 
> performance of the feed view as no packet order is being guaranteed by 
> this specific set of OpenVPN mode of operations. I'm guessing that 
> some custom UDP written apps may assume that they will receive their 
> data packets in the order that their server sends them but with my 
> implementations, it will likely break that assumption based on 
> parallel processing speeds.
>
> Instead of trying to put in some sort of packet tracking and ordering 
> into the code, I decided to use iptables + ip rules/routes to mark a 
> subset of UDP packets and send them through a separate OVPN instance 
> (bulk mode only, no multi threaded mode) - the rest of the smarter 
> protocols can still be sent through the main tunnel (bulk mode + mtio 
> mode). It seems to be working better now compatibility wise as the 
> network clients are simply on my WiFi network and they are not 
> individually connected or aware of the VPN itself (zero config 
> automatic environment).
>
> Anyway, I just wanted to share this observation as I found it 
> interesting in nature as a potential downside of doing this without 
> more complex logic placed into the code base itself!
>
That reordering of packets can cause massive performance impacts is 
fairly well understand effect. You have to fight with the same effects 
when doing link aggregation like LACP (from 2000ish but other standard 
date back even further) and typically this is solved by hashing the 
connection and ensuring that a UDP or TCP flow is only sent via one of 
the links.

Also with TCP reordering will cause massive retransmmit as "fast 
retransmit" in TCP will trigger retransmission for reordered packets 
basically almost instantly as it operates under the assumption that 
reordering does not happen or is infrequently enough that it can be 
ignored in the greater picture. You might not see as big of a 
performance degradation as with the other apps but it will still be 
noticable.

Arne


