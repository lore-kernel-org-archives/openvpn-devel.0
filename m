From: Antonio Quartulli <a@...2181...>
Date: Mon, 19 Sep 2022 17:35:41 +0200
Message-Id: <20220919153541.9991-1-a@...2181...>
In-Reply-To: <20220919141757.9336-1-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] p2p/dco: renew peer in P2P mode upon
 reconnection
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>

In P2P mode when the peer reconnects we have to renew the state in DCO
in order to inform it about the new peer-id.

Cc: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
Changes from v1:
* remove useless arguments from tls_multi_process() (and descendant
  calls) as we now pass 'c' directly
---
 src/openvpn/forward.c |  4 +---
 src/openvpn/ssl.c     | 54 +++++++++++++++++++++++++++++++++----------
 src/openvpn/ssl.h     |  6 +----
 3 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 810cb8a7..41593fc9 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -170,9 +170,7 @@ check_tls(struct context *c)
 
     if (interval_test(&c->c2.tmp_int))
     {
-        const int tmp_status = tls_multi_process
-                                   (c->c2.tls_multi, &c->c2.to_link, &c->c2.to_link_addr,
-                                   get_link_socket_info(c), &wakeup);
+        const int tmp_status = tls_multi_process(c, &wakeup);
         if (tmp_status == TLSMP_ACTIVE)
         {
             update_time();
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3116fa4b..10691f0c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -45,9 +45,11 @@
 
 #include "error.h"
 #include "common.h"
+#include "openvpn.h"
 #include "socket.h"
 #include "misc.h"
 #include "fdmisc.h"
+#include "forward.h"
 #include "interval.h"
 #include "perf.h"
 #include "status.h"
@@ -2717,13 +2719,14 @@ read_incoming_tls_plaintext(struct key_state *ks, struct buffer *buf,
 
 
 static bool
-tls_process_state(struct tls_multi *multi,
+tls_process_state(struct context *c,
                   struct tls_session *session,
-                  struct buffer *to_link,
                   struct link_socket_actual **to_link_addr,
                   struct link_socket_info *to_link_socket_info,
                   interval_t *wakeup)
 {
+    struct tls_multi *multi = c->c2.tls_multi;
+    struct buffer *to_link = &c->c2.to_link;
     bool state_change = false;
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 
@@ -2827,6 +2830,20 @@ tls_process_state(struct tls_multi *multi,
         state_change = true;
         dmsg(D_TLS_DEBUG_MED, "STATE S_SENT_KEY");
         ks->state = S_SENT_KEY;
+
+        /* In P2P mode we have to renew the peer in DCO in case of
+         * reconnection (--tls-server case)
+         */
+        if (session->opt->server && (session->opt->mode != MODE_SERVER)
+            && (ks->key_id == 0) && multi->dco_peer_added)
+        {
+            msg(D_DCO, "Renewing P2P peer in tls-server mode");
+            int ret = dco_p2p_add_new_peer(c);
+            if (ret < 0)
+            {
+                msg(D_DCO, "Cannot renew peer in DCO: %s (%d)", strerror(-ret), ret);
+            }
+        }
     }
 
     /* Receive Key */
@@ -2843,6 +2860,20 @@ tls_process_state(struct tls_multi *multi,
         state_change = true;
         dmsg(D_TLS_DEBUG_MED, "STATE S_GOT_KEY");
         ks->state = S_GOT_KEY;
+
+        /* In P2P mode we have to renew the peer in DCO in case of
+         * reconnection (--tls-client case)
+         */
+        if (!session->opt->server && !session->opt->pull && (ks->key_id == 0)
+            && multi->dco_peer_added)
+        {
+            msg(D_DCO, "Renewing P2P peer in tls-client mode");
+            int ret = dco_p2p_add_new_peer(c);
+            if (ret < 0)
+            {
+                msg(D_DCO, "Cannot renew peer in DCO: %s (%d)", strerror(-ret), ret);
+            }
+        }
     }
 
     /* Write outgoing plaintext to TLS object */
@@ -2911,15 +2942,16 @@ error:
  * want to send to our peer.
  */
 static bool
-tls_process(struct tls_multi *multi,
+tls_process(struct context *c,
             struct tls_session *session,
-            struct buffer *to_link,
             struct link_socket_actual **to_link_addr,
             struct link_socket_info *to_link_socket_info,
             interval_t *wakeup)
 {
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
     struct key_state *ks_lame = &session->key[KS_LAME_DUCK]; /* retiring key */
+    struct tls_multi *multi = c->c2.tls_multi;
+    struct buffer *to_link = &c->c2.to_link;
 
     /* Make sure we were initialized and that we're not in an error state */
     ASSERT(ks->state != S_UNDEF);
@@ -2962,7 +2994,7 @@ tls_process(struct tls_multi *multi,
              state_name(ks_lame->state),
              to_link->len,
              *wakeup);
-        state_change = tls_process_state(multi, session, to_link, to_link_addr,
+        state_change = tls_process_state(c, session, to_link_addr,
                                          to_link_socket_info, wakeup);
 
         if (ks->state == S_ERROR)
@@ -3055,12 +3087,11 @@ tls_process(struct tls_multi *multi,
  */
 
 int
-tls_multi_process(struct tls_multi *multi,
-                  struct buffer *to_link,
-                  struct link_socket_actual **to_link_addr,
-                  struct link_socket_info *to_link_socket_info,
-                  interval_t *wakeup)
+tls_multi_process(struct context *c, interval_t *wakeup)
 {
+    struct link_socket_info *to_link_socket_info = get_link_socket_info(c);
+    struct link_socket_actual **to_link_addr = &c->c2.to_link_addr;
+    struct tls_multi *multi = c->c2.tls_multi;
     struct gc_arena gc = gc_new();
     int active = TLSMP_INACTIVE;
     bool error = false;
@@ -3101,8 +3132,7 @@ tls_multi_process(struct tls_multi *multi,
 
             update_time();
 
-            if (tls_process(multi, session, to_link, &tla,
-                            to_link_socket_info, wakeup))
+            if (tls_process(c, session, &tla, to_link_socket_info, wakeup))
             {
                 active = TLSMP_ACTIVE;
             }
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index a2724470..13b44f20 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -218,11 +218,7 @@ void tls_multi_free(struct tls_multi *multi, bool clear);
  * Basically decides if we should call tls_process for
  * the active or untrusted sessions.
  */
-int tls_multi_process(struct tls_multi *multi,
-                      struct buffer *to_link,
-                      struct link_socket_actual **to_link_addr,
-                      struct link_socket_info *to_link_socket_info,
-                      interval_t *wakeup);
+int tls_multi_process(struct context *c, interval_t *wakeup);
 
 
 /**************************************************************************/
-- 
2.35.1


