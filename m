From: Gert Doering <gert@...1296...>
Date: Sat, 22 Nov 2025 19:52:33 +0100
Message-ID: <20251122185239.26312-1-gert@...1296...>
In-Reply-To: <gerrit.1763636270000.Id1457f8432b4f0a69108b91ca12f2cbd0818f90d@...2715...>
References: <gerrit.1763636270000.Id1457f8432b4f0a69108b91ca12f2cbd0818f90d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] multi-socket: remove duplicated/dead code
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

Removed the event_ctl() for ENABLE_ASYNC_PUSH
in io_wait_dowork() since that function is
not executed by servers anymore.

Removed a duplicated code in multi_io_process_io()
for new incoming TCP connections since the same
thing is done couple lines above.

Change-Id: Id1457f8432b4f0a69108b91ca12f2cbd0818f90d
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1384
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1384
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d57cbe0..ccb8404 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2214,9 +2214,7 @@
     static uintptr_t management_shift =
         MANAGEMENT_SHIFT; /* depends on MANAGEMENT_READ and MANAGEMENT_WRITE */
 #endif
-#ifdef ENABLE_ASYNC_PUSH
-    static uintptr_t file_shift = FILE_SHIFT;
-#endif
+
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     static uintptr_t dco_shift = DCO_SHIFT; /* Event from DCO linux kernel module */
 #endif
@@ -2242,14 +2240,6 @@
     }
 #endif
 
-#ifdef ENABLE_ASYNC_PUSH
-    /* arm inotify watcher */
-    if (c->options.mode == MODE_SERVER)
-    {
-        event_ctl(c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void *)file_shift);
-    }
-#endif
-
     /*
      * Possible scenarios:
      *  (1) tcp/udp port has data available to read
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 6e31687..fe72456 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -500,18 +500,7 @@
                         multi_io_action(m, NULL, TA_TUN_READ, false);
                     }
                 }
-                /* new incoming TCP client attempting to connect? */
-                else if (e->arg == MULTI_IO_SOCKET)
-                {
-                    struct multi_instance *mi;
-                    ASSERT(m->top.c2.link_sockets[0]);
-                    socket_reset_listen_persistent(m->top.c2.link_sockets[0]);
-                    mi = multi_create_instance_tcp(m, m->top.c2.link_sockets[0]);
-                    if (mi)
-                    {
-                        multi_io_action(m, mi, TA_INITIAL, false);
-                    }
-                }
+
 #if defined(ENABLE_DCO)
                 /* incoming data on DCO? */
                 else if (e->arg == MULTI_IO_DCO)

