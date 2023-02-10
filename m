From: Arne Schwabe <arne@...1227...>
Date: Fri, 10 Feb 2023 15:27:04 +0100
Message-Id: <20230210142712.572303-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/4] Collections of miscellenaous patches
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

These are a few random patches that could have been sent as single patches to
the list but I bundle them here to indicate their "low priority"/impact.

Arne Schwabe (4):
  Combine extra_tun/frame parameter of frame_calculate_payload_overhead
  Update the last sections in the man page to a be a bit less outdated
  Revise the cipher negotiation about OpenVPN3 in the man page
  Reduce initialisation spam from verb <= 3 and print summary instead

 doc/man-sections/cipher-negotiation.rst |   5 +-
 doc/openvpn.8.rst                       |  11 +-
 src/openvpn/crypto.c                    |   4 +-
 src/openvpn/errlevel.h                  |   1 +
 src/openvpn/init.c                      | 143 +++++++++++++++++++++++-
 src/openvpn/mss.c                       |   2 +-
 src/openvpn/mtu.c                       |  14 +--
 src/openvpn/mtu.h                       |   6 +-
 src/openvpn/occ.c                       |   3 +-
 src/openvpn/occ.h                       |  16 +++
 src/openvpn/sig.c                       |  15 ---
 src/openvpn/ssl.c                       |   5 -
 src/openvpn/ssl_ncp.c                   |   2 +-
 13 files changed, 178 insertions(+), 49 deletions(-)

-- 
2.37.1 (Apple Git-137.1)


