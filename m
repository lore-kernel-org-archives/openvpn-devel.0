Message-ID: <4BB45497.8040707@...1338...>
Date: Thu, 01 Apr 2010 10:08:55 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>	<1ae7a5fdae1e6d71bb7708a4f75ff060e3237c1c.1270060247.git.fabian.knittel@...1338...>
	<20100331231158.2782.qmail@...1287...>
In-Reply-To: <20100331231158.2782.qmail@...1287...>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Peter Stuge schrieb:
> Fabian Knittel wrote:
>> +  if (ntohs (vlanhdr.tpid) != OPENVPN_ETH_P_8021Q)
>> +    {
>> +      /* Drop untagged frames */
>> +      goto err;
>> +    }
> 
> It would be nice to be able to use VID 0 to mean untagged packets.

Hm, nice idea.  I'll implement it in my next round of patches.

Cheers
Fabian

