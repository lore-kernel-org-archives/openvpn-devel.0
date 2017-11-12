From: Steffan Karger <steffan@...1856...>
Date: Sun, 12 Nov 2017 18:22:37 +0100
Message-Id: <20171112172237.8285-1-steffan@...1856...>
In-Reply-To: <ed338010-2918-fb1d-27e0-116712651b87@...2181...>
References: <ed338010-2918-fb1d-27e0-116712651b87@...2181...>
Subject: [Openvpn-devel] [PATCH v2] Use P_DATA_V2 for server->client packets
 too
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

P_DATA_V2 introduced the peer-id.  This allows clients to float, but as a
side-effect 32-bit aligns the encrypted data.  That alignment improves
performance particularly on cheaper/older CPUs.  So although servers don't
actually have a peer-id, still use the V2 packet format (with a zero-id)
for server->client traffic too.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
v2: actually enable P_DATA_V2... Now tested with:
    2.4<>2.4 (V2), 2.4-srv<>2.3-clt (V2), 2.3-srv<>2.4-clt (V1),
    2.4-srv<>2.2-clt (V1)

 src/openvpn/forward.c | 4 ++--
 src/openvpn/push.c    | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 1b7455bb..a868a8ff 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -496,7 +496,7 @@ encrypt_sign(struct context *c, bool comp_frag)
         /* If using P_DATA_V2, prepend the 1-byte opcode and 3-byte peer-id to the
          * packet before openvpn_encrypt(), so we can authenticate the opcode too.
          */
-        if (c->c2.buf.len > 0 && !c->c2.tls_multi->opt.server && c->c2.tls_multi->use_peer_id)
+        if (c->c2.buf.len > 0 && c->c2.tls_multi->use_peer_id)
         {
             tls_prepend_opcode_v2(c->c2.tls_multi, &b->encrypt_buf);
         }
@@ -512,7 +512,7 @@ encrypt_sign(struct context *c, bool comp_frag)
     /* Do packet administration */
     if (c->c2.tls_multi)
     {
-        if (c->c2.buf.len > 0 && (c->c2.tls_multi->opt.server || !c->c2.tls_multi->use_peer_id))
+        if (c->c2.buf.len > 0 && !c->c2.tls_multi->use_peer_id)
         {
             tls_prepend_opcode_v1(c->c2.tls_multi, &c->c2.buf);
         }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 5947a31f..16a4101f 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -366,6 +366,7 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
             push_option_fmt(gc, push_list, M_USAGE, "peer-id %d",
                             tls_multi->peer_id);
         }
+        tls_multi->use_peer_id = true;
     }
 
     /* Push cipher if client supports Negotiable Crypto Parameters */
-- 
2.14.1


