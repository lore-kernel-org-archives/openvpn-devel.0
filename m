Date: Fri, 19 Feb 2010 20:33:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100219193304.GZ9556@...1296...>
References: <4B7E71A5.3020806@...1114...>
	<20100219134650.GR9556@...1296...>
	<4B7EA05C.5000802@...1114...>
	<20100219145623.GU9556@...1296...>
	<jwvk4u9ce0t.fsf-monnier+inbox@...1269...>
Mime-Version: 1.0
In-Reply-To: <jwvk4u9ce0t.fsf-monnier+inbox@...1269...>
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

On Fri, Feb 19, 2010 at 12:50:10PM -0500, Stefan Monnier wrote:
> >> I'm fine with whichever path you choose.  But just bear in mind, some
> >> systems might not have IPv6 support - which breaks portability ...
> > On the unixish side, there is no system which has tun/tap today but
> > does not have IPv6.
> 
> What about embedded systems using uclibc compiled "without ipv6 support"?

I have not yet encountered any such system.  That doesn't mean they don't
exist, it's just "I have not yet seen them".  

My OpenWRT does IPv6, and that's the smallest system I have.


> Or is that some different kind of "support" that wouldn't affect your code?

I have to investigate.

I'd assume that the necessary header files (that provide necessary compile-
time things like "struct in6_addr") are still complete, and that only the
run-time which is installed on the device itself will be reduced.

If the net effect of the change is "function calls like inet_ntop() are
there but refuse to handle AF_INET6 things (with an error message)", it 
won't break OpenVPN - the IPv6 stuff will not work, but it will not break
the IPv4 stuff.

If the net effect is "dynamic linking fails because inet_ntop() or
getaddrinfo() are not even available in the library", this would be very
bad - but it would be surprising, since developers have been told to
use the address-family independent functions (like getaddrinfo()) for
10 years now, so this would break more applications.

gert

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

