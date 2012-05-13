Message-ID: <4FB031B7.5010704@...1227...>
Date: Mon, 14 May 2012 00:12:07 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Disable tun-ipv6 warning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hey,

Openvpn will show the following warning, if I enable tun-ipv6 in the
local config and not remote or vice versa:

WARNING: 'tun-ipv6' is present in remote config but missing in local
config, remote='tun-ipv6'

From my understanding a ipv6 capable tun interface is always capable of
ipv4 only. (On android there is no difference at all). Even without
explicitly stating "tun-ipv6" openvpn will happily configure the ipv6
options. Is there anything this message warns about? (I know the obvious
the configs do not match).

If the server does not push any ipv6 related messages running with
tun-ipv6 works fine, and if the server does push ipv6 messages it works
fine too.

Forgive me if I am missing something obvious.

Arne


