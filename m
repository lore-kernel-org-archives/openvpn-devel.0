Message-ID: <48ADA8AA.4040704@...1123...>
Date: Thu, 21 Aug 2008 19:40:58 +0200
From: Peter Rabbitson <rabbit+list@...1123...>
MIME-Version: 1.0
References: <48AC1C11.60107@...1123...> <48ADA320.9090708@...41...>
In-Reply-To: <48ADA320.9090708@...41...>
Subject: Re: [Openvpn-devel] Followup to CVE-2008-3459 fix
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: Openvpn-devel@lists.sourceforge.net

James Yonan wrote:
> Peter Rabbitson wrote:

>>
>> Eventually the best way to deal with this is to test for
>> ip_addr_dotted_quad_safe and is_special_addr, and then attempt a dns
>> lookup on the string supplied for route. If anything comes back - use
>> the result as the routed IPs. Otherwise warn and carry on. This would
>> also fix this long-outstanding (not mine) wishlist:
>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=237251
> 
> I agree that this should be fixed, probably via a --route-fqdn-pull
> option (as suggested) on the client to permit DNS lookups on option
> parameters that previously allowed them.
> 

I think if you go with my second suggestion (above) the option becomes
redundant. You can attempt a DNS lookup with pretty much anything (as
far as string goes), and if nothing comes back - well nothing comes back.

In any case, I'm glad this didn't fall off the radar.

Thank you for the excellent software!

Peter


