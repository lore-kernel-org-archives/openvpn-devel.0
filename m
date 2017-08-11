From: Antonio Quartulli <a@...2181...>
Date: Fri, 11 Aug 2017 17:07:39 +0800
Message-Id: <20170811090744.31750-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 0/5] generic code clean-up
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
Cc: Antonio Quartulli <a@...2181...>

These 5 patches contain basic clean-up work about
issues highlighted by static analyzers during
some test-runs.

All the patches except "ensure function declarations are compiled with their
definitions" should be straightforward. For the latter
I can imagine there might be some arguments against it.

Cheers,


Antonio Quartulli (5):
  make function declarations C99 compliant
  ensure function declarations are compiled with their definitions
  add missing static attribute to functions
  remove unused functions
  use NULL instead of 0 when assigning pointers

 src/openvpn/buffer.c             |  2 +-
 src/openvpn/comp-lz4.c           |  2 +-
 src/openvpn/console.c            |  2 +-
 src/openvpn/console.h            |  8 ++++----
 src/openvpn/console_builtin.c    |  2 +-
 src/openvpn/console_systemd.c    |  4 ++--
 src/openvpn/crypto.c             |  4 ++--
 src/openvpn/crypto.h             |  5 ++++-
 src/openvpn/crypto_mbedtls.c     | 10 +++++-----
 src/openvpn/crypto_mbedtls.h     |  4 ++--
 src/openvpn/crypto_openssl.c     |  6 +++---
 src/openvpn/error.c              |  9 ++++-----
 src/openvpn/error.h              |  2 +-
 src/openvpn/forward-inline.h     | 28 ++--------------------------
 src/openvpn/forward.c            |  2 +-
 src/openvpn/forward.h            | 35 +++++++++++++++++++++++++++++++++++
 src/openvpn/init.c               |  2 +-
 src/openvpn/init.h               |  2 ++
 src/openvpn/interval.h           |  2 +-
 src/openvpn/lladdr.c             |  1 +
 src/openvpn/manage.c             |  8 ++++----
 src/openvpn/manage.h             | 11 ++++++-----
 src/openvpn/mbuf.h               |  4 ++--
 src/openvpn/misc.c               | 23 -----------------------
 src/openvpn/mroute.h             | 21 +++++++++++----------
 src/openvpn/mtcp.c               |  2 +-
 src/openvpn/multi.c              |  4 ++--
 src/openvpn/multi.h              |  7 +++----
 src/openvpn/ntlm.c               |  2 +-
 src/openvpn/occ-inline.h         | 10 +++-------
 src/openvpn/occ.h                |  6 ++++++
 src/openvpn/options.c            |  8 ++++----
 src/openvpn/packet_id.c          |  2 +-
 src/openvpn/packet_id.h          |  2 +-
 src/openvpn/pf-inline.h          |  6 ++----
 src/openvpn/pf.h                 |  6 ++++++
 src/openvpn/ping-inline.h        |  6 ++----
 src/openvpn/ping.h               |  4 ++++
 src/openvpn/pkcs11.c             |  6 +++---
 src/openvpn/platform.c           |  2 +-
 src/openvpn/plugin.h             |  2 ++
 src/openvpn/proxy.c              |  2 +-
 src/openvpn/ps.c                 |  4 ++--
 src/openvpn/route.c              |  4 ++--
 src/openvpn/socket.c             |  2 +-
 src/openvpn/socket.h             | 13 +++++++------
 src/openvpn/ssl.c                | 16 +++-------------
 src/openvpn/ssl_backend.h        |  6 +++---
 src/openvpn/ssl_mbedtls.c        |  6 +++---
 src/openvpn/ssl_openssl.c        | 20 +++++++-------------
 src/openvpn/ssl_verify_openssl.c |  4 ++--
 src/openvpn/win32.c              |  6 +++---
 src/openvpn/win32.h              |  4 ++--
 53 files changed, 175 insertions(+), 186 deletions(-)

-- 
2.14.0


