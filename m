From: Antonio Quartulli <a@...2181...>
Date: Sat,  4 Sep 2021 11:56:23 +0200
Message-Id: <20210904095629.6273-2-a@...2181...>
In-Reply-To: <20210904095629.6273-1-a@...2181...>
References: <20210904095629.6273-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/7] simplify condition detecting pure P2P
 mode
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

The new condition is equivalent to the old one, but easier to grasp.

Also add message to inform uset that cipher negotiation, in this case,
it indeed disabled.

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/options.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 00ba6044..0d6b85cf 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3076,8 +3076,12 @@ options_postprocess_verify(const struct options *o)
 static void
 options_postprocess_cipher(struct options *o)
 {
-    if (!o->pull && !(o->mode == MODE_SERVER))
+    if (!o->tls_server && !o->tls_client)
     {
+        /* we are in the classic P2P mode */
+        msg(M_WARN, "Cipher negotiation is disabled since TLS "
+                    "mode is not enabled");
+
         /* If the cipher is not set, use the old default of BF-CBC. We will
          * warn that this is deprecated on cipher initialisation, no need
          * to warn here as well */
-- 
2.32.0


