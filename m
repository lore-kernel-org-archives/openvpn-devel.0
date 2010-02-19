Date: Fri, 19 Feb 2010 23:42:49 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100219224249.GE9556@...1296...>
References: <4B7E71A5.3020806@...1114...>
	<20100219134650.GR9556@...1296...>
	<4B7EA05C.5000802@...1114...>
	<20100219145623.GU9556@...1296...>
	<jwvk4u9ce0t.fsf-monnier+inbox@...1269...>
	<20100219193304.GZ9556@...1296...>
Mime-Version: 1.0
In-Reply-To: <20100219193304.GZ9556@...1296...>
Subject: Re: [Openvpn-devel] [IPv6] Merge conflicts in mroute.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Stefan Monnier <monnier@...1282...>
Cc: Openvpn-devel@lists.sourceforge.net

Hi,

On Fri, Feb 19, 2010 at 08:33:04PM +0100, Gert Doering wrote:
> > [uclibc without UCLIBC_HAS_IPV6]
> 
> I have to investigate.

And so I did.  The impact of UCLIBC_HAS_IPV6=0 is fairly low:

 - getaddrinfo() will not resolve IPv6 addresses (but *will* be available)
 
 - the external globals in6addr_any and in6addr_loopback will not
   be compiled in (in6_addr.c).

   ** I expect this to cause linking problems for my code **

 - inet_ntop6() and inet_pton6() will not be compiled-in - both are only
   called indirectly, from inet_ntop() and inet_pton(), respectively, for
   af AF_INET6.  So trying to convert IPv6 addresses will fail at run-time.

   [side note: that's actually the same code as in the FreeBSD libc, 
   and as such, fully threadsafe :-) )

 - __opensock() refuses AF_INET6 sockets at run-time

 - the resolv.c functions (gethostbyname2, gethostbyaddr, __dns_lookup, 
   __read_etc_hosts_r, gethostent, ...) will not resolve / handle IPv6
   addresses 


 - the relevant *definitions* (struct in6_addr etc) are all there, all
   the time, and not depending on UCLIBC_HAS_IPV6.


I don't have a system available for testing, but I would expect that 
OpenVPN with my patches compiled/linked against an IPv4-only uClibc
would fail due to unavailability of "in6addr_any", which can be fairly
easily worked-around  [reports welcome!].   

The other stuff should not cause any adverse run-time effects - if IPv6 
isn't compiled in the library, OpenVPN will just not accept 
"--ifconfig-ipv6" and similar commands (because parsing the IPv6 
addresses fails, and thus the addresses are refused as "invalid"), but 
everything else will just work as-is.

As said: I would welcome contact to someone who is using uClibc+OpenVPN
and could help me test this and adapt the code if needed.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

