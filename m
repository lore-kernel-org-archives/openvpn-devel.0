Message-ID: <4BB46059.9080208@...1147...>
Date: Thu, 01 Apr 2010 10:59:05 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>	<1ae7a5fdae1e6d71bb7708a4f75ff060e3237c1c.1270060247.git.fabian.knittel@...1338...>	<20100331231158.2782.qmail@...1287...>
	<4BB45497.8040707@...1338...>
In-Reply-To: <4BB45497.8040707@...1338...>
Subject: Re: [Openvpn-devel] [PATCH 4/9] vlan: Prepend and
 remove	VLAN	identifiers on outgoing and incoming frames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Fabian Knittel <fabian.knittel@...1338...>
Cc: openvpn-devel@lists.sourceforge.net

Fabian Knittel wrote:
> Peter Stuge schrieb:
>   
>> Fabian Knittel wrote:
>>     
>>> +  if (ntohs (vlanhdr.tpid) != OPENVPN_ETH_P_8021Q)
>>> +    {
>>> +      /* Drop untagged frames */
>>> +      goto err;
>>> +    }
>>>       
>> It would be nice to be able to use VID 0 to mean untagged packets.
>>     
>
> Hm, nice idea.  I'll implement it in my next round of patches.
>   
FYI: 802.1Q defines VLAN 1 as the 'native' LAN: all packets on VLAN 1 
are *by definition* not encapsulated (according to my CCNA guide ;-))
VID 0 means "priority frames"
Perhaps we need to make sure that VID 1 means untagged ...

For more details, see http://www.javvin.com/protocolVLAN.html

cheers,

JJK


