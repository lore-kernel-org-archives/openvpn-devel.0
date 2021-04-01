From: Arne Schwabe <arne@...1227...>
Date: Thu,  1 Apr 2021 15:13:23 +0200
Message-Id: <20210401131337.3684-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 00/14] Various clean up patches
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

These are a number of patches that do various cleanups that
I did as part of implementing DCO but are good on their own.

Arne Schwabe (14):
  Remove code for aligning non-swapped compression
  Remove superflous ifdefs around enum like defines
  Rename tunnel_server_udp_single_threaded to tunnel_server_udp
  Add documentation on EVENT_READ/EVENT_WRITE constants
  Remove unused variable pass_config_info
  Remove pointless tun_adjust_frame_parameters function
  Remove unused field txqueuelen from struct tuntap
  Remove unused function tls_test_auth_deferred_interval
  Move is_proto function to the socket.h header
  Remove thread_mode field of multi_context
  Remove P2MP mode and check for gettimeofday
  Extract multi_assign_peer_id into its own function
  log file descriptor in more socket related error messages
  Remove do_init_socket_2 and do_init_socket_1 wrapper function

 doc/doxygen/doc_eventloop.h      |   2 +-
 doc/doxygen/doc_tunnel_state.h   |   2 +-
 src/compat/compat-gettimeofday.c |   2 +-
 src/openvpn/comp.h               |   6 --
 src/openvpn/error.c              |   8 +-
 src/openvpn/event.c              |   8 +-
 src/openvpn/forward.c            |  26 +-----
 src/openvpn/forward.h            |   6 --
 src/openvpn/helper.c             |   3 -
 src/openvpn/init.c               | 122 +-------------------------
 src/openvpn/manage.c             |   4 -
 src/openvpn/mbuf.c               |   3 -
 src/openvpn/mbuf.h               |   3 -
 src/openvpn/mtcp.c               |   7 +-
 src/openvpn/mtu.h                |   6 --
 src/openvpn/mudp.c               |  45 +---------
 src/openvpn/mudp.h               |   7 +-
 src/openvpn/multi.c              |  95 +++++++++++---------
 src/openvpn/multi.h              |  20 +++--
 src/openvpn/openvpn.h            |  25 +++---
 src/openvpn/options.c            |  55 ++----------
 src/openvpn/options.h            |  49 ++++++-----
 src/openvpn/otime.c              |   4 -
 src/openvpn/pool.c               |   4 -
 src/openvpn/pool.h               |   3 -
 src/openvpn/push.c               |   3 -
 src/openvpn/push.h               |   3 -
 src/openvpn/pushlist.h           |   4 +-
 src/openvpn/route.h              |   2 -
 src/openvpn/shaper.c             |   5 +-
 src/openvpn/shaper.h             |   4 -
 src/openvpn/socket.c             | 145 ++++++++++---------------------
 src/openvpn/socket.h             |  90 +++++++++----------
 src/openvpn/ssl.h                |  11 ---
 src/openvpn/ssl_common.h         |   4 -
 src/openvpn/syshead.h            |  32 -------
 src/openvpn/tun.h                |  13 ---
 37 files changed, 234 insertions(+), 597 deletions(-)

-- 
2.30.1


