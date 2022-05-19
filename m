From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 19 May 2022 10:54:26 +0200
Message-Id: <20220519085428.6783-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/2] uncrustify: add sp_after_comma=add
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

Another thing that irritated me during patch
reviews that could be fixed with uncrustify.

Since there are a sizable number of fixes required
I split it in a reformat patch and an uncrustify
patch.

Frank Lichtenheld (2):
  Reformat for sp_after_comma=add
  uncrustify: add sp_after_comma=add

 dev-tools/uncrustify.conf                     |  1 +
 .../client-connect/sample-client-connect.c    |  2 +-
 .../keyingmaterialexporter.c                  |  2 +-
 src/compat/compat-versionhelpers.h            |  8 ++++----
 src/openvpn/buffer.c                          |  2 +-
 src/openvpn/comp-lz4.c                        |  4 ++--
 src/openvpn/crypto_mbedtls.c                  |  2 +-
 src/openvpn/cryptoapi.c                       |  2 +-
 src/openvpn/list.c                            |  2 +-
 src/openvpn/manage.c                          |  8 ++++----
 src/openvpn/mtu.c                             |  4 ++--
 src/openvpn/networking_sitnl.c                |  2 +-
 src/openvpn/options.c                         |  8 ++++----
 src/openvpn/pkcs11_openssl.c                  |  2 +-
 src/openvpn/pool.c                            |  2 +-
 src/openvpn/ps.c                              |  2 +-
 src/openvpn/route.c                           |  2 +-
 src/openvpn/run_command.c                     |  2 +-
 src/openvpn/socket.c                          | 12 +++++------
 src/openvpn/socket.h                          |  2 +-
 src/openvpn/ssl_ncp.c                         |  2 +-
 src/openvpn/ssl_openssl.c                     | 10 +++++-----
 src/openvpn/ssl_verify_openssl.c              |  2 +-
 src/openvpn/syshead.h                         |  4 ++--
 src/openvpn/win32.h                           |  2 +-
 src/openvpn/xkey_helper.c                     |  4 ++--
 src/openvpn/xkey_provider.c                   |  4 ++--
 src/plugins/auth-pam/utils.c                  |  8 ++++----
 tests/unit_tests/openvpn/test_ncp.c           |  4 ++--
 tests/unit_tests/openvpn/test_pkt.c           |  6 +++---
 tests/unit_tests/openvpn/test_provider.c      |  2 +-
 .../auth-pam/test_search_and_replace.c        | 20 +++++++++----------
 32 files changed, 70 insertions(+), 69 deletions(-)

-- 
2.30.2


