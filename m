From: Arne Schwabe <arne@...1227...>
Date: Fri, 23 Oct 2020 14:02:58 +0200
Message-Id: <20201023120259.29783-6-arne@...1227...>
In-Reply-To: <20201023120259.29783-1-arne@...1227...>
References: <20201023113244.26295-1-arne@...1227...>
 <20201023120259.29783-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 7/8] Send AUTH_FAILED message to clients on
 renegotiation failures
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

This changes the exit in server mode on renegotiation to an exit that
also sends an AUTH_FAILED to the client. Any previously set failed auth
reason is passed to the client.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 958246c4..67615a6b 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -155,7 +155,14 @@ check_tls(struct context *c)
         }
         else if (tmp_status == TLSMP_KILL)
         {
-            register_signal(c, SIGTERM, "auth-control-exit");
+            if (c->options.mode == MODE_SERVER)
+            {
+                send_auth_failed(c, c->c2.tls_multi->client_reason);
+            }
+            else
+            {
+                register_signal(c, SIGTERM, "auth-control-exit");
+            }
         }
 
         interval_future_trigger(&c->c2.tmp_int, wakeup);
-- 
2.26.2


