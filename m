From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Dec 2021 18:01:50 +0100
Message-Id: <20211207170211.3275837-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 00/21] Big buffer/frame refactoring patch set
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

This patchset refactores a lot of the buffer related code. It mainly
uses the approach of simplifying the buffer sizes by always allocating
buffers with worst case overhead instead of trying a save < 100 bytes
and complicating the code.

It also moves to central functions that calculate the various overheads
from the small little functions scattered all over the source code.

And last but not least, this patch set also corrects the MSS and
fragment size calculation to take into account the real overhead
that is present after NCP. It also adds a a 'mtu' keyword to both
options so the desired real outer packet can be specified.

The patchset also deprecates link-mtu as this options is no longer
working well as intended since neither encryption/authentication
overhead is fixed (NCP) nor is the encapsulation overhead constant
(IPv4 vs IPv6) and link-mtu basically assumes that the overhead is
constant.

This patchset needs the "Cleanup crypto and use string isntead internal
types" patch set applied first or will have conflicts.

Arne Schwabe (21):
  Remove max_size from buffer_list_new
  Deprecate link-mtu
  Remove align_adjust frame code
  Fix triggering assertion of ks->authticated after tls_deauthenticate
  Document frame related function and variables a bit more
  Remove post_open_mtu code
  Add helper functions to calculate header/payload sizes
  Decouple MSS fix calculation from frame calculation
  Rework occ link-mtu calculation
  Change buffer allocation calculation and checks to be more static
  Remove pointless do_init_frame_tls function
  Fix datagram_overhead and assorted functions
  Implement optional mtu parameter for mssfix
  Add mtu paramter to --fragment and change fragment calculation
  Update fragment and mssfix related warnings
  Remove link_mtu parameter when running up/down scripts
  Use new frame header methods to calculate OCC_MTU_LOAD payload size
  Remove extra_link from frame
  Replace TUN_MTU_SIZE with frame->tun_mtu
  Remove frame->link_mtu
  Remove frame.extra_frame and frame.extra_buffer

 Changes.rst                            |   9 +
 doc/man-sections/link-options.rst      |  42 ++--
 src/openvpn/buffer.c                   |   7 +-
 src/openvpn/buffer.h                   |   4 +-
 src/openvpn/comp-lz4.c                 |   4 +-
 src/openvpn/comp.c                     |  15 --
 src/openvpn/comp.h                     |   4 -
 src/openvpn/crypto.c                   |  64 ++++--
 src/openvpn/crypto.h                   |  23 +-
 src/openvpn/forward.c                  |  32 +--
 src/openvpn/fragment.c                 |   9 +-
 src/openvpn/init.c                     | 302 +++++++++++--------------
 src/openvpn/init.h                     |   2 +-
 src/openvpn/lzo.c                      |   2 +-
 src/openvpn/manage.c                   |   4 +-
 src/openvpn/mss.c                      | 154 +++++++++++++
 src/openvpn/mss.h                      |  14 ++
 src/openvpn/mtu.c                      | 179 +++++++++------
 src/openvpn/mtu.h                      | 253 ++++++++++-----------
 src/openvpn/multi.c                    |   7 +-
 src/openvpn/multi.h                    |   2 +-
 src/openvpn/occ.c                      |  34 ++-
 src/openvpn/options.c                  |  82 ++-----
 src/openvpn/options.h                  |   7 +-
 src/openvpn/ping.c                     |   2 +-
 src/openvpn/proto.h                    |  11 -
 src/openvpn/reliable.c                 |   7 -
 src/openvpn/reliable.h                 |   3 -
 src/openvpn/socket.c                   |  34 +--
 src/openvpn/socket.h                   |  19 +-
 src/openvpn/socks.c                    |  11 +-
 src/openvpn/socks.h                    |   2 -
 src/openvpn/ssl.c                      |  99 ++++----
 src/openvpn/ssl.h                      |  10 +-
 src/openvpn/ssl_common.h               |   3 +-
 src/openvpn/tls_crypt.c                |  10 -
 src/openvpn/tls_crypt.h                |   5 -
 src/openvpn/tun.c                      |   1 -
 src/openvpn/tun.h                      |   4 -
 src/openvpn/win32.c                    |   2 +-
 tests/unit_tests/openvpn/Makefile.am   |   6 +-
 tests/unit_tests/openvpn/test_buffer.c |  22 +-
 tests/unit_tests/openvpn/test_crypto.c | 128 ++++++++++-
 tests/unit_tests/openvpn/test_misc.c   |   1 +
 44 files changed, 900 insertions(+), 735 deletions(-)

-- 
2.33.0


