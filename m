From: Antonio Quartulli <a@...2181...>
Date: Fri,  8 Jun 2018 13:20:09 +0800
Message-Id: <20180608052017.6696-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v2 0/5] Allow IPv6-only tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <a@...2181...>

This patchset allows clients and servers to work with a
tunnel configured with IPv6 only.

Patch 3 is a mere cosmetic change and could be merged
regardless of the rest.

With this change a server can be configured by using only the
'--server-ipv6' directive.
This will result in clients receiving only 'ifconfig-ipv6'
setting in their push-reply (and no IPv4 at all).


Differences from v1:
- more windows logic has been added to ensure client is properly started
  and configured with IPv6 only;
- warning messages added when trying to add IPv4 routes (even when
  redirect-gateway without !ipv4 is specified). Note: the behaviour of
  redirect-gateway has not been touched, therefore the "ipv6" flag is
  still required, even if only IPv6 are configured on the interfaces;
- redirect-gateway is prevented from adding a bypass route if no IPv4
  redirection is taking place;
- added support for --ifconfig-pool-persist when only IPv6 is configured
- added do_ifconfig_ipv4() in do_ifconfig() to make code symmetric wrt
  IPv6;
- I may have forgotten some other little details..


(Note: this code is also available at [1] in the ipv6-only branch)


Cheers,

Trac: #208
[1] https://gitlab.com/ordex986/openvpn


Antonio Quartulli (8):
  tun: ensure interface can be configured with IPv6 only
  windows: properly configure TAP driver when no IPv4 is configured
  pool: convert pool 'type' to enum
  pool: allow to configure an IPv6-only ifconfig-pool
  make server capable of starting with an IPv6-only tunnel
  pool: add support for ifconfig-pool-persist with IPv6 only
  route: warn on IPv4 routes installation when no IPv4 is configured
  options: enable IPv4 redirection logic only if really required

 src/openvpn/forward.c |    4 +-
 src/openvpn/helper.c  |    8 +-
 src/openvpn/multi.c   |   10 +-
 src/openvpn/options.c |   16 +-
 src/openvpn/pool.c    |  259 +++++++---
 src/openvpn/pool.h    |   17 +-
 src/openvpn/route.c   |   14 +-
 src/openvpn/tun.c     | 1142 ++++++++++++++++++-----------------------
 src/openvpn/tun.h     |   12 +-
 9 files changed, 754 insertions(+), 728 deletions(-)

-- 
2.17.1


