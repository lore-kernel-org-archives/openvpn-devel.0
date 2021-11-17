From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 17 Nov 2021 05:53:21 +0200
Message-Id: <20211117035321.249-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH master+release/2.5] Tune down verbosity for
 suspected retransmits
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

There are cases when control packet is not acked fast enough,
for example when handling PUSH_REPLY, which requires setting up
tunnel. In those cases packet will be retransmitted.

OpenVPN 2 changes packet-id on retransmission, so it passes
replay protection and got rejected as a replay by reliability layer,
which checks another packet-id (sequence id) which is used to assemble
our TCP-like stream.

OpenVPN 3, however, doesn't change packet-id on retransmission,
which triggers replay protection and causes level 1 nonfatal errors
in logs.

When replay protection sees the packet with the same timestamp
and packet-id as previously received one, this is likely retransmission
from OpenVPN 3. To not to scare users, tune verbosity down in this case.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/crypto.c    | 5 ++++-
 src/openvpn/packet_id.c | 3 +++
 src/openvpn/packet_id.h | 1 +
 src/openvpn/ssl.c       | 6 ++++--
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 1dfc760f..5a0775c1 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -335,7 +335,10 @@ crypto_check_replay(struct crypto_options *opt,
     {
         if (!(opt->flags & CO_MUTE_REPLAY_WARNINGS))
         {
-            msg(D_REPLAY_ERRORS, "%s: bad packet ID (may be a replay): %s -- "
+            /* openvpn3 doesn't change packet-id on retransmit, this is
+             * likely the case so tune verbosity down */
+            int verb = opt->packet_id.rec.retransmit ? D_PID_DEBUG : D_REPLAY_ERRORS;
+            msg(verb, "%s: bad packet ID (may be a %s): %s -- "
                 "see the man page entry for --no-replay and --replay-window for "
                 "more info or silence this warning with --mute-replay-warnings",
                 error_prefix, packet_id_net_print(pin, true, gc));
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 19bf3c51..09434bbb 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -201,6 +201,8 @@ packet_id_test(struct packet_id_rec *p,
 {
     packet_id_type diff;
 
+    p->retransmit = false;
+
     packet_id_debug(D_PID_DEBUG, p, pin, "PID_TEST", 0);
 
     ASSERT(p->initialized);
@@ -250,6 +252,7 @@ packet_id_test(struct packet_id_rec *p,
                 }
                 else
                 {
+                    p->retransmit = true;
                     /* raised from D_PID_DEBUG_LOW to reduce verbosity */
                     packet_id_debug(D_PID_DEBUG_MEDIUM, p, pin, "PID_ERR replay", diff);
                     return false;
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 8f705964..e47d671f 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -141,6 +141,7 @@ struct packet_id_rec
     struct seq_list *seq_list; /* packet-id "memory" */
     const char *name;
     int unit;
+    bool retransmit;          /* true if last packet is suspected retransmit */
 };
 
 /*
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index b2dc48be..10f227d1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1531,8 +1531,10 @@ read_control_auth(struct buffer *buf,
         openvpn_decrypt(buf, null, &ctx->opt, NULL, BPTR(buf));
         if (!buf->len)
         {
-            msg(D_TLS_ERRORS,
-                "TLS Error: incoming packet authentication failed from %s",
+            /* openvpn3 doesn't change packet-id on retransmit, this is
+             * likely the case so tune verbosity down */
+            int verb = ctx->opt.packet_id.rec.retransmit ? D_TLS_DEBUG : D_TLS_ERRORS;
+            msg(verb, "TLS Error: incoming packet authentication failed from %s",
                 print_link_socket_actual(from, &gc));
             goto cleanup;
         }
-- 
2.23.0.windows.1


