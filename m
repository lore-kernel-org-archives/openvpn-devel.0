From: Antonio Quartulli <a@...2181...>
Date: Fri, 12 Oct 2018 02:41:53 +0800
Message-Id: <20181011184200.22175-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 0/7] introduce networking API and add
 netlink support for Linux
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

From a high level description of this patchset, please refer to
"[PATCH 0/4] add netlink support for Linux" sent to the mailing list on
Apr, 20th 2018.

Changes from v1:
- introduced opaque context object containing implementation specific
  state;
- fixed env passed to ip command (thanks to opaque context);
- rebased on to pof latest master (00d78cd5)


Regards,


Antonio Quartulli (7):
  implement platform generic networking API
  implement networking API for iproute2
  introduce sitnl: Simplified Interface To NetLink
  tun.c: use new networking API to handle tun interface on Linux
  route.c: use new networking API to handle routing table on Linux
  route.c: use sitnl to implement get_default_gateway_ipv6()
  unit tests: implement test for sitnl

 configure.ac                               |   15 +-
 src/openvpn/Makefile.am                    |    3 +
 src/openvpn/errlevel.h                     |    1 +
 src/openvpn/forward.c                      |    2 +-
 src/openvpn/init.c                         |   55 +-
 src/openvpn/init.h                         |    5 +-
 src/openvpn/networking.h                   |  272 +++++
 src/openvpn/networking_ip.c                |  385 ++++++
 src/openvpn/networking_ip.h                |   36 +
 src/openvpn/networking_sitnl.c             | 1227 ++++++++++++++++++++
 src/openvpn/networking_sitnl.h             |   28 +
 src/openvpn/openvpn.c                      |    4 +-
 src/openvpn/openvpn.h                      |    2 +
 src/openvpn/options.c                      |   10 +-
 src/openvpn/options.h                      |    1 +
 src/openvpn/route.c                        |  497 +++-----
 src/openvpn/route.h                        |   26 +-
 src/openvpn/sitnl.h                        |  217 ++++
 src/openvpn/ssl.c                          |    2 +-
 src/openvpn/ssl_common.h                   |    1 +
 src/openvpn/tun.c                          |  233 ++--
 src/openvpn/tun.h                          |   14 +-
 tests/Makefile.am                          |    3 +-
 tests/t_net.sh                             |  180 +++
 tests/unit_tests/openvpn/Makefile.am       |   28 +-
 tests/unit_tests/openvpn/test_networking.c |  229 ++++
 26 files changed, 2974 insertions(+), 502 deletions(-)
 create mode 100644 src/openvpn/networking.h
 create mode 100644 src/openvpn/networking_ip.c
 create mode 100644 src/openvpn/networking_ip.h
 create mode 100644 src/openvpn/networking_sitnl.c
 create mode 100644 src/openvpn/networking_sitnl.h
 create mode 100644 src/openvpn/sitnl.h
 create mode 100755 tests/t_net.sh
 create mode 100644 tests/unit_tests/openvpn/test_networking.c

-- 
2.19.1


