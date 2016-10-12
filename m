References: <20160916161354.GM78279@...1296...>
	<1476263591-12401-1-git-send-email-arne@...1227...>
	<CAEsd45Tkkmbp=qbgVZxAt-U3hkLBQemOxDGRjTucLCoJPM+bTg@...278...>
	<026a4dab-8aac-7edb-4f58-4fbacfe56795@...1227...>
	<CAEsd45QhH3=xo-0A3QZe0eqp4gBM7T9WOvJ0Bu4+GFKJbRrtUg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <190fba8c-900c-3805-4afa-95c2f4af7974@...1227...>
Date: Wed, 12 Oct 2016 15:12:24 +0200
MIME-Version: 1.0
In-Reply-To: <CAEsd45QhH3=xo-0A3QZe0eqp4gBM7T9WOvJ0Bu4+GFKJbRrtUg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4] Remove tun-ipv6 Option. Instead
 assume that IPv6 is always supported.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> What I should have asked is: with this patch will an OpenVPN client
> still send out IPv4 packets if there are no IPv6 options specified or
> pulled from the server?

In short: Behave exactly as before.

Longer explaination:

Without the patch OpenVPN refuses ifconfig-ipv6 and route-ipv6 without
tun-ipv6 option because the tun device has not been configured in a IPv6
safe way. With patch it does not refuse the commands.


The problem that tun-ipv6 solved was "Method A works with IPv6/IPv4 but
might break on old versions of Linux(?) and Method B always works but
only IPv4".

On Linux the tun device has been opend/configured in different ways for
tun-ipv6 and non tun-ipv6 which are both IPv4/IPv6 capable (prepend a
header to packet/do not prepend a header) for reasons that are probably
lost in history. The patch unifies that to never prepends headers (IPv4
behaviour and Android behaviour).

For OS X tun (and utun) has always been opened in the same way no matter
if tun-ipv6 was specifiied. So only change for OS X is no longer
refusing ifconfig-ipv6 and route-ipv6 without tun-ipv6 option.
 

Arne

