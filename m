From: Arne Schwabe <arne@...1227...>
Date: Fri,  9 Sep 2022 21:59:01 +0200
Message-Id: <20220909195902.2011798-2-arne@...1227...>
In-Reply-To: <20220909195902.2011798-1-arne@...1227...>
References: <20220909195902.2011798-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] Use buffer to prepare protocol-flags
 push-reply
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

The current approach of checking a string buffer is a bit clunky and
also not very extensible. Refactor this by collecting the flags in
a buffer.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/push.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 0a66902a8..989316130 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -647,14 +647,18 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
         }
     }
 
+    struct buffer proto_flags = alloc_buf_gc(128, gc);
+
     if (o->imported_protocol_flags & CO_USE_CC_EXIT_NOTIFY)
     {
-        const char *ekm = "";
+        buf_printf(&proto_flags, " cc-exit");
+
+        /* if the cc exit flag is supported, pushing tls-ekm via protocol-flags
+         * is also supported */
         if (o->imported_protocol_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT)
         {
-            ekm = " tls-ekm";
+            buf_printf(&proto_flags, " tls-ekm");
         }
-        push_option_fmt(gc, push_list, M_USAGE, "protocol-flags cc-exit%s", ekm);
     }
     else if (o->imported_protocol_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT)
     {
@@ -662,6 +666,10 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
     }
 
 
+    if (buf_len(&proto_flags) > 0)
+    {
+        push_option_fmt(gc, push_list, M_USAGE, "protocol-flags%s", buf_str(&proto_flags));
+    }
 
     return true;
 }
-- 
2.32.1 (Apple Git-133)


