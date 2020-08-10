From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Aug 2020 16:36:50 +0200
Message-Id: <20200810143707.5834-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 00/17] OpenVPN refactoring
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

This a number of patches that cleanup or refactor code in order
to improve either code quality or prepare other features. A few
patches that were necessary as prerequisite for NCP or client-connect
patches have been already extractracted from the refactoring and been
applied.

I id hold off sending these patches, so we could concentrate on getting
the necessary patches for 2.5 out.

Arne Schwabe (17):
  Refactor/Reformat tls_pre_decrypt
  Cleanup tls_pre_decrypt_lite and tls_pre_encrypt
  Clean up a number of leftover C89 initialisations in ssl.c
  Minor cleanup in push.c
  Remove buf argument from link_socket_set_outgoing_addr
  Remove a number of check/do_work wrapper calls from coarse_timers
  Split pf_check_reload check and check timer in process_coarse_timers
  Rename check_ping_restart_dowork to trigger_ping_timeout_signal
  Eliminate check_fragment function
  Eliminate check_incoming_control_channel wrapper function
  Eliminate check_tls wrapper function
  Merge check_coarse_timers and check_coarse_timers_dowork
  Remove S_OP_NORMAL key state.
  Skip existing interfaces on opening the first available utun on macOS
  Refactor key_state_export_keying_material functions
  Move parsing IV_PROTO to separate function
  Move openvpn specific key expansion into its own function

 src/openvpn/forward.c     |  367 ++++-------
 src/openvpn/forward.h     |   18 +-
 src/openvpn/multi.c       |   49 +-
 src/openvpn/pf.c          |    4 +-
 src/openvpn/ping.c        |    6 +-
 src/openvpn/ping.h        |   13 +-
 src/openvpn/push.c        |    7 +-
 src/openvpn/socket.c      |    3 +-
 src/openvpn/socket.h      |   35 +-
 src/openvpn/ssl.c         | 1234 +++++++++++++++++++------------------
 src/openvpn/ssl_backend.h |   14 +-
 src/openvpn/ssl_common.h  |    9 +-
 src/openvpn/ssl_mbedtls.c |   22 +-
 src/openvpn/ssl_openssl.c |   32 +-
 src/openvpn/status.c      |   13 -
 src/openvpn/status.h      |    2 -
 src/openvpn/tun.c         |    9 +-
 17 files changed, 878 insertions(+), 959 deletions(-)

-- 
2.26.2


