From: Arne Schwabe <arne@...1227...>
Date: Tue, 15 Nov 2022 13:29:40 +0100
Message-Id: <20221115122940.1947284-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix logic error in checking early
 negotiation support check
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

We want to check if EARLY_NEG_START is set and reserve the other bits
for future expansions. Right now we also check if all reserved bits are
zero. oops.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/mudp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 7c6fc816e..bdf35a8ba 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -92,7 +92,7 @@ do_pre_decrypt_check(struct multi_context *m,
         ASSERT(packet_id_read(&pin, &tmp, true));
 
         /* The most significant byte is 0x0f if early negotiation is supported */
-        bool early_neg_support = (pin.id & EARLY_NEG_MASK) == EARLY_NEG_START;
+        bool early_neg_support = ((pin.id & EARLY_NEG_MASK) & EARLY_NEG_START) == EARLY_NEG_START;
 
         /* All clients that support early negotiation and tls-crypt are assumed
          * to also support resending the WKc in the 2nd packet */
-- 
2.37.0 (Apple Git-136)


