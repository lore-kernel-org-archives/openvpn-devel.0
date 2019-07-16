From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 16 Jul 2019 18:14:45 +0300
Message-Id: <1563290085-9219-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1562069242-29559-1-git-send-email-lstipakov@...277...>
References: <1562069242-29559-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v5] Wintun - experimental support
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

This adds experimental support for Wintun,
an alternative to tap-windows6 on Windows.

To use wintun, specify

  --windows-driver wintun

as config option. Default value is "tap-windows6".

Unlike tap-windows6, Wintun returns multiple packets,
which have to be decapsulated and processed one by one.
We do it by reading data into a new buffer, processing
single packet and returning control to event loop
to give it a chance to write processed packet to link.

If there are no pending writes and there is data in wintun
buffer, event loop triggers tun read. There we read single
packet from wintun buffer or, if it is empty, read from
tun driver.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 v5:
  - support for Wintun 0.4, which removed start padding and
 changed buffer alignment to 16 bytes

 v4:
  - support for Wintun 0.3, which requires buffer registration
  by sending zeroed buffer with max length, which Wintun then
  maps into kernel memory

 v3:
  - add Wintun support for UDP server

 v2:
  - fix sending "icmp unreachable"
  - fix padding calculation on tun write
  - tweak buffer size

 src/openvpn/forward.c |  73 ++++++++++++--
 src/openvpn/forward.h |  31 ++++++
 src/openvpn/init.c    |   7 ++
 src/openvpn/mudp.c    |  36 ++++++-
 src/openvpn/openvpn.h |   4 +
 src/openvpn/options.c |  36 ++++++-
 src/openvpn/options.h |   1 +
 src/openvpn/socket.c  |   4 +-
 src/openvpn/syshead.h |   1 +
 src/openvpn/tun.c     | 259 ++++++++++++++++++++++++++++++++++++--------------
 src/openvpn/tun.h     |  32 ++++++-
 src/openvpn/win32.c   | 118 ++++++++++++++++++++++-
 src/openvpn/win32.h   |  19 +++-
 13 files changed, 523 insertions(+), 98 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 35df089..84ac9fc 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1505,12 +1505,6 @@ ipv6_send_icmp_unreachable(struct context *c, struct buffer *buf, bool client)
 
     int icmpheader_len = sizeof(struct openvpn_ipv6hdr)
                          + sizeof(struct openvpn_icmp6hdr);
-    int totalheader_len = icmpheader_len;
-
-    if (TUNNEL_TYPE(c->c1.tuntap) == DEV_TYPE_TAP)
-    {
-        totalheader_len += sizeof(struct openvpn_ethhdr);
-    }
 
     /*
      * Calculate size for payload, defined in the standard that the resulting
@@ -1535,7 +1529,8 @@ ipv6_send_icmp_unreachable(struct context *c, struct buffer *buf, bool client)
         c->c2.to_link = c->c2.buffers->aux_buf;
         outbuf = &(c->c2.to_link);
     }
-    ASSERT(buf_init(outbuf, totalheader_len));
+    /* reserve enough headroom to prepend with eth/ip/icmp header and Wintun encapsulation */
+    ASSERT(buf_init(outbuf, FRAME_HEADROOM(&c->c2.frame)));
 
     /* Fill the end of the buffer with original packet */
     ASSERT(buf_safe(outbuf, payload_len));
@@ -2182,6 +2177,34 @@ io_wait_dowork(struct context *c, const unsigned int flags)
     dmsg(D_EVENT_WAIT, "I/O WAIT status=0x%04x", c->c2.event_set_status);
 }
 
+#ifdef _WIN32
+uint32_t
+read_incoming_wintun(struct context *c)
+{
+    struct buffer *buf = &c->c2.wintun_buf;
+    uint32_t *size = NULL;
+    int end_padding_len = 0;
+
+    /* get packet size */
+    size = (uint32_t *)buf_read_alloc(buf, 4);
+    if (size == NULL)
+    {
+        return 0;
+    }
+
+    /* copy packet */
+    c->c2.buf = c->c2.buffers->read_tun_buf;
+    buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame));
+    buf_safe(&c->c2.buf, MAX_RW_SIZE_TUN(&c->c2.frame));
+    if (!buf_copy_n(&c->c2.buf, buf, (int)*size))
+    {
+        return 0;
+    }
+
+    return *size;
+}
+#endif
+
 void
 process_io(struct context *c)
 {
@@ -2217,10 +2240,40 @@ process_io(struct context *c)
     /* Incoming data on TUN device */
     else if (status & TUN_READ)
     {
-        read_incoming_tun(c);
-        if (!IS_SIG(c))
+#ifdef _WIN32
+        if (c->options.wintun)
         {
-            process_incoming_tun(c);
+            /* only read from driver if there are no packets in buffer */
+            if (BLEN(&c->c2.wintun_buf) == 0)
+            {
+                read_incoming_tun(c);
+                c->c2.wintun_buf = c->c2.buf;
+            }
+            if (!IS_SIG(c))
+            {
+                const uint32_t size = read_incoming_wintun(c);
+                if (size > 0)
+                {
+                    process_incoming_tun(c);
+                    /* skip the end padding */
+                    buf_advance(&c->c2.wintun_buf, (4 - (size & 3)) % 4);
+                }
+            }
+
+            /*
+             * We need to write processed wintun packet to link,
+             * hence we give control back to event loop, which will
+             * call us again if wintun buffer is not empty
+             */
+        }
+        else
+#endif
+        {
+            read_incoming_tun(c);
+            if (!IS_SIG(c))
+            {
+                process_incoming_tun(c);
+            }
         }
     }
 }
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 48202c0..50d8d32 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -61,6 +61,7 @@
 #define IOW_MBUF            (1<<7)
 #define IOW_READ_TUN_FORCE  (1<<8)
 #define IOW_WAIT_SIGNAL     (1<<9)
+#define IOW_READ_WINTUN_BUF (1<<10)
 
 #define IOW_READ            (IOW_READ_TUN|IOW_READ_LINK)
 
@@ -375,6 +376,12 @@ p2p_iow_flags(const struct context *c)
     {
         flags |= IOW_TO_TUN;
     }
+#ifdef _WIN32
+    if (c->c2.wintun_buf.len > 0)
+    {
+        flags |= IOW_READ_WINTUN_BUF;
+    }
+#endif
     return flags;
 }
 
@@ -401,6 +408,14 @@ io_wait(struct context *c, const unsigned int flags)
         }
         c->c2.event_set_status = ret;
     }
+#ifdef _WIN32
+    /* make sure we write to link before reading from wintun buffer,
+     * otherwise we'll overwrite c2->to_link buffer and lose a packet */
+    else if (!(flags & IOW_TO_LINK) && (flags & IOW_READ_WINTUN_BUF))
+    {
+        c->c2.event_set_status = TUN_READ;
+    }
+#endif
     else
     {
         /* slow path */
@@ -410,4 +425,20 @@ io_wait(struct context *c, const unsigned int flags)
 
 #define CONNECTION_ESTABLISHED(c) (get_link_socket_info(c)->connection_established)
 
+#ifdef _WIN32
+
+/**
+ * Reads a single packet from wintun buffer.
+ * It is caller's responsibility to advance buffer
+ * over the end padding after processing packet.
+ *
+ * @param c          - The context structure of the VPN tunnel associated with
+ *                     the packet.
+ *
+ * @returns size of packet, 0 of packet cannot be read.
+ */
+uint32_t
+read_incoming_wintun(struct context *c);
+#endif
+
 #endif /* FORWARD_H */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 647f533..3036912 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1702,6 +1702,10 @@ do_init_tun(struct context *c)
                             c->c2.es,
                             &c->net_ctx);
 
+#ifdef _WIN32
+    c->c1.tuntap->wintun = c->options.wintun;
+#endif
+
     init_tun_post(c->c1.tuntap,
                   &c->c2.frame,
                   &c->options.tuntap_options);
@@ -1744,6 +1748,9 @@ do_open_tun(struct context *c)
     /* store (hide) interactive service handle in tuntap_options */
     c->c1.tuntap->options.msg_channel = c->options.msg_channel;
     msg(D_ROUTE, "interactive service msg_channel=%u", (unsigned int) c->options.msg_channel);
+
+    c->c1.tuntap->wintun = c->options.wintun;
+
 #endif
 
     /* allocate route list structure */
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index b7f061a..f4903d8 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -236,10 +236,40 @@ multi_process_io_udp(struct multi_context *m)
     /* Incoming data on TUN device */
     else if (status & TUN_READ)
     {
-        read_incoming_tun(&m->top);
-        if (!IS_SIG(&m->top))
+#ifdef _WIN32
+        if (m->top.options.wintun)
+        {
+            /* only read from driver if there are no packets in buffer */
+            if (BLEN(&m->top.c2.wintun_buf) == 0)
+            {
+                read_incoming_tun(&m->top);
+                m->top.c2.wintun_buf = m->top.c2.buf;
+            }
+            if (!IS_SIG(&m->top))
+            {
+                const uint32_t size = read_incoming_wintun(&m->top);
+                if (size > 0)
+                {
+                    multi_process_incoming_tun(m, mpp_flags);
+                    /* skip the end padding */
+                    buf_advance(&m->top.c2.wintun_buf, (4 - (size & 3)) % 4);
+                }
+            }
+
+            /*
+             * We need to write processed wintun packet to link,
+             * hence we give control back to event loop, which will
+             * call us again if wintun buffer is not empty
+             */
+        }
+        else
+#endif
         {
-            multi_process_incoming_tun(m, mpp_flags);
+            read_incoming_tun(&m->top);
+            if (!IS_SIG(&m->top))
+            {
+                multi_process_incoming_tun(m, mpp_flags);
+            }
         }
     }
 #ifdef ENABLE_ASYNC_PUSH
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index fca33f2..96cf182 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -382,6 +382,10 @@ struct context_2
     struct buffer buf;
     struct buffer to_tun;
     struct buffer to_link;
+#ifdef _WIN32
+    /* can contain multiple packets */
+    struct buffer wintun_buf;
+#endif
 
     /* should we print R|W|r|w to console on packet transfers? */
     bool log_rw;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7ced460..1715f80 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -845,6 +845,7 @@ init_options(struct options *o, const bool init_gc)
     o->tuntap_options.dhcp_masq_offset = 0;     /* use network address as internal DHCP server address */
     o->route_method = ROUTE_METHOD_ADAPTIVE;
     o->block_outside_dns = false;
+    o->wintun = false;
 #endif
 #if P2MP_SERVER
     o->real_hash_size = 256;
@@ -2937,6 +2938,12 @@ options_postprocess_mutate_invariant(struct options *options)
         options->ifconfig_noexec = false;
     }
 
+    /* for wintun kernel doesn't send DHCP requests, so use ipapi to set IP address and netmask */
+    if (options->wintun)
+    {
+        options->tuntap_options.ip_win32_type = IPW32_SET_IPAPI;
+    }
+
     remap_redirect_gateway_flags(options);
 #endif
 
@@ -3982,6 +3989,26 @@ foreign_option(struct options *o, char *argv[], int len, struct env_set *es)
     }
 }
 
+#ifdef _WIN32
+bool
+parse_windows_driver(const char *str, const int msglevel)
+{
+    if (streq(str, "tap-windows6"))
+    {
+        return false;
+    }
+    else if (streq(str, "wintun"))
+    {
+        return true;
+    }
+    else
+    {
+        msg(msglevel, "--windows-driver must be tap-windows6 or wintun");
+        return false;
+    }
+}
+#endif
+
 /*
  * parse/print topology coding
  */
@@ -5224,6 +5251,13 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->dev_type = p[1];
     }
+#ifdef _WIN32
+    else if (streq(p[0], "windows-driver") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->wintun = parse_windows_driver(p[1], M_FATAL);
+    }
+#endif
     else if (streq(p[0], "dev-node") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
@@ -7221,7 +7255,7 @@ add_option(struct options *options,
     else if (streq(p[0], "show-adapters") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        show_tap_win_adapters(M_INFO|M_NOPREFIX, M_WARN|M_NOPREFIX);
+        show_tap_win_adapters(M_INFO|M_NOPREFIX, M_WARN|M_NOPREFIX, options->wintun);
         openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */
     }
     else if (streq(p[0], "show-net") && !p[1])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index fb2d84a..d35ec53 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -614,6 +614,7 @@ struct options
     bool show_net_up;
     int route_method;
     bool block_outside_dns;
+    bool wintun;
 #endif
 
     bool use_peer_id;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index c472cf1..4352869 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1635,8 +1635,8 @@ static void
 socket_frame_init(const struct frame *frame, struct link_socket *sock)
 {
 #ifdef _WIN32
-    overlapped_io_init(&sock->reads, frame, FALSE, false);
-    overlapped_io_init(&sock->writes, frame, TRUE, false);
+    overlapped_io_init(&sock->reads, frame, true, false, false);
+    overlapped_io_init(&sock->writes, frame, false, false, false);
     sock->rw_handle.read = sock->reads.overlapped.hEvent;
     sock->rw_handle.write = sock->writes.overlapped.hEvent;
 #endif
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 899aa59..e9accb5 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -39,6 +39,7 @@
 #ifdef _WIN32
 #include <windows.h>
 #include <winsock2.h>
+#include <tlhelp32.h>
 #define sleep(x) Sleep((x)*1000)
 #define random rand
 #define srandom srand
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8f8f7c6..e906684 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -790,8 +790,8 @@ init_tun_post(struct tuntap *tt,
 {
     tt->options = *options;
 #ifdef _WIN32
-    overlapped_io_init(&tt->reads, frame, FALSE, true);
-    overlapped_io_init(&tt->writes, frame, TRUE, true);
+    overlapped_io_init(&tt->reads, frame, true, true, tt->wintun);
+    overlapped_io_init(&tt->writes, frame, false, true, tt->wintun);
     tt->rw_handle.read = tt->reads.overlapped.hEvent;
     tt->rw_handle.write = tt->writes.overlapped.hEvent;
     tt->adapter_index = TUN_ADAPTER_INDEX_INVALID;
@@ -3297,13 +3297,58 @@ tun_read_queue(struct tuntap *tt, int maxsize)
     return tt->reads.iostate;
 }
 
+static inline bool
+register_wintun_write_buf(struct tuntap *tt, DWORD *err)
+{
+    BOOL status;
+
+    ResetEvent(tt->writes.overlapped.hEvent);
+
+    status = WriteFile(
+        tt->hand,
+        BPTR(&tt->writes.buf_init),
+        BLEN(&tt->writes.buf_init),
+        &tt->writes.size,
+        &tt->writes.overlapped
+    );
+
+    /* this should fail */
+    if (status)
+    {
+        return false;
+    }
+    else
+    {
+        *err = GetLastError();
+        return *err == ERROR_INVALID_USER_BUFFER;
+    }
+}
+
 int
 tun_write_queue(struct tuntap *tt, struct buffer *buf)
 {
     if (tt->writes.iostate == IOSTATE_INITIAL)
     {
         BOOL status;
-        int err;
+        DWORD err;
+
+        if (tt->wintun && !tt->wintun_write_buf_registered)
+        {
+            /**
+             * Before doing first write operation, Wintun requires to
+             * register write buffer by sending zeroed buffer of max length,
+             * which Wintun will then map into kernel memory.
+             */
+            if (!register_wintun_write_buf(tt, &err))
+            {
+                struct gc_arena gc = gc_new();
+                msg(M_FATAL, "WIN32 I/O: Error registering Wintun write buffer: %s", strerror_win32(err, &gc));
+            }
+            else
+            {
+                tt->wintun_write_buf_registered = true;
+            }
+        }
 
         /* make a private copy of buf */
         tt->writes.buf = tt->writes.buf_init;
@@ -3445,7 +3490,7 @@ tun_finalize(
 }
 
 const struct tap_reg *
-get_tap_reg(struct gc_arena *gc)
+get_tap_reg(struct gc_arena *gc, bool wintun)
 {
     HKEY adapter_key;
     LONG status;
@@ -3476,6 +3521,20 @@ get_tap_reg(struct gc_arena *gc)
         char net_cfg_instance_id_string[] = "NetCfgInstanceId";
         char net_cfg_instance_id[256];
         DWORD data_type;
+        char expected_component_id[256];
+        char expected_root_component_id[256];
+        char net_luid_index_string[] = "NetLuidIndex";
+        DWORD luid_index;
+
+        if (wintun)
+        {
+            strcpy(expected_component_id, WINTUN_COMPONENT_ID);
+        }
+        else
+        {
+            strcpy(expected_component_id, TAP_WIN_COMPONENT_ID);
+        }
+        openvpn_snprintf(expected_root_component_id, sizeof(expected_root_component_id), "root\\%s", expected_component_id);
 
         len = sizeof(enum_name);
         status = RegEnumKeyEx(
@@ -3540,13 +3599,27 @@ get_tap_reg(struct gc_arena *gc)
 
                 if (status == ERROR_SUCCESS && data_type == REG_SZ)
                 {
-                    if (!strcmp(component_id, TAP_WIN_COMPONENT_ID) ||
-                        !strcmp(component_id, "root\\" TAP_WIN_COMPONENT_ID))
+                    if (!strcmp(component_id, expected_component_id) ||
+                        !strcmp(component_id, expected_root_component_id))
                     {
                         struct tap_reg *reg;
                         ALLOC_OBJ_CLEAR_GC(reg, struct tap_reg, gc);
                         reg->guid = string_alloc(net_cfg_instance_id, gc);
 
+                        len = sizeof(luid_index);
+                        status = RegQueryValueEx(
+                            unit_key,
+                            net_luid_index_string,
+                            NULL,
+                            &data_type,
+                            (LPBYTE)&luid_index,
+                            &len);
+
+                        if (status == ERROR_SUCCESS && data_type == REG_DWORD)
+                        {
+                            reg->luid_index = luid_index;
+                        }
+
                         /* link into return list */
                         if (!first)
                         {
@@ -3759,7 +3832,7 @@ show_valid_win32_tun_subnets(void)
 }
 
 void
-show_tap_win_adapters(int msglev, int warnlev)
+show_tap_win_adapters(int msglev, int warnlev, bool wintun)
 {
     struct gc_arena gc = gc_new();
 
@@ -3773,10 +3846,10 @@ show_tap_win_adapters(int msglev, int warnlev)
     const struct tap_reg *tr1;
     const struct panel_reg *pr;
 
-    const struct tap_reg *tap_reg = get_tap_reg(&gc);
+    const struct tap_reg *tap_reg = get_tap_reg(&gc, wintun);
     const struct panel_reg *panel_reg = get_panel_reg(&gc);
 
-    msg(msglev, "Available TAP-WIN32 adapters [name, GUID]:");
+    msg(msglev, "Available %s adapters [name, GUID]:", wintun ? "WinTun" : "TAP-WIN32");
 
     /* loop through each TAP-Windows adapter registry entry */
     for (tr = tap_reg; tr != NULL; tr = tr->next)
@@ -3898,13 +3971,14 @@ at_least_one_tap_win(const struct tap_reg *tap_reg)
 }
 
 /*
- * Get an adapter GUID and optional actual_name from the
+ * Get an adapter GUID, LUID index and optional actual_name from the
  * registry for the TAP device # = device_number.
  */
 static const char *
 get_unspecified_device_guid(const int device_number,
                             char *actual_name,
                             int actual_name_size,
+                            int *luid_index,
                             const struct tap_reg *tap_reg_src,
                             const struct panel_reg *panel_reg_src,
                             struct gc_arena *gc)
@@ -3953,6 +4027,11 @@ get_unspecified_device_guid(const int device_number,
         }
     }
 
+    if (luid_index)
+    {
+        *luid_index = tap_reg->luid_index;
+    }
+
     /* Save GUID for return value */
     ret = alloc_buf_gc(256, gc);
     buf_printf(&ret, "%s", tap_reg->guid);
@@ -4551,7 +4630,7 @@ get_adapter_index_flexible(const char *name)  /* actual name or GUID */
     }
     if (index == TUN_ADAPTER_INDEX_INVALID)
     {
-        const struct tap_reg *tap_reg = get_tap_reg(&gc);
+        const struct tap_reg *tap_reg = get_tap_reg(&gc, false);
         const struct panel_reg *panel_reg = get_panel_reg(&gc);
         const char *guid = name_to_guid(name, tap_reg, panel_reg);
         index = get_adapter_index_method_1(guid);
@@ -4678,7 +4757,7 @@ void
 tap_allow_nonadmin_access(const char *dev_node)
 {
     struct gc_arena gc = gc_new();
-    const struct tap_reg *tap_reg = get_tap_reg(&gc);
+    const struct tap_reg *tap_reg = get_tap_reg(&gc, false);
     const struct panel_reg *panel_reg = get_panel_reg(&gc);
     const char *device_guid = NULL;
     HANDLE hand;
@@ -4732,6 +4811,7 @@ tap_allow_nonadmin_access(const char *dev_node)
                                                       actual_buffer,
                                                       sizeof(actual_buffer),
                                                       tap_reg,
+                                                      NULL,
                                                       panel_reg,
                                                       &gc);
 
@@ -5254,7 +5334,7 @@ out:
 static const char *
 netsh_get_id(const char *dev_node, struct gc_arena *gc)
 {
-    const struct tap_reg *tap_reg = get_tap_reg(gc);
+    const struct tap_reg *tap_reg = get_tap_reg(gc, false);
     const struct panel_reg *panel_reg = get_panel_reg(gc);
     struct buffer actual = alloc_buf_gc(256, gc);
     const char *guid;
@@ -5267,9 +5347,9 @@ netsh_get_id(const char *dev_node, struct gc_arena *gc)
     }
     else
     {
-        guid = get_unspecified_device_guid(0, BPTR(&actual), BCAP(&actual), tap_reg, panel_reg, gc);
+        guid = get_unspecified_device_guid(0, BPTR(&actual), BCAP(&actual), NULL, tap_reg, panel_reg, gc);
 
-        if (get_unspecified_device_guid(1, NULL, 0, tap_reg, panel_reg, gc)) /* ambiguous if more than one TAP-Windows adapter */
+        if (get_unspecified_device_guid(1, NULL, 0, NULL, tap_reg, panel_reg, gc)) /* ambiguous if more than one TAP-Windows adapter */
         {
             guid = NULL;
         }
@@ -5543,6 +5623,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     struct gc_arena gc = gc_new();
     char device_path[256];
     const char *device_guid = NULL;
+    DWORD device_luid_index = 0;
     DWORD len;
     bool dhcp_masq = false;
     bool dhcp_masq_post = false;
@@ -5569,7 +5650,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
      * Lookup the device name in the registry, using the --dev-node high level name.
      */
     {
-        const struct tap_reg *tap_reg = get_tap_reg(&gc);
+        const struct tap_reg *tap_reg = get_tap_reg(&gc, tt->wintun);
         const struct panel_reg *panel_reg = get_panel_reg(&gc);
         char actual_buffer[256];
 
@@ -5616,6 +5697,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
                 device_guid = get_unspecified_device_guid(device_number,
                                                           actual_buffer,
                                                           sizeof(actual_buffer),
+                                                          &device_luid_index,
                                                           tap_reg,
                                                           panel_reg,
                                                           &gc);
@@ -5625,11 +5707,28 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
                     msg(M_FATAL, "All TAP-Windows adapters on this system are currently in use.");
                 }
 
-                /* Open Windows TAP-Windows adapter */
-                openvpn_snprintf(device_path, sizeof(device_path), "%s%s%s",
-                                 USERMODEDEVICEDIR,
-                                 device_guid,
-                                 TAP_WIN_SUFFIX);
+                /* Open wintun / tap-windows6 adapter */
+                if (tt->wintun)
+                {
+                    openvpn_snprintf(device_path, sizeof(device_path), "%sWINTUN%lu",
+                                     USERMODEDEVICEDIR,
+                                     device_luid_index);
+                }
+                else
+                {
+                    openvpn_snprintf(device_path, sizeof(device_path), "%s%s%s",
+                                     USERMODEDEVICEDIR,
+                                     device_guid,
+                                     TAP_WIN_SUFFIX);
+                }
+
+                if (tt->wintun)
+                {
+                    if (!impersonate_as_system())
+                    {
+                        msg(M_FATAL, "ERROR:  Failed to impersonate as SYSTEM, make sure process is running under privileged account");
+                    }
+                }
 
                 tt->hand = CreateFile(
                     device_path,
@@ -5641,6 +5740,14 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
                     0
                     );
 
+                if (tt->wintun)
+                {
+                    if (!RevertToSelf())
+                    {
+                        msg(M_FATAL, "ERROR:  RevertToSelf error: %lu", GetLastError());
+                    }
+                }
+
                 if (tt->hand == INVALID_HANDLE_VALUE)
                 {
                     msg(D_TUNTAP_INFO, "CreateFile failed on TAP device: %s", device_path);
@@ -5659,12 +5766,14 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
         tt->actual_name = string_alloc(actual_buffer, NULL);
     }
 
-    msg(M_INFO, "TAP-WIN32 device [%s] opened: %s", tt->actual_name, device_path);
+    msg(M_INFO, "%s device device [%s] opened: %s", tt->wintun ? "Wintun" : "TAP - WIN32", tt->actual_name, device_path);
     tt->adapter_index = get_adapter_index(device_guid);
 
-    /* get driver version info */
+    if (!tt->wintun)
     {
+        /* get driver version info */
         ULONG info[3];
+        ULONG mtu;
         CLEAR(info);
         if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_VERSION,
                             &info, sizeof(info),
@@ -5699,11 +5808,8 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
         {
             msg( M_FATAL, "ERROR:  Tap-Win32 driver version %d.%d is buggy regarding small IPv4 packets in TUN mode. Upgrade your Tap-Win32 driver.", (int) info[0], (int) info[1] );
         }
-    }
 
-    /* get driver MTU */
-    {
-        ULONG mtu;
+        /* get driver MTU */
         if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_MTU,
                             &mtu, sizeof(mtu),
                             &mtu, sizeof(mtu), &len, NULL))
@@ -5761,7 +5867,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
     /* set point-to-point mode if TUN device */
 
-    if (tt->type == DEV_TYPE_TUN)
+    if (tt->type == DEV_TYPE_TUN && !tt->wintun)
     {
         if (!tt->did_ifconfig_setup && !tt->did_ifconfig_ipv6_setup)
         {
@@ -5849,71 +5955,80 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             ep[2] = dhcp_masq_addr(tt->local, tt->adapter_netmask, tt->options.dhcp_masq_custom_offset ? tt->options.dhcp_masq_offset : 0);
         }
 
-        /* lease time in seconds */
-        ep[3] = (uint32_t) tt->options.dhcp_lease_time;
+        if (!tt->wintun)
+        {
+            /* lease time in seconds */
+            ep[3] = (uint32_t)tt->options.dhcp_lease_time;
 
-        ASSERT(ep[3] > 0);
+            ASSERT(ep[3] > 0);
 
 #ifndef SIMULATE_DHCP_FAILED /* this code is disabled to simulate bad DHCP negotiation */
-        if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_DHCP_MASQ,
-                             ep, sizeof(ep),
-                             ep, sizeof(ep), &len, NULL))
-        {
-            msg(M_FATAL, "ERROR: The TAP-Windows driver rejected a DeviceIoControl call to set TAP_WIN_IOCTL_CONFIG_DHCP_MASQ mode");
-        }
+            if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_DHCP_MASQ,
+                ep, sizeof(ep),
+                ep, sizeof(ep), &len, NULL))
+            {
+                msg(M_FATAL, "ERROR: The TAP-Windows driver rejected a DeviceIoControl call to set TAP_WIN_IOCTL_CONFIG_DHCP_MASQ mode");
+            }
 
-        msg(M_INFO, "Notified TAP-Windows driver to set a DHCP IP/netmask of %s/%s on interface %s [DHCP-serv: %s, lease-time: %d]",
-            print_in_addr_t(tt->local, 0, &gc),
-            print_in_addr_t(tt->adapter_netmask, 0, &gc),
-            device_guid,
-            print_in_addr_t(ep[2], IA_NET_ORDER, &gc),
-            ep[3]
+            msg(M_INFO, "Notified TAP-Windows driver to set a DHCP IP/netmask of %s/%s on interface %s [DHCP-serv: %s, lease-time: %d]",
+                print_in_addr_t(tt->local, 0, &gc),
+                print_in_addr_t(tt->adapter_netmask, 0, &gc),
+                device_guid,
+                print_in_addr_t(ep[2], IA_NET_ORDER, &gc),
+                ep[3]
             );
 
-        /* user-supplied DHCP options capability */
-        if (tt->options.dhcp_options)
-        {
-            struct buffer buf = alloc_buf(256);
-            if (build_dhcp_options_string(&buf, &tt->options))
+            /* user-supplied DHCP options capability */
+            if (tt->options.dhcp_options)
             {
-                msg(D_DHCP_OPT, "DHCP option string: %s", format_hex(BPTR(&buf), BLEN(&buf), 0, &gc));
-                if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT,
-                                     BPTR(&buf), BLEN(&buf),
-                                     BPTR(&buf), BLEN(&buf), &len, NULL))
+                struct buffer buf = alloc_buf(256);
+                if (build_dhcp_options_string(&buf, &tt->options))
                 {
-                    msg(M_FATAL, "ERROR: The TAP-Windows driver rejected a TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT DeviceIoControl call");
+                    msg(D_DHCP_OPT, "DHCP option string: %s", format_hex(BPTR(&buf), BLEN(&buf), 0, &gc));
+                    if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT,
+                        BPTR(&buf), BLEN(&buf),
+                        BPTR(&buf), BLEN(&buf), &len, NULL))
+                    {
+                        msg(M_FATAL, "ERROR: The TAP-Windows driver rejected a TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT DeviceIoControl call");
+                    }
                 }
+                else
+                {
+                    msg(M_WARN, "DHCP option string not set due to error");
+                }
+                free_buf(&buf);
             }
-            else
-            {
-                msg(M_WARN, "DHCP option string not set due to error");
-            }
-            free_buf(&buf);
-        }
 #endif /* ifndef SIMULATE_DHCP_FAILED */
+        }
+
+
     }
 
-    /* set driver media status to 'connected' */
+    if (!tt->wintun)
     {
-        ULONG status = TRUE;
-        if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_SET_MEDIA_STATUS,
-                             &status, sizeof(status),
-                             &status, sizeof(status), &len, NULL))
+        /* set driver media status to 'connected' */
         {
-            msg(M_WARN, "WARNING: The TAP-Windows driver rejected a TAP_WIN_IOCTL_SET_MEDIA_STATUS DeviceIoControl call.");
+            ULONG status = TRUE;
+            if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_SET_MEDIA_STATUS,
+                &status, sizeof(status),
+                &status, sizeof(status), &len, NULL))
+            {
+              msg(M_WARN, "WARNING: The TAP-Windows driver rejected a TAP_WIN_IOCTL_SET_MEDIA_STATUS DeviceIoControl call.");
+            }
         }
-    }
 
-    /* possible wait for adapter to come up */
-    {
-        int s = tt->options.tap_sleep;
-        if (s > 0)
+        /* possible wait for adapter to come up */
         {
-            msg(M_INFO, "Sleeping for %d seconds...", s);
-            management_sleep(s);
+            int s = tt->options.tap_sleep;
+            if (s > 0)
+            {
+                msg(M_INFO, "Sleeping for %d seconds...", s);
+                management_sleep(s);
+            }
         }
     }
 
+
     /* possibly use IP Helper API to set IP address on adapter */
     {
         const DWORD index = tt->adapter_index;
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 69831c4..cccf0f0 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -38,6 +38,10 @@
 #include "misc.h"
 #include "networking.h"
 
+#ifdef _WIN32
+#define WINTUN_COMPONENT_ID "wintun"
+#endif
+
 #if defined(_WIN32) || defined(TARGET_ANDROID)
 
 #define TUN_ADAPTER_INDEX_INVALID ((DWORD)-1)
@@ -175,6 +179,10 @@ struct tuntap
      * ~0 if undefined */
     DWORD adapter_index;
 
+    bool wintun; /* true if wintun is used instead of tap-windows6 */
+    bool wintun_write_buf_registered;
+    char wintun_padding[16];
+
     int standby_iter;
 #else  /* ifdef _WIN32 */
     int fd; /* file descriptor for TUN/TAP dev */
@@ -341,6 +349,7 @@ route_order(void)
 struct tap_reg
 {
     const char *guid;
+    DWORD luid_index;
     struct tap_reg *next;
 };
 
@@ -378,7 +387,7 @@ DWORD adapter_index_of_ip(const IP_ADAPTER_INFO *list,
                           int *count,
                           in_addr_t *netmask);
 
-void show_tap_win_adapters(int msglev, int warnlev);
+void show_tap_win_adapters(int msglev, int warnlev, bool wintun);
 
 void show_adapters(int msglev);
 
@@ -469,6 +478,27 @@ read_tun_buffered(struct tuntap *tt, struct buffer *buf)
 static inline int
 write_tun_buffered(struct tuntap *tt, struct buffer *buf)
 {
+    if (tt->wintun)
+    {
+        int len = BLEN(buf);
+
+        /* variable len end padding */
+        int end_padding_len = (4 - (len & 3)) % 4;
+        if (end_padding_len > 0)
+        {
+            if (!buf_write(buf, tt->wintun_padding, end_padding_len))
+            {
+                return -1;
+            }
+        }
+
+        /* 4 bytes size */
+        if (!buf_write_prepend(buf, &len, 4))
+        {
+            return -1;
+        }
+    }
+
     return tun_write_win32(tt, buf);
 }
 
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index eb4c030..44d5620 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -164,20 +164,33 @@ init_security_attributes_allow_all(struct security_attributes *obj)
 void
 overlapped_io_init(struct overlapped_io *o,
                    const struct frame *frame,
-                   BOOL event_state,
-                   bool tuntap_buffer)  /* if true: tuntap buffer, if false: socket buffer */
+                   bool reads, /* if true: reads buffer, if false: writes buffer */
+                   bool tuntap_buffer,  /* if true: tuntap buffer, if false: socket buffer */
+                   bool wintun)
 {
     CLEAR(*o);
 
     /* manual reset event, initially set according to event_state */
-    o->overlapped.hEvent = CreateEvent(NULL, TRUE, event_state, NULL);
+    o->overlapped.hEvent = CreateEvent(NULL, TRUE, reads ? FALSE : TRUE, NULL);
     if (o->overlapped.hEvent == NULL)
     {
         msg(M_ERR, "Error: overlapped_io_init: CreateEvent failed");
     }
 
-    /* allocate buffer for overlapped I/O */
-    alloc_buf_sock_tun(&o->buf_init, frame, tuntap_buffer, 0);
+    if (wintun && tuntap_buffer && reads)
+    {
+        /*
+         * Lev: according to my tests, this buffer size gives the best performance
+         */
+        int buf_size = 0x3C000;
+        o->buf_init = alloc_buf(buf_size);
+        o->buf_init.len = buf_size;
+    }
+    else
+    {
+        /* allocate buffer for overlapped I/O */
+        alloc_buf_sock_tun(&o->buf_init, frame, tuntap_buffer, 0);
+    }
 }
 
 void
@@ -1493,4 +1506,99 @@ send_msg_iservice(HANDLE pipe, const void *data, size_t size,
     return ret;
 }
 
+bool
+impersonate_as_system()
+{
+    HANDLE thread_token, process_snapshot, winlogon_process, winlogon_token, duplicated_token, file_handle;
+    PROCESSENTRY32 entry;
+    BOOL ret;
+    DWORD pid = 0;
+    TOKEN_PRIVILEGES privileges;
+
+    CLEAR(entry);
+    CLEAR(privileges);
+
+    entry.dwSize = sizeof(PROCESSENTRY32);
+
+    privileges.PrivilegeCount = 1;
+    privileges.Privileges->Attributes = SE_PRIVILEGE_ENABLED;
+
+    if (!LookupPrivilegeValue(NULL, SE_DEBUG_NAME, &privileges.Privileges[0].Luid))
+    {
+        return false;
+    }
+
+    if (!ImpersonateSelf(SecurityImpersonation))
+    {
+        return false;
+    }
+
+    if (!OpenThreadToken(GetCurrentThread(), TOKEN_ADJUST_PRIVILEGES, FALSE, &thread_token))
+    {
+        RevertToSelf();
+        return false;
+    }
+    if (!AdjustTokenPrivileges(thread_token, FALSE, &privileges, sizeof(privileges), NULL, NULL))
+    {
+        CloseHandle(thread_token);
+        RevertToSelf();
+        return false;
+    }
+    CloseHandle(thread_token);
+
+    process_snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
+    if (process_snapshot == INVALID_HANDLE_VALUE)
+    {
+        RevertToSelf();
+        return false;
+    }
+    for (ret = Process32First(process_snapshot, &entry); ret; ret = Process32Next(process_snapshot, &entry))
+    {
+        if (!_stricmp(entry.szExeFile, "winlogon.exe"))
+        {
+            pid = entry.th32ProcessID;
+            break;
+        }
+    }
+    CloseHandle(process_snapshot);
+    if (!pid)
+    {
+        RevertToSelf();
+        return false;
+    }
+
+    winlogon_process = OpenProcess(PROCESS_QUERY_INFORMATION, FALSE, pid);
+    if (!winlogon_process)
+    {
+        RevertToSelf();
+        return false;
+    }
+
+    if (!OpenProcessToken(winlogon_process, TOKEN_IMPERSONATE | TOKEN_DUPLICATE, &winlogon_token))
+    {
+        CloseHandle(winlogon_process);
+        RevertToSelf();
+        return false;
+    }
+    CloseHandle(winlogon_process);
+
+    if (!DuplicateToken(winlogon_token, SecurityImpersonation, &duplicated_token))
+    {
+        CloseHandle(winlogon_token);
+        RevertToSelf();
+        return false;
+    }
+    CloseHandle(winlogon_token);
+
+    if (!SetThreadToken(NULL, duplicated_token))
+    {
+        CloseHandle(duplicated_token);
+        RevertToSelf();
+        return false;
+    }
+    CloseHandle(duplicated_token);
+
+    return true;
+}
+
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 4814bbc..e511b56 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -212,10 +212,12 @@ struct overlapped_io {
     struct buffer buf;
 };
 
-void overlapped_io_init(struct overlapped_io *o,
-                        const struct frame *frame,
-                        BOOL event_state,
-                        bool tuntap_buffer);
+void
+overlapped_io_init(struct overlapped_io *o,
+                   const struct frame *frame,
+                   bool reads, /* if true: reads buffer, if false: writes buffer */
+                   bool tuntap_buffer,  /* if true: tuntap buffer, if false: socket buffer */
+                   bool wintun);
 
 void overlapped_io_close(struct overlapped_io *o);
 
@@ -323,5 +325,14 @@ bool send_msg_iservice(HANDLE pipe, const void *data, size_t size,
 int
 openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags);
 
+/**
+ * Impersonates current thread as SYSTEM, required
+ * to open Wintun device.
+ *
+ * @returns     True if it succeeds, false if it fails.
+ */
+bool
+impersonate_as_system();
+
 #endif /* ifndef OPENVPN_WIN32_H */
 #endif /* ifdef _WIN32 */
-- 
2.7.4


