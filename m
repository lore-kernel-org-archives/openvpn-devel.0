From: Lev Stipakov <lstipakov@...277...>
Date: Thu,  7 Nov 2019 19:45:22 +0200
Message-Id: <1573148729-27339-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v2 0/7] Wintun support
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

This set of patches adds support of wintun kernel driver
(https://www.wintun.net) to OpenVPN Windows client and server.

While wintun is in beta (currently used version is 0.7), it performs
significantly faster comparison to tap-windows6.

Below are download bandwidth stats reported by iperf3 running on client:

 > iperf3 -c <server-vpn-ip> -t 60 

Server - community openvpn2 (2.4.4)

  tap-windows6  - 396Mbit/s
  wintun        - 677Mbit/s 

Server - propietary openvpn3 with kernel acceleration (in development)

  tap-windows6  - 386Mbit/s
  wintun        - 840Mbit/s

Client version used for tap-windows6 tests is 2.4.8.

To use wintun driver instead of tap-window6, add "windows-driver wintun"
to your VPN config file or openvpn.exe command line.

Ready-made Windows client installer (signed by OpenVPN Inc)
with wintun support could be found here: from http://staging.openvpn.net/openvpn2/.

To build installer yourself, you need a patched version of
openvpn-build, see https://github.com/OpenVPN/openvpn-build/pull/154.

Changes from v1:

 - rebased on top of latest master (2b11e57)

Lev Stipakov (7):
  Visual Studio: upgrade project files to VS2019
  wintun: add --windows-driver config option
  wintun: implement opening wintun device
  wintun: ring buffers based I/O
  wintun: interactive service support
  wintun: set adapter properties via interactive service
  wintun: clear adapter settings on tun close

 include/openvpn-msg.h                       |  10 +
 src/compat/compat.vcxproj                   |  12 +-
 src/openvpn/Makefile.am                     |   4 +-
 src/openvpn/forward.c                       |  42 ++-
 src/openvpn/forward.h                       |  47 ++-
 src/openvpn/init.c                          |   7 +
 src/openvpn/mtcp.c                          |  28 +-
 src/openvpn/mudp.c                          |  14 +
 src/openvpn/openvpn.vcxproj                 |  16 +-
 src/openvpn/openvpn.vcxproj.filters         |   8 +-
 src/openvpn/options.c                       |  37 ++
 src/openvpn/options.h                       |   1 +
 src/openvpn/ring_buffer.c                   |  54 +++
 src/openvpn/ring_buffer.h                   |  79 +++++
 src/openvpn/route.c                         |   2 +-
 src/openvpn/route.h                         |   3 +-
 src/openvpn/syshead.h                       |   1 +
 src/openvpn/tun.c                           | 504 +++++++++++++++++++++++-----
 src/openvpn/tun.h                           | 139 +++++++-
 src/openvpn/win32.c                         |  95 ++++++
 src/openvpn/win32.h                         |   4 +
 src/openvpnmsica/openvpnmsica.vcxproj       |  14 +-
 src/openvpnserv/Makefile.am                 |   3 +-
 src/openvpnserv/interactive.c               | 141 +++++++-
 src/openvpnserv/openvpnserv.vcxproj         |  14 +-
 src/openvpnserv/openvpnserv.vcxproj.filters |   6 +
 src/tapctl/tapctl.vcxproj                   |  14 +-
 27 files changed, 1160 insertions(+), 139 deletions(-)
 create mode 100644 src/openvpn/ring_buffer.c
 create mode 100644 src/openvpn/ring_buffer.h

-- 
2.7.4


