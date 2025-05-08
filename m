From: Gert Doering <gert@...1296...>
Date: Thu,  8 May 2025 19:46:15 +0200
Message-ID: <20250508174624.7504-1-gert@...1296...>
In-Reply-To: <gerrit.1743171486000.I0c4fce76c81c5297ff5469d787114f1279bf35e5@...2715...>
References: <gerrit.1743171486000.I0c4fce76c81c5297ff5469d787114f1279bf35e5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] CMake: Reorganize header and symbol tests
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

From: Frank Lichtenheld <frank@...2641...>

When we check for the header and then symbols
in that header combine this so that the
relationship between the tests is clear and
that we do not do tests we know will fail.

Change-Id: I0c4fce76c81c5297ff5469d787114f1279bf35e5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/924
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index c19d29a..ae818c3 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -74,7 +74,11 @@
 endfunction()
 
 if (MSVC)
-    add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE -D_WINSOCK_DEPRECATED_NO_WARNINGS)
+    add_compile_definitions(
+        _CRT_SECURE_NO_WARNINGS
+        _CRT_NONSTDC_NO_DEPRECATE
+        _WINSOCK_DEPRECATED_NO_WARNINGS
+        )
     if (USE_WERROR)
         add_compile_options(/WX)
     endif ()
@@ -171,88 +175,102 @@
     set(TARGET_WIN32 YES)
 endif ()
 
-check_symbol_exists(chroot unistd.h HAVE_CHROOT)
-check_symbol_exists(chdir unistd.h HAVE_CHDIR)
-check_symbol_exists(dup unistd.h HAVE_DUP)
-check_symbol_exists(dup2 unistd.h HAVE_DUP2)
-check_symbol_exists(fork unistd.h HAVE_FORK)
-check_symbol_exists(execve unistd.h HAVE_EXECVE)
-check_symbol_exists(ftruncate unistd.h HAVE_FTRUNCATE)
-check_symbol_exists(nice unistd.h HAVE_NICE)
-check_symbol_exists(setgid unistd.h HAVE_SETGID)
-check_symbol_exists(setuid unistd.h HAVE_SETUID)
-check_symbol_exists(setsid unistd.h HAVE_SETSID)
-check_symbol_exists(getpeereid "unistd.h;sys/socket.h" HAVE_GETPEEREID)
+check_include_files(unistd.h HAVE_UNISTD_H)
+if (HAVE_UNISTD_H)
+    check_symbol_exists(chroot unistd.h HAVE_CHROOT)
+    check_symbol_exists(chdir unistd.h HAVE_CHDIR)
+    check_symbol_exists(dup unistd.h HAVE_DUP)
+    check_symbol_exists(dup2 unistd.h HAVE_DUP2)
+    check_symbol_exists(fork unistd.h HAVE_FORK)
+    check_symbol_exists(execve unistd.h HAVE_EXECVE)
+    check_symbol_exists(ftruncate unistd.h HAVE_FTRUNCATE)
+    check_symbol_exists(nice unistd.h HAVE_NICE)
+    check_symbol_exists(setgid unistd.h HAVE_SETGID)
+    check_symbol_exists(setuid unistd.h HAVE_SETUID)
+    check_symbol_exists(setsid unistd.h HAVE_SETSID)
+    check_symbol_exists(daemon "unistd.h;stdlib.h" HAVE_DAEMON)
+    check_symbol_exists(getpeereid "unistd.h;sys/socket.h" HAVE_GETPEEREID)
+endif()
 
-check_symbol_exists(epoll_create sys/epoll.h HAVE_EPOLL_CREATE)
+check_include_files(grp.h HAVE_GRP_H)
+if (HAVE_GRP_H)
+    check_symbol_exists(getgrnam grp.h HAVE_GETGRNAM)
+endif()
+check_include_files(libgen.h HAVE_LIBGEN_H)
+if (HAVE_LIBGEN_H)
+    check_symbol_exists(basename libgen.h HAVE_BASENAME)
+    check_symbol_exists(dirname libgen.h HAVE_DIRNAME)
+endif()
+check_include_files(pwd.h HAVE_PWD_H)
+if (HAVE_PWD_H)
+    check_symbol_exists(getpwnam pwd.h HAVE_GETPWNAM)
+endif()
+check_include_files(sys/epoll.h HAVE_SYS_EPOLL_H)
+if (HAVE_SYS_EPOLL_H)
+    check_symbol_exists(epoll_create sys/epoll.h HAVE_EPOLL_CREATE)
+endif()
+check_include_files(syslog.h HAVE_SYSLOG_H)
+if (HAVE_SYSLOG_H)
+    check_symbol_exists(openlog syslog.h HAVE_OPENLOG)
+    check_symbol_exists(syslog syslog.h HAVE_SYSLOG)
+endif()
+check_include_files(sys/mman.h HAVE_SYS_MMAN_H)
+if (HAVE_SYS_MMAN_H)
+    check_symbol_exists(mlockall sys/mman.h HAVE_MLOCKALL)
+endif()
+check_include_files(sys/socket.h HAVE_SYS_SOCKET_H)
+if (HAVE_SYS_SOCKET_H)
+    check_symbol_exists(sendmsg sys/socket.h HAVE_SENDMSG)
+    check_symbol_exists(recvmsg sys/socket.h HAVE_RECVMSG)
+    check_symbol_exists(getsockname sys/socket.h HAVE_GETSOCKNAME)
+    # Checking for existence of structs with check_symbol_exists does not work,
+    # so we use check_struct_hash_member with a member instead
+    check_struct_has_member("struct cmsghdr" cmsg_len sys/socket.h HAVE_CMSGHDR)
+endif()
+check_include_files(sys/time.h HAVE_SYS_TIME_H)
+if (HAVE_SYS_TIME_H)
+    check_symbol_exists(gettimeofday sys/time.h HAVE_GETTIMEOFDAY)
+    check_symbol_exists(getrlimit "sys/time.h;sys/resource.h" HAVE_GETRLIMIT)
+endif()
 
-check_symbol_exists(gettimeofday sys/time.h HAVE_GETTIMEOFDAY)
-check_symbol_exists(basename libgen.h HAVE_BASENAME)
 check_symbol_exists(chsize io.h HAVE_CHSIZE)
-check_symbol_exists(daemon "unistd.h;stdlib.h" HAVE_DAEMON)
-check_symbol_exists(dirname libgen.h HAVE_DIRNAME)
 check_symbol_exists(getrlimit sys/resource.h HAVE_GETRLIMIT)
-check_symbol_exists(mlockall sys/mman.h HAVE_MLOCKALL)
-
-check_symbol_exists(sendmsg sys/socket.h HAVE_SENDMSG)
-check_symbol_exists(recvmsg sys/socket.h HAVE_RECVMSG)
-check_symbol_exists(openlog syslog.h HAVE_OPENLOG)
-check_symbol_exists(syslog syslog.h HAVE_SYSLOG)
-check_symbol_exists(getgrnam grp.h HAVE_GETGRNAM)
-check_symbol_exists(getpwnam pwd.h HAVE_GETPWNAM)
-check_symbol_exists(getsockname sys/socket.h HAVE_GETSOCKNAME)
-check_symbol_exists(getrlimit "sys/time.h;sys/resource.h" HAVE_GETRLIMIT)
-
-# Checking for existence of structs with check_symbol_exists does not work,
-# so we use check_struct_hash_member with a member instead
-check_struct_has_member("struct cmsghdr" cmsg_len sys/socket.h HAVE_CMSGHDR)
-
 
 # Some OS (e.g. FreeBSD) need some basic headers to allow
 # including network headers
 set(NETEXTRA sys/types.h)
 check_include_files("${NETEXTRA};netinet/in.h" HAVE_NETINET_IN_H)
-
 if (HAVE_NETINET_IN_H)
     list(APPEND NETEXTRA netinet/in.h)
 endif ()
 
-check_include_files("${NETEXTRA};netinet/in6.h" HAVE_NETINET_IN_H)
+check_include_files(arpa/inet.h HAVE_ARPA_INET_H)
+check_include_files(dlfcn.h HAVE_DLFCN_H)
+check_include_files(dmalloc.h HAVE_DMALLOC_H)
+check_include_files(fcntl.h HAVE_FCNTL_H)
+check_include_files(err.h HAVE_ERR_H)
 check_include_files(linux/if_tun.h HAVE_LINUX_IF_TUN_H)
 check_include_files(linux/sockios.h HAVE_LINUX_SOCKIOS_H)
-check_include_files(dlfcn.h HAVE_DLFCN_H)
-check_include_files(fcntl.h HAVE_FCNTL_H)
-check_include_files(dmalloc.h HAVE_DMALLOC_H)
-check_include_files(err.h HAVE_ERR_H)
-check_include_files(sys/epoll.h HAVE_SYS_EPOLL_H)
-check_include_files(poll.h HAVE_POLL_H)
-check_include_files(sys/socket.h HAVE_SYS_SOCKET_H)
-check_include_files(sys/time.h HAVE_SYS_TIME_H)
 check_include_files(netdb.h HAVE_NETDB_H)
-check_include_files(unistd.h HAVE_UNISTD_H)
-check_include_files(sys/un.h HAVE_SYS_UN_H)
-check_include_files(libgen.h HAVE_LIBGEN_H)
+check_include_files("${NETEXTRA};netinet/in6.h" HAVE_NETINET_IN_H)
 check_include_files(net/if.h HAVE_NET_IF_H)
-check_include_files("${NETEXTRA};netinet/ip.h" HAVE_NETINET_IP_H)
-check_include_files(arpa/inet.h HAVE_ARPA_INET_H)
+check_include_files("${NETEXTRA};net/if_tun.h" HAVE_NET_IF_TUN_H)
+check_include_files(poll.h HAVE_POLL_H)
+check_include_files("${NETEXTRA};resolv.h" HAVE_RESOLV_H)
 check_include_files(sys/ioctl.h HAVE_SYS_IOCTL_H)
 check_include_files(sys/inotify.h HAVE_SYS_INOTIFY_H)
 check_include_files("${NETEXTRA};sys/uio.h" HAVE_SYS_UIO_H)
-check_include_files(syslog.h HAVE_SYSLOG_H)
+check_include_files(sys/un.h HAVE_SYS_UN_H)
 check_include_files(sys/wait.h HAVE_SYS_WAIT_H)
-check_include_files(grp.h HAVE_GRP_H)
-check_include_files(pwd.h HAVE_PWD_H)
-check_include_files(sys/mman.h HAVE_SYS_MMAN_H)
 
-
-check_include_files("${NETEXTRA};resolv.h" HAVE_RESOLV_H)
-check_include_files("${NETEXTRA};net/if_tun.h" HAVE_NET_IF_TUN_H)
-
-set(CMAKE_EXTRA_INCLUDE_FILES netinet/ip.h)
-check_type_size("struct in_pktinfo" IN_PKTINFO)
-check_struct_has_member("struct in_pktinfo" ipi_spec_dst netinet/ip.h HAVE_IPI_SPEC_DST)
-check_type_size("struct msghdr" MSGHDR)
-set(CMAKE_EXTRA_INCLUDE_FILES)
+check_include_files("${NETEXTRA};netinet/ip.h" HAVE_NETINET_IP_H)
+if (HAVE_NETINET_IP_H)
+    set(CMAKE_EXTRA_INCLUDE_FILES netinet/ip.h)
+    check_type_size("struct in_pktinfo" IN_PKTINFO)
+    check_struct_has_member("struct in_pktinfo" ipi_spec_dst netinet/ip.h HAVE_IPI_SPEC_DST)
+    check_type_size("struct msghdr" MSGHDR)
+    set(CMAKE_EXTRA_INCLUDE_FILES)
+endif()
 
 find_program(IFCONFIG_PATH ifconfig)
 find_program(IPROUTE_PATH ip)
@@ -317,8 +335,8 @@
 
     if (MINGW)
         target_compile_definitions(${target} PRIVATE
-                -DWIN32_LEAN_AND_MEAN
-                -DNTDDI_VERSION=NTDDI_VISTA -D_WIN32_WINNT=_WIN32_WINNT_VISTA
+                WIN32_LEAN_AND_MEAN
+                NTDDI_VERSION=NTDDI_VISTA _WIN32_WINNT=_WIN32_WINNT_VISTA
         )
     endif()
 
@@ -360,7 +378,7 @@
 configure_file(config.h.cmake.in config.h)
 configure_file(include/openvpn-plugin.h.in openvpn-plugin.h)
 # TODO we should remove the need for this, and always include config.h
-add_definitions(-DHAVE_CONFIG_H)
+add_compile_definitions(HAVE_CONFIG_H)
 
 include_directories(${CMAKE_CURRENT_BINARY_DIR})
 

