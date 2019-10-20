From: Gert Doering <gert@...1296...>
Date: Sun, 20 Oct 2019 17:00:39 +0200
Message-Id: <20191020150039.21516-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Force combinationation of --socks-proxy and
 --proto UDP to use IPv4.
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

Our current socks.c code does not handle IPv6 + UDP mode (socket
negotiated with server is IPv4-only, addresses passed in the
packets are IPv4-only).  If this combination is specified, print
an explanatory message and force IPv4-only.

While at it, extend socks.c code to print address+port of auxiliary
UDP connection to SOCKS server (helps debugging).

Trac: #1221

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c | 18 ++++++++++++++++++
 src/openvpn/socks.c   |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 752f5f2c..1da14e8b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2825,6 +2825,24 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
 #endif
     }
 
+    /* our socks code is not fully IPv6 enabled yet (TCP works, UDP not)
+     * so fall back to IPv4-only (trac #1221)
+     */
+    if (ce->socks_proxy_server && proto_is_udp(ce->proto) && ce->af != AF_INET)
+    {
+        if (ce->af == AF_INET6)
+        {
+            msg(M_INFO, "WARNING: '--proto udp6' is not compatible with "
+                "'--socks-proxy' today.  Forcing IPv4 mode." );
+        }
+        else
+        {
+            msg(M_INFO, "NOTICE: dual-stack mode for '--proto udp' does not "
+                "work correctly with '--socks-proxy' today.  Forcing IPv4." );
+        }
+        ce->af = AF_INET;
+    }
+
     /*
      * Set MTU defaults
      */
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index c61ef55c..ad3a70b2 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -414,6 +414,10 @@ recv_socks_reply(socket_descriptor_t sd,
     {
         memcpy(&addr->addr.in4.sin_addr, buf + 4, sizeof(addr->addr.in4.sin_addr));
         memcpy(&addr->addr.in4.sin_port, buf + 8, sizeof(addr->addr.in4.sin_port));
+        struct gc_arena gc = gc_new();
+        msg(M_INFO, "SOCKS proxy wants us to send UDP to %s",
+            print_sockaddr(addr, &gc));
+        gc_free(&gc);
     }
 
 
-- 
2.21.0


