From: Charles Duffy <cduffy@...294...>
Date: Sat, 17 Jun 2006 08:40:50 -0500
Message-ID: <e710p7$8ic$1@...165...>
References: <20060617152151.6ce2f63f.mailinglists@...673...>
Mime-Version: 1.0
In-Reply-To: <20060617152151.6ce2f63f.mailinglists@...673...>
Sender: news <news@...165...>
Subject: Re: [Openvpn-devel] ovpn server on udp with multiple gateways
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

richard lucassen wrote:
> Is there a (simple) way to let OpenVPN use the same source address to
> which the connection was set up like in the following example?
> 
> - set up tunnel x.x.x.x to dst address 1.1.1.2
>   return src address 1.1.1.2 to x.x.x.x
> - set up tunnel x.x.x.x to dst address 2.2.2.2
>   return src address 2.2.2.2 to x.x.x.x
> - set up tunnel x.x.x.x to dst address 3.3.3.2
>   return src address 3.3.3.2 to x.x.x.x

OpenVPN 2.1-beta3 merged a patch adding multihoming support. Multihoming 
can be enabled or disabled at build-time, but should be enabled by 
default if your OS supports it. There's a new "multihome" configuration 
directive to enable this functionality if your build has support.

(BTW, this is a usage question rather than a development one; it should 
go to OpenVPN-users, not OpenVPN-devel. That said, searching the 
OpenVPN-devel archives for "multihome" should be interesting if you're 
curious for the discussion surrounding the patch when it was initially 
submitted).


