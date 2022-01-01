From: Arne Schwabe <arne@...1227...>
Date: Sat,  1 Jan 2022 17:25:18 +0100
Message-Id: <20220101162532.2251835-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 00/14] Big buffer/frame refactoring patch
 set v3
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

This version of the patchset adds the CBC fix to correct the CBC calculation.
This patch introduces a lot of rebase conflicts and therefore the whole
patchset is resent as v3.

Arne Schwabe (14):
  Deprecate link-mtu
  Fix mssfix and frame calculation in CBC mode
  Change buffer allocation calculation and checks to be more static
  Fix datagram_overhead and assorted functions
  Implement optional mtu parameter for mssfix
  Update fragment and mssfix related warnings
  Change the default for mssfix to mssfix 1492 mtu
  Remove link_mtu parameter when running up/down scripts
  Add mtu paramter to --fragment and change fragment calculation
  Use new frame header methods to calculate OCC_MTU_LOAD payload size
  Remove extra_link from frame
  Replace TUN_MTU_SIZE with frame->tun_mtu
  Remove frame->link_mtu
  Remove frame.extra_frame and frame.extra_buffer

 Changes.rst                            |   9 +
 doc/man-sections/link-options.rst      |  65 ++++--
 src/openvpn/comp-lz4.c                 |   4 +-
 src/openvpn/comp.c                     |  15 --
 src/openvpn/comp.h                     |   4 -
 src/openvpn/crypto.c                   |  59 +-----
 src/openvpn/crypto.h                   |  14 +-
 src/openvpn/forward.c                  |  25 +--
 src/openvpn/fragment.c                 |   7 +-
 src/openvpn/init.c                     | 274 ++++++++++++-------------
 src/openvpn/integer.h                  |   9 +
 src/openvpn/lzo.c                      |   2 +-
 src/openvpn/mss.c                      | 159 ++++++++++++--
 src/openvpn/mss.h                      |  12 +-
 src/openvpn/mtu.c                      | 143 +++++--------
 src/openvpn/mtu.h                      | 204 +++++++-----------
 src/openvpn/multi.c                    |   7 +-
 src/openvpn/multi.h                    |   2 +-
 src/openvpn/occ.c                      |  33 ++-
 src/openvpn/options.c                  |  85 +++++---
 src/openvpn/options.h                  |   6 +-
 src/openvpn/ping.c                     |   2 +-
 src/openvpn/reliable.c                 |   7 -
 src/openvpn/reliable.h                 |   3 -
 src/openvpn/socket.c                   |  31 ---
 src/openvpn/socket.h                   |  19 +-
 src/openvpn/socks.c                    |  11 +-
 src/openvpn/socks.h                    |   2 -
 src/openvpn/ssl.c                      |  89 +++-----
 src/openvpn/ssl.h                      |  10 +-
 src/openvpn/ssl_common.h               |   3 +-
 src/openvpn/tls_crypt.c                |  10 -
 src/openvpn/tls_crypt.h                |   5 -
 tests/unit_tests/openvpn/test_crypto.c |  86 +++++++-
 34 files changed, 733 insertions(+), 683 deletions(-)

-- 
2.33.0


