From: Gert Doering <gert@...1296...>
Date: Sun, 10 Jun 2012 17:41:26 +0200
Message-Id: <1339342891-28443-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] some missing pieces for 2.3_alpha2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

somewhat unexpectedly, I had two days of free time at my hand, and 
here are what I consider the last missing pieces for basic IPv6 support
in 2.3_alpha2 (the route-gateway handling for IPv6), plus a bit of 
cleanup that crossed my way doing this.

The code changes affect Linux iproute2, Linux ifconfig, FreeBSD and
MacOS X (Darwin) and have been thoroughly tested on each affected OS 
(t_client tests with the current "official" set but now with indirect 
ping for test set 4 - which didn't work on those platforms before! - 
and manually staring at the routes).  

TAP on MacOS 5 shows some funny effects with IPv6 routes pointing to 
non-existant next-hops on tap interfaces, but that seems to be an 
operating system thing, and nothing OpenVPN can do about it.  (Well: 
don't install such routes, and everything works fine :) ).

This patch set basically incorporates the work that Scott Zeid sent to 
the list 10 months ago (<1314694036-3749-1-git-send-email-s@...1497...>),
but his doesn't work - on the BSDs, you can't use "-iface <dev>"
together with a gateway spec, it must be either-or.  Nevertheless,
thanks for this groundwork.

Please review and ACK :-)

gert


