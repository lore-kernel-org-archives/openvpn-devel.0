From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:31:41 +0300
Message-Id: <1336851105-24172-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [V2.4 0/4] tun cleanups
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

Platform independent interface for tun provider.

Split the long tun.c into platform specific files using
tun_engine interface.

Functionality is the same.

Maintenance will be much easier! new options, like stacking
several interfaces and delegate partial control to plugin.

There is more to be done in order to clean up the code,
however this is a good starting point.

Some more minor cleanups.

Tested on Linux, FreeBSD, Windows.

Branch should be merge after syshead[1].
Most probably patch exceeds list limitation, review is available[2].

This is for 2.4, please review quickly this so won't need to rebase.

Special thanks to Eric Crist for his FreeBSD help.

[1] https://github.com/alonbl/openvpn/compare/build...syshead
[2] https://github.com/alonbl/openvpn/compare/syshead...tun

Alon Bar-Lev (4):
  cleanup: remove check_subnet_conflict
  cleanup: move warn_on_use_of_common_subnets to init.c
  cleanup: remove tun_adjust_frame_parameters
  cleanup: tun: tun_engine interface

 configure.ac                             |    6 +
 src/openvpn/Makefile.am                  |   12 +
 src/openvpn/error.c                      |    2 +-
 src/openvpn/forward.c                    |   28 +-
 src/openvpn/helper.c                     |    2 +-
 src/openvpn/init.c                       |   61 +-
 src/openvpn/multi.c                      |    2 +-
 src/openvpn/options.c                    |   20 +-
 src/openvpn/options.h                    |    5 +-
 src/openvpn/route.c                      |    2 +-
 src/openvpn/sig.c                        |    4 +-
 src/openvpn/syshead.h                    |   56 -
 src/openvpn/tun-engine-common-bsd.c      |  103 +
 src/openvpn/tun-engine-common-bsd.h      |   34 +
 src/openvpn/tun-engine-common.c          |  518 +++
 src/openvpn/tun-engine-common.h          |   85 +
 src/openvpn/tun-engine-darwin.c          |  226 ++
 src/openvpn/tun-engine-dragonfly.c       |  193 ++
 src/openvpn/tun-engine-freebsd.c         |  229 ++
 src/openvpn/tun-engine-generic.c         |   97 +
 src/openvpn/tun-engine-linux-options.h   |   37 +
 src/openvpn/tun-engine-linux.c           |  515 +++
 src/openvpn/tun-engine-netbsd.c          |  318 ++
 src/openvpn/tun-engine-openbsd.c         |  259 ++
 src/openvpn/tun-engine-options.h         |   37 +
 src/openvpn/tun-engine-solaris.c         |  491 +++
 src/openvpn/tun-engine-windows-options.h |   92 +
 src/openvpn/tun-engine-windows-util.h    |   83 +
 src/openvpn/tun-engine-windows.c         | 2757 ++++++++++++++++
 src/openvpn/tun-engine.h                 |   95 +
 src/openvpn/tun.c                        | 5053 ++----------------------------
 src/openvpn/tun.h                        |  469 +---
 32 files changed, 6548 insertions(+), 5343 deletions(-)
 create mode 100644 src/openvpn/tun-engine-common-bsd.c
 create mode 100644 src/openvpn/tun-engine-common-bsd.h
 create mode 100644 src/openvpn/tun-engine-common.c
 create mode 100644 src/openvpn/tun-engine-common.h
 create mode 100644 src/openvpn/tun-engine-darwin.c
 create mode 100644 src/openvpn/tun-engine-dragonfly.c
 create mode 100644 src/openvpn/tun-engine-freebsd.c
 create mode 100644 src/openvpn/tun-engine-generic.c
 create mode 100644 src/openvpn/tun-engine-linux-options.h
 create mode 100644 src/openvpn/tun-engine-linux.c
 create mode 100644 src/openvpn/tun-engine-netbsd.c
 create mode 100644 src/openvpn/tun-engine-openbsd.c
 create mode 100644 src/openvpn/tun-engine-options.h
 create mode 100644 src/openvpn/tun-engine-solaris.c
 create mode 100644 src/openvpn/tun-engine-windows-options.h
 create mode 100644 src/openvpn/tun-engine-windows-util.h
 create mode 100644 src/openvpn/tun-engine-windows.c
 create mode 100644 src/openvpn/tun-engine.h

-- 
1.7.3.4


