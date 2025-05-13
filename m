From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 13 May 2025 15:38:45 +0000
In-Reply-To: <gerrit.1747046041000.I43ec390040bffeec05270271ea7fb54fb219c536@...2715...>
References: <gerrit.1747046041000.I43ec390040bffeec05270271ea7fb54fb219c536@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <1a53c18aa67b0596e7bdd403240b8bf6a42ddd25-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oDYoeUPl/uY="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: win: remove Wintun
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oDYoeUPl/uY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
21?usp=3Demail )

Change subject: win: remove Wintun support
......................................................................

win: remove Wintun support

Since DCO supports modern ciphers and server mode,
there is no reason to support Wintun anymore.

This also removes --windows-driver option support. The
default driver is DCO, as it has been since 2.6. If for
some reasons one doesn't want to use it, --disable-dco
multiplatform option will switch to tap-windows6.

Change-Id: I43ec390040bffeec05270271ea7fb54fb219c536
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250513151006.13617-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
631.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/vpn-network-options.rst
M doc/man-sections/windows-options.rst
M include/openvpn-msg.h
M src/openvpn/Makefile.am
M src/openvpn/dco.c
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/mudp.c
M src/openvpn/multi_io.c
M src/openvpn/options.c
D src/openvpn/ring_buffer.h
M src/openvpn/tun.c
M src/openvpn/tun.h
M src/openvpnmsica/openvpnmsica.c
M src/openvpnmsica/openvpnmsica.h
M src/openvpnserv/CMakeLists.txt
M src/openvpnserv/Makefile.am
M src/openvpnserv/interactive.c
M src/tapctl/main.c
M src/tapctl/tap.h
20 files changed, 27 insertions(+), 801 deletions(-)




diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index 67f7e1f..40b8c19 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -137,8 +137,7 @@
   Set additional network parameters on supported platforms. May be specifi=
ed
   on the client or pushed from the server. On Windows these options are
   handled by the ``tap-windows6`` driver by default or directly by OpenVPN
-  if dhcp is disabled or the ``wintun`` driver is in use. The
-  ``OpenVPN for Android`` client also handles them internally.
+  if dhcp is disabled. The ``OpenVPN for Android`` client also handles the=
m internally.

   On all other platforms these options are only saved in the client's
   environment under the name :code:`foreign_option_{n}` before the
diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/window=
s-options.rst
index 1955869..af2fb45 100644
--- a/doc/man-sections/windows-options.rst
+++ b/doc/man-sections/windows-options.rst
@@ -252,9 +252,3 @@
   otherwise it defaulted to :code:`C:\\WINDOWS`. It is not needed to use
   the ``env`` keyword any more, and it will just be ignored. A warning is
   logged when this is found in the configuration file.
-
---windows-driver drv
-  Specifies which tun driver to use. Values are :code:`ovpn-dco` (default),
-  :code:`tap-windows6` and :code:`wintun`. :code:`ovpn-dco` and :code:`win=
tun`
-  require ``--dev tun``. :code:`wintun` also requires OpenVPN process to r=
un
-  elevated, or be invoked using the Interactive Service.
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 2cf8d40..34b133b 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -44,7 +44,7 @@
     msg_del_wfp_block,
     msg_register_dns,
     msg_enable_dhcp,
-    msg_register_ring_buffers,
+    deprecated_msg_register_ring_buffers,
     msg_set_mtu,
     msg_add_wins_cfg,
     msg_del_wins_cfg,
@@ -159,15 +159,6 @@

 typedef struct {
     message_header_t header;
-    HANDLE device;
-    HANDLE send_ring_handle;
-    HANDLE receive_ring_handle;
-    HANDLE send_tail_moved;
-    HANDLE receive_tail_moved;
-} register_ring_buffers_message_t;
-
-typedef struct {
-    message_header_t header;
     interface_t iface;
     short family;
     int mtu;
@@ -176,7 +167,6 @@
 typedef enum {
     ADAPTER_TYPE_DCO,
     ADAPTER_TYPE_TAP,
-    ADAPTER_TYPE_WINTUN
 } adapter_type_t;

 typedef struct {
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 37af683..3c1a875 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -163,6 +163,6 @@
 	$(OPTIONAL_DL_LIBS) \
 	$(OPTIONAL_INOTIFY_LIBS)
 if WIN32
-openvpn_SOURCES +=3D openvpn_win32_resources.rc wfp_block.c wfp_block.h ri=
ng_buffer.h
+openvpn_SOURCES +=3D openvpn_win32_resources.rc wfp_block.c wfp_block.h
 openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm=
 -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi -lbcrypt
 endif
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 7ad9cb3..c61cbda 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -359,14 +359,6 @@
         return false;
     }

-    if ((o->windows_driver =3D=3D WINDOWS_DRIVER_WINTUN)
-        || (o->windows_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6))
-    {
-        msg(msglevel, "--windows-driver is set to '%s'. Disabling Data Cha=
nnel Offload",
-            print_tun_backend_driver(o->windows_driver));
-        return false;
-    }
-
     if ((o->mode =3D=3D MODE_SERVER) && o->ce.local_list->len > 1)
     {
         msg(msglevel, "multiple --local options defined, disabling data ch=
annel offload");
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 0b8b262..ed4cdb4 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1308,26 +1308,11 @@
     c->c2.buf =3D c->c2.buffers->read_tun_buf;

 #ifdef _WIN32
-    if (c->c1.tuntap->backend_driver =3D=3D WINDOWS_DRIVER_WINTUN)
-    {
-        read_wintun(c->c1.tuntap, &c->c2.buf);
-        if (c->c2.buf.len =3D=3D -1)
-        {
-            register_signal(c->sig, SIGHUP, "tun-abort");
-            c->persist.restart_sleep_seconds =3D 1;
-            msg(M_INFO, "Wintun read error, restarting");
-            perf_pop();
-            return;
-        }
-    }
-    else
-    {
-        /* we cannot end up here when using dco */
-        ASSERT(!dco_enabled(&c->options));
+    /* we cannot end up here when using dco */
+    ASSERT(!dco_enabled(&c->options));

-        sockethandle_t sh =3D { .is_handle =3D true, .h =3D c->c1.tuntap->=
hand, .prepend_sa =3D false };
-        sockethandle_finalize(sh, &c->c1.tuntap->reads, &c->c2.buf, NULL);
-    }
+    sockethandle_t sh =3D { .is_handle =3D true, .h =3D c->c1.tuntap->hand=
, .prepend_sa =3D false };
+    sockethandle_finalize(sh, &c->c1.tuntap->reads, &c->c2.buf, NULL);
 #else  /* ifdef _WIN32 */
     ASSERT(buf_init(&c->c2.buf, c->c2.frame.buf.headroom));
     ASSERT(buf_safe(&c->c2.buf, c->c2.frame.buf.payload_size));
@@ -1942,7 +1927,7 @@
 #endif

 #ifdef _WIN32
-        size =3D write_tun_buffered(c->c1.tuntap, &c->c2.to_tun);
+        size =3D tun_write_win32(c->c1.tuntap, &c->c2.to_tun);
 #else
         if (c->c1.tuntap->backend_driver =3D=3D DRIVER_AFUNIX)
         {
@@ -2148,17 +2133,6 @@
         tuntap |=3D EVENT_READ;
     }

-#ifdef _WIN32
-    if (tuntap_is_wintun(c->c1.tuntap))
-    {
-        /*
-         * With wintun we are only interested in read event. Ring buffer is
-         * always ready for write, so we don't do wait.
-         */
-        tuntap =3D EVENT_READ;
-    }
-#endif
-
     /*
      * Configure event wait based on socket, tuntap flags.
      */
@@ -2217,36 +2191,8 @@
     }
     else
     {
-#ifdef _WIN32
-        bool skip_iowait =3D flags & IOW_TO_TUN;
-        if (flags & IOW_READ_TUN)
-        {
-            /*
-             * don't read from tun if we have pending write to link,
-             * since every tun read overwrites to_link buffer filled
-             * by previous tun read
-             */
-            skip_iowait =3D !(flags & IOW_TO_LINK);
-        }
-        if (tuntap_is_wintun(c->c1.tuntap) && skip_iowait)
-        {
-            unsigned int ret =3D 0;
-            if (flags & IOW_TO_TUN)
-            {
-                ret |=3D TUN_WRITE;
-            }
-            if (flags & IOW_READ_TUN)
-            {
-                ret |=3D TUN_READ;
-            }
-            multi_io->udp_flags =3D ret;
-        }
-        else
-#endif /* ifdef _WIN32 */
-        {
-            /* slow path - delegate to io_wait_dowork_udp to calculate fla=
gs */
-            get_io_flags_dowork_udp(c, multi_io, flags);
-        }
+        /* slow path - delegate to io_wait_dowork_udp to calculate flags */
+        get_io_flags_dowork_udp(c, multi_io, flags);
     }
 }

diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 77892d6..74c6036 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -360,12 +360,6 @@
     {
         flags |=3D IOW_TO_TUN;
     }
-#ifdef _WIN32
-    if (tuntap_ring_empty(c->c1.tuntap))
-    {
-        flags &=3D ~IOW_READ_TUN;
-    }
-#endif
     return flags;
 }

@@ -393,36 +387,8 @@
     }
     else
     {
-#ifdef _WIN32
-        bool skip_iowait =3D flags & IOW_TO_TUN;
-        if (flags & IOW_READ_TUN)
-        {
-            /*
-             * don't read from tun if we have pending write to link,
-             * since every tun read overwrites to_link buffer filled
-             * by previous tun read
-             */
-            skip_iowait =3D !(flags & IOW_TO_LINK);
-        }
-        if (tuntap_is_wintun(c->c1.tuntap) && skip_iowait)
-        {
-            unsigned int ret =3D 0;
-            if (flags & IOW_TO_TUN)
-            {
-                ret |=3D TUN_WRITE;
-            }
-            if (flags & IOW_READ_TUN)
-            {
-                ret |=3D TUN_READ;
-            }
-            c->c2.event_set_status =3D ret;
-        }
-        else
-#endif /* ifdef _WIN32 */
-        {
-            /* slow path */
-            io_wait_dowork(c, flags);
-        }
+        /* slow path */
+        io_wait_dowork(c, flags);
     }
 }

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 54dfc72..7158d5c 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -457,11 +457,5 @@
     {
         flags |=3D IOW_READ;
     }
-#ifdef _WIN32
-    if (tuntap_ring_empty(m->top.c1.tuntap))
-    {
-        flags &=3D ~IOW_READ_TUN;
-    }
-#endif
     return flags;
 }
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index f4ca4df..7f47319 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -190,20 +190,6 @@
         get_io_flags_udp(&m->top, m->multi_io, p2mp_iow_flags(m));
     }

-#ifdef _WIN32
-    if (tuntap_is_wintun(m->top.c1.tuntap))
-    {
-        if (!tuntap_ring_empty(m->top.c1.tuntap))
-        {
-            /* there is data in wintun ring buffer, read it immediately */
-            m->multi_io->esr[0].arg =3D MULTI_IO_TUN;
-            m->multi_io->esr[0].rwflags =3D EVENT_READ;
-            m->multi_io->n_esr =3D 1;
-            return 1;
-        }
-        persistent =3D NULL;
-    }
-#endif
     tun_set(m->top.c1.tuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, p=
ersistent);
 #if defined(ENABLE_DCO) \
     && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET=
_WIN32))
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 02970a7..55b923c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -750,10 +750,6 @@
     "                       optional parameter controls the initial state =
of ex.\n"
     "--show-net-up   : Show " PACKAGE_NAME "'s view of routing table and n=
et adapter list\n"
     "                  after TAP adapter is up and routes have been added.=
\n"
-    "--windows-driver   : Which tun driver to use?\n"
-    "                     ovpn-dco (default)\n"
-    "                     tap-windows6\n"
-    "                     wintun\n"
     "--block-outside-dns   : Block DNS on other network adapters to preven=
t DNS leaks\n"
     "Windows Standalone Options:\n"
     "\n"
@@ -2592,11 +2588,6 @@
                 prefix);
         }
     }
-
-    if (options->windows_driver =3D=3D WINDOWS_DRIVER_WINTUN && dev !=3D D=
EV_TYPE_TUN)
-    {
-        msg(M_USAGE, "--windows-driver wintun requires --dev tun");
-    }
 #endif /* ifdef _WIN32 */

     /*
@@ -3371,9 +3362,8 @@
 #ifdef _WIN32
     const int dev =3D dev_type_enum(options->dev, options->dev_type);

-    /* when using wintun/ovpn-dco, kernel doesn't send DHCP requests, so d=
on't use it */
-    if ((options->windows_driver =3D=3D WINDOWS_DRIVER_WINTUN
-         || options->windows_driver =3D=3D DRIVER_DCO)
+    /* when using ovpn-dco, kernel doesn't send DHCP requests, so don't us=
e it */
+    if ((options->windows_driver =3D=3D DRIVER_DCO)
         && (options->tuntap_options.ip_win32_type =3D=3D IPW32_SET_DHCP_MA=
SQ
             || options->tuntap_options.ip_win32_type =3D=3D IPW32_SET_ADAP=
TIVE))
     {
@@ -4665,39 +4655,6 @@
     return ret;
 }

-#ifdef _WIN32
-/**
- * Parses --windows-driver config option
- *
- * @param str       value of --windows-driver option
- * @param msglevel  msglevel to report parsing error
- * @return enum tun_driver_type  driver type, WINDOWS_DRIVER_UNSPECIFIED o=
n unknown --windows-driver value
- */
-static enum tun_driver_type
-parse_windows_driver(const char *str, const int msglevel)
-{
-    if (streq(str, "tap-windows6"))
-    {
-        return WINDOWS_DRIVER_TAP_WINDOWS6;
-    }
-    else if (streq(str, "wintun"))
-    {
-        return WINDOWS_DRIVER_WINTUN;
-    }
-
-    else if (streq(str, "ovpn-dco"))
-    {
-        return DRIVER_DCO;
-    }
-    else
-    {
-        msg(msglevel, "--windows-driver must be tap-windows6, wintun "
-            "or ovpn-dco");
-        return WINDOWS_DRIVER_UNSPECIFIED;
-    }
-}
-#endif /* ifdef _WIN32 */
-
 /*
  * parse/print topology coding
  */
@@ -6012,7 +5969,8 @@
     else if (streq(p[0], "windows-driver") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->windows_driver =3D parse_windows_driver(p[1], M_FATAL);
+        msg(M_WARN, "DEPRECATED OPTION: windows-driver: In OpenVPN 2.7, th=
e default Windows driver is ovpn-dco. "
+            "If incompatible options are used, OpenVPN will fall back to t=
ap-windows6. Wintun support has been removed.");
     }
 #endif
     else if (streq(p[0], "disable-dco"))
diff --git a/src/openvpn/ring_buffer.h b/src/openvpn/ring_buffer.h
deleted file mode 100644
index c536980..0000000
--- a/src/openvpn/ring_buffer.h
+++ /dev/null
@@ -1,125 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
- *                2019 Lev Stipakov <lev@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifdef _WIN32
-#ifndef OPENVPN_RING_BUFFER_H
-#define OPENVPN_RING_BUFFER_H
-
-#include <windows.h>
-#include <winioctl.h>
-
-#include <stdint.h>
-#include <stdbool.h>
-
-/*
- * Values below are taken from Wireguard Windows client
- * https://github.com/WireGuard/wireguard-go/blob/master/tun/wintun/ring_w=
indows.go#L14
- */
-#define WINTUN_RING_CAPACITY        0x800000
-#define WINTUN_RING_TRAILING_BYTES  0x10000
-#define WINTUN_MAX_PACKET_SIZE      0xffff
-#define WINTUN_PACKET_ALIGN         4
-
-#define TUN_IOCTL_REGISTER_RINGS CTL_CODE(51820U, 0x970U, METHOD_BUFFERED,=
 FILE_READ_DATA | FILE_WRITE_DATA)
-
-/**
- * Wintun ring buffer
- * See https://github.com/WireGuard/wintun#ring-layout
- */
-struct tun_ring
-{
-    volatile ULONG head;
-    volatile ULONG tail;
-    volatile LONG alertable;
-    UCHAR data[WINTUN_RING_CAPACITY + WINTUN_RING_TRAILING_BYTES];
-};
-
-/**
- * Struct for ring buffers registration
- * See https://github.com/WireGuard/wintun#registering-rings
- */
-struct tun_register_rings
-{
-    struct
-    {
-        ULONG ring_size;
-        struct tun_ring *ring;
-        HANDLE tail_moved;
-    } send, receive;
-};
-
-struct TUN_PACKET_HEADER
-{
-    uint32_t size;
-};
-
-struct TUN_PACKET
-{
-    uint32_t size;
-    UCHAR data[WINTUN_MAX_PACKET_SIZE];
-};
-
-/**
- * Registers ring buffers used to exchange data between
- * userspace openvpn process and wintun kernel driver,
- * see https://github.com/WireGuard/wintun#registering-rings
- *
- * @param device              handle to opened wintun device
- * @param send_ring           pointer to send ring
- * @param receive_ring        pointer to receive ring
- * @param send_tail_moved     event set by wintun to signal openvpn
- *                            that data is available for reading in send r=
ing
- * @param receive_tail_moved  event set by openvpn to signal wintun
- *                            that data has been written to receive ring
- * @return                    true if registration is successful, false ot=
herwise - use GetLastError()
- */
-static inline bool
-register_ring_buffers(HANDLE device,
-                      struct tun_ring *send_ring,
-                      struct tun_ring *receive_ring,
-                      HANDLE send_tail_moved,
-                      HANDLE receive_tail_moved)
-{
-    struct tun_register_rings rr;
-    BOOL res;
-    DWORD bytes_returned;
-
-    ZeroMemory(&rr, sizeof(rr));
-
-    rr.send.ring =3D send_ring;
-    rr.send.ring_size =3D sizeof(struct tun_ring);
-    rr.send.tail_moved =3D send_tail_moved;
-
-    rr.receive.ring =3D receive_ring;
-    rr.receive.ring_size =3D sizeof(struct tun_ring);
-    rr.receive.tail_moved =3D receive_tail_moved;
-
-    res =3D DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr, sizeof(=
rr),
-                          NULL, 0, &bytes_returned, NULL);
-
-    return res !=3D FALSE;
-}
-
-#endif /* ifndef OPENVPN_RING_BUFFER_H */
-#endif /* ifdef _WIN32 */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 6a2043e..d7c38a1 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -63,9 +63,6 @@
         case WINDOWS_DRIVER_TAP_WINDOWS6:
             return "tap-windows6";

-        case WINDOWS_DRIVER_WINTUN:
-            return "wintun";
-
         case DRIVER_GENERIC_TUNTAP:
             return "tun/tap";

@@ -473,10 +470,6 @@
             t =3D ADAPTER_TYPE_TAP;
             break;

-        case WINDOWS_DRIVER_WINTUN:
-            t =3D ADAPTER_TYPE_WINTUN;
-            break;
-
         case DRIVER_DCO:
             t =3D ADAPTER_TYPE_DCO;
             break;
@@ -1040,37 +1033,8 @@
     overlapped_io_init(&tt->writes, frame, TRUE);
     tt->adapter_index =3D TUN_ADAPTER_INDEX_INVALID;

-    if (tt->backend_driver =3D=3D WINDOWS_DRIVER_WINTUN)
-    {
-        tt->wintun_send_ring_handle =3D CreateFileMapping(INVALID_HANDLE_V=
ALUE, NULL,
-                                                        PAGE_READWRITE,
-                                                        0,
-                                                        sizeof(struct tun_=
ring),
-                                                        NULL);
-        tt->wintun_receive_ring_handle =3D CreateFileMapping(INVALID_HANDL=
E_VALUE,
-                                                           NULL,
-                                                           PAGE_READWRITE,
-                                                           0,
-                                                           sizeof(struct t=
un_ring),
-                                                           NULL);
-        if ((tt->wintun_send_ring_handle =3D=3D NULL) || (tt->wintun_recei=
ve_ring_handle =3D=3D NULL))
-        {
-            msg(M_FATAL, "Cannot allocate memory for ring buffer");
-        }
-
-        tt->rw_handle.read =3D CreateEvent(NULL, FALSE, FALSE, NULL);
-        tt->rw_handle.write =3D CreateEvent(NULL, FALSE, FALSE, NULL);
-
-        if ((tt->rw_handle.read =3D=3D NULL) || (tt->rw_handle.write =3D=
=3D NULL))
-        {
-            msg(M_FATAL, "Cannot create events for ring buffer");
-        }
-    }
-    else
-    {
-        tt->rw_handle.read =3D tt->reads.overlapped.hEvent;
-        tt->rw_handle.write =3D tt->writes.overlapped.hEvent;
-    }
+    tt->rw_handle.read =3D tt->reads.overlapped.hEvent;
+    tt->rw_handle.write =3D tt->writes.overlapped.hEvent;
 #endif /* ifdef _WIN32 */
 }

@@ -4010,10 +3974,6 @@
                     {
                         windows_driver =3D WINDOWS_DRIVER_TAP_WINDOWS6;
                     }
-                    else if (strcasecmp(component_id, WINTUN_COMPONENT_ID)=
 =3D=3D 0)
-                    {
-                        windows_driver =3D WINDOWS_DRIVER_WINTUN;
-                    }
                     else if (strcasecmp(component_id, "ovpn-dco") =3D=3D 0)
                     {
                         windows_driver =3D DRIVER_DCO;
@@ -4320,7 +4280,7 @@
 }

 /*
- * Lookup a TAP-Windows or Wintun adapter by GUID.
+ * Lookup an adapter by GUID.
  */
 static const struct tap_reg *
 get_adapter_by_guid(const char *guid, const struct tap_reg *tap_reg)
@@ -4375,7 +4335,7 @@
 {
     if (!tap_reg)
     {
-        msg(M_FATAL, "There are no TAP-Windows, Wintun or ovpn-dco adapter=
s "
+        msg(M_FATAL, "There are no TAP-Windows or ovpn-dco adapters "
             "on this system.  You should be able to create an adapter "
             "by using tapctl.exe utility.");
     }
@@ -6086,46 +6046,6 @@
     gc_free(&gc);
 }

-static bool
-service_register_ring_buffers(const struct tuntap *tt)
-{
-    HANDLE msg_channel =3D tt->options.msg_channel;
-    ack_message_t ack;
-    bool ret =3D true;
-    struct gc_arena gc =3D gc_new();
-
-    register_ring_buffers_message_t msg =3D {
-        .header =3D {
-            msg_register_ring_buffers,
-            sizeof(register_ring_buffers_message_t),
-            0
-        },
-        .device =3D tt->hand,
-        .send_ring_handle =3D tt->wintun_send_ring_handle,
-        .receive_ring_handle =3D tt->wintun_receive_ring_handle,
-        .send_tail_moved =3D tt->rw_handle.read,
-        .receive_tail_moved =3D tt->rw_handle.write
-    };
-
-    if (!send_msg_iservice(msg_channel, &msg, sizeof(msg), &ack, "Register=
 ring buffers"))
-    {
-        ret =3D false;
-    }
-    else if (ack.error_number !=3D NO_ERROR)
-    {
-        msg(M_NONFATAL, "Register ring buffers failed using service: %s [s=
tatus=3D0x%x]",
-            strerror_win32(ack.error_number, &gc), ack.error_number);
-        ret =3D false;
-    }
-    else
-    {
-        msg(M_INFO, "Ring buffers registered via service");
-    }
-
-    gc_free(&gc);
-    return ret;
-}
-
 void
 fork_register_dns_action(struct tuntap *tt)
 {
@@ -6363,58 +6283,6 @@
     gc_free(&gc);
 }

-static bool
-wintun_register_ring_buffer(struct tuntap *tt, const char *device_guid)
-{
-    bool ret =3D true;
-
-    tt->wintun_send_ring =3D (struct tun_ring *)MapViewOfFile(tt->wintun_s=
end_ring_handle,
-                                                            FILE_MAP_ALL_A=
CCESS,
-                                                            0,
-                                                            0,
-                                                            sizeof(struct =
tun_ring));
-
-    tt->wintun_receive_ring =3D (struct tun_ring *)MapViewOfFile(tt->wintu=
n_receive_ring_handle,
-                                                               FILE_MAP_AL=
L_ACCESS,
-                                                               0,
-                                                               0,
-                                                               sizeof(stru=
ct tun_ring));
-
-    if (tt->options.msg_channel)
-    {
-        ret =3D service_register_ring_buffers(tt);
-    }
-    else
-    {
-        if (!register_ring_buffers(tt->hand,
-                                   tt->wintun_send_ring,
-                                   tt->wintun_receive_ring,
-                                   tt->rw_handle.read,
-                                   tt->rw_handle.write))
-        {
-            switch (GetLastError())
-            {
-                case ERROR_ACCESS_DENIED:
-                    msg(M_FATAL, "ERROR:  Wintun requires SYSTEM privilege=
s and therefore "
-                        "should be used with interactive service. If you w=
ant to "
-                        "use openvpn from command line, you need to do SYS=
TEM "
-                        "elevation yourself (for example with psexec).");
-                    break;
-
-                case ERROR_ALREADY_INITIALIZED:
-                    msg(M_NONFATAL, "Adapter %s is already in use", device=
_guid);
-                    break;
-
-                default:
-                    msg(M_NONFATAL | M_ERRNO, "Failed to register ring buf=
fers");
-            }
-            ret =3D false;
-        }
-
-    }
-    return ret;
-}
-
 static void
 tuntap_set_connected(const struct tuntap *tt)
 {
@@ -6574,8 +6442,7 @@
     const char *path =3D NULL;
     char tuntap_device_path[256];

-    if (tt->backend_driver =3D=3D WINDOWS_DRIVER_WINTUN
-        || tt->backend_driver =3D=3D DRIVER_DCO)
+    if (tt->backend_driver =3D=3D DRIVER_DCO)
     {
         const struct device_instance_id_interface *dev_if;

@@ -6629,18 +6496,6 @@
         return false;
     }

-    if (tt->backend_driver =3D=3D WINDOWS_DRIVER_WINTUN)
-    {
-        /* Wintun adapter may be considered "open" after ring buffers are =
successfuly registered. */
-        if (!wintun_register_ring_buffer(tt, device_guid))
-        {
-            msg(D_TUNTAP_INFO, "Failed to register %s adapter ring buffers=
", device_guid);
-            CloseHandle(tt->hand);
-            tt->hand =3D NULL;
-            return false;
-        }
-    }
-
     return true;
 }

@@ -6988,16 +6843,6 @@
         }
         tt->hand =3D NULL;
     }
-
-    if (tt->backend_driver =3D=3D WINDOWS_DRIVER_WINTUN)
-    {
-        CloseHandle(tt->rw_handle.read);
-        CloseHandle(tt->rw_handle.write);
-        UnmapViewOfFile(tt->wintun_send_ring);
-        UnmapViewOfFile(tt->wintun_receive_ring);
-        CloseHandle(tt->wintun_send_ring_handle);
-        CloseHandle(tt->wintun_receive_ring_handle);
-    }
 }

 void
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index bcc23b4..de1876a 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -39,13 +39,11 @@
 #include "proto.h"
 #include "misc.h"
 #include "networking.h"
-#include "ring_buffer.h"
 #include "dco.h"

 enum tun_driver_type {
     WINDOWS_DRIVER_UNSPECIFIED,
     WINDOWS_DRIVER_TAP_WINDOWS6,
-    WINDOWS_DRIVER_WINTUN,
     DRIVER_GENERIC_TUNTAP,
     /** using an AF_UNIX socket to pass packets from/to an external progra=
m.
      *  This is always defined. We error out if a user tries to open this =
type
@@ -58,7 +56,6 @@
 };

 #ifdef _WIN32
-#define WINTUN_COMPONENT_ID "wintun"
 #define DCO_WIN_REFERENCE_STRING "ovpn-dco"
 #endif

@@ -233,11 +230,7 @@

     int standby_iter;

-    HANDLE wintun_send_ring_handle;
-    HANDLE wintun_receive_ring_handle;
-    struct tun_ring *wintun_send_ring;
-    struct tun_ring *wintun_receive_ring;
-#else  /* ifdef _WIN32 */
+    #else  /* ifdef _WIN32 */
     int fd; /* file descriptor for TUN/TAP dev */
 #endif /* ifdef _WIN32 */

@@ -262,20 +255,6 @@
 #endif
 }

-#ifdef _WIN32
-static inline bool
-tuntap_is_wintun(struct tuntap *tt)
-{
-    return tt && tt->backend_driver =3D=3D WINDOWS_DRIVER_WINTUN;
-}
-
-static inline bool
-tuntap_ring_empty(struct tuntap *tt)
-{
-    return tuntap_is_wintun(tt) && (tt->wintun_send_ring->head =3D=3D tt->=
wintun_send_ring->tail);
-}
-#endif
-
 /*
  * Function prototypes
  */
@@ -526,74 +505,6 @@

 int tun_write_win32(struct tuntap *tt, struct buffer *buf);

-static inline ULONG
-wintun_ring_packet_align(ULONG size)
-{
-    return (size + (WINTUN_PACKET_ALIGN - 1)) & ~(WINTUN_PACKET_ALIGN - 1);
-}
-
-static inline ULONG
-wintun_ring_wrap(ULONG value)
-{
-    return value & (WINTUN_RING_CAPACITY - 1);
-}
-
-static inline void
-read_wintun(struct tuntap *tt, struct buffer *buf)
-{
-    struct tun_ring *ring =3D tt->wintun_send_ring;
-    ULONG head =3D ring->head;
-    ULONG tail =3D ring->tail;
-    ULONG content_len;
-    struct TUN_PACKET *packet;
-    ULONG aligned_packet_size;
-
-    *buf =3D tt->reads.buf_init;
-    buf->len =3D 0;
-
-    if ((head >=3D WINTUN_RING_CAPACITY) || (tail >=3D WINTUN_RING_CAPACIT=
Y))
-    {
-        msg(M_INFO, "Wintun: ring capacity exceeded");
-        buf->len =3D -1;
-        return;
-    }
-
-    if (head =3D=3D tail)
-    {
-        /* nothing to read */
-        return;
-    }
-
-    content_len =3D wintun_ring_wrap(tail - head);
-    if (content_len < sizeof(struct TUN_PACKET_HEADER))
-    {
-        msg(M_INFO, "Wintun: incomplete packet header in send ring");
-        buf->len =3D -1;
-        return;
-    }
-
-    packet =3D (struct TUN_PACKET *) &ring->data[head];
-    if (packet->size > WINTUN_MAX_PACKET_SIZE)
-    {
-        msg(M_INFO, "Wintun: packet too big in send ring");
-        buf->len =3D -1;
-        return;
-    }
-
-    aligned_packet_size =3D wintun_ring_packet_align(sizeof(struct TUN_PAC=
KET_HEADER) + packet->size);
-    if (aligned_packet_size > content_len)
-    {
-        msg(M_INFO, "Wintun: incomplete packet in send ring");
-        buf->len =3D -1;
-        return;
-    }
-
-    buf_write(buf, packet->data, packet->size);
-
-    head =3D wintun_ring_wrap(head + aligned_packet_size);
-    ring->head =3D head;
-}
-
 static inline bool
 is_ip_packet_valid(const struct buffer *buf)
 {
@@ -621,65 +532,6 @@
     return true;
 }

-static inline int
-write_wintun(struct tuntap *tt, struct buffer *buf)
-{
-    struct tun_ring *ring =3D tt->wintun_receive_ring;
-    ULONG head =3D ring->head;
-    ULONG tail =3D ring->tail;
-    ULONG aligned_packet_size;
-    ULONG buf_space;
-    struct TUN_PACKET *packet;
-
-    /* wintun marks ring as corrupted (overcapacity) if it receives invali=
d IP packet */
-    if (!is_ip_packet_valid(buf))
-    {
-        msg(D_LOW, "write_wintun(): drop invalid IP packet");
-        return 0;
-    }
-
-    if ((head >=3D WINTUN_RING_CAPACITY) || (tail >=3D WINTUN_RING_CAPACIT=
Y))
-    {
-        msg(M_INFO, "write_wintun(): head/tail value is over capacity");
-        return -1;
-    }
-
-    aligned_packet_size =3D wintun_ring_packet_align(sizeof(struct TUN_PAC=
KET_HEADER) + BLEN(buf));
-    buf_space =3D wintun_ring_wrap(head - tail - WINTUN_PACKET_ALIGN);
-    if (aligned_packet_size > buf_space)
-    {
-        msg(M_INFO, "write_wintun(): ring is full");
-        return 0;
-    }
-
-    /* copy packet size and data into ring */
-    packet =3D (struct TUN_PACKET * )&ring->data[tail];
-    packet->size =3D BLEN(buf);
-    memcpy(packet->data, BPTR(buf), BLEN(buf));
-
-    /* move ring tail */
-    ring->tail =3D wintun_ring_wrap(tail + aligned_packet_size);
-    if (ring->alertable !=3D 0)
-    {
-        SetEvent(tt->rw_handle.write);
-    }
-
-    return BLEN(buf);
-}
-
-static inline int
-write_tun_buffered(struct tuntap *tt, struct buffer *buf)
-{
-    if (tt->backend_driver =3D=3D WINDOWS_DRIVER_WINTUN)
-    {
-        return write_wintun(tt, buf);
-    }
-    else
-    {
-        return tun_write_win32(tt, buf);
-    }
-}
-
 static inline bool
 tuntap_is_dco_win(struct tuntap *tt)
 {
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c
index 30db644..4ff1b70 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -320,11 +320,6 @@
         L"ACTIVETAPWINDOWS6ADAPTERS");
     find_adapters(
         hInstall,
-        L"Wintun" L"\0",
-        L"WINTUNADAPTERS",
-        L"ACTIVEWINTUNADAPTERS");
-    find_adapters(
-        hInstall,
         L"ovpn-dco" L"\0",
         L"OVPNDCOADAPTERS",
         L"ACTIVEOVPNDCOADAPTERS");
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsic=
a.h
index 761aa47..9898067 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -88,10 +88,6 @@
  *   ACTIVETAPWINDOWS6ADAPTERS properties with semicolon delimited list of=
 all installed adapter
  *   GUIDs and active adapter GUIDs respectively.
  *
- * - Finds existing Wintun adapters and set WINTUNADAPTERS and ACTIVEWINTU=
NADAPTERS properties
- *   with semicolon delimited list of all installed adapter GUIDs and acti=
ve adapter GUIDs
- *   respectively.
- *
  * - Finds existing ovpn-dco adapters and set OVPNDCOADAPTERS and ACTIVEOV=
PNDCOADAPTERS properties
  *   with semicolon delimited list of all installed adapter GUIDs and acti=
ve adapter GUIDs
  *   respectively.
diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index 44a40fe..7e3efb2 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -20,7 +20,6 @@
     ../tapctl/basic.h
     ../openvpn/wfp_block.c ../openvpn/wfp_block.h
     openvpnserv_resources.rc
-    ../openvpn/ring_buffer.h
     )
 target_compile_options(openvpnserv PRIVATE
     -D_UNICODE
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index f053f40..852746d 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -36,5 +36,4 @@
 	service.c service.h \
 	validate.c validate.h \
 	$(top_srcdir)/src/openvpn/wfp_block.c $(top_srcdir)/src/openvpn/wfp_block=
.h \
-	openvpnserv_resources.rc \
-	$(top_srcdir)/src/openvpn/ring_buffer.h
+	openvpnserv_resources.rc
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 8a7b50d..5f842bd 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -40,7 +40,6 @@
 #include "openvpn-msg.h"
 #include "validate.h"
 #include "wfp_block.h"
-#include "ring_buffer.h"

 #define IO_TIMEOUT  2000 /*ms*/

@@ -90,7 +89,6 @@
     undo_dns6,
     undo_nrpt,
     undo_domains,
-    undo_ring_buffer,
     undo_wins,
     _undo_type_max
 } undo_type_t;
@@ -108,11 +106,6 @@
     PWSTR domains;
 } dns_domains_undo_data_t;

-typedef struct {
-    struct tun_ring *send_ring;
-    struct tun_ring *receive_ring;
-} ring_buffer_maps_t;
-
 typedef union {
     message_header_t header;
     address_message_t address;
@@ -122,7 +115,6 @@
     dns_cfg_message_t dns;
     nrpt_dns_cfg_message_t nrpt_dns;
     enable_dhcp_message_t dhcp;
-    register_ring_buffers_message_t rrb;
     set_mtu_message_t mtu;
     wins_cfg_message_t wins;
     create_adapter_message_t create_adapter;
@@ -188,23 +180,6 @@
     return INVALID_HANDLE_VALUE;
 }

-static void
-OvpnUnmapViewOfFile(struct tun_ring **ring)
-{
-    if (ring && *ring)
-    {
-        UnmapViewOfFile(*ring);
-        *ring =3D NULL;
-    }
-}
-
-static void
-UnmapRingBuffer(ring_buffer_maps_t *ring_buffer_maps)
-{
-    OvpnUnmapViewOfFile(&ring_buffer_maps->send_ring);
-    OvpnUnmapViewOfFile(&ring_buffer_maps->receive_ring);
-}
-
 static HANDLE
 InitOverlapped(LPOVERLAPPED overlapped)
 {
@@ -213,7 +188,6 @@
     return overlapped->hEvent;
 }

-
 static BOOL
 ResetOverlapped(LPOVERLAPPED overlapped)
 {
@@ -2973,119 +2947,6 @@
 }

 static DWORD
-OvpnDuplicateHandle(HANDLE ovpn_proc, HANDLE orig_handle, HANDLE *new_hand=
le)
-{
-    DWORD err =3D ERROR_SUCCESS;
-
-    if (!DuplicateHandle(ovpn_proc, orig_handle, GetCurrentProcess(), new_=
handle, 0, FALSE, DUPLICATE_SAME_ACCESS))
-    {
-        err =3D GetLastError();
-        MsgToEventLog(M_SYSERR, L"Could not duplicate handle");
-        return err;
-    }
-
-    return err;
-}
-
-static DWORD
-DuplicateAndMapRing(HANDLE ovpn_proc, HANDLE orig_handle, struct tun_ring =
**ring)
-{
-    DWORD err =3D ERROR_SUCCESS;
-
-    HANDLE dup_handle =3D NULL;
-
-    err =3D OvpnDuplicateHandle(ovpn_proc, orig_handle, &dup_handle);
-    if (err !=3D ERROR_SUCCESS)
-    {
-        return err;
-    }
-    *ring =3D (struct tun_ring *)MapViewOfFile(dup_handle, FILE_MAP_ALL_AC=
CESS, 0, 0, sizeof(struct tun_ring));
-    CloseHandleEx(&dup_handle);
-    if (*ring =3D=3D NULL)
-    {
-        err =3D GetLastError();
-        MsgToEventLog(M_SYSERR, L"Could not map shared memory");
-        return err;
-    }
-
-    return err;
-}
-
-static DWORD
-HandleRegisterRingBuffers(const register_ring_buffers_message_t *rrb, HAND=
LE ovpn_proc,
-                          undo_lists_t *lists)
-{
-    DWORD err =3D 0;
-
-    ring_buffer_maps_t *ring_buffer_maps =3D RemoveListItem(&(*lists)[undo=
_ring_buffer], CmpAny, NULL);
-
-    if (ring_buffer_maps)
-    {
-        UnmapRingBuffer(ring_buffer_maps);
-    }
-    else if ((ring_buffer_maps =3D calloc(1, sizeof(*ring_buffer_maps))) =
=3D=3D NULL)
-    {
-        return ERROR_OUTOFMEMORY;
-    }
-
-    HANDLE device =3D NULL;
-    HANDLE send_tail_moved =3D NULL;
-    HANDLE receive_tail_moved =3D NULL;
-
-    err =3D OvpnDuplicateHandle(ovpn_proc, rrb->device, &device);
-    if (err !=3D ERROR_SUCCESS)
-    {
-        goto out;
-    }
-
-    err =3D DuplicateAndMapRing(ovpn_proc, rrb->send_ring_handle, &ring_bu=
ffer_maps->send_ring);
-    if (err !=3D ERROR_SUCCESS)
-    {
-        goto out;
-    }
-
-    err =3D DuplicateAndMapRing(ovpn_proc, rrb->receive_ring_handle, &ring=
_buffer_maps->receive_ring);
-    if (err !=3D ERROR_SUCCESS)
-    {
-        goto out;
-    }
-
-    err =3D OvpnDuplicateHandle(ovpn_proc, rrb->send_tail_moved, &send_tai=
l_moved);
-    if (err !=3D ERROR_SUCCESS)
-    {
-        goto out;
-    }
-
-    err =3D OvpnDuplicateHandle(ovpn_proc, rrb->receive_tail_moved, &recei=
ve_tail_moved);
-    if (err !=3D ERROR_SUCCESS)
-    {
-        goto out;
-    }
-
-    if (!register_ring_buffers(device, ring_buffer_maps->send_ring,
-                               ring_buffer_maps->receive_ring,
-                               send_tail_moved, receive_tail_moved))
-    {
-        err =3D GetLastError();
-        MsgToEventLog(M_SYSERR, L"Could not register ring buffers");
-        goto out;
-    }
-
-    err =3D AddListItem(&(*lists)[undo_ring_buffer], ring_buffer_maps);
-
-out:
-    if (err !=3D ERROR_SUCCESS && ring_buffer_maps)
-    {
-        UnmapRingBuffer(ring_buffer_maps);
-        free(ring_buffer_maps);
-    }
-    CloseHandleEx(&device);
-    CloseHandleEx(&send_tail_moved);
-    CloseHandleEx(&receive_tail_moved);
-    return err;
-}
-
-static DWORD
 HandleMTUMessage(const set_mtu_message_t *mtu)
 {
     DWORD err =3D 0;
@@ -3130,10 +2991,6 @@
             hwid =3D L"root\\tap0901";
             break;

-        case ADAPTER_TYPE_WINTUN:
-            hwid =3D L"wintun";
-            break;
-
         default:
             return ERROR_INVALID_PARAMETER;
     }
@@ -3238,14 +3095,6 @@
             }
             break;

-        case msg_register_ring_buffers:
-            if (msg.header.size =3D=3D sizeof(msg.rrb))
-            {
-                HANDLE ovpn_hnd =3D proc_info->hProcess;
-                ack.error_number =3D HandleRegisterRingBuffers(&msg.rrb, o=
vpn_hnd, lists);
-            }
-            break;
-
         case msg_set_mtu:
             if (msg.header.size =3D=3D sizeof(msg.mtu))
             {
@@ -3327,10 +3176,6 @@
                     }
                     break;

-                case undo_ring_buffer:
-                    UnmapRingBuffer(item->data);
-                    break;
-
                 case _undo_type_max:
                     /* unreachable */
                     break;
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 551a8e6..4569b87 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -75,8 +75,8 @@
     L"               Note: This name can also be specified as OpenVPN's --=
dev-node   \n"
     L"               option.                                              =
           \n"
     L"--hwid <hwid>  Adapter hardware ID. Default value is root\\tap0901, =
which      \n"
-    L"               describes tap-windows6 driver. To work with wintun or=
 ovpn-dco  \n"
-    L"               driver, specify 'wintun' or 'ovpn-dco'.              =
           \n"
+    L"               describes tap-windows6 driver. To work with ovpn-dco =
driver,    \n"
+    L"               driver, specify 'ovpn-dco'.                          =
           \n"
     L"\n"
     L"Output:\n"
     L"\n"
@@ -94,7 +94,7 @@
     L"\n"
     L"Options:\n"
     L"\n"
-    L"--hwid <hwid>  Adapter hardware ID. By default, root\\tap0901, tap09=
01, wintun and \n"
+    L"--hwid <hwid>  Adapter hardware ID. By default, root\\tap0901, tap09=
01 and \n"
     L"               ovpn-dco adapters are listed. Use this switch to limi=
t the list.\n"
     L"\n"
     L"Output:\n"
@@ -167,10 +167,6 @@
     {
         base_name =3D L"OpenVPN Data Channel Offload";
     }
-    else if (wcsicmp(hwid, L"wintun") =3D=3D 0)
-    {
-        base_name =3D L"OpenVPN Wintun";
-    }
     else if (wcsicmp(hwid, L"root\\" _L(TAP_WIN_COMPONENT_ID)) =3D=3D 0)
     {
         base_name =3D L"OpenVPN TAP-Windows6";
@@ -351,7 +347,6 @@
         WCHAR szzHwId[0x100] =3D
             L"root\\" _L(TAP_WIN_COMPONENT_ID) L"\0"
             _L(TAP_WIN_COMPONENT_ID) L"\0"
-            L"Wintun\0"
             L"ovpn-dco\0";

         /* Parse options. */
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index 38ea824..c35176c 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -38,7 +38,7 @@
  *                      description of the device. This pointer is optiona=
l and can be NULL.
  *
  * @param szHwId        A pointer to a NULL-terminated string that supplie=
s the hardware id
- *                      of the device (e.g. "root\\tap0901", "Wintun").
+ *                      of the device (e.g. "root\\tap0901").
  *
  * @param pbRebootRequired  A pointer to a BOOL flag. If the device requir=
es a system restart,
  *                      this flag is set to TRUE. Otherwise, the flag is l=
eft unmodified. This

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1021?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I43ec390040bffeec05270271ea7fb54fb219c536
Gerrit-Change-Number: 1021
Gerrit-PatchSet: 6
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--oDYoeUPl/uY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1021?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">win: remove Wintun support<br><br>Since DCO s=
upports modern ciphers and server mode,<br>there is no reason to support Wi=
ntun anymore.<br><br>This also removes --windows-driver option support. The=
<br>default driver is DCO, as it has been since 2.6. If for<br>some reasons=
 one doesn&#39;t want to use it, --disable-dco<br>multiplatform option will=
 switch to tap-windows6.<br><br>Change-Id: I43ec390040bffeec05270271ea7fb54=
fb219c536<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250513151006.136=
17-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel=
@lists.sourceforge.net/msg31631.html<br>Signed-off-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>---<br>M doc/man-sections/vpn-network-options.rst<br>M =
doc/man-sections/windows-options.rst<br>M include/openvpn-msg.h<br>M src/op=
envpn/Makefile.am<br>M src/openvpn/dco.c<br>M src/openvpn/forward.c<br>M sr=
c/openvpn/forward.h<br>M src/openvpn/mudp.c<br>M src/openvpn/multi_io.c<br>=
M src/openvpn/options.c<br>D src/openvpn/ring_buffer.h<br>M src/openvpn/tun=
.c<br>M src/openvpn/tun.h<br>M src/openvpnmsica/openvpnmsica.c<br>M src/ope=
nvpnmsica/openvpnmsica.h<br>M src/openvpnserv/CMakeLists.txt<br>M src/openv=
pnserv/Makefile.am<br>M src/openvpnserv/interactive.c<br>M src/tapctl/main.=
c<br>M src/tapctl/tap.h<br>20 files changed, 27 insertions(+), 801 deletion=
s(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections=
/vpn-network-options.rst</span><br><span>index 67f7e1f..40b8c19 100644</spa=
n><br><span>--- a/doc/man-sections/vpn-network-options.rst</span><br><span>=
+++ b/doc/man-sections/vpn-network-options.rst</span><br><span>@@ -137,8 +1=
37,7 @@</span><br><span>   Set additional network parameters on supported p=
latforms. May be specified</span><br><span>   on the client or pushed from =
the server. On Windows these options are</span><br><span>   handled by the =
``tap-windows6`` driver by default or directly by OpenVPN</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  if dhcp is disabled or the ``wintun``=
 driver is in use. The</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  ``OpenVPN for Android`` client also handles them internally.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  if dhcp is disabled. The ``Op=
enVPN for Android`` client also handles them internally.</span><br><span> <=
/span><br><span>   On all other platforms these options are only saved in t=
he client&#39;s</span><br><span>   environment under the name :code:`foreig=
n_option_{n}` before the</span><br><span>diff --git a/doc/man-sections/wind=
ows-options.rst b/doc/man-sections/windows-options.rst</span><br><span>inde=
x 1955869..af2fb45 100644</span><br><span>--- a/doc/man-sections/windows-op=
tions.rst</span><br><span>+++ b/doc/man-sections/windows-options.rst</span>=
<br><span>@@ -252,9 +252,3 @@</span><br><span>   otherwise it defaulted to =
:code:`C:\\WINDOWS`. It is not needed to use</span><br><span>   the ``env``=
 keyword any more, and it will just be ignored. A warning is</span><br><spa=
n>   logged when this is found in the configuration file.</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>---windows-driver drv<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Specifies which tun =
driver to use. Values are :code:`ovpn-dco` (default),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  :code:`tap-windows6` and :code:`wintun`. =
:code:`ovpn-dco` and :code:`wintun`</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  require ``--dev tun``. :code:`wintun` also requires OpenVPN=
 process to run</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  elev=
ated, or be invoked using the Interactive Service.</span><br><span>diff --g=
it a/include/openvpn-msg.h b/include/openvpn-msg.h</span><br><span>index 2c=
f8d40..34b133b 100644</span><br><span>--- a/include/openvpn-msg.h</span><br=
><span>+++ b/include/openvpn-msg.h</span><br><span>@@ -44,7 +44,7 @@</span>=
<br><span>     msg_del_wfp_block,</span><br><span>     msg_register_dns,</s=
pan><br><span>     msg_enable_dhcp,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    msg_register_ring_buffers,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    deprecated_msg_register_ring_buffers,</span><b=
r><span>     msg_set_mtu,</span><br><span>     msg_add_wins_cfg,</span><br>=
<span>     msg_del_wins_cfg,</span><br><span>@@ -159,15 +159,6 @@</span><br=
><span> </span><br><span> typedef struct {</span><br><span>     message_hea=
der_t header;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    HAND=
LE device;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    HANDLE =
send_ring_handle;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
HANDLE receive_ring_handle;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    HANDLE send_tail_moved;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    HANDLE receive_tail_moved;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-} register_ring_buffers_message_t;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-typedef struct {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    message_header_t header;</span><br><span>     interface_t iface=
;</span><br><span>     short family;</span><br><span>     int mtu;</span><b=
r><span>@@ -176,7 +167,6 @@</span><br><span> typedef enum {</span><br><span=
>     ADAPTER_TYPE_DCO,</span><br><span>     ADAPTER_TYPE_TAP,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ADAPTER_TYPE_WINTUN</span><br>=
<span> } adapter_type_t;</span><br><span> </span><br><span> typedef struct =
{</span><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefi=
le.am</span><br><span>index 37af683..3c1a875 100644</span><br><span>--- a/s=
rc/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am</span>=
<br><span>@@ -163,6 +163,6 @@</span><br><span> 	$(OPTIONAL_DL_LIBS) \</span=
><br><span> 	$(OPTIONAL_INOTIFY_LIBS)</span><br><span> if WIN32</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-openvpn_SOURCES +=3D openvpn_win3=
2_resources.rc wfp_block.c wfp_block.h ring_buffer.h</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+openvpn_SOURCES +=3D openvpn_win32_resour=
ces.rc wfp_block.c wfp_block.h</span><br><span> openvpn_LDADD +=3D -lgdi32 =
-lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncryp=
t -lsetupapi -lbcrypt</span><br><span> endif</span><br><span>diff --git a/s=
rc/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index 7ad9cb3..c61cbda=
 100644</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/o=
penvpn/dco.c</span><br><span>@@ -359,14 +359,6 @@</span><br><span>         =
return false;</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if ((o-&gt;windows_driver =3D=3D WINDO=
WS_DRIVER_WINTUN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    || (o-&gt;windows_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;--windows-driver is=
 set to &#39;%s&#39;. Disabling Data Channel Offload&quot;,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            print_tun_backend_driver(=
o-&gt;windows_driver));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an>     if ((o-&gt;mode =3D=3D MODE_SERVER) &amp;&amp; o-&gt;ce.local_list-=
&gt;len &gt; 1)</span><br><span>     {</span><br><span>         msg(msgleve=
l, &quot;multiple --local options defined, disabling data channel offload&q=
uot;);</span><br><span>diff --git a/src/openvpn/forward.c b/src/openvpn/for=
ward.c</span><br><span>index 0b8b262..ed4cdb4 100644</span><br><span>--- a/=
src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br=
><span>@@ -1308,26 +1308,11 @@</span><br><span>     c-&gt;c2.buf =3D c-&gt;=
c2.buffers-&gt;read_tun_buf;</span><br><span> </span><br><span> #ifdef _WIN=
32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c1.tu=
ntap-&gt;backend_driver =3D=3D WINDOWS_DRIVER_WINTUN)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        read_wintun(c-&gt;c1.tuntap, &amp;c-&gt;c2.buf);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;c2.buf=
.len =3D=3D -1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            regist=
er_signal(c-&gt;sig, SIGHUP, &quot;tun-abort&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            c-&gt;persist.restart_sleep_sec=
onds =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  msg(M_INFO, &quot;Wintun read error, restarting&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            perf_pop();</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            return;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* we cannot =
end up here when using dco */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        ASSERT(!dco_enabled(&amp;c-&gt;options));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* we cannot end up here when usi=
ng dco */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT=
(!dco_enabled(&amp;c-&gt;options));</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        sockethandle_t sh =3D { .is_handle =
=3D true, .h =3D c-&gt;c1.tuntap-&gt;hand, .prepend_sa =3D false };</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        sockethandle_finalize=
(sh, &amp;c-&gt;c1.tuntap-&gt;reads, &amp;c-&gt;c2.buf, NULL);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    sockethandle_t sh =3D { .is_handle =3D true,=
 .h =3D c-&gt;c1.tuntap-&gt;hand, .prepend_sa =3D false };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    sockethandle_finalize(sh, &amp;c=
-&gt;c1.tuntap-&gt;reads, &amp;c-&gt;c2.buf, NULL);</span><br><span> #else =
 /* ifdef _WIN32 */</span><br><span>     ASSERT(buf_init(&amp;c-&gt;c2.buf,=
 c-&gt;c2.frame.buf.headroom));</span><br><span>     ASSERT(buf_safe(&amp;c=
-&gt;c2.buf, c-&gt;c2.frame.buf.payload_size));</span><br><span>@@ -1942,7 =
+1927,7 @@</span><br><span> #endif</span><br><span> </span><br><span> #ifde=
f _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        size =
=3D write_tun_buffered(c-&gt;c1.tuntap, &amp;c-&gt;c2.to_tun);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        size =3D tun_write_win32=
(c-&gt;c1.tuntap, &amp;c-&gt;c2.to_tun);</span><br><span> #else</span><br><=
span>         if (c-&gt;c1.tuntap-&gt;backend_driver =3D=3D DRIVER_AFUNIX)<=
/span><br><span>         {</span><br><span>@@ -2148,17 +2133,6 @@</span><br=
><span>         tuntap |=3D EVENT_READ;</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tuntap_is_wintun=
(c-&gt;c1.tuntap))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-         * With wintun we are =
only interested in read event. Ring buffer is</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-         * always ready for write, so we don&#39;t =
do wait.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tuntap =3D EVEN=
T_READ;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /*</span><br><span>  =
    * Configure event wait based on socket, tuntap flags.</span><br><span> =
     */</span><br><span>@@ -2217,36 +2191,8 @@</span><br><span>     }</span=
><br><span>     else</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        bool skip_iowait =3D flags &amp; IOW_TO_TUN;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (flags &amp; IOW_RE=
AD_TUN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            /*</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-             * don&#39;t read fro=
m tun if we have pending write to link,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-             * since every tun read overwrites to_link bu=
ffer filled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
   * by previous tun read</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-             */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          skip_iowait =3D !(flags &amp; IOW_TO_LINK);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (tuntap_is_wintun(c-&gt;c1.tuntap) &amp;&amp=
; skip_iowait)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            unsigne=
d int ret =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       if (flags &amp; IOW_TO_TUN)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                ret |=3D TUN_WRITE;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            if (flags &amp; IOW_READ_TUN)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                ret |=3D TUN_READ;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            multi_io-&gt;udp_flags =3D ret;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef _WIN32 */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            /* slow path - delegate to io_wait_dowo=
rk_udp to calculate flags */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            get_io_flags_dowork_udp(c, multi_io, flags);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* slow path - delegate to io_wai=
t_dowork_udp to calculate flags */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        get_io_flags_dowork_udp(c, multi_io, flags);</span><=
br><span>     }</span><br><span> }</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br><span>index =
77892d6..74c6036 100644</span><br><span>--- a/src/openvpn/forward.h</span><=
br><span>+++ b/src/openvpn/forward.h</span><br><span>@@ -360,12 +360,6 @@</=
span><br><span>     {</span><br><span>         flags |=3D IOW_TO_TUN;</span=
><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tunt=
ap_ring_empty(c-&gt;c1.tuntap))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  flags &amp;=3D ~IOW_READ_TUN;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
</span><br><span>     return flags;</span><br><span> }</span><br><span> </s=
pan><br><span>@@ -393,36 +387,8 @@</span><br><span>     }</span><br><span> =
    else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#ifdef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        bool skip_iowait =3D flags &amp; IOW_TO_TUN;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (flags &amp; IOW_READ_TUN)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            /*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-             * don&#39;t read from tun if w=
e have pending write to link,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-             * since every tun read overwrites to_link buffer fille=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             * by pr=
evious tun read</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
       */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
skip_iowait =3D !(flags &amp; IOW_TO_LINK);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (tuntap_is_wintun(c-&gt;c1.tuntap) &amp;&amp; skip_iow=
ait)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            unsigned int ret =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if =
(flags &amp; IOW_TO_TUN)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           ret |=3D TUN_WRITE;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            if (flags &amp; IOW_READ_TUN)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                ret |=3D TUN_READ;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            c-&gt;c2.event_set_status =3D ret;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif /* ifdef _WIN32 */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            /* slow path */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            io_wait_dowork(c, flags);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* slow path */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        io_wait_dowork(c, flags);</span><br>=
<span>     }</span><br><span> }</span><br><span> </span><br><span>diff --gi=
t a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 54dfc72..=
7158d5c 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++=
 b/src/openvpn/mudp.c</span><br><span>@@ -457,11 +457,5 @@</span><br><span>=
     {</span><br><span>         flags |=3D IOW_READ;</span><br><span>     }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tuntap_ring_empty(m-&=
gt;top.c1.tuntap))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        flags &amp;=
=3D ~IOW_READ_TUN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan>     return flags;</span><br><span> }</span><br><span>diff --git a/src/=
openvpn/multi_io.c b/src/openvpn/multi_io.c</span><br><span>index f4ca4df..=
7f47319 100644</span><br><span>--- a/src/openvpn/multi_io.c</span><br><span=
>+++ b/src/openvpn/multi_io.c</span><br><span>@@ -190,20 +190,6 @@</span><b=
r><span>         get_io_flags_udp(&amp;m-&gt;top, m-&gt;multi_io, p2mp_iow_=
flags(m));</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (tuntap_is_wintun(m-&gt;top.c1.tuntap))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (!tuntap_ring_empty(m-&gt;top.c=
1.tuntap))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* there is=
 data in wintun ring buffer, read it immediately */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            m-&gt;multi_io-&gt;esr[0].arg =
=3D MULTI_IO_TUN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        m-&gt;multi_io-&gt;esr[0].rwflags =3D EVENT_READ;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            m-&gt;multi_io-&gt;n_esr =
=3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret=
urn 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        persistent =3D NULL=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     tun_set(=
m-&gt;top.c1.tuntap, m-&gt;multi_io-&gt;es, EVENT_READ, MULTI_IO_TUN, persi=
stent);</span><br><span> #if defined(ENABLE_DCO) \</span><br><span>     &am=
p;&amp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET=
_WIN32))</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/o=
ptions.c</span><br><span>index 02970a7..55b923c 100644</span><br><span>--- =
a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><=
br><span>@@ -750,10 +750,6 @@</span><br><span>     &quot;                  =
     optional parameter controls the initial state of ex.\n&quot;</span><br=
><span>     &quot;--show-net-up   : Show &quot; PACKAGE_NAME &quot;&#39;s v=
iew of routing table and net adapter list\n&quot;</span><br><span>     &quo=
t;                  after TAP adapter is up and routes have been added.\n&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;--windo=
ws-driver   : Which tun driver to use?\n&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    &quot;                     ovpn-dco (default)\=
n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;    =
                 tap-windows6\n&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    &quot;                     wintun\n&quot;</span><br><sp=
an>     &quot;--block-outside-dns   : Block DNS on other network adapters t=
o prevent DNS leaks\n&quot;</span><br><span>     &quot;Windows Standalone O=
ptions:\n&quot;</span><br><span>     &quot;\n&quot;</span><br><span>@@ -259=
2,11 +2588,6 @@</span><br><span>                 prefix);</span><br><span> =
        }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (op=
tions-&gt;windows_driver =3D=3D WINDOWS_DRIVER_WINTUN &amp;&amp; dev !=3D D=
EV_TYPE_TUN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_USAGE, &quo=
t;--windows-driver wintun requires --dev tun&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> #endif /* ifdef _WIN=
32 */</span><br><span> </span><br><span>     /*</span><br><span>@@ -3371,9 =
+3362,8 @@</span><br><span> #ifdef _WIN32</span><br><span>     const int de=
v =3D dev_type_enum(options-&gt;dev, options-&gt;dev_type);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* when using w=
intun/ovpn-dco, kernel doesn&#39;t send DHCP requests, so don&#39;t use it =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((options-&g=
t;windows_driver =3D=3D WINDOWS_DRIVER_WINTUN</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-         || options-&gt;windows_driver =3D=3D DRIVE=
R_DCO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* when u=
sing ovpn-dco, kernel doesn&#39;t send DHCP requests, so don&#39;t use it *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((options-&=
gt;windows_driver =3D=3D DRIVER_DCO)</span><br><span>         &amp;&amp; (o=
ptions-&gt;tuntap_options.ip_win32_type =3D=3D IPW32_SET_DHCP_MASQ</span><b=
r><span>             || options-&gt;tuntap_options.ip_win32_type =3D=3D IPW=
32_SET_ADAPTIVE))</span><br><span>     {</span><br><span>@@ -4665,39 +4655,=
6 @@</span><br><span>     return ret;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * Parses --windows-driver config option</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * @param str       value of --windows-driver op=
tion</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param msgleve=
l  msglevel to report parsing error</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * @return enum tun_driver_type  driver type, WINDOWS_DRIVER_=
UNSPECIFIED on unknown --windows-driver value</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-static enum tun_driver_type</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-parse_windows_driver(const char *str, const int msglevel)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (streq(str, &quot;tap-windows6&quot;))</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        return WINDOWS_DRIVER_TAP_WINDO=
WS6;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(str, &quot;win=
tun&quot;))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        return WINDOWS_DRI=
VER_WINTUN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    else if (streq(str, &quot;ovpn-dco&quot;))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return DRIVER_DCO;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     msg(msglevel, &quot;--windows-driver must be tap-windows6, wintun &quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;o=
r ovpn-dco&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return WINDOWS_DRIVER_UNSPECIFIED;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef _W=
IN32 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an> /*</span><br><span>  * parse/print topology coding</span><br><span>  */=
</span><br><span>@@ -6012,7 +5969,8 @@</span><br><span>     else if (streq(=
p[0], &quot;windows-driver&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><=
br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;wi=
ndows_driver =3D parse_windows_driver(p[1], M_FATAL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;DEPRECATED OPTI=
ON: windows-driver: In OpenVPN 2.7, the default Windows driver is ovpn-dco.=
 &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
&quot;If incompatible options are used, OpenVPN will fall back to tap-windo=
ws6. Wintun support has been removed.&quot;);</span><br><span>     }</span>=
<br><span> #endif</span><br><span>     else if (streq(p[0], &quot;disable-d=
co&quot;))</span><br><span>diff --git a/src/openvpn/ring_buffer.h b/src/ope=
nvpn/ring_buffer.h</span><br><span>deleted file mode 100644</span><br><span=
>index c536980..0000000</span><br><span>--- a/src/openvpn/ring_buffer.h</sp=
an><br><span>+++ /dev/null</span><br><span>@@ -1,125 +0,0 @@</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *  OpenVPN -- An application to securely tunnel IP net=
works</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *             o=
ver a single UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *             session authentication and k=
ey exchange,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *       =
      packet encryption, packet authentication, and</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *             packet compression.</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  Copyright (C) 2002-2024 OpenVPN Inc &lt;sales=
@...515...&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *     =
           2019 Lev Stipakov &lt;lev@...515...&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *  This program is free software; you can redistribute it and/or=
 modify</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  it under t=
he terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  as published by the Free Software Found=
ation.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *  This program is distributed in=
 the hope that it will be useful,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *  but WITHOUT ANY WARRANTY; without even the implied warranty=
 of</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  MERCHANTABILIT=
Y or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  GNU General Public License for more details.<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  with this program; if not, write to the Free Software Foun=
dation, Inc.,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 F=
ranklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifde=
f _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef OPENV=
PN_RING_BUFFER_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne OPENVPN_RING_BUFFER_H</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;windo=
ws.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;=
winioctl.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;stdint.h&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;stdbool.h&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * Values below are taken from Wireguard Windows client</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * https://github.com/Wir=
eGuard/wireguard-go/blob/master/tun/wintun/ring_windows.go#L14</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define WINTUN_RING_CAPACITY        0x800000</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define WINTUN_RING_TRAILING_=
BYTES  0x10000</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 WINTUN_MAX_PACKET_SIZE      0xffff</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define WINTUN_PACKET_ALIGN         4</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define TUN_IOCTL_REGISTER_RINGS CTL_CODE(51820U, 0x970U, METHOD=
_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Wintun ring b=
uffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * See https://g=
ithub.com/WireGuard/wintun#ring-layout</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
truct tun_ring</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    volatile ULONG head;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    volatile ULONG tail;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    volatile LONG ale=
rtable;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    UCHAR data=
[WINTUN_RING_CAPACITY + WINTUN_RING_TRAILING_BYTES];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * Struct for ring buffers=
 registration</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * See h=
ttps://github.com/WireGuard/wintun#registering-rings</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-struct tun_register_rings</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        ULONG ring_size;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct tun_ring *r=
ing;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        HANDLE ta=
il_moved;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    } send, =
receive;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-struct TUN_PACKET_HEADER</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    uint32_t size;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-struct TUN_PACKET</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    uint32_t size;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    UCHAR data[WINTUN_MAX_PACKET_SIZE];</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * Registers ring buffers used=
 to exchange data between</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * userspace openvpn process and wintun kernel driver,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * see https://github.com/WireGuard/wi=
ntun#registering-rings</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param device  =
            handle to opened wintun device</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * @param send_ring           pointer to send ring</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param receive_ring   =
     pointer to receive ring</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * @param send_tail_moved     event set by wintun to signal openvpn<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *                    =
        that data is available for reading in send ring</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * @param receive_tail_moved  event set b=
y openvpn to signal wintun</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *                            that data has been written to receive ri=
ng</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return         =
           true if registration is successful, false otherwise - use GetLas=
tError()</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-register_ring_buffers(HANDLE devic=
e,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
   struct tun_ring *send_ring,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                      struct tun_ring *receive_ring,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                      HANDLE send_t=
ail_moved,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
           HANDLE receive_tail_moved)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
struct tun_register_rings rr;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    BOOL res;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    DWORD bytes_returned;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ZeroMemory(&a=
mp;rr, sizeof(rr));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    rr.send.ring =3D se=
nd_ring;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    rr.send.r=
ing_size =3D sizeof(struct tun_ring);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    rr.send.tail_moved =3D send_tail_moved;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    rr.receive.ring =3D receive_ring;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    rr.receive.ring_size =3D sizeof(struct=
 tun_ring);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    rr.rec=
eive.tail_moved =3D receive_tail_moved;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 res =3D DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &amp;rr, sizeof(=
rr),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
         NULL, 0, &amp;bytes_returned, NULL);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return res !=3D FALSE;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef OPENVPN_RING_BUF=
FER_H */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifd=
ef _WIN32 */</span><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/t=
un.c</span><br><span>index 6a2043e..d7c38a1 100644</span><br><span>--- a/sr=
c/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ =
-63,9 +63,6 @@</span><br><span>         case WINDOWS_DRIVER_TAP_WINDOWS6:</=
span><br><span>             return &quot;tap-windows6&quot;;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case WINDO=
WS_DRIVER_WINTUN:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        return &quot;wintun&quot;;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span>         case DRIVER_GENERIC_TUNTAP:</span><b=
r><span>             return &quot;tun/tap&quot;;</span><br><span> </span><b=
r><span>@@ -473,10 +470,6 @@</span><br><span>             t =3D ADAPTER_TYP=
E_TAP;</span><br><span>             break;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        case WINDOWS_DRIVER_WINTUN:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            t =3D ADAP=
TER_TYPE_WINTUN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>         case DRIVER_DCO:</span><br><span>             t =3D ADAPT=
ER_TYPE_DCO;</span><br><span>             break;</span><br><span>@@ -1040,3=
7 +1033,8 @@</span><br><span>     overlapped_io_init(&amp;tt-&gt;writes, fr=
ame, TRUE);</span><br><span>     tt-&gt;adapter_index =3D TUN_ADAPTER_INDEX=
_INVALID;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_WINTUN)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        tt-&gt;wintun_send_ring_handle =3D Crea=
teFileMapping(INVALID_HANDLE_VALUE, NULL,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                                       =
 PAGE_READWRITE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                                                   0,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                           =
             sizeof(struct tun_ring),</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                                        NUL=
L);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tt-&gt;win=
tun_receive_ring_handle =3D CreateFileMapping(INVALID_HANDLE_VALUE,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
                              NULL,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                                                           PA=
GE_READWRITE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                                                   0,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                           =
                sizeof(struct tun_ring),</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                                        =
   NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
(tt-&gt;wintun_send_ring_handle =3D=3D NULL) || (tt-&gt;wintun_receive_ring=
_handle =3D=3D NULL))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
msg(M_FATAL, &quot;Cannot allocate memory for ring buffer&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        tt-&gt;rw_handle.read =3D CreateEvent(NULL, FALSE, FALSE=
, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tt-&g=
t;rw_handle.write =3D CreateEvent(NULL, FALSE, FALSE, NULL);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if ((tt-&gt;rw_handle.read =3D=3D NULL) || (tt-&g=
t;rw_handle.write =3D=3D NULL))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          msg(M_FATAL, &quot;Cannot create events for ring buffer&quot;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   tt-&gt;rw_handle.read =3D tt-&gt;reads.overlapped.hEvent;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        tt-&gt;rw_handle.write =3D t=
t-&gt;writes.overlapped.hEvent;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
tt-&gt;rw_handle.read =3D tt-&gt;reads.overlapped.hEvent;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;rw_handle.write =3D tt-&gt=
;writes.overlapped.hEvent;</span><br><span> #endif /* ifdef _WIN32 */</span=
><br><span> }</span><br><span> </span><br><span>@@ -4010,10 +3974,6 @@</spa=
n><br><span>                     {</span><br><span>                        =
 windows_driver =3D WINDOWS_DRIVER_TAP_WINDOWS6;</span><br><span>          =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           else if (strcasecmp(component_id, WINTUN_COMPONENT_ID) =3D=3D 0)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
   windows_driver =3D WINDOWS_DRIVER_WINTUN;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    }</span><br><span>              =
       else if (strcasecmp(component_id, &quot;ovpn-dco&quot;) =3D=3D 0)</s=
pan><br><span>                     {</span><br><span>                      =
   windows_driver =3D DRIVER_DCO;</span><br><span>@@ -4320,7 +4280,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> /*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Lookup a TAP-Windows or Wintun adapter b=
y GUID.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Lookup an=
 adapter by GUID.</span><br><span>  */</span><br><span> static const struct=
 tap_reg *</span><br><span> get_adapter_by_guid(const char *guid, const str=
uct tap_reg *tap_reg)</span><br><span>@@ -4375,7 +4335,7 @@</span><br><span=
> {</span><br><span>     if (!tap_reg)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;There ar=
e no TAP-Windows, Wintun or ovpn-dco adapters &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;There are no T=
AP-Windows or ovpn-dco adapters &quot;</span><br><span>             &quot;o=
n this system.  You should be able to create an adapter &quot;</span><br><s=
pan>             &quot;by using tapctl.exe utility.&quot;);</span><br><span=
>     }</span><br><span>@@ -6086,46 +6046,6 @@</span><br><span>     gc_free=
(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-service_register_ring_buffers(const struct tuntap *tt)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    HANDLE msg_channel =3D tt-&gt;options.msg_=
channel;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ack_messa=
ge_t ack;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret=
 =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    register_ring=
_buffers_message_t msg =3D {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        .header =3D {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg_register_ring_buffers,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            sizeof(register_ring_buffers_message_t)=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            0</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        },</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        .device =3D tt-&gt;hand,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        .send_ring_handle =
=3D tt-&gt;wintun_send_ring_handle,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        .receive_ring_handle =3D tt-&gt;wintun_receive_ring_h=
andle,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        .send_t=
ail_moved =3D tt-&gt;rw_handle.read,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        .receive_tail_moved =3D tt-&gt;rw_handle.write</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    };</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (!send_msg_iservice(msg_channel, &amp;msg, sizeof(msg), =
&amp;ack, &quot;Register ring buffers&quot;))</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        ret =3D false;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    els=
e if (ack.error_number !=3D NO_ERROR)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        msg(M_NONFATAL, &quot;Register ring buffers failed using service: %=
s [status=3D0x%x]&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            strerror_win32(ack.error_number, &amp;gc), ack.error_number)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =3D fals=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        msg(M_INFO, &quot;Ring buffers registered via service&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    return ret;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> void</span><br><span> fork_register_dns_action(struct tuntap =
*tt)</span><br><span> {</span><br><span>@@ -6363,58 +6283,6 @@</span><br><s=
pan>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-wintun_register_ring_buffer(struct tuntap *=
tt, const char *device_guid)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    tt-&gt;wintun_send_ring =3D (=
struct tun_ring *)MapViewOfFile(tt-&gt;wintun_send_ring_handle,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
                           FILE_MAP_ALL_ACCESS,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                                 =
           0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                                                    0,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                          =
                  sizeof(struct tun_ring));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    tt-&gt;wintun_receive_ring =3D (struct tun_ring *)MapViewOfFile(tt-&gt=
;wintun_receive_ring_handle,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                                                               FILE_=
MAP_ALL_ACCESS,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                                                         0,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
                          0,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                                                               sizeo=
f(struct tun_ring));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;options=
.msg_channel)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =3D service_=
register_ring_buffers(tt);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (!register_ring_buffers(tt-&g=
t;hand,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
                     tt-&gt;wintun_send_ring,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                   tt-&gt;wintun_re=
ceive_ring,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                         tt-&gt;rw_handle.read,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                   tt-&gt;rw_hand=
le.write))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            switch (Get=
LastError())</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                c=
ase ERROR_ACCESS_DENIED:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    msg(M_FATAL, &quot;ERROR:  Wintun requires SYSTEM pr=
ivileges and therefore &quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                        &quot;should be used with interactive servi=
ce. If you want to &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                        &quot;use openvpn from command line, you need t=
o do SYSTEM &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                     &quot;elevation yourself (for example with psexec).&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                case ERROR_ALREA=
DY_INITIALIZED:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              msg(M_NONFATAL, &quot;Adapter %s is already in use&quot;, dev=
ice_guid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                default:</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    msg(=
M_NONFATAL | M_ERRNO, &quot;Failed to register ring buffers&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            ret =3D false;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</=
span><br><span> tuntap_set_connected(const struct tuntap *tt)</span><br><sp=
an> {</span><br><span>@@ -6574,8 +6442,7 @@</span><br><span>     const char=
 *path =3D NULL;</span><br><span>     char tuntap_device_path[256];</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-=
&gt;backend_driver =3D=3D WINDOWS_DRIVER_WINTUN</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        || tt-&gt;backend_driver =3D=3D DRIVER_DC=
O)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;ba=
ckend_driver =3D=3D DRIVER_DCO)</span><br><span>     {</span><br><span>    =
     const struct device_instance_id_interface *dev_if;</span><br><span> </=
span><br><span>@@ -6629,18 +6496,6 @@</span><br><span>         return false=
;</span><br><span>     }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_WI=
NTUN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        /* Wintun adapter may be=
 considered &quot;open&quot; after ring buffers are successfuly registered.=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!wintu=
n_register_ring_buffer(tt, device_guid))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(D_TUNTAP_INFO, &quot;Failed to register %s adapter r=
ing buffers&quot;, device_guid);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            CloseHandle(tt-&gt;hand);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            tt-&gt;hand =3D NULL;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            return false;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span>     return true;</span><br><span> }</span=
><br><span> </span><br><span>@@ -6988,16 +6843,6 @@</span><br><span>       =
  }</span><br><span>         tt-&gt;hand =3D NULL;</span><br><span>     }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;backend_driver =3D=3D WINDOW=
S_DRIVER_WINTUN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        CloseHandle(t=
t-&gt;rw_handle.read);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        CloseHandle(tt-&gt;rw_handle.write);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        UnmapViewOfFile(tt-&gt;wintun_send_ring);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        UnmapViewOfFile=
(tt-&gt;wintun_receive_ring);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        CloseHandle(tt-&gt;wintun_send_ring_handle);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        CloseHandle(tt-&gt;wintun_re=
ceive_ring_handle);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span> }</span><br><span> </span><br><span> void</span><br><s=
pan>diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>inde=
x bcc23b4..de1876a 100644</span><br><span>--- a/src/openvpn/tun.h</span><br=
><span>+++ b/src/openvpn/tun.h</span><br><span>@@ -39,13 +39,11 @@</span><b=
r><span> #include &quot;proto.h&quot;</span><br><span> #include &quot;misc.=
h&quot;</span><br><span> #include &quot;networking.h&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#include &quot;ring_buffer.h&quot;</sp=
an><br><span> #include &quot;dco.h&quot;</span><br><span> </span><br><span>=
 enum tun_driver_type {</span><br><span>     WINDOWS_DRIVER_UNSPECIFIED,</s=
pan><br><span>     WINDOWS_DRIVER_TAP_WINDOWS6,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    WINDOWS_DRIVER_WINTUN,</span><br><span>     D=
RIVER_GENERIC_TUNTAP,</span><br><span>     /** using an AF_UNIX socket to p=
ass packets from/to an external program.</span><br><span>      *  This is a=
lways defined. We error out if a user tries to open this type</span><br><sp=
an>@@ -58,7 +56,6 @@</span><br><span> };</span><br><span> </span><br><span>=
 #ifdef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 WINTUN_COMPONENT_ID &quot;wintun&quot;</span><br><span> #define DCO_WIN_RE=
FERENCE_STRING &quot;ovpn-dco&quot;</span><br><span> #endif</span><br><span=
> </span><br><span>@@ -233,11 +230,7 @@</span><br><span> </span><br><span> =
    int standby_iter;</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    HANDLE wintun_send_ring_handle;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    HANDLE wintun_receive_ring_handle;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tun_ring *wintu=
n_send_ring;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t tun_ring *wintun_receive_ring;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#else  /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    #else  /* ifdef _WIN32 */</span><br><span>     int fd;=
 /* file descriptor for TUN/TAP dev */</span><br><span> #endif /* ifdef _WI=
N32 */</span><br><span> </span><br><span>@@ -262,20 +255,6 @@</span><br><sp=
an> #endif</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-tuntap_is_wintun(struct tuntap *tt)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    return tt &amp;&amp; tt-&gt;backend_driver =3D=3D WINDOWS_DRIV=
ER_WINTUN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static inline bool</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-tuntap_ring_empty(struct tuntap *tt)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return tuntap_is_wintun(tt) &amp;&amp; (tt-&gt;wintun_se=
nd_ring-&gt;head =3D=3D tt-&gt;wintun_send_ring-&gt;tail);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> /*</span><br><span>  * Function prototypes</span><br><s=
pan>  */</span><br><span>@@ -526,74 +505,6 @@</span><br><span> </span><br><=
span> int tun_write_win32(struct tuntap *tt, struct buffer *buf);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline=
 ULONG</span><br><span style=3D"color: hsl(0, 100%, 40%);">-wintun_ring_pac=
ket_align(ULONG size)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (size + (=
WINTUN_PACKET_ALIGN - 1)) &amp; ~(WINTUN_PACKET_ALIGN - 1);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic inline ULONG</span><br><span style=3D"color: hsl(0, 100%, 40%);">-wintu=
n_ring_wrap(ULONG value)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return value =
&amp; (WINTUN_RING_CAPACITY - 1);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-read_wintun(struct tuntap *tt, s=
truct buffer *buf)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tun_ring *ri=
ng =3D tt-&gt;wintun_send_ring;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    ULONG head =3D ring-&gt;head;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    ULONG tail =3D ring-&gt;tail;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    ULONG content_len;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct TUN_PACKET *packet;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    ULONG aligned_packet_size;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    *buf =3D tt-&gt;reads.buf_init;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    buf-&gt;len =3D 0;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if ((head &gt;=3D WINTUN_RING_CAPACITY) || (t=
ail &gt;=3D WINTUN_RING_CAPACITY))</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     msg(M_INFO, &quot;Wintun: ring capacity exceeded&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        buf-&gt;len =3D -1;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (head =3D=3D tail)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /=
* nothing to read */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    content_len =3D wintun_ring_wrap(tail -=
 head);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (conten=
t_len &lt; sizeof(struct TUN_PACKET_HEADER))</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        msg(M_INFO, &quot;Wintun: incomplete packet header in send r=
ing&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bu=
f-&gt;len =3D -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    packet =3D (struct TUN_PACKET *) &amp;ring-=
&gt;data[head];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (packet-&gt;size &gt; WINTUN_MAX_PACKET_SIZE)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(M_INFO, &quot;Wintun: packet too big in send ring&quot=
;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf-&gt;le=
n =3D -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    aligned_packet_size =3D wintun_ring_packet_align(si=
zeof(struct TUN_PACKET_HEADER) + packet-&gt;size);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (aligned_packet_size &gt; content_len)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;Wintun: inco=
mplete packet in send ring&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        buf-&gt;len =3D -1;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_write(buf, packe=
t-&gt;data, packet-&gt;size);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    head =3D =
wintun_ring_wrap(head + aligned_packet_size);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    ring-&gt;head =3D head;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> static inline bool</span><br><span> is_ip_pac=
ket_valid(const struct buffer *buf)</span><br><span> {</span><br><span>@@ -=
621,65 +532,6 @@</span><br><span>     return true;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static in=
line int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_wintun(=
struct tuntap *tt, struct buffer *buf)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 struct tun_ring *ring =3D tt-&gt;wintun_receive_ring;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    ULONG head =3D ring-&gt;head;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ULONG tail =3D ring-&gt;ta=
il;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ULONG aligned_=
packet_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ULONG=
 buf_space;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct=
 TUN_PACKET *packet;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* wintun marks ri=
ng as corrupted (overcapacity) if it receives invalid IP packet */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (!is_ip_packet_valid(bu=
f))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        msg(D_LOW, &quot;write_win=
tun(): drop invalid IP packet&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((head &gt;=3D WIN=
TUN_RING_CAPACITY) || (tail &gt;=3D WINTUN_RING_CAPACITY))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;write_wintun(): head/tail va=
lue is over capacity&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        return -1;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    aligned_packet_size =3D wintu=
n_ring_packet_align(sizeof(struct TUN_PACKET_HEADER) + BLEN(buf));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    buf_space =3D wintun_ring_=
wrap(head - tail - WINTUN_PACKET_ALIGN);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (aligned_packet_size &gt; buf_space)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;write_wintun(): ring is =
full&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
eturn 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* copy packet size and data into ring */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet =3D (struct TUN=
_PACKET * )&amp;ring-&gt;data[tail];</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    packet-&gt;size =3D BLEN(buf);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    memcpy(packet-&gt;data, BPTR(buf), BLEN(buf=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* move ring tail */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    ring-&gt;tail =3D wintun_ring_wr=
ap(tail + aligned_packet_size);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (ring-&gt;alertable !=3D 0)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        SetEvent(tt-&gt;rw_handle.write);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 BLEN(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-write_tun_buffered(struct tuntap *tt, struct buffer *bu=
f)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;backend_driver =3D=3D WI=
NDOWS_DRIVER_WINTUN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return wr=
ite_wintun(tt, buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        return tun_write_win32(tt, buf);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> static inline bool</span><br><span> tuntap_is=
_dco_win(struct tuntap *tt)</span><br><span> {</span><br><span>diff --git a=
/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c</span><b=
r><span>index 30db644..4ff1b70 100644</span><br><span>--- a/src/openvpnmsic=
a/openvpnmsica.c</span><br><span>+++ b/src/openvpnmsica/openvpnmsica.c</spa=
n><br><span>@@ -320,11 +320,6 @@</span><br><span>         L&quot;ACTIVETAPW=
INDOWS6ADAPTERS&quot;);</span><br><span>     find_adapters(</span><br><span=
>         hInstall,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      L&quot;Wintun&quot; L&quot;\0&quot;,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        L&quot;WINTUNADAPTERS&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        L&quot;ACTIVEWINTUNADAPTERS&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    find_adapters=
(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        hInstall,</s=
pan><br><span>         L&quot;ovpn-dco&quot; L&quot;\0&quot;,</span><br><sp=
an>         L&quot;OVPNDCOADAPTERS&quot;,</span><br><span>         L&quot;A=
CTIVEOVPNDCOADAPTERS&quot;);</span><br><span>diff --git a/src/openvpnmsica/=
openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h</span><br><span>index 761a=
a47..9898067 100644</span><br><span>--- a/src/openvpnmsica/openvpnmsica.h</=
span><br><span>+++ b/src/openvpnmsica/openvpnmsica.h</span><br><span>@@ -88=
,10 +88,6 @@</span><br><span>  *   ACTIVETAPWINDOWS6ADAPTERS properties wit=
h semicolon delimited list of all installed adapter</span><br><span>  *   G=
UIDs and active adapter GUIDs respectively.</span><br><span>  *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * - Finds existing Wintun adapte=
rs and set WINTUNADAPTERS and ACTIVEWINTUNADAPTERS properties</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *   with semicolon delimited list =
of all installed adapter GUIDs and active adapter GUIDs</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *   respectively.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span>  * - Finds existing ovp=
n-dco adapters and set OVPNDCOADAPTERS and ACTIVEOVPNDCOADAPTERS properties=
</span><br><span>  *   with semicolon delimited list of all installed adapt=
er GUIDs and active adapter GUIDs</span><br><span>  *   respectively.</span=
><br><span>diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CM=
akeLists.txt</span><br><span>index 44a40fe..7e3efb2 100644</span><br><span>=
--- a/src/openvpnserv/CMakeLists.txt</span><br><span>+++ b/src/openvpnserv/=
CMakeLists.txt</span><br><span>@@ -20,7 +20,6 @@</span><br><span>     ../ta=
pctl/basic.h</span><br><span>     ../openvpn/wfp_block.c ../openvpn/wfp_blo=
ck.h</span><br><span>     openvpnserv_resources.rc</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ../openvpn/ring_buffer.h</span><br><span> =
    )</span><br><span> target_compile_options(openvpnserv PRIVATE</span><br=
><span>     -D_UNICODE</span><br><span>diff --git a/src/openvpnserv/Makefil=
e.am b/src/openvpnserv/Makefile.am</span><br><span>index f053f40..852746d 1=
00644</span><br><span>--- a/src/openvpnserv/Makefile.am</span><br><span>+++=
 b/src/openvpnserv/Makefile.am</span><br><span>@@ -36,5 +36,4 @@</span><br>=
<span> 	service.c service.h \</span><br><span> 	validate.c validate.h \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/wfp_block.c $(top_srcdir)/src/open=
vpn/wfp_block.h \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	ope=
nvpnserv_resources.rc \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	$(top_srcdir)/src/openvpn/ring_buffer.h</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	openvpnserv_resources.rc</span><br><span>diff --git=
 a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br>=
<span>index 8a7b50d..5f842bd 100644</span><br><span>--- a/src/openvpnserv/i=
nteractive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br>=
<span>@@ -40,7 +40,6 @@</span><br><span> #include &quot;openvpn-msg.h&quot;=
</span><br><span> #include &quot;validate.h&quot;</span><br><span> #include=
 &quot;wfp_block.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#include &quot;ring_buffer.h&quot;</span><br><span> </span><br><span> #d=
efine IO_TIMEOUT  2000 /*ms*/</span><br><span> </span><br><span>@@ -90,7 +8=
9,6 @@</span><br><span>     undo_dns6,</span><br><span>     undo_nrpt,</spa=
n><br><span>     undo_domains,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    undo_ring_buffer,</span><br><span>     undo_wins,</span><br><s=
pan>     _undo_type_max</span><br><span> } undo_type_t;</span><br><span>@@ =
-108,11 +106,6 @@</span><br><span>     PWSTR domains;</span><br><span> } dn=
s_domains_undo_data_t;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-typedef struct {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct tun_ring *send_ring;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    struct tun_ring *receive_ring;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-} ring_buffer_maps_t;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> typedef union {</spa=
n><br><span>     message_header_t header;</span><br><span>     address_mess=
age_t address;</span><br><span>@@ -122,7 +115,6 @@</span><br><span>     dns=
_cfg_message_t dns;</span><br><span>     nrpt_dns_cfg_message_t nrpt_dns;</=
span><br><span>     enable_dhcp_message_t dhcp;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    register_ring_buffers_message_t rrb;</span><b=
r><span>     set_mtu_message_t mtu;</span><br><span>     wins_cfg_message_t=
 wins;</span><br><span>     create_adapter_message_t create_adapter;</span>=
<br><span>@@ -188,23 +180,6 @@</span><br><span>     return INVALID_HANDLE_V=
ALUE;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-OvpnUnmapViewOfFile(struct tun_ring **ring)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (ring &amp;&amp; *ring)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        UnmapViewOfFile(*ring);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        *ring =3D NULL;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-UnmapRingBuffer(ring_buffer_maps_t *ring_buffer_m=
aps)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    OvpnUnmapViewOfFile(&amp;ring_buf=
fer_maps-&gt;send_ring);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    OvpnUnmapViewOfFile(&amp;ring_buffer_maps-&gt;receive_ring);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> static HANDLE</span><br><span> =
InitOverlapped(LPOVERLAPPED overlapped)</span><br><span> {</span><br><span>=
@@ -213,7 +188,6 @@</span><br><span>     return overlapped-&gt;hEvent;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> static BOOL</span><br><span> ResetOverlapped(L=
POVERLAPPED overlapped)</span><br><span> {</span><br><span>@@ -2973,119 +29=
47,6 @@</span><br><span> }</span><br><span> </span><br><span> static DWORD<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-OvpnDuplicateHandle(HA=
NDLE ovpn_proc, HANDLE orig_handle, HANDLE *new_handle)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    DWORD err =3D ERROR_SUCCESS;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (!DuplicateHandle(ovpn_proc, orig_handle, GetCurrentProcess(), n=
ew_handle, 0, FALSE, DUPLICATE_SAME_ACCESS))</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        err =3D GetLastError();</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        MsgToEventLog(M_SYSERR, L&quot;Could not duplicate=
 handle&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return err;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static DWORD</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-DuplicateAndMapRing(HAND=
LE ovpn_proc, HANDLE orig_handle, struct tun_ring **ring)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    DWORD err =3D ERROR_SUCCESS;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    HANDLE dup_handle =3D NULL;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
rr =3D OvpnDuplicateHandle(ovpn_proc, orig_handle, &amp;dup_handle);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (err !=3D ERROR_SUCCE=
SS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        return err;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    *ring =3D (struct tun_ring *)MapViewOfFile(dup_h=
andle, FILE_MAP_ALL_ACCESS, 0, 0, sizeof(struct tun_ring));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    CloseHandleEx(&amp;dup_handle);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (*ring =3D=3D NU=
LL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        err =3D GetLastError();</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_=
SYSERR, L&quot;Could not map shared memory&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        return err;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static DWORD</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-HandleRegisterRingBuffers(const register_ring_buffers_message_t *r=
rb, HANDLE ovpn_proc,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                          undo_lists_t *lists)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    DWORD err =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ring_buffer_m=
aps_t *ring_buffer_maps =3D RemoveListItem(&amp;(*lists)[undo_ring_buffer],=
 CmpAny, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ring_buffer_maps)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        UnmapRingBuffer(ring_buffer_map=
s);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    else if ((ring_buffer_maps =3D=
 calloc(1, sizeof(*ring_buffer_maps))) =3D=3D NULL)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return ERROR_OUTOFMEMORY;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    HANDL=
E device =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 HANDLE send_tail_moved =3D NULL;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    HANDLE receive_tail_moved =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    err =3D OvpnDuplicateHandle(ovpn_proc, rrb-&gt;device, &amp;=
device);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (err !=
=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto out;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    err =3D DuplicateAndMapRing(ovpn_proc, rrb-&gt;send_ring=
_handle, &amp;ring_buffer_maps-&gt;send_ring);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (err !=3D ERROR_SUCCESS)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        goto out;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D DuplicateA=
ndMapRing(ovpn_proc, rrb-&gt;receive_ring_handle, &amp;ring_buffer_maps-&gt=
;receive_ring);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (err !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto=
 out;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    err =3D OvpnDuplicateHandle(ovpn_proc, rrb-&gt;se=
nd_tail_moved, &amp;send_tail_moved);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (err !=3D ERROR_SUCCESS)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        goto out;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D OvpnDuplicateHandle=
(ovpn_proc, rrb-&gt;receive_tail_moved, &amp;receive_tail_moved);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (err !=3D ERROR_SUCCESS)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        goto out;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (!register_ring_buffers(device, ring_buffer_maps-&gt;send_ring,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
  ring_buffer_maps-&gt;receive_ring,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                               send_tail_moved, receive_tail=
_moved))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D GetLastError(=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventL=
og(M_SYSERR, L&quot;Could not register ring buffers&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        goto out;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 err =3D AddListItem(&amp;(*lists)[undo_ring_buffer], ring_buffer_maps);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-out:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (err !=3D ERROR_SUCCESS &amp;&amp; ring_buffer_maps)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        UnmapRingBuffer(ring_buffer_ma=
ps);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        free(ring=
_buffer_maps);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CloseHandleEx(&amp;=
device);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CloseHand=
leEx(&amp;send_tail_moved);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    CloseHandleEx(&amp;receive_tail_moved);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    return err;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static DWORD</span>=
<br><span> HandleMTUMessage(const set_mtu_message_t *mtu)</span><br><span> =
{</span><br><span>     DWORD err =3D 0;</span><br><span>@@ -3130,10 +2991,6=
 @@</span><br><span>             hwid =3D L&quot;root\\tap0901&quot;;</span=
><br><span>             break;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        case ADAPTER_TYPE_WINTUN:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            hwid =3D L&quot;wintun&q=
uot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            brea=
k;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>  =
       default:</span><br><span>             return ERROR_INVALID_PARAMETER=
;</span><br><span>     }</span><br><span>@@ -3238,14 +3095,6 @@</span><br><=
span>             }</span><br><span>             break;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case msg_regist=
er_ring_buffers:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       if (msg.header.size =3D=3D sizeof(msg.rrb))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                HANDLE ovpn_hnd =3D proc_info-&gt;hPro=
cess;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
ack.error_number =3D HandleRegisterRingBuffers(&amp;msg.rrb, ovpn_hnd, list=
s);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         cas=
e msg_set_mtu:</span><br><span>             if (msg.header.size =3D=3D size=
of(msg.mtu))</span><br><span>             {</span><br><span>@@ -3327,10 +31=
76,6 @@</span><br><span>                     }</span><br><span>            =
         break;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                case undo_ring_buffer:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    UnmapRingBuffer(item-&gt;d=
ata);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span>                 case _undo_type_max:</span><br><span>               =
      /* unreachable */</span><br><span>                     break;</span><=
br><span>diff --git a/src/tapctl/main.c b/src/tapctl/main.c</span><br><span=
>index 551a8e6..4569b87 100644</span><br><span>--- a/src/tapctl/main.c</spa=
n><br><span>+++ b/src/tapctl/main.c</span><br><span>@@ -75,8 +75,8 @@</span=
><br><span>     L&quot;               Note: This name can also be specified=
 as OpenVPN&#39;s --dev-node   \n&quot;</span><br><span>     L&quot;       =
        option.                                                         \n&=
quot;</span><br><span>     L&quot;--hwid &lt;hwid&gt;  Adapter hardware ID.=
 Default value is root\\tap0901, which      \n&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    L&quot;               describes tap-win=
dows6 driver. To work with wintun or ovpn-dco  \n&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    L&quot;               driver, specify=
 &#39;wintun&#39; or &#39;ovpn-dco&#39;.                         \n&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;          =
     describes tap-windows6 driver. To work with ovpn-dco driver,    \n&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;      =
         driver, specify &#39;ovpn-dco&#39;.                               =
      \n&quot;</span><br><span>     L&quot;\n&quot;</span><br><span>     L&=
quot;Output:\n&quot;</span><br><span>     L&quot;\n&quot;</span><br><span>@=
@ -94,7 +94,7 @@</span><br><span>     L&quot;\n&quot;</span><br><span>     =
L&quot;Options:\n&quot;</span><br><span>     L&quot;\n&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    L&quot;--hwid &lt;hwid&gt;  Adap=
ter hardware ID. By default, root\\tap0901, tap0901, wintun and \n&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;--hwid &lt;=
hwid&gt;  Adapter hardware ID. By default, root\\tap0901, tap0901 and \n&qu=
ot;</span><br><span>     L&quot;               ovpn-dco adapters are listed=
. Use this switch to limit the list.\n&quot;</span><br><span>     L&quot;\n=
&quot;</span><br><span>     L&quot;Output:\n&quot;</span><br><span>@@ -167,=
10 +167,6 @@</span><br><span>     {</span><br><span>         base_name =3D =
L&quot;OpenVPN Data Channel Offload&quot;;</span><br><span>     }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    else if (wcsicmp(hwid, L&qu=
ot;wintun&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bas=
e_name =3D L&quot;OpenVPN Wintun&quot;;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span>     else if (wcsicmp(hwid, L&quot;=
root\\&quot; _L(TAP_WIN_COMPONENT_ID)) =3D=3D 0)</span><br><span>     {</sp=
an><br><span>         base_name =3D L&quot;OpenVPN TAP-Windows6&quot;;</spa=
n><br><span>@@ -351,7 +347,6 @@</span><br><span>         WCHAR szzHwId[0x10=
0] =3D</span><br><span>             L&quot;root\\&quot; _L(TAP_WIN_COMPONEN=
T_ID) L&quot;\0&quot;</span><br><span>             _L(TAP_WIN_COMPONENT_ID)=
 L&quot;\0&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       L&quot;Wintun\0&quot;</span><br><span>             L&quot;ovpn-dco\0=
&quot;;</span><br><span> </span><br><span>         /* Parse options. */</sp=
an><br><span>diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h</span><br><sp=
an>index 38ea824..c35176c 100644</span><br><span>--- a/src/tapctl/tap.h</sp=
an><br><span>+++ b/src/tapctl/tap.h</span><br><span>@@ -38,7 +38,7 @@</span=
><br><span>  *                      description of the device. This pointer=
 is optional and can be NULL.</span><br><span>  *</span><br><span>  * @para=
m szHwId        A pointer to a NULL-terminated string that supplies the har=
dware id</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *           =
           of the device (e.g. &quot;root\\tap0901&quot;, &quot;Wintun&quot=
;).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *              =
        of the device (e.g. &quot;root\\tap0901&quot;).</span><br><span>  *=
</span><br><span>  * @param pbRebootRequired  A pointer to a BOOL flag. If =
the device requires a system restart,</span><br><span>  *                  =
    this flag is set to TRUE. Otherwise, the flag is left unmodified. This<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1021?usp=3Demail">change 1021</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1021?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I43ec390040bffeec05270271ea7=
fb54fb219c536 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1021 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--oDYoeUPl/uY=--

