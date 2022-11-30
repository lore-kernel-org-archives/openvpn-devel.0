From: selva.nair@...277...
Date: Wed, 30 Nov 2022 05:56:09 -0500
Message-Id: <20221130105609.662402-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Do not add leading space to pushed options
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

From: Selva Nair <selva.nair@...277...>

This makes auth-token push during reneg
consistent with regular PUSH_REPLY.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 92a0bc2d..f8c747d4 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -746,7 +746,7 @@ send_push_reply_auth_token(struct tls_multi *multi)
 
     /* Construct a mimimal control channel push reply message */
     struct buffer buf = alloc_buf_gc(PUSH_BUNDLE_SIZE, &gc);
-    buf_printf(&buf, "%s, %s", push_reply_cmd, e->option);
+    buf_printf(&buf, "%s,%s", push_reply_cmd, e->option);
     send_control_channel_string_dowork(multi, BSTR(&buf), D_PUSH);
     gc_free(&gc);
 }
-- 
2.34.1


