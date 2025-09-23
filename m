From: Gert Doering <gert@...1296...>
Date: Tue, 23 Sep 2025 18:04:53 +0200
Message-ID: <20250923160459.32273-1-gert@...1296...>
In-Reply-To: <gerrit.1758642994000.I9cb8aa6ef01445cb99758583aba8ae8f9ded0862@...2715...>
References: <gerrit.1758642994000.I9cb8aa6ef01445cb99758583aba8ae8f9ded0862@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] multi_io_init: simplify
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

From: Frank Lichtenheld <frank@...2641...>

We take two values and try to massage them in various
ways. But this function only has one caller and that
puts exactly the same value into both of them. So
simplify the code.

Change-Id: I9cb8aa6ef01445cb99758583aba8ae8f9ded0862
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1209
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1209
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 9256127..1d2ee53 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -411,7 +411,7 @@
     /*
      * Initialize multi-socket I/O wait object
      */
-    m->multi_io = multi_io_init(t->options.max_clients, &m->max_clients);
+    m->multi_io = multi_io_init(m->max_clients);
     m->tcp_queue_limit = t->options.tcp_queue_limit;
 
     /*
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index ece789c..0bfbb63 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -113,21 +113,18 @@
 }
 
 struct multi_io *
-multi_io_init(int maxevents, int *maxclients)
+multi_io_init(const int maxclients)
 {
     struct multi_io *multi_io;
-    const int extra_events = BASE_N_EVENTS;
 
-    ASSERT(maxevents >= 1);
-    ASSERT(maxclients);
+    ASSERT(maxclients >= 1);
 
     ALLOC_OBJ_CLEAR(multi_io, struct multi_io);
-    multi_io->maxevents = maxevents + extra_events;
+    multi_io->maxevents = maxclients + BASE_N_EVENTS;
     multi_io->es = event_set_init(&multi_io->maxevents, 0);
     wait_signal(multi_io->es, MULTI_IO_SIG);
     ALLOC_ARRAY(multi_io->esr, struct event_set_return, multi_io->maxevents);
-    *maxclients = max_int(min_int(multi_io->maxevents - extra_events, *maxclients), 1);
-    msg(D_MULTI_LOW, "MULTI IO: MULTI_IO INIT maxclients=%d maxevents=%d", *maxclients,
+    msg(D_MULTI_LOW, "MULTI IO: MULTI_IO INIT maxclients=%d maxevents=%d", maxclients,
         multi_io->maxevents);
     return multi_io;
 }
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index 07eb3d4..4a3c60d 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -61,7 +61,7 @@
 #endif
 };
 
-struct multi_io *multi_io_init(int maxevents, int *maxclients);
+struct multi_io *multi_io_init(int maxclients);
 
 void multi_io_free(struct multi_io *multi_io);
 

