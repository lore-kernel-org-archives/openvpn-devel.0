Message-ID: <48ADA320.9090708@...41...>
Date: Thu, 21 Aug 2008 10:17:20 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <48AC1C11.60107@...1123...>
In-Reply-To: <48AC1C11.60107@...1123...>
Subject: Re: [Openvpn-devel] Followup to CVE-2008-3459 fix
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
To: Peter Rabbitson <rabbit+list@...1123...>
Cc: Openvpn-devel@lists.sourceforge.net

Peter Rabbitson wrote:
> Hello,
> 
> I would like to duplicate a concern about the proposed fix, voiced over
> at the debian BTS
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=493488#29, before the
> final version ships.
> 
> =========================================================
> This fix breaks the following setup:
> 
> 1) Server A provides openvpn connectivity to clients
> 2) Servers X Y and Z are configured as VPN clients and provide some http
> services both to the outside internet and to any VPN clients.
> 3) The http services are configured in a way that mandates password
> authentication via an SSL channel, except when communicating with other
> VPN clients.
> 4) Server A supplies 'push "route hostname.of.[X|Y|Z].server"', because
> the servers in question are development machines, which can (and do)
> change their IP addresses rather frequently.
> 
> With the current "fix" point 4 becomes impractical, and now besides
> updates to the dns (which are automatic) I have to update the server
> config every time something changes (which unfortunately is manual).
> ========================================================
> 
> Eventually the best way to deal with this is to test for
> ip_addr_dotted_quad_safe and is_special_addr, and then attempt a dns
> lookup on the string supplied for route. If anything comes back - use
> the result as the routed IPs. Otherwise warn and carry on. This would
> also fix this long-outstanding (not mine) wishlist:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=237251

I agree that this should be fixed, probably via a --route-fqdn-pull 
option (as suggested) on the client to permit DNS lookups on option 
parameters that previously allowed them.

James


