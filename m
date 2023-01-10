From: Arne Schwabe <arne@...1227...>
Date: Tue, 10 Jan 2023 16:19:01 +0100
Message-Id: <20230110151901.998479-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Log peer-id if loglevel is D_DCO_DEBUG
 and dco is enabled
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

This enables logging the peer id in p2mp mode if dco is enabled
and the log level is high enough

Patch v2: use check_debug_level to check current log level

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 26904859f..b639d3c67 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -476,6 +476,12 @@ multi_instance_string(const struct multi_instance *mi, bool null, struct gc_aren
             buf_printf(&out, "%s/", cn);
         }
         buf_printf(&out, "%s", mroute_addr_print(&mi->real, gc));
+        if (mi->context.c2.tls_multi
+            && check_debug_level(D_DCO_DEBUG)
+            && dco_enabled(&mi->context.options))
+        {
+            buf_printf(&out, " peer-id=%d", mi->context.c2.tls_multi->peer_id);
+        }
         return BSTR(&out);
     }
     else if (null)
-- 
2.37.1 (Apple Git-137.1)


