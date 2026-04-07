From: Gert Doering <gert@...1296...>
Date: Tue,  7 Apr 2026 13:24:28 +0200
Message-ID: <20260407112434.5588-1-gert@...1296...>
In-Reply-To: <gerrit.1773241811000.I8d6b7bc1b7744dc6d57aaed3231b8901275752f2@...2715...>
References: <gerrit.1773241811000.I8d6b7bc1b7744dc6d57aaed3231b8901275752f2@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Change type of max_clients to uint32_t
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

peer_id is mostly this already (except in DCO
context for some reason), and max_peerid was
defined as uint32_t as well. So changing max_clients
to uint32_t avoids many -Wsign-compare warnings.

While here fix limit for max_clients in options
parsing. It is not allowed to be MAX_PEER_ID
exactly.

Change-Id: I8d6b7bc1b7744dc6d57aaed3231b8901275752f2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1564
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1564
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index a1e373d..718cd8b 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -559,11 +559,6 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static void
 dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlist_t *nvl)
 {
@@ -582,10 +577,6 @@
         __func__, peerid, mi->context.c2.dco_read_bytes, mi->context.c2.dco_write_bytes);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 dco_read_and_process(dco_context_t *dco)
 {
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b92fa43..37171c5 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -858,11 +858,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static int
 ovpn_handle_peer(dco_context_t *dco, struct nlattr *attrs[])
 {
@@ -889,7 +884,7 @@
     if (dco->ifmode == OVPN_MODE_P2P)
     {
         c2 = &dco->c->c2;
-        if (c2->tls_multi->dco_peer_id != peer_id)
+        if (c2->tls_multi->dco_peer_id != (int)peer_id)
         {
             return NL_SKIP;
         }
@@ -918,10 +913,6 @@
     return NL_OK;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static bool
 ovpn_iface_check(dco_context_t *dco, struct nlattr *attrs[])
 {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index f46c24d..2e26f2a 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -739,11 +739,6 @@
     return 0;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 int
 dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_err)
 {
@@ -838,9 +833,9 @@
     {
         OVPN_PEER_STATS *stat = &peer_stats[i];
 
-        if (stat->PeerId >= dco->c->multi->max_clients)
+        if (stat->PeerId >= (int)dco->c->multi->max_clients)
         {
-            msg(M_WARN, "%s: received out of bound peer_id %u (max=%u)", __func__, stat->PeerId,
+            msg(M_WARN, "%s: received out of bound peer_id %d (max=%u)", __func__, stat->PeerId,
                 dco->c->multi->max_clients);
             continue;
         }
@@ -871,10 +866,6 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 dco_get_peer_stats_fallback(struct context *c, const bool raise_sigusr1_on_err)
 {
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index b359750..432c79a 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -180,11 +180,6 @@
     return false;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /*
  * Get a client instance based on real address.  If
  * the instance doesn't exist, create it while
@@ -217,7 +212,7 @@
             uint32_t peer_id = ((uint32_t)ptr[1] << 16) | ((uint32_t)ptr[2] << 8) | ((uint32_t)ptr[3]);
             peer_id_disabled = (peer_id == MAX_PEER_ID);
 
-            if (!peer_id_disabled && (peer_id < m->max_clients) && (m->instances[peer_id]))
+            if (!peer_id_disabled && (peer_id < m->max_clients) && m->instances[peer_id])
             {
                 /* Floating on TCP will never be possible, so ensure we only process
                  * UDP clients */
@@ -315,10 +310,6 @@
     return mi;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Send a packet to UDP socket.
  */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index c03e821..f825bf8 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -695,11 +695,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /*
  * Create a client instance object for a newly connected client.
  */
@@ -782,10 +777,6 @@
     return NULL;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Dump tables -- triggered by SIGUSR2.
  * If status file is defined, write to file.
@@ -3261,7 +3252,7 @@
         return;
     }
 
-    if ((peer_id < m->max_clients) && (m->instances[peer_id]))
+    if (((uint32_t)peer_id < m->max_clients) && m->instances[peer_id])
     {
         struct multi_instance *mi = m->instances[peer_id];
         set_prefix(mi);
@@ -4085,18 +4076,13 @@
 #endif /* ifdef ENABLE_MANAGEMENT */
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 void
 multi_assign_peer_id(struct multi_context *m, struct multi_instance *mi)
 {
     /* max_clients must be less then max peer-id value */
     ASSERT(m->max_clients < MAX_PEER_ID);
 
-    for (int i = 0; i < m->max_clients; ++i)
+    for (uint32_t i = 0; i < m->max_clients; ++i)
     {
         if (!m->instances[i])
         {
@@ -4117,10 +4103,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  * @brief Determines the earliest wakeup interval based on periodic operations.
  *
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 17d850b..e0108ad 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -182,7 +182,7 @@
     struct multi_reap *reaper;
     struct mroute_addr local;
     bool enable_c2c;
-    int max_clients;
+    uint32_t max_clients;
     int tcp_queue_limit;
     int status_file_version;
     int n_clients; /* current number of authenticated clients */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8daec42..861e194 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1431,7 +1431,7 @@
     SHOW_INT(cf_per);
     SHOW_INT(cf_initial_max);
     SHOW_INT(cf_initial_per);
-    SHOW_INT(max_clients);
+    SHOW_UINT(max_clients);
     SHOW_INT(max_routes_per_client);
     SHOW_STR(auth_user_pass_verify_script);
     SHOW_BOOL(auth_user_pass_verify_script_via_file);
@@ -7354,7 +7354,7 @@
     else if (streq(p[0], "max-clients") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (!atoi_constrained(p[1], &options->max_clients, p[0], 1, MAX_PEER_ID, msglevel))
+        if (!atoi_constrained(p[1], (int *)&options->max_clients, p[0], 1, MAX_PEER_ID - 1, msglevel))
         {
             goto err;
         }
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 3d8b505..a956a96 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -530,7 +530,7 @@
     int cf_initial_max;
     int cf_initial_per;
 
-    int max_clients;
+    uint32_t max_clients;
     int max_routes_per_client;
     int stale_routes_check_interval;
     int stale_routes_ageing_time;

