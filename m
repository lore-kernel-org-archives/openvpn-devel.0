From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 31 Jul 2023 11:27:05 +0000
References: <gerrit.1690802820000.I666314a223d324ca72dbe7ba7d22f764996d3ca2@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5686a39411cec135016dd392f76ed665e9f067ee-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CK9831YH5ZI="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[release/2.6]: add basic
 CMake based build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>

--CK9831YH5ZI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

stipa has uploaded this change for review. ( http://gerrit.openvpn.net/c/op=
envpn/+/322?usp=3Demail )


Change subject: add basic CMake based build
......................................................................

add basic CMake based build

This helps with IDE integration among other things.

This is a basic implementation for development purposes
that can't replace any of the existing release builds.

Change-Id: I666314a223d324ca72dbe7ba7d22f764996d3ca2
Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
A CMakeLists.txt
A config.h.cmake.in
M src/openvpn/lzo.h
3 files changed, 1,091 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/322/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
new file mode 100644
index 0000000..9978ea4
--- /dev/null
+++ b/CMakeLists.txt
@@ -0,0 +1,591 @@
+  cmake_minimum_required(VERSION 3.3)
+project(openvpn)
+
+# This CMake file implements building OpenVPN with CMAKE
+#
+# Note that this is *NOT* the official way to build openvpn on anything
+# other than Windows/mingw despite working on other platforms too. You wil=
l need
+# to add -DUNSUPPORTED_BUILDS=3Dtrue to build on non Windows platforms.
+#
+# This cmake also makes a few assertions like lzo, lz4 being used
+# and OpenSSL having version 1.1.1+ and generally does not offer the same
+# configurability like autoconf
+
+# -DCMAKE_TOOLCHAIN_FILE=3DC:/Users/User/source/repos/vcpkg/scripts/builds=
ystems/vcpkg.cmake
+#-DVCPKG_OVERLAY_PORTS=3DC:/Users/User/source/repos/openvpn/contrib/vcpkg-=
ports
+#-GNinja
+
+option(UNSUPPORTED_BUILDS "Allow unsupported builds" OFF)
+
+if (NOT WIN32 AND NOT ${UNSUPPORTED_BUILDS})
+    message(FATAL_ERROR "Note: on Unix platform the official and supported=
 build method is using autoconfig. CMake based build should be only used fo=
r Windows and internal testing/development.")
+endif()
+
+option(MBED "BUILD with mbed" OFF)
+option(WOLFSSL "BUILD with wolfSSL" OFF)
+if (MSVC)
+    option(USE_WERROR "Treat compiler warnings as errors (-Werror)" OFF)
+else ()
+    option(USE_WERROR "Treat compiler warnings as errors (-Werror)" ON)
+endif ()
+option(PLUGIN_DIR "Location of the plugin directory" /usr/local/lib/openvp=
n/plugins)
+
+# AddressSanitize - use CXX=3Dclang++ CC=3Dclang cmake -DCMAKE_BUILD_TYPE=
=3Dasan to build with ASAN
+set(CMAKE_C_FLAGS_ASAN
+        "-fsanitize=3Daddress,undefined -fno-sanitize-recover=3Dall -fno-o=
ptimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-po=
inter -g -O1"
+        CACHE STRING "Flags used by the C compiler during AddressSanitizer=
 builds."
+        FORCE)
+set(CMAKE_CXX_FLAGS_ASAN
+        "-fsanitize=3Daddress,undefined -fno-sanitize-recover=3Dall -fno-o=
ptimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-po=
inter -g -O1"
+        CACHE STRING "Flags used by the C++ compiler during AddressSanitiz=
er builds."
+        FORCE)
+
+if (MSVC)
+    target_compile_options(${target} PRIVATE /W3)
+else ()
+    add_compile_options(-Wall -Wuninitialized)
+    # We are not ready for this
+    #add_compile_options(-Wsign-compare)
+endif ()
+
+find_package(PkgConfig)
+INCLUDE(CheckSymbolExists)
+INCLUDE(CheckIncludeFiles)
+INCLUDE(CheckTypeSize)
+INCLUDE(CheckStructHasMember)
+
+set(OPENVPN_VERSION_MAJOR 2)
+set(OPENVPN_VERSION_MINOR 6)
+set(OPENVPN_VERSION_PATCH _git)
+
+if (NOT WIN32)
+    add_definitions(-DPLUGIN_LIBDIR=3D\"${PLUGIN_DIR}\")
+endif ()
+
+# TODO remove later when msvc-config.h is removed and we can always includ=
e config.h
+add_definitions(-DHAVE_CONFIG_H)
+
+
+# Set the various defines for config.h.cmake.in
+if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
+    set(TARGET_LINUX YES)
+    set(ENABLE_ASYNC_PUSH YES)
+    set(ENABLE_LINUXDCO YES)
+    set(ENABLE_SITNL YES)
+    set(HAVE_DECL_SO_MARK YES)
+    set(ENABLE_FEATURE_TUN_PERSIST 1)
+    set(HAVE_LINUX_TYPES_H 1)
+    set(ENABLE_DCO YES)
+    set(HAVE_CMSGHDR YES)
+elseif (${CMAKE_SYSTEM_NAME} STREQUAL "FreeBSD")
+    set(TARGET_FREEBSD YES)
+    set(ENABLE_DCO YES)
+    link_libraries(-lnv)
+elseif (WIN32)
+    set(ENABLE_DCO YES)
+elseif (APPLE)
+    set(TARGET_DARWIN YES)
+    set(HAVE_NET_IF_UTUN_H YES)
+endif ()
+
+if (UNIX)
+    set(PATH_SEPARATOR /)
+    set(ENABLE_PORT_SHARE YES)
+    set(HAVE_SA_FAMILY_T YES)
+elseif (WIN32)
+    set(PATH_SEPARATOR \\\\)
+    set(TARGET_WIN32 YES)
+endif ()
+
+CHECK_SYMBOL_EXISTS(chroot unistd.h HAVE_CHROOT)
+CHECK_SYMBOL_EXISTS(chdir unistd.h HAVE_CHDIR)
+CHECK_SYMBOL_EXISTS(dup unistd.h HAVE_DUP)
+CHECK_SYMBOL_EXISTS(dup2 unistd.h HAVE_DUP2)
+CHECK_SYMBOL_EXISTS(fork unistd.h HAVE_FORK)
+CHECK_SYMBOL_EXISTS(execve unistd.h HAVE_EXECVE)
+CHECK_SYMBOL_EXISTS(ftruncate unistd.h HAVE_FTRUNCATE)
+CHECK_SYMBOL_EXISTS(setgid unistd.h HAVE_SETGID)
+CHECK_SYMBOL_EXISTS(setuid unistd.h HAVE_SETUID)
+CHECK_SYMBOL_EXISTS(getpeereid unistd.h HAVE_GETPEEREID)
+
+CHECK_SYMBOL_EXISTS(epoll_create sys/epoll.h HAVE_EPOLL_CREATE)
+
+CHECK_SYMBOL_EXISTS(gettimeofday sys/time.h HAVE_GETTIMEOFDAY)
+CHECK_SYMBOL_EXISTS(basename libgen.h HAVE_BASENAME)
+CHECK_SYMBOL_EXISTS(chsize io.h HAVE_CHSIZE)
+CHECK_SYMBOL_EXISTS(daemon stdlib.h HAVE_DAEMON)
+CHECK_SYMBOL_EXISTS(dirname libgen.h HAVE_DIRNAME)
+CHECK_SYMBOL_EXISTS(getrlimit sys/resource.h HAVE_GETRLIMIT)
+CHECK_SYMBOL_EXISTS(mlockall sys/mman.h HAVE_MLOCKALL)
+
+CHECK_SYMBOL_EXISTS(sendmsg sys/socket.h HAVE_SENDMSG)
+CHECK_SYMBOL_EXISTS(recvmsg sys/socket.h HAVE_RECVMSG)
+CHECK_SYMBOL_EXISTS(cmsghdr sys/socket.h HAVE_CMSGHDR)
+CHECK_SYMBOL_EXISTS(openlog syslog.h HAVE_OPENLOG)
+CHECK_SYMBOL_EXISTS(syslog syslog.h HAVE_SYSLOG)
+CHECK_SYMBOL_EXISTS(getgrnam grp.h HAVE_GETGRNAM)
+CHECK_SYMBOL_EXISTS(getpwnam pwd.h HAVE_GETPWNAM)
+CHECK_SYMBOL_EXISTS(getsockname sys/socket.h HAVE_GETSOCKNAME)
+
+# Some OS (e.g. FreeBSD) need some basic headers to allow
+# including network headers
+SET(NETEXTRA sys/types.h)
+CHECK_INCLUDE_FILES("${NETEXTRA};netinet/in.h" HAVE_NETINET_IN_H)
+
+if (HAVE_NETINET_IN_H)
+    LIST(APPEND NETEXTRA netinet/in.h)
+endif ()
+
+CHECK_INCLUDE_FILES("${NETEXTRA};netinet/in6.h" HAVE_NETINET_IN_H)
+CHECK_INCLUDE_FILES(linux/if_tun.h HAVE_LINUX_IF_TUN_H)
+CHECK_INCLUDE_FILES(linux/sockios.h HAVE_LINUX_SOCKIOS_H)
+CHECK_INCLUDE_FILES(dlfcn.h HAVE_DLFCN_H)
+CHECK_INCLUDE_FILES(fcntl.h HAVE_FCNTL_H)
+CHECK_INCLUDE_FILES(dmalloc.h HAVE_DMALLOC_H)
+CHECK_INCLUDE_FILES(err.h HAVE_ERR_H)
+CHECK_INCLUDE_FILES(sys/epoll.h HAVE_SYS_EPOLL_H)
+CHECK_INCLUDE_FILES(poll.h HAVE_POLL_H)
+CHECK_INCLUDE_FILES(sys/socket.h HAVE_SYS_SOCKET_H)
+CHECK_INCLUDE_FILES(sys/time.h HAVE_SYS_TIME_H)
+CHECK_INCLUDE_FILES(netdb.h HAVE_NETDB_H)
+CHECK_INCLUDE_FILES(unistd.h HAVE_UNISTD_H)
+CHECK_INCLUDE_FILES(sys/un.h HAVE_SYS_UN_H)
+CHECK_INCLUDE_FILES(libgen.h HAVE_LIBGEN_H)
+CHECK_INCLUDE_FILES(net/if.h HAVE_NET_IF_H)
+CHECK_INCLUDE_FILES("${NETEXTRA};netinet/ip.h" HAVE_NETINET_IP_H)
+CHECK_INCLUDE_FILES(arpa/inet.h HAVE_ARPA_INET_H)
+CHECK_INCLUDE_FILES(net/if_utun.h HAVE_NET_UTUN_H)
+CHECK_INCLUDE_FILES(sys/ioctl.h HAVE_SYS_IOCTL_H)
+CHECK_INCLUDE_FILES(sys/inotify.h HAVE_SYS_INOTIFY_H)
+CHECK_INCLUDE_FILES("${NETEXTRA};sys/uio.h" HAVE_SYS_UIO_H)
+CHECK_INCLUDE_FILES(syslog.h HAVE_SYSLOG_H)
+CHECK_INCLUDE_FILES(sys/wait.h HAVE_SYS_WAIT_H)
+CHECK_INCLUDE_FILES(grp.h HAVE_GRP_H)
+CHECK_INCLUDE_FILES(pwd.h HAVE_PWD_H)
+CHECK_INCLUDE_FILES(sys/mman.h HAVE_SYS_MMAN_H)
+
+
+CHECK_INCLUDE_FILES("${NETEXTRA};resolv.h" HAVE_RESOLV_H)
+CHECK_INCLUDE_FILES("${NETEXTRA};net/if_tun.h" HAVE_NET_IF_TUN_H)
+
+# Is this obscure header needed anywhere?!
+CHECK_INCLUDE_FILES(netinet/in_systm.h HAVE_NETINET_IN_SYSTM_H)
+
+
+SET(CMAKE_EXTRA_INCLUDE_FILES netinet/ip.h)
+CHECK_TYPE_SIZE("struct in_pktinfo" IN_PKTINFO)
+CHECK_STRUCT_HAS_MEMBER("struct in_pktinfo" ipi_spec_dst netinet/ip.h HAVE=
_IPI_SPEC_DST)
+CHECK_TYPE_SIZE("struct msghdr" MSGHDR)
+SET(CMAKE_EXTRA_INCLUDE_FILES)
+
+find_program(IFCONFIG_PATH ifconfig)
+find_program(IPROUTE_PATH ip)
+find_program(ROUTE_PATH route)
+
+
+if (NOT WIN32)
+    set(ENABLE_LZ4 YES)
+    set(ENABLE_LZO YES)
+endif ()
+
+function(add_library_deps target)
+    if (${MBED})
+        target_include_directories(${target} PRIVATE $ENV{HOME}/oss/mbedtl=
s2/include)
+        message("Building ${target} for mbed TLS")
+        target_link_libraries(${target} PUBLIC -L$ENV{HOME}/oss/mbedtls2/l=
ibrary -L/usr/local/opt/lzo/lib -lmbedtls -lmbedx509 -lmbedcrypto)
+    elseif (${WOLFSSL})
+        pkg_search_module(wolfssl wolfssl REQUIRED)
+        target_link_libraries(${target} PUBLIC ${wolfssl_LINK_LIBRARIES})
+        target_include_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIR=
S}/wolfssl)
+        message("Building ${target} for WolfSSL: ${wolfssl_LINK_LIBRARIES}=
 ${wolfssl_INCLUDE_DIRS}/wolfsll")
+    else ()
+        set(ENABLE_X509ALTUSERNAME YES)
+
+        find_package(OpenSSL REQUIRED)
+        target_link_libraries(${target} PUBLIC OpenSSL::SSL)
+
+        message("Building ${target} for default OpenSSL")
+    endif ()
+
+
+    if (${ENABLE_LZ4})
+        pkg_search_module(liblz4 liblz4 REQUIRED IMPORTED_TARGET)
+        target_link_libraries(${target} PUBLIC PkgConfig::liblz4)
+    endif ()
+
+    if (${ENABLE_LZO})
+        pkg_search_module(lzo2 lzo2 REQUIRED IMPORTED_TARGET)
+        target_link_libraries(${target} PUBLIC PkgConfig::lzo2)
+    endif ()
+
+    if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
+        target_include_directories(${target} PUBLIC ${LIBNL_INCLUDE_DIRS})
+        target_link_libraries(${target} PUBLIC ${LIBNL_LIBRARIES})
+    endif ()
+
+    if (USE_WERROR)
+        if (MSVC)
+            target_compile_options(${target} PRIVATE /WX)
+        else ()
+            target_compile_options(${target} PRIVATE -Werror)
+        endif ()
+    endif ()
+endfunction()
+
+if (${MBED})
+    set(ENABLE_CRYPTO_MBEDTLS YES)
+elseif (${WOLFSSL})
+    set(ENABLE_CRYPTO_OPENSSL YES)
+    set(ENABLE_CRYPTO_WOLFSSL YES)
+    set(ENABLE_X509ALTUSERNAME YES)
+else ()
+    set(ENABLE_CRYPTO_OPENSSL YES)
+    set(ENABLE_X509ALTUSERNAME YES)
+endif ()
+
+include_directories(${CMAKE_CURRENT_SOURCE_DIR} src/compat include)
+
+if (WIN32)
+    find_package(OpenSSL REQUIRED)
+
+    link_libraries(OpenSSL::SSL OpenSSL::Crypto ws2_32.lib Crypt32.lib fwp=
uclnt.lib iphlpapi.lib
+            wininet.lib setupapi.lib rpcrt4.lib wtsapi32.lib Ncrypt.lib)
+    add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE =
-D _WINSOCK_DEPRECATED_NO_WARNINGS -D_CONSOLE)
+endif ()
+
+configure_file(config.h.cmake.in config.h)
+configure_file(include/openvpn-plugin.h.in openvpn-plugin.h)
+
+include_directories(${CMAKE_CURRENT_BINARY_DIR})
+
+set(SOURCE_FILES
+        ${CMAKE_CURRENT_BINARY_DIR}/config.h
+        ${CMAKE_CURRENT_BINARY_DIR}/openvpn-plugin.h
+
+        src/compat/compat-basename.c
+        src/compat/compat-daemon.c
+        src/compat/compat-dirname.c
+        src/compat/compat-gettimeofday.c
+        src/compat/compat-strsep.c
+        src/compat/compat-versionhelpers.h
+        src/openvpn/argv.c
+        src/openvpn/argv.h
+        src/openvpn/base64.c
+        src/openvpn/base64.h
+        src/openvpn/basic.h
+        src/openvpn/block_dns.h
+        src/openvpn/block_dns.c
+        src/openvpn/buffer.c
+        src/openvpn/buffer.h
+        src/openvpn/circ_list.h
+        src/openvpn/clinat.c
+        src/openvpn/clinat.h
+        src/openvpn/common.h
+        src/openvpn/comp-lz4.c
+        src/openvpn/comp-lz4.h
+        src/openvpn/comp.c
+        src/openvpn/comp.h
+        src/openvpn/compstub.c
+        src/openvpn/console.c
+        src/openvpn/console_builtin.c
+        src/openvpn/console.h
+        src/openvpn/crypto.c
+        src/openvpn/crypto.h
+        src/openvpn/crypto_backend.h
+        src/openvpn/crypto_openssl.c
+        src/openvpn/crypto_openssl.h
+        src/openvpn/crypto_mbedtls.c
+        src/openvpn/crypto_mbedtls.h
+        src/openvpn/cryptoapi.c
+        src/openvpn/cryptoapi.h
+        src/openvpn/dco.c
+        src/openvpn/dco.h
+        src/openvpn/dco_win.c
+        src/openvpn/dco_win.h
+        src/openvpn/dco_linux.c
+        src/openvpn/dco_linux.h
+        src/openvpn/dco_freebsd.c
+        src/openvpn/dco_freebsd.h
+        src/openvpn/dhcp.c
+        src/openvpn/dhcp.h
+        src/openvpn/dns.c
+        src/openvpn/dns.h
+        src/openvpn/errlevel.h
+        src/openvpn/env_set.c
+        src/openvpn/env_set.h
+        src/openvpn/error.c
+        src/openvpn/error.h
+        src/openvpn/event.c
+        src/openvpn/event.h
+        src/openvpn/fdmisc.c
+        src/openvpn/fdmisc.h
+        src/openvpn/forward.c
+        src/openvpn/forward.h
+        src/openvpn/fragment.c
+        src/openvpn/fragment.h
+        src/openvpn/gremlin.c
+        src/openvpn/gremlin.h
+        src/openvpn/helper.c
+        src/openvpn/helper.h
+        src/openvpn/httpdigest.c
+        src/openvpn/httpdigest.h
+        src/openvpn/init.c
+        src/openvpn/init.h
+        src/openvpn/integer.h
+        src/openvpn/interval.c
+        src/openvpn/interval.h
+        src/openvpn/list.c
+        src/openvpn/list.h
+        src/openvpn/lladdr.c
+        src/openvpn/lladdr.h
+        src/openvpn/lzo.c
+        src/openvpn/lzo.h
+        src/openvpn/manage.c
+        src/openvpn/manage.h
+        src/openvpn/mbuf.c
+        src/openvpn/mbuf.h
+        src/openvpn/memdbg.h
+        src/openvpn/misc.c
+        src/openvpn/misc.h
+        src/openvpn/mroute.c
+        src/openvpn/mroute.h
+        src/openvpn/mss.c
+        src/openvpn/mss.h
+        src/openvpn/mstats.c
+        src/openvpn/mstats.h
+        src/openvpn/mtcp.c
+        src/openvpn/mtcp.h
+        src/openvpn/mtu.c
+        src/openvpn/mtu.h
+        src/openvpn/mudp.c
+        src/openvpn/mudp.h
+        src/openvpn/multi.c
+        src/openvpn/multi.h
+        src/openvpn/ntlm.c
+        src/openvpn/ntlm.h
+        src/openvpn/occ.c
+        src/openvpn/occ.h
+        src/openvpn/openvpn.c
+        src/openvpn/openvpn.h
+        src/openvpn/options.c
+        src/openvpn/options.h
+        src/openvpn/options_util.c
+        src/openvpn/options_util.h
+        src/openvpn/otime.c
+        src/openvpn/otime.h
+        src/openvpn/ovpn_dco_win.h
+        src/openvpn/packet_id.c
+        src/openvpn/packet_id.h
+        src/openvpn/perf.c
+        src/openvpn/perf.h
+        src/openvpn/ping.c
+        src/openvpn/ping.h
+        src/openvpn/pkcs11.c
+        src/openvpn/pkcs11.h
+        src/openvpn/pkcs11_backend.h
+        src/openvpn/pkcs11_openssl.c
+        src/openvpn/pkcs11_mbedtls.c
+        src/openvpn/platform.c
+        src/openvpn/platform.h
+        src/openvpn/plugin.c
+        src/openvpn/plugin.h
+        src/openvpn/pool.c
+        src/openvpn/pool.h
+        src/openvpn/proto.c
+        src/openvpn/proto.h
+        src/openvpn/proxy.c
+        src/openvpn/proxy.h
+        src/openvpn/ps.c
+        src/openvpn/ps.h
+        src/openvpn/push.c
+        src/openvpn/push.h
+        src/openvpn/pushlist.h
+        src/openvpn/reliable.c
+        src/openvpn/reliable.h
+        src/openvpn/route.c
+        src/openvpn/route.h
+        src/openvpn/run_command.c
+        src/openvpn/run_command.h
+        src/openvpn/schedule.c
+        src/openvpn/schedule.h
+        src/openvpn/session_id.c
+        src/openvpn/session_id.h
+        src/openvpn/shaper.c
+        src/openvpn/shaper.h
+        src/openvpn/sig.c
+        src/openvpn/sig.h
+        src/openvpn/socket.c
+        src/openvpn/socket.h
+        src/openvpn/socks.c
+        src/openvpn/socks.h
+        src/openvpn/ssl.c
+        src/openvpn/ssl.h
+        src/openvpn/ssl_backend.h
+        src/openvpn/ssl_common.h
+        src/openvpn/ssl_openssl.c
+        src/openvpn/ssl_openssl.h
+        src/openvpn/ssl_mbedtls.c
+        src/openvpn/ssl_mbedtls.h
+        src/openvpn/ssl_verify.c
+        src/openvpn/ssl_verify.h
+        src/openvpn/ssl_verify_backend.h
+        src/openvpn/ssl_verify_openssl.c
+        src/openvpn/ssl_verify_openssl.h
+        src/openvpn/ssl_verify_mbedtls.c
+        src/openvpn/ssl_verify_mbedtls.h
+        src/openvpn/status.c
+        src/openvpn/status.h
+        src/openvpn/syshead.h
+        src/openvpn/tls_crypt.c
+        src/openvpn/tun.c
+        src/openvpn/tun.h
+        src/openvpn/networking_sitnl.c
+        src/openvpn/networking_freebsd.c
+        src/openvpn/auth_token.c
+        src/openvpn/auth_token.h
+        src/openvpn/ssl_ncp.c
+        src/openvpn/ssl_ncp.h
+        src/openvpn/ssl_pkt.c
+        src/openvpn/ssl_pkt.h
+        src/openvpn/ssl_util.c
+        src/openvpn/ssl_util.h
+        src/openvpn/vlan.c
+        src/openvpn/vlan.h
+        src/openvpn/win32.c
+        src/openvpn/win32-util.c
+        src/openvpn/win32.h
+        src/openvpn/win32-util.h
+        src/openvpn/xkey_helper.c
+        src/openvpn/xkey_provider.c
+        )
+
+add_executable(openvpn ${SOURCE_FILES})
+
+add_library_deps(openvpn)
+
+if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
+    target_link_libraries(openvpn PUBLIC -ldl)
+
+    find_package(PkgConfig)
+    pkg_search_module(LIBNL REQUIRED libnl-genl-3.0)
+
+    target_link_libraries(openvpn PUBLIC ${LIBNL_LIBRARIES})
+    target_include_directories(openvpn PRIVATE ${LIBNL_INCLUDE_DIRS})
+endif ()
+
+
+if (MINGW)
+    target_link_options(openvpn PRIVATE -municode)
+endif ()
+
+if (NOT WIN32)
+    find_library(resolv resolv)
+    # some platform like BSDs already include resolver functionality in th=
e libc and not have an extra resolv library
+    if (${resolv} OR APPLE)
+        target_link_libraries(openvpn PUBLIC -lresolv)
+    endif ()
+endif ()
+
+
+pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TARGET)
+enable_testing()
+
+SET(unit_tests "test_packet_id" "test_crypto" "test_ncp" "test_auth_token"=
 "test_misc" "test_buffer" "test_provider" "test_pkt")
+
+# These tests work on only on Linux since they depend on special linker fe=
atures
+if (WIN32)
+    LIST(APPEND unit_tests "test_cryptoapi")
+elseif (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
+    LIST(APPEND unit_tests "test_networking" "test_tls_crypt" "test_argv")
+endif ()
+
+
+FOREACH (test_name ${unit_tests})
+    add_executable(${test_name}
+            tests/unit_tests/openvpn/${test_name}.c
+            tests/unit_tests/openvpn/mock_msg.c
+            src/openvpn/platform.c
+            src/openvpn/crypto_mbedtls.c
+            src/openvpn/crypto_openssl.c
+            src/openvpn/crypto.c
+            src/openvpn/otime.c
+            src/openvpn/packet_id.c
+            src/openvpn/base64.c
+            src/openvpn/win32-util.c
+            src/openvpn/mtu.c
+            src/openvpn/networking_sitnl.c
+            src/compat/compat-strsep.c
+            src/compat/compat-gettimeofday.c
+            src/openvpn/ssl_util.c
+            src/openvpn/reliable.c
+            src/openvpn/session_id.c
+            src/openvpn/mss.c
+            src/openvpn/xkey_provider.c
+            )
+
+    add_library_deps(${test_name})
+    target_link_libraries(${test_name} PUBLIC PkgConfig::cmocka)
+
+    target_include_directories(${test_name} PRIVATE src/openvpn)
+
+    if (NOT ${test_name} STREQUAL "test_buffer")
+        target_sources(${test_name} PRIVATE
+                src/openvpn/buffer.c
+                )
+    endif ()
+    add_test(NAME ${test_name} COMMAND ${test_name})
+ENDFOREACH ()
+
+target_sources(test_pkt PRIVATE
+        src/openvpn/argv.c
+        src/openvpn/env_set.c
+        src/openvpn/reliable.c
+        src/openvpn/run_command.c
+        src/openvpn/session_id.c
+        src/openvpn/ssl_pkt.c
+        src/openvpn/tls_crypt.c
+        )
+
+if (TARGET test_cryptoapi)
+    target_sources(test_cryptoapi PRIVATE
+            src/openvpn/xkey_helper.c
+            src/openvpn/xkey_provider.c
+            )
+endif ()
+
+target_sources(test_provider PRIVATE
+        src/openvpn/xkey_provider.c
+        src/openvpn/xkey_helper.c
+        )
+
+target_sources(test_misc PRIVATE
+        src/openvpn/options_util.c
+        )
+
+IF (TARGET test_tls_crypt)
+    target_sources(test_tls_crypt PRIVATE
+            src/openvpn/argv.c
+            src/openvpn/env_set.c
+            src/openvpn/run_command.c)
+endif ()
+
+if (TARGET test_argv)
+    target_sources(test_argv PRIVATE
+            src/openvpn/argv.c
+            src/openvpn/env_set.c
+            src/openvpn/run_command.c)
+endif ()
+
+
+FOREACH (test_name "networking" "tls_crypt" "argv")
+    if (TARGET test_${test_name})
+        target_link_options(test_${test_name} PRIVATE -Wl,--wrap=3Dparse_l=
ine)
+    endif ()
+ENDFOREACH ()
+
+if (TARGET test_tls_crypt)
+    target_link_options("test_tls_crypt" PRIVATE
+            -Wl,--wrap=3Dbuffer_read_from_file
+            -Wl,--wrap=3Dbuffer_write_file
+            -Wl,--wrap=3Drand_bytes)
+ENDIF ()
\ No newline at end of file
diff --git a/config.h.cmake.in b/config.h.cmake.in
new file mode 100644
index 0000000..6185971
--- /dev/null
+++ b/config.h.cmake.in
@@ -0,0 +1,492 @@
+
+/* Configuration settings */
+#define CONFIGURE_DEFINES "N/A"
+
+/* Enable async push */
+#cmakedefine ENABLE_ASYNC_PUSH
+
+/* Use mbed TLS library */
+#cmakedefine ENABLE_CRYPTO_MBEDTLS
+
+/* Use Openssl */
+#cmakedefine ENABLE_CRYPTO_OPENSSL
+
+/* Use wolfSSL crypto library */
+#cmakedefine ENABLE_CRYPTO_WOLFSSL
+
+/* Enable shared data channel offload */
+#cmakedefine ENABLE_DCO
+
+/* Enable debugging support (needed for verb>=3D4) */
+#define ENABLE_DEBUG 1
+
+/* We have persist tun capability */
+#cmakedefine ENABLE_FEATURE_TUN_PERSIST
+
+/* Enable internal fragmentation support */
+#define ENABLE_FRAGMENT 1
+
+/* Enable linux data channel offload */
+#cmakedefine ENABLE_LINUXDCO
+
+/* Enable LZ4 compression library */
+#cmakedefine ENABLE_LZ4
+
+/* Enable LZO compression library */
+#cmakedefine ENABLE_LZO
+
+/* Enable management server capability */
+#define ENABLE_MANAGEMENT 1
+
+/* Enable OFB and CFB cipher modes */
+#define ENABLE_OFB_CFB_MODE
+
+/* Enable PKCS11 */
+/* #undef ENABLE_PKCS11 */
+
+/* Enable plug-in support */
+#define ENABLE_PLUGIN 1
+
+/* Enable TCP Server port sharing */
+#cmakedefine ENABLE_PORT_SHARE
+
+/* SELinux support */
+#cmakedefine ENABLE_SELINUX
+
+/* enable sitnl support */
+#cmakedefine ENABLE_SITNL
+
+/* Enable systemd integration */
+/* #undef ENABLE_SYSTEMD */
+
+/* Enable --x509-username-field feature */
+#cmakedefine ENABLE_X509ALTUSERNAME
+
+/* Compiler supports anonymous unions */
+#define HAVE_ANONYMOUS_UNION_SUPPORT
+
+/* Define to 1 if you have the <arpa/inet.h> header file. */
+#cmakedefine HAVE_ARPA_INET_H 1
+
+/* Define to 1 if you have the `basename' function. */
+#cmakedefine HAVE_BASENAME
+
+/* Define to 1 if you have the `chdir' function. */
+#cmakedefine HAVE_CHDIR
+
+/* Define to 1 if you have the `chroot' function. */
+#cmakedefine HAVE_CHROOT
+
+/* Define to 1 if you have the `chsize' function. */
+#cmakedefine HAVE_CHSIZE
+
+/* struct cmsghdr needed for extended socket error support */
+#cmakedefine HAVE_CMSGHDR
+
+/* Define to 1 if you have the `daemon' function. */
+#cmakedefine HAVE_DAEMON
+
+/* Define to 1 if you have the declaration of `SO_MARK', and to 0 if you
+don't. */
+#cmakedefine01 HAVE_DECL_SO_MARK
+
+/* Define to 1 if you have the <direct.h> header file. */
+#cmakedefine HAVE_DIRECT_H
+
+/* Define to 1 if you have the `dirname' function. */
+#cmakedefine HAVE_DIRNAME
+
+/* Define to 1 if you have the <dlfcn.h> header file. */
+#cmakedefine HAVE_DLFCN_H
+
+/* Define to 1 if you have the <dmalloc.h> header file. */
+#cmakedefine HAVE_DMALLOC_H
+
+/* Define to 1 if you have the `dup' function. */
+#cmakedefine HAVE_DUP
+
+/* Define to 1 if you have the `dup2' function. */
+#cmakedefine HAVE_DUP2
+
+/* Define to 1 if you have the `epoll_create' function. */
+#cmakedefine HAVE_EPOLL_CREATE
+
+/* Define to 1 if you have the <err.h> header file. */
+#cmakedefine HAVE_ERR_H
+
+/* Crypto library supports keying material exporter */
+#define HAVE_EXPORT_KEYING_MATERIAL 1
+
+/* Define to 1 if you have the <fcntl.h> header file. */
+#cmakedefine HAVE_FCNTL_H
+
+/* Define to 1 if you have the `fork' function. */
+#cmakedefine HAVE_FORK
+#cmakedefine HAVE_EXECVE
+
+/* Define to 1 if you have the `ftruncate' function. */
+#cmakedefine HAVE_FTRUNCATE
+
+/* Define to 1 if you have the `getgrnam' function. */
+#cmakedefine HAVE_GETGRNAM
+
+/* Define to 1 if you have the `getpeereid' function. */
+#cmakedefine HAVE_GETPEEREID
+
+/* Define to 1 if you have the `getpwnam' function. */
+#cmakedefine HAVE_GETPWNAM
+
+/* Define to 1 if you have the `getrlimit' function. */
+#undef HAVE_GETRLIMIT
+
+/* Define to 1 if you have the `getsockname' function. */
+#cmakedefine HAVE_GETSOCKNAME
+
+/* Define to 1 if you have the `gettimeofday' function. */
+#cmakedefine HAVE_GETTIMEOFDAY
+
+/* Define to 1 if you have the <grp.h> header file. */
+#cmakedefine HAVE_GRP_H
+
+/* struct in_pktinfo needed for IP_PKTINFO support */
+#cmakedefine HAVE_IN_PKTINFO
+
+/* Define to 1 if you have the <io.h> header file. */
+#cmakedefine HAVE_IO_H
+
+/* struct in_pktinfo.ipi_spec_dst needed for IP_PKTINFO support */
+#cmakedefine HAVE_IPI_SPEC_DST
+
+/* Define to 1 if you have the <libgen.h> header file. */
+#cmakedefine HAVE_LIBGEN_H
+
+/* Define to 1 if you have the <limits.h> header file. */
+#define HAVE_LIMITS_H 1
+
+/* Define to 1 if you have the <linux/if_tun.h> header file. */
+#cmakedefine HAVE_LINUX_IF_TUN_H
+
+/* Define to 1 if you have the <linux/sockios.h> header file. */
+#cmakedefine HAVE_LINUX_SOCKIOS_H
+
+/* Define to 1 if you have the <linux/types.h> header file. */
+#cmakedefine HAVE_LINUX_TYPES_H
+
+/* Define to 1 if you have the <lzoconf.h> header file. */
+#define HAVE_LZO_CONF_H
+
+/* Define to 1 if you have the <lzo1x.h> header file. */
+#define HAVE_LZO1X_H 1
+
+/* Define to 1 if you have the <lzoutil.h> header file. */
+#define HAVE_LZOUTIL_H 1
+
+/* Define to 1 if you have the `mlockall' function. */
+#cmakedefine HAVE_MLOCKALL
+
+/* struct msghdr needed for extended socket error support */
+#cmakedefine HAVE_MSGHDR
+
+/* Define to 1 if you have the <netdb.h> header file. */
+#cmakedefine HAVE_NETDB_H
+
+/* Define to 1 if you have the <netinet/in.h> header file. */
+#cmakedefine HAVE_NETINET_IN_H
+
+/* Define to 1 if you have the <netinet/in_systm.h> header file. */
+#undef HAVE_NETINET_IN_SYSTM_H
+
+/* Define to 1 if you have the <netinet/ip.h> header file. */
+#cmakedefine HAVE_NETINET_IP_H
+
+/* Define to 1 if you have the <netinet/tcp.h> header file. */
+#undef HAVE_NETINET_TCP_H
+
+/* Define to 1 if you have the <net/if.h> header file. */
+#cmakedefine HAVE_NET_IF_H
+
+/* Define to 1 if you have the <net/if_tun.h> header file. */
+#cmakedefine HAVE_NET_IF_TUN_H
+
+/* Define to 1 if you have the <net/if_utun.h> header file. */
+#cmakedefine01 HAVE_NET_IF_UTUN_H
+
+/* Define to 1 if you have the <net/tun/if_tun.h> header file. */
+#cmakedefine HAVE_NET_TUN_IF_TUN_H
+
+/* Define to 1 if you have the `nice' function. */
+#undef HAVE_NICE
+
+/* Define to 1 if you have the `openlog' function. */
+#undef HAVE_OPENLOG
+
+/* OpenSSL engine support available */
+#undef HAVE_OPENSSL_ENGINE
+
+/* Define to 1 if you have the `poll' function. */
+#undef HAVE_POLL
+
+/* Define to 1 if you have the <poll.h> header file. */
+#cmakedefine HAVE_POLL_H
+
+/* Define to 1 if you have the `putenv' function. */
+#undef HAVE_PUTENV
+
+/* Define to 1 if you have the <pwd.h> header file. */
+#cmakedefine HAVE_PWD_H
+
+/* Define to 1 if you have the `readv' function. */
+#undef HAVE_READV
+
+/* Define to 1 if you have the `recvmsg' function. */
+#cmakedefine HAVE_RECVMSG
+#cmakedefine HAVE_SENDMSG
+
+/* Define to 1 if you have the <resolv.h> header file. */
+#cmakedefine HAVE_RESOLV_H
+
+/* sa_family_t, needed to hold AF_* info */
+#cmakedefine HAVE_SA_FAMILY_T
+
+/* Define to 1 if you have the `sd_booted' function. */
+#undef HAVE_SD_BOOTED
+
+/* Define to 1 if you have the `setgid' function. */
+#cmakedefine HAVE_SETGID
+
+/* Define to 1 if you have the `setgroups' function. */
+#undef HAVE_SETGROUPS
+
+/* Define to 1 if you have the `setsid' function. */
+#undef HAVE_SETSID
+
+/* Define to 1 if you have the `setsockopt' function. */
+#define HAVE_SETSOCKOPT 1
+
+/* Define to 1 if you have the `setuid' function. */
+#cmakedefine HAVE_SETUID
+
+/* Define to 1 if you have the <signal.h> header file. */
+#undef HAVE_SIGNAL_H
+
+/* Define to 1 if you have the `socket' function. */
+#undef HAVE_SOCKET
+
+/* struct sock_extended_err needed for extended socket error support */
+#undef HAVE_SOCK_EXTENDED_ERR
+
+/* Define to 1 if you have the `stat' function. */
+#define HAVE_STAT 1
+
+/* Define to 1 if you have the <stdarg.h> header file. */
+#define HAVE_STDARG_H 1
+
+/* Define to 1 if you have the <stdint.h> header file. */
+#define HAVE_STDINT_H 1
+
+/* Define to 1 if you have the <stdio.h> header file. */
+#define HAVE_STDIO_H 1
+
+/* Define to 1 if you have the <stdlib.h> header file. */
+#define HAVE_STDLIB_H 1
+
+/* Define to 1 if you have the `strdup' function. */
+#undef HAVE_STRDUP
+
+/* Define to 1 if you have the <strings.h> header file. */
+#define HAVE_STRINGS_H 1
+
+/* Define to 1 if you have the <string.h> header file. */
+#define HAVE_STRING_H 1
+
+/* Define to 1 if you have the `strsep' function. */
+#undef HAVE_STRSEP
+
+/* Define to 1 if you have the `syslog' function. */
+#undef HAVE_SYSLOG
+
+/* Define to 1 if you have the <syslog.h> header file. */
+#cmakedefine HAVE_SYSLOG_H
+
+/* Define to 1 if you have the `system' function. */
+#undef HAVE_SYSTEM
+
+/* Define to 1 if you have the <systemd/sd-daemon.h> header file. */
+#undef HAVE_SYSTEMD_SD_DAEMON_H
+
+/* Define to 1 if you have the <sys/epoll.h> header file. */
+#cmakedefine HAVE_SYS_EPOLL_H
+
+/* Define to 1 if you have the <sys/file.h> header file. */
+#undef HAVE_SYS_FILE_H
+
+/* Define to 1 if you have the <sys/inotify.h> header file. */
+#cmakedefine HAVE_SYS_INOTIFY_H
+
+/* Define to 1 if you have the <sys/ioctl.h> header file. */
+#cmakedefine HAVE_SYS_IOCTL_H
+
+/* Define to 1 if you have the <sys/kern_control.h> header file. */
+#undef HAVE_SYS_KERN_CONTROL_H
+
+/* Define to 1 if you have the <sys/mman.h> header file. */
+#cmakedefine HAVE_SYS_MMAN_H
+
+/* Define to 1 if you have the <sys/socket.h> header file. */
+#cmakedefine HAVE_SYS_SOCKET_H
+
+/* Define to 1 if you have the <sys/sockio.h> header file. */
+#undef HAVE_SYS_SOCKIO_H
+
+/* Define to 1 if you have the <sys/stat.h> header file. */
+#define HAVE_SYS_STAT_H 1
+
+/* Define to 1 if you have the <sys/time.h> header file. */
+#cmakedefine HAVE_SYS_TIME_H
+
+/* Define to 1 if you have the <sys/types.h> header file. */
+#undef HAVE_SYS_TYPES_H
+
+/* Define to 1 if you have the <sys/uio.h> header file. */
+#cmakedefine HAVE_SYS_UIO_H
+
+/* Define to 1 if you have the <sys/un.h> header file. */
+#cmakedefine HAVE_SYS_UN_H
+
+/* Define to 1 if you have the <sys/wait.h> header file. */
+#cmakedefine HAVE_SYS_WAIT_H
+
+/* Define to 1 if you have the <tap-windows.h> header file. */
+#undef HAVE_TAP_WINDOWS_H
+
+/* Define to 1 if you have the `time' function. */
+#define HAVE_TIME 1
+
+/* Define to 1 if you have the <time.h> header file. */
+#define HAVE_TIME_H 1
+
+/* Define to 1 if you have the <uapi.h> header file. */
+#undef HAVE_UAPI_H
+
+/* Define to 1 if you have the <unistd.h> header file. */
+#cmakedefine HAVE_UNISTD_H
+
+/* Define to 1 if you have the <valgrind/memcheck.h> header file. */
+#undef HAVE_VALGRIND_MEMCHECK_H
+
+/* Define to 1 if you have the <versionhelpers.h> header file. */
+#undef HAVE_VERSIONHELPERS_H
+
+/* Define to 1 if you have the `vfork' function. */
+#undef HAVE_VFORK
+
+/* Define to 1 if you have the <vfork.h> header file. */
+#undef HAVE_VFORK_H
+
+/* Define to 1 if you have the `vsnprintf' function. */
+#undef HAVE_VSNPRINTF
+
+/* we always assume a recent mbed TLS version */
+#define HAVE_CTR_DRBG_UPDATE_RET 1
+
+/* Path to ifconfig tool */
+#define IFCONFIG_PATH "@IFCONFIG_PATH@"
+
+/* Path to iproute tool */
+#define IPROUTE_PATH "@IPROUTE_PATH@"
+
+/* Path to route tool */
+#define ROUTE_PATH "@ROUTE_PATH@"
+
+/* OpenVPN major version - integer */
+#undef OPENVPN_VERSION_MAJOR
+
+/* OpenVPN minor version - integer */
+#undef OPENVPN_VERSION_MINOR
+
+/* OpenVPN patch level - may be a string or integer */
+#define OPENVPN_VERSION_PATCH "@OPENVPN_VERSION_PATCH@"
+
+/* Name of package */
+#define PACKAGE "openvpn"
+
+/* Define to the address where bug reports for this package should be sent=
. */
+#undef PACKAGE_BUGREPORT
+
+/* Define to the full name of this package. */
+#define PACKAGE_NAME "OpenVPN"
+
+/* Define to the full name and version of this package. */
+#define PACKAGE_STRING "OpenVPN @OPENVPN_VERSION_MAJOR@...220...@OPENVPN_V=
ERSION_MINOR@@OPENVPN_VERSION_PATCH@"
+
+/* Define to the version of this package. */
+#define PACKAGE_VERSION "@OPENVPN_VERSION_MAJOR@...220...@OPENVPN_VERSION_=
MINOR@@OPENVPN_VERSION_PATCH@"
+
+/* OpenVPN major version - integer */
+#define OPENVPN_VERSION_MAJOR @OPENVPN_VERSION_MAJOR@
+
+/* OpenVPN minor version - integer */
+#define OPENVPN_VERSION_MINOR @OPENVPN_VERSION_MINOR@
+
+/* Path to systemd-ask-password tool */
+#undef SYSTEMD_ASK_PASSWORD_PATH
+
+/* systemd is newer than v216 */
+#define SYSTEMD_NEWER_THAN_216
+
+/* The tap-windows id */
+#define TAP_WIN_COMPONENT_ID "tap0901"
+
+/* The tap-windows version number is required for OpenVPN */
+#define TAP_WIN_MIN_MAJOR 9
+
+/* The tap-windows version number is required for OpenVPN */
+#define TAP_WIN_MIN_MINOR 9
+
+/* Are we running on Mac OS X? */
+#cmakedefine TARGET_DARWIN
+
+/* Are we running on FreeBSD? */
+#cmakedefine TARGET_FREEBSD
+
+/* Are we running on Linux? */
+#cmakedefine TARGET_LINUX
+
+/* Are we running WIN32? */
+#cmakedefine TARGET_WIN32
+
+#define TARGET_ALIAS "@CMAKE_SYSTEM_NAME@"
+
+/* Enable GNU extensions on systems that have them.  */
+#ifndef _GNU_SOURCE
+# define _GNU_SOURCE 1
+#endif
+
+
+#if defined(_WIN32)
+#include <inttypes.h>
+typedef uint32_t in_addr_t;
+typedef uint16_t in_port_t;
+
+#define SIGHUP    1
+#define SIGINT    2
+#define SIGUSR1   10
+#define SIGUSR2   12
+#define SIGTERM   15
+#endif
+
+#if defined(_MSC_VER)
+#include <BaseTsd.h>
+typedef SSIZE_T ssize_t;
+#define strncasecmp strnicmp
+#define strcasecmp _stricmp
+
+
+#define S_IRUSR 0
+#define S_IWUSR 0
+#define R_OK 4
+#define W_OK 2
+#define X_OK 1
+#define F_OK 0
+#endif
+
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index c572354..f05c002 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -37,7 +37,14 @@
  * @addtogroup compression
  * @{
  */
-
+#if defined(HAVE_LZO_CONF_H)
+/* The lzo.h magic gets confused and still wants
+ * to include lzo/lzoconf.h even if our include paths
+ * are setup to include the paths without lzo/ include lzoconf.h to
+ * avoid it being include by lzoutil.h */
+#include <lzodefs.h>
+#include <lzoconf.h>
+#endif
 #if defined(HAVE_LZO_LZOUTIL_H)
 #include <lzo/lzoutil.h>
 #elif defined(HAVE_LZOUTIL_H)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/322?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I666314a223d324ca72dbe7ba7d22f764996d3ca2
Gerrit-Change-Number: 322
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--CK9831YH5ZI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa has uploaded this change for <strong>review</strong>.</p><p><a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/322?usp=3Demail">View Change</a>=
</p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>add basic CMake based build<br><br>This helps with IDE integration among o=
ther things.<br><br>This is a basic implementation for development purposes=
<br>that can&#39;t replace any of the existing release builds.<br><br>Chang=
e-Id: I666314a223d324ca72dbe7ba7d22f764996d3ca2<br>Signed-off-by: Arne Schw=
abe &lt;arne@...1227...&gt;<br>Signed-off-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>---<br>A CMakeLists.txt<br>A config.h.cmake.in<br>M src/op=
envpn/lzo.h<br>3 files changed, 1,091 insertions(+), 1 deletion(-)<br><br><=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/322/1</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>new file =
mode 100644</span><br><span>index 0000000..9978ea4</span><br><span>--- /dev=
/null</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -0,0 +1,591 @=
@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  cmake_minimum_re=
quired(VERSION 3.3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
project(openvpn)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# This CMake file impl=
ements building OpenVPN with CMAKE</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# N=
ote that this is *NOT* the official way to build openvpn on anything</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# other than Windows/mingw=
 despite working on other platforms too. You will need</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# to add -DUNSUPPORTED_BUILDS=3Dtrue to =
build on non Windows platforms.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# This=
 cmake also makes a few assertions like lzo, lz4 being used</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# and OpenSSL having version 1.1.1+=
 and generally does not offer the same</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# configurability like autoconf</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# -DCMAKE_TOOLCHAIN_FILE=3DC:/Users/User/source/repos/vcpkg/scr=
ipts/buildsystems/vcpkg.cmake</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#-DVCPKG_OVERLAY_PORTS=3DC:/Users/User/source/repos/openvpn/contr=
ib/vcpkg-ports</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#-GNi=
nja</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+option(UNSUPPORTED_BUILDS &quot;All=
ow unsupported builds&quot; OFF)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (NO=
T WIN32 AND NOT ${UNSUPPORTED_BUILDS})</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    message(FATAL_ERROR &quot;Note: on Unix platform the=
 official and supported build method is using autoconfig. CMake based build=
 should be only used for Windows and internal testing/development.&quot;)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif()</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+option(MBED &quot;BUILD with mbed&quot; OFF)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+option(WOLFSSL &quot;BUILD =
with wolfSSL&quot; OFF)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+if (MSVC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    op=
tion(USE_WERROR &quot;Treat compiler warnings as errors (-Werror)&quot; OFF=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+else ()</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    option(USE_WERROR &quot;Tr=
eat compiler warnings as errors (-Werror)&quot; ON)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+endif ()</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+option(PLUGIN_DIR &quot;Location of the plugin direc=
tory&quot; /usr/local/lib/openvpn/plugins)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# AddressSanitize - use CXX=3Dclang++ CC=3Dclang cmake -DCMAKE_BUILD_TY=
PE=3Dasan to build with ASAN</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+set(CMAKE_C_FLAGS_ASAN</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        &quot;-fsanitize=3Daddress,undefined -fno-sanitize-reco=
ver=3Dall -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -f=
no-omit-frame-pointer -g -O1&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        CACHE STRING &quot;Flags used by the C compiler duri=
ng AddressSanitizer builds.&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        FORCE)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+set(CMAKE_CXX_FLAGS_ASAN</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        &quot;-fsanitize=3Daddress,undefined -fno-sanitize-re=
cover=3Dall -fno-optimize-sibling-calls -fsanitize-address-use-after-scope =
-fno-omit-frame-pointer -g -O1&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        CACHE STRING &quot;Flags used by the C++ compiler =
during AddressSanitizer builds.&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        FORCE)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (MS=
VC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    target_compi=
le_options(${target} PRIVATE /W3)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+else ()</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    add_compile_options(-Wall -Wuninitialized)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    # We are not ready for this</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    #add_compile_options(-Wsign-co=
mpare)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif ()</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+find_package(PkgConfig)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+INCLUDE(CheckSymbolExists)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+INCLUDE(CheckIncludeFiles)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+INCLUDE(CheckTypeSize)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+INCLUDE(CheckStructH=
asMember)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+set(OPENVPN_VERSION_MAJOR 2)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(OPENVPN_VERSION_=
MINOR 6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(OPENVPN=
_VERSION_PATCH _git)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (NOT WIN32)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_definitions(-DP=
LUGIN_LIBDIR=3D\&quot;${PLUGIN_DIR}\&quot;)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+endif ()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# TODO=
 remove later when msvc-config.h is removed and we can always include confi=
g.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_definitions(=
-DHAVE_CONFIG_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# Set the various defines for config.h.cm=
ake.in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (${CMAKE_S=
YSTEM_NAME} STREQUAL &quot;Linux&quot;)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    set(TARGET_LINUX YES)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    set(ENABLE_ASYNC_PUSH YES)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    set(ENABLE_LINUXDCO YES)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    set(ENABLE_SITNL YES)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(HAVE_DECL_SO_MA=
RK YES)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(ENAB=
LE_FEATURE_TUN_PERSIST 1)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    set(HAVE_LINUX_TYPES_H 1)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    set(ENABLE_DCO YES)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    set(HAVE_CMSGHDR YES)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+elseif (${CMAKE_SYSTEM_NAME} STREQUAL &quot;FreeB=
SD&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(TA=
RGET_FREEBSD YES)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  set(ENABLE_DCO YES)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    link_libraries(-lnv)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+elseif (WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    set(ENABLE_DCO YES)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+elseif (APPLE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    set(TARGET_DARWIN YES)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    set(HAVE_NET_IF_UTUN_H YES)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+endif ()</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (UNIX)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(PATH_SEPARAT=
OR /)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(ENABLE=
_PORT_SHARE YES)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 set(HAVE_SA_FAMILY_T YES)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+elseif (WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    set(PATH_SEPARATOR \\\\)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    set(TARGET_WIN32 YES)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+endif ()</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_SYMBOL_=
EXISTS(chroot unistd.h HAVE_CHROOT)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+CHECK_SYMBOL_EXISTS(chdir unistd.h HAVE_CHDIR)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+CHECK_SYMBOL_EXISTS(dup unistd.h=
 HAVE_DUP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_SYM=
BOL_EXISTS(dup2 unistd.h HAVE_DUP2)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+CHECK_SYMBOL_EXISTS(fork unistd.h HAVE_FORK)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+CHECK_SYMBOL_EXISTS(execve unistd.=
h HAVE_EXECVE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK=
_SYMBOL_EXISTS(ftruncate unistd.h HAVE_FTRUNCATE)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+CHECK_SYMBOL_EXISTS(setgid unistd.h HAVE_SETG=
ID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_SYMBOL_EXI=
STS(setuid unistd.h HAVE_SETUID)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+CHECK_SYMBOL_EXISTS(getpeereid unistd.h HAVE_GETPEEREID)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+CHECK_SYMBOL_EXISTS(epoll_create sys/epoll.h=
 HAVE_EPOLL_CREATE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_SYMBOL_EXISTS=
(gettimeofday sys/time.h HAVE_GETTIMEOFDAY)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+CHECK_SYMBOL_EXISTS(basename libgen.h HAVE_BASENAME=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_SYMBOL_EXIST=
S(chsize io.h HAVE_CHSIZE)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+CHECK_SYMBOL_EXISTS(daemon stdlib.h HAVE_DAEMON)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+CHECK_SYMBOL_EXISTS(dirname libgen.h HA=
VE_DIRNAME)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_SY=
MBOL_EXISTS(getrlimit sys/resource.h HAVE_GETRLIMIT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+CHECK_SYMBOL_EXISTS(mlockall sys/mman.h H=
AVE_MLOCKALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_SYMBOL_EXISTS(sendm=
sg sys/socket.h HAVE_SENDMSG)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+CHECK_SYMBOL_EXISTS(recvmsg sys/socket.h HAVE_RECVMSG)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+CHECK_SYMBOL_EXISTS(cmsghdr sy=
s/socket.h HAVE_CMSGHDR)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+CHECK_SYMBOL_EXISTS(openlog syslog.h HAVE_OPENLOG)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+CHECK_SYMBOL_EXISTS(syslog syslog.h HAV=
E_SYSLOG)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_SYMB=
OL_EXISTS(getgrnam grp.h HAVE_GETGRNAM)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+CHECK_SYMBOL_EXISTS(getpwnam pwd.h HAVE_GETPWNAM)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_SYMBOL_EXISTS(getso=
ckname sys/socket.h HAVE_GETSOCKNAME)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 Some OS (e.g. FreeBSD) need some basic headers to allow</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# including network headers</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+SET(NETEXTRA sys/types.h)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLUDE_FILES(&quo=
t;${NETEXTRA};netinet/in.h&quot; HAVE_NETINET_IN_H)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+if (HAVE_NETINET_IN_H)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    LIST(APPEND NETEXTRA netinet/in.h)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+endif ()</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+CHECK_INCLUDE_FILES(&quot;${NETEXTRA};netinet/in6.h&quot; HAVE_NETIN=
ET_IN_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLU=
DE_FILES(linux/if_tun.h HAVE_LINUX_IF_TUN_H)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+CHECK_INCLUDE_FILES(linux/sockios.h HAVE_LINUX_SOC=
KIOS_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLUD=
E_FILES(dlfcn.h HAVE_DLFCN_H)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+CHECK_INCLUDE_FILES(fcntl.h HAVE_FCNTL_H)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLUDE_FILES(dmalloc.h HAVE_DMALLO=
C_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLUDE_F=
ILES(err.h HAVE_ERR_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+CHECK_INCLUDE_FILES(sys/epoll.h HAVE_SYS_EPOLL_H)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLUDE_FILES(poll.h HAVE_POLL_H)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLUDE_FILES(s=
ys/socket.h HAVE_SYS_SOCKET_H)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+CHECK_INCLUDE_FILES(sys/time.h HAVE_SYS_TIME_H)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLUDE_FILES(netdb.h HAVE_NET=
DB_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLUDE_=
FILES(unistd.h HAVE_UNISTD_H)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+CHECK_INCLUDE_FILES(sys/un.h HAVE_SYS_UN_H)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLUDE_FILES(libgen.h HAVE_LIBGEN_=
H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLUDE_FIL=
ES(net/if.h HAVE_NET_IF_H)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+CHECK_INCLUDE_FILES(&quot;${NETEXTRA};netinet/ip.h&quot; HAVE_NETINE=
T_IP_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLUD=
E_FILES(arpa/inet.h HAVE_ARPA_INET_H)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+CHECK_INCLUDE_FILES(net/if_utun.h HAVE_NET_UTUN_H)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLUDE_FILES(sys/io=
ctl.h HAVE_SYS_IOCTL_H)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+CHECK_INCLUDE_FILES(sys/inotify.h HAVE_SYS_INOTIFY_H)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLUDE_FILES(&quot;${NETEXTRA}=
;sys/uio.h&quot; HAVE_SYS_UIO_H)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+CHECK_INCLUDE_FILES(syslog.h HAVE_SYSLOG_H)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLUDE_FILES(sys/wait.h HAVE_SY=
S_WAIT_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_INCL=
UDE_FILES(grp.h HAVE_GRP_H)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+CHECK_INCLUDE_FILES(pwd.h HAVE_PWD_H)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+CHECK_INCLUDE_FILES(sys/mman.h HAVE_SYS_MMAN_H)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+CHECK_INCLUDE_FILES(&quot;${NETEXTRA};resolv.h&quot; HAVE_R=
ESOLV_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLU=
DE_FILES(&quot;${NETEXTRA};net/if_tun.h&quot; HAVE_NET_IF_TUN_H)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# Is this obscure header needed anywhere?!</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_INCLUDE_FILES(netine=
t/in_systm.h HAVE_NETINET_IN_SYSTM_H)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+SET(CMAKE_EXTRA_INCL=
UDE_FILES netinet/ip.h)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+CHECK_TYPE_SIZE(&quot;struct in_pktinfo&quot; IN_PKTINFO)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+CHECK_STRUCT_HAS_MEMBER(&quot;str=
uct in_pktinfo&quot; ipi_spec_dst netinet/ip.h HAVE_IPI_SPEC_DST)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+CHECK_TYPE_SIZE(&quot;struct =
msghdr&quot; MSGHDR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+SET(CMAKE_EXTRA_INCLUDE_FILES)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+find_pr=
ogram(IFCONFIG_PATH ifconfig)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+find_program(IPROUTE_PATH ip)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+find_program(ROUTE_PATH route)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (NOT=
 WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(ENAB=
LE_LZ4 YES)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(=
ENABLE_LZO YES)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endi=
f ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+function(add_library_deps target)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (${MBED})</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        target_include_=
directories(${target} PRIVATE $ENV{HOME}/oss/mbedtls2/include)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        message(&quot;Building $=
{target} for mbed TLS&quot;)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        target_link_libraries(${target} PUBLIC -L$ENV{HOME}/oss/mb=
edtls2/library -L/usr/local/opt/lzo/lib -lmbedtls -lmbedx509 -lmbedcrypto)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    elseif (${WOLFSS=
L})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pkg_sear=
ch_module(wolfssl wolfssl REQUIRED)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        target_link_libraries(${target} PUBLIC ${wolfssl_LI=
NK_LIBRARIES})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   target_include_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIRS}/wol=
fssl)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        messag=
e(&quot;Building ${target} for WolfSSL: ${wolfssl_LINK_LIBRARIES} ${wolfssl=
_INCLUDE_DIRS}/wolfsll&quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else ()</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        set(ENABLE_X509ALTUSERNAME YES)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        find_package(OpenSSL REQUIRED)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        target_link_libraries(${target} PUBLIC OpenSS=
L::SSL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        message(&quot;Building =
${target} for default OpenSSL&quot;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    endif ()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (${ENABLE_LZ4})</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        pkg_search_module=
(liblz4 liblz4 REQUIRED IMPORTED_TARGET)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        target_link_libraries(${target} PUBLIC PkgConf=
ig::liblz4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    endi=
f ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (${ENABLE_LZO})</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        pkg_search_module(lzo2 =
lzo2 REQUIRED IMPORTED_TARGET)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        target_link_libraries(${target} PUBLIC PkgConfig::lzo2)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    endif ()</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (${CMAKE_SYSTEM_NAME} STREQUAL &quot;Li=
nux&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t=
arget_include_directories(${target} PUBLIC ${LIBNL_INCLUDE_DIRS})</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        target_link_libraries=
(${target} PUBLIC ${LIBNL_LIBRARIES})</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    endif ()</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
USE_WERROR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (MSVC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  target_compile_options(${target} PRIVATE /WX)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        else ()</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            target_compile_options(${target} PRIVAT=
E -Werror)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
ndif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    endif ()=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endfunction()</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+if (${MBED})</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    set(ENABLE_CRYPTO_MBEDTLS YES)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+elseif (${WOLFSSL})</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    set(ENABLE_CRYPTO_OPENSSL YES)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(ENABLE_CRYPTO=
_WOLFSSL YES)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    se=
t(ENABLE_X509ALTUSERNAME YES)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+else ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  set(ENABLE_CRYPTO_OPENSSL YES)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    set(ENABLE_X509ALTUSERNAME YES)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+endif ()</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
nclude_directories(${CMAKE_CURRENT_SOURCE_DIR} src/compat include)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+if (WIN32)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    find_package(OpenSSL REQUIRED)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    link_libraries(OpenSSL::SSL OpenSSL::Crypto ws2_32.lib C=
rypt32.lib fwpuclnt.lib iphlpapi.lib</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            wininet.lib setupapi.lib rpcrt4.lib wtsapi32.l=
ib Ncrypt.lib)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
dd_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE -D _WI=
NSOCK_DEPRECATED_NO_WARNINGS -D_CONSOLE)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+endif ()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+configure=
_file(config.h.cmake.in config.h)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+configure_file(include/openvpn-plugin.h.in openvpn-plugin.h)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+include_directories(${CMAKE_CURRENT_BIN=
ARY_DIR})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+set(SOURCE_FILES</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        ${CMAKE_CURRENT_BINARY_D=
IR}/config.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 ${CMAKE_CURRENT_BINARY_DIR}/openvpn-plugin.h</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        src/compat/compat-basename.c</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        src/compat/compat-daemon.c</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        src/compat/compat-dirname.c<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/compat/c=
ompat-gettimeofday.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        src/compat/compat-strsep.c</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        src/compat/compat-versionhelpers.h</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/argv.c</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/argv.h</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/ba=
se64.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/o=
penvpn/base64.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    src/openvpn/basic.h</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        src/openvpn/block_dns.h</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        src/openvpn/block_dns.c</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        src/openvpn/buffer.c</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/buffer.h</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/circ_list=
.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openv=
pn/clinat.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
src/openvpn/clinat.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        src/openvpn/common.h</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        src/openvpn/comp-lz4.c</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        src/openvpn/comp-lz4.h</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/comp.c</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/comp.h</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/compstu=
b.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/open=
vpn/console.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  src/openvpn/console_builtin.c</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        src/openvpn/console.h</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        src/openvpn/crypto.c</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        src/openvpn/crypto.h</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/crypto_backend.=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvp=
n/crypto_openssl.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       src/openvpn/crypto_openssl.h</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        src/openvpn/crypto_mbedtls.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/crypto_mbedtls.h</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/cryp=
toapi.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/=
openvpn/cryptoapi.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        src/openvpn/dco.c</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        src/openvpn/dco.h</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        src/openvpn/dco_win.c</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        src/openvpn/dco_win.h</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/dco_linux.c</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/dco_linux=
.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openv=
pn/dco_freebsd.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     src/openvpn/dco_freebsd.h</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        src/openvpn/dhcp.c</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        src/openvpn/dhcp.h</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        src/openvpn/dns.c</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        src/openvpn/dns.h</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/errlevel.h</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/env_set=
.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openv=
pn/env_set.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 src/openvpn/error.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        src/openvpn/error.h</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        src/openvpn/event.c</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        src/openvpn/event.h</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        src/openvpn/fdmisc.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/fdmisc.h</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/forward.c</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/fo=
rward.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/=
openvpn/fragment.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       src/openvpn/fragment.h</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        src/openvpn/gremlin.c</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        src/openvpn/gremlin.h</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        src/openvpn/helper.c</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/helper.h</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/httpdig=
est.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/op=
envpn/httpdigest.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       src/openvpn/init.c</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        src/openvpn/init.h</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        src/openvpn/integer.h</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        src/openvpn/interval.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/interval.h</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/list.c</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/lis=
t.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/open=
vpn/lladdr.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 src/openvpn/lladdr.h</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        src/openvpn/lzo.c</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        src/openvpn/lzo.h</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        src/openvpn/manage.c</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        src/openvpn/manage.h</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/mbuf.c</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/mbuf.h</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/memdbg.=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvp=
n/misc.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src=
/openvpn/misc.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    src/openvpn/mroute.c</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        src/openvpn/mroute.h</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        src/openvpn/mss.c</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        src/openvpn/mss.h</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        src/openvpn/mstats.c</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/mstats.h</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/mtcp.c</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/mtcp=
.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openv=
pn/mtu.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src=
/openvpn/mtu.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   src/openvpn/mudp.c</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        src/openvpn/mudp.h</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        src/openvpn/multi.c</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        src/openvpn/multi.h</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        src/openvpn/ntlm.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/ntlm.h</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/occ.c</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/occ.h</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/op=
envpn.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/=
openvpn/openvpn.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      src/openvpn/options.c</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        src/openvpn/options.h</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        src/openvpn/options_util.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/options_util.h</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/otime.=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvp=
n/otime.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sr=
c/openvpn/ovpn_dco_win.h</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        src/openvpn/packet_id.c</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        src/openvpn/packet_id.h</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        src/openvpn/perf.c</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/perf.h</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/ping.c</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/ping.=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvp=
n/pkcs11.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
rc/openvpn/pkcs11.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        src/openvpn/pkcs11_backend.h</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        src/openvpn/pkcs11_openssl.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/pkcs11_mbedtls.c</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/plat=
form.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/o=
penvpn/platform.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      src/openvpn/plugin.c</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        src/openvpn/plugin.h</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        src/openvpn/pool.c</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        src/openvpn/pool.h</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        src/openvpn/proto.c</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/proto.h</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/proxy.c</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/p=
roxy.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/o=
penvpn/ps.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
src/openvpn/ps.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     src/openvpn/push.c</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        src/openvpn/push.h</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        src/openvpn/pushlist.h</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        src/openvpn/reliable.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/reliable.h</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/route.c</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/ro=
ute.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/op=
envpn/run_command.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        src/openvpn/run_command.h</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        src/openvpn/schedule.c</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        src/openvpn/schedule.h</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/session_id.c</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/sessio=
n_id.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/o=
penvpn/shaper.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    src/openvpn/shaper.h</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        src/openvpn/sig.c</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        src/openvpn/sig.h</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        src/openvpn/socket.c</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        src/openvpn/socket.h</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/socks.c</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/socks.h</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/ssl.=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvp=
n/ssl.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/=
openvpn/ssl_backend.h</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        src/openvpn/ssl_common.h</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        src/openvpn/ssl_openssl.c</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        src/openvpn/ssl_openssl.h</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/ssl_mbedtls.=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvp=
n/ssl_mbedtls.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    src/openvpn/ssl_verify.c</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        src/openvpn/ssl_verify.h</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        src/openvpn/ssl_verify_backend.h</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/ssl_verify_o=
penssl.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src=
/openvpn/ssl_verify_openssl.h</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        src/openvpn/ssl_verify_mbedtls.c</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        src/openvpn/ssl_verify_mbedtls.h</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/sta=
tus.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/op=
envpn/status.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   src/openvpn/syshead.h</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        src/openvpn/tls_crypt.c</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        src/openvpn/tun.c</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        src/openvpn/tun.h</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        src/openvpn/networking_sitnl.c</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/network=
ing_freebsd.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  src/openvpn/auth_token.c</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        src/openvpn/auth_token.h</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        src/openvpn/ssl_ncp.c</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        src/openvpn/ssl_ncp.h</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/ssl_pkt.c</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/ssl_p=
kt.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/ope=
nvpn/ssl_util.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    src/openvpn/ssl_util.h</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        src/openvpn/vlan.c</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        src/openvpn/vlan.h</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        src/openvpn/win32.c</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        src/openvpn/win32-util.c</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/win32.h</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/win32=
-util.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/=
openvpn/xkey_helper.c</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        src/openvpn/xkey_provider.c</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        )</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_executa=
ble(openvpn ${SOURCE_FILES})</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_librar=
y_deps(openvpn)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+if (${CMAKE_SYSTEM_NAME=
} STREQUAL &quot;Linux&quot;)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    target_link_libraries(openvpn PUBLIC -ldl)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    find_package(PkgConfig)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    pkg_search_module(LIBNL REQUIRED libnl-genl-3=
.0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    target_link_libraries(openvpn P=
UBLIC ${LIBNL_LIBRARIES})</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    target_include_directories(openvpn PRIVATE ${LIBNL_INCLUDE_DIRS})=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif ()</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+if (MINGW)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  target_link_options(openvpn PRIVATE -municode)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+endif ()</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
f (NOT WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi=
nd_library(resolv resolv)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    # some platform like BSDs already include resolver functionality =
in the libc and not have an extra resolv library</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (${resolv} OR APPLE)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        target_link_libraries(openvpn =
PUBLIC -lresolv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif ()</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TARGET)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+enable_testing()</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+SET(unit_tests &quot;test_packet_id&quot;=
 &quot;test_crypto&quot; &quot;test_ncp&quot; &quot;test_auth_token&quot; &=
quot;test_misc&quot; &quot;test_buffer&quot; &quot;test_provider&quot; &quo=
t;test_pkt&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# These tests work on=
 only on Linux since they depend on special linker features</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+if (WIN32)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    LIST(APPEND unit_tests &quot;test_crypto=
api&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+elseif ($=
{CMAKE_SYSTEM_NAME} STREQUAL &quot;Linux&quot;)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    LIST(APPEND unit_tests &quot;test_networkin=
g&quot; &quot;test_tls_crypt&quot; &quot;test_argv&quot;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+endif ()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+FOREACH (te=
st_name ${unit_tests})</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    add_executable(${test_name}</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            tests/unit_tests/openvpn/${test_name}.c</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests=
/openvpn/mock_msg.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            src/openvpn/platform.c</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            src/openvpn/crypto_mbedtls.c</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/crypto_openssl.=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/op=
envpn/crypto.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       src/openvpn/otime.c</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            src/openvpn/packet_id.c</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            src/openvpn/base64.c</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/win32-util.c</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvp=
n/mtu.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
src/openvpn/networking_sitnl.c</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            src/compat/compat-strsep.c</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            src/compat/compat-gettimeofday.c<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/open=
vpn/ssl_util.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       src/openvpn/reliable.c</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            src/openvpn/session_id.c</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            src/openvpn/mss.c</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/xkey_provider.=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            )</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    add_library_deps(${test_name})</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    target_link_libraries(=
${test_name} PUBLIC PkgConfig::cmocka)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    target_include_directories(${test_name} PRIVATE src/openvpn)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (NOT ${test_name} STREQUAL &quot;test_buff=
er&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ta=
rget_sources(${test_name} PRIVATE</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                src/openvpn/buffer.c</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                )</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    endif ()</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    add_test(NAME ${test_name} COMMAND ${test_name})<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ENDFOREACH ()</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+target_sources(test_pkt PRIVATE</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/argv.c</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/env_se=
t.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/open=
vpn/reliable.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   src/openvpn/run_command.c</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        src/openvpn/session_id.c</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        src/openvpn/ssl_pkt.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/tls_crypt.c</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+if (TARGET test_cryptoapi)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    target_sources(test_cryptoapi PRIVATE</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/xkey_=
helper.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 src/openvpn/xkey_provider.c</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            )</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+target_sources(test_provide=
r PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sr=
c/openvpn/xkey_provider.c</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        src/openvpn/xkey_helper.c</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        )</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+target_so=
urces(test_misc PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        src/openvpn/options_util.c</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        )</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+IF (TARGET=
 test_tls_crypt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 target_sources(test_tls_crypt PRIVATE</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            src/openvpn/argv.c</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            src/openvpn/env_set.c</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/run_com=
mand.c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif ()</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+if (TARGET test_argv)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    target_sources(test_argv PRIVATE</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvp=
n/argv.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 src/openvpn/env_set.c</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            src/openvpn/run_command.c)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+endif ()</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+FOREACH (test_name &quot;ne=
tworking&quot; &quot;tls_crypt&quot; &quot;argv&quot;)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (TARGET test_${test_name})</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        target_link_option=
s(test_${test_name} PRIVATE -Wl,--wrap=3Dparse_line)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    endif ()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ENDFOREACH ()</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+if (TARGET test_tls_crypt)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    target_link_options(&quot;test_tls_crypt&quot; PRIVATE</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            -Wl,--wrap=3Dbu=
ffer_read_from_file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            -Wl,--wrap=3Dbuffer_write_file</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            -Wl,--wrap=3Drand_bytes)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ENDIF ()</span><br><span>\ No newli=
ne at end of file</span><br><span>diff --git a/config.h.cmake.in b/config.h=
.cmake.in</span><br><span>new file mode 100644</span><br><span>index 000000=
0..6185971</span><br><span>--- /dev/null</span><br><span>+++ b/config.h.cma=
ke.in</span><br><span>@@ -0,0 +1,492 @@</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* Configuration settings */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define CONFIGURE_DEFINES &quot;N/A&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Enable async push */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#cmakedefine ENABLE_ASYNC_PUSH</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Use mbed TLS library */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#cmakedefine ENABLE_CRYPTO_MBEDTLS</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Use Openssl */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#cmakedefine ENABLE_CRYPTO_OPENSSL</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Use wolfSSL crypto library */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#cmakedefine ENABLE_CRYPTO_WOLFSSL</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Enable shared data channel offload */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine ENABLE_DCO</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* Enable debugging support (needed for verb&gt;=3D=
4) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ENABLE=
_DEBUG 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* We have persist tun capabil=
ity */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine =
ENABLE_FEATURE_TUN_PERSIST</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Enable in=
ternal fragmentation support */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define ENABLE_FRAGMENT 1</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* Enable linux data channel offload */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#cmakedefine ENABLE_LINUXDCO</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Enable LZ4 compression library */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#cmakedefine ENABLE_LZ4</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Enable LZO compression library */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#cmakedefine ENABLE_LZO</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Enable management server capability */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define ENABLE_MANAGEMENT 1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* Enable OFB and CFB cipher modes */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define ENABLE_OFB_CFB_MODE</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Enable PKCS11 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* #undef ENABLE_PKCS11 */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Enable plug-in support */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define ENABLE_PLUGIN 1</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* Enable TCP Server port sharing */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#cmakedefine ENABLE_PORT_SHARE</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* SELinux support */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#cmakedefine ENABLE_SELINUX</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* enable sitnl support */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#cmakedefine ENABLE_SITNL</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Enable systemd integration */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* #undef ENABLE_SYSTEMD */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Enable --x509-username-field feature */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#cmakedefine ENABLE_X509ALTUSERNAME</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* Compiler supports anonymous unions */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_ANONYM=
OUS_UNION_SUPPORT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you=
 have the &lt;arpa/inet.h&gt; header file. */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#cmakedefine HAVE_ARPA_INET_H 1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* Define to 1 if you have the `basename&#39; function. =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE=
_BASENAME</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have th=
e `chdir&#39; function. */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#cmakedefine HAVE_CHDIR</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Defin=
e to 1 if you have the `chroot&#39; function. */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#cmakedefine HAVE_CHROOT</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Define to 1 if you have the `chsize&#39; function. */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_CHSIZ=
E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* struct cmsghdr needed for extended=
 socket error support */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#cmakedefine HAVE_CMSGHDR</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Defin=
e to 1 if you have the `daemon&#39; function. */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#cmakedefine HAVE_DAEMON</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Define to 1 if you have the declaration of `SO_MARK&#39;,=
 and to 0 if you</span><br><span style=3D"color: hsl(120, 100%, 40%);">+don=
&#39;t. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedef=
ine01 HAVE_DECL_SO_MARK</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 =
if you have the &lt;direct.h&gt; header file. */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#cmakedefine HAVE_DIRECT_H</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* Define to 1 if you have the `dirname&#39; function. */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_DI=
RNAME</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &l=
t;dlfcn.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#cmakedefine HAVE_DLFCN_H</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Define to 1 if you have the &lt;dmalloc.h&gt; header file. */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_DMALLOC_H</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `dup&#39; fun=
ction. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefi=
ne HAVE_DUP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have =
the `dup2&#39; function. */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#cmakedefine HAVE_DUP2</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Defin=
e to 1 if you have the `epoll_create&#39; function. */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_EPOLL_CREATE</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;err.h&gt; hea=
der file. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmaked=
efine HAVE_ERR_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Crypto library supp=
orts keying material exporter */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define HAVE_EXPORT_KEYING_MATERIAL 1</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Define to 1 if you have the &lt;fcntl.h&gt; header file. */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_FC=
NTL_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `f=
ork&#39; function. */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#cmakedefine HAVE_FORK</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#cmakedefine HAVE_EXECVE</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define=
 to 1 if you have the `ftruncate&#39; function. */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_FTRUNCATE</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Define to 1 if you have the `getgrnam&#39; function.=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAV=
E_GETGRNAM</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have t=
he `getpeereid&#39; function. */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#cmakedefine HAVE_GETPEEREID</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Define to 1 if you have the `getpwnam&#39; function. */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_GETPWNAM</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `getrlimit&#39=
; function. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#unde=
f HAVE_GETRLIMIT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you =
have the `getsockname&#39; function. */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#cmakedefine HAVE_GETSOCKNAME</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Define to 1 if you have the `gettimeofday&#39; function. */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_GET=
TIMEOFDAY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have th=
e &lt;grp.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#cmakedefine HAVE_GRP_H</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
struct in_pktinfo needed for IP_PKTINFO support */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_IN_PKTINFO</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* Define to 1 if you have the &lt;io.h&gt; header fil=
e. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine H=
AVE_IO_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* struct in_pktinfo.ipi_spec_=
dst needed for IP_PKTINFO support */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#cmakedefine HAVE_IPI_SPEC_DST</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Define to 1 if you have the &lt;libgen.h&gt; header file. */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_LIBG=
EN_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt=
;limits.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define HAVE_LIMITS_H 1</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* De=
fine to 1 if you have the &lt;linux/if_tun.h&gt; header file. */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_LINUX_IF_TUN=
_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;l=
inux/sockios.h&gt; header file. */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#cmakedefine HAVE_LINUX_SOCKIOS_H</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* Define to 1 if you have the &lt;linux/types.h&gt; header file.=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAV=
E_LINUX_TYPES_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you h=
ave the &lt;lzoconf.h&gt; header file. */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define HAVE_LZO_CONF_H</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* Define to 1 if you have the &lt;lzo1x.h&gt; header file. */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_LZO1X_H 1</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;lzouti=
l.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define HAVE_LZOUTIL_H 1</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define =
to 1 if you have the `mlockall&#39; function. */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#cmakedefine HAVE_MLOCKALL</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* struct msghdr needed for extended socket error support =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE=
_MSGHDR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the =
&lt;netdb.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#cmakedefine HAVE_NETDB_H</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* Define to 1 if you have the &lt;netinet/in.h&gt; header file. */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_NETINET_IN=
_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;n=
etinet/in_systm.h&gt; header file. */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#undef HAVE_NETINET_IN_SYSTM_H</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* Define to 1 if you have the &lt;netinet/ip.h&gt; header file. =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE=
_NETINET_IP_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you hav=
e the &lt;netinet/tcp.h&gt; header file. */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#undef HAVE_NETINET_TCP_H</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Define to 1 if you have the &lt;net/if.h&gt; header file. */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_NE=
T_IF_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &=
lt;net/if_tun.h&gt; header file. */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#cmakedefine HAVE_NET_IF_TUN_H</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Define to 1 if you have the &lt;net/if_utun.h&gt; header file. *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine01 HAV=
E_NET_IF_UTUN_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you h=
ave the &lt;net/tun/if_tun.h&gt; header file. */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#cmakedefine HAVE_NET_TUN_IF_TUN_H</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `nice&#39; function=
. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_NIC=
E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `openl=
og&#39; function. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#undef HAVE_OPENLOG</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* OpenSSL engine =
support available */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#undef HAVE_OPENSSL_ENGINE</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define t=
o 1 if you have the `poll&#39; function. */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#undef HAVE_POLL</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Define to 1 if you have the &lt;poll.h&gt; header file. */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_POLL_H</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `putenv&#39; f=
unction. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef H=
AVE_PUTENV</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have t=
he &lt;pwd.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#cmakedefine HAVE_PWD_H</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 Define to 1 if you have the `readv&#39; function. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_READV</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Define to 1 if you have the `recvmsg&#39; function. */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_RECV=
MSG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAV=
E_SENDMSG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have th=
e &lt;resolv.h&gt; header file. */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#cmakedefine HAVE_RESOLV_H</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* sa_family_t, needed to hold AF_* info */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SA_FAMILY_T</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Define to 1 if you have the `sd_booted&#39; function. =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_SD_BO=
OTED</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `se=
tgid&#39; function. */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#cmakedefine HAVE_SETGID</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define t=
o 1 if you have the `setgroups&#39; function. */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#undef HAVE_SETGROUPS</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Define to 1 if you have the `setsid&#39; function. */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_SETSID</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `setsockopt&#39=
; function. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne HAVE_SETSOCKOPT 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if =
you have the `setuid&#39; function. */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#cmakedefine HAVE_SETUID</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* Define to 1 if you have the &lt;signal.h&gt; header file. */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_SIGNAL_H</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `socket&#39; =
function. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef =
HAVE_SOCKET</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* struct sock_extended_err=
 needed for extended socket error support */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#undef HAVE_SOCK_EXTENDED_ERR</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* Define to 1 if you have the `stat&#39; function. */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_STAT 1</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;stdarg=
.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define HAVE_STDARG_H 1</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to=
 1 if you have the &lt;stdint.h&gt; header file. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define HAVE_STDINT_H 1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* Define to 1 if you have the &lt;stdio.h&gt; header fi=
le. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_=
STDIO_H 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have th=
e &lt;stdlib.h&gt; header file. */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define HAVE_STDLIB_H 1</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* Define to 1 if you have the `strdup&#39; function. */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_STRDUP</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* Define to 1 if you have the &lt;strings.h&gt; header fi=
le. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_=
STRINGS_H 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have =
the &lt;string.h&gt; header file. */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define HAVE_STRING_H 1</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Define to 1 if you have the `strsep&#39; function. */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_STRSEP</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* Define to 1 if you have the `syslog&#39; function. */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_SYSLOG<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;sysl=
og.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#cmakedefine HAVE_SYSLOG_H</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Defi=
ne to 1 if you have the `system&#39; function. */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#undef HAVE_SYSTEM</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* Define to 1 if you have the &lt;systemd/sd-daemon.h&gt; header=
 file. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAV=
E_SYSTEMD_SD_DAEMON_H</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if=
 you have the &lt;sys/epoll.h&gt; header file. */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SYS_EPOLL_H</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* Define to 1 if you have the &lt;sys/file.h&gt; head=
er file. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef H=
AVE_SYS_FILE_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you ha=
ve the &lt;sys/inotify.h&gt; header file. */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SYS_INOTIFY_H</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Define to 1 if you have the &lt;sys/ioctl.h&gt; header=
 file. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefi=
ne HAVE_SYS_IOCTL_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if y=
ou have the &lt;sys/kern_control.h&gt; header file. */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_SYS_KERN_CONTROL_H</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;sys/mman.h&gt=
; header file. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#c=
makedefine HAVE_SYS_MMAN_H</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to=
 1 if you have the &lt;sys/socket.h&gt; header file. */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SYS_SOCKET_H</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;sys/sockio.h=
&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#undef HAVE_SYS_SOCKIO_H</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to =
1 if you have the &lt;sys/stat.h&gt; header file. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define HAVE_SYS_STAT_H 1</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* Define to 1 if you have the &lt;sys/time.h&gt; head=
er file. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakede=
fine HAVE_SYS_TIME_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if =
you have the &lt;sys/types.h&gt; header file. */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#undef HAVE_SYS_TYPES_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Define to 1 if you have the &lt;sys/uio.h&gt; header file=
. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HA=
VE_SYS_UIO_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have=
 the &lt;sys/un.h&gt; header file. */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#cmakedefine HAVE_SYS_UN_H</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* Define to 1 if you have the &lt;sys/wait.h&gt; header file. */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SYS_W=
AIT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &l=
t;tap-windows.h&gt; header file. */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#undef HAVE_TAP_WINDOWS_H</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Define to 1 if you have the `time&#39; function. */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define HAVE_TIME 1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* Define to 1 if you have the &lt;time.h&gt; header fil=
e. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_T=
IME_H 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the =
&lt;uapi.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#undef HAVE_UAPI_H</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define=
 to 1 if you have the &lt;unistd.h&gt; header file. */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_UNISTD_H</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;valgrind/memcheck=
.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#undef HAVE_VALGRIND_MEMCHECK_H</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* D=
efine to 1 if you have the &lt;versionhelpers.h&gt; header file. */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_VERSIONHELPERS_=
H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `vfork=
&#39; function. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
undef HAVE_VFORK</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you =
have the &lt;vfork.h&gt; header file. */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#undef HAVE_VFORK_H</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Define to 1 if you have the `vsnprintf&#39; function. */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_VSNPRINTF</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* we always assume a recent mbed TLS version */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_CTR_DRBG=
_UPDATE_RET 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Path to ifconfig tool =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IFCONFIG_=
PATH &quot;@IFCONFIG_PATH@&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Pat=
h to iproute tool */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define IPROUTE_PATH &quot;@IPROUTE_PATH@&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* Path to route tool */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define ROUTE_PATH &quot;@ROUTE_PATH@&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* OpenVPN major version - integer */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#undef OPENVPN_VERSION_MAJOR</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* OpenVPN minor version - integer */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#undef OPENVPN_VERSION_MINOR<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* OpenVPN patch level - may be a strin=
g or integer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine OPENVPN_VERSION_PATCH &quot;@OPENVPN_VERSION_PATCH@&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* Name of package */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define PACKAGE &quot;openvpn&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Define to the address where bug reports for this p=
ackage should be sent. */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#undef PACKAGE_BUGREPORT</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Defin=
e to the full name of this package. */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define PACKAGE_NAME &quot;OpenVPN&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* Define to the full name and version of this package=
. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PACKAGE=
_STRING &quot;OpenVPN @OPENVPN_VERSION_MAJOR@...220...@OPENVPN_VERSION_MINO=
R@@OPENVPN_VERSION_PATCH@&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Defi=
ne to the version of this package. */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define PACKAGE_VERSION &quot;@OPENVPN_VERSION_MAJOR@...1665...=
20...@...2740...@@OPENVPN_VERSION_PATCH@&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* OpenVPN major version - integer */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_VERSION_MAJOR @OPENVPN=
_VERSION_MAJOR@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* OpenVPN minor versio=
n - integer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne OPENVPN_VERSION_MINOR @OPENVPN_VERSION_MINOR@</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* Path to systemd-ask-password tool */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#undef SYSTEMD_ASK_PASSWORD_PATH</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* systemd is newer than v216 */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define SYSTEMD_NEWER_THAN_216</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* The tap-windows id */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define TAP_WIN_COMPONENT_ID &quot;tap090=
1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* The tap-windows version numb=
er is required for OpenVPN */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define TAP_WIN_MIN_MAJOR 9</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* The tap-windows version number is required for OpenVPN */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define TAP_WIN_MIN_MINOR 9</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* Are we running on Mac OS X? */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine TARGET_DARWIN</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* Are we running on FreeBSD? */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine TARGET_FREEBSD</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Are we running on Linux? */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine TARGET_LINUX</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Are we running WIN32? */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine TARGET_WIN32</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define TARGET_ALIAS &quot;@CMAKE_SYSTEM_NAME@=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* Enable GNU extensions on syst=
ems that have them.  */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#ifndef _GNU_SOURCE</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# define _GNU_SOURCE 1</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &lt;inttypes.h&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+typedef uint32_t in_addr_t;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+typedef uint16_t in_port_t;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define SIGHUP    1</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define SIGINT    2</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define SIGUSR1   10</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define SIGUSR2   12</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define SIGTERM   15</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(_MSC_VER)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &lt;BaseTsd.h&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+typedef SSIZE_T ssize_t;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define strncasecmp strnicmp</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define strcasecmp _stricmp</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define S_IRUSR 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine S_IWUSR 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine R_OK 4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define W=
_OK 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define X_OK 1=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define F_OK 0</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>diff --git a/src/ope=
nvpn/lzo.h b/src/openvpn/lzo.h</span><br><span>index c572354..f05c002 10064=
4</span><br><span>--- a/src/openvpn/lzo.h</span><br><span>+++ b/src/openvpn=
/lzo.h</span><br><span>@@ -37,7 +37,14 @@</span><br><span>  * @addtogroup c=
ompression</span><br><span>  * @{</span><br><span>  */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if defined(HAVE_LZO_CONF_H)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* The lzo.h magic gets confused and still wants</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to include lzo/lzoco=
nf.h even if our include paths</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * are setup to include the paths without lzo/ include lzoconf.h=
 to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * avoid it bein=
g include by lzoutil.h */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &lt;lzodefs.h&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &lt;lzoconf.h&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span> #if defined(HAVE_LZO_LZOUTIL_H)=
</span><br><span> #include &lt;lzo/lzoutil.h&gt;</span><br><span> #elif def=
ined(HAVE_LZOUTIL_H)</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/322?usp=3Demail">change 322</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/322?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I666314a223d324ca72dbe7ba7d2=
2f764996d3ca2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 322 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--CK9831YH5ZI=--

