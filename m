From: Gert Doering <gert@...1296...>
Date: Mon, 17 Nov 2025 08:49:15 +0100
Message-ID: <20251117074921.26531-1-gert@...1296...>
In-Reply-To: <gerrit.1762532329000.I2a1786b2bf15852222c28e1b73ab7edbb5f19d7f@...2715...>
References: <gerrit.1762532329000.I2a1786b2bf15852222c28e1b73ab7edbb5f19d7f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] ssl_pkt: Avoid conversion warnings
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

I considered changing opcode to be uint8_t directly, but
most code treats it as int now, so that would be a much
bigger change. Similar for key_id.

Change-Id: I2a1786b2bf15852222c28e1b73ab7edbb5f19d7f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1360
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1360
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index d7f7ac3..f216e88 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -160,17 +160,14 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 void
 write_control_auth(struct tls_session *session, struct key_state *ks, struct buffer *buf,
                    struct link_socket_actual **to_link_addr, int opcode, int max_ack,
                    bool prepend_ack)
 {
-    uint8_t header = ks->key_id | (opcode << P_OPCODE_SHIFT);
+    ASSERT(ks->key_id >= 0 && ks->key_id <= P_KEY_ID_MASK);
+    ASSERT(opcode >= 0 && opcode <= P_LAST_OPCODE);
+    uint8_t header = (uint8_t)(ks->key_id | (opcode << P_OPCODE_SHIFT));
 
     /* Workaround for Softether servers. Softether has a bug that it only
      * allows 4 ACks in packets and drops packets if more ACKs are contained
@@ -474,7 +471,7 @@
     /* Get the valid time quantisation for our hmac,
      * we divide time by handwindow/2 and allow the previous
      * and future session time if specified by offset */
-    uint32_t session_id_time = ntohl(now / ((handwindow + 1) / 2) + offset);
+    uint32_t session_id_time = ntohl((uint32_t)(now / ((handwindow + 1) / 2) + offset));
 
     hmac_ctx_reset(hmac);
     /* We do not care about endian here since it does not need to be
@@ -501,10 +498,6 @@
     return result.sid;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,
                               const struct openvpn_sockaddr *from,

