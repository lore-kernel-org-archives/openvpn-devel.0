Date: Sun, 21 Feb 2010 20:31:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100221193132.GO9556@...1296...>
References: <7bb795fd1002211100l760645cfl1a3cfc07ebd91e4@...278...>
Mime-Version: 1.0
In-Reply-To: <7bb795fd1002211100l760645cfl1a3cfc07ebd91e4@...278...>
Subject: Re: [Openvpn-devel] [PATCH] make ipv6_payload compile under
	windowze ( feat_ipv6_payload branch )
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
To: JuanJo Ciarlante? <jjo@...410...>
Cc: Bernhard Schmidt <berni@...376...>, openvpn-devel@lists.sourceforge.net

Hi,

On Sun, Feb 21, 2010 at 08:00:27PM +0100, JuanJo Ciarlante?  wrote:
> This patch makes ipv6_payload successfully cross *compile*
> (and just that :) under my mingw32msvc setup on Linux.

Oh, cool!  Thanks a lot for that.

I'll try to figure out how to setup a cross-compile environment 
during next week, and then I'll try to figure out how to get the
IPv6 ifconfig & IPv6 route stuff done (if nothing else helps, run
"netsh" commands to do the work...).

> Because same syshead.h changes are already included in
> feat_ipv6_transport, it may merge-conflict applying it over
> allmerged once the latter includes ipv6_transport.

Shouldn't git sort this out, if it's exactly the same change?

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

