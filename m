From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 14 Oct 2024 14:29:08 +0200
Message-Id: <20241014122908.38342-1-frank@...2641...>
In-Reply-To: <gerrit.1727098847000.I7ebf0d4fb2a23278e16003b2e35598178155d658@...2715...>
References: <gerrit.1727098847000.I7ebf0d4fb2a23278e16003b2e35598178155d658@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] io_work: pass event_arg object to event
 handler in case of socket event
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
Cc: Antonio Quartulli <a@...2181...>, Gianmarco De Gregori <gianmarco@...2726...>

From: Antonio Quartulli <a@...2181...>

In order to allow the code to work with multiple listening sockets
it is essential to allow the generic multi_io event handler
to distinguish between the various socket objects.

This can be achieved by passing an event_arg object that contains
a pointer to the link_socket.

This code path is used on clients as well as UDP servers.

Change-Id: I7ebf0d4fb2a23278e16003b2e35598178155d658
Signed-off-by: Antonio Quartulli <a@...2181...>
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Manually added Signed-off-by for Giaan

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/760
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index b3ba183..c212e07 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -82,6 +82,12 @@
 #define EVENT_METHOD_US_TIMEOUT   (1<<0)
 #define EVENT_METHOD_FAST         (1<<1)
 
+/*
+ * The following constant is used as boundary between integer value
+ * and real addresses when passing arguments to event handlers as (void *)
+ */
+#define MULTI_N           ((void *)16) /* upper bound on MTCP_x */
+
 #ifdef _WIN32
 
 typedef const struct rw_handle *event_t;
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 66e5be1..d50b24c 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2183,7 +2183,8 @@
     /*
      * Configure event wait based on socket, tuntap flags.
      */
-    socket_set(c->c2.link_socket, c->c2.event_set, socket, (void *)socket_shift, NULL);
+    socket_set(c->c2.link_socket, c->c2.event_set, socket,
+               &c->c2.link_socket->ev_arg, NULL);
     tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL);
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (socket & EVENT_READ && c->c2.did_open_tun)
@@ -2246,7 +2247,27 @@
                 for (i = 0; i < status; ++i)
                 {
                     const struct event_set_return *e = &esr[i];
-                    c->c2.event_set_status |= ((e->rwflags & 3) << (uintptr_t)e->arg);
+                    uintptr_t shift;
+
+                    if (e->arg >= MULTI_N)
+                    {
+                        struct event_arg *ev_arg = (struct event_arg *)e->arg;
+                        if (ev_arg->type != EVENT_ARG_LINK_SOCKET)
+                        {
+                            c->c2.event_set_status = ES_ERROR;
+                            msg(D_LINK_ERRORS,
+                                "io_work: non socket event delivered");
+                            return;
+                        }
+
+                        shift = socket_shift;
+                    }
+                    else
+                    {
+                        shift = (uintptr_t)e->arg;
+                    }
+
+                    c->c2.event_set_status |= ((e->rwflags & 3) << shift);
                 }
             }
             else if (status == 0)
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 1b956f4..e89ddba 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -60,8 +60,6 @@
 #define MTCP_FILE_CLOSE_WRITE ((void *)5)
 #define MTCP_DCO        ((void *)6)
 
-#define MTCP_N           ((void *)16) /* upper bound on MTCP_x */
-
 struct ta_iow_flags
 {
     unsigned int flags;
@@ -693,7 +691,7 @@
         struct event_set_return *e = &mtcp->esr[i];
 
         /* incoming data for instance or listening socket? */
-        if (e->arg >= MTCP_N)
+        if (e->arg >= MULTI_N)
         {
             struct event_arg *ev_arg = (struct event_arg *)e->arg;
             switch (ev_arg->type)

