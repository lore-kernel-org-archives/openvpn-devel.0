Message-ID: <4F33956F.9060707@...1388...>
Date: Thu, 09 Feb 2012 22:44:15 +1300
From: Michal Ludvig <mludvig@...1388...>
MIME-Version: 1.0
References: <4F333427.70808@...1388...>
	<20120209082057.GG13929@...1296...>
In-Reply-To: <20120209082057.GG13929@...1296...>
Subject: Re: [Openvpn-devel] route-ipv6 parameters & route prefixes
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

On 02/09/2012 09:20 PM, Gert Doering wrote:
> Hi,
>
> On Thu, Feb 09, 2012 at 03:49:11PM +1300, Michal Ludvig wrote:
>> I'm used to pushing route options to the clients with explicit metrics.
>> That works good for IPv4 with e.g.:
>> push "route 192.168.128.0 255.255.240.0 vpn_gateway 200"
>>
>> However route-ipv6 doesn't accept the 'vpn_gateway' keyword and
>> therefore I can't easily set a metric. I could indeed put the actual
>> server IP in there but that's less flexible, partly because I have this
>> routes section in a separate file included in multiple configs on the
>> same machine.
> What are you trying to achieve?

I'm trying to set a metric for IPv6 route pushed from the OpenVPN server.

Long story, if you're asking why, is: we've got multiple OpenVPN 
gateways to our network, each in a different location. A VPN user can 
connect to any of them, or to more then one, and must have access to the 
whole network. Obviously I'm pushing the prefixes local for each 
location with a lower metric and the non-local prefixes with a higher 
metric. That way, even if a user has a tunnel up to two or more 
locations, the traffic to each location is always routed through the 
most direct tunnel with the lowest metric.

To make things a little more complicated I have both UDP and TCP 
endpoints in each location (TCP is there for users behind HTTP proxies 
for example) and most of their configs are shared, therefore I use the 
"vpn_gateway" placeholder that gets replaced for the VPN IP of the 
actual server, which is different between UDP and TCP on the same 
gateway. Without that placeholder I can't share the config with "push 
route-ipv6" options between UDP and TCP instances.

So that's what I'm trying to achieve. Hope that makes sense :)

Michal

