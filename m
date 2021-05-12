From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 May 2021 15:15:02 +0200
Message-Id: <20210512131511.1309914-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/9] Miscellaneous cleanup patches/small
 fixes
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

This patch set has a number of small fixes/improvements and documentation
fixes/updates. They should be able to be applied in any order and have weak
relationship to each other at best. I am sending them in one patch set to
make review/keeping track of patches easier.

Arne Schwabe (9):
  Remove explicit struct iovec check (HAVE_IOVEC)
  Remove getpeername, getpid check
  Inline do_init_auth_token_key
  Add missing free_key_ctx for auth_token
  Add ifdef guards to unit test
  Add noreturn attribute for MSVC to assert_failed method.
  Move utility function from win32.c to win32-util.c
  Document stub-v2 being basically an alias for no compression at all
  Add detailed man page section to setup a OpenVPN setup with
    peer-fingerprint

 Changes.rst                                |   4 +
 configure.ac                               |   5 +-
 doc/Makefile.am                            |   1 +
 doc/man-sections/example-fingerprint.rst   | 194 +++++++++++++++++++++
 doc/man-sections/protocol-options.rst      |   5 +
 src/openvpn/Makefile.am                    |   1 +
 src/openvpn/error.h                        |  12 +-
 src/openvpn/init.c                         |  24 +--
 src/openvpn/openvpn.vcxproj                |   2 +
 src/openvpn/openvpn.vcxproj.filters        |   3 +
 src/openvpn/platform.c                     |   4 -
 src/openvpn/socket.c                       |   7 -
 src/openvpn/syshead.h                      |   6 +-
 src/openvpn/win32-util.c                   | 137 +++++++++++++++
 src/openvpn/win32-util.h                   |  41 +++++
 src/openvpn/win32.c                        |  96 +---------
 src/openvpn/win32.h                        |   6 -
 tests/unit_tests/openvpn/test_argv.c       |   2 +
 tests/unit_tests/openvpn/test_auth_token.c |   2 +
 tests/unit_tests/openvpn/test_crypto.c     |   4 +
 tests/unit_tests/openvpn/test_misc.c       |   2 +
 tests/unit_tests/openvpn/test_ncp.c        |   2 +
 tests/unit_tests/openvpn/test_tls_crypt.c  |   2 +
 23 files changed, 426 insertions(+), 136 deletions(-)
 create mode 100644 doc/man-sections/example-fingerprint.rst
 create mode 100644 src/openvpn/win32-util.c
 create mode 100644 src/openvpn/win32-util.h

-- 
2.31.1


