From: Arne Schwabe <arne@...1227...>
Date: Fri, 10 May 2019 14:11:07 +0200
Message-Id: <20190510121114.30468-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 0/7] Auth token patches v3
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

This is the v3 of the patch series. I choose to resend all of the patches
so they all cleanly apply. Since the patches depend on the changes suggested
to --genkey, I made them part of the patch series. The other patches have
been updated to incoperate the feedback.

Arne Schwabe (7):
  Write key to stdout if filename is not given
  Implement --genkey type keyfile syntax and migrate tls-crypt-v2
  Add pem_read_key_file variant that allows a random key
  Rewrite auth-token-gen to be based on HMAC based tokens
  Implement a permanent session id in auth-token
  Sent indication that a session is expired to clients
  Implement unit tests for auth-gen-token

 doc/openvpn.8                              | 141 ++++++--
 src/openvpn/Makefile.am                    |   1 +
 src/openvpn/auth_token.c                   | 387 +++++++++++++++++++++
 src/openvpn/auth_token.h                   | 129 +++++++
 src/openvpn/crypto.c                       |  35 +-
 src/openvpn/crypto.h                       |  15 +
 src/openvpn/init.c                         |  90 +++--
 src/openvpn/manage.c                       |   4 +-
 src/openvpn/openvpn.h                      |   1 +
 src/openvpn/options.c                      | 103 ++++--
 src/openvpn/options.h                      |  19 +-
 src/openvpn/push.c                         |  70 +++-
 src/openvpn/push.h                         |   8 +
 src/openvpn/ssl.c                          |  13 +-
 src/openvpn/ssl_common.h                   |  56 +--
 src/openvpn/ssl_verify.c                   | 213 ++++++------
 src/openvpn/ssl_verify.h                   |  15 +-
 src/openvpn/tls_crypt.c                    |  13 +-
 tests/unit_tests/openvpn/Makefile.am       |  18 +-
 tests/unit_tests/openvpn/test_auth_token.c | 375 ++++++++++++++++++++
 20 files changed, 1457 insertions(+), 249 deletions(-)
 create mode 100644 src/openvpn/auth_token.c
 create mode 100644 src/openvpn/auth_token.h
 create mode 100644 tests/unit_tests/openvpn/test_auth_token.c

-- 
2.21.0


