Message-ID: <4F338218.1050600@...1147...>
Date: Thu, 09 Feb 2012 09:21:44 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4F324C25.6030908@...1548...> <4F32567E.60209@...1114...>
	<4F3261DE.7050601@...1147...> <4F32746F.2090206@...1548...>
	<4F3276C4.9080105@...1114...>
	<4F3281A2.40303@...1548...> <4F328C87.8070104@...1147...>
	<4F329445.7040103@...1548...> <4F329B2C.8080207@...1147...>
	<4F32A28F.5020500@...1114...>
In-Reply-To: <4F32A28F.5020500@...1114...>
Subject: Re: [Openvpn-devel] Config question
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Paul Bakker <p.j.bakker@...1548...>

Hi David,

David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 08/02/12 16:56, Jan Just Keijser wrote:
>   
>> Hi Paul,
>>
>> Paul Bakker wrote:
>>     
>>> On 8-2-2012 15:53, Jan Just Keijser wrote:
>>>       
>>>> Hi Paul,
>>>>
>>>>
>>>> I can't find why the client would use 'eth0' for the 'tun0'
>>>> network - perhaps if you rerun with 'verb 7' and check for GDG
>>>> messages you will get a clue what openvpn is deciding... As a
>>>> workaround, try adding the second config route-gateway
>>>> 10.100.0.10 redirect-gateway def1
>>>>
>>>> this should tell openvpn that the default GW is 10.100.0.10.
>>>>         
>>> ========================================= Wed Feb  8 16:14:22 2012
>>> us=437713 GDG: route[1] 0.0.0.0/0.0.0.0/172.31.0.1 m=0 Wed Feb  8
>>> 16:14:22 2012 us=437752 GDG: route[2] 
>>> 10.100.0.0/255.255.255.0/0.0.0.0 m=0 Wed Feb  8 16:14:22 2012
>>> us=437786 GDG: route[3] 169.254.0.0/255.255.0.0/0.0.0.0 m=1000 Wed
>>> Feb  8 16:14:22 2012 us=437817 GDG: route[4] 
>>> 172.31.0.0/255.255.255.0/0.0.0.0 m=1 Wed Feb  8 16:14:22 2012
>>> us=437849 GDG: route[5] 192.168.1.18/255.255.255.255/172.31.0.1 m=0 
>>> Wed Feb  8 16:14:22 2012 us=437909 GDG: best=172.31.0.1[1] lm=0 Wed
>>> Feb  8 16:14:22 2012 us=438044 GDG: route[1] 
>>> 0.0.0.0/0.0.0.0/172.31.0.1 m=0 Wed Feb  8 16:14:22 2012 us=438078
>>> GDG: route[2] 10.100.0.0/255.255.255.0/0.0.0.0 m=0 Wed Feb  8
>>> 16:14:22 2012 us=438110 GDG: route[3] 
>>> 169.254.0.0/255.255.0.0/0.0.0.0 m=1000 Wed Feb  8 16:14:22 2012
>>> us=438140 GDG: route[4] 172.31.0.0/255.255.255.0/0.0.0.0 m=1 Wed Feb
>>> 8 16:14:22 2012 us=438171 GDG: route[5] 
>>> 192.168.1.18/255.255.255.255/172.31.0.1 m=0 Wed Feb  8 16:14:22 2012
>>> us=438216 GDG: best=172.31.0.1[1] lm=0 Wed Feb  8 16:14:22 2012
>>> us=438254 ROUTE default_gateway=172.31.0.1 Wed Feb  8 16:14:22 2012
>>> us=439676 TUN/TAP device tun1 opened Wed Feb  8 16:14:22 2012
>>> us=439749 TUN/TAP TX queue length set to 100 Wed Feb  8 16:14:22
>>> 2012 us=439815 do_ifconfig, tt->ipv6=0, 
>>> tt->did_ifconfig_ipv6_setup=0 Wed Feb  8 16:14:22 2012 us=439928
>>> /sbin/ifconfig tun1 172.30.1.2 netmask 255.255.255.0 mtu 1500
>>> broadcast 172.30.1.255 Wed Feb  8 16:14:22 2012 us=445345
>>> /sbin/route add -net 10.100.0.10 netmask 255.255.255.255 gw
>>> 172.31.0.1 Wed Feb  8 16:14:22 2012 us=447721 /sbin/route add -net
>>> 0.0.0.0 netmask 128.0.0.0 gw 172.30.1.1 Wed Feb  8 16:14:22 2012
>>> us=449931 /sbin/route add -net 128.0.0.0 netmask 128.0.0.0 gw
>>> 172.30.1.1 =========================================
>>>
>>> So indeed it seems to think the default gateway should be
>>> 172.31.0.1, which is correct.. While for adding a static route for
>>> an ip (10.100.0.10) in this case, it is making the wrong choice. It
>>> can deduce that route[2] would be used (which has interface tun0)
>>> instead of the default route.. So this is a bug in OpenVPN handling
>>> the redirect-gateway def1 command and adding the static route..
>>>
>>> Adding the redirect gateway solves the problem, but is not viable in
>>> my setup, so I'm going for a manual add at this point in time. If
>>> this ever gets fixed in OpenVPN i'll move back to the
>>> redirect-gateway.
>>>
>>>       
>> this indeed looks like a (minor) bug: - the second layer openvpn
>> server is reachable via _A_ local network (10.100.0.0/24) - you've
>> requested 'redirect-gateway' - for safety reasons openvpn then adds a
>> direct route to the VPN server via the original gateway (10.100.0.10
>> via 172.31.0.1)
>>
>> a workaround is to add 'redirect-gateway def1' to the inner layer VPN
>> as well.
>>     
>
> Just to be sure we're not trying to fix something which might be fixed.
> Which version of OpenVPN are you testing this on?  The later master
> branch or a 2.2 release?
>
> The reason for asking is that I know James Yonan did some additions to
> the routing code lately, also solving some --redirect-gateway issues.
> I'm far from convinced it's really related.  But it's close enough to
> check out.
>
> <http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=commitdiff;h=8fc83a2d6cfa44032f38e13fc2f7dbc096f584d9>
>
>   

I'll check the sources later today... what Paul is seeing is triggered 
by the fact that in this particular case you do NOT want the /32 route 
to the VPN server via the original default gateway. It might be 
worthwhile to add this as an option to OpenVPN. A scenario like this 
does not apply only to the double tunnel scenario, but also the following:

- client has 2 network interfaces, eth0 and eth1
- eth0 is connected to the default GW, e.g. 172.31.0.1
- eth1 is connected to another LAN, 10.100.0.0/24
- the OpenVPN server is on this other LAN, 10.100.0.10

if the client connects and wants to redirect the GW, an extra route is 
added 10.100.0.10/32 *via the original GW* : this route overrules the 
LAN route '10.100.0.0/24 via eth1'

Perhaps it's possible to determine via which interface openvpn is 
talking to the server - we could then decided whether to add the /32 
route or not. A user-override option would also be useful in this case.

cheers,

JJK


