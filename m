Message-ID: <559672D0.1030904@...1147...>
Date: Fri, 03 Jul 2015 13:32:32 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <55966BE0.5090400@...1147...> <55966F4A.7010008@...1114...>
In-Reply-To: <55966F4A.7010008@...1114...>
Subject: Re: [Openvpn-devel] Adding routes on Windows using DHCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi David,

David Sommerseth wrote:
> On 03/07/15 13:02, Jan Just Keijser wrote:
>   
>> hi all,
>>
>> whilst writing the TFTP/WPAD patch I stumbled upon the options to set a 
>> default gateway and/or routes using DHCP options.
>> I've patched openvpn to also set DHCP option 3 ("gateway") and indeed, 
>> windows picks up the route supplied to it  :)
>>
>> This might be a way to address this topic from the IRC meeting:
>>
>> Windows 8.1 DNS registration issues
>>
>>     * ipconfig failing to execute during VPN connection
>>       <https://community.openvpn.net/openvpn/ticket/516>
>>     * Who will fix and how?
>>
>>
>> It's even possible to run openvpn without admin privileges and set 
>> routes this way!
>> Before you get too excited: it does not seem to be possible to replace 
>> an existing default GW this way. the new 0.0.0.0 route has the metric of 
>> the tap-win32 adapter , which is better than that of a wifi adapter but 
>> worse (30 == higher) than that of a regular LAN Adapter (metric=10).
>>
>> Before I go any deeper into this: what does the rest think about setting 
>> routes on Windows this way? It could be a nice way to circumvent all 
>> kinds of "route add" problems.
>>     
>
> Okay, it's bold of me having opinion on the Windows, who have not used
> Windows on his personal or work computers the last 15 years.
>
> But I generally think this sounds like a really good idea.  I understand
> doing the routing tricks for --redirect-gateway won't work - and I can
> personally live with that.  I do like that openvpn today then can run
> without privileges,
>
> A few questions though
>
> * Can you push several routes via DHCP?  Or just a single one?
> If you can push multiple routes, then I'd say we should look into adding
> a check if --redirect-gateway + non-admin privileged user => provide an
> solid warning in the logs that redirecting won't work without proper
> privileges.
>   
yes this is possible; it's possible to push multiple gateways and 
multiple (classless) routes (dhcp options 121 & 249).
If the metric on the tap-win adapter is set manually and is set low 
enough the redirecting the gateway will also work.
However, changing the metric requires evelated access...

> * What about IPv6?
> Can you push IPv6 routes the same way?  Will that also work without privileges?
>   
How are IPv6 addresses handled by OpenVPN / tap-win32 ? IPv6 comes with 
DHCPv6 which also includes support for pushing routes&gateways. It needs 
further investigation, however.


JJK


