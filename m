From: Arne Schwabe <arne@...1227...>
Date: Tue, 26 Apr 2022 15:23:23 +0200
Message-Id: <20220426132324.76517-1-arne@...1227...>
In-Reply-To: <0220422134038.3801239-1-arne@...1227...>
References: <0220422134038.3801239-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Change FULL_SYNC macro to
 no_pending_reliable_packets function
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

This changes this macro to a better named inline function. This
introduces a slight whitespace problem but the next refactoring will
move the incorrectly intended block to its own function anyway.
---
 src/openvpn/ssl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index bad59f2a1..6c6648afa 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1774,8 +1774,11 @@ flush_payload_buffer(struct key_state *ks)
 }
 
 /* true if no in/out acknowledgements pending */
-#define FULL_SYNC \
-    (reliable_empty(ks->send_reliable) && reliable_ack_empty(ks->rec_ack))
+static bool
+no_pending_reliable_packets(struct key_state *ks)
+{
+    return (reliable_empty(ks->send_reliable) && reliable_ack_empty(ks->rec_ack));
+}
 
 /*
  * Move the active key to the lame duck key and reinitialize the
@@ -2518,7 +2521,7 @@ tls_process(struct tls_multi *multi,
         }
 
         /* Wait for Initial Handshake ACK */
-        if (ks->state == S_PRE_START && FULL_SYNC)
+        if (ks->state == S_PRE_START && no_pending_reliable_packets(ks))
         {
             ks->state = S_START;
             state_change = true;
@@ -2544,7 +2547,7 @@ tls_process(struct tls_multi *multi,
         if (((ks->state == S_GOT_KEY && !session->opt->server)
              || (ks->state == S_SENT_KEY && session->opt->server)))
         {
-            if (FULL_SYNC)
+            if (no_pending_reliable_packets(ks))
             {
                 ks->established = now;
                 dmsg(D_TLS_DEBUG_MED, "STATE S_ACTIVE");
-- 
2.32.0 (Apple Git-132)


