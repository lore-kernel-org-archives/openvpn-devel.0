From: Antonio Quartulli <a@...2181...>
Date: Fri, 12 Aug 2022 15:06:47 +0200
Message-Id: <20220812130657.29899-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v100 00/10] ovpn-dco: leftovers
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

This patchset is essentially a resending of the patches that were
already on the mailing list, but were not appled yet.

Some of them required extra work, while some required reordering.

To make things simpler, I am resending them as a patchset, with some
extra bonus patches too.

I am going with v100 to kinda restart from zero, without mixing up
existing versions of these patches.

Enjoy!

Antonio Quartulli (10):
  do_open_tun: restyle "can preserve TUN" check
  dco-win: introduce low-level code for handling ovpn-dco-win in Windows
  dco-win: add platform dependant check on incompatible options
  dco-win: implement ovpn-dco support in P2P Windows code path
  dco-win: add documentation to README.dco.md
  dco-win: update GH Actions config file
  dco-win: ensure the DCO API is not used when running on Windows
  ovpn-dco: print some netlink messages to debug level
  dco: properly name variables
  dco: move message to DCO debug level and reword a bit

 .github/workflows/build.yaml        |   7 +-
 README.dco.md                       |  11 +-
 config-msvc.h                       |   2 +
 configure.ac                        |   9 +-
 dev-tools/special-files.lst         |   1 +
 src/openvpn/Makefile.am             |   4 +-
 src/openvpn/dco.c                   |  34 ++-
 src/openvpn/dco_internal.h          |   1 +
 src/openvpn/dco_linux.c             |   5 +-
 src/openvpn/dco_win.c               | 397 ++++++++++++++++++++++++++++
 src/openvpn/dco_win.h               |  57 ++++
 src/openvpn/forward.c               |  31 ++-
 src/openvpn/init.c                  | 307 +++++++++++----------
 src/openvpn/openvpn.vcxproj         |   3 +
 src/openvpn/openvpn.vcxproj.filters |   9 +
 src/openvpn/options.c               |  28 +-
 src/openvpn/options.h               |  15 +-
 src/openvpn/ovpn-dco-win.h          | 108 ++++++++
 src/openvpn/socket.c                |  93 ++++++-
 src/openvpn/socket.h                |  25 +-
 src/openvpn/tun.c                   |  56 +++-
 src/openvpn/tun.h                   |  77 ++++--
 22 files changed, 1059 insertions(+), 221 deletions(-)
 create mode 100644 src/openvpn/dco_win.c
 create mode 100644 src/openvpn/dco_win.h
 create mode 100644 src/openvpn/ovpn-dco-win.h

-- 
2.35.1


