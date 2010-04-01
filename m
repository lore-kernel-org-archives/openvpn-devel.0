Message-ID: <4BB4882E.9020805@...1114...>
Date: Thu, 01 Apr 2010 13:49:02 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>	<1ae7a5fdae1e6d71bb7708a4f75ff060e3237c1c.1270060247.git.fabian.knittel@...1338...>	<20100331231158.2782.qmail@...1287...>	<4BB45497.8040707@...1338...>	<4BB46059.9080208@...1147...>
	<20100401091414.24106.qmail@...1287...> <4BB48345.7020408@...1338...>
In-Reply-To: <4BB48345.7020408@...1338...>
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
To: Fabian Knittel <fabian.knittel@...1338...>
Cc: openvpn-devel@lists.sourceforge.net

On 01/04/10 13:28, Fabian Knittel wrote:
> Peter Stuge schrieb:
>> Jan Just Keijser wrote:
>>> FYI: 802.1Q defines VLAN 1 as the 'native' LAN: all packets on VLAN 1 
>>> are *by definition* not encapsulated (according to my CCNA guide ;-))
> [...]
>>> Perhaps we need to make sure that VID 1 means untagged ...
>>
>> Any VID can be untagged. While 1 is the default it can change and
>> OpenVPN shouldn't really care.
>>
>> One alternative approach to using tag 0 would be to introduce a
>> vlan-pvid (or vlan-default-tag) option to set the PVID.
> 
> So packets coming in on the tap device that aren't tagged would be
> assumed to have a vid == PVID.  And packets going out on the tap device
> with a vid == PVID would go out untagged.  (A vid of 0 would continue to
> be rejected as configuration option.)
> Not specifying --vlan-pvid would mean that only tagged packets are
> accepted (and sent).
> 
> I'm still unsure what to do with incoming frames from clients who's vid
> matches the pvid and where the frames contain a full 802.1Q header with
> a non-zero vid.  I'll probably just drop those packets.  Maybe we should
> drop such packets regardless of the PVID value while in --vlan-tagging
> mode.   (Tags in tags are apparently specified by 802.1ad and we don't
> support that anyway.)
> 

Just paying attention to the discussion from the side line.  But just a
simple question from a VLAN newbie.  This discussion here made me think
about something, something which probably is not directly connected to
vid == PVID.

But what kind traffic does hit the OpenVPN clients?  Does the OpenVPN
server send only traffic to the corresponding VLAN the OpenVPN client is
"assigned" to?  Or does it receive packages for all the VLAN's and does
the "filtering" on the client side?

From a security and not the least from a performance perspective, the
OpenVPN clients should only receive traffic which hits it's own VLAN
(ie. the server does the "filtering" before sending data to the client).
 I'm not sure if I saw this in code or not ... but if it is in place and
somebody could point me to the patch which does it, I would be happy.


kind regards,

David Sommerseth

