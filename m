From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Status and Roadmap for IPv6 Support
In-Reply-To: <20050701174909.G11246@...283...>
Message-ID: <Pine.LNX.4.58.0507060201340.27761@...41...>
References: <42C29B31.4010202@...428...> <Pine.LNX.4.58.0506291113130.27900@...41...>
 <42C3AD6E.1080907@...428...> <20050701174909.G11246@...283...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Jul  6 01:08:02 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: JuanJo Ciarlante <jjo-ipsec@...283...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 1 Jul 2005, JuanJo Ciarlante wrote:

> On Thu, Jun 30, 2005 at 10:29:34AM +0200, Hartmut Goebel wrote:
> > Hello,
> > 
> > Thanks for your answer.
> > 
> > >>1a) As far as I've found out, OpenVPN 2.0 supports forwarding IPv6 when
> > >>using tun+tun-ipv6 or tap. But neither of the build-in commands (like
> > >>route, ifconfig, server, push/pull) supprot IPv6-addresses or IPv6
> > >>Name-lookup.
> > >>
> > >>Is this correct, or have I overlooked something?
> > > 
> > > 
> > > That is correct for OpenVPN 1.6 and 2.0...  But JuanJo Ciarlante's IPv6 
> > > patch against 2.0 adds IPv6 support in a much more substantial way.
> > 
> > I tested this patch but it seams to only target issues about forwarding
> > IPv6 packets. OpenVPn options/commands like 'route' are anchanged and
> > still not able to handle IPvp addresses. This is since
> > openvpn_inet_aton() does only suppport dotted quads.
> > 
> > Or have I overlooked something?
> 
> Indeed my patch adds OpenVPN/IPv6 streams (udp6,tcp6) support , and nothing about
> IPv6/OpenPVN links (albeit some ipv6-related infrastructure that could be used in
> this respect in the future).

Any interest in working on this?  It seems to be the last hurdle to get 
IPv6 support in OpenVPN up to the same level as IPv4.

James

