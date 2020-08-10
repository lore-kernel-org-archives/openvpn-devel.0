From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Aug 2020 16:37:06 +0200
Message-Id: <20200810143707.5834-17-arne@...1227...>
In-Reply-To: <20200810143707.5834-1-arne@...1227...>
References: <20200810143707.5834-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 16/17] Move parsing IV_PROTO to separate
 function
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 49 +++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index b7b7e32f..13738180 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1771,6 +1771,28 @@ multi_client_connect_setenv(struct multi_context *m,
     gc_free(&gc);
 }
 
+/**
+ * Extracts the IV_PROTO variable and returns its value or 0
+ * if it cannot be extracted.
+ *
+ */
+static unsigned int
+extract_iv_proto(const char *peer_info)
+{
+
+    const char *optstr = peer_info ? strstr(peer_info, "IV_PROTO=") : NULL;
+    if (optstr)
+    {
+        int proto = 0;
+        int r = sscanf(optstr, "IV_PROTO=%d", &proto);
+        if (r == 1 && proto > 0)
+        {
+            return proto;
+        }
+    }
+    return 0;
+}
+
 /**
  * Calculates the options that depend on the client capabilities
  * based on local options and available peer info
@@ -1780,30 +1802,19 @@ multi_client_connect_setenv(struct multi_context *m,
 static bool
 multi_client_set_protocol_options(struct context *c)
 {
-
-    const char *optstr = NULL;
     struct tls_multi *tls_multi = c->c2.tls_multi;
     const char *const peer_info = tls_multi->peer_info;
     struct options *o = &c->options;
 
-    /* Send peer-id if client supports it */
-    optstr = peer_info ? strstr(peer_info, "IV_PROTO=") : NULL;
-    if (optstr)
-    {
-        int proto = 0;
-        int r = sscanf(optstr, "IV_PROTO=%d", &proto);
-        if (r == 1)
-        {
-            if (proto & IV_PROTO_DATA_V2)
-            {
-                tls_multi->use_peer_id = true;
-            }
-            if (proto & IV_PROTO_REQUEST_PUSH)
-            {
-                c->c2.push_request_received = true;
-            }
-        }
 
+    unsigned int proto = extract_iv_proto(peer_info);
+    if (proto & IV_PROTO_DATA_V2)
+    {
+        tls_multi->use_peer_id = true;
+    }
+    if (proto & IV_PROTO_REQUEST_PUSH)
+    {
+        c->c2.push_request_received = true;
     }
 
     /* Select cipher if client supports Negotiable Crypto Parameters */
-- 
2.26.2


