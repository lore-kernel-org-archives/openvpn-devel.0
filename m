Date: Sat, 20 Feb 2010 11:25:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100220102527.GG9556@...1296...>
References: <4B7E71A5.3020806@...1114...>
	<20100219134650.GR9556@...1296...>
	<4B7EA05C.5000802@...1114...>
	<20100219145623.GU9556@...1296...>
	<jwvk4u9ce0t.fsf-monnier+inbox@...1269...>
	<20100219193304.GZ9556@...1296...>
	<20100219224249.GE9556@...1296...> <1266620011.31441.15@...1207...>
Mime-Version: 1.0
In-Reply-To: <1266620011.31441.15@...1207...>
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: Openvpn-devel@lists.sourceforge.net, Stefan Monnier <monnier@...1282...>

Hi,

On Fri, Feb 19, 2010 at 04:53:31PM -0600, Karl O. Pinc wrote:
> > As said: I would welcome contact to someone who is using
> > uClibc+OpenVPN
> > and could help me test this and adapt the code if needed.
> 
> To run the risk of harping on a theme....
> 
> If the problem is that someone is './configure --no-ipv6'-ing
> ipv6 away then maybe openvpn needs to have a similar ./configure
> option?  Or could ./configure just test against UCLIBC_HAS_IPV6?

This is where this discussion started: do we really need to #ifdef
the IPv6 related code in OpenVPN, or can we assume that any recent OS
that has tun/tap will provide the necessary functions anyway.

Adding lots of #ifdefs doesn't improve code readability and feature 
testing, and makes future maintenance harder (because it's not always
obvious if something you change might break a different combination of
optional compile-time features that what you use).

For uClibc, the answer could be "it should be sufficient to just define 
'in6_addr_any' locally in OpenVPN code, if uClibc is detected" - that's 
just 16 bytes of static data.

gert

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

