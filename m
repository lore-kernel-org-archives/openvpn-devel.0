Date: Thu, 29 Apr 2010 09:03:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100429070322.GW12312@...1296...>
References: <i2j251896ce1004282102v38fd0e79l2a222c4501dad9db@...278...>
Mime-Version: 1.0
In-Reply-To: <i2j251896ce1004282102v38fd0e79l2a222c4501dad9db@...278...>
Subject: Re: [Openvpn-devel] [PATCH] TAP interface support for
	Solaris/OpenSolaris
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
To: Kazuyoshi Aizawa <admin2@...628...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Apr 29, 2010 at 01:02:37PM +0900, Kazuyoshi Aizawa wrote:
> I've attached a patch for tun.c which includes support for tap
> interface for solaris/opensolaris.
> The code is based on OpneVPN 2.1.1. And it has a routine to
> plumb/unplumb tap interface like ifconfig command.
> 
> tap driver for solarsi/opensolaris is here:
>       http://www.whiteboard.ne.jp/~admin2/tuntap/

Thanks for your work!.  I have already used bits from there when adding 
IPv6 payload support to OpenVPN on Solaris :-)

Question to the community: how do we want to integrate the tun.c changes
for Solaris?  Its own branch, feat_misc branch, feat_ipv6_payload branch?

If we include it in feat_ipv6_payload, it won't have merge conflicts - but
then you only get the TAP-on-Solaris in combination with all the IPv6 stuff,
which people might not want.

David?

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

