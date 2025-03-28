From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 28 Mar 2025 14:18:10 +0000
References: <gerrit.1743171486000.I0c4fce76c81c5297ff5469d787114f1279bf35e5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <01fea60bc616cf6169268641c7c2a0a70ba57ec9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vIqZJJqDsmI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: CMake: Reorganize
 header and symbol tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vIqZJJqDsmI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/924?usp=3Demail

to review the following change.


Change subject: CMake: Reorganize header and symbol tests
......................................................................

CMake: Reorganize header and symbol tests

When we check for the header and then symbols
in that header combine this so that the
relationship between the tests is clear and
that we do not do tests we know will fail.

Change-Id: I0c4fce76c81c5297ff5469d787114f1279bf35e5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CMakeLists.txt
1 file changed, 83 insertions(+), 65 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/924/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index ba11056..2169e69 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -74,7 +74,11 @@
 endfunction()

 if (MSVC)
-    add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE =
-D_WINSOCK_DEPRECATED_NO_WARNINGS)
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
+    # Checking for existence of structs with check_symbol_exists does not =
work,
+    # so we use check_struct_hash_member with a member instead
+    check_struct_has_member("struct cmsghdr" cmsg_len sys/socket.h HAVE_CM=
SGHDR)
+endif()
+check_include_files(sys/time.h HAVE_SYS_TIME_H)
+if (HAVE_SYS_TIME_H)
+    check_symbol_exists(gettimeofday sys/time.h HAVE_GETTIMEOFDAY)
+    check_symbol_exists(getrlimit "sys/time.h;sys/resource.h" HAVE_GETRLIM=
IT)
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
-check_struct_has_member("struct cmsghdr" cmsg_len sys/socket.h HAVE_CMSGHD=
R)
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
-check_struct_has_member("struct in_pktinfo" ipi_spec_dst netinet/ip.h HAVE=
_IPI_SPEC_DST)
-check_type_size("struct msghdr" MSGHDR)
-set(CMAKE_EXTRA_INCLUDE_FILES)
+check_include_files("${NETEXTRA};netinet/ip.h" HAVE_NETINET_IP_H)
+if (HAVE_NETINET_IP_H)
+    set(CMAKE_EXTRA_INCLUDE_FILES netinet/ip.h)
+    check_type_size("struct in_pktinfo" IN_PKTINFO)
+    check_struct_has_member("struct in_pktinfo" ipi_spec_dst netinet/ip.h =
HAVE_IPI_SPEC_DST)
+    check_type_size("struct msghdr" MSGHDR)
+    set(CMAKE_EXTRA_INCLUDE_FILES)
+endif()

 find_program(IFCONFIG_PATH ifconfig)
 find_program(IPROUTE_PATH ip)
@@ -316,8 +334,8 @@

     if (MINGW)
         target_compile_definitions(${target} PRIVATE
-                -DWIN32_LEAN_AND_MEAN
-                -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINN=
T_VISTA
+                WIN32_LEAN_AND_MEAN
+                NTDDI_VERSION=3DNTDDI_VISTA _WIN32_WINNT=3D_WIN32_WINNT_VI=
STA
         )
     endif()

@@ -359,7 +377,7 @@
 configure_file(config.h.cmake.in config.h)
 configure_file(include/openvpn-plugin.h.in openvpn-plugin.h)
 # TODO we should remove the need for this, and always include config.h
-add_definitions(-DHAVE_CONFIG_H)
+add_compile_definitions(HAVE_CONFIG_H)

 include_directories(${CMAKE_CURRENT_BINARY_DIR})

@@ -707,7 +725,7 @@

         # for compat with IDEs like Clion that ignore the tests properties
         # for the environment variable srcdir when running tests as fallba=
ck
-        target_compile_definitions(${test_name} PRIVATE "-DUNIT_TEST_SOURC=
EDIR=3D\"${CMAKE_SOURCE_DIR}/tests/unit_tests/openvpn\"")
+        target_compile_definitions(${test_name} PRIVATE "UNIT_TEST_SOURCED=
IR=3D\"${CMAKE_SOURCE_DIR}/tests/unit_tests/openvpn\"")

         if (NOT ${test_name} STREQUAL "test_buffer")
             target_sources(${test_name} PRIVATE

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/924?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0c4fce76c81c5297ff5469d787114f1279bf35e5
Gerrit-Change-Number: 924
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--vIqZJJqDsmI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/924?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">CMake: Reorganize header and symbol tests<br><br>When we chec=
k for the header and then symbols<br>in that header combine this so that th=
e<br>relationship between the tests is clear and<br>that we do not do tests=
 we know will fail.<br><br>Change-Id: I0c4fce76c81c5297ff5469d787114f1279bf=
35e5<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br=
>M CMakeLists.txt<br>1 file changed, 83 insertions(+), 65 deletions(-)<br><=
br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/924/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index=
 ba11056..2169e69 100644</span><br><span>--- a/CMakeLists.txt</span><br><sp=
an>+++ b/CMakeLists.txt</span><br><span>@@ -74,7 +74,11 @@</span><br><span>=
 endfunction()</span><br><span> </span><br><span> if (MSVC)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    add_definitions(-D_CRT_SECURE_NO_=
WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE -D_WINSOCK_DEPRECATED_NO_WARNINGS)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_compile_definit=
ions(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        _CRT_S=
ECURE_NO_WARNINGS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      _CRT_NONSTDC_NO_DEPRECATE</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        _WINSOCK_DEPRECATED_NO_WARNINGS</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span>     if (USE_WE=
RROR)</span><br><span>         add_compile_options(/WX)</span><br><span>   =
  endif ()</span><br><span>@@ -171,88 +175,102 @@</span><br><span>     set(=
TARGET_WIN32 YES)</span><br><span> endif ()</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-check_symbol_exists(chroot unistd.h=
 HAVE_CHROOT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_sy=
mbol_exists(chdir unistd.h HAVE_CHDIR)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-check_symbol_exists(dup unistd.h HAVE_DUP)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-check_symbol_exists(dup2 unistd.h HAV=
E_DUP2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_symbol_e=
xists(fork unistd.h HAVE_FORK)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-check_symbol_exists(execve unistd.h HAVE_EXECVE)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-check_symbol_exists(ftruncate unistd.h =
HAVE_FTRUNCATE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_=
symbol_exists(nice unistd.h HAVE_NICE)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-check_symbol_exists(setgid unistd.h HAVE_SETGID)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-check_symbol_exists(setuid unis=
td.h HAVE_SETUID)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-chec=
k_symbol_exists(setsid unistd.h HAVE_SETSID)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-check_symbol_exists(getpeereid &quot;unistd.h;sys/so=
cket.h&quot; HAVE_GETPEEREID)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+check_include_files(unistd.h HAVE_UNISTD_H)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+if (HAVE_UNISTD_H)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists(chroot unistd.h H=
AVE_CHROOT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    chec=
k_symbol_exists(chdir unistd.h HAVE_CHDIR)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    check_symbol_exists(dup unistd.h HAVE_DUP)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists(d=
up2 unistd.h HAVE_DUP2)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    check_symbol_exists(fork unistd.h HAVE_FORK)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists(execve unistd.h H=
AVE_EXECVE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    chec=
k_symbol_exists(ftruncate unistd.h HAVE_FTRUNCATE)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    check_symbol_exists(nice unistd.h HAVE_N=
ICE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_symbo=
l_exists(setgid unistd.h HAVE_SETGID)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    check_symbol_exists(setuid unistd.h HAVE_SETUID)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists(=
setsid unistd.h HAVE_SETSID)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    check_symbol_exists(daemon &quot;unistd.h;stdlib.h&quot; HAVE_=
DAEMON)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_sy=
mbol_exists(getpeereid &quot;unistd.h;sys/socket.h&quot; HAVE_GETPEEREID)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif()</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_symbol_exis=
ts(epoll_create sys/epoll.h HAVE_EPOLL_CREATE)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+check_include_files(grp.h HAVE_GRP_H)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+if (HAVE_GRP_H)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists(getgrnam g=
rp.h HAVE_GETGRNAM)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
endif()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_includ=
e_files(libgen.h HAVE_LIBGEN_H)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+if (HAVE_LIBGEN_H)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    check_symbol_exists(basename libgen.h HAVE_BASENAME)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists(dir=
name libgen.h HAVE_DIRNAME)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+endif()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+chec=
k_include_files(pwd.h HAVE_PWD_H)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+if (HAVE_PWD_H)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    check_symbol_exists(getpwnam pwd.h HAVE_GETPWNAM)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+endif()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+check_include_files(sys/epoll.h HAVE_SYS_=
EPOLL_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (HAVE_SY=
S_EPOLL_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check=
_symbol_exists(epoll_create sys/epoll.h HAVE_EPOLL_CREATE)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+endif()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+check_include_files(syslog.h HAVE_SYSLOG_H)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+if (HAVE_SYSLOG_H)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists(o=
penlog syslog.h HAVE_OPENLOG)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    check_symbol_exists(syslog syslog.h HAVE_SYSLOG)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+endif()</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+check_include_files(sys/mman.h HAVE_SYS_MMAN=
_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (HAVE_SYS_MMA=
N_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_symbo=
l_exists(mlockall sys/mman.h HAVE_MLOCKALL)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+endif()</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+check_include_files(sys/socket.h HAVE_SYS_SOCKET_H)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+if (HAVE_SYS_SOCKET_H)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists(send=
msg sys/socket.h HAVE_SENDMSG)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    check_symbol_exists(recvmsg sys/socket.h HAVE_RECVMSG)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists(g=
etsockname sys/socket.h HAVE_GETSOCKNAME)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    # Checking for existence of structs with check_sy=
mbol_exists does not work,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    # so we use check_struct_hash_member with a member instead</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_struct_has_memb=
er(&quot;struct cmsghdr&quot; cmsg_len sys/socket.h HAVE_CMSGHDR)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+endif()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+check_include_files(sys/time.h HAVE_SYS_T=
IME_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (HAVE_SYS_=
TIME_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_sy=
mbol_exists(gettimeofday sys/time.h HAVE_GETTIMEOFDAY)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists(getrlimit &quot;=
sys/time.h;sys/resource.h&quot; HAVE_GETRLIMIT)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+endif()</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-check_symbol_exists(gettimeofday sys/time.h=
 HAVE_GETTIMEOFDAY)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ch=
eck_symbol_exists(basename libgen.h HAVE_BASENAME)</span><br><span> check_s=
ymbol_exists(chsize io.h HAVE_CHSIZE)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-check_symbol_exists(daemon &quot;unistd.h;stdlib.h&quot; HA=
VE_DAEMON)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_symbo=
l_exists(dirname libgen.h HAVE_DIRNAME)</span><br><span> check_symbol_exist=
s(getrlimit sys/resource.h HAVE_GETRLIMIT)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-check_symbol_exists(mlockall sys/mman.h HAVE_MLOCKALL)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-check_symbol_exists(sendmsg sys/socket.h H=
AVE_SENDMSG)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_sym=
bol_exists(recvmsg sys/socket.h HAVE_RECVMSG)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-check_symbol_exists(openlog syslog.h HAVE_OPENLOG)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_symbol_exists(sy=
slog syslog.h HAVE_SYSLOG)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-check_symbol_exists(getgrnam grp.h HAVE_GETGRNAM)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-check_symbol_exists(getpwnam pwd.h HAVE_GE=
TPWNAM)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_symbol_e=
xists(getsockname sys/socket.h HAVE_GETSOCKNAME)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-check_symbol_exists(getrlimit &quot;sys/time.h;s=
ys/resource.h&quot; HAVE_GETRLIMIT)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Check=
ing for existence of structs with check_symbol_exists does not work,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-# so we use check_struct_has=
h_member with a member instead</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-check_struct_has_member(&quot;struct cmsghdr&quot; cmsg_len sys/so=
cket.h HAVE_CMSGHDR)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> </span><br><span> # Some OS (e.g. FreeBSD) need some basic=
 headers to allow</span><br><span> # including network headers</span><br><s=
pan> set(NETEXTRA sys/types.h)</span><br><span> check_include_files(&quot;$=
{NETEXTRA};netinet/in.h&quot; HAVE_NETINET_IN_H)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> if (HAVE_NETINET_IN_H)</span><=
br><span>     list(APPEND NETEXTRA netinet/in.h)</span><br><span> endif ()<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-chec=
k_include_files(&quot;${NETEXTRA};netinet/in6.h&quot; HAVE_NETINET_IN_H)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+check_include_files(ar=
pa/inet.h HAVE_ARPA_INET_H)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+check_include_files(dlfcn.h HAVE_DLFCN_H)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+check_include_files(dmalloc.h HAVE_DMALLOC_H)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_include_files=
(fcntl.h HAVE_FCNTL_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+check_include_files(err.h HAVE_ERR_H)</span><br><span> check_include_fil=
es(linux/if_tun.h HAVE_LINUX_IF_TUN_H)</span><br><span> check_include_files=
(linux/sockios.h HAVE_LINUX_SOCKIOS_H)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-check_include_files(dlfcn.h HAVE_DLFCN_H)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-check_include_files(fcntl.h HAVE_FCNTL=
_H)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_include_file=
s(dmalloc.h HAVE_DMALLOC_H)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-check_include_files(err.h HAVE_ERR_H)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-check_include_files(sys/epoll.h HAVE_SYS_EPOLL_H)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-check_include_files(poll.=
h HAVE_POLL_H)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_i=
nclude_files(sys/socket.h HAVE_SYS_SOCKET_H)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-check_include_files(sys/time.h HAVE_SYS_TIME_H)</spa=
n><br><span> check_include_files(netdb.h HAVE_NETDB_H)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-check_include_files(unistd.h HAVE_UNISTD_H=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_include_files(=
sys/un.h HAVE_SYS_UN_H)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-check_include_files(libgen.h HAVE_LIBGEN_H)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+check_include_files(&quot;${NETEXTRA};netinet/in6=
.h&quot; HAVE_NETINET_IN_H)</span><br><span> check_include_files(net/if.h H=
AVE_NET_IF_H)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_in=
clude_files(&quot;${NETEXTRA};netinet/ip.h&quot; HAVE_NETINET_IP_H)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-check_include_files(arpa/inet=
.h HAVE_ARPA_INET_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+check_include_files(&quot;${NETEXTRA};net/if_tun.h&quot; HAVE_NET_IF_TUN_H=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_include_file=
s(poll.h HAVE_POLL_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+check_include_files(&quot;${NETEXTRA};resolv.h&quot; HAVE_RESOLV_H)</span=
><br><span> check_include_files(sys/ioctl.h HAVE_SYS_IOCTL_H)</span><br><sp=
an> check_include_files(sys/inotify.h HAVE_SYS_INOTIFY_H)</span><br><span> =
check_include_files(&quot;${NETEXTRA};sys/uio.h&quot; HAVE_SYS_UIO_H)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-check_include_files(syslog.=
h HAVE_SYSLOG_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+che=
ck_include_files(sys/un.h HAVE_SYS_UN_H)</span><br><span> check_include_fil=
es(sys/wait.h HAVE_SYS_WAIT_H)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-check_include_files(grp.h HAVE_GRP_H)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-check_include_files(pwd.h HAVE_PWD_H)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-check_include_files(sys/mman.h HAV=
E_SYS_MMAN_H)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_inclu=
de_files(&quot;${NETEXTRA};resolv.h&quot; HAVE_RESOLV_H)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-check_include_files(&quot;${NETEXTRA};ne=
t/if_tun.h&quot; HAVE_NET_IF_TUN_H)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set(CMA=
KE_EXTRA_INCLUDE_FILES netinet/ip.h)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-check_type_size(&quot;struct in_pktinfo&quot; IN_PKTINFO)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-check_struct_has_member(=
&quot;struct in_pktinfo&quot; ipi_spec_dst netinet/ip.h HAVE_IPI_SPEC_DST)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_type_size(&quot;=
struct msghdr&quot; MSGHDR)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-set(CMAKE_EXTRA_INCLUDE_FILES)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+check_include_files(&quot;${NETEXTRA};netinet/ip.h&quot; H=
AVE_NETINET_IP_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if=
 (HAVE_NETINET_IP_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    set(CMAKE_EXTRA_INCLUDE_FILES netinet/ip.h)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    check_type_size(&quot;struct in_pktinfo&qu=
ot; IN_PKTINFO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
check_struct_has_member(&quot;struct in_pktinfo&quot; ipi_spec_dst netinet/=
ip.h HAVE_IPI_SPEC_DST)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    check_type_size(&quot;struct msghdr&quot; MSGHDR)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    set(CMAKE_EXTRA_INCLUDE_FILES)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+endif()</span><br><spa=
n> </span><br><span> find_program(IFCONFIG_PATH ifconfig)</span><br><span> =
find_program(IPROUTE_PATH ip)</span><br><span>@@ -316,8 +334,8 @@</span><br=
><span> </span><br><span>     if (MINGW)</span><br><span>         target_co=
mpile_definitions(${target} PRIVATE</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                -DWIN32_LEAN_AND_MEAN</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                -DNTDDI_VERSION=3DNTDDI_VIS=
TA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                WIN32_LEAN_AND_MEAN</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                NTDDI_VERSION=3DNTDDI_VI=
STA _WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span>         )</span><br>=
<span>     endif()</span><br><span> </span><br><span>@@ -359,7 +377,7 @@</s=
pan><br><span> configure_file(config.h.cmake.in config.h)</span><br><span> =
configure_file(include/openvpn-plugin.h.in openvpn-plugin.h)</span><br><spa=
n> # TODO we should remove the need for this, and always include config.h</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-add_definitions(-DHAVE_=
CONFIG_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_compil=
e_definitions(HAVE_CONFIG_H)</span><br><span> </span><br><span> include_dir=
ectories(${CMAKE_CURRENT_BINARY_DIR})</span><br><span> </span><br><span>@@ =
-707,7 +725,7 @@</span><br><span> </span><br><span>         # for compat wi=
th IDEs like Clion that ignore the tests properties</span><br><span>       =
  # for the environment variable srcdir when running tests as fallback</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        target_compile_def=
initions(${test_name} PRIVATE &quot;-DUNIT_TEST_SOURCEDIR=3D\&quot;${CMAKE_=
SOURCE_DIR}/tests/unit_tests/openvpn\&quot;&quot;)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        target_compile_definitions(${test_na=
me} PRIVATE &quot;UNIT_TEST_SOURCEDIR=3D\&quot;${CMAKE_SOURCE_DIR}/tests/un=
it_tests/openvpn\&quot;&quot;)</span><br><span> </span><br><span>         i=
f (NOT ${test_name} STREQUAL &quot;test_buffer&quot;)</span><br><span>     =
        target_sources(${test_name} PRIVATE</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/924?us=
p=3Demail">change 924</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/924?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0c4fce76c81c5297ff5469d7871=
14f1279bf35e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 924 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--vIqZJJqDsmI=--

