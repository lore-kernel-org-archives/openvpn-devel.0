From: Gert Doering <gert@...1296...>
Date: Thu, 11 Dec 2025 11:59:51 +0100
Message-ID: <20251211105956.22789-1-gert@...1296...>
In-Reply-To: <gerrit.1765279409000.I2c0a0b55ad56e704d4bd19f1fbc1c30c83fae14c@...2715...>
References: <gerrit.1765279409000.I2c0a0b55ad56e704d4bd19f1fbc1c30c83fae14c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] Deprecate --fast-io option
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

From: Gianmarco De Gregori <gianmarco@...2726...>

Recent changes to the event loop revealed that
the --fast-io option is now partially broken and
may cause "unroutable control packet" issues.

As agreed during the last hackathon, this patch
turns --fast-io into a no-op and emits a warning
when it is used.

Additionally, the MPP_CONDITIONAL_PRE_SELECT
flag has been removed as it was part of the
same code path and no longer needed.

Change-Id: I2c0a0b55ad56e704d4bd19f1fbc1c30c83fae14c
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1425
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1425
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index 882cf28..a9232ce 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -211,18 +211,6 @@
   ``--show-engines`` standalone option to list the crypto engines which
   are supported by OpenSSL.
 
---fast-io
-  Optimize TUN/TAP/UDP I/O writes by avoiding a call to
-  poll/epoll/select prior to the write operation. The purpose of such a
-  call would normally be to block until the device or socket is ready to
-  accept the write. Such blocking is unnecessary on some platforms which
-  don't support write blocking on UDP sockets or TUN/TAP devices. In such
-  cases, one can optimize the event loop by avoiding the poll/epoll/select
-  call, improving CPU efficiency by 5% to 10%.
-
-  This option can only be used on non-Windows systems, when ``--proto
-  udp`` is specified, and when ``--shaper`` is *NOT* specified.
-
 --group group
   Similar to the ``--user`` option, this option changes the group ID of
   the OpenVPN process to ``group`` after initialization.
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/unsupported-options.rst
index b646991..f1332f3 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -9,6 +9,10 @@
   Removed in OpenVPN 2.5.  This should be replaced with
   ``--verify-client-cert none``.
 
+--fast-io
+  Ignored since OpenVPN 2.7. This option became broken due to changes
+  to the event loop.
+
 --http-proxy-retry
   Removed in OpenVPN 2.4.  All retries are controlled by ``--max-connect-retry``.
 
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 913fb92..492e667 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2154,13 +2154,12 @@
 }
 
 /*
- * Wait for I/O events.  Used for both TCP & UDP sockets
- * in point-to-point mode and for UDP sockets in
+ * Wait for I/O events.  Used for UDP sockets in
  * point-to-multipoint mode.
  */
 
 void
-get_io_flags_dowork_udp(struct context *c, struct multi_io *multi_io, const unsigned int flags)
+get_io_flags_udp(struct context *c, struct multi_io *multi_io, const unsigned int flags)
 {
     unsigned int out_socket;
 
@@ -2168,33 +2167,12 @@
     multi_io->udp_flags = (out_socket << SOCKET_SHIFT);
 }
 
+/*
+ * This is the core I/O wait function, used for all I/O waits except
+ * for the top-level server sockets.
+ */
 void
-get_io_flags_udp(struct context *c, struct multi_io *multi_io, const unsigned int flags)
-{
-    multi_io->udp_flags = ES_ERROR;
-    if (c->c2.fast_io && (flags & (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))
-    {
-        /* fast path -- only for TUN/TAP/UDP writes */
-        unsigned int ret = 0;
-        if (flags & IOW_TO_TUN)
-        {
-            ret |= TUN_WRITE;
-        }
-        if (flags & (IOW_TO_LINK | IOW_MBUF))
-        {
-            ret |= SOCKET_WRITE;
-        }
-        multi_io->udp_flags = ret;
-    }
-    else
-    {
-        /* slow path - delegate to io_wait_dowork_udp to calculate flags */
-        get_io_flags_dowork_udp(c, multi_io, flags);
-    }
-}
-
-void
-io_wait_dowork(struct context *c, const unsigned int flags)
+io_wait(struct context *c, const unsigned int flags)
 {
     unsigned int out_socket;
     unsigned int out_tuntap;
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 06808b9..7f6f666 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -68,12 +68,9 @@
 
 extern counter_type link_write_bytes_global;
 
-void get_io_flags_dowork_udp(struct context *c, struct multi_io *multi_io,
-                             const unsigned int flags);
-
 void get_io_flags_udp(struct context *c, struct multi_io *multi_io, const unsigned int flags);
 
-void io_wait_dowork(struct context *c, const unsigned int flags);
+void io_wait(struct context *c, const unsigned int flags);
 
 void pre_select(struct context *c);
 
@@ -382,34 +379,6 @@
     return flags;
 }
 
-/*
- * This is the core I/O wait function, used for all I/O waits except
- * for the top-level server sockets.
- */
-static inline void
-io_wait(struct context *c, const unsigned int flags)
-{
-    if (proto_is_dgram(c->c2.link_sockets[0]->info.proto) && c->c2.fast_io
-        && (flags & (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))
-    {
-        /* fast path -- only for TUN/TAP/UDP writes */
-        unsigned int ret = 0;
-        if (flags & IOW_TO_TUN)
-        {
-            ret |= TUN_WRITE;
-        }
-        if (flags & (IOW_TO_LINK | IOW_MBUF))
-        {
-            ret |= SOCKET_WRITE;
-        }
-        c->c2.event_set_status = ret;
-    }
-    else
-    {
-        /* slow path */
-        io_wait_dowork(c, flags);
-    }
-}
 
 static inline bool
 connection_established(struct context *c)
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fc079e1..cd01520 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4139,34 +4139,6 @@
     }
 }
 
-/*
- * Fast I/O setup.  Fast I/O is an optimization which only works
- * if all of the following are true:
- *
- * (1) The platform is not Windows
- * (2) --proto udp is enabled
- * (3) --shaper is disabled
- */
-static void
-do_setup_fast_io(struct context *c)
-{
-    if (c->options.fast_io)
-    {
-#ifdef _WIN32
-        msg(M_INFO, "NOTE: --fast-io is disabled since we are running on Windows");
-#else
-        if (c->options.shaper)
-        {
-            msg(M_INFO, "NOTE: --fast-io is disabled since we are using --shaper");
-        }
-        else
-        {
-            c->c2.fast_io = true;
-        }
-#endif
-    }
-}
-
 static void
 do_signal_on_tls_errors(struct context *c)
 {
@@ -4513,12 +4485,6 @@
     }
 #endif
 
-    /* should we enable fast I/O? */
-    if (c->mode == CM_P2P || c->mode == CM_TOP)
-    {
-        do_setup_fast_io(c);
-    }
-
     /* should we throw a signal on TLS errors? */
     do_signal_on_tls_errors(c);
 
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 5de3af6..92d4dda 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -339,9 +339,7 @@
 multi_process_io_udp(struct multi_context *m, struct link_socket *sock)
 {
     const unsigned int status = m->multi_io->udp_flags;
-    const unsigned int mpp_flags = m->top.c2.fast_io
-                                       ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLOSE_ON_SIGNAL)
-                                       : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);
+    const unsigned int mpp_flags = (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);
 
     /* UDP port ready to accept write */
     if (status & SOCKET_WRITE)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 153695c..d2d9ba8e 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3008,8 +3008,7 @@
     bool ret = true;
 
     if (!IS_SIG(&mi->context)
-        && ((flags & MPP_PRE_SELECT)
-            || ((flags & MPP_CONDITIONAL_PRE_SELECT) && !ANY_OUT(&mi->context))))
+        && ((flags & MPP_PRE_SELECT)))
     {
 #if defined(ENABLE_ASYNC_PUSH)
         bool was_unauthenticated = true;
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index a44f9f2..1209dfb 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -271,10 +271,9 @@
 
 bool multi_process_timeout(struct multi_context *m, const unsigned int mpp_flags);
 
-#define MPP_PRE_SELECT             (1 << 0)
-#define MPP_CONDITIONAL_PRE_SELECT (1 << 1)
-#define MPP_CLOSE_ON_SIGNAL        (1 << 2)
-#define MPP_RECORD_TOUCH           (1 << 3)
+#define MPP_PRE_SELECT      (1 << 0)
+#define MPP_CLOSE_ON_SIGNAL (1 << 1)
+#define MPP_RECORD_TOUCH    (1 << 2)
 
 
 /**************************************************************************/
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index a198fcf..3e1ae78 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -420,9 +420,6 @@
     struct env_set *es;
     bool es_owned;
 
-    /* don't wait for TUN/TAP/UDP to be ready to accept write */
-    bool fast_io;
-
     /* --ifconfig endpoints to be pushed to client */
     bool push_request_received;
     bool push_ifconfig_defined;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2d1f740..d01ec47 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -285,7 +285,6 @@
 #if ENABLE_IP_PKTINFO
     "--multihome     : Configure a multi-homed UDP server.\n"
 #endif
-    "--fast-io       : Optimize TUN/TAP/UDP writes.\n"
     "--remap-usr1 s  : On SIGUSR1 signals, remap signal (s='SIGHUP' or 'SIGTERM').\n"
     "--persist-tun   : Keep tun/tap device open across SIGUSR1 or --ping-restart.\n"
     "--persist-remote-ip : Keep remote IP address across SIGUSR1 or --ping-restart.\n"
@@ -1795,8 +1794,6 @@
 #endif
     SHOW_INT(sockflags);
 
-    SHOW_BOOL(fast_io);
-
     SHOW_INT(comp.alg);
     SHOW_INT(comp.flags);
 
@@ -6592,7 +6589,7 @@
     else if (streq(p[0], "fast-io") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->fast_io = true;
+        msg(M_WARN, "DEPRECATED OPTION: --fast-io option ignored.");
     }
     else if (streq(p[0], "inactive") && p[1] && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d331033..555d9dd 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -406,9 +406,6 @@
     int status_file_version;
     int status_file_update_freq;
 
-    /* optimize TUN/TAP/UDP writes */
-    bool fast_io;
-
     struct compress_options comp;
 
     /* buffer sizes */

