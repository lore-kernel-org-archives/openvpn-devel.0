From: Gert Doering <gert@...1296...>
Date: Mon, 28 Jul 2025 10:42:49 +0200
Message-ID: <20250728084255.1824-1-gert@...1296...>
In-Reply-To: <gerrit.1753690218000.I6977d23b5289eba5db436608e0500216e0e689ec@...2715...>
References: <gerrit.1753690218000.I6977d23b5289eba5db436608e0500216e0e689ec@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] mudp.c, multi.c,
 multi_io.c: get rid of "all three DCO platforms" #ifdefs
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

With commit b66b80b2a all three platforms with DCO support have DCO float
notifications now, so the #ifdef inside multi_process_incoming_dco() is
no longer needed.

Also, the whole notification block (process_incoming_del_peer() and
multi_process_incoming_dco()) was surrounded by an

  #ifdef ENABLE_DCO "and all 3 platforms"

which is also not making sense anymore (if we add a fourth DCO platform,
we need to aim for having "all notifications from day 1", at least having
the stubs and defines).

Last not least, the event stuff in mudp.c and multi_io.c had grown the
same construct - and we'll need events for any future DCO platform, too.

So, fix those #ifdef as well, while at it.

Change-Id: I6977d23b5289eba5db436608e0500216e0e689ec
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <antonio@...2726...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1117
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index ee8446a..118c954 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -412,8 +412,7 @@
         multi_process_file_closed(m, mpp_flags);
     }
 #endif
-#if defined(ENABLE_DCO) \
-    && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))
+#if defined(ENABLE_DCO)
     else if (status & DCO_READ)
     {
         if (!IS_SIG(&m->top))
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 49f5320..b2d2b6c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3337,8 +3337,7 @@
 }
 #endif
 
-#if defined(ENABLE_DCO) \
-    && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))
+#if defined(ENABLE_DCO)
 static void
 process_incoming_del_peer(struct multi_context *m, struct multi_instance *mi,
                           dco_context_t *dco)
@@ -3409,7 +3408,6 @@
         {
             process_incoming_del_peer(m, mi, dco);
         }
-#if defined(TARGET_LINUX) || defined(TARGET_WIN32) || defined(TARGET_FREEBSD)
         else if (dco->dco_message_type == OVPN_CMD_FLOAT_PEER)
         {
             ASSERT(mi->context.c2.link_sockets[0]);
@@ -3419,7 +3417,6 @@
             multi_process_float(m, mi, mi->context.c2.link_sockets[0]);
             CLEAR(dco->dco_float_peer_ss);
         }
-#endif /* if defined(TARGET_LINUX) || defined(TARGET_WIN32) */
         else if (dco->dco_message_type == OVPN_CMD_SWAP_KEYS)
         {
             tls_session_soft_reset(mi->context.c2.tls_multi);
@@ -3452,7 +3449,7 @@
     dco->dco_write_bytes = 0;
     return ret > 0;
 }
-#endif /* if defined(ENABLE_DCO) && defined(TARGET_LINUX) */
+#endif /* if defined(ENABLE_DCO) */
 
 /*
  * Process packets in the TCP/UDP socket -> TUN/TAP interface direction,
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 4854f4b..102ee2f 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -191,8 +191,7 @@
     }
 
     tun_set(m->top.c1.tuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, persistent);
-#if defined(ENABLE_DCO) \
-    && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))
+#if defined(ENABLE_DCO)
     dco_event_set(&m->top.c1.tuntap->dco, m->multi_io->es, MULTI_IO_DCO);
 #endif
 
@@ -526,8 +525,7 @@
                     multi_io_action(m, mi, TA_INITIAL, false);
                 }
             }
-#if defined(ENABLE_DCO) \
-            && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))
+#if defined(ENABLE_DCO)
             /* incoming data on DCO? */
             else if (e->arg == MULTI_IO_DCO)
             {

