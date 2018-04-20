From: Antonio Quartulli <a@...2181...>
Date: Fri, 20 Apr 2018 19:16:16 +0800
Message-Id: <20180420111624.7230-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 0/4] add netlink support for Linux
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

Hi all,

finally this is the first "real" patchset that
introduces native netlink support for the Linux platform.

- Description:

At the moment openvpn operates on the tun interface and on the routing
table by directly invoking the "ip" command (or ifconfig/route if
nettools is selected at compile time).

With this patchset, openvpn would not need to fork new processes to
run the "ip" binary any longer, but would directly talk to the kernel
by means of the netlink interface.
This means simpler/cleaner code and, possibly, faster execution.

Another important advantage of this change is that the openvpn
process will be in charge of directly working with the kernel, thus
it can be granted special capabilities so that interfaces/routes
operations can be carried out even when running as non-root.

Christian Hesse is working on a follow-up patch to properly allow the
above.

This patchset also offers a first step towards a refactoring
of the tun.c and route.c code.


The idea moving forward is to drop nettools support once this patchset
is merged, but to retain support for ip and the --ifconfig/route-noexec
options.


The last patch implements a little framework to test sitnl
functionalities. Some functions are actually tested in the
framework, but more should be added in the future.

- Git:

This code can also be found on GitHub (based on latest master) at:
https://github.com/ordex/openvpn/tree/sitnl


Regards,


Antonio Quartulli (8):
  implement platform generic networking API
  implement networking API for iproute2
  tun.c: use new networking API to handle tun interface on Linux
  route.c: use new networking API to handle routing table on Linux
  introduce sitnl: Simplified Interface To NetLink
  configure: don't check for route/ifconfig on linux
  route.c: use sitnl to implement get_default_gateway_ipv6()
  unit tests: implement test for sitnl

 configure.ac                               |    5 +-
 src/openvpn/Makefile.am                    |    1 +
 src/openvpn/errlevel.h                     |    1 +
 src/openvpn/networking.h                   |  225 ++++
 src/openvpn/networking_ip.c                |  368 ++++++
 src/openvpn/networking_sitnl.c             | 1206 ++++++++++++++++++++
 src/openvpn/route.c                        |  364 ++----
 src/openvpn/sitnl.h                        |  217 ++++
 src/openvpn/tun.c                          |  199 +---
 tests/Makefile.am                          |    3 +-
 tests/t_net.sh                             |  170 +++
 tests/unit_tests/openvpn/Makefile.am       |   23 +-
 tests/unit_tests/openvpn/test_networking.c |  217 ++++
 13 files changed, 2559 insertions(+), 440 deletions(-)
 create mode 100644 src/openvpn/networking.h
 create mode 100644 src/openvpn/networking_ip.c
 create mode 100644 src/openvpn/networking_sitnl.c
 create mode 100644 src/openvpn/sitnl.h
 create mode 100755 tests/t_net.sh
 create mode 100644 tests/unit_tests/openvpn/test_networking.c

-- 
2.17.0


