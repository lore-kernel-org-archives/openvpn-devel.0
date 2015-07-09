Message-ID: <559E5EC9.8010106@...1147...>
Date: Thu, 09 Jul 2015 13:45:13 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <55966BE0.5090400@...1147...> <55966F4A.7010008@...1114...>
	<559672D0.1030904@...1147...> <20150703115639.GC57772@...2041...>
	<20150703131545.GZ382@...1296...>
	<5596980F.6010600@...1147...> <559D4F39.5000603@...1147...>
	<20150708185945.GV382@...1296...>
In-Reply-To: <20150708185945.GV382@...1296...>
Subject: Re: [Openvpn-devel] Adding routes on Windows using DHCP
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Yo,

Gert Doering wrote:
> Hi,
>
> On Wed, Jul 08, 2015 at 06:26:33PM +0200, Jan Just Keijser wrote:
>   
>>> AFAICT windows does support that option (that's what I was referring 
>>> to with options 121 or 249) . OTOH, I am *not* sure if it allows you 
>>> to set a 0.0.0.0/1 route using that option, but I guess there's only 
>>> one way to find out.
>>>       
>> FWIW: I've patched openvpn to set routes using DHCP on Windows and yes, 
>> it works: I can add any route to the system routing tables, including 
>> 0.0.0.0/1 and 128.0.0.1/1 ; this could be used as an alternative to 
>> requiring elevated privileges.
>>     
>
> Unless you can also set the host route for the VPN gateway (point to 
> a gateway on a *different* interface), this is not really helping...  
> just adding 2x /1 will just cause recursion as packets to the VPN server 
> will be happily routed into the tap interface again.
>   

as usual, Gert is right :(
I've added an explicit /32 route to the OpenVPN server via DHCP , which 
Windows picks up, including the right LAN GW address *BUT* it associates 
it with the VPN interface, not the regular LAN interface. Thus you end 
up with a "bite your own tail" route and the VPN collapses.

So I guess the only thing this DHCP-trick is useful for is if you're not 
redirecting all traffic - in that case you can run openvpn in 
non-privileged mode and set a bunch of routes to go over the VPN, just 
not the default route.

@Selva: my current patch contains hardcoded addresses and is just a 
proof-of-concept. I cannot share the executable with you.


JJK

