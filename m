From: Arne Schwabe <arne@...1227...>
Date: Thu,  8 Dec 2022 16:31:29 +0100
Message-Id: <20221208153129.1207228-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Ignore connection attempts while server is
 shutting down
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

Currently we still allow clients to connect while the server is waiting
to shut down. This window is very small (2s) and is only used when
explicit-exit-notify is enabled on the server side.

The chance of a client connecting during this time period is very low
unless someone puts something stupid like --connect-retry 1 3 into his/her
client config and forces the client to reconnect during this time period.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/mudp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index bdf35a8ba..458152335 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -229,8 +229,13 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
         if (!mi)
         {
             struct tls_pre_decrypt_state state = {0};
-
-            if (do_pre_decrypt_check(m, &state, real))
+            if (m->deferred_shutdown_signal.signal_received)
+            {
+                msg(D_MULTI_ERRORS,
+                    "MULTI: Connection attempt from %s ignored while server is "
+                    "shutting down", mroute_addr_print(&real, &gc));
+            }
+            else if (do_pre_decrypt_check(m, &state, real))
             {
                 /* This is an unknown session but with valid tls-auth/tls-crypt
                  * (or no auth at all).  If this is the initial packet of a
-- 
2.37.1 (Apple Git-137.1)


