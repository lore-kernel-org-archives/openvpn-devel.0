Message-ID: <4c416e69-07b6-b7e0-25aa-0b3fb3ce5ac4@...2181...>
Date: Thu, 15 Dec 2022 11:15:30 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20221214164824.172-1-lstipakov@...277...>
 <CAKuzo_iZPLJvSyK53oziTO99ZW6ua-DFvEWMoPAK3MjrjQ5PdA@...278...>
 <CAGyAFMV=QqUUPj8-Z8_U3JWG3qoBOZOKpMMVAztpdc-8qT+0HQ@...278...>
 <CAKuzo_g6Pc6djBCu05-k5oJFWYuTYBFa60Ucay+z1BebJK=9Gg@...278...>
 <CAGyAFMUTjZuN+W8FagK+F=4P+iuUAEYS0qmieb3kNQYKN-z=gg@...278...>
 <Y5pEEhAGyKzbNn8u@...1296...>
 <CAGyAFMUQUx_oL_Qi6SBcAdB94VCW+1tmTQVkoCh5B0BnYThkLg@...278...>
 <CAKuzo_imcQLV60uJN9mXTR8ti7gctgR=iZVpi+2AvDvSTJ_x0g@...278...>
 <CAKuzo_jVnAUeKM9=x1vU_DztqPrwYJfHe=YTy5AS8PKF2_Tv1g@...278...>
 <CAGyAFMVkMAUmiNZCbp3xwognY-5d7-ZGEH9v=S17YBogfx2vnA@...278...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAGyAFMVkMAUmiNZCbp3xwognY-5d7-ZGEH9v=S17YBogfx2vnA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Introduce dco_get_peer_stats API and
 Windows implementation
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
To: Lev Stipakov <lstipakov@...277...>, Selva Nair <selva.nair@...277...>
Cc: Lev Stipakov <lev@...515...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 15/12/2022 10:31, Lev Stipakov wrote:
> Hi,
> 
>> In non-dco use, the stats as persisted by the management interface are not reset throughout the lifetime of the process. With dco, what the driver provides is "Peer Stats" which is reset in OvpnPeerNew()  (linux appears to do the same). A quick option > would be to move the zero-ing to OvpnEvtFileCleanup() which, I guess, would work at least when persist-tun is in use.
> 
> Yeah, without persist-tun client closes the handle, which triggers
> OvpnEvtFileCleanup(), which would reset stats.
> 
>> Or in a new callback that gets called on tun-open. But then it wont be strictly "Peer Stats".
> 
> Yeah that might be an option, to have RESET_STATS ioctl.
> 
> Also I wonder if the driver could remember, say, the last pid, and
> then reset stats on NEW_PEER if pid != last pid. Since pids are
> recycled, we might "leak" stats in unfortunate cases, but that's okay
> I guess?
> 

Sorry for jumping in the discussion a bit late.

IMHO the stats belong to the Peer object.
Let's not forget that, apart from windows, DCO supports multi-peer mode, 
therefore we have to consider that case as well.

Due to the above, I'd "reset" the stats when a new peer object is 
instantiated. Basically when a new peer object is instantiated it should 
come with empty stats, as expected.

If the desired behvaiour in userspace is to keep the stats persistent 
across a number of events, it should simply be userspace to keep those 
stats.

This way we don't mix up the logic of counting the bytes per peer, and 
keeping a general picture of the VPN process.

Cheers,


-- 
Antonio Quartulli

