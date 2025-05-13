From: Gert Doering <gert@...1296...>
Date: Tue, 13 May 2025 17:09:59 +0200
Message-ID: <20250513151006.13617-1-gert@...1296...>
In-Reply-To: <gerrit.1747046041000.I43ec390040bffeec05270271ea7fb54fb219c536@...2715...>
References: <gerrit.1747046041000.I43ec390040bffeec05270271ea7fb54fb219c536@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] win: remove Wintun support
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

From: Lev Stipakov <lev@...515...>

Since DCO supports modern ciphers and server mode,
there is no reason to support Wintun anymore.

This also removes --windows-driver option support. The
default driver is DCO, as it has been since 2.6. If for
some reasons one doesn't want to use it, --disable-dco
multiplatform option will switch to tap-windows6.

Change-Id: I43ec390040bffeec05270271ea7fb54fb219c536
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1021
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 67f7e1f..40b8c19 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -137,8 +137,7 @@
   Set additional network parameters on supported platforms. May be specified
   on the client or pushed from the server. On Windows these options are
   handled by the ``tap-windows6`` driver by default or directly by OpenVPN
-  if dhcp is disabled or the ``wintun`` driver is in use. The
-  ``OpenVPN for Android`` client also handles them internally.
+  if dhcp is disabled. The ``OpenVPN for Android`` client also handles them internally.
 
   On all other platforms these options are only saved in the client's
   environment under the name :code:`foreign_option_{n}` before the
diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/windows-options.rst
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
-  :code:`tap-windows6` and :code:`wintun`. :code:`ovpn-dco` and :code:`wintun`
-  require ``--dev tun``. :code:`wintun` also requires OpenVPN process to run
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
-openvpn_SOURCES += openvpn_win32_resources.rc wfp_block.c wfp_block.h ring_buffer.h
+openvpn_SOURCES += openvpn_win32_resources.rc wfp_block.c wfp_block.h
 openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi -lbcrypt
 endif
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 7ad9cb3..c61cbda 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -359,14 +359,6 @@
         return false;
     }
 
-    if ((o->windows_driver == WINDOWS_DRIVER_WINTUN)
-        || (o->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6))
-    {
-        msg(msglevel, "--windows-driver is set to '%s'. Disabling Data Channel Offload",
-            print_tun_backend_driver(o->windows_driver));
-        return false;
-    }
-
     if ((o->mode == MODE_SERVER) && o->ce.local_list->len > 1)
     {
         msg(msglevel, "multiple --local options defined, disabling data channel offload");
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 0b8b262..ed4cdb4 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1308,26 +1308,11 @@
     c->c2.buf = c->c2.buffers->read_tun_buf;
 
 #ifdef _WIN32
-    if (c->c1.tuntap->backend_driver == WINDOWS_DRIVER_WINTUN)
-    {
-        read_wintun(c->c1.tuntap, &c->c2.buf);
-        if (c->c2.buf.len == -1)
-        {
-            register_signal(c->sig, SIGHUP, "tun-abort");
-            c->persist.restart_sleep_seconds = 1;
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
 
-        sockethandle_t sh = { .is_handle = true, .h = c->c1.tuntap->hand, .prepend_sa = false };
-        sockethandle_finalize(sh, &c->c1.tuntap->reads, &c->c2.buf, NULL);
-    }
+    sockethandle_t sh = { .is_handle = true, .h = c->c1.tuntap->hand, .prepend_sa = false };
+    sockethandle_finalize(sh, &c->c1.tuntap->reads, &c->c2.buf, NULL);
 #else  /* ifdef _WIN32 */
     ASSERT(buf_init(&c->c2.buf, c->c2.frame.buf.headroom));
     ASSERT(buf_safe(&c->c2.buf, c->c2.frame.buf.payload_size));
@@ -1942,7 +1927,7 @@
 #endif
 
 #ifdef _WIN32
-        size = write_tun_buffered(c->c1.tuntap, &c->c2.to_tun);
+        size = tun_write_win32(c->c1.tuntap, &c->c2.to_tun);
 #else
         if (c->c1.tuntap->backend_driver == DRIVER_AFUNIX)
         {
@@ -2148,17 +2133,6 @@
         tuntap |= EVENT_READ;
     }
 
-#ifdef _WIN32
-    if (tuntap_is_wintun(c->c1.tuntap))
-    {
-        /*
-         * With wintun we are only interested in read event. Ring buffer is
-         * always ready for write, so we don't do wait.
-         */
-        tuntap = EVENT_READ;
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
-        bool skip_iowait = flags & IOW_TO_TUN;
-        if (flags & IOW_READ_TUN)
-        {
-            /*
-             * don't read from tun if we have pending write to link,
-             * since every tun read overwrites to_link buffer filled
-             * by previous tun read
-             */
-            skip_iowait = !(flags & IOW_TO_LINK);
-        }
-        if (tuntap_is_wintun(c->c1.tuntap) && skip_iowait)
-        {
-            unsigned int ret = 0;
-            if (flags & IOW_TO_TUN)
-            {
-                ret |= TUN_WRITE;
-            }
-            if (flags & IOW_READ_TUN)
-            {
-                ret |= TUN_READ;
-            }
-            multi_io->udp_flags = ret;
-        }
-        else
-#endif /* ifdef _WIN32 */
-        {
-            /* slow path - delegate to io_wait_dowork_udp to calculate flags */
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
         flags |= IOW_TO_TUN;
     }
-#ifdef _WIN32
-    if (tuntap_ring_empty(c->c1.tuntap))
-    {
-        flags &= ~IOW_READ_TUN;
-    }
-#endif
     return flags;
 }
 
@@ -393,36 +387,8 @@
     }
     else
     {
-#ifdef _WIN32
-        bool skip_iowait = flags & IOW_TO_TUN;
-        if (flags & IOW_READ_TUN)
-        {
-            /*
-             * don't read from tun if we have pending write to link,
-             * since every tun read overwrites to_link buffer filled
-             * by previous tun read
-             */
-            skip_iowait = !(flags & IOW_TO_LINK);
-        }
-        if (tuntap_is_wintun(c->c1.tuntap) && skip_iowait)
-        {
-            unsigned int ret = 0;
-            if (flags & IOW_TO_TUN)
-            {
-                ret |= TUN_WRITE;
-            }
-            if (flags & IOW_READ_TUN)
-            {
-                ret |= TUN_READ;
-            }
-            c->c2.event_set_status = ret;
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
         flags |= IOW_READ;
     }
-#ifdef _WIN32
-    if (tuntap_ring_empty(m->top.c1.tuntap))
-    {
-        flags &= ~IOW_READ_TUN;
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
-            m->multi_io->esr[0].arg = MULTI_IO_TUN;
-            m->multi_io->esr[0].rwflags = EVENT_READ;
-            m->multi_io->n_esr = 1;
-            return 1;
-        }
-        persistent = NULL;
-    }
-#endif
     tun_set(m->top.c1.tuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, persistent);
 #if defined(ENABLE_DCO) \
     && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 02970a7..55b923c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -750,10 +750,6 @@
     "                       optional parameter controls the initial state of ex.\n"
     "--show-net-up   : Show " PACKAGE_NAME "'s view of routing table and net adapter list\n"
     "                  after TAP adapter is up and routes have been added.\n"
-    "--windows-driver   : Which tun driver to use?\n"
-    "                     ovpn-dco (default)\n"
-    "                     tap-windows6\n"
-    "                     wintun\n"
     "--block-outside-dns   : Block DNS on other network adapters to prevent DNS leaks\n"
     "Windows Standalone Options:\n"
     "\n"
@@ -2592,11 +2588,6 @@
                 prefix);
         }
     }
-
-    if (options->windows_driver == WINDOWS_DRIVER_WINTUN && dev != DEV_TYPE_TUN)
-    {
-        msg(M_USAGE, "--windows-driver wintun requires --dev tun");
-    }
 #endif /* ifdef _WIN32 */
 
     /*
@@ -3371,9 +3362,8 @@
 #ifdef _WIN32
     const int dev = dev_type_enum(options->dev, options->dev_type);
 
-    /* when using wintun/ovpn-dco, kernel doesn't send DHCP requests, so don't use it */
-    if ((options->windows_driver == WINDOWS_DRIVER_WINTUN
-         || options->windows_driver == DRIVER_DCO)
+    /* when using ovpn-dco, kernel doesn't send DHCP requests, so don't use it */
+    if ((options->windows_driver == DRIVER_DCO)
         && (options->tuntap_options.ip_win32_type == IPW32_SET_DHCP_MASQ
             || options->tuntap_options.ip_win32_type == IPW32_SET_ADAPTIVE))
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
- * @return enum tun_driver_type  driver type, WINDOWS_DRIVER_UNSPECIFIED on unknown --windows-driver value
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
-        options->windows_driver = parse_windows_driver(p[1], M_FATAL);
+        msg(M_WARN, "DEPRECATED OPTION: windows-driver: In OpenVPN 2.7, the default Windows driver is ovpn-dco. "
+            "If incompatible options are used, OpenVPN will fall back to tap-windows6. Wintun support has been removed.");
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
- * https://github.com/WireGuard/wireguard-go/blob/master/tun/wintun/ring_windows.go#L14
- */
-#define WINTUN_RING_CAPACITY        0x800000
-#define WINTUN_RING_TRAILING_BYTES  0x10000
-#define WINTUN_MAX_PACKET_SIZE      0xffff
-#define WINTUN_PACKET_ALIGN         4
-
-#define TUN_IOCTL_REGISTER_RINGS CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)
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
- *                            that data is available for reading in send ring
- * @param receive_tail_moved  event set by openvpn to signal wintun
- *                            that data has been written to receive ring
- * @return                    true if registration is successful, false otherwise - use GetLastError()
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
-    rr.send.ring = send_ring;
-    rr.send.ring_size = sizeof(struct tun_ring);
-    rr.send.tail_moved = send_tail_moved;
-
-    rr.receive.ring = receive_ring;
-    rr.receive.ring_size = sizeof(struct tun_ring);
-    rr.receive.tail_moved = receive_tail_moved;
-
-    res = DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr, sizeof(rr),
-                          NULL, 0, &bytes_returned, NULL);
-
-    return res != FALSE;
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
             t = ADAPTER_TYPE_TAP;
             break;
 
-        case WINDOWS_DRIVER_WINTUN:
-            t = ADAPTER_TYPE_WINTUN;
-            break;
-
         case DRIVER_DCO:
             t = ADAPTER_TYPE_DCO;
             break;
@@ -1040,37 +1033,8 @@
     overlapped_io_init(&tt->writes, frame, TRUE);
     tt->adapter_index = TUN_ADAPTER_INDEX_INVALID;
 
-    if (tt->backend_driver == WINDOWS_DRIVER_WINTUN)
-    {
-        tt->wintun_send_ring_handle = CreateFileMapping(INVALID_HANDLE_VALUE, NULL,
-                                                        PAGE_READWRITE,
-                                                        0,
-                                                        sizeof(struct tun_ring),
-                                                        NULL);
-        tt->wintun_receive_ring_handle = CreateFileMapping(INVALID_HANDLE_VALUE,
-                                                           NULL,
-                                                           PAGE_READWRITE,
-                                                           0,
-                                                           sizeof(struct tun_ring),
-                                                           NULL);
-        if ((tt->wintun_send_ring_handle == NULL) || (tt->wintun_receive_ring_handle == NULL))
-        {
-            msg(M_FATAL, "Cannot allocate memory for ring buffer");
-        }
-
-        tt->rw_handle.read = CreateEvent(NULL, FALSE, FALSE, NULL);
-        tt->rw_handle.write = CreateEvent(NULL, FALSE, FALSE, NULL);
-
-        if ((tt->rw_handle.read == NULL) || (tt->rw_handle.write == NULL))
-        {
-            msg(M_FATAL, "Cannot create events for ring buffer");
-        }
-    }
-    else
-    {
-        tt->rw_handle.read = tt->reads.overlapped.hEvent;
-        tt->rw_handle.write = tt->writes.overlapped.hEvent;
-    }
+    tt->rw_handle.read = tt->reads.overlapped.hEvent;
+    tt->rw_handle.write = tt->writes.overlapped.hEvent;
 #endif /* ifdef _WIN32 */
 }
 
@@ -4010,10 +3974,6 @@
                     {
                         windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6;
                     }
-                    else if (strcasecmp(component_id, WINTUN_COMPONENT_ID) == 0)
-                    {
-                        windows_driver = WINDOWS_DRIVER_WINTUN;
-                    }
                     else if (strcasecmp(component_id, "ovpn-dco") == 0)
                     {
                         windows_driver = DRIVER_DCO;
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
-        msg(M_FATAL, "There are no TAP-Windows, Wintun or ovpn-dco adapters "
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
-    HANDLE msg_channel = tt->options.msg_channel;
-    ack_message_t ack;
-    bool ret = true;
-    struct gc_arena gc = gc_new();
-
-    register_ring_buffers_message_t msg = {
-        .header = {
-            msg_register_ring_buffers,
-            sizeof(register_ring_buffers_message_t),
-            0
-        },
-        .device = tt->hand,
-        .send_ring_handle = tt->wintun_send_ring_handle,
-        .receive_ring_handle = tt->wintun_receive_ring_handle,
-        .send_tail_moved = tt->rw_handle.read,
-        .receive_tail_moved = tt->rw_handle.write
-    };
-
-    if (!send_msg_iservice(msg_channel, &msg, sizeof(msg), &ack, "Register ring buffers"))
-    {
-        ret = false;
-    }
-    else if (ack.error_number != NO_ERROR)
-    {
-        msg(M_NONFATAL, "Register ring buffers failed using service: %s [status=0x%x]",
-            strerror_win32(ack.error_number, &gc), ack.error_number);
-        ret = false;
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
-    bool ret = true;
-
-    tt->wintun_send_ring = (struct tun_ring *)MapViewOfFile(tt->wintun_send_ring_handle,
-                                                            FILE_MAP_ALL_ACCESS,
-                                                            0,
-                                                            0,
-                                                            sizeof(struct tun_ring));
-
-    tt->wintun_receive_ring = (struct tun_ring *)MapViewOfFile(tt->wintun_receive_ring_handle,
-                                                               FILE_MAP_ALL_ACCESS,
-                                                               0,
-                                                               0,
-                                                               sizeof(struct tun_ring));
-
-    if (tt->options.msg_channel)
-    {
-        ret = service_register_ring_buffers(tt);
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
-                    msg(M_FATAL, "ERROR:  Wintun requires SYSTEM privileges and therefore "
-                        "should be used with interactive service. If you want to "
-                        "use openvpn from command line, you need to do SYSTEM "
-                        "elevation yourself (for example with psexec).");
-                    break;
-
-                case ERROR_ALREADY_INITIALIZED:
-                    msg(M_NONFATAL, "Adapter %s is already in use", device_guid);
-                    break;
-
-                default:
-                    msg(M_NONFATAL | M_ERRNO, "Failed to register ring buffers");
-            }
-            ret = false;
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
     const char *path = NULL;
     char tuntap_device_path[256];
 
-    if (tt->backend_driver == WINDOWS_DRIVER_WINTUN
-        || tt->backend_driver == DRIVER_DCO)
+    if (tt->backend_driver == DRIVER_DCO)
     {
         const struct device_instance_id_interface *dev_if;
 
@@ -6629,18 +6496,6 @@
         return false;
     }
 
-    if (tt->backend_driver == WINDOWS_DRIVER_WINTUN)
-    {
-        /* Wintun adapter may be considered "open" after ring buffers are successfuly registered. */
-        if (!wintun_register_ring_buffer(tt, device_guid))
-        {
-            msg(D_TUNTAP_INFO, "Failed to register %s adapter ring buffers", device_guid);
-            CloseHandle(tt->hand);
-            tt->hand = NULL;
-            return false;
-        }
-    }
-
     return true;
 }
 
@@ -6988,16 +6843,6 @@
         }
         tt->hand = NULL;
     }
-
-    if (tt->backend_driver == WINDOWS_DRIVER_WINTUN)
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
     /** using an AF_UNIX socket to pass packets from/to an external program.
      *  This is always defined. We error out if a user tries to open this type
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
-    return tt && tt->backend_driver == WINDOWS_DRIVER_WINTUN;
-}
-
-static inline bool
-tuntap_ring_empty(struct tuntap *tt)
-{
-    return tuntap_is_wintun(tt) && (tt->wintun_send_ring->head == tt->wintun_send_ring->tail);
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
-    struct tun_ring *ring = tt->wintun_send_ring;
-    ULONG head = ring->head;
-    ULONG tail = ring->tail;
-    ULONG content_len;
-    struct TUN_PACKET *packet;
-    ULONG aligned_packet_size;
-
-    *buf = tt->reads.buf_init;
-    buf->len = 0;
-
-    if ((head >= WINTUN_RING_CAPACITY) || (tail >= WINTUN_RING_CAPACITY))
-    {
-        msg(M_INFO, "Wintun: ring capacity exceeded");
-        buf->len = -1;
-        return;
-    }
-
-    if (head == tail)
-    {
-        /* nothing to read */
-        return;
-    }
-
-    content_len = wintun_ring_wrap(tail - head);
-    if (content_len < sizeof(struct TUN_PACKET_HEADER))
-    {
-        msg(M_INFO, "Wintun: incomplete packet header in send ring");
-        buf->len = -1;
-        return;
-    }
-
-    packet = (struct TUN_PACKET *) &ring->data[head];
-    if (packet->size > WINTUN_MAX_PACKET_SIZE)
-    {
-        msg(M_INFO, "Wintun: packet too big in send ring");
-        buf->len = -1;
-        return;
-    }
-
-    aligned_packet_size = wintun_ring_packet_align(sizeof(struct TUN_PACKET_HEADER) + packet->size);
-    if (aligned_packet_size > content_len)
-    {
-        msg(M_INFO, "Wintun: incomplete packet in send ring");
-        buf->len = -1;
-        return;
-    }
-
-    buf_write(buf, packet->data, packet->size);
-
-    head = wintun_ring_wrap(head + aligned_packet_size);
-    ring->head = head;
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
-    struct tun_ring *ring = tt->wintun_receive_ring;
-    ULONG head = ring->head;
-    ULONG tail = ring->tail;
-    ULONG aligned_packet_size;
-    ULONG buf_space;
-    struct TUN_PACKET *packet;
-
-    /* wintun marks ring as corrupted (overcapacity) if it receives invalid IP packet */
-    if (!is_ip_packet_valid(buf))
-    {
-        msg(D_LOW, "write_wintun(): drop invalid IP packet");
-        return 0;
-    }
-
-    if ((head >= WINTUN_RING_CAPACITY) || (tail >= WINTUN_RING_CAPACITY))
-    {
-        msg(M_INFO, "write_wintun(): head/tail value is over capacity");
-        return -1;
-    }
-
-    aligned_packet_size = wintun_ring_packet_align(sizeof(struct TUN_PACKET_HEADER) + BLEN(buf));
-    buf_space = wintun_ring_wrap(head - tail - WINTUN_PACKET_ALIGN);
-    if (aligned_packet_size > buf_space)
-    {
-        msg(M_INFO, "write_wintun(): ring is full");
-        return 0;
-    }
-
-    /* copy packet size and data into ring */
-    packet = (struct TUN_PACKET * )&ring->data[tail];
-    packet->size = BLEN(buf);
-    memcpy(packet->data, BPTR(buf), BLEN(buf));
-
-    /* move ring tail */
-    ring->tail = wintun_ring_wrap(tail + aligned_packet_size);
-    if (ring->alertable != 0)
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
-    if (tt->backend_driver == WINDOWS_DRIVER_WINTUN)
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
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
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
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index 761aa47..9898067 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -88,10 +88,6 @@
  *   ACTIVETAPWINDOWS6ADAPTERS properties with semicolon delimited list of all installed adapter
  *   GUIDs and active adapter GUIDs respectively.
  *
- * - Finds existing Wintun adapters and set WINTUNADAPTERS and ACTIVEWINTUNADAPTERS properties
- *   with semicolon delimited list of all installed adapter GUIDs and active adapter GUIDs
- *   respectively.
- *
  * - Finds existing ovpn-dco adapters and set OVPNDCOADAPTERS and ACTIVEOVPNDCOADAPTERS properties
  *   with semicolon delimited list of all installed adapter GUIDs and active adapter GUIDs
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
 	$(top_srcdir)/src/openvpn/wfp_block.c $(top_srcdir)/src/openvpn/wfp_block.h \
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
-        *ring = NULL;
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
-OvpnDuplicateHandle(HANDLE ovpn_proc, HANDLE orig_handle, HANDLE *new_handle)
-{
-    DWORD err = ERROR_SUCCESS;
-
-    if (!DuplicateHandle(ovpn_proc, orig_handle, GetCurrentProcess(), new_handle, 0, FALSE, DUPLICATE_SAME_ACCESS))
-    {
-        err = GetLastError();
-        MsgToEventLog(M_SYSERR, L"Could not duplicate handle");
-        return err;
-    }
-
-    return err;
-}
-
-static DWORD
-DuplicateAndMapRing(HANDLE ovpn_proc, HANDLE orig_handle, struct tun_ring **ring)
-{
-    DWORD err = ERROR_SUCCESS;
-
-    HANDLE dup_handle = NULL;
-
-    err = OvpnDuplicateHandle(ovpn_proc, orig_handle, &dup_handle);
-    if (err != ERROR_SUCCESS)
-    {
-        return err;
-    }
-    *ring = (struct tun_ring *)MapViewOfFile(dup_handle, FILE_MAP_ALL_ACCESS, 0, 0, sizeof(struct tun_ring));
-    CloseHandleEx(&dup_handle);
-    if (*ring == NULL)
-    {
-        err = GetLastError();
-        MsgToEventLog(M_SYSERR, L"Could not map shared memory");
-        return err;
-    }
-
-    return err;
-}
-
-static DWORD
-HandleRegisterRingBuffers(const register_ring_buffers_message_t *rrb, HANDLE ovpn_proc,
-                          undo_lists_t *lists)
-{
-    DWORD err = 0;
-
-    ring_buffer_maps_t *ring_buffer_maps = RemoveListItem(&(*lists)[undo_ring_buffer], CmpAny, NULL);
-
-    if (ring_buffer_maps)
-    {
-        UnmapRingBuffer(ring_buffer_maps);
-    }
-    else if ((ring_buffer_maps = calloc(1, sizeof(*ring_buffer_maps))) == NULL)
-    {
-        return ERROR_OUTOFMEMORY;
-    }
-
-    HANDLE device = NULL;
-    HANDLE send_tail_moved = NULL;
-    HANDLE receive_tail_moved = NULL;
-
-    err = OvpnDuplicateHandle(ovpn_proc, rrb->device, &device);
-    if (err != ERROR_SUCCESS)
-    {
-        goto out;
-    }
-
-    err = DuplicateAndMapRing(ovpn_proc, rrb->send_ring_handle, &ring_buffer_maps->send_ring);
-    if (err != ERROR_SUCCESS)
-    {
-        goto out;
-    }
-
-    err = DuplicateAndMapRing(ovpn_proc, rrb->receive_ring_handle, &ring_buffer_maps->receive_ring);
-    if (err != ERROR_SUCCESS)
-    {
-        goto out;
-    }
-
-    err = OvpnDuplicateHandle(ovpn_proc, rrb->send_tail_moved, &send_tail_moved);
-    if (err != ERROR_SUCCESS)
-    {
-        goto out;
-    }
-
-    err = OvpnDuplicateHandle(ovpn_proc, rrb->receive_tail_moved, &receive_tail_moved);
-    if (err != ERROR_SUCCESS)
-    {
-        goto out;
-    }
-
-    if (!register_ring_buffers(device, ring_buffer_maps->send_ring,
-                               ring_buffer_maps->receive_ring,
-                               send_tail_moved, receive_tail_moved))
-    {
-        err = GetLastError();
-        MsgToEventLog(M_SYSERR, L"Could not register ring buffers");
-        goto out;
-    }
-
-    err = AddListItem(&(*lists)[undo_ring_buffer], ring_buffer_maps);
-
-out:
-    if (err != ERROR_SUCCESS && ring_buffer_maps)
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
     DWORD err = 0;
@@ -3130,10 +2991,6 @@
             hwid = L"root\\tap0901";
             break;
 
-        case ADAPTER_TYPE_WINTUN:
-            hwid = L"wintun";
-            break;
-
         default:
             return ERROR_INVALID_PARAMETER;
     }
@@ -3238,14 +3095,6 @@
             }
             break;
 
-        case msg_register_ring_buffers:
-            if (msg.header.size == sizeof(msg.rrb))
-            {
-                HANDLE ovpn_hnd = proc_info->hProcess;
-                ack.error_number = HandleRegisterRingBuffers(&msg.rrb, ovpn_hnd, lists);
-            }
-            break;
-
         case msg_set_mtu:
             if (msg.header.size == sizeof(msg.mtu))
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
     L"               Note: This name can also be specified as OpenVPN's --dev-node   \n"
     L"               option.                                                         \n"
     L"--hwid <hwid>  Adapter hardware ID. Default value is root\\tap0901, which      \n"
-    L"               describes tap-windows6 driver. To work with wintun or ovpn-dco  \n"
-    L"               driver, specify 'wintun' or 'ovpn-dco'.                         \n"
+    L"               describes tap-windows6 driver. To work with ovpn-dco driver,    \n"
+    L"               driver, specify 'ovpn-dco'.                                     \n"
     L"\n"
     L"Output:\n"
     L"\n"
@@ -94,7 +94,7 @@
     L"\n"
     L"Options:\n"
     L"\n"
-    L"--hwid <hwid>  Adapter hardware ID. By default, root\\tap0901, tap0901, wintun and \n"
+    L"--hwid <hwid>  Adapter hardware ID. By default, root\\tap0901, tap0901 and \n"
     L"               ovpn-dco adapters are listed. Use this switch to limit the list.\n"
     L"\n"
     L"Output:\n"
@@ -167,10 +167,6 @@
     {
         base_name = L"OpenVPN Data Channel Offload";
     }
-    else if (wcsicmp(hwid, L"wintun") == 0)
-    {
-        base_name = L"OpenVPN Wintun";
-    }
     else if (wcsicmp(hwid, L"root\\" _L(TAP_WIN_COMPONENT_ID)) == 0)
     {
         base_name = L"OpenVPN TAP-Windows6";
@@ -351,7 +347,6 @@
         WCHAR szzHwId[0x100] =
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
  *                      description of the device. This pointer is optional and can be NULL.
  *
  * @param szHwId        A pointer to a NULL-terminated string that supplies the hardware id
- *                      of the device (e.g. "root\\tap0901", "Wintun").
+ *                      of the device (e.g. "root\\tap0901").
  *
  * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
  *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This

