From: Antonio Quartulli <a@...2181...>
Date: Fri, 24 Jun 2022 10:37:44 +0200
Message-Id: <20220624083809.23487-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 00/25] ovpn-dco: introduce data-channel
 offload support
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

This patchset is *almost* the same as the previous patchset, but it got
fragmented in multiple patches for easier review.

I am not setting any version on these patches as they do not match
previous versions.

The idea behind splitting patches is that they should be mergeable and
compilable one-by-one.

Ideally they should not introduce any regression in existing
functionalities, however, it may not always be apossible to *test* the
new code as it will require a subsequent patch to be used. Still we will
be able to compile the new code and review it.

While splitting patches, some ugly things have been fixed/changed..so
hopefully splitting patches has already paid off a bit..

I hope this will help with getting this new functionality merged soon.

This patchset reflects what is currently pushed to the "dco" branch.

Best Regards,

Antonio Quartulli (24):
  dco: introduce low-level code for handling ovpn-dco in the Linux
    kernel
  dco: add helper function to detect if DCO is enabled or not
  dco: use specific metric when installing routes
  dco: create DCO interface using SITNL
  dco: let open_tun_generic handle the DCO case
  dco: initialize context and save pointer in TLS object
  dco: add option check - disable DCO if conflict is detected
  dco: allow user to disable it at runtime
  dco: configure keys in DCO right after generating them
  dco: periodically check and possibly rotate/delete keys
  dco: split option parsing routines
  dco: check that pulled options are compatible
  dco: implement dco support for p2p/client code path
  dco: implement dco support for p2mp/server code path
  dco: add documentation for ovpn-dco-linux
  GitHub Actions: add Linux DCO build (on Ubuntu 20.04)
  dco: turn supported ciphers list into a function
  dco-win: implement GetOverlappedResultEx for mingw32
  dco-win: add platform dependant check on incompatible options
  do_open_tun: restyle "can preserve TUN" check
  dco-win: introduce low-level code for handling ovpn-dco-win in Windows
  dco-win: implement ovpn-dco support in P2P Windows code path
  dco-win: add documentation to README.dco.md
  dco-win: update GH Actions config file

Arne Schwabe (1):
  tun: extract close_tun_handle into its own fucntion and print correct
    type

 .github/workflows/build.yaml                  |  16 +-
 Changes.rst                                   |   9 +
 README.dco.md                                 | 132 +++
 config-msvc.h                                 |   2 +
 configure.ac                                  |  37 +
 dev-tools/special-files.lst                   |   2 +
 doc/man-sections/advanced-options.rst         |  13 +
 doc/man-sections/server-options.rst           |   6 +
 src/compat/Makefile.am                        |   3 +-
 src/compat/compat-dco_get_overlapped_result.c |  46 +
 src/compat/compat.h                           |   8 +
 src/compat/compat.vcxproj                     |   1 +
 src/compat/compat.vcxproj.filters             |   3 +
 src/openvpn/Makefile.am                       |   7 +-
 src/openvpn/dco.c                             | 621 ++++++++++++
 src/openvpn/dco.h                             | 318 ++++++
 src/openvpn/dco_internal.h                    |  79 ++
 src/openvpn/dco_linux.c                       | 940 ++++++++++++++++++
 src/openvpn/dco_linux.h                       |  59 ++
 src/openvpn/dco_win.c                         | 402 ++++++++
 src/openvpn/dco_win.h                         |  58 ++
 src/openvpn/errlevel.h                        |   2 +
 src/openvpn/event.h                           |   3 +
 src/openvpn/forward.c                         |  89 +-
 src/openvpn/init.c                            | 456 ++++++---
 src/openvpn/init.h                            |   4 +-
 src/openvpn/mtcp.c                            |  59 +-
 src/openvpn/mudp.c                            |  13 +
 src/openvpn/multi.c                           | 221 +++-
 src/openvpn/multi.h                           |  14 +-
 src/openvpn/networking_sitnl.c                |  11 +
 src/openvpn/openvpn.vcxproj                   |  11 +-
 src/openvpn/openvpn.vcxproj.filters           |  27 +
 src/openvpn/options.c                         |  53 +-
 src/openvpn/options.h                         |  15 +
 src/openvpn/ovpn-dco-win.h                    | 108 ++
 src/openvpn/ovpn_dco_linux.h                  | 265 +++++
 src/openvpn/socket.c                          |  94 +-
 src/openvpn/socket.h                          |  26 +-
 src/openvpn/ssl.c                             |  74 +-
 src/openvpn/ssl.h                             |   7 +-
 src/openvpn/ssl_common.h                      |  23 +
 src/openvpn/tun.c                             | 250 +++--
 src/openvpn/tun.h                             |  64 +-
 44 files changed, 4292 insertions(+), 359 deletions(-)
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


