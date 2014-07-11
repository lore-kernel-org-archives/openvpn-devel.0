Message-ID: <53BFF9BE.1090204@...1147...>
Date: Fri, 11 Jul 2014 16:50:38 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <53BF9998.5020906@...1921...> <53BFA5AA.4070305@...1147...>
	<53BFA759.7060307@...1227...> <53BFA9A0.3020605@...1147...>
	<53BFACDE.9050609@...1227...> <53BFAF81.2080705@...1147...>
	<53BFC22C.5010601@...1227...>
In-Reply-To: <53BFC22C.5010601@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server
 configuration file
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Arne Schwabe wrote:
>> Fri Jul 11 11:31:28 2014 OpenVPN ROUTE: OpenVPN needs a gateway
>> parameter for a --route option and no default was specified by either
>> --route-gateway or --ifconfig options
>> Fri Jul 11 11:31:28 2014 OpenVPN ROUTE: failed to parse/resolve route
>> for host/network: 192.168.4.0
>> Fri Jul 11 11:31:28 2014 TUN/TAP device tun0 opened
>>
>>
>> so the 'server' macro does not seem to properly publish this in all
>> cases.
>>
>>     
> I sent a patch to the list which should fix that use case. Can you test
> that patch and if it works for you too?
>
>   

the patch works on the 2.3 branch.
the master branch (from openvpn-testing) currently does not build on 
either CentOS 5 and 6.

JJK



