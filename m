From: Antonio Quartulli <a@...2181...>
Date: Sat,  2 Apr 2022 09:09:01 +0200
Message-Id: <20220402070902.30282-7-a@...2181...>
In-Reply-To: <20220402070902.30282-1-a@...2181...>
References: <20220402070902.30282-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/7] ovpn-dco-win: introduce windows
 data-channel offload support
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
Cc: Arne Schwabe <arne@...1227...>, Lev Stipakov <lev@...515...>, Antonio Quartulli <a@...2181...>

From: Arne Schwabe <arne@...1227...>

Implement the data-channel offloading using the ovpn-dco-win kernel
module. See README.dco.md for more details.

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Lev Stipakov <lev@...515...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 .github/workflows/build.yaml                  |   7 +-
 README.dco.md                                 |   9 +
 config-msvc.h                                 |   2 +
 configure.ac                                  |  29 +-
 src/compat/Makefile.am                        |   3 +-
 src/compat/compat-dco_get_overlapped_result.c |  44 ++
 src/compat/compat.h                           |   6 +
 src/compat/compat.vcxproj                     |   1 +
 src/compat/compat.vcxproj.filters             |   3 +
 src/openvpn/Makefile.am                       |   3 +-
 src/openvpn/dco.c                             |  28 +-
 src/openvpn/dco.h                             |   5 +
 src/openvpn/dco_internal.h                    |   1 +
 src/openvpn/dco_linux.c                       |   6 +
 src/openvpn/dco_linux.h                       |   1 -
 src/openvpn/dco_win.c                         | 397 ++++++++++++++++++
 src/openvpn/dco_win.h                         |  57 +++
 src/openvpn/init.c                            |  34 +-
 src/openvpn/openvpn.vcxproj                   |   2 +
 src/openvpn/openvpn.vcxproj.filters           |   9 +
 src/openvpn/options.c                         |  22 +-
 src/openvpn/options.h                         |  13 +-
 src/openvpn/ovpn-dco-win.h                    | 108 +++++
 src/openvpn/socket.c                          | 105 ++++-
 src/openvpn/socket.h                          |  20 +-
 src/openvpn/tun.c                             |  43 +-
 src/openvpn/tun.h                             |  56 ++-
 27 files changed, 938 insertions(+), 76 deletions(-)
 create mode 100644 src/compat/compat-dco_get_overlapped_result.c
 create mode 100644 src/openvpn/dco_win.c
 create mode 100644 src/openvpn/dco_win.h
 create mode 100644 src/openvpn/ovpn-dco-win.h

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index fa99e12b..579bbb5d 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -27,11 +27,6 @@ jobs:
     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 libtool automake autoconf man2html unzip
-      - name: Checkout ovpn-dco-win
-        uses: actions/checkout@...2620...
-        with:
-          repository: OpenVPN/ovpn-dco-win
-          path: ovpn-dco-win
       - name: Checkout OpenVPN
         uses: actions/checkout@...2620...
         with:
@@ -119,7 +114,7 @@ jobs:
         run: cp ./tap-windows-9.23.3/include/tap-windows.h ${HOME}/mingw/opt/include/
 
       - name: configure OpenVPN
-        run: PKG_CONFIG_PATH=${HOME}/mingw/opt/lib/pkgconfig DCO_SOURCEDIR=$(realpath ../ovpn-dco-win) LDFLAGS=-L$HOME/mingw/opt/lib CFLAGS=-I$HOME/mingw/opt/include OPENSSL_LIBS="-L${HOME}/opt/lib -lssl -lcrypto" OPENSSL_CFLAGS=-I$HOME/mingw/opt/include PREFIX=$HOME/mingw/opt LZO_CFLAGS=-I$HOME/mingw/opt/include LZO_LIBS="-L${HOME}/mingw/opt/lib -llzo2" ./configure  --host=${CHOST} --disable-lz4 --enable-dco
+        run: PKG_CONFIG_PATH=${HOME}/mingw/opt/lib/pkgconfig LDFLAGS=-L$HOME/mingw/opt/lib CFLAGS=-I$HOME/mingw/opt/include OPENSSL_LIBS="-L${HOME}/opt/lib -lssl -lcrypto" OPENSSL_CFLAGS=-I$HOME/mingw/opt/include PREFIX=$HOME/mingw/opt LZO_CFLAGS=-I$HOME/mingw/opt/include LZO_LIBS="-L${HOME}/mingw/opt/lib -llzo2" ./configure  --host=${CHOST} --disable-lz4 --enable-dco
         working-directory: openvpn
 
       - name: build OpenVPN
diff --git a/README.dco.md b/README.dco.md
index 27c166b9..d3599727 100644
--- a/README.dco.md
+++ b/README.dco.md
@@ -58,6 +58,13 @@ see a message like
 in your log.
 
 
+Getting started (Windows)
+-------------------------
+Getting started under windows is currently for brave people having experience
+with windows development. You need to compile openvpn yourself and also need 
+to get the test driver installed on your system.
+
+
 DCO and P2P mode
 ----------------
 DCO is also available when running OpenVPN in P2P mode without --pull/--client option.
@@ -109,6 +116,8 @@ Limitations by design
 - topology subnet is the only supported `--topology` for servers
 - iroute directives install routes on the host operating system, see also
   routing with ovpn-dco
+- (ovpn-dco-win) client and p2p mode only
+- (ovpn-dco-win) only AES-GCM-128/192/256 cipher support
 
 
 Current implementation limitations
diff --git a/config-msvc.h b/config-msvc.h
index b08beb52..b621f3fb 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -87,3 +87,5 @@ typedef uint16_t in_port_t;
 #ifdef HAVE_CONFIG_MSVC_LOCAL_H
 #include <config-msvc-local.h>
 #endif
+
+#define ENABLE_DCO 1
diff --git a/configure.ac b/configure.ac
index fa00abb5..7199483a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -144,7 +144,7 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[dco],
-	[AS_HELP_STRING([--enable-dco], [enable data channel offload support using ovpn-dco kernel module @<:@default=no@:>@])],
+	[AS_HELP_STRING([--enable-dco], [enable data channel offload support using the ovpn-dco kernel module (always enabled on Windows) @<:@default=no@:>@])],
 	,
 	[enable_dco="no"]
 )
@@ -328,6 +328,7 @@ case "$host" in
 		;;
 	*-mingw*)
 		AC_DEFINE([TARGET_WIN32], [1], [Are we running WIN32?])
+		AC_DEFINE([ENABLE_DCO], [1], [DCO is always enabled on Windows])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["W"], [Target prefix])
 		CPPFLAGS="${CPPFLAGS} -DWIN32_LEAN_AND_MEAN"
 		CPPFLAGS="${CPPFLAGS} -DNTDDI_VERSION=NTDDI_VISTA -D_WIN32_WINNT=_WIN32_WINNT_VISTA"
@@ -773,18 +774,24 @@ if test "$enable_dco" = "yes"; then
 dnl
 dnl Include generic netlink library used to talk to ovpn-dco
 dnl
+	case "$host" in
+		*-*-linux*)
+			PKG_CHECK_MODULES([LIBNL_GENL],
+					  [libnl-genl-3.0 >= 3.2.29],
+					  [have_libnl="yes"],
+					  [AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config installed? Must be version 3.4.0 or newer])]
+			)
 
-	PKG_CHECK_MODULES([LIBNL_GENL],
-			  [libnl-genl-3.0 >= 3.2.29],
-			  [have_libnl="yes"],
-			  [AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config installed? Must be version 3.4.0 or newer])]
-	)
-
-	CFLAGS="${CFLAGS} ${LIBNL_GENL_CFLAGS}"
-	LIBS="${LIBS} ${LIBNL_GENL_LIBS}"
+			CFLAGS="${CFLAGS} ${LIBNL_GENL_CFLAGS}"
+			LIBS="${LIBS} ${LIBNL_GENL_LIBS}"
+			AC_DEFINE(ENABLE_DCO, 1, [Enable data channel offload for Linux])
+			AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
+		;;
 
-	AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
-	AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
+		*-mingw*)
+			AC_MSG_NOTICE([NOTE: --enable-dco ignored on Windows because it's always enabled])
+		;;
+	esac
 fi
 
 if test "${with_crypto_library}" = "openssl"; then
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 6eb991dc..6dba08aa 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -28,4 +28,5 @@ libcompat_la_SOURCES = \
 	compat-gettimeofday.c \
 	compat-daemon.c \
 	compat-strsep.c \
-	compat-versionhelpers.h
+	compat-versionhelpers.h \
+	compat-dco_get_overlapped_result.c
diff --git a/src/compat/compat-dco_get_overlapped_result.c b/src/compat/compat-dco_get_overlapped_result.c
new file mode 100644
index 00000000..4a52dd46
--- /dev/null
+++ b/src/compat/compat-dco_get_overlapped_result.c
@@ -0,0 +1,44 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2021 Lev Stipakov <lev@...515...>
+ *  Copyright (C) 2021 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "compat.h"
+
+#if defined(__MINGW32__) && !defined(__MINGW64__)
+BOOL dco_get_overlapped_result(HANDLE handle, OVERLAPPED* ov, DWORD* transferred, DWORD delay_millisec, BOOL unused)
+{
+    BOOL res = GetOverlappedResult(handle, ov, transferred, FALSE);
+    if ((res == 0) && (GetLastError() == ERROR_IO_INCOMPLETE))
+    {
+        Sleep(delay_millisec);
+    }
+    return res;
+}
+#endif
diff --git a/src/compat/compat.h b/src/compat/compat.h
index 026974a8..274febce 100644
--- a/src/compat/compat.h
+++ b/src/compat/compat.h
@@ -62,4 +62,10 @@ char *strsep(char **stringp, const char *delim);
 
 #endif
 
+#if defined(__MINGW32__) && !defined(__MINGW64__)
+BOOL dco_get_overlapped_result(HANDLE handle, OVERLAPPED* ov, DWORD* transferred, DWORD delay_millisec, BOOL unused);
+#else
+#define dco_get_overlapped_result GetOverlappedResultEx
+#endif
+
 #endif /* COMPAT_H */
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index fe03a51a..1dacb503 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -159,6 +159,7 @@
   </ItemDefinitionGroup>
   <ItemGroup>
     <ClCompile Include="compat-basename.c" />
+    <ClCompile Include="compat-dco_get_overlapped_result.c" />
     <ClCompile Include="compat-dirname.c" />
     <ClCompile Include="compat-gettimeofday.c" />
     <ClCompile Include="compat-daemon.c" />
diff --git a/src/compat/compat.vcxproj.filters b/src/compat/compat.vcxproj.filters
index 96ca026a..73fc9f91 100644
--- a/src/compat/compat.vcxproj.filters
+++ b/src/compat/compat.vcxproj.filters
@@ -30,6 +30,9 @@
     <ClCompile Include="compat-strsep.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="compat-dco_get_overlapped_result.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="compat.h">
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index af801b1d..2c7c95f9 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -55,6 +55,7 @@ openvpn_SOURCES = \
 	crypto_mbedtls.c crypto_mbedtls.h \
 	dco.c dco.h dco_internal.h \
 	dco_linux.c dco_linux.h \
+	dco_win.c dco_win.h \
 	dhcp.c dhcp.h \
 	dns.c dns.h \
 	env_set.c env_set.h \
@@ -149,5 +150,5 @@ openvpn_LDADD = \
 	$(OPTIONAL_INOTIFY_LIBS)
 if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h ring_buffer.h
-openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi
+openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi -lbcrypt
 endif
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 8d4970e2..263633a6 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -422,6 +422,25 @@ dco_check_option_conflict_ce(const struct connection_entry *ce, int msglevel)
     return false;
 }
 
+static bool
+dco_check_option_conflict_platform(int msglevel, const struct options *o)
+{
+#if defined(_WIN32)
+    if (o->mode == MODE_SERVER)
+    {
+        msg(msglevel, "Only client and p2p data channel offload is supported "
+                      "with ovpn-dco-win.");
+        return true;
+    }
+    if (o->persist_tun)
+    {
+        msg(msglevel, "--persist-tun is not supported with ovpn-dco-win.");
+        return true;
+    }
+#endif
+    return false;
+}
+
 bool
 dco_check_option_conflict(int msglevel, const struct options *o)
 {
@@ -436,6 +455,11 @@ dco_check_option_conflict(int msglevel, const struct options *o)
         return true;
     }
 
+    if (dco_check_option_conflict_platform(msglevel, o))
+    {
+        return true;
+    }
+
     if (dev_type_enum(o->dev, o->dev_type) != DEV_TYPE_TUN)
     {
         msg(msglevel, "Note: dev-type not tun, disabling data channel offload.");
@@ -444,7 +468,7 @@ dco_check_option_conflict(int msglevel, const struct options *o)
 
     /* At this point the ciphers have already been normalised */
     if (o->enable_ncp_fallback
-        && !tls_item_in_cipher_list(o->ciphername, DCO_SUPPORTED_CIPHERS))
+        && !tls_item_in_cipher_list(o->ciphername, dco_get_supported_ciphers()))
     {
         msg(msglevel, "Note: --data-cipher-fallback with cipher '%s' "
                       "disables data channel offload.", o->ciphername);
@@ -498,7 +522,7 @@ dco_check_option_conflict(int msglevel, const struct options *o)
     const char *token;
     while ((token = strsep(&tmp_ciphers, ":")))
     {
-        if (!tls_item_in_cipher_list(token, DCO_SUPPORTED_CIPHERS))
+        if (!tls_item_in_cipher_list(token, dco_get_supported_ciphers()))
         {
             msg(msglevel, "Note: cipher '%s' in --data-ciphers is not supported "
                 "by ovpn-dco, disabling data channel offload.", token);
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 5734e760..afa3ea23 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -180,6 +180,11 @@ void dco_update_keys(dco_context_t *dco, struct tls_multi *multi);
  */
 bool dco_available(int msglevel);
 
+/**
+ * Returns list of colon-separated ciphers supported by platform
+ */
+const char *dco_get_supported_ciphers();
+
 /**
  * Installs a DCO in the main event loop
  */
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index 0737a607..821aae49 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -28,6 +28,7 @@
 #if defined(ENABLE_DCO)
 
 #include "dco_linux.h"
+#include "dco_win.h"
 
 /**
  * This file contains the internal DCO API definition.
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 739f981f..790b329c 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -879,4 +879,10 @@ dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
     }
 }
 
+const char *
+dco_get_supported_ciphers()
+{
+    return "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305";
+}
+
 #endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 0a02adfa..276850ce 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -36,7 +36,6 @@ typedef enum ovpn_cipher_alg dco_cipher_t;
 
 #define DCO_IROUTE_METRIC   100
 #define DCO_DEFAULT_METRIC  200
-#define DCO_SUPPORTED_CIPHERS "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305"
 
 typedef struct
 {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
new file mode 100644
index 00000000..56ae15ff
--- /dev/null
+++ b/src/openvpn/dco_win.c
@@ -0,0 +1,397 @@
+/*
+ *  Interface to ovpn-win-dco networking code
+ *
+ *  Copyright (C) 2020 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#if defined(_WIN32)
+
+#include "syshead.h"
+
+#include "dco.h"
+#include "tun.h"
+#include "crypto.h"
+#include "ssl_common.h"
+
+#include <bcrypt.h>
+#include <winsock2.h>
+#include <ws2tcpip.h>
+
+#if defined(__MINGW32__)
+const IN_ADDR in4addr_any = { 0 };
+#endif
+
+static struct tuntap
+create_dco_handle(const char *devname, struct gc_arena *gc)
+{
+    struct tuntap tt = { .windows_driver = WINDOWS_DRIVER_WINDCO };
+    const char *device_guid;
+
+    tun_open_device(&tt, devname, &device_guid, gc);
+
+    return tt;
+}
+
+bool
+ovpn_dco_init(int mode, dco_context_t *dco)
+{
+    return true;
+}
+
+int
+open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
+{
+    ASSERT(0);
+    return 0;
+}
+
+static void
+dco_wait_ready(DWORD idx)
+{
+    for (int i = 0; i < 20; ++i)
+    {
+        MIB_IPINTERFACE_ROW row = {.InterfaceIndex = idx, .Family = AF_INET};
+        if (GetIpInterfaceEntry(&row) != ERROR_NOT_FOUND)
+        {
+            break;
+        }
+        msg(D_DCO_DEBUG, "interface %ld not yet ready, retrying", idx);
+        Sleep(50);
+    }
+}
+
+void
+dco_start_tun(struct tuntap *tt)
+{
+    msg(D_DCO_DEBUG, "%s", __func__);
+
+    /* reference the tt object inside the DCO context, because the latter will
+     * be passed around
+     */
+    tt->dco.tt = tt;
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_START_VPN, NULL, 0, NULL, 0,
+        &bytes_returned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_START_VPN) failed with code %lu",
+            GetLastError());
+    }
+
+    /* Sometimes IP Helper API, which we use for setting IP address etc,
+     * complains that interface is not found. Give it some time to settle
+     */
+    dco_wait_ready(tt->adapter_index);
+}
+
+static int
+dco_connect_wait(HANDLE handle, OVERLAPPED* ov, int timeout, volatile int* signal_received)
+{
+    DWORD timeout_msec = timeout * 1000;
+    const int poll_interval_ms = 50;
+
+    while (timeout_msec > 0)
+    {
+        timeout_msec -= poll_interval_ms;
+
+        DWORD transferred;
+        if (dco_get_overlapped_result(handle, ov, &transferred, poll_interval_ms, FALSE) != 0)
+        {
+            /* TCP connection established by dco */
+            return 0;
+        }
+
+        DWORD err = GetLastError();
+        if ((err != WAIT_TIMEOUT) && (err != ERROR_IO_INCOMPLETE))
+        {
+            /* dco reported connection error */
+            struct gc_arena gc = gc_new();
+            msg(M_NONFATAL, "%s: %s", __func__, strerror_win32(err, &gc));
+            *signal_received = SIGUSR1;
+            gc_free(&gc);
+            return -1;
+        }
+
+        get_signal(signal_received);
+        if (*signal_received)
+        {
+            return -1;
+        }
+
+        management_sleep(0);
+    }
+
+    /* we end up here when timeout occurs in userspace */
+    msg(M_NONFATAL, "%s: dco connect timeout", __func__);
+    *signal_received = SIGUSR1;
+
+    return -1;
+}
+
+struct tuntap
+dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,
+                  struct addrinfo *bind, const char* devname,
+                  struct gc_arena *gc, int timeout, volatile int* signal_received)
+{
+    msg(D_DCO_DEBUG, "%s", __func__);
+
+    OVPN_NEW_PEER peer = { 0 };
+
+    struct sockaddr *local = NULL;
+    struct sockaddr *remote = remoteaddr->ai_addr;
+
+    if (remoteaddr->ai_protocol == IPPROTO_TCP
+        || remoteaddr->ai_socktype == SOCK_STREAM)
+    {
+        peer.Proto = OVPN_PROTO_TCP;
+    }
+    else
+    {
+        peer.Proto = OVPN_PROTO_UDP;
+    }
+
+    if (bind_local)
+    {
+        /* Use first local address with correct address family */
+        while(bind && !local)
+        {
+            if (bind->ai_family == remote->sa_family)
+            {
+                local = bind->ai_addr;
+            }
+            bind = bind->ai_next;
+        }
+    }
+
+    if (bind_local && !local)
+    {
+        msg(M_FATAL, "DCO: Socket bind failed: Address to bind lacks %s record",
+           addr_family_name(remote->sa_family));
+    }
+
+    if (remote->sa_family == AF_INET6)
+    {
+        peer.Remote.Addr6 = *((SOCKADDR_IN6 *)(remoteaddr->ai_addr));
+        if (local)
+        {
+            peer.Local.Addr6 = *((SOCKADDR_IN6 *)local);
+        }
+        else
+        {
+            peer.Local.Addr6.sin6_addr = in6addr_any;
+            peer.Local.Addr6.sin6_port = 0;
+            peer.Local.Addr6.sin6_family = AF_INET6;
+        }
+    }
+    else if (remote->sa_family == AF_INET)
+    {
+        peer.Remote.Addr4 = *((SOCKADDR_IN *)(remoteaddr->ai_addr));
+        if (local)
+        {
+            peer.Local.Addr4 = *((SOCKADDR_IN *)local);
+        }
+        else
+        {
+            peer.Local.Addr4.sin_addr = in4addr_any;
+            peer.Local.Addr4.sin_port = 0;
+            peer.Local.Addr4.sin_family = AF_INET;
+        }
+    }
+    else
+    {
+        ASSERT(0);
+    }
+
+    struct tuntap tt = create_dco_handle(devname, gc);
+
+    OVERLAPPED ov = { 0 };
+    if (!DeviceIoControl(tt.hand, OVPN_IOCTL_NEW_PEER, &peer, sizeof(peer), NULL, 0, NULL, &ov))
+    {
+        DWORD err = GetLastError();
+        if (err != ERROR_IO_PENDING)
+        {
+            msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_PEER) failed with code %lu", err);
+        }
+        else
+        {
+            if (dco_connect_wait(tt.hand, &ov, timeout, signal_received))
+            {
+                close_tun_handle(&tt);
+            }
+        }
+    }
+    return tt;
+}
+
+int dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
+                 struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+                 struct in_addr *remote_in4, struct in6_addr *remote_in6)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
+    return 0;
+}
+
+int dco_del_peer(dco_context_t *dco, unsigned int peerid)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d - not implemented", __func__, peerid);
+    return 0;
+}
+
+int dco_set_peer(dco_context_t *dco, unsigned int peerid,
+                 int keepalive_interval, int keepalive_timeout, int mss)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d, mss %d", __func__,
+        peerid, keepalive_interval, keepalive_timeout, mss);
+
+    OVPN_SET_PEER peer;
+
+    peer.KeepaliveInterval =  keepalive_interval;
+    peer.KeepaliveTimeout = keepalive_timeout;
+    peer.MSS = mss;
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_SET_PEER, &peer,
+                         sizeof(peer), NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_WARN, "DeviceIoControl(OVPN_IOCTL_SET_PEER) failed with code %lu", GetLastError());
+        return -1;
+    }
+    return 0;
+}
+
+int
+dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid,
+            dco_key_slot_t slot,
+            const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
+            const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
+            const char *ciphername)
+{
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s",
+       __func__, slot, keyid, peerid, ciphername);
+
+    const int nonce_len = 8;
+    size_t key_len = cipher_kt_key_size(ciphername);
+
+    OVPN_CRYPTO_DATA crypto_data;
+    ZeroMemory(&crypto_data, sizeof(crypto_data));
+
+    crypto_data.CipherAlg = dco_get_cipher(ciphername);
+    crypto_data.KeyId = keyid;
+    crypto_data.PeerId = peerid;
+    crypto_data.KeySlot = slot;
+
+    CopyMemory(crypto_data.Encrypt.Key, encrypt_key, key_len);
+    crypto_data.Encrypt.KeyLen = (char)key_len;
+    CopyMemory(crypto_data.Encrypt.NonceTail, encrypt_iv, nonce_len);
+
+    CopyMemory(crypto_data.Decrypt.Key, decrypt_key, key_len);
+    crypto_data.Decrypt.KeyLen = (char)key_len;
+    CopyMemory(crypto_data.Decrypt.NonceTail, decrypt_iv, nonce_len);
+
+    ASSERT(crypto_data.CipherAlg > 0);
+
+    DWORD bytes_returned = 0;
+
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_NEW_KEY, &crypto_data,
+                         sizeof(crypto_data), NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed with code %lu",
+            GetLastError());
+        return -1;
+    }
+    return 0;
+}
+int
+dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)
+{
+    msg(D_DCO, "%s: peer-id %d, slot %d called but ignored", __func__, peerid,
+        slot);
+    /* FIXME: Implement in driver first */
+    return 0;
+}
+
+int dco_swap_keys(dco_context_t *dco, unsigned int peer_id)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_SWAP_KEYS, NULL, 0, NULL, 0,
+                         &bytes_returned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_SWAP_KEYS) failed with code %lu",
+            GetLastError());
+        return -1;
+    }
+    return 0;
+}
+
+bool
+dco_available(int msglevel)
+{
+    return true;
+}
+
+int
+dco_do_read(dco_context_t *dco)
+{
+    /* no-op on windows */
+    return 0;
+}
+
+int
+dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
+{
+    /* no-op on windows */
+    return 0;
+}
+
+void
+dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
+{
+    /* no-op on windows */
+}
+
+const char *
+dco_get_supported_ciphers()
+{
+    /*
+     * this API can be called either from user mode or kernel mode,
+     * which enables us to probe driver's chachapoly support
+     * (available starting from Windows 11)
+     */
+
+    BCRYPT_ALG_HANDLE h;
+    NTSTATUS status = BCryptOpenAlgorithmProvider(&h, L"CHACHA20_POLY1305", NULL, 0);
+    if (BCRYPT_SUCCESS(status))
+    {
+        BCryptCloseAlgorithmProvider(h, 0);
+        return "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305";
+    }
+    else
+    {
+        return "AES-128-GCM:AES-256-GCM:AES-192-GCM";
+    }
+}
+
+#endif /* defined(_WIN32) */
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
new file mode 100644
index 00000000..aaaa509f
--- /dev/null
+++ b/src/openvpn/dco_win.h
@@ -0,0 +1,57 @@
+/*
+ *  Interface to ovpn-win-dco networking code
+ *
+ *  Copyright (C) 2020-2022 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2022 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef DCO_WIN_H
+#define DCO_WIN_H
+
+#if defined(ENABLE_DCO) && defined(_WIN32)
+
+#include "buffer.h"
+#include "ovpn-dco-win.h"
+
+typedef OVPN_KEY_SLOT dco_key_slot_t;
+typedef OVPN_CIPHER_ALG dco_cipher_t;
+
+struct dco_context {
+    bool real_tun_init;
+    struct tuntap *tt;
+};
+
+typedef struct dco_context dco_context_t;
+
+struct tuntap
+dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,
+                  struct addrinfo *bind, const char *devname,
+                  struct gc_arena *gc, int timeout,
+                  volatile int *signal_received);
+
+void
+dco_start_tun(struct tuntap *tt);
+
+#else
+
+static inline void dco_start_tun(struct tuntap *tt)
+{
+    ASSERT(false);
+}
+
+#endif /* defined(_WIN32) */
+#endif /* ifndef DCO_H */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b3e86078..8818ba6f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1667,7 +1667,8 @@ do_init_tun(struct context *c)
                             c->c1.link_socket_addr.remote_list,
                             !c->options.ifconfig_nowarn,
                             c->c2.es,
-                            &c->net_ctx);
+                            &c->net_ctx,
+                            c->c1.tuntap);
 
 #ifdef _WIN32
     c->c1.tuntap->windows_driver = c->options.windows_driver;
@@ -1691,7 +1692,11 @@ do_open_tun(struct context *c)
     bool ret = false;
 
 #ifndef TARGET_ANDROID
-    if (!c->c1.tuntap)
+    if (!c->c1.tuntap
+#ifdef _WIN32
+        || (c->c1.tuntap && !c->c1.tuntap->dco.real_tun_init)
+#endif
+        )
     {
 #endif
 
@@ -1782,9 +1787,12 @@ do_open_tun(struct context *c)
         ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
     }
 
-    /* open the tun device */
-    open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
-             c->c1.tuntap, &c->net_ctx);
+    /* open the tun device. ovpn-dco-win already opend the device for the socket */
+    if (!is_windco(c->c1.tuntap))
+    {
+        open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
+                 c->c1.tuntap, &c->net_ctx);
+    }
 
     /* set the hardware address */
     if (c->options.lladdr)
@@ -3514,6 +3522,22 @@ do_close_free_key_schedule(struct context *c, bool free_ssl_ctx)
 static void
 do_close_link_socket(struct context *c)
 {
+#ifdef _WIN32
+    if (c->c2.link_socket && c->c2.link_socket->info.dco_installed && is_windco(c->c1.tuntap))
+    {
+        ASSERT(c->c2.link_socket_owned);
+        ASSERT(c->c1.tuntap);
+
+        /* We rely on the tun close to the handle if also setup
+         * routes etc, since they cannot be delete when the interface
+         * handle has been closed */
+        if (true && !c->c1.tuntap->dco.real_tun_init)
+        {
+            do_close_tun_simple(c);
+        }
+        c->c2.link_socket->sd = SOCKET_UNDEFINED;
+    }
+#endif
     if (c->c2.link_socket && c->c2.link_socket_owned)
     {
         link_socket_close(c->c2.link_socket);
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index fb5bc80a..e185777e 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -268,6 +268,7 @@
     <ClCompile Include="crypto_openssl.c" />
     <ClCompile Include="cryptoapi.c" />
     <ClCompile Include="dco.c" />
+    <ClCompile Include="dco_win.c" />
     <ClCompile Include="dhcp.c" />
     <ClCompile Include="dns.c" />
     <ClCompile Include="env_set.c" />
@@ -354,6 +355,7 @@
     <ClInclude Include="crypto_openssl.h" />
     <ClInclude Include="cryptoapi.h" />
     <ClInclude Include="dco.h" />
+    <ClInclude Include="dco_win.h" />
     <ClInclude Include="dhcp.h" />
     <ClInclude Include="dns.h" />
     <ClInclude Include="env_set.h" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index 303811fe..80aec501 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -258,6 +258,9 @@
     <ClCompile Include="xkey_provider.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="dco_win.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="base64.h">
@@ -386,6 +389,9 @@
     <ClInclude Include="multi.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="networking_windco.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
     <ClInclude Include="ntlm.h">
       <Filter>Header Files</Filter>
     </ClInclude>
@@ -536,6 +542,9 @@
     <ClInclude Include="xkey_common.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="dco_win.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpn_win32_resources.rc">
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9567d3b8..57b8fac2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2338,6 +2338,11 @@ options_postprocess_verify_ce(const struct options *options,
     {
         msg(M_USAGE, "--windows-driver wintun requires --dev tun");
     }
+
+    if (options->windows_driver == WINDOWS_DRIVER_WINDCO)
+    {
+        dco_check_option_conflict(M_USAGE, options);
+    }
 #endif /* ifdef _WIN32 */
 
     /*
@@ -3108,8 +3113,8 @@ options_postprocess_mutate_invariant(struct options *options)
 #ifdef _WIN32
     const int dev = dev_type_enum(options->dev, options->dev_type);
 
-    /* when using wintun, kernel doesn't send DHCP requests, so don't use it */
-    if (options->windows_driver == WINDOWS_DRIVER_WINTUN
+    /* when using wintun/ovpn-dco-win, kernel doesn't send DHCP requests, so don't use it */
+    if ((options->windows_driver == WINDOWS_DRIVER_WINTUN || options->windows_driver == WINDOWS_DRIVER_WINDCO)
         && (options->tuntap_options.ip_win32_type == IPW32_SET_DHCP_MASQ || options->tuntap_options.ip_win32_type == IPW32_SET_ADAPTIVE))
     {
         options->tuntap_options.ip_win32_type = IPW32_SET_NETSH;
@@ -3205,10 +3210,12 @@ options_postprocess_setdefault_ncpciphers(struct options *o)
         /* custom --data-ciphers set, keep list */
         return;
     }
+#if !defined(_WIN32)
     else if (cipher_valid("CHACHA20-POLY1305"))
     {
         o->ncp_ciphers = "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
     }
+#endif
     else
     {
         o->ncp_ciphers = "AES-256-GCM:AES-128-GCM";
@@ -4033,7 +4040,8 @@ options_string(const struct options *o,
                       NULL,
                       false,
                       NULL,
-                      ctx);
+                      ctx,
+                      NULL);
         if (tt)
         {
             tt_local = true;
@@ -4458,9 +4466,15 @@ parse_windows_driver(const char *str, const int msglevel)
     {
         return WINDOWS_DRIVER_WINTUN;
     }
+
+    else if (streq(str, "ovpn-dco-win"))
+    {
+        return WINDOWS_DRIVER_WINDCO;
+    }
     else
     {
-        msg(msglevel, "--windows-driver must be tap-windows6 or wintun");
+        msg(msglevel, "--windows-driver must be tap-windows6, wintun "
+                      "or ovpn-dco-win");
         return WINDOWS_DRIVER_UNSPECIFIED;
     }
 }
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index a0619597..22208f8f 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -876,24 +876,19 @@ void options_string_import(struct options *options,
 
 bool key_is_external(const struct options *options);
 
-#if defined(ENABLE_DCO)
-
 /**
  * Returns whether the current configuration has dco enabled.
  */
 static inline bool
 dco_enabled(const struct options *o)
 {
+#if defined(_WIN32)
+    return o->windows_driver == WINDOWS_DRIVER_WINDCO;
+#elif defined(ENABLE_DCO)
     return !o->tuntap_options.disable_dco;
-}
-
 #else
-
-static inline bool
-dco_enabled(const struct options *o)
-{
     return false;
+#endif /* defined(_WIN32) */
 }
 
-#endif
 #endif /* ifndef OPTIONS_H */
diff --git a/src/openvpn/ovpn-dco-win.h b/src/openvpn/ovpn-dco-win.h
new file mode 100644
index 00000000..1ebd51a7
--- /dev/null
+++ b/src/openvpn/ovpn-dco-win.h
@@ -0,0 +1,108 @@
+/*
+ *  ovpn-dco-win OpenVPN protocol accelerator for Windows
+ *
+ *  Copyright (C) 2020-2021 OpenVPN Inc <sales@...515...>
+ *
+ *  Author:	Lev Stipakov <lev@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This particular file (uapi.h) is also licensed using the MIT license (see COPYRIGHT.MIT).
+ */
+
+#pragma once
+#ifndef _KERNEL_MODE
+#include <winsock2.h>
+#endif
+#include <ws2def.h>
+#include <ws2ipdef.h>
+
+typedef enum {
+	OVPN_PROTO_UDP,
+	OVPN_PROTO_TCP
+} OVPN_PROTO;
+
+typedef struct _OVPN_NEW_PEER {
+	union {
+		SOCKADDR_IN Addr4;
+		SOCKADDR_IN6 Addr6;
+	} Local;
+
+	union {
+		SOCKADDR_IN Addr4;
+		SOCKADDR_IN6 Addr6;
+	} Remote;
+
+	OVPN_PROTO Proto;
+} OVPN_NEW_PEER, * POVPN_NEW_PEER;
+
+typedef struct _OVPN_STATS {
+	LONG LostInControlPackets;
+	LONG LostOutControlPackets;
+
+	LONG LostInDataPackets;
+	LONG LostOutDataPackets;
+
+	LONG ReceivedDataPackets;
+	LONG ReceivedControlPackets;
+
+	LONG SentControlPackets;
+	LONG SentDataPackets;
+
+	LONG64 TransportBytesSent;
+	LONG64 TransportBytesReceived;
+
+	LONG64 TunBytesSent;
+	LONG64 TunBytesReceived;
+} OVPN_STATS, * POVPN_STATS;
+
+typedef enum _OVPN_KEY_SLOT {
+	OVPN_KEY_SLOT_PRIMARY,
+	OVPN_KEY_SLOT_SECONDARY
+} OVPN_KEY_SLOT;
+
+typedef enum _OVPN_CIPHER_ALG {
+	OVPN_CIPHER_ALG_NONE,
+	OVPN_CIPHER_ALG_AES_GCM,
+	OVPN_CIPHER_ALG_CHACHA20_POLY1305
+} OVPN_CIPHER_ALG;
+
+typedef struct _OVPN_KEY_DIRECTION
+{
+	unsigned char Key[32];
+	unsigned char KeyLen; // 16/24/32 -> AES-128-GCM/AES-192-GCM/AES-256-GCM
+	unsigned char NonceTail[8];
+} OVPN_KEY_DIRECTION;
+
+typedef struct _OVPN_CRYPTO_DATA {
+	OVPN_KEY_DIRECTION Encrypt;
+	OVPN_KEY_DIRECTION Decrypt;
+	OVPN_KEY_SLOT KeySlot;
+	OVPN_CIPHER_ALG CipherAlg;
+	unsigned char KeyId;
+	int PeerId;
+} OVPN_CRYPTO_DATA, * POVPN_CRYPTO_DATA;
+
+typedef struct _OVPN_SET_PEER {
+	LONG KeepaliveInterval;
+	LONG KeepaliveTimeout;
+	LONG MSS;
+} OVPN_SET_PEER, * POVPN_SET_PEER;
+
+#define OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_SWAP_KEYS    CTL_CODE(FILE_DEVICE_UNKNOWN, 4, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_SET_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 5, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN, 6, METHOD_BUFFERED, FILE_ANY_ACCESS)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index bec9308f..5cad4991 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2119,6 +2119,38 @@ phase2_socks_client(struct link_socket *sock, struct signal_info *sig_info)
     resolve_remote(sock, 1, NULL, &sig_info->signal_received);
 }
 
+#if defined(_WIN32)
+static void
+create_socket_windco(struct context* c, struct link_socket* sock,
+                     volatile int *signal_received)
+{
+    struct tuntap* tt;
+    /* In this case persist-tun is enabled, which we don't support yet */
+    ASSERT(!c->c1.tuntap);
+
+    ALLOC_OBJ(tt, struct tuntap);
+
+    *tt = dco_create_socket(sock->info.lsa->current_remote,
+                            sock->bind_local,
+                            sock->info.lsa->bind_local,
+                            c->options.dev_node,
+                            &c->gc,
+                            get_server_poll_remaining_time(sock->server_poll_timeout),
+                            signal_received);
+    if (*signal_received)
+    {
+        return;
+    }
+
+    c->c1.tuntap = tt;
+    sock->info.dco_installed = true;
+
+    /* Ensure we can "safely" cast the handle to a socket */
+    static_assert(sizeof(sock->sd) == sizeof(tt->hand), "HANDLE and SOCKET size differs");
+    sock->sd = (SOCKET)tt->hand;
+}
+#endif
+
 /* finalize socket initialization */
 void
 link_socket_init_phase2(struct context *c)
@@ -2158,7 +2190,24 @@ link_socket_init_phase2(struct context *c)
     /* If a valid remote has been found, create the socket with its addrinfo */
     if (sock->info.lsa->current_remote)
     {
-        create_socket(sock, sock->info.lsa->current_remote);
+#if defined(_WIN32)
+        if (dco_enabled(&c->options))
+        {
+            create_socket_windco(c, sock, &sig_info->signal_received);
+            if (sig_info->signal_received)
+            {
+                goto done;
+            }
+
+            linksock_print_addr(sock);
+            goto done;
+        }
+        else
+#endif
+        {
+            create_socket(sock, sock->info.lsa->current_remote);
+        }
+
     }
 
     /* If socket has not already been created create it now */
@@ -2221,6 +2270,7 @@ link_socket_init_phase2(struct context *c)
     }
 
     phase2_set_socket_flags(sock);
+
     linksock_print_addr(sock);
 
 done:
@@ -3459,7 +3509,19 @@ socket_recv_queue(struct link_socket *sock, int maxsize)
         ASSERT(ResetEvent(sock->reads.overlapped.hEvent));
         sock->reads.flags = 0;
 
-        if (proto_is_udp(sock->info.proto))
+        if (sock->info.dco_installed)
+        {
+            status = ReadFile(
+                    (HANDLE) sock->sd,
+                wsabuf[0].buf,
+                wsabuf[0].len,
+                &sock->reads.size,
+                &sock->reads.overlapped
+            );
+            /* Readfile status is inverted from WSARecv */
+            status = !status;
+        }
+        else if (proto_is_udp(sock->info.proto))
         {
             sock->reads.addr_defined = true;
             sock->reads.addrlen = sizeof(sock->reads.addr6);
@@ -3512,7 +3574,14 @@ socket_recv_queue(struct link_socket *sock, int maxsize)
         }
         else
         {
-            status = WSAGetLastError();
+            if (sock->info.dco_installed)
+            {
+                status = GetLastError();
+            }
+            else
+            {
+                status = WSAGetLastError();
+            }
             if (status == WSA_IO_PENDING) /* operation queued? */
             {
                 sock->reads.iostate = IOSTATE_QUEUED;
@@ -3557,7 +3626,21 @@ socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct lin
         ASSERT(ResetEvent(sock->writes.overlapped.hEvent));
         sock->writes.flags = 0;
 
-        if (proto_is_udp(sock->info.proto))
+        if (sock->info.dco_installed)
+        {
+            status = WriteFile(
+                    (HANDLE)sock->sd,
+                    wsabuf[0].buf,
+                    wsabuf[0].len,
+                    &sock->writes.size,
+                    &sock->writes.overlapped
+            );
+
+            /* WriteFile status is inverted from WSASendTo */
+            status = !status;
+
+        }
+        else if (proto_is_udp(sock->info.proto))
         {
             /* set destination address for UDP writes */
             sock->writes.addr_defined = true;
@@ -3618,8 +3701,17 @@ socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct lin
         }
         else
         {
-            status = WSAGetLastError();
-            if (status == WSA_IO_PENDING) /* operation queued? */
+            if (sock->info.dco_installed)
+            {
+                status = GetLastError();
+            }
+            else
+            {
+                status = WSAGetLastError();
+            }
+
+            /* both status code have the identical value */
+            if (status == WSA_IO_PENDING || status == ERROR_IO_PENDING) /* operation queued? */
             {
                 sock->writes.iostate = IOSTATE_QUEUED;
                 sock->writes.status = status;
@@ -3644,6 +3736,7 @@ socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct lin
     return sock->writes.iostate;
 }
 
+/* Returns the nubmer of bytes successfully read */
 int
 sockethandle_finalize(sockethandle_t sh,
                       struct overlapped_io *io,
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index ccb71042..84b9d0ca 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -34,6 +34,7 @@
 #include "proxy.h"
 #include "socks.h"
 #include "misc.h"
+#include "tun.h"
 
 /*
  * OpenVPN's default port number as assigned by IANA.
@@ -1048,6 +1049,11 @@ link_socket_read_udp_win32(struct link_socket *sock,
                            struct link_socket_actual *from)
 {
     sockethandle_t sh = { .s = sock->sd };
+    if (sock->info.dco_installed)
+    {
+        addr_copy_sa(&from->dest, &sock->info.lsa->actual.dest);
+        sh.is_handle = true;
+    }
     return sockethandle_finalize(sh, &sock->reads, buf, from);
 }
 
@@ -1065,7 +1071,10 @@ link_socket_read(struct link_socket *sock,
                  struct buffer *buf,
                  struct link_socket_actual *from)
 {
-    if (proto_is_udp(sock->info.proto)) /* unified UDPv4 and UDPv6 */
+    if (proto_is_udp(sock->info.proto)
+        || sock->info.dco_installed)
+        /* unified UDPv4 and UDPv6, for DCO the kernel
+         * will strip the length header */
     {
         int res;
 
@@ -1106,19 +1115,19 @@ link_socket_write_win32(struct link_socket *sock,
 {
     int err = 0;
     int status = 0;
-    sockethandle_t sh = { .s = sock->sd };
+    sockethandle_t sh = { .s = sock->sd, .is_handle = sock->info.dco_installed };
     if (overlapped_io_active(&sock->writes))
     {
         status = sockethandle_finalize(sh, &sock->writes, NULL, NULL);
         if (status < 0)
         {
-            err = WSAGetLastError();
+            err = SocketHandleGetLastError(sh);
         }
     }
     socket_send_queue(sock, buf, to);
     if (status < 0)
     {
-        WSASetLastError(err);
+        SocketHandleSetLastError(sh, err);
         return status;
     }
     else
@@ -1180,8 +1189,9 @@ link_socket_write(struct link_socket *sock,
                   struct buffer *buf,
                   struct link_socket_actual *to)
 {
-    if (proto_is_udp(sock->info.proto)) /* unified UDPv4 and UDPv6 */
+    if (proto_is_udp(sock->info.proto) || sock->info.dco_installed)
     {
+        /* unified UDPv4 and UDPv6 and DCO (kernel adds size header) */
         return link_socket_write_udp(sock, buf, to);
     }
     else if (proto_is_tcp(sock->info.proto)) /* unified TCPv4 and TCPv6 */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 35b1744c..79ddcec1 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -742,13 +742,23 @@ init_tun(const char *dev,        /* --dev option */
          struct addrinfo *remote_public,
          const bool strict_warn,
          struct env_set *es,
-         openvpn_net_ctx_t *ctx)
+         openvpn_net_ctx_t *ctx,
+         struct tuntap *tt)
 {
     struct gc_arena gc = gc_new();
-    struct tuntap *tt;
 
-    ALLOC_OBJ(tt, struct tuntap);
-    clear_tuntap(tt);
+    if (!tt)
+    {
+        ALLOC_OBJ(tt, struct tuntap);
+        clear_tuntap(tt);
+    }
+#if defined(_WIN32)
+    else
+    {
+        ASSERT(!tt->dco.real_tun_init);
+        tt->dco.real_tun_init = true;
+    }
+#endif
 
     tt->type = dev_type_enum(dev, dev_type);
     tt->topology = topology;
@@ -891,6 +901,12 @@ init_tun_post(struct tuntap *tt,
 {
     tt->options = *options;
 #ifdef _WIN32
+    if (tt->windows_driver == WINDOWS_DRIVER_WINDCO)
+    {
+        dco_start_tun(tt);
+        return;
+    }
+
     overlapped_io_init(&tt->reads, frame, FALSE, true);
     overlapped_io_init(&tt->writes, frame, TRUE, true);
     tt->adapter_index = TUN_ADAPTER_INDEX_INVALID;
@@ -3489,6 +3505,9 @@ print_windows_driver(enum windows_driver_type windows_driver)
         case WINDOWS_DRIVER_WINTUN:
             return "wintun";
 
+        case WINDOWS_DRIVER_WINDCO:
+            return "ovpn-dco-win";
+
         default:
             return "unspecified";
     }
@@ -3870,6 +3889,11 @@ get_tap_reg(struct gc_arena *gc)
                     {
                         windows_driver = WINDOWS_DRIVER_WINTUN;
                     }
+                    else if (strcasecmp(component_id, "ovpn-dco") == 0)
+                    {
+                        windows_driver = WINDOWS_DRIVER_WINDCO;
+                    }
+
 
                     if (windows_driver != WINDOWS_DRIVER_UNSPECIFIED)
                     {
@@ -4224,7 +4248,9 @@ at_least_one_tap_win(const struct tap_reg *tap_reg)
 {
     if (!tap_reg)
     {
-        msg(M_FATAL, "There are no TAP-Windows nor Wintun adapters on this system.  You should be able to create an adapter by using tapctl.exe utility.");
+        msg(M_FATAL, "There are no TAP-Windows, Wintun or ovpn-dco-win adapters "
+                     "on this system.  You should be able to create an adapter "
+                     "by using tapctl.exe utility.");
     }
 }
 
@@ -6424,7 +6450,7 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
     const char *path = NULL;
     char tuntap_device_path[256];
 
-    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
+    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN || tt->windows_driver == WINDOWS_DRIVER_WINDCO)
     {
         const struct device_instance_id_interface *dev_if;
 
@@ -6444,7 +6470,7 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
     }
     else
     {
-        /* Open TAP-Windows adapter */
+        /* Open TAP-Windows or dco-win adapter */
         openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
                          USERMODEDEVICEDIR,
                          device_guid,
@@ -6480,7 +6506,7 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
     return true;
 }
 
-static void
+void
 tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_guid, struct gc_arena *gc)
 {
     const struct tap_reg *tap_reg = get_tap_reg(gc);
@@ -6772,7 +6798,6 @@ netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc
     argv_free(&argv);
 }
 
-static
 void close_tun_handle(struct tuntap* tt)
 {
     const char* adaptertype = print_windows_driver(tt->windows_driver);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 8d5ef0cd..fee2c61c 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -48,7 +48,8 @@
 enum windows_driver_type {
     WINDOWS_DRIVER_UNSPECIFIED,
     WINDOWS_DRIVER_TAP_WINDOWS6,
-    WINDOWS_DRIVER_WINTUN
+    WINDOWS_DRIVER_WINTUN,
+    WINDOWS_DRIVER_WINDCO
 };
 #endif
 
@@ -64,6 +65,8 @@ struct tuntap_options {
     /* --ip-win32 options */
     bool ip_win32_defined;
 
+    bool disable_dco;
+
 #define IPW32_SET_MANUAL       0   /* "--ip-win32 manual" */
 #define IPW32_SET_NETSH        1   /* "--ip-win32 netsh" */
 #define IPW32_SET_IPAPI        2   /* "--ip-win32 ipapi" */
@@ -242,6 +245,10 @@ tuntap_ring_empty(struct tuntap *tt)
 {
     return tuntap_is_wintun(tt) && (tt->wintun_send_ring->head == tt->wintun_send_ring->tail);
 }
+
+/* Low level function to open tun handle, used by DCO to create a handle for DCO*/
+void
+tun_open_device(struct tuntap* tt, const char* dev_node, const char** device_guid, struct gc_arena* gc);
 #endif
 
 /*
@@ -253,6 +260,8 @@ void open_tun(const char *dev, const char *dev_type, const char *dev_node,
 
 void close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx);
 
+void close_tun_handle(struct tuntap* tt);
+
 int write_tun(struct tuntap *tt, uint8_t *buf, int len);
 
 int read_tun(struct tuntap *tt, uint8_t *buf, int len);
@@ -279,7 +288,8 @@ struct tuntap *init_tun(const char *dev,        /* --dev option */
                         struct addrinfo *remote_public,
                         const bool strict_warn,
                         struct env_set *es,
-                        openvpn_net_ctx_t *ctx);
+                        openvpn_net_ctx_t *ctx,
+                        struct tuntap *tt);
 
 void init_tun_post(struct tuntap *tt,
                    const struct frame *frame,
@@ -624,6 +634,11 @@ write_tun_buffered(struct tuntap *tt, struct buffer *buf)
     }
 }
 
+static inline bool is_windco(struct tuntap *tt)
+{
+    return tt->windows_driver == WINDOWS_DRIVER_WINDCO;
+}
+
 #else  /* ifdef _WIN32 */
 
 static inline bool
@@ -649,6 +664,12 @@ tun_standby(struct tuntap *tt)
     return true;
 }
 
+
+static inline bool is_windco(struct tuntap *tt)
+{
+    return false;
+}
+
 #endif /* ifdef _WIN32 */
 
 /*
@@ -672,25 +693,28 @@ tun_set(struct tuntap *tt,
         void *arg,
         unsigned int *persistent)
 {
-    if (tuntap_defined(tt))
+    if (!tuntap_defined(tt) || is_windco(tt))
     {
-        /* if persistent is defined, call event_ctl only if rwflags has changed since last call */
-        if (!persistent || *persistent != rwflags)
+        return;
+    }
+
+    /* if persistent is defined, call event_ctl only if rwflags has changed since last call */
+    if (!persistent || *persistent != rwflags)
+    {
+        event_ctl(es, tun_event_handle(tt), rwflags, arg);
+        if (persistent)
         {
-            event_ctl(es, tun_event_handle(tt), rwflags, arg);
-            if (persistent)
-            {
-                *persistent = rwflags;
-            }
+            *persistent = rwflags;
         }
+    }
 #ifdef _WIN32
-        if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6 && (rwflags & EVENT_READ))
-        {
-            tun_read_queue(tt, 0);
-        }
-#endif
-        tt->rwflags_debug = rwflags;
+    if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6 && (rwflags & EVENT_READ))
+    {
+        tun_read_queue(tt, 0);
     }
+#endif
+    tt->rwflags_debug = rwflags;
+
 }
 
 const char *tun_stat(const struct tuntap *tt, unsigned int rwflags, struct gc_arena *gc);
-- 
2.35.1


