From: Steffan Karger <steffan@...1856...>
Date: Sun, 11 Feb 2018 11:19:29 +0100
Message-Id: <20180211101929.4535-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Log pre-handshake packet drops using
 D_MULTI_DROPPED
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

We have a debug level packets dropped by the TLS layer - use that for this
packet drop too.  This changes this message from 'verb 3' to 'verb 4'
(which should result in less user reports about this almost always
harmless warning).

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 676d0b90..d758c31a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3361,7 +3361,7 @@ tls_pre_decrypt(struct tls_multi *multi,
                 {
                     if (!ks->crypto_options.key_ctx_bi.initialized)
                     {
-                        msg(D_TLS_DEBUG_LOW,
+                        msg(D_MULTI_DROPPED,
                             "Key %s [%d] not initialized (yet), dropping packet.",
                             print_link_socket_actual(from, &gc), key_id);
                         goto error_lite;
-- 
2.14.1


