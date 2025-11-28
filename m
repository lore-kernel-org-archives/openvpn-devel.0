From: Gert Doering <gert@...1296...>
Date: Fri, 28 Nov 2025 12:26:59 +0100
Message-ID: <20251128112705.12613-1-gert@...1296...>
In-Reply-To: <gerrit.1764062094000.Iefc251cb4483c0b9fb9d6a5207db4445cd884d52@...2715...>
References: <gerrit.1764062094000.Iefc251cb4483c0b9fb9d6a5207db4445cd884d52@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v13] dco: process messages immediately after
 read
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

From: Ralf Lici <ralf@...2726...>

Currently, reading and processing of incoming DCO messages are
decoupled: notifications are read, parsed, and the relevant information
is stored in fields of dco_context_t for later processing (with the only
exception being stats). This approach is problematic on Linux, since
libnl does not allow reading a single netlink message at a time, which
can result in loss of information when multiple notifications are
available.

This change adopts a read -> parse -> process paradigm. On Linux,
processing is now invoked directly from within the parsing callback,
which libnl calls for each received netlink packet. The other interfaces
are adapted accordingly to unify the processing model across all
platforms.

On Linux, however, a DEL_PEER notification from the kernel triggers a
GET_PEER request from userspace, which clutters the netlink
communication logic and can lead to errors or even process exit when
multiple simultaneous DEL_PEER notifications are received. To avoid
this, introduce a lock that prevents requesting stats while we are still
busy parsing other messages.

Reported-by: Stefan Baranoff <stefan.baranoff@...2970...>
Change-Id: Iefc251cb4483c0b9fb9d6a5207db4445cd884d52
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1403
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1403
This mail reflects revision 13 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index e5e8709..cd6e32a 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -127,12 +127,13 @@
 void close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx);
 
 /**
- * Read data from the DCO communication channel (i.e. a control packet)
+ * Read and process data from the DCO communication channel
+ * (i.e. a control packet)
  *
  * @param dco       the DCO context
  * @return          0 on success or a negative error code otherwise
  */
-int dco_do_read(dco_context_t *dco);
+int dco_read_and_process(dco_context_t *dco);
 
 /**
  * Install a DCO in the main event loop
@@ -305,7 +306,7 @@
 }
 
 static inline int
-dco_do_read(dco_context_t *dco)
+dco_read_and_process(dco_context_t *dco)
 {
     ASSERT(false);
     return 0;
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index f2a89ac..d1ad092 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -578,7 +578,7 @@
 }
 
 int
-dco_do_read(dco_context_t *dco)
+dco_read_and_process(dco_context_t *dco)
 {
     struct ifdrv drv;
     uint8_t buf[4096];
@@ -684,11 +684,21 @@
 
         default:
             msg(M_WARN, "%s: unknown kernel notification %d", __func__, type);
+            dco->dco_message_type = 0;
             break;
     }
 
     nvlist_destroy(nvl);
 
+    if (dco->c->mode == CM_TOP)
+    {
+        multi_process_incoming_dco(dco);
+    }
+    else
+    {
+        process_incoming_dco(dco);
+    }
+
     return 0;
 }
 
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 0ae30b1..2664029 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -49,6 +49,15 @@
 #include <netlink/genl/family.h>
 #include <netlink/genl/ctrl.h>
 
+/* When parsing multiple DEL_PEER notifications, openvpn tries to request stats
+ * for each DEL_PEER message (see setenv_stats). This triggers a GET_PEER
+ * request-reply while we are still parsing the rest of the initial
+ * notifications, which can lead to NLE_BUSY or even NLE_NOMEM.
+ *
+ * This basic lock ensures we don't bite our own tail by issuing a dco_get_peer
+ * while still busy receiving and parsing other messages.
+ */
+static bool __is_locked = false;
 
 /* libnl < 3.5.0 does not set the NLA_F_NESTED on its own, therefore we
  * have to explicitly do it to prevent the kernel from failing upon
@@ -127,7 +136,9 @@
 static int
 ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
 {
+    __is_locked = true;
     int ret = nl_recvmsgs(dco->nl_sock, dco->nl_cb);
+    __is_locked = false;
 
     switch (ret)
     {
@@ -1094,29 +1105,34 @@
      * message, that stores the type-specific attributes.
      *
      * the "dco" object is then filled accordingly with the information
-     * retrieved from the message, so that the rest of the OpenVPN code can
-     * react as need be.
+     * retrieved from the message, so that *process_incoming_dco can react
+     * as need be.
      */
+    int ret;
     switch (gnlh->cmd)
     {
         case OVPN_CMD_PEER_GET:
         {
+            /* return directly, there are no messages to pass to *process_incoming_dco() */
             return ovpn_handle_peer(dco, attrs);
         }
 
         case OVPN_CMD_PEER_DEL_NTF:
         {
-            return ovpn_handle_peer_del_ntf(dco, attrs);
+            ret = ovpn_handle_peer_del_ntf(dco, attrs);
+            break;
         }
 
         case OVPN_CMD_PEER_FLOAT_NTF:
         {
-            return ovpn_handle_peer_float_ntf(dco, attrs);
+            ret = ovpn_handle_peer_float_ntf(dco, attrs);
+            break;
         }
 
         case OVPN_CMD_KEY_SWAP_NTF:
         {
-            return ovpn_handle_key_swap_ntf(dco, attrs);
+            ret = ovpn_handle_key_swap_ntf(dco, attrs);
+            break;
         }
 
         default:
@@ -1125,11 +1141,25 @@
             return NL_STOP;
     }
 
+    if (ret != NL_OK)
+    {
+        return ret;
+    }
+
+    if (dco->c->mode == CM_TOP)
+    {
+        multi_process_incoming_dco(dco);
+    }
+    else
+    {
+        process_incoming_dco(dco);
+    }
+
     return NL_OK;
 }
 
 int
-dco_do_read(dco_context_t *dco)
+dco_read_and_process(dco_context_t *dco)
 {
     msg(D_DCO_DEBUG, __func__);
 
@@ -1141,6 +1171,12 @@
 {
     ASSERT(dco);
 
+    if (__is_locked)
+    {
+        msg(D_DCO_DEBUG, "%s: cannot request peer stats while parsing other messages", __func__);
+        return 0;
+    }
+
     /* peer_id == -1 means "dump all peers", but this is allowed in MP mode only.
      * If it happens in P2P mode it means that the DCO peer was deleted and we
      * can simply bail out
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index ca5eedf..94f043f 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -690,7 +690,7 @@
 }
 
 int
-dco_do_read(dco_context_t *dco)
+dco_read_and_process(dco_context_t *dco)
 {
     if (dco->ifmode != DCO_MODE_MP)
     {
@@ -727,6 +727,15 @@
             break;
     }
 
+    if (dco->c->mode == CM_TOP)
+    {
+        multi_process_incoming_dco(dco);
+    }
+    else
+    {
+        process_incoming_dco(dco);
+    }
+
     return 0;
 }
 
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index ccb8404..1a68af4 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1243,19 +1243,11 @@
     }
 }
 
-static void
-process_incoming_dco(struct context *c)
+void
+process_incoming_dco(dco_context_t *dco)
 {
 #if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
-    dco_context_t *dco = &c->c1.tuntap->dco;
-
-    dco_do_read(dco);
-
-    /* no message for us to handle - platform specific code has logged details */
-    if (dco->dco_message_type == 0)
-    {
-        return;
-    }
+    struct context *c = dco->c;
 
     /* FreeBSD currently sends us removal notifcation with the old peer-id in
      * p2p mode with the ping timeout reason, so ignore that one to not shoot
@@ -2369,7 +2361,7 @@
     {
         if (!IS_SIG(c))
         {
-            process_incoming_dco(c);
+            dco_read_and_process(&c->c1.tuntap->dco);
         }
     }
 }
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index a575faf..9e9b02e 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -210,6 +210,13 @@
                                  const struct sockaddr *float_sa);
 
 /**
+ * Process an incoming DCO message (from kernel space).
+ *
+ * @param dco - Pointer to the structure representing the DCO context.
+ */
+void process_incoming_dco(dco_context_t *dco);
+
+/**
  * Write a packet to the external network interface.
  * @ingroup external_multiplexer
  *
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2b944667..153695c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3263,14 +3263,12 @@
     multi_signal_instance(m, mi, SIGTERM);
 }
 
-bool
-multi_process_incoming_dco(struct multi_context *m)
+void
+multi_process_incoming_dco(dco_context_t *dco)
 {
-    dco_context_t *dco = &m->top.c1.tuntap->dco;
+    ASSERT(dco->c->multi);
 
-    struct multi_instance *mi = NULL;
-
-    int ret = dco_do_read(&m->top.c1.tuntap->dco);
+    struct multi_context *m = dco->c->multi;
 
     int peer_id = dco->dco_message_peer_id;
 
@@ -3279,12 +3277,12 @@
      */
     if (peer_id < 0)
     {
-        return ret > 0;
+        return;
     }
 
     if ((peer_id < m->max_clients) && (m->instances[peer_id]))
     {
-        mi = m->instances[peer_id];
+        struct multi_instance *mi = m->instances[peer_id];
         set_prefix(mi);
         if (dco->dco_message_type == OVPN_CMD_DEL_PEER)
         {
@@ -3325,11 +3323,6 @@
             "type %d, del_peer_reason %d",
             peer_id, dco->dco_message_type, dco->dco_del_peer_reason);
     }
-
-    dco->dco_message_type = 0;
-    dco->dco_message_peer_id = -1;
-    dco->dco_del_peer_reason = -1;
-    return ret > 0;
 }
 #endif /* if defined(ENABLE_DCO) */
 
@@ -4462,4 +4455,4 @@
 
     return (!ipv6_net_contains_host(&ifconfig_local, o->ifconfig_ipv6_netbits,
                                     dest));
-}
\ No newline at end of file
+}
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index a62b07a..a44f9f2 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -305,13 +305,9 @@
 /**
  * Process an incoming DCO message (from kernel space).
  *
- * @param m            - The single \c multi_context structure.
- *
- * @return
- *  - True, if the message was received correctly.
- *  - False, if there was an error while reading the message.
+ * @param dco - Pointer to the structure representing the DCO context.
  */
-bool multi_process_incoming_dco(struct multi_context *m);
+void multi_process_incoming_dco(dco_context_t *dco);
 
 /**************************************************************************/
 /**
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index fe72456..997951e 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -505,7 +505,7 @@
                 /* incoming data on DCO? */
                 else if (e->arg == MULTI_IO_DCO)
                 {
-                    multi_process_incoming_dco(m);
+                    dco_read_and_process(&m->top.c1.tuntap->dco);
                 }
 #endif
                 /* signal received? */

