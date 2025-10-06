From: Christian Kujau <lists@...2941...>
Date: Mon,  6 Oct 2025 16:42:46 +0200
Message-ID: <20251006144249.23672-1-lists@...2941...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 0/2] Documentation fixes
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
Cc: Christian Kujau <github@...2941...>

From: Christian Kujau <github@...2941...>

This started with fixing the three stale URLs in openvpn(8) but
got slightly out of hand and the 2nd commit contains some URL
fixes throughout the whole tree.

Christian Kujau (2):
  doc: Fix hyperlinks in openvpn(8)
  doc: HTTPS upgrades and URL fixes throughout the tree

 CONTRIBUTING.rst                      |  2 +-
 INSTALL                               |  8 ++++----
 PORTS                                 |  2 +-
 README                                |  3 ---
 dev-tools/git-pre-commit-format.sh    |  2 +-
 doc/android.txt                       |  2 +-
 doc/doxygen/doc_compression.h         |  2 +-
 doc/doxygen/doc_mainpage.h            |  2 +-
 doc/keying-material-exporter.txt      | 10 +++++-----
 doc/man-sections/link-options.rst     |  2 +-
 doc/man-sections/protocol-options.rst |  2 +-
 doc/openvpn.8.rst                     |  6 +++---
 m4/pkg.m4                             |  2 +-
 src/openvpn/list.c                    |  2 +-
 src/openvpn/memdbg.h                  |  2 +-
 src/openvpn/ntlm.c                    |  4 ++--
 src/openvpn/options.c                 |  2 +-
 src/openvpn/options.h                 |  2 +-
 src/openvpn/route.c                   |  4 ++--
 src/openvpn/socks.c                   |  2 +-
 src/openvpn/socks.h                   |  2 +-
 src/openvpn/tun.c                     |  4 ++--
 src/openvpn/win32-util.c              |  3 +--
 23 files changed, 34 insertions(+), 38 deletions(-)

-- 
2.50.1 (Apple Git-155)


