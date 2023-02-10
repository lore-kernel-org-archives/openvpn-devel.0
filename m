From: Arne Schwabe <arne@...1227...>
Date: Fri, 10 Feb 2023 15:27:08 +0100
Message-Id: <20230210142712.572303-5-arne@...1227...>
In-Reply-To: <20230210142712.572303-1-arne@...1227...>
References: <20230210142712.572303-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Add debug output for sent IV variables
 in client mode with verb 7
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

This helps debugging what information a client is sending without having to
use a debugger or to look at the server log.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 016bdc57f..1138dc4e7 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1970,6 +1970,20 @@ read_string_alloc(struct buffer *buf)
     return str;
 }
 
+static void
+print_client_peer_info(struct buffer *out, struct gc_arena *gc)
+{
+    struct buffer buf = alloc_buf_gc(buf_len(out), gc);
+    buf_copy(&buf, out);
+
+    char line[256];
+
+    while (buf_parse(&buf, '\n', line, sizeof(line)))
+    {
+        chomp(line);
+        msg(D_PUSH_DEBUG, "sending peer info: %s", line);
+    }
+}
 /**
  * Prepares the IV_ and UV_ variables that are part of the
  * exchange to signal the peer's capabilities. The amount
@@ -2119,6 +2133,11 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
             }
         }
 
+        if (check_debug_level(D_PUSH_DEBUG))
+        {
+            print_client_peer_info(&out, &gc);
+        }
+
         if (!write_string(buf, BSTR(&out), -1))
         {
             goto error;
-- 
2.37.1 (Apple Git-137.1)


