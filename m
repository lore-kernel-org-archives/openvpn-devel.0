From: Antonio Quartulli <a@...2181...>
Date: Sun,  1 Apr 2018 21:16:11 +0800
Message-Id: <20180401131615.12567-1-a@...2181...>
Subject: [Openvpn-devel] [RFC 0/4] add netlink support for Linux
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

this patchset introduces native netlink support for the Linux platform.

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


Feedback of any type is of course welcome.


This patch is posted as RFC because, as agreed during the last
Hackathon, it will be considered for merging only when unit-tests
will also be available. On to pof that, several aspects (like
allowing iproute2 to be still used) have to be properly implemented.


This code can also be found on GitHub (based on latest master) at:
https://github.com/ordex/openvpn/tree/sitnl


Regards,


Antonio Quartulli (4):
  configure: add LINUX conditional variable
  introduce sitnl: Simplified Interface To NetLink
  tun.c: use sitnl to handle tun configuration on Linux
  route.c: use sitnl to handle route configuration on Linux

 configure.ac            |    2 +
 src/openvpn/Makefile.am |    3 +
 src/openvpn/errlevel.h  |    1 +
 src/openvpn/route.c     |  364 +++------------
 src/openvpn/sitnl.c     | 1195 +++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/sitnl.h     |  217 +++++++++
 src/openvpn/tun.c       |  199 +++-----
 7 files changed, 1547 insertions(+), 434 deletions(-)
 create mode 100644 src/openvpn/sitnl.c
 create mode 100644 src/openvpn/sitnl.h

-- 
2.16.3


