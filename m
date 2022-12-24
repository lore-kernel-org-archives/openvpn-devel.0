From: Arne Schwabe <arne@...1227...>
Date: Sat, 24 Dec 2022 20:42:51 +0100
Message-Id: <20221224194253.3202231-8-arne@...1227...>
In-Reply-To: <20221224194253.3202231-1-arne@...1227...>
References: <20221224194253.3202231-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 7/9] Bail out when trying to install a TCP
 socket with residual data to DCO
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

Instead of getting the server in a very weird state, we bail out here. This
is only a bandaid solution but better than the alternatives.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/mtcp.c  |  2 +-
 src/openvpn/multi.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 263f4d994..3837ccbab 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -591,7 +591,7 @@ multi_tcp_post(struct multi_context *m, struct multi_instance *mi, const int act
                     struct gc_arena gc = gc_new();
                     msg(M_INFO, "ovpn-dco installed socket with residual read "
                         "len=%d, mi=%s. This connection will probably"
-                        " break.",  BLEN(&c->c2.link_socket->stream_buf.residual),
+                        " break.",  BLEN(&c->c2.link_socket->stream_buf.buf),
                         multi_instance_string(mi, false, &gc));
                     gc_free(&gc);
                     break;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 9a20112e2..d29b7efe3 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2316,9 +2316,17 @@ multi_client_setup_dco_initial(struct multi_context *m,
 {
     if (!dco_enabled(&mi->context.options))
     {
-        /* DCO not enabled, nothing to do, return sucess */
+        /* DCO not enabled, nothing to do, return success */
         return true;
     }
+
+    if (socket_read_residual(mi->context.c2.link_socket))
+    {
+        msg(M_INFO, "TCP socket with half read packet. Cannot install to "
+            "DCO: %s",  multi_instance_string(mi, false, gc));
+        return false;
+    }
+
     int ret = dco_multi_add_new_peer(m, mi);
     if (ret < 0)
     {
-- 
2.37.1 (Apple Git-137.1)


