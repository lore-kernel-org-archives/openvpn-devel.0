From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 26 Aug 2022 10:54:21 +0200
Message-Id: <20220826085427.25302-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/6] uncrustify vs. operators
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

There are several different uncrustify settings
controlling the space around operators. This
series presents a few options of what to set.
Pick and choose ;)


Frank Lichtenheld (6):
  uncrustify: add space around compare operators
  reformat for sp_compare=add
  uncrustify: add space around "additive" operators
  reformat for sp_arith_additive=add
  uncrustify: add space around all arithmetic operators
  reformat for sp_arith=add

 config-msvc.h                                 |   2 +-
 dev-tools/uncrustify.conf                     |   2 +
 include/openvpn-plugin.h.in                   |   2 +-
 .../client-connect/sample-client-connect.c    |  32 +--
 sample/sample-plugins/defer/multi-auth.c      |  10 +-
 sample/sample-plugins/log/log.c               |  18 +-
 sample/sample-plugins/log/log_v3.c            |  18 +-
 sample/sample-plugins/simple/base64.c         |   2 +-
 src/compat/compat-gettimeofday.c              |   2 +-
 src/compat/compat-versionhelpers.h            |   2 +-
 src/openvpn/auth_token.c                      |  22 +-
 src/openvpn/basic.h                           |   2 +-
 src/openvpn/buffer.c                          |   8 +-
 src/openvpn/buffer.h                          |  76 ++---
 src/openvpn/common.h                          |   2 +-
 src/openvpn/comp.h                            |  18 +-
 src/openvpn/console_builtin.c                 |   2 +-
 src/openvpn/console_systemd.c                 |   2 +-
 src/openvpn/crypto.c                          |  12 +-
 src/openvpn/crypto.h                          |  16 +-
 src/openvpn/crypto_mbedtls.c                  |  28 +-
 src/openvpn/crypto_openssl.c                  |   6 +-
 src/openvpn/cryptoapi.c                       |  36 +--
 src/openvpn/dco.c                             |   2 +-
 src/openvpn/dco_freebsd.c                     |   4 +-
 src/openvpn/dco_linux.c                       |   2 +-
 src/openvpn/dhcp.c                            |  14 +-
 src/openvpn/env_set.c                         |   2 +-
 src/openvpn/error.c                           |  12 +-
 src/openvpn/error.h                           |  26 +-
 src/openvpn/event.c                           |  22 +-
 src/openvpn/event.h                           |   4 +-
 src/openvpn/forward.c                         |   8 +-
 src/openvpn/forward.h                         |  44 +--
 src/openvpn/gremlin.c                         |   8 +-
 src/openvpn/gremlin.h                         |  10 +-
 src/openvpn/httpdigest.c                      |   8 +-
 src/openvpn/httpdigest.h                      |   2 +-
 src/openvpn/init.c                            |  44 +--
 src/openvpn/init.h                            |  16 +-
 src/openvpn/integer.h                         |   4 +-
 src/openvpn/list.c                            |  18 +-
 src/openvpn/list.h                            |   4 +-
 src/openvpn/manage.c                          |  66 ++---
 src/openvpn/manage.h                          |  74 ++---
 src/openvpn/mbuf.h                            |   4 +-
 src/openvpn/misc.c                            |  14 +-
 src/openvpn/misc.h                            |  28 +-
 src/openvpn/mroute.h                          |  26 +-
 src/openvpn/mss.c                             |  10 +-
 src/openvpn/mstats.c                          |   2 +-
 src/openvpn/mtcp.c                            |  10 +-
 src/openvpn/mtu.c                             |   2 +-
 src/openvpn/mudp.c                            |   4 +-
 src/openvpn/multi.c                           |  14 +-
 src/openvpn/multi.h                           |  16 +-
 src/openvpn/ntlm.c                            |  16 +-
 src/openvpn/openssl_compat.h                  |   2 +-
 src/openvpn/openvpn.c                         |   2 +-
 src/openvpn/openvpn.h                         |   6 +-
 src/openvpn/options.c                         | 260 +++++++++---------
 src/openvpn/options.h                         |  74 ++---
 src/openvpn/otime.c                           |   2 +-
 src/openvpn/perf.c                            |   2 +-
 src/openvpn/pkcs11.c                          |  32 +--
 src/openvpn/pkcs11_openssl.c                  |   6 +-
 src/openvpn/platform.c                        |   8 +-
 src/openvpn/plugin.c                          |   4 +-
 src/openvpn/pool.c                            |   4 +-
 src/openvpn/proto.c                           |   2 +-
 src/openvpn/proto.h                           |  16 +-
 src/openvpn/proxy.c                           |  16 +-
 src/openvpn/ps.c                              |  12 +-
 src/openvpn/push.c                            |  12 +-
 src/openvpn/reliable.c                        |   6 +-
 src/openvpn/route.c                           |  32 +--
 src/openvpn/route.h                           |  52 ++--
 src/openvpn/run_command.h                     |   6 +-
 src/openvpn/schedule.c                        |   8 +-
 src/openvpn/shaper.h                          |   4 +-
 src/openvpn/socket.c                          |  44 +--
 src/openvpn/socket.h                          |  56 ++--
 src/openvpn/socks.c                           |   4 +-
 src/openvpn/ssl.c                             |  10 +-
 src/openvpn/ssl.h                             |  18 +-
 src/openvpn/ssl_common.h                      |  20 +-
 src/openvpn/ssl_mbedtls.c                     |  24 +-
 src/openvpn/ssl_ncp.c                         |   4 +-
 src/openvpn/ssl_openssl.c                     |  14 +-
 src/openvpn/ssl_pkt.c                         |   2 +-
 src/openvpn/ssl_verify.c                      |   6 +-
 src/openvpn/ssl_verify.h                      |   8 +-
 src/openvpn/ssl_verify_mbedtls.c              |  14 +-
 src/openvpn/ssl_verify_openssl.c              |  10 +-
 src/openvpn/status.c                          |   6 +-
 src/openvpn/status.h                          |   4 +-
 src/openvpn/syshead.h                         |   2 +-
 src/openvpn/tls_crypt.c                       |   2 +-
 src/openvpn/tls_crypt.h                       |   4 +-
 src/openvpn/tun.c                             |  46 ++--
 src/openvpn/win32.c                           |  26 +-
 src/openvpn/win32.h                           |   4 +-
 src/openvpn/xkey_common.h                     |   2 +-
 src/openvpn/xkey_provider.c                   |   6 +-
 src/openvpnmsica/openvpnmsica.c               |   8 +-
 src/openvpnserv/common.c                      |   2 +-
 src/openvpnserv/interactive.c                 |  28 +-
 src/openvpnserv/service.c                     |   4 +-
 src/openvpnserv/service.h                     |   6 +-
 src/plugins/auth-pam/auth-pam.c               |  40 +--
 src/plugins/auth-pam/pamdl.c                  |   2 +-
 src/plugins/auth-pam/utils.c                  |   6 +-
 src/plugins/down-root/down-root.c             |   2 +-
 src/tapctl/basic.h                            |   2 +-
 src/tapctl/error.h                            |  28 +-
 src/tapctl/main.c                             |   2 +-
 tests/unit_tests/openvpn/test_auth_token.c    |  26 +-
 tests/unit_tests/openvpn/test_buffer.c        |   8 +-
 tests/unit_tests/openvpn/test_pkt.c           |   6 +-
 tests/unit_tests/openvpn/test_provider.c      |   4 +-
 tests/unit_tests/openvpn/test_tls_crypt.c     |  10 +-
 121 files changed, 975 insertions(+), 973 deletions(-)

-- 
2.34.1


