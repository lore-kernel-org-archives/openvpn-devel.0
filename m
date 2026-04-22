From: Gert Doering <gert@...1296...>
Date: Wed, 22 Apr 2026 12:01:51 +0200
Message-ID: <20260422100202.10464-1-gert@...1296...>
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@...2715...>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Multisocket: use event engine rwflags
 for UDP I/O
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

udp_flags does not guarantee correct association with the socket being
processed. Use the rwflags delivered by the event engine along with the
event to ensure proper per-socket I/O handling.

Remove udp_flags entirely.

This change is based on an investigation triggered by a report from
Joshua Rogers using ZeroPath.

Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1635
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1635
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 27cfd36..36597db 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2029,8 +2029,7 @@
 }
 
 static void
-multi_io_process_flags(struct context *c, struct event_set *es, const unsigned int flags,
-                       unsigned int *out_socket, unsigned int *out_tuntap)
+multi_io_process_flags(struct context *c, struct event_set *es, const unsigned int flags)
 {
     unsigned int socket = 0;
     unsigned int tuntap = 0;
@@ -2130,16 +2129,6 @@
     }
 
     tun_set(c->c1.tuntap, es, tuntap, (void *)tun_shift, NULL);
-
-    if (out_socket)
-    {
-        *out_socket = socket;
-    }
-
-    if (out_tuntap)
-    {
-        *out_tuntap = tuntap;
-    }
 }
 
 /*
@@ -2150,10 +2139,7 @@
 void
 get_io_flags_udp(struct context *c, struct multi_io *multi_io, const unsigned int flags)
 {
-    unsigned int out_socket;
-
-    multi_io_process_flags(c, multi_io->es, flags, &out_socket, NULL);
-    multi_io->udp_flags = (out_socket << SOCKET_SHIFT);
+    multi_io_process_flags(c, multi_io->es, flags);
 }
 
 /*
@@ -2163,8 +2149,6 @@
 void
 io_wait(struct context *c, const unsigned int flags)
 {
-    unsigned int out_socket;
-    unsigned int out_tuntap;
     struct event_set_return esr[4];
 
     /* These shifts all depend on EVENT_READ and EVENT_WRITE */
@@ -2183,7 +2167,7 @@
      */
     event_reset(c->c2.event_set);
 
-    multi_io_process_flags(c, c->c2.event_set, flags, &out_socket, &out_tuntap);
+    multi_io_process_flags(c, c->c2.event_set, flags);
 
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (c->c1.tuntap)
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 432c79a..beec57a 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -336,18 +336,17 @@
  * Process a UDP socket event.
  */
 void
-multi_process_io_udp(struct multi_context *m, struct link_socket *sock)
+multi_process_io_udp(struct multi_context *m, struct link_socket *sock, unsigned int rwflags)
 {
-    const unsigned int status = m->multi_io->udp_flags;
     const unsigned int mpp_flags = (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);
 
     /* UDP port ready to accept write */
-    if (status & SOCKET_WRITE)
+    if (rwflags & SOCKET_WRITE)
     {
         multi_process_outgoing_link(m, mpp_flags);
     }
     /* Incoming data on UDP port */
-    else if (status & SOCKET_READ)
+    else if (rwflags & SOCKET_READ)
     {
         read_incoming_link(&m->top, sock);
         if (!IS_SIG(&m->top))
@@ -355,8 +354,6 @@
             multi_process_incoming_link(m, NULL, mpp_flags, sock);
         }
     }
-
-    m->multi_io->udp_flags = ES_ERROR;
 }
 
 /*
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 005ee10..1417651 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -32,7 +32,7 @@
 
 unsigned int p2mp_iow_flags(const struct multi_context *m);
 
-void multi_process_io_udp(struct multi_context *m, struct link_socket *sock);
+void multi_process_io_udp(struct multi_context *m, struct link_socket *sock, unsigned int rwflags);
 /**************************************************************************/
 /**
  * Get, and if necessary create, the multi_instance associated with a
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index e6f4e9c..f9af800 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -457,7 +457,7 @@
                     }
                     else
                     {
-                        multi_process_io_udp(m, ev_arg->u.sock);
+                        multi_process_io_udp(m, ev_arg->u.sock, e->rwflags);
                         mi = m->pending;
                     }
                     /* monitor and/or handle events that are
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index 6b2f59a..d6734bd 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -55,7 +55,6 @@
     int n_esr;
     int maxevents;
     unsigned int tun_rwflags;
-    unsigned int udp_flags;
 #ifdef ENABLE_MANAGEMENT
     unsigned int management_persist_flags;
 #endif

