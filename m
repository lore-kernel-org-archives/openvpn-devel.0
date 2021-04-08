From: Arne Schwabe <arne@...1227...>
Date: Thu,  8 Apr 2021 16:02:25 +0200
Message-Id: <20210408140229.31824-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 0/3] P2P NCP support patch set
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

Note: this patchset requires the "Move context_auth from context_2 
to tls_multi and name it multi_state" patch to be applied first.

Our P2P mode is currently lacking in features compared to the
P2MP mode. Especially EKM, DATA_v2 and NCP cannot be used with
P2P mode. And the differences increase code complexity as we
need to maintain two code paths. As we don't intend to
deprecate P2P mode, this patchset implements NCP for P2P mode.

P2P NCP is lot less ambigous than normal NCP and will only
be activated if both peers support it and avoids all the
edge cases of different level of support for different
versions.

Arne Schwabe (3):
  Change options->data_channel_use_ekm to flags
  Remove --ncp-disable option
  Support NCP in pure P2P VPN setups

 Changes.rst                           |   4 +
 doc/man-sections/protocol-options.rst |   8 +-
 src/openvpn/init.c                    | 113 +++++++++++++----
 src/openvpn/multi.c                   |   9 +-
 src/openvpn/options.c                 |  48 ++-----
 src/openvpn/options.h                 |   5 +-
 src/openvpn/push.c                    |   2 +-
 src/openvpn/ssl.c                     | 173 ++++++++++++++++++--------
 src/openvpn/ssl.h                     |   5 +
 src/openvpn/ssl_backend.h             |   1 +
 src/openvpn/ssl_common.h              |  11 +-
 src/openvpn/ssl_ncp.c                 | 149 +++++++++++++++++++++-
 src/openvpn/ssl_ncp.h                 |  25 ++++
 tests/unit_tests/openvpn/test_ncp.c   |  11 ++
 14 files changed, 426 insertions(+), 138 deletions(-)

-- 
2.31.1


