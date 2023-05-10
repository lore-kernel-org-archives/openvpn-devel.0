From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 10 May 2023 13:22:33 +0200
Message-Id: <20230510112236.248026-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/3] Some misc -Wconversion fixes
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

In the context of the CMake patchset Lev and I discussed
lowering the warning level for the MSVC builds since there
are so many conversion warnings they drown out everything
else.

So I actually tried what happens when you build with
-Wconversion on Linux and whether it would be possible
to resolve these issues. The short answer is: no, this
is not possible with reasonable effort. But while finding
this out I at least fixed some of the issues. So here
a small patchset that fell out of that.

Can also be reviewed via https://gerrit.openvpn.net/

Frank Lichtenheld (3):
  Various fixes for -Wconversion errors
  Change type of frame.mss_fix to uint16_t
  mss/mtu: make all size calculations use size_t

 src/openvpn/buffer.c                       |  4 +-
 src/openvpn/crypto.c                       | 10 +++--
 src/openvpn/integer.h                      | 15 ++++++--
 src/openvpn/mss.c                          | 43 +++++++++++-----------
 src/openvpn/mss.h                          |  4 +-
 src/openvpn/mtu.c                          |  6 +--
 src/openvpn/mtu.h                          |  2 +-
 src/openvpn/options.c                      |  1 +
 src/openvpn/otime.c                        |  2 +-
 src/openvpn/otime.h                        |  2 +-
 src/openvpn/packet_id.c                    |  4 +-
 src/openvpn/reliable.c                     |  7 ++--
 src/openvpn/socket.h                       |  4 +-
 src/openvpn/tls_crypt.c                    |  2 +-
 src/openvpn/xkey_helper.c                  | 14 +++----
 tests/unit_tests/openvpn/mock_get_random.c |  2 +-
 tests/unit_tests/openvpn/test_crypto.c     |  6 +--
 tests/unit_tests/openvpn/test_packet_id.c  |  6 +--
 tests/unit_tests/openvpn/test_provider.c   |  2 +-
 tests/unit_tests/openvpn/test_tls_crypt.c  |  2 +-
 20 files changed, 74 insertions(+), 64 deletions(-)

-- 
2.34.1


