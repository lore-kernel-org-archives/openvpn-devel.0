From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 14 Oct 2024 14:27:59 +0200
Message-Id: <20241014122759.38094-1-frank@...2641...>
In-Reply-To: <gerrit.1727098847000.Ib583bf17e35b14aed78fd8217b6e71e8c2b78089@...2715...>
References: <gerrit.1727098847000.Ib583bf17e35b14aed78fd8217b6e71e8c2b78089@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] io_work: convert shift argument to
 uintptr_t
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

Instead of passing the shift argument as pointer, pass
directly its integer value. This will allow the code to
distinguish a shift value from a real object pointer,
like we already do in multi_tcp_process_io().

This change will allow us later to pass an event_arg
object as event handler argument instead of a simple
integer value.

Change-Id: Ib583bf17e35b14aed78fd8217b6e71e8c2b78089
Signed-off-by: Antonio Quartulli <a@...2181...>
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Same as v3 but I added Signed-off-by for Giaan.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/759
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6f279ec..66e5be1 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2065,20 +2065,18 @@
     unsigned int tuntap = 0;
     struct event_set_return esr[4];
 
-    /* These shifts all depend on EVENT_READ (=1) and EVENT_WRITE (=2)
-     * and are added to the shift. Check openvpn.h for more details.
-     */
-    static int socket_shift = SOCKET_SHIFT;
-    static int tun_shift = TUN_SHIFT;
-    static int err_shift = ERR_SHIFT;
+    /* These shifts all depend on EVENT_READ and EVENT_WRITE */
+    static uintptr_t socket_shift = SOCKET_SHIFT;   /* depends on SOCKET_READ and SOCKET_WRITE */
+    static uintptr_t tun_shift = TUN_SHIFT;      /* depends on TUN_READ and TUN_WRITE */
+    static uintptr_t err_shift = ERR_SHIFT;      /* depends on ES_ERROR */
 #ifdef ENABLE_MANAGEMENT
-    static int management_shift = MANAGEMENT_SHIFT;
+    static uintptr_t management_shift = MANAGEMENT_SHIFT; /* depends on MANAGEMENT_READ and MANAGEMENT_WRITE */
 #endif
 #ifdef ENABLE_ASYNC_PUSH
-    static int file_shift = FILE_SHIFT;
+    static uintptr_t file_shift = FILE_SHIFT;
 #endif
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
-    static int dco_shift = DCO_SHIFT;    /* Event from DCO linux kernel module */
+    static uintptr_t dco_shift = DCO_SHIFT;    /* Event from DCO linux kernel module */
 #endif
 
     /*
@@ -2092,7 +2090,7 @@
      */
     if (flags & IOW_WAIT_SIGNAL)
     {
-        wait_signal(c->c2.event_set, (void *)&err_shift);
+        wait_signal(c->c2.event_set, (void *)err_shift);
     }
 
     /*
@@ -2185,19 +2183,19 @@
     /*
      * Configure event wait based on socket, tuntap flags.
      */
-    socket_set(c->c2.link_socket, c->c2.event_set, socket, (void *)&socket_shift, NULL);
-    tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)&tun_shift, NULL);
+    socket_set(c->c2.link_socket, c->c2.event_set, socket, (void *)socket_shift, NULL);
+    tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL);
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (socket & EVENT_READ && c->c2.did_open_tun)
     {
-        dco_event_set(&c->c1.tuntap->dco, c->c2.event_set, (void *)&dco_shift);
+        dco_event_set(&c->c1.tuntap->dco, c->c2.event_set, (void *)dco_shift);
     }
 #endif
 
 #ifdef ENABLE_MANAGEMENT
     if (management)
     {
-        management_socket_set(management, c->c2.event_set, (void *)&management_shift, NULL);
+        management_socket_set(management, c->c2.event_set, (void *)management_shift, NULL);
     }
 #endif
 
@@ -2205,7 +2203,7 @@
     /* arm inotify watcher */
     if (c->options.mode == MODE_SERVER)
     {
-        event_ctl(c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void *)&file_shift);
+        event_ctl(c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void *)file_shift);
     }
 #endif
 
@@ -2248,7 +2246,7 @@
                 for (i = 0; i < status; ++i)
                 {
                     const struct event_set_return *e = &esr[i];
-                    c->c2.event_set_status |= ((e->rwflags & 3) << *((int *)e->arg));
+                    c->c2.event_set_status |= ((e->rwflags & 3) << (uintptr_t)e->arg);
                 }
             }
             else if (status == 0)

