From: Gert Doering <gert@...1296...>
Date: Mon, 24 Nov 2025 18:58:27 +0100
Message-ID: <20251124175832.21352-1-gert@...1296...>
In-Reply-To: <gerrit.1762862118000.I6a5110a0583b8b33496b06d9c27c1084df38e842@...2715...>
References: <gerrit.1762862118000.I6a5110a0583b8b33496b06d9c27c1084df38e842@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] multi-socket: do not return tuntap flags
 on server-side
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

Tuntap flags are already handled within
multi_io_process_io() so return them by
multi_io_process_flags() would be redoundant,
since we need them only for tun_set().

While at it, removed part of the I/O process
from multi_process_io_udp() since those are
also handled within multi_io_process_io(),
removed the FILE_CLOSED and FILE_SHIFT
defines since we now handle that kind of
event in multi_io_process_io() through
the MULTI_IO_FILE_CLOSE_WRITE define.

Change-Id: I6a5110a0583b8b33496b06d9c27c1084df38e842
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1364
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1364
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index f6aa9c4..c2c63f6 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -68,8 +68,6 @@
 #define MANAGEMENT_SHIFT 6
 #define MANAGEMENT_READ  (1 << (MANAGEMENT_SHIFT + READ_SHIFT))
 #define MANAGEMENT_WRITE (1 << (MANAGEMENT_SHIFT + WRITE_SHIFT))
-#define FILE_SHIFT       8
-#define FILE_CLOSED      (1 << (FILE_SHIFT + READ_SHIFT))
 #define DCO_SHIFT        10
 #define DCO_READ         (1 << (DCO_SHIFT + READ_SHIFT))
 #define DCO_WRITE        (1 << (DCO_SHIFT + WRITE_SHIFT))
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index a6d3394..ccb8404 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2170,10 +2170,10 @@
 void
 get_io_flags_dowork_udp(struct context *c, struct multi_io *multi_io, const unsigned int flags)
 {
-    unsigned int out_socket, out_tuntap;
+    unsigned int out_socket;
 
-    multi_io_process_flags(c, multi_io->es, flags, &out_socket, &out_tuntap);
-    multi_io->udp_flags = out_socket | out_tuntap;
+    multi_io_process_flags(c, multi_io->es, flags, &out_socket, NULL);
+    multi_io->udp_flags = (out_socket << SOCKET_SHIFT);
 }
 
 void
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 31134be..b03e165 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -333,7 +333,7 @@
 }
 
 /*
- * Process an I/O event.
+ * Process a UDP socket event.
  */
 void
 multi_process_io_udp(struct multi_context *m, struct link_socket *sock)
@@ -343,50 +343,11 @@
                                        ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLOSE_ON_SIGNAL)
                                        : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);
 
-#ifdef MULTI_DEBUG_EVENT_LOOP
-    char buf[16];
-    buf[0] = 0;
-    if (status & SOCKET_READ)
-    {
-        strcat(buf, "SR/");
-    }
-    else if (status & SOCKET_WRITE)
-    {
-        strcat(buf, "SW/");
-    }
-    else if (status & TUN_READ)
-    {
-        strcat(buf, "TR/");
-    }
-    else if (status & TUN_WRITE)
-    {
-        strcat(buf, "TW/");
-    }
-    else if (status & FILE_CLOSED)
-    {
-        strcat(buf, "FC/");
-    }
-    printf("IO %s\n", buf);
-#endif /* ifdef MULTI_DEBUG_EVENT_LOOP */
-
-#ifdef ENABLE_MANAGEMENT
-    if (status & (MANAGEMENT_READ | MANAGEMENT_WRITE))
-    {
-        ASSERT(management);
-        management_io(management);
-    }
-#endif
-
     /* UDP port ready to accept write */
     if (status & SOCKET_WRITE)
     {
         multi_process_outgoing_link(m, mpp_flags);
     }
-    /* TUN device ready to accept write */
-    else if (status & TUN_WRITE)
-    {
-        multi_process_outgoing_tun(m, mpp_flags);
-    }
     /* Incoming data on UDP port */
     else if (status & SOCKET_READ)
     {
@@ -396,35 +357,6 @@
             multi_process_incoming_link(m, NULL, mpp_flags, sock);
         }
     }
-    /* Incoming data on TUN device */
-    else if (status & TUN_READ)
-    {
-        read_incoming_tun(&m->top);
-        if (!IS_SIG(&m->top))
-        {
-            multi_process_incoming_tun(m, mpp_flags);
-        }
-    }
-#ifdef ENABLE_ASYNC_PUSH
-    /* INOTIFY callback */
-    else if (status & FILE_CLOSED)
-    {
-        multi_process_file_closed(m, mpp_flags);
-    }
-#endif
-#if defined(ENABLE_DCO)
-    else if (status & DCO_READ)
-    {
-        if (!IS_SIG(&m->top))
-        {
-            bool ret = true;
-            while (ret)
-            {
-                ret = multi_process_incoming_dco(m);
-            }
-        }
-    }
-#endif
 
     m->multi_io->udp_flags = ES_ERROR;
 }

