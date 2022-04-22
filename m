From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 15:40:29 +0200
Message-Id: <20220422134038.3801239-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 00/28] Stateless three-way handshake and
 control channel improvements
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

OpenVPN currently has a bit of a weakness in its early three way handshake

A single client reset packet (first packet of the handshake) will
  - trigger creating session on the server side leading to poential
    ressource exhaustian
  - make the server respond with 3 answers trying to get an ACK for its
    answer making it a amplification

This patch series intends to solve this problem and since the patches revolve
a lot around control channel behaviour, I discovered and fixed a number of other
weaknesses in the control channel implementation:

 - Implementing an HMAC based scheme to offer a stateless three way handshake for
   the server that avoids the previous mentioned problems.
 - Restricting control channel packet size is now possible without breaking the
   protocol (--tls-mtu)
 - Server and client will now always repeat previous ACKs to avoid the peer
   resending a packet if an ACK is gone missing. (Similar to what cumulative
   ACKs in other protocols achieve).

Arne Schwabe (28):
  Remove tls_init_control_channel_frame_parameters wrapper function
  Remove dead PID_TEST code
  Move pre decrypt lite check to its own function
  Add documentation for swap_hmac function
  Extend tls_pre_decrypt_lite to return type of packet and keep state
  Move ssl function related to control channel wrap/unwrap to
    ssl_pkt.c/h
  Add unit tests for test_tls_decrypt_lite
  Split out reliable_ack_parse from reliable_ack_read
  Remove inc_pid argument from reliable_mark_deleted that is always true
  Remove EXPONENTIAL_BACKOFF define
  Refactor tls-auth/tls-crypt wrapping into into own function
  Extract session_move_pre_start as own function, use local buffer
    variable
  Change FULL_SYNC macro to no_pending_reliable_packets function
  Move tls_process_state into its own function
  Remove pointless indentation from tls_process.
  Move CRL reload to key_state_init from S_START transition
  Implement constructing a control channel reset client as standalone
    fucntion
  Implement stateless, HMAC basedsesssion id three way handshake
  Make buf_write_u8/16/32 take the type they pretend to take
  Change reliable_get_buf_sequenced to reliable_get_entry_sequenced
  Extract read_incoming_tls_ciphertext into function
  Implement HMAC based session id for tls-crypt v2
  Optimise three-way handshake condition for S_PRE_START to S_START
  Extract read_incoming_tls_plaintext into its own function
  Ensure that control channel packet are respecting tls-mtu
  Allow setting control channel packet size with tls-mtu
  Add unit test for reliable_get_num_output_sequenced_available
  Always include ACKs for the last seen control packets

 Changes.rst                                |   16 +
 doc/doxygen/doc_protocol_overview.h        |    2 +
 doc/man-sections/link-options.rst          |    7 +
 doc/man-sections/tls-options.rst           |   14 +
 doc/tls-crypt-v2.txt                       |   41 +
 src/openvpn/Makefile.am                    |    1 +
 src/openvpn/buffer.h                       |   13 +-
 src/openvpn/crypto.h                       |    8 +
 src/openvpn/init.c                         |   28 +-
 src/openvpn/mtu.h                          |    5 +
 src/openvpn/mudp.c                         |  164 ++-
 src/openvpn/multi.h                        |    3 +
 src/openvpn/openvpn.h                      |    6 +
 src/openvpn/openvpn.vcxproj                |    2 +
 src/openvpn/openvpn.vcxproj.filters        |    3 +
 src/openvpn/options.c                      |   27 +
 src/openvpn/options.h                      |    4 +
 src/openvpn/packet_id.c                    |   56 -
 src/openvpn/packet_id.h                    |   25 +-
 src/openvpn/reliable.c                     |  209 +++-
 src/openvpn/reliable.h                     |   84 +-
 src/openvpn/ssl.c                          | 1312 ++++++++++----------
 src/openvpn/ssl.h                          |   97 +-
 src/openvpn/ssl_backend.h                  |    8 +-
 src/openvpn/ssl_common.h                   |    1 +
 src/openvpn/ssl_mbedtls.c                  |   19 +-
 src/openvpn/ssl_mbedtls.h                  |    4 +
 src/openvpn/ssl_openssl.c                  |   22 +-
 src/openvpn/ssl_openssl.h                  |    7 +
 src/openvpn/ssl_pkt.c                      |  549 ++++++++
 src/openvpn/ssl_pkt.h                      |  295 +++++
 tests/unit_tests/openvpn/Makefile.am       |   29 +-
 tests/unit_tests/openvpn/mock_get_random.c |   10 +
 tests/unit_tests/openvpn/test_packet_id.c  |   90 ++
 tests/unit_tests/openvpn/test_pkt.c        |  620 +++++++++
 35 files changed, 2825 insertions(+), 956 deletions(-)
 create mode 100644 src/openvpn/ssl_pkt.c
 create mode 100644 src/openvpn/ssl_pkt.h
 create mode 100644 tests/unit_tests/openvpn/test_pkt.c

-- 
2.32.0 (Apple Git-132)


