From: Frank Lichtenheld <frank@...2641...>
Date: Tue,  9 May 2023 13:12:02 +0200
Message-Id: <20230509111205.138997-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/3] Switch to CMake for Windows builds
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

Posted here to make people aware of the patch
set.

Reviews can also be done via https://gerrit.openvpn.net/

Also available as a branch at
https://github.com/flichtenheld/openvpn/tree/cmake

This is based on the initial CMake patch by
Arne Schwabe, but extends that to provide
a complete replacement for existing MinGW
build (autotools based) and MSVC build
(openvpn.sln).

The first patch in the series is Arne's original
patch to document his authorship. It makes not
a whole lot of sense to review that in isolation
and I will not apply any fixes to it. All changes
go into the second patch.

The following features are added while switching
these builds to CMake:
 - vcpkg support for MinGW build, allowing for
   trivial cross-compilation on Linux
 - Add unittests to MSVC build
 - Rework MSVC config header generation, removing
   need for separate headers between autotools
   and MSVC

The following advantages are reasons for switching
to CMake over the existing MSVC build:
 - Easier to maintain CMake files without IDE
   than the sln and vcxproj files
 - Able to maintain MSVC and MinGW build side-by-side

The plan is to completely remove the existing MSVC
build system but leave the existing autotools builds
in place as-is, including MinGW support.

CMake is not the intended build system for Unix-like
platforms and there are no current plans to switch
to it.

Arne Schwabe (1):
  add basic CMake based build

Frank Lichtenheld (2):
  CMake: Add complete MinGW and MSVC build
  Remove all traces of the previous MSVC build system

 .github/workflows/build.yaml                  | 297 ++-----
 .gitignore                                    |  12 +-
 CMakeLists.txt                                | 749 ++++++++++++++++++
 CMakePresets.json                             | 183 +++++
 Makefile.am                                   |   7 +-
 build/Makefile.am                             |   2 -
 build/msvc/Makefile.am                        |  15 -
 build/msvc/msvc-generate/Makefile.am          |  18 -
 build/msvc/msvc-generate/Makefile.mak         |  67 --
 build/msvc/msvc-generate/msvc-generate.js     | 118 ---
 .../msvc/msvc-generate/msvc-generate.vcxproj  | 158 ----
 build/msvc/msvc-generate/version.m4.in        |   3 -
 config-msvc-version.h.in                      |  14 -
 config-msvc.h                                 |  93 ---
 config.h.cmake.in                             | 488 ++++++++++++
 configure.ac                                  |   2 -
 .../cmake}/git-version.py                     |   0
 contrib/cmake/parse-version.m4.py             |  58 ++
 contrib/vcpkg-manifests/mingw/vcpkg.json      |  13 +
 contrib/vcpkg-manifests/windows/vcpkg.json    |  20 +
 .../vcpkg-ports/pkcs11-helper/portfile.cmake  |  22 +-
 doc/CMakeLists.txt                            |  81 ++
 openvpn.sln                                   | 107 ---
 src/compat/Debug.props                        |  21 -
 src/compat/Makefile.am                        |   6 -
 src/compat/PropertySheet.props                |  29 -
 src/compat/Release.props                      |  26 -
 src/compat/compat-basename.c                  |   2 -
 src/compat/compat-daemon.c                    |   2 -
 src/compat/compat-dirname.c                   |   2 -
 src/compat/compat-gettimeofday.c              |   2 -
 src/compat/compat-strsep.c                    |   2 -
 src/compat/compat.vcxproj                     | 179 -----
 src/openvpn/Makefile.am                       |   1 -
 src/openvpn/argv.c                            |   2 -
 src/openvpn/auth_token.c                      |   2 -
 src/openvpn/base64.c                          |   2 -
 src/openvpn/block_dns.c                       |   2 -
 src/openvpn/buffer.c                          |   2 -
 src/openvpn/clinat.c                          |   2 -
 src/openvpn/comp-lz4.c                        |   2 -
 src/openvpn/comp.c                            |   2 -
 src/openvpn/compstub.c                        |   2 -
 src/openvpn/console.c                         |   2 -
 src/openvpn/console_builtin.c                 |   2 -
 src/openvpn/crypto.c                          |   2 -
 src/openvpn/crypto_mbedtls.c                  |   2 -
 src/openvpn/crypto_openssl.c                  |   2 -
 src/openvpn/cryptoapi.c                       |   2 -
 src/openvpn/dco.c                             |   2 -
 src/openvpn/dco_freebsd.c                     |   2 -
 src/openvpn/dco_linux.c                       |   2 -
 src/openvpn/dco_win.c                         |   2 -
 src/openvpn/dhcp.c                            |   2 -
 src/openvpn/dns.c                             |   2 -
 src/openvpn/env_set.c                         |   2 -
 src/openvpn/error.c                           |   2 -
 src/openvpn/event.c                           |   2 -
 src/openvpn/fdmisc.c                          |   2 -
 src/openvpn/forward.c                         |   2 -
 src/openvpn/fragment.c                        |   2 -
 src/openvpn/gremlin.c                         |   2 -
 src/openvpn/helper.c                          |   2 -
 src/openvpn/httpdigest.c                      |   2 -
 src/openvpn/init.c                            |   2 -
 src/openvpn/interval.c                        |   2 -
 src/openvpn/list.c                            |   2 -
 src/openvpn/lladdr.c                          |   2 -
 src/openvpn/lzo.c                             |   2 -
 src/openvpn/lzo.h                             |   9 +-
 src/openvpn/manage.c                          |   2 -
 src/openvpn/mbuf.c                            |   2 -
 src/openvpn/misc.c                            |   2 -
 src/openvpn/mroute.c                          |   2 -
 src/openvpn/mss.c                             |   2 -
 src/openvpn/mstats.c                          |   2 -
 src/openvpn/mtcp.c                            |   2 -
 src/openvpn/mtu.c                             |   2 -
 src/openvpn/mudp.c                            |   2 -
 src/openvpn/multi.c                           |   2 -
 src/openvpn/networking_freebsd.c              |   2 -
 src/openvpn/networking_iproute2.c             |   2 -
 src/openvpn/networking_sitnl.c                |   2 -
 src/openvpn/ntlm.c                            |   2 -
 src/openvpn/occ.c                             |   2 -
 src/openvpn/openssl_compat.h                  |   2 -
 src/openvpn/openvpn.c                         |   2 -
 src/openvpn/openvpn.vcxproj                   | 470 -----------
 src/openvpn/openvpn_win32_resources.rc        |   2 -
 src/openvpn/options.c                         |   2 -
 src/openvpn/options_util.c                    |   2 -
 src/openvpn/otime.c                           |   2 -
 src/openvpn/packet_id.c                       |   2 -
 src/openvpn/perf.c                            |   2 -
 src/openvpn/ping.c                            |   2 -
 src/openvpn/pkcs11.c                          |   2 -
 src/openvpn/pkcs11_mbedtls.c                  |   2 -
 src/openvpn/pkcs11_openssl.c                  |   2 -
 src/openvpn/platform.c                        |   2 -
 src/openvpn/plugin.c                          |   2 -
 src/openvpn/pool.c                            |   2 -
 src/openvpn/proto.c                           |   2 -
 src/openvpn/proxy.c                           |   2 -
 src/openvpn/ps.c                              |   2 -
 src/openvpn/push.c                            |   2 -
 src/openvpn/reflect_filter.c                  |   2 -
 src/openvpn/reliable.c                        |   2 -
 src/openvpn/route.c                           |   2 -
 src/openvpn/run_command.c                     |   2 -
 src/openvpn/schedule.c                        |   2 -
 src/openvpn/session_id.c                      |   2 -
 src/openvpn/shaper.c                          |   2 -
 src/openvpn/sig.c                             |   2 -
 src/openvpn/socket.c                          |   2 -
 src/openvpn/socks.c                           |   2 -
 src/openvpn/ssl.c                             |   2 -
 src/openvpn/ssl_mbedtls.c                     |   2 -
 src/openvpn/ssl_ncp.c                         |   2 -
 src/openvpn/ssl_openssl.c                     |   2 -
 src/openvpn/ssl_pkt.c                         |   2 -
 src/openvpn/ssl_util.c                        |   2 -
 src/openvpn/ssl_verify.c                      |   2 -
 src/openvpn/ssl_verify_mbedtls.c              |   2 -
 src/openvpn/ssl_verify_openssl.c              |   2 -
 src/openvpn/status.c                          |   2 -
 src/openvpn/tls_crypt.c                       |   2 -
 src/openvpn/tun.c                             |   2 -
 src/openvpn/vcpkg.json                        |  15 -
 src/openvpn/vlan.c                            |   2 -
 src/openvpn/win32-util.c                      |   2 -
 src/openvpn/win32.c                           |   2 -
 src/openvpn/xkey_helper.c                     |   2 -
 src/openvpn/xkey_provider.c                   |   2 -
 src/openvpnmsica/CMakeLists.txt               |  36 +
 src/openvpnmsica/Makefile.am                  |   6 -
 src/openvpnmsica/dllmain.c                    |   2 -
 src/openvpnmsica/msica_arg.c                  |   2 -
 src/openvpnmsica/msiex.c                      |   2 -
 src/openvpnmsica/openvpnmsica-Debug.props     |  14 -
 src/openvpnmsica/openvpnmsica-Release.props   |  15 -
 src/openvpnmsica/openvpnmsica.c               |   2 -
 src/openvpnmsica/openvpnmsica.props           |  17 -
 src/openvpnmsica/openvpnmsica.vcxproj         | 208 -----
 src/openvpnmsica/openvpnmsica_resources.rc    |   2 -
 src/openvpnserv/CMakeLists.txt                |  34 +
 src/openvpnserv/Makefile.am                   |   3 -
 src/openvpnserv/openvpnserv.vcxproj           | 229 ------
 src/openvpnserv/openvpnserv_resources.rc      |   2 -
 src/openvpnserv/service.h                     |   2 -
 src/tapctl/CMakeLists.txt                     |  31 +
 src/tapctl/Makefile.am                        |   5 -
 src/tapctl/main.c                             |   2 -
 src/tapctl/tap.c                              |   2 -
 src/tapctl/tapctl.props                       |  18 -
 src/tapctl/tapctl.vcxproj                     | 205 -----
 src/tapctl/tapctl_resources.rc                |   2 -
 tests/unit_tests/openvpn/mock_msg.c           |   2 -
 tests/unit_tests/openvpn/pkey_test_utils.c    |   2 -
 tests/unit_tests/openvpn/test_auth_token.c    |   2 -
 tests/unit_tests/openvpn/test_buffer.c        |   2 -
 tests/unit_tests/openvpn/test_crypto.c        |   2 -
 tests/unit_tests/openvpn/test_cryptoapi.c     |   2 -
 tests/unit_tests/openvpn/test_misc.c          |   2 -
 tests/unit_tests/openvpn/test_ncp.c           |   2 -
 tests/unit_tests/openvpn/test_packet_id.c     |   2 -
 tests/unit_tests/openvpn/test_pkcs11.c        |   2 -
 tests/unit_tests/openvpn/test_pkt.c           |   2 -
 tests/unit_tests/openvpn/test_provider.c      |   2 -
 tests/unit_tests/openvpn/test_tls_crypt.c     |   2 -
 169 files changed, 1798 insertions(+), 2554 deletions(-)
 create mode 100644 CMakeLists.txt
 create mode 100644 CMakePresets.json
 delete mode 100644 build/msvc/Makefile.am
 delete mode 100644 build/msvc/msvc-generate/Makefile.am
 delete mode 100644 build/msvc/msvc-generate/Makefile.mak
 delete mode 100644 build/msvc/msvc-generate/msvc-generate.js
 delete mode 100644 build/msvc/msvc-generate/msvc-generate.vcxproj
 delete mode 100644 build/msvc/msvc-generate/version.m4.in
 delete mode 100644 config-msvc-version.h.in
 delete mode 100644 config-msvc.h
 create mode 100644 config.h.cmake.in
 rename {build/msvc/msvc-generate => contrib/cmake}/git-version.py (100%)
 create mode 100644 contrib/cmake/parse-version.m4.py
 create mode 100644 contrib/vcpkg-manifests/mingw/vcpkg.json
 create mode 100644 contrib/vcpkg-manifests/windows/vcpkg.json
 create mode 100644 doc/CMakeLists.txt
 delete mode 100644 openvpn.sln
 delete mode 100644 src/compat/Debug.props
 delete mode 100644 src/compat/PropertySheet.props
 delete mode 100644 src/compat/Release.props
 delete mode 100644 src/compat/compat.vcxproj
 delete mode 100644 src/openvpn/openvpn.vcxproj
 delete mode 100644 src/openvpn/vcpkg.json
 create mode 100644 src/openvpnmsica/CMakeLists.txt
 delete mode 100644 src/openvpnmsica/openvpnmsica-Debug.props
 delete mode 100644 src/openvpnmsica/openvpnmsica-Release.props
 delete mode 100644 src/openvpnmsica/openvpnmsica.props
 delete mode 100644 src/openvpnmsica/openvpnmsica.vcxproj
 create mode 100644 src/openvpnserv/CMakeLists.txt
 delete mode 100644 src/openvpnserv/openvpnserv.vcxproj
 create mode 100644 src/tapctl/CMakeLists.txt
 delete mode 100644 src/tapctl/tapctl.props
 delete mode 100644 src/tapctl/tapctl.vcxproj

-- 
2.34.1


