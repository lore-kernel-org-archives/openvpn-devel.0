Message-ID: <4BB450FB.4010307@...1338...>
Date: Thu, 01 Apr 2010 09:53:31 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>	<70dd1e1441bb32df36f449920384f20a3683a2f0.1270060247.git.fabian.knittel@...1338...>
	<20100331230347.1687.qmail@...1287...>
In-Reply-To: <20100331230347.1687.qmail@...1287...>
Subject: Re: [Openvpn-devel] [PATCH 3/9] vlan: Add
	per-client	--vlan-tag	option
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

Hi Peter,

Peter Stuge schrieb:
> Fabian Knittel wrote:
>> +#define OPENVPN_8021Q_MAX_VID 0xFFFE
> 
> The max VID in 802.1q is 4095 = 0xfff.

You are absolutely correct.  Thanks for catching that.  I intended it to
say 0xFFE, because the standard talks about VID values being valid
within the range 0 through 4094 [1].  But OPENVPN_8021Q_MASK_VID should
definitely be defined as 0xFFF, as the bit field is 12 bits.

VID == 0xFFF is "Reserved for implementation use." and "shall not be
configured as PVID [...] or transmitted in a tag header." [2]  But I'm
not sure whether it's used in reality and if you'd like that value to be
accepted, I have no objections.

Thanks again for reviewing!

Cheers
Fabian

1: IEEE Std 8021.Q-2005, "9.6 VLAN Tag Control Information", p.76
2: IEEE Std 8021.Q-2005, Table 9-2, p.76

