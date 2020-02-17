From: Arne Schwabe <arne@...1227...>
Date: Mon, 17 Feb 2020 15:43:34 +0100
Message-Id: <20200217144339.3273-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v4 0/5] NCP v2 patch set
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

Resend all patches to make applying them easier and sort them into the order
they should be applied to keep Windows happy

Arne Schwabe (5):
  Only announce IV_NCP=2 when we are willing to support these ciphers
  Add strsep compat function
  Implement dynamic NCP negotiation
  Move NCP related function into a seperate file and add unit tests
  Normalise ncp-ciphers option and restrict it to 127 bytes

 configure.ac                         |   2 +-
 doc/openvpn.8                        |  13 +-
 src/compat/Makefile.am               |   1 +
 src/compat/compat-strsep.c           |  61 ++++++
 src/compat/compat.h                  |   4 +
 src/compat/compat.vcxproj            |   3 +-
 src/openvpn/Makefile.am              |   1 +
 src/openvpn/init.c                   |   3 +-
 src/openvpn/multi.c                  |   1 +
 src/openvpn/openvpn.vcxproj          |   2 +
 src/openvpn/openvpn.vcxproj.filters  |   8 +-
 src/openvpn/options.c                |  15 +-
 src/openvpn/push.c                   |  32 +++-
 src/openvpn/ssl.c                    |  85 +--------
 src/openvpn/ssl.h                    |  31 ---
 src/openvpn/ssl_common.h             |   2 +-
 src/openvpn/ssl_ncp.c                | 274 +++++++++++++++++++++++++++
 src/openvpn/ssl_ncp.h                | 116 ++++++++++++
 tests/unit_tests/openvpn/Makefile.am |  18 +-
 tests/unit_tests/openvpn/test_ncp.c  | 207 ++++++++++++++++++++
 20 files changed, 752 insertions(+), 127 deletions(-)
 create mode 100644 src/compat/compat-strsep.c
 create mode 100644 src/openvpn/ssl_ncp.c
 create mode 100644 src/openvpn/ssl_ncp.h
 create mode 100644 tests/unit_tests/openvpn/test_ncp.c

-- 
2.25.0


