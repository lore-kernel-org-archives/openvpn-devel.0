Message-ID: <3a5f2f6a-0145-4ae7-bb21-cf1c36b51501@...2181...>
Date: Thu, 19 Mar 2026 15:42:46 +0100
MIME-Version: 1.0
References: <20260317141916.437559-1-a@...2181...> <abwJl_hNK3fqV45Y@...2915...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <abwJl_hNK3fqV45Y@...2915...>
Subject: Re: [Openvpn-devel] [PATCH ovpn net] ovpn: fix race between
 deleting interface and adding new peer
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
To: Sabrina Dubroca <sd@...2891...>
Cc: openvpn-devel@lists.sourceforge.net, Hyunwoo Kim <imv4bel@...277...>

On 19/03/2026 15:35, Sabrina Dubroca wrote:
> 2026-03-17, 15:19:16 +0100, Antonio Quartulli wrote:
>> From: Antonio Quartulli <antonio@...515...>
>>
>> While deleting an existing ovpn interface, there is a very
>> narrow window where adding a new peer via netlink may cause
>> the netdevice to hang and prevent its unregistration.
>>
>> It may happen during ovpn_dellink(), when all existing peers are
>> freed and the device is queued for deregistration, but a
>> CMD_PEER_NEW message comes in adding a new peer that takes again
>> a reference to the netdev.
>>
>> At this point there is no way to release the device because we are
>> under the assumption that all peers were already released.
>>
>> Fix the race condition by releasing all peers in ndo_uninit(),
>> when the netdevice has already been removed from the netdev
>> list and thus an incoming CMD_PEER_NEW cannot have any effect
>> anymore.
>>
>> At this point ovpn_dellink() becomes empty and can just be
>> removed.
>>
>> Reported-by: Hyunwoo Kim <imv4bel@...277...>
>> Closes: https://lore.kernel.org/netdev/aaVgJ16edTfQkYbx@...3012.../
>> Suggested-by: Sabrina Dubroca <sd@...2891...>
>> Fixes: 80747caef33d ("ovpn: introduce the ovpn_peer object")
>> Signed-off-by: Antonio Quartulli <antonio@...515...>
>> ---
>>   drivers/net/ovpn/main.c | 12 ++----------
>>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> Reviewed-by: Sabrina Dubroca <sd@...2891...>
> 
> Thanks. This issue probably got introduced when I made you move some
> stuff from the UNREGISTER notifier into deletion, during the initial
> review.
> 

I also think it was around those times.
This area has been reshuffled quite a bit :)


Will send to net ASAP.

Thanks!

Regards,

-- 
Antonio Quartulli


