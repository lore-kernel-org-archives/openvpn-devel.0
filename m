Message-ID: <4BB47EFF.5020005@...1147...>
Date: Thu, 01 Apr 2010 13:09:51 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>	<1ae7a5fdae1e6d71bb7708a4f75ff060e3237c1c.1270060247.git.fabian.knittel@...1338...>	<20100331231158.2782.qmail@...1287...>	<4BB45497.8040707@...1338...>
	<4BB46059.9080208@...1147...> <20100401091414.24106.qmail@...1287...>
In-Reply-To: <20100401091414.24106.qmail@...1287...>
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
To: openvpn-devel@lists.sourceforge.net

Peter Stuge wrote:
> Jan Just Keijser wrote:
>   
>> FYI: 802.1Q defines VLAN 1 as the 'native' LAN: all packets on VLAN 1 
>> are *by definition* not encapsulated (according to my CCNA guide ;-))
>>     
>
> 802.1Q != CCNA..
>
> Look at the spec, Table 9-2 on page 86. (100 in PDF)
>
> VID Use
>   0 "no VLAN identifier is present in the frame"
>   1 "The default PVID value used for classifying frames on ingress ..
>      The PVID value of a Port can be changed by management."
> FFF "Reserved for implementation use."
>
>
>   
be careful here (from table 9.2; I actually have an older copy of the 
802.1Q spec):

The null VLAN ID. Indicates that the tag header contains only priority
information; no VLAN identifier is present in the frame. This VID value 
shall not
be configured as a PVID or a member of a VID Set, or configured in any 
Filtering
Database entry, or used in any Management operation.

so it *does* have priority info in it and it is *not* the same as no 
VLAN identifier ...


cheers,

JJK

