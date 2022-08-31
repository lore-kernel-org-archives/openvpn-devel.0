From: Arne Schwabe <arne@...1227...>
Date: Wed, 31 Aug 2022 15:41:40 +0200
Message-Id: <20220831134140.913337-2-arne@...1227...>
In-Reply-To: <20220831134140.913337-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220831134140.913337-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 29/28] Add workaround for Softether server
 dropping P_ACK_V1 with >= 5 acks
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

Softether had the number of ACKs in ANY OpenVPN packet limited to 4 and
dropped packets with more than 4 ACKs. This leads to Softether dropping
P_ACK_V1 packets with more than 4 ACKs as invalid. As the recent change
of always acking as many packets as possible, this leads to Softether
server not being able to successfully establish a connection anymore as
it never registers the ACKs.

This behaviour has been fixed on the Softether side with commit 37aa1ba5
but in order to allow clients to connect to older Softether servers, this
commit implements a workaround for the case that the peer might be a
Softether server (no tls-auth/tls-crypt and no other advanced protocol
feature) and limits ACKs to 4 in this case.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_pkt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index e86fbc1b8..9b180cbf4 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -177,6 +177,15 @@ write_control_auth(struct tls_session *session,
 {
     uint8_t header = ks->key_id | (opcode << P_OPCODE_SHIFT);
 
+    /* Workaround for Softether servers. Softether has a bug that it only
+     * allows 4 ACks in packets and drops packets if more ACKs are contained
+     * in a packet (see commit a14d812dcbc in Softether) */
+    if (session->tls_wrap.mode == TLS_WRAP_NONE && !session->opt->server
+        && !(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT))
+    {
+        max_ack = min_int(max_ack, 4);
+    }
+
     ASSERT(link_socket_actual_defined(&ks->remote_addr));
     ASSERT(reliable_ack_write
                (ks->rec_ack, ks->lru_acks, buf, &ks->session_id_remote,
-- 
2.32.1 (Apple Git-133)


