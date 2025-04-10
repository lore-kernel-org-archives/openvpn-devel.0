From: Gert Doering <gert@...1296...>
Date: Thu, 10 Apr 2025 23:50:29 +0200
Message-ID: <20250410215037.11878-1-gert@...1296...>
In-Reply-To: <gerrit.1744182251000.I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c@...2715...>
References: <gerrit.1744182251000.I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Fix dco_win and multisocket interaction
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

The recent introduction of the multisocket support
did not account for some Windows-specific DCO paths.
This patch restores correct behavior on Windows.

Key changes:

 - Add WIN32 guards around DCO-specifc code.
 - Disable wait_signal() when running in
   server mode, as it conflicts with the
   event engine since Windows handles
   signals as I/Os.
 - Ensure correct socket handling for TCP
   vs UDP.

Github: #720

Change-Id: I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/935
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index af1d008..0b8b262 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2072,7 +2072,7 @@
     /*
      * Calculate the flags based on the provided 'flags' argument.
      */
-    if (flags & IOW_WAIT_SIGNAL)
+    if ((c->options.mode != MODE_SERVER) && (flags & IOW_WAIT_SIGNAL))
     {
         wait_signal(es, (void *)err_shift);
     }
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 1d62ea6..86c5160 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -181,7 +181,8 @@
 
     if (mi)
     {
-        if (defer || mbuf_defined(mi->tcp_link_out_deferred))
+        if ((defer && !proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
+            || mbuf_defined(mi->tcp_link_out_deferred))
         {
             /* save to queue */
             struct buffer *buf = &mi->context.c2.to_link;
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index f1751ff..f4ca4df 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -176,10 +176,13 @@
     int status, i;
     unsigned int *persistent = &m->multi_io->tun_rwflags;
 
-    for (i = 0; i < m->top.c1.link_sockets_num; i++)
+    if (!tuntap_is_dco_win(m->top.c1.tuntap))
     {
-        socket_set_listen_persistent(m->top.c2.link_sockets[i], m->multi_io->es,
-                                     &m->top.c2.link_sockets[i]->ev_arg);
+        for (i = 0; i < m->top.c1.link_sockets_num; i++)
+        {
+            socket_set_listen_persistent(m->top.c2.link_sockets[i], m->multi_io->es,
+                                         &m->top.c2.link_sockets[i]->ev_arg);
+        }
     }
 
     if (has_udp_in_local_list(&m->top.options))
@@ -202,7 +205,8 @@
     }
 #endif
     tun_set(m->top.c1.tuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, persistent);
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+#if defined(ENABLE_DCO) \
+    && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))
     dco_event_set(&m->top.c1.tuntap->dco, m->multi_io->es, MULTI_IO_DCO);
 #endif
 
@@ -535,7 +539,8 @@
                     multi_io_action(m, mi, TA_INITIAL, false);
                 }
             }
-#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
+#if defined(ENABLE_DCO) \
+            && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))
             /* incoming data on DCO? */
             else if (e->arg == MULTI_IO_DCO)
             {

