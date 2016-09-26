Message-ID: <57E907AE.5060100@...1147...>
Date: Mon, 26 Sep 2016 13:34:06 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1474666458.11690.23.camel@...1866...>		
	<57E5A654.60503@...1147...>
	<1474672864.11690.27.camel@...1866...>	
	<57E7E1FB.9070202@...1147...>
	<1474817465.11690.54.camel@...1866...>
In-Reply-To: <1474817465.11690.54.camel@...1866...>
Subject: Re: [Openvpn-devel] p2p topology on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@...1866...>, openvpn-devel@lists.sourceforge.net

Hi David,

On 25/09/16 17:31, David Woodhouse wrote:
> On Sun, 2016-09-25 at 16:40 +0200, Jan Just Keijser wrote:
>> thanks for clarifying - but with OpenVPN 2.4 the default topology mode
>> will be 'subnet topology', in which we also assign a single IP address
>> to each client. Is there a (fundamental) difference between these two?
> Subnet topology is nice if you *have* a subnet. At least you only
> "waste" one network and one broadcast address for your entire subnet,
> rather than wasting three IP addresses per client as with the 'net30'
> topology.
>
> But still the true point-to-point mode allows absolutely *no* wastage,
> and can be used in circumstances where you really *can't* just dedicate
> a subnet to the purpose. If you have a thousand clients, then sure the
> wastage of the subnet topology is in the noise. If you have just one
> client then it's just the same as net30, because that's what you
> actually end up doing.
>
> One example that comes to mind is if a machine is being rehomed from a
> known IP address on a given subnet, but which still needs to be
> reachable on its original IP address. Another machine on the original
> subnet can be set up to do proxy ARP for it on the real Ethernet, and
> route its packets over OpenVPN... but you can't just use that subnet
> for the VPN.
>
> But mainly it just offends me that this is supported on other
> platforms, but it *doesn't* work on Windows.... and I think it could.
thanks for clarifying.
this sounds like a typical use case for "assign a public IP address". 
This is already possible with topology subnet and some special config 
stuff on the server side, e.g.
- give the openvpn server an IP range that overlaps with existing 
(server-side) IP space
- don't assign address from a large DHCP pool, but use a client-connect 
script to assign an address per certificate
- use proxy arp and some routing tricks to ensure that all client 
traffic is routed properly via the server.

the one thing I'm afraid of with your new type of p2p addressing is that 
we'd introduce yet-another topology system: net30, "old" p2p, subnet and 
now "new" p2p - or would this simply be an extension of the never-used 
"old" p2p topology?

cheers,

JJK




