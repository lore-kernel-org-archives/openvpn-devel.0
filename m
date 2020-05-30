From: Antonio Quartulli <a@...2181...>
Date: Sat, 30 May 2020 02:05:53 +0200
Message-Id: <20200530000600.1680-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4 0/7] Allow IPv6-only tunnels
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

This patchset allows servers to work with a tunnel
configured with IPv6 only (client code has already been merged).

This new v4 is the result of some more reviews, including an
hardcore reviewing session that me and Gert had yesterday afternoon.

We found some interesting bugs and agreed on some
previously-not-well-defined behaviours.

The patchset is now ready for broader testing and potential final
vetting.


In a nutshell, after applying this patchset, it will be possible to
configure a server with just --server-ipv6 and no IPv4 at all (in
the tunnel).


Happy hacking!

(Note: this code is also available at [1] in the ipv6-only branch)


Cheers,

Trac: #208
[1] https://gitlab.com/ordex986/openvpn


Antonio Quartulli (7):
  pool: prevent IPv6 pools to be larger than 2^16 addresses
  pool: allow to configure an IPv6-only ifconfig-pool
  allow usage of --server-ipv6 even when no --server is specified
  pool: add support for ifconfig-pool-persist with IPv6 only
  route: warn on IPv4 routes installation when no IPv4 is configured
  options: enable IPv4 redirection logic only if really required
  ipv6-pool: get rid of size constraint

 src/openvpn/helper.c  |  15 +-
 src/openvpn/multi.c   |  10 +-
 src/openvpn/options.c |  29 +++-
 src/openvpn/pool.c    | 317 ++++++++++++++++++++++++++++++++----------
 src/openvpn/pool.h    |   8 +-
 src/openvpn/route.c   |  16 ++-
 6 files changed, 302 insertions(+), 93 deletions(-)

-- 
2.26.2


