From: Antonio Quartulli <a@...2181...>
Date: Sat,  2 Apr 2022 09:08:55 +0200
Message-Id: <20220402070902.30282-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/7] Introduce ovpn-dco(-win) support
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

this is the first official submission of the ovpn-dco support for
OpenVPN 2. This patchset is ready for review (and possible merge).

Please have a look, test and try to break it!

What has changed from the RFCv2 (sent on Jan 14th):
* DCO API has been modified to allow specifying a value for mssfix.
  However only ovpn-dco-win will pick up this value and do something
  meaningful. On linux is yet to be decided how to handle it.
* peer_add() and peer_set() have been decoupled so that the latter
  can be invoked at the right time, after some parameters have been
  computed (i.e. mssfix).
* routes and iroutes are now installed with a default metric of 200
  for the former and 100 for the latter. this guarantees that iroutes
  always have higher priority (iroutes are basically routes with a
  specific nexthop).
* The ovpn-dco interface is now configured in p2p mode when launching
  OpenVPN as client or p2p, while it is configured in mp (multipeer)
  mode when launching OpenVPN in server mode.
* Reverse Path Filtering is now enabled automatically when the interface
  is configured in mp mode (this is a change in ovpn-dco itself).
* some more intra-OpenVPN DCO API polishing.
* a few minor things I may not be recalling now...

A working copy of this patchset, always based on top of laest master, is
available in the OpenVPN repo in the "dco" branch.

Thanks a lot!
Regards,

Antonio Quartulli (4):
  networking: silence warnings about unused arguments
  networking: implement net_iface_new and net_iface_del APIs
  ovpn-dco: introduce linux data-channel offload support
  GitHub Actions: add Linux DCO build (on Ubuntu 20.04)

Arne Schwabe (3):
  networking: remove duplicate methods from networking_sitnl.c
  tun: extract close_tun_handle into its own fucntion and print correct
    type
  ovpn-dco-win: introduce windows data-channel offload support

 .github/workflows/build.yaml                  |  16 +-
 Changes.rst                                   |   7 +
 README.dco.md                                 | 138 +++
 config-msvc.h                                 |   2 +
 configure.ac                                  |  35 +
 doc/man-sections/advanced-options.rst         |  13 +
 doc/man-sections/server-options.rst           |   6 +
 src/compat/Makefile.am                        |   3 +-
 src/compat/compat-dco_get_overlapped_result.c |  44 +
 src/compat/compat.h                           |   6 +
 src/compat/compat.vcxproj                     |   1 +
 src/compat/compat.vcxproj.filters             |   3 +
 src/openvpn/Makefile.am                       |   5 +-
 src/openvpn/crypto.c                          |   1 +
 src/openvpn/dco.c                             | 631 +++++++++++++
 src/openvpn/dco.h                             | 310 ++++++
 src/openvpn/dco_internal.h                    |  81 ++
 src/openvpn/dco_linux.c                       | 888 ++++++++++++++++++
 src/openvpn/dco_linux.h                       |  61 ++
 src/openvpn/dco_win.c                         | 397 ++++++++
 src/openvpn/dco_win.h                         |  57 ++
 src/openvpn/errlevel.h                        |   2 +
 src/openvpn/event.h                           |   3 +
 src/openvpn/forward.c                         |  79 +-
 src/openvpn/init.c                            | 204 +++-
 src/openvpn/init.h                            |   2 +-
 src/openvpn/misc.h                            |   3 +-
 src/openvpn/mtcp.c                            |  61 +-
 src/openvpn/mudp.c                            |  13 +
 src/openvpn/multi.c                           | 227 ++++-
 src/openvpn/multi.h                           |   6 +-
 src/openvpn/networking.h                      |  37 +-
 src/openvpn/networking_iproute2.c             |  35 +
 src/openvpn/networking_sitnl.c                | 100 +-
 src/openvpn/openvpn.vcxproj                   |   6 +-
 src/openvpn/openvpn.vcxproj.filters           |  15 +
 src/openvpn/options.c                         |  51 +-
 src/openvpn/options.h                         |  15 +
 src/openvpn/ovpn-dco-win.h                    | 108 +++
 src/openvpn/ovpn_dco_linux.h                  | 265 ++++++
 src/openvpn/socket.c                          | 105 ++-
 src/openvpn/socket.h                          |  21 +-
 src/openvpn/ssl.c                             |  80 +-
 src/openvpn/ssl.h                             |   7 +-
 src/openvpn/ssl_common.h                      |  23 +
 src/openvpn/ssl_ncp.c                         |   2 +-
 src/openvpn/tun.c                             | 245 +++--
 src/openvpn/tun.h                             |  62 +-
 tests/unit_tests/openvpn/test_networking.c    |  25 +-
 49 files changed, 4239 insertions(+), 268 deletions(-)
 create mode 100644 README.dco.md
 create mode 100644 src/compat/compat-dco_get_overlapped_result.c
 create mode 100644 src/openvpn/dco.c
 create mode 100644 src/openvpn/dco.h
 create mode 100644 src/openvpn/dco_internal.h
 create mode 100644 src/openvpn/dco_linux.c
 create mode 100644 src/openvpn/dco_linux.h
 create mode 100644 src/openvpn/dco_win.c
 create mode 100644 src/openvpn/dco_win.h
 create mode 100644 src/openvpn/ovpn-dco-win.h
 create mode 100644 src/openvpn/ovpn_dco_linux.h

-- 
2.35.1


