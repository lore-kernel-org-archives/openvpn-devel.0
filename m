Message-ID: <4F8DA6C8.60809@...1698...>
Date: Tue, 17 Apr 2012 21:22:16 +0400
From: Sergey Matveychuk <sem@...1698...>
MIME-Version: 1.0
References: <4F8D6C6F.3080403@...1698...> <20120417141612.GF1359@...1296...>
In-Reply-To: <20120417141612.GF1359@...1296...>
Subject: Re: [Openvpn-devel] adding ipv6 routes wrong for tap
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
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

17.04.2012 18:16, Gert Doering wrote:
> Hi,
>
> On Tue, Apr 17, 2012 at 05:13:19PM +0400, Sergey Matveychuk wrote:
>> I see openvpn adds ipv6 routes always for interface not addresses. I
>> think it should be like in add_route(): something like is_on_link() to
>> determ if interface should be added or address.
>
> IPv6 routes on TAP doesn't work yet, yes.  This is a documented shortcoming
> and I'll fix it as soon as possible (which might not be as soon as you
> hope for).  TUN works, or setting the routes manually from an "up" script.
>

Rough changing route command works for me:

argv_printf (&argv, "%s add -inet6 %s/%d %s",
		ROUTE_PATH,
	        network,
	        r6->netbits,
	        gateway );

But I understand it should be done correctly.

