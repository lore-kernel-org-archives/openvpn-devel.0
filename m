From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 11 Nov 2015 10:05:11 +0200
Message-ID: <5642F6B7.7090902@...277...>
References: <1447079709-17806-1-git-send-email-lstipakov@...277...>
	<20151109145555.GE24952@...1296...>
Mime-Version: 1.0
In-Reply-To: <20151109145555.GE24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Use adapter index instead of name
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
Cc: Olli Mannisto <olmannisto@...277...>

Hi,

>
> It should actually be not very hard - we should be able to set "tt->actual"
> to read "interface=nnn", and then it should work automagically without even
> touching route.c at all

Setting "interface=<idx>" to "tt->actual_name" will affect all code 
branches which use that value, for example "netsh_enable_dhcp". In this 
particular case we cannot use index and must use interface name, 
according to MS 
(https://technet.microsoft.com/en-us/library/cc731521(v=ws.10).aspx#BKMK_setaddress)

Same documentation claims that "set/delete address" accepts interface 
index only for ipv6. That said, "add/delete route" accepts index for 
both ipv4/ipv6. Besides, ipv4 syntax for "set address" is "[ name =] 
InterfaceName" and ipv6 is "[[ interface=] String]".

So, if we want to use index also for "add/del route", I'd gently modify 
add/del_route_ipv6 and make it use "interface=<idx>" (without breaking 
"vpn server special route" case).

> What does surprise me, though, is that it works for you with just specifying
> the interface index, without "IF" or "interface=" before it.
>

MS says "[[ interface=] String] Specifies an interface name or index" 
for "set address" and "add route". If I read it right, "interface" 
prefix can be omitted. But let's use it for consistency with existing code.

-Lev






