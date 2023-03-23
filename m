Message-ID: <fe246110-62a1-b348-71d6-e1a17097fd88@...2181...>
Date: Thu, 23 Mar 2023 13:15:03 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230322192757.20767-1-a@...2181...>
 <ZBxABqx/VGMY4R62@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <ZBxABqx/VGMY4R62@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v4] dco-linux: implement
 dco_get_peer_stats{, multi} API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Spot on and sorry for forgetting to mentioning it:

You need ovpn-dco at this commit:

commit 726fdfe0fa21aa4e87c5a60294ea0365ce7b6809 (HEAD -> master, 
origin/master)
Author: Antonio Quartulli <antonio@...515...>
Date:   Mon Mar 20 23:50:52 2023 +0100

     ovpn-dco: store and report transport rx/tx stats as well

     Signed-off-by: Antonio Quartulli <antonio@...515...>

Which comes right after the one you are using.

It is not a breaking change (as you see there is no real *failure*, just 
missing information from the kernel side).

Regards,

On 23/03/2023 13:03, Gert Doering wrote:
> Hi,
> 
> On Wed, Mar 22, 2023 at 08:27:57PM +0100, Antonio Quartulli wrote:
>> With this API it is possible to retrieve the stats for a specific peer
>> or for all peers and then update the userspace counters with the value
>> reported by DCO.
>>
>> Change-Id: Ia3990b86b1be7ca844fb1674b39ce0d60528ccff
>> Signed-off-by: Antonio Quartulli <a@...2181...>
> 
> This *looks* very reasonable, but only half of it works for me.
> 
> ...
> tun-udp-p2mp[492453]: OpenVPN 2.7_git [git:vw/master/5a8fb55ac8cf4019] x86_64-pc-linux-gnu [SSL (mbed TLS)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] [DCO] built on Mar 23 2023
> tun-udp-p2mp[492453]: DCO version: 0.2.20230313
> ...
> tun-udp-p2mp[492454]: dco_get_peer_stats_multi
> tun-udp-p2mp[492454]: dco_parse_peer_multi: parsing message...
> tun-udp-p2mp[492454]: dco_update_peer_stat: no link RX bytes provided in reply for peer 0
> tun-udp-p2mp[492454]: dco_update_peer_stat: no link TX bytes provided in reply for peer 0
> tun-udp-p2mp[492454]: dco_update_peer_stat / tun_read_bytes: 240
> tun-udp-p2mp[492454]: dco_update_peer_stat / tun_write_bytes: 96
> tun-udp-p2mp[492454]: dco_parse_peer_multi: parsing message...
> tun-udp-p2mp[492454]: dco_update_peer_stat: no link RX bytes provided in reply for peer 1
> tun-udp-p2mp[492454]: dco_update_peer_stat: no link TX bytes provided in reply for peer 1
> tun-udp-p2mp[492454]: dco_update_peer_stat / tun_read_bytes: 776
> tun-udp-p2mp[492454]: dco_update_peer_stat / tun_write_bytes: 80
> 
> 
> So neither for p2p tls nor for --server setups, I am receiving "link bytes",
> only tun*bytes.
> 
> I have not checked the kernel side if I *should* receive anything, but
> this looks incomplete - either the kernel side is not yet ready (not
> a showstopper) or there is a desync in the tags used, which might or
> might not prevent merging...
> 
> Antonio, any ideas?
> 
> gert

-- 
Antonio Quartulli

